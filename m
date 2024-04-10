Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3C0CD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 09:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2357187F52;
	Wed, 10 Apr 2024 11:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oqzFvbK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD8D88089; Wed, 10 Apr 2024 11:30:19 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62E5087666
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 11:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-516cdb21b34so8407097e87.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712741416; x=1713346216; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VC25ZZW8rYQQhA6Ae0l1Os16CxB3LHyjpIJv/GZwh08=;
 b=oqzFvbK4fJktF+cLiyOF3Ntv0qhkzf2RIzMHfR2WmPtMD5yYbFxE7GW0tHz2z1QrXC
 KwpKvQ3Wwo7uaGewHUF3OVYI3nwBnnJgng3/GVWWFxrKHRzpLPRxWG+LPEfUuv7Hc8zX
 1dpUMSB2yr59Ar0yVVC+6igCz758KomOKgBnVy5Apo1gpWFpb8DGsdosQCoVM2KX7PbG
 CeKbGdose+H2SodvPoRSat58jBIk/bg4BNMmG3wu3LZyUGoI6hUge5WV1YFrEefNtRco
 eChYKDhWBkYtvjeaLRA0eos9q4y8fN2sot+LKtpGXX/y8F6Wk2IYanrUrfxAfLAWoMrK
 Ilig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712741416; x=1713346216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VC25ZZW8rYQQhA6Ae0l1Os16CxB3LHyjpIJv/GZwh08=;
 b=N7vo/nj0/bWsEkIud9CqN7SMO9d3EOxEbbY6wVcwIbR7GaqdzIwn8AUZiQ3uKRvc9Z
 jhBs/ZOWJCF+T9RDUgNPZzcCXwmR4RTZeonIB54KOwbJ67K0mEiYrMverRAwqkL0brEA
 YiaGPhtqB5dPE1bKiwzQey2CQOybeBq5jR+DwNQ5DZrWYvvzi3sI+ufUE+0ZGcdJbVzr
 P8/EjrJuqGH86NPIoC4C+rAJJ2JM1pewayI3pUulnuzoiJv8EL2+WHVA3tILtnKUK4z5
 YPDPDO5q7wPlT/LdRsr4ujbz50KDncKBa0cUN4FmIHsLBelnGt3Gt9ELD+6zuOOWbA2B
 iEtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0gnLRtkAecUIbHcohzXlA106DViwX1WXLj+IPywaDSlZ3l2IMHk8QOsJKLY3fOERPiIzWtpFZyj30tGXDt4FIFJx0JA==
X-Gm-Message-State: AOJu0Yz5vYG/tCH5+vfSfTxEpq/yuCgQOy05ieuNQHyye7jHfdSUM358
 7dqo2ktWbrrZC7UM+D86kNRHrx0B9RWWoFT/R6wklesmgz3/1IJd4J0zc5Luf589/mFUkJMRXLZ
 mlMVHFAHxmsJNgViAPpMq5O86wVQcFbnFCRQg8Q==
X-Google-Smtp-Source: AGHT+IH3a52IGQ6t3sH4SCaIIblR4t6M5X/K9Fczpef4FFps4CwsSHYlAgJeG3MOkTJ9oobVcBSlxZXqBSRox60nmXo=
X-Received: by 2002:ac2:5a0b:0:b0:516:ce9e:73ce with SMTP id
 q11-20020ac25a0b000000b00516ce9e73cemr1205609lfn.21.1712741415614; Wed, 10
 Apr 2024 02:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-2-j-humphreys@ti.com>
 <cac63a03-b019-4aed-83de-db2effa1a2f1@gmx.de>
 <86zfu2z1p4.fsf@udb0321960.dhcp.ti.com>
 <a2fb8782-66d5-44ad-8238-d565e0934de9@gmx.de>
In-Reply-To: <a2fb8782-66d5-44ad-8238-d565e0934de9@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 10 Apr 2024 11:29:39 +0200
Message-ID: <CAC_iWjLEzeXmhc=EiGT3++1a5W5JRrZHivgSN=JMN+mQtpTZeQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] board: Define GUIDs for firmware images
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jon Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Judith Mendez <jm@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
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

