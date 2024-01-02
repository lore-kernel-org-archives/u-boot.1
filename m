Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7559AC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 13:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32898756F;
	Tue,  2 Jan 2024 14:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xd0JTd8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 837D08756F; Tue,  2 Jan 2024 14:00:07 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CEFF8766D
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 14:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3368b9bbeb4so8781525f8f.2
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 05:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704200403; x=1704805203;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=v39Oep6tuYxqLcl4wCBuViME32p62Yq9DLFGvt8mmcs=;
 b=xd0JTd8+RgDUIKWysSMUPDzrEx9urVaG8erd7oCq3CfzjmzMyRuBVKsL0y3mwelWw7
 W/JBVEYoj8cvVxVuVLfPJ6uh1FDpirzTeNaOLvUEqSIpKdxSq7yZrNScH9nnxNbrwsHv
 nnop9wjQ23ErZtOFhxqdPISsz29Yja3mZdK6IVW/QfxNnYbmQPdAlh/qEa0i8pFuqDXS
 Y36MWQCkySR4J4+C3m85x4LwbzlMGNE2/53MOJIu5+rDBvufIpaQYYqOz5jPGBqPLflW
 f+RCje7TtAp1HrdSpEiEYS8uipCiiY8UkTtSC9EVgGhnSNFiALCPoiqW0OLPIFBNMm3R
 cxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704200403; x=1704805203;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v39Oep6tuYxqLcl4wCBuViME32p62Yq9DLFGvt8mmcs=;
 b=lBr0FENOw+quE9fB9nSJROE+BlFTnRZqvLRQGAGr3gfWt/4ms+ZEI6VK2A4UTTt5K5
 IavcDNOBS40qyZGhwBiNuNtOdNrC61OhXjiDfpwWhb0V9wUB1mTlu9EdHxoGAvygmZ+c
 0melMhHBJHfB3GerDVEXhXCZYQ0ef3byOThzl28IliCHm/9ffRtxQFDozKIzr3OHKV5X
 azO7gsAzgpMskfPN/cjROlSSMT1i3/hmDPV7nj4An0b5BDWeMgEnonE8ZDvBzHtmWxCG
 /6xRP7+1VgjTSXMRwwuw1/ddMLo/vmAOCU8Zo/T9ZTfD+x7c+gH2fwedvksk6gg/7IHr
 6+aA==
X-Gm-Message-State: AOJu0Yw7xETVYMD3/MwLXN9UnYXbKLJX2QqOgKAY9L88d++ZmTYZIexc
 JrLevAAi4fcEPzKyxSLxwVBa6U49Yqb3sA==
X-Google-Smtp-Source: AGHT+IGafYY0NvV1WqLCODdgz/MlFXTSuEwmf8WglKGY+4EF2TjsDrqjaTGVLXXfDsZ5qXzRcg6XJQ==
X-Received: by 2002:adf:f4c5:0:b0:336:6a75:b543 with SMTP id
 h5-20020adff4c5000000b003366a75b543mr5767095wrp.143.1704200403470; 
 Tue, 02 Jan 2024 05:00:03 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a5d488f000000b00336e43e8e57sm17080526wrq.58.2024.01.02.05.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 05:00:03 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, michal.simek@amd.com,
 marex@denx.de, michael@walle.cc, stcarlso@linux.microsoft.com,
 tobias@waldekranz.com, seanedmond@microsoft.com,
 abdellatif.elkhlifi@arm.com, neil.armstrong@linaro.org, n-jain1@ti.com,
 xypron.glpk@gmx.de, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, frieder.schrempf@kontron.de,
 sjg@chromium.org, hs@denx.de, sean.anderson@seco.com,
 dimorinny@google.com, patrick.delaunay@foss.st.com
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: Re: [PATCH v1 10/12] fastboot: check device type for SPI NAND too
In-Reply-To: <20231228153922.84323-11-avromanov@salutedevices.com>
References: <20231228153922.84323-1-avromanov@salutedevices.com>
 <20231228153922.84323-11-avromanov@salutedevices.com>
Date: Tue, 02 Jan 2024 14:00:02 +0100
Message-ID: <87wmsr51rh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Alexey,

Thank you for the patch.

On Thu, Dec 28, 2023 at 18:39, Alexey Romanov <avromanov@salutedevices.com> wrote:

> SPI NAND devices also supports 'fastboot erase / flash' commands.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/fastboot/fb_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
> index 6d3a900c77..39d888301f 100644
> --- a/drivers/fastboot/fb_nand.c
> +++ b/drivers/fastboot/fb_nand.c
> @@ -53,7 +53,7 @@ static int fb_nand_lookup(const char *partname,
>  		return ret;
>  	}
>  
> -	if (dev->id->type != MTD_DEV_TYPE_NAND) {
> +	if (dev->id->type != MTD_DEV_TYPE_NAND && dev->id->type != MTD_DEV_TYPE_SPINAND) {
>  		pr_err("partition '%s' is not stored on a NAND device",
>  		      partname);
>  		fastboot_fail("not a NAND device", response);
> -- 
> 2.30.1
