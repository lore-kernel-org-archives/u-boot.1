Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6053EE57F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 444EF88D51;
	Thu, 12 Sep 2024 02:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ct+DJZrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0908888D43; Thu, 12 Sep 2024 02:58:56 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F9888D4F
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7191df6b5f5so279139b3a.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102732; x=1726707532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b5RRpb14NaaOhRl0Y0oo/B1lS2Kp1QF/hMCNtNoVwT0=;
 b=Ct+DJZrIVY82aO8bIdpzuYZigfeq42ZQ+xtJqIv+POCURVM+CC20aKi6R4VLMfhfaP
 FNzSInFIitI8uVHXOVCGgvX26flsgE0GcxAYt0Y1GThIwnqvrcBGepPG/lO9i6E9gv8k
 B/cU2Og+1Wl+JM3tQqJh0SVG49GhxHd3iF1Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102732; x=1726707532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b5RRpb14NaaOhRl0Y0oo/B1lS2Kp1QF/hMCNtNoVwT0=;
 b=ode+5aSvCvUTOVBxDkC//Pk9s1h0WpX0O+1m7vhtUqD6sVqft9cJq4VKMLhQvqrkzB
 uSKGKGORpU3MMatD1N6T/5aFv+FN0A7zgt8ztOtER1EQLHmkFTTBaXhdyc6vmIcC2bTo
 BzYvUCEKHfQDlsVAUWjlRj96NPzrCF1LDIUdbT+nIFRNVcFBpkMd/NrO+jH/myy8AOKr
 XgW/GXRn7XAfI+mGeguJh/B8Bx6YQayjIyi5K32iaJrQZ6xGooUu6vvcdbNJKZPtOqs3
 hCpMGZk+F815MVwDxH1z4Cvnf4L7w75GpL/BWCa8z0g8FiVycreOhc/L+8sOuzuyeOQD
 nrnw==
X-Gm-Message-State: AOJu0Yx1BAe3fY2Axt/2j0HE0xB7Fq16mOfMNgCtKtE5SugmB2e3r75c
 wx4EBjiKQNglIi+J64fmiVaigRwaxsJAKnnRG1dYRimws3W+cw2u+vlA7SnSpmn84P7ERIElGhC
 tM+16DqzQJWEpAwYOGVWdgGoI45drbSkWs6Wv
X-Google-Smtp-Source: AGHT+IGZ7/q6/Ds30qVXe0qyl7kC7TvmaLdAFHVwn/s2xv37W4aeIVCfV8CIeCXh0c9YAi1p/ZZcxQUS6leXylwxjbs=
X-Received: by 2002:a05:6a20:b40a:b0:1cf:3838:1ec5 with SMTP id
 adf61e73a8af0-1cf75c7ea5cmr1303830637.5.1726102732019; Wed, 11 Sep 2024
 17:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-24-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-24-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:28 -0600
Message-ID: <CAFLszTiCrUZGOgoZ29Yc0=GB2asZ0zyQwopQ=-D5L5pANs0ENQ@mail.gmail.com>
Subject: Re: [PATCH v3 23/30] arm: mach-bcm283x: Map the ARM local MMIO as well
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 11 Sept 2024 at 00:30, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Cover the "ARM local MMIO" range as well in the default MMU mapping in
> order to allow future code to access the GIC-400 without crashing. For
> now the GIC is not touched in u-boot, thus this change is a noop.

U-Boot

>
> See [1](BCM2711 ARM Peripherals) for reference.
>
> TEST: Enabled CONFIG_GICV2 and accessed the GIC in C code without crash.
>
> 1: https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
>  arch/arm/mach-bcm283x/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

(with above fixed)


>
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 1b459707bc..7a1de22e0a 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -50,7 +50,7 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
>         }, {
>                 .virt = 0xfc000000UL,
>                 .phys = 0xfc000000UL,
> -               .size = 0x03800000UL,
> +               .size = 0x04000000UL,
>                 .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> --
> 2.46.0
>
