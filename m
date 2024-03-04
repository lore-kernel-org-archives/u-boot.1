Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DE9C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72A087F09;
	Mon,  4 Mar 2024 15:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ROioy1sm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2682487E4F; Mon,  4 Mar 2024 15:28:06 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A513987F09
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso6020472a12.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709562483; x=1710167283; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h+/M5Q6WMO8rjXBD4m/N+1fPfC0YV1vCSKVFW4E2DNU=;
 b=ROioy1smx0OTSwwWT4W6hhTHzfQgEg93iXbBFgSya79ooD5tbJRc2s56HKuz/HUiiP
 1LFOA6npovKr2YdmAXyIvs62zKogbdcspRNkLscrLvhnNklcvlQirqUAw8luy6GFZ2Wz
 Qm5EHII1jzVRUYgLThaFVIfM7kTIyCNO80zgICeQaHfoGK3HkVw3EdEG8lHsF73flJiD
 wOx4Y3D2ifD0mMuOh8MT7gUhtL27TT9rSro+ptt+UDIz1K/edL658x18wbYl5mSNpFUL
 ijJVkxbhxpFqh0lCwkBuXFKt3hjGk/bEqK3cN3gZpZwB2e/EjTtzK8tWPEHzn4ZwHNxr
 lkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709562483; x=1710167283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+/M5Q6WMO8rjXBD4m/N+1fPfC0YV1vCSKVFW4E2DNU=;
 b=oTJJE7pFB7ccYQxJ7Kk4vPOTs1mFwoTWOqyXThE8AuVPHRTiFHol8pShbQ4e7KHCg2
 PUQG35ZZMZyvB+HjyfHfjFjuVHvg1NBmC6uA0PC2tztukeq1ZGPWOPdXd0QIzEWO+ZjB
 JiQ8uvtzkNUaXFmg6veGSygknZxIl4Cs1PtmypPAQff/XSBnCrOY/p+IMEGAHmAx5aP7
 GGdtTN7kzMULEyiva9vdzeCI1rD6A9vDOeIhNceiJ6RFQqcPonQUYmR2hX2DA+tzsOLC
 3FbsizMtkO1eE1a0/X1bgKgqpwwOqaBYvksc1odyuGlQauHfJmt3b+rYGMLMPE9KZXeH
 WyvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTYZmsAi9EZNyFa4otuCC1vLsGOqFkY9Gh8VrBmpG6lSDyoB1Oj8dQAdhaqY6G8SxKiprea9AacxbN2N9FSl84baG4Bg==
X-Gm-Message-State: AOJu0YxRcwrtmOnX7ZKsANaIrQ0peq4BAveeH4mWTRW1siA9m1+imP2J
 H+eASTOM6HBgBMHXeweFGaEc4tYjb9Q7S8lEAxMnvaxa9SCpI8ll2NU3GT2pdSI=
X-Google-Smtp-Source: AGHT+IEM8V77tKo4vx6Q0Bli0V2kcAKwdKepF4dyxn7WdZTa/RHXAGKJpHZ//NffbprkTiKiHT5rQw==
X-Received: by 2002:aa7:c98d:0:b0:567:56a4:3940 with SMTP id
 c13-20020aa7c98d000000b0056756a43940mr1504291edt.19.1709562483070; 
 Mon, 04 Mar 2024 06:28:03 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 dy25-20020a05640231f900b005655dd9492dsm4701196edb.53.2024.03.04.06.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 06:28:02 -0800 (PST)
Date: Mon, 4 Mar 2024 17:27:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Bin Meng <bmeng@tinylab.org>, Linus Walleij <linus.walleij@linaro.org>,
 Fabio Estevam <festevam@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v2 2/2] arm64: Enable CONFIG_64BIT for static analysis
Message-ID: <f25d9a4c-9986-4b51-8731-75091c1b876e@moroto.mountain>
References: <6a7328b8-eb22-4ad6-a1d6-eaecd2f8a067@moroto.mountain>
 <6907b26a-9eb2-4ffd-8337-50ee96155c05@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6907b26a-9eb2-4ffd-8337-50ee96155c05@canonical.com>
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

On Mon, Mar 04, 2024 at 02:44:12PM +0100, Heinrich Schuchardt wrote:
> On 04.03.24 08:04, Dan Carpenter wrote:
> > In the Makefile there is a line that says this:
> > 
> >      # the checker needs the correct machine size
> >      CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)
> > 
> > Set CONFIG_64BIT for ARM64 so that we pass -m64 to the static checkers
> > instead of -m32.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: split the patch into two patches
> > 
> >   arch/arm/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index fde85dc0d537..76d6a8cc6886 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -6,6 +6,7 @@ config SYS_ARCH
> >   config ARM64
> >   	bool
> > +	select 64BIT
> 
> How about other 64bit architectures (sandbox64, x86_64)?
> 

You're right.  That was laziness on my part.  Plus, I didn't know about
sandbox64.  But I think once we fix the two you mentioned then
everything will be updated.

$ grep -l 64 arch/*/Kconfig
arch/arm/Kconfig
arch/mips/Kconfig
arch/riscv/Kconfig
arch/sandbox/Kconfig
arch/x86/Kconfig

I'll send those patches tomorrow.

regards,
dan carpenter
