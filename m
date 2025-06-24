Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC37C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A4AF82C84;
	Tue, 24 Jun 2025 10:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750753346;
	bh=mJRw/+/tHDhUZ3wtH2o4wIyYHj0/lsuJUV5ikgVdVS4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XYzaAZd/xpJtoRUm3uybw988X+rkkOXBefEs0HRT+OJuG4uerSWRmHspHqT5LRdZh
	 XNSfgBg+JUXI9z0r4mBqolxTcIyV7azRu5CdetaEQuwTxbnzkqTRdzlI7YpraubJOk
	 XmDIH4zwKQIDVduDzRpx8wSnxPm0QRfoFPBM0TXPSxXqlpW0cWsenPAUbMI6cWk4Xi
	 NUq+NUoBDvmbibkWKOvVtAShhIf7bmXpxDHpMKzBR0CtoxDIjuPxJ/1WbPtEBT+CPp
	 VrcQAl7/R7P928CJisX2yMyDKrg2/3R7wM7cnwNs5HSOdpAxibrhCY85HTvHrW5OF2
	 kOVJWg3ncPP9w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83CC782D17; Tue, 24 Jun 2025 10:22:25 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A70B82C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4bRHxS5Cphz9tdg;
 Tue, 24 Jun 2025 10:22:20 +0200 (CEST)
Message-ID: <822ba813-2a9e-4a40-821d-ed72c10a78b2@denx.de>
Date: Tue, 24 Jun 2025 10:22:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] watchdog: qcom: Add max timeout check to prevent
 overflow
To: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, hello@paulsajna.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250624061907.3893511-1-gopinath.sekar@oss.qualcomm.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250624061907.3893511-1-gopinath.sekar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4bRHxS5Cphz9tdg
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



On 24.06.25 08:19, Gopinath Sekar wrote:
> Added a check to ensure the requested timeout does not exceed the
> hardware's maximum supported value. This prevents register overflow
> and ensures watchdog reliability.
> 
> So, added a check in qcom_wdt_start() to ensure the requested timeout
> does not exceed the hardware-supported maximum value.
> 
> The timeout is first converted to watchdog ticks and then compared
> against QCOM_WDT_MAX_TIMEOUT. This helps prevent misconfiguration
> and potential watchdog misbehavior due to overflow.
> 
> QCOM_WDT_MAX_TIMEOUT is set to 0xFFFFF, as Qualcomm SoCs typically
> use 20 bits to store bark/bite timeout values.
> 
> This work builds upon the previous submission:
> https://lore.kernel.org/u-boot/20250527124926.128413-1-balaji.selvanathan@oss.qualcomm.com/
> 
> Signed-off-by: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
> ---
>   drivers/watchdog/qcom-wdt.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index adbb5aacdc3..eeeea4c24b7 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -17,6 +17,9 @@
>   
>   #include <asm/io.h>
>   
> +/* Maximum allowed timeout value in Qcom SoCs*/
> +#define QCOM_WDT_MAX_TIMEOUT	0xfffff
> +
>   enum wdt_reg {
>   	WDT_RST,
>   	WDT_EN,
> @@ -55,8 +58,20 @@ static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
>   int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   {
>   	struct qcom_wdt *wdt = dev_get_priv(dev);
> -	ulong bark_timeout_s = ((timeout_ms - 1)  * wdt->clk_rate) / 1000;
> -	ulong bite_timeout_s = (timeout_ms * wdt->clk_rate) / 1000;
> +	u64 tmp_timeout;
> +	u32 bark_timeout_s, bite_timeout_s;
> +
> +	/* Compute timeout in watchdog ticks */
> +	tmp_timeout = (timeout_ms * (u64)wdt->clk_rate) / 1000;
> +	if (tmp_timeout > QCOM_WDT_MAX_TIMEOUT) {
> +		dev_err(dev, "Requested timeout (%llu ms) exceeds maximum allowed value (%llu ms).\n",
> +			timeout_ms, ((u64)QCOM_WDT_MAX_TIMEOUT * 1000) / wdt->clk_rate);
> +		return -EINVAL;

Not sure, but wouldn't it be better to use this max timeout value in
this case instead of returning with error? Best with a changed dev_err
or dev_warn explaining this changed behavior.

Thanks,
Stefan

