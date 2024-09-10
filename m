Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C669FEDE9BF
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 20:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB29890D6;
	Tue, 10 Sep 2024 22:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UH0XaDN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B1B890D5; Tue, 10 Sep 2024 19:22:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89E8890B9
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 19:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725988969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3vjwCmPpTkBKGqOEkdExm0tsKjHnk98SQK6nD9tYe0s=;
 b=UH0XaDN4EXYt8MrZxKmnU+wqwscaZAqs3p/8wAN/UDEIFOqHWouaDvW8pzCAjbOIgs2v96
 2pwIlxYTMEBv38kzx5Vn4e2ASvjsmaJM8WqaZZ2OF58YZqpfhWZ4X5xSdUQOV+EjQym3vl
 3i9P2VTkwXuV0laD+x3hdfrgWhrPt2k=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-Bzm9_2VxMrKIJUbemxiLqw-1; Tue, 10 Sep 2024 13:22:48 -0400
X-MC-Unique: Bzm9_2VxMrKIJUbemxiLqw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-69a0536b23aso171713667b3.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988967; x=1726593767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vjwCmPpTkBKGqOEkdExm0tsKjHnk98SQK6nD9tYe0s=;
 b=iyzMCWt6lcW4f+/IkJhO30x378eR7z6EXjM8S2O/kku7HIeaoAnAS0zQKEMzAQESuI
 uCDVdLb4QLacj83Bkl+cgTrK2wNdcqG3kjj6j8nFE86wi1Xhtj74GKHlyjoxN7foKpjQ
 FVvQxApXZVM2+MsZq5XqD5QAfxsJMVZMeJ85Fc9GnBOydkGWWtXqXsCA8l2FzUcnH63j
 ewZO186GF3CifQam1yQJRM2EB2+Y5gHRop8boN3tJeE18x1CYeKFT7S2fPdn36e/hS1C
 O1NidXNfM2iYWAlt+G2qUyicHi+E1g2EfhxTFENn7GamaEBBr1QXKIMuPk6cfIGhRPg2
 Vm1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJkfSxpxawGwlkviMuDEmqXWrZq/vZ+Ca4aIArVWY24ialcwdhdGn/LUkD7hwgD6+fvigpI5s=@lists.denx.de
X-Gm-Message-State: AOJu0YwN28shu5GT3ntR8ZfZHqwryAxgpZfxcPVgijK9mM3gJ1r9ned2
 UoB/sFJG6sBykAiqd/9/rmmryQGfaY4/JZkI2RWJ2TFu3CS5CBVs9t7Fd7pwyOwCen5CXqX8MCg
 a3UQ2PJiMtluKjgExBeOvDOGCzZkvuMzczk2Xsuh738IIyxsrjU8=
X-Received: by 2002:a05:690c:93:b0:650:858c:9b9c with SMTP id
 00721157ae682-6db45154302mr142923037b3.29.1725988967245; 
 Tue, 10 Sep 2024 10:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx3XWfh+9OzNFekXP792T5XrWK6szcgBwMqxM6D7Mi8KyaSfJmES+LOTTzU4KJuq2NJoXtlA==
X-Received: by 2002:a05:690c:93:b0:650:858c:9b9c with SMTP id
 00721157ae682-6db45154302mr142922777b3.29.1725988966922; 
 Tue, 10 Sep 2024 10:22:46 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7967dbcsm324397685a.40.2024.09.10.10.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:22:46 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:22:44 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Apurva Nandan <a-nandan@ti.com>, Tom Rini <trini@konsulko.com>, 
 Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>,
 j-humphreys@ti.com, Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC/RFT 2/3] board: ti: j784s4: Initialize the ESM & PMIC
 ESM
Message-ID: <5xm64cbmev3egme4xx4n2mgeryn2hhs37ckoiuinveelbx433n@unhnob5wpfnx>
References: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
 <20240906-j784s4-esm-enable-v1-2-b83b17d5a744@redhat.com>
 <2fdfcb29-f6d1-4e30-960d-f1d500fb1cf6@ti.com>
MIME-Version: 1.0
In-Reply-To: <2fdfcb29-f6d1-4e30-960d-f1d500fb1cf6@ti.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 10 Sep 2024 22:43:11 +0200
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

On Sat, Sep 07, 2024 at 11:12:05AM GMT, Kumar, Udit wrote:
> Hi Andrew,
> 
> On 9/7/2024 2:54 AM, Andrew Halaney wrote:
> > From: Keerthy <j-keerthy@ti.com>
> > 
> > Initialize the ESM & PMIC ESM. This allows things like
> > the watchdog to reset the board when tripped.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > Link: https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/board/ti/j784s4/evm.c?h=ti-u-boot-2024.04&id=9d8b40958ce792808bc571d828197dbc2e7978d6
> > [halaney: add a line to the commit message, include header]
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> >   board/ti/j784s4/evm.c | 28 ++++++++++++++++++++++++++++
> >   1 file changed, 28 insertions(+)
> > 
> > diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> > index 548dbd5925d..a0ef3a44536 100644
> > --- a/board/ti/j784s4/evm.c
> > +++ b/board/ti/j784s4/evm.c
> > @@ -7,6 +7,7 @@
> >    *
> >    */
> > +#include <dm.h>
> >   #include <efi_loader.h>
> >   #include <init.h>
> >   #include <spl.h>
> > @@ -72,4 +73,31 @@ int board_late_init(void)
> >   void spl_board_init(void)
> >   {
> > +	struct udevice *dev;
> > +	int ret;
> > +
> > +	if (IS_ENABLED(CONFIG_ESM_K3)) {
> > +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@700000",
> > +						&dev);
> > +		if (ret)
> > +			printf("MISC init for esm@700000 failed: %d\n", ret);
> > +
> > +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@40800000",
> > +						&dev);
> > +		if (ret)
> > +			printf("MISC init for esm@40800000 failed: %d\n", ret);
> > +
> > +		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@42080000",
> > +						&dev);
> > +		if (ret)
> > +			printf("MISC init for esm@42080000 failed: %d\n", ret);
> > +	}
> 
> Thanks for patch ,
> 
> IMO, if one of esm is failing then we can skip other esm probe,
> 
> > +
> > +	if (IS_ENABLED(CONFIG_ESM_PMIC)) {
> > +		ret = uclass_get_device_by_driver(UCLASS_MISC,
> > +						  DM_DRIVER_GET(pmic_esm),
> > +						  &dev);
> 
> Same here if esm probe is successful then only we should probe pmic_esm.
> 
> Reason is , if any of probe is failing functionality will not work and
> 
> there is no point to probe devices, if function is not working.

Any preference on how this is handled? I was going to do something like:

	if (IS_ENABLED(CONFIG_ESM_K3)) {
		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@700000",
						&dev);
		if (ret) {
			printf("MISC init for esm@700000 failed: %d\n", ret);
			return;
		}

		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@40800000",
						&dev);
		...
		if (IS_ENABLED(CONFIG_ESM_PMIC)) {
			ret = uclass_get_device_by_driver(UCLASS_MISC,
							  DM_DRIVER_GET(pmic_esm),
							  &dev);
			if (ret) {
				printf("ESM PMIC init failed: %d\n", ret);
				return;
			}
		}
	}

but wasn't sure if a err_esm label and goto would be more in line with
what you imagined? Let me know otherwise I'll just submit this version
tomorrow or so.

Thanks,
Andrew

