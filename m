Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1B9E77188
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 13:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDBD280352;
	Sat, 28 Dec 2024 14:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1F380362; Sat, 28 Dec 2024 14:46:27 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11CEA80107
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 14:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1tRX90-0004d0-75; Sat, 28 Dec 2024 14:46:18 +0100
Message-ID: <0c9b672a-df0f-4341-a11d-ad3ea6eedad7@pengutronix.de>
Date: Sat, 28 Dec 2024 14:46:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] usb: dwc3: invalidate dcache on buffer used in
 interrupt handling
To: Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
 <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-3-5f3498d8035b@linaro.org>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-3-5f3498d8035b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 11.10.24 16:38, Neil Armstrong wrote:
> On Qualcomm systems, the setup buffer and even buffers are in
> a bad state at interrupt handling, so invalidate the dcache lines
> for the setup_buf and event buffer to make sure we read correct
> data written by the hardware.
> 
> This fixes the following error:
> dwc3-generic-peripheral usb@a600000: UNKNOWN IRQ type -1
> dwc3-generic-peripheral usb@a600000: UNKNOWN IRQ type 4673109
> 
> and invalid situation in dwc3_gadget_giveback() because setup_buf content
> is read at 0s and leads to fatal crash fixed by [1].
> 
> [1] https://lore.kernel.org/all/20240528-topic-sm8x50-dwc3-gadget-crash-fix-v1-1-58434ab4b3d3@linaro.org/
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/usb/dwc3/ep0.c    | 2 ++
>  drivers/usb/dwc3/gadget.c | 2 ++
>  drivers/usb/dwc3/io.h     | 8 ++++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 8ba5fcd5312..531f0b522af 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -742,6 +742,8 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
>  	if (!dwc->gadget_driver)
>  		goto out;
>  
> +	dwc3_invalidate_cache((uintptr_t)ctrl, sizeof(*ctrl));

I believe this to be incorrect. ctrl here is dwc->ctrl_req, which AFAICS
is allocated in dwc3_gadget_init() using dma_alloc_coherent.

Doing cache maintenance on DMA-coherent memory doesn't make sense.
If this makes things better for you, it's probable that something else
is broken.

Additionally, this will break platforms that have DMA-coherent DWC3
and allocate normal memory instead of uncached memory. I am not sure
if there are such U-Boot platforms yet, as searching for dma-coherent DT
property yields no relevant results, but e.g. LS1046A in barebox would've
been broken by such a change.

Cheers,
Ahmad

> +
>  	len = le16_to_cpu(ctrl->wLength);
>  	if (!len) {
>  		dwc->three_stage_setup = false;
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 19c3a5f5e58..e5a383407a2 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2534,6 +2534,8 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3 *dwc, u32 buf)
>  	while (left > 0) {
>  		union dwc3_event event;
>  
> +		dwc3_invalidate_cache((uintptr_t)evt->buf, evt->length);
> +
>  		event.raw = *(u32 *) (evt->buf + evt->lpos);
>  
>  		dwc3_process_event_entry(dwc, &event);
> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
> index 0ede323671b..c1ab0288142 100644
> --- a/drivers/usb/dwc3/io.h
> +++ b/drivers/usb/dwc3/io.h
> @@ -55,4 +55,12 @@ static inline void dwc3_flush_cache(uintptr_t addr, int length)
>  
>  	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
>  }
> +
> +static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
> +{
> +	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
> +	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
> +
> +	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
> +}
>  #endif /* __DRIVERS_USB_DWC3_IO_H */
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
