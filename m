Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA49CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D07849B4;
	Mon,  1 Jun 2026 14:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z6cb8vl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A266E846D3; Mon,  1 Jun 2026 10:41:24 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C908466E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso4157415e9.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780303280; x=1780908080; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/7R948491BoiRkagPBFNbPSvdOPZgSVkIutldWMlY/0=;
 b=Z6cb8vl2FMMmRCuCSVtZPmexOhUWsF2Zvurf5CqQ1zmAdWQmf24D9QtxxYXITG0d2U
 mPRfbEjZapaP7kMC7Z/sIMumWnDY0MG9lYCd35gfC9CPqq91YhgZGWhlKy/iq+KNmnc4
 F38UiYN4OBRFRetdLW1OXclZttnfklED3S0lCvbqz39AVhk4MvoUDnrXdm7JZalMajBb
 OMJP2z6A0dObN7Eg+jnPSR18DnDdMkB8nYNqMNUvgcmF3462oaXEpuGn/mX0SaK2qVll
 3f49fW/VfBZzBlfdNkTlI9U5BudwSis+owLJ7bDyADAnD+Z8nGGvIMKwinnBN3Ag0OBz
 bgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780303280; x=1780908080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7R948491BoiRkagPBFNbPSvdOPZgSVkIutldWMlY/0=;
 b=KKaY3yjOCDjCL70iRTpWW25jJcqDPJUcHthf8OE3g8SOlT3AQlbzfaaQu2d/pw8NiT
 etxClDdv+0aeGynwq3WIikwNqxBYxikUdWTRa74+2oWIywh/2nuyb9alfm6A8jOa9nHH
 G7vYrxCkIFnyFektDC8Lo1z+5lWHau+jT7fwKlR5kHVSlKyUbt1Yma+7lMWtvzYa8qs2
 JNqjlUOfw3Arnz1rs23t6otELBKXcewFRQVKoTV4fh+dypczPL+V3jfL199WxTrRyMIz
 WZ+aDhG9QrNpdYBOIqVH85A3hRZsJktfzhlrYQvUGrXnsdxuJWjakIQYefMNu7NB91ef
 pclg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yKmnWB22H3zNvkh2G7MB2OH8U3hCVBXZ8kWyNN+yfwyPAg9biGNqJ4Ju1FnqJSVVPayKXc2c=@lists.denx.de
X-Gm-Message-State: AOJu0YzqgoWS8LhOXiCxxuAUtNSgioZJHc0JmXCzo28FE+BCkvOTvWPa
 XrMSFxbbfoUYonjMTR+vC3i4iymTdsrZvc9FqLYmG8h3NGoQK+X0BH410B1/67pjKVQ=
X-Gm-Gg: Acq92OFhEZoDMxhfAqdDL98Mya4BwAy/l/XyUhDc1Q63errHWobuTbI1PeDVumQlR2a
 Q+WE1ueBCQi9Psze9WAtfB/rx77RGVPrERdPsRa6APaq3PziSwyJc3rNFcn/KoCh7grM5AW8GXX
 l3p4pKzPUDWF1nXfD9KoU3GY0sJQ7uQ6LdsPya6mHJAnk6JqIv5mQYFEcXJwiBctIFMqqaKMdWr
 ubu7P03yihVZev8UZOdewMd52+oUer/DZASdBvq0OrCoi7CVUQb7FfDPedp05BVJkfZBXMtyMdq
 sZlNqZz87eGUKzqJ2dgqjfhnllXvURHs9exn1p04Zo1ZFrcjhGxH7LRc7dUF/pe1L+f34v8jvgi
 nk8ELKbtc5I3UyWP4je0idalFzd45f8h6hKNOBV3QezY7ykJeVoxP8uvsooLlOgAMJ2uuB6etFo
 iRxyT4Gak94zIYxP3xAE421yHPMe6owz/zd9KPJmo=
X-Received: by 2002:a05:600c:8a0d:20b0:48a:906b:14ca with SMTP id
 5b1f17b1804b1-490a293dcaamr129096495e9.20.1780303279813; 
 Mon, 01 Jun 2026 01:41:19 -0700 (PDT)
Received: from linaro.org ([92.206.123.66]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490aeab0955sm5479625e9.4.2026.06.01.01.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 01:41:19 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:41:13 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: me@samcday.com
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>
Subject: Re: [PATCH RESEND 15/16] serial: msm: wait for TX empty before reinit
Message-ID: <ah1FqUGQYaS15Cad@linaro.org>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
 <20260601-qcom-armv7-v1-15-05a08d87e476@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-qcom-armv7-v1-15-05a08d87e476@samcday.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

On Mon, Jun 01, 2026 at 06:12:56PM +1000, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> At least on UARTDM 1.3, I was noticing the early UART debug banner
> getting corrupted. It turns out this is because U-Boot was
> re-initializing the UARTDM block and writing to it before it had
> finished shifting out the FIFO from the previous bootloader. Waiting for
> TX_EMPTY in the status register consistently fixes the issue.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  drivers/serial/serial_msm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index 10948e2aede..db085d68a0d 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -351,6 +351,8 @@ static inline void _debug_uart_init(void)
>  	 *   - HMIBSC: GCC_BLSP1_UART1_APPS_CLK
>  	 */
>  	//apq8016_clk_init_uart(0x1800000, <uart_clk_id>);
> +	while (!(readl(init_serial_data.base + UARTDM_SR) & UARTDM_SR_TX_EMPTY))
> +		;

I think you need to add some timeout here. There is some funky SoC where
the UART is left in some half-disabled state and this bit will never
become unset. Maybe it was MSM8909, I don't remember exactly. I have
similar code in TF-A and there I had to add the timeout to prevent the
device from getting completely stuck during boot sometimes because of
this loop:

https://github.com/ARM-software/arm-trusted-firmware/blob/da738d5eae93af342fdc4995dd3c05acb4c9d757/plat/qti/bear/msm8916/aarch32/uartdm_console.S#L68-L81

Thanks,
Stephan
