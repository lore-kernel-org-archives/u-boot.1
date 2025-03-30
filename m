Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA07C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 11:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55AC08144A;
	Sun, 30 Mar 2025 13:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cNEERIhw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176CD819D2; Sun, 30 Mar 2025 13:57:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8170880FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 13:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743335848;
 bh=ok1vS/zi+pharDRYZ/oWXwmT3wMUhW1kNiM7aFjpeSQ=;
 b=cNEERIhw44tShVzUwCOVLS/KwKoDHpU3jktGtcPkHW4CrORyQlZ+oLJDKYEz1GW1ygI3Ghe/N
 CrK3Am1zBPgVUG6F1/drwQzRSaK4R2GrddW97iBNWRW4zWGiNKnY106RXczfNKFruexXhRrVcYF
 EZ+7BTqQzsF3fapgMSsLUAalH1x6m8Y+EMwHLNzJa4Tv7qNnHtGqJMNDPsv/jUhV00WD2Sk/nWG
 GGpQMkKrrX50U3CnH0iT8dmbiMeUdXJ83YdbGyZMJE/QWnKlTAWYLoZBA1MjVLbn888i4PtNzeI
 upfNjblRR5NNrP9u0SxRoEsnENLNC7NWIpBOW9my8r0A==
X-Forward-Email-ID: 67e9319e0286204565e94f68
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6f01aadb-9188-48e5-b4d6-2e3e2f69a04e@kwiboo.se>
Date: Sun, 30 Mar 2025 13:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] video: rockchip: rk3328: filter unsupported modes
To: Vasily Khoruzhick <anarsoul@gmail.com>
References: <20250323225134.2369473-1-anarsoul@gmail.com>
 <20250323225134.2369473-2-anarsoul@gmail.com>
Content-Language: en-US
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Jagan Teki <jagan@edgeble.ai>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250323225134.2369473-2-anarsoul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Vasily,

On 2025-03-23 23:50, Vasily Khoruzhick wrote:
> While RK3328 is capable of 4K resolutions, dw-hdmi driver in u-boot
> seems to have some issue with 4K. 1440p or lower works fine.
> 
> Limit max resolutions to 2560x1440x60Hz, by filtering the modes with
> pixel clock > 297MHz
> 
> Fixes: f3ea872970d603 ("video: rockchip: Add rk3328 hdmi support")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> v2: add a comment that max pixel clock limit is a workaround
> 
> drivers/video/rockchip/rk3328_hdmi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/video/rockchip/rk3328_hdmi.c b/drivers/video/rockchip/rk3328_hdmi.c
> index 763669c09be..ff351aaac7c 100644
> --- a/drivers/video/rockchip/rk3328_hdmi.c
> +++ b/drivers/video/rockchip/rk3328_hdmi.c
> @@ -105,9 +105,20 @@ static int rk3328_hdmi_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> +static bool rk3328_hdmi_mode_valid(struct udevice *dev,
> +				   const struct display_timing *timing)
> +{
> +	/* Limit pixel clock to 297MHz. While RK3328 support higher rates and it
> +	 * works in Linux, it doesn't seem to work in u-boot. That limits max
> +	 * resolution to 1440p
> +	 */
> +	return timing->pixelclock.typ <= 297000000;

I think it make more sense to limit to the HDMI 1.4 max 340 MHz instead
of arbitrary 297 MHz. Anything above 340 MHz will require scrambling etc
and will not work in U-Boot unless at least dw-hdmi driver is updated.

Regards,
Jonas

> +}
> +
>  static const struct dm_display_ops rk3328_hdmi_ops = {
>  	.read_edid = rk_hdmi_read_edid,
>  	.enable = rk3328_hdmi_enable,
> +	.mode_valid = rk3328_hdmi_mode_valid,
>  };
>  
>  static const struct udevice_id rk3328_hdmi_ids[] = {