Hi both

On Wed, 10 Apr 2024 at 10:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 09.04.24 23:05, Jon Humphreys wrote:
> > Heinrich Schuchardt <xypron.glpk@gmx.de> writes:
> >
> >> On 4/9/24 00:31, Jonathan Humphreys wrote:
> >>> Define GUIDs for the different firmware images (tiboot3.bin, tispl.bin,
> >>> u-boot.img, sysfw). >
> >>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >>> ---
> >>>    include/configs/ti_armv7_common.h | 17 +++++++++++++++++
> >>>    1 file changed, 17 insertions(+)
> >>>
> >>> diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_armv7_common.h
> >>> index 3def7b1027e..4ce14a9b84c 100644
> >>> --- a/include/configs/ti_armv7_common.h
> >>> +++ b/include/configs/ti_armv7_common.h
> >>> @@ -16,6 +16,23 @@
> >>>    #ifndef __CONFIG_TI_ARMV7_COMMON_H__
> >>>    #define __CONFIG_TI_ARMV7_COMMON_H__
> >>>
> >>> +/* GUIDs for capsule updatable firmware images */
> >>
> >> Please, provide code comments for the GUIDs, e.g.
> >>
> >> /**
> >>    * define K3_TIBOOT3_IMAGE_GUID - firmware GUID for K3 tiboot3.bin
> >>    *
> >>    * This GUID is used in capsules updates to identify the tiboot3.bin
> >>    * binary.
> >>    */

I'd go one step further tbh.  Those GUIDs can be used by OEMs/ODMs
producing capsules for their future products.
Currently, we don't have a documented way to allow users to redefine
this (but Linaro is working on it).  If both TI and an OEM use the
same GUID and try to upload the firmware to LVFS, we will have a GUID
clash.
I think we should have that on the comment as well, until we can
properly sort it out

Thanks
/Ilias
> >>
> >> Cf.
> >> https://docs.kernel.org/doc-guide/kernel-doc.html#object-like-macro-documentation
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >
> > Heinrich, thanks for reviewing!
> >
> > I modelled the GUID macros after how other boards and even core code
> > defined there's.  (eg, include/configs/kontron-sl-mx8mm.h or
> > include/efi_api.h).
> >
> > However, if this is the new direction, I will format as you suggest.
> > Please confirm.
>
> Hello Jon,
>
> Without properly documenting macros we make the live of developers more
> difficult. Yes, we still have a lot of missing code documentation. But
> we should not follow poor example.
>
> Best regards
>
> Heinrich
>
> >
> > thanks
> > Jon
> >
> >>> +#define K3_TIBOOT3_IMAGE_GUID \
> >>> +   EFI_GUID(0xe672b518, 0x7cd7, 0x4014, 0xbd, 0x8d, \
> >>> +            0x40, 0x72, 0x4d, 0x0a, 0xd4, 0xdc)
> >>> +
> >>> +#define K3_SPL_IMAGE_GUID \
> >>> +   EFI_GUID(0x86f710ad, 0x10cf, 0x46ea, 0xac, 0x67, \
> >>> +            0x85, 0x6a, 0xe0, 0x6e, 0xfa, 0xd2)
> >>> +
> >>> +#define K3_UBOOT_IMAGE_GUID \
> >>> +   EFI_GUID(0x81b58fb0, 0x3b00, 0x4add, 0xa2, 0x0a, \
> >>> +            0xc1, 0x85, 0xbb, 0xac, 0xa1, 0xed)
> >>> +
> >>> +#define K3_SYSFW_IMAGE_GUID \
> >>> +   EFI_GUID(0x6fd10680, 0x361b, 0x431f, 0x80, 0xaa, \
> >>> +            0x89, 0x94, 0x55, 0x81, 0x9e, 0x11)
> >>> +
> >>>    /*
> >>>     * We setup defaults based on constraints from the Linux kernel, which should
> >>>     * also be safe elsewhere.  We have the default load at 32MB into DDR (for
>
