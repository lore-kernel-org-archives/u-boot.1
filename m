Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE81FA1FD4
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 16:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6294184262;
	Wed, 22 Apr 2026 18:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ni0XKpyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8878426E; Wed, 22 Apr 2026 18:28:25 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA41D8412A
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 18:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g14Qr5bD7z9tnC;
 Wed, 22 Apr 2026 18:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776875300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bXajOOCyJnPhxoTzW6bJJUp2G6gp6jkaPRWGMaUY6E=;
 b=ni0XKpyxbGDL18MPVfAm09oavuc07+HRtX+EdSRGdoOR12+DuciiFUB2peCurGJEVCyCR7
 VGkL9EnJBe6zBv0ZYReR9C8ZhKqHVGjBcUfdbdlYUl6x7FPDKgEUOzgr1YzBBIC68E6qUR
 ZdbHQKbpJfzgMLJPCWsnt8Vk1i57lZe22WPIgnMhntXPX/VDBTQvhlRCCTGL6BKPLbKRW/
 +F5gqPyfj79FrRr/T8puWwGM55llibvrAfJz1M6yFM27qmRa/QqL3wFgjhnWGWftYSCzOe
 7xuDR7YV6+1rA8kpsihSijX74+uSuceajK4gBBr5ZVrFVnAU/0W1t+8ijZx/Ag==
Message-ID: <66b59836-8989-45e7-b690-520b2b57cfdb@mailbox.org>
Date: Wed, 22 Apr 2026 13:28:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: dwc2_udc_otg_phy: fix compilation on non-Exynos
 patforms
To: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <ab44395a-dc24-4141-8211-16a16281d349@cherry.de>
 <20260422083430.20345-1-m95d+git@psihoexpert.ro>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260422083430.20345-1-m95d+git@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 790eb77c060c86961e1
X-MBO-RS-META: rgsrorgp9zkpcicomgob7buwfrjjajbo
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

On 4/22/26 10:32 AM, Marius Dinu wrote:
> s5p_cpu_id used in drivers/usb/gadget/dwc2_udc_otg_phy.c is undefined on
> platforms other than Exynos.
> 
> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   drivers/usb/gadget/dwc2_udc_otg_phy.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/dwc2_udc_otg_phy.c b/drivers/usb/gadget/dwc2_udc_otg_phy.c
> index e0ac5d142b0..c56ff1125bd 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg_phy.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg_phy.c
> @@ -56,10 +56,12 @@ void otg_phy_init(struct dwc2_udc *dev)
>   	else /* C110 GONI */
>   		clrbits_le32(&phy->phypwr, OTG_DISABLE_0 | ANALOG_PWRDOWN | FORCE_SUSPEND_0);

This ^ C210 Universal and C110 Goni stuff is also Exynos specific. Do we 
need some SoC-specific dwc2_udc_otg_phy_exynos.c file which would 
contain that SoC specific code ?

> +#if defined(CONFIG_ARCH_EXYNOS) || defined(CONFIG_ARCH_S5PC1XX)
>   	if (s5p_cpu_id == 0x4412)
>   		clrsetbits_le32(&phy->phyclk, EXYNOS4X12_ID_PULLUP0 | EXYNOS4X12_COMMON_ON_N0,
>   				EXYNOS4X12_CLK_SEL_24MHZ); /* PLL 24Mhz */
>   	else
> +#endif
>   		clrsetbits_le32(&phy->phyclk, ID_PULLUP0 | COMMON_ON_N0,
>   				CLK_SEL_24MHZ); /* PLL 24Mhz */
[...]
