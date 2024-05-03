Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25820C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 12:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81DBF88BE0;
	Fri,  3 May 2024 14:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3rqhbiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2D688BEE; Fri,  3 May 2024 14:44:54 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6825688BE0
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 14:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-de59ec28b08so1728292276.3
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714740291; x=1715345091; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/E0G+xaB27jY4GNuHIuahToCtq7UNTV1/Wul2VNkM0=;
 b=T3rqhbiCTyb2u8BxXi8XZZOJP5mOae935RQiSU29XNToQHjHhz9HqrPO9hGMCE9hav
 d6CeXWFByoBCBbbVPkOjLDNR1qJfjdmKCU9OANdGFHfUCLOIRbHyQCbXkhGxiLO7UPl6
 SbCnZSvPmMxE1qW++RaY2ORQPsfCJbeWxPAVxG7IDH+ERXiLafIPK+THxdfqiMYY3UZ5
 xXb0B9Bz13kBs62G1dK2MRkygqhpBElc3gOV8+nVG+P6Kxd4TPR1LvA7WfGkfpR0tkst
 fBZ9zBpUCSlJ14KzFo4U0qnQkhtu5QvSDHO4OVeqNLmSdap1Cu9hIOM6HSWBsMOrNS6P
 +W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714740291; x=1715345091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/E0G+xaB27jY4GNuHIuahToCtq7UNTV1/Wul2VNkM0=;
 b=jMeQRpztu+1R3WQ5J1TyLyga7hnYH2yVDX9C/gw4/i2hWjJzkAReUwMpvLUbizJxw9
 Lqsd5JeA6N80/H60DWXy0kLDNGS5VIwkFhZCh3y9mFUIRXAVtB4Q8yTLn2tuHp1fyXJu
 2RQR6FLvhUBVR2MiFv9V0O8Xlv/T2nNree5ApdAT7x09V4fcNSe6DPZ5FmsCzKBr5TRy
 HYXAOGYzJSvtFtbv62XrBK/bSgah8l/oD320T0L59usOCC9LScebueiOjhcGp8vNlB6h
 AW5uO0XM8n48pMeJybQ0SnpQIACCATpgG7LVd5D6bmXoYVF0/OJMARVEtBruyQwCnGmk
 82oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYyUsOBZjaAK/HjB2VoXSHkXJ8lINtFGS2dRMP/EwQz+PnupwrKOpyRKRRGxpGMyMI7T2sEkL8sk4lK55qgMIqHmxpDg==
X-Gm-Message-State: AOJu0Yxf46evv+hzXvxayAW97/7VX7k0V8wlGVR7z5NXlDskPnI5BBid
 ANLMuTODxEe9zqsvQEdP5/9vuwsoRxJ31hMVZ+D7V4KAjDD1Fi/kq7+fJ7zVZe2tiRWSz7Sjc1E
 dqGtkLCUPwfkmJGdNeuR2pXLFEwY=
X-Google-Smtp-Source: AGHT+IHa9rWUfNCw0YBwht43UP4qyh4HUzFaLMU2w/crn7jWNNPmpeJAretL6U+n62hRfb23sWRs9qextCugOa//vmU=
X-Received: by 2002:a25:2d7:0:b0:de4:6124:edfe with SMTP id
 206-20020a2502d7000000b00de46124edfemr2309831ybc.3.1714740291161; Fri, 03 May
 2024 05:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
In-Reply-To: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 3 May 2024 09:44:38 -0300
Message-ID: <CAOMZO5DgBF7ULn4Cp7VA0c29A5TKiJrxwoBEXSbYPu-9M4nzJw@mail.gmail.com>
Subject: Re: [PATCH] configs: Make USB_GADGET_MANUFACTURER consistent over all
 PHYTEC boards
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Tom Rini <trini@konsulko.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martyn Welch <martyn.welch@collabora.com>, 
 Parthiban Nallathambi <parthitce@gmail.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Benjamin,

On Fri, May 3, 2024 at 4:01=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:

> -CONFIG_USB_GADGET_MANUFACTURER=3D"FSL"
> +CONFIG_USB_GADGET_MANUFACTURER=3D"PHYTEC"
>  CONFIG_USB_GADGET_VENDOR_NUM=3D0x0525
>  CONFIG_USB_GADGET_PRODUCT_NUM=3D0xa4a5
...
> -CONFIG_USB_GADGET_MANUFACTURER=3D"Texas Instruments"
> +CONFIG_USB_GADGET_MANUFACTURER=3D"PHYTEC"
>  CONFIG_USB_GADGET_VENDOR_NUM=3D0x0451
>  CONFIG_USB_GADGET_PRODUCT_NUM=3D0x6165

What about making VENDOR_NUM/PRODUCT_NUM consistent as well?
