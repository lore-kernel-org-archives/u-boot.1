Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C82C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 00:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65AE588698;
	Fri, 19 Apr 2024 02:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UMdAuAQ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A366886A0; Fri, 19 Apr 2024 02:57:40 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3453988526
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 02:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2a698b0948fso349681a91.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713488257; x=1714093057; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/mRklg0rMuCgkcdw41y44W4JFgnF6kFO+zsc7GSyao=;
 b=UMdAuAQ5Z2Cn3NJpBbRdxd1ZH/owfVyV9S85iRg+Vgh/DFzzxEWc0pdr18jUCg+hGw
 wUXWC9j44apVmKaeHDpBHjxJdDuj1GXH7DpTY/HrK8W7L6Fp8GLtN7ZAoHyowsK3wkOd
 0/5LHTtKZU8K0paIYpZvI2TOr14P5ADa+GwnUVl1Qs3BVV50REnRZMP4Ifa9z1C0QOYr
 uCYs43vMdjj4l/7VroaAEffXOD2TmPG5nMJNWLfHuojVadb4lpb2/MyQppiLbFsNLvHO
 y+SEHCVNhxQj2umipARKqJ08UliXxG3nCml3vCD593tk8J9jq2PJxWteNrysJzkNszmZ
 O0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713488257; x=1714093057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/mRklg0rMuCgkcdw41y44W4JFgnF6kFO+zsc7GSyao=;
 b=hK9V+2L1zs36Wvq3HQ3J3vxfwzRSidyXSogkH5E/7b6QxkrxS0euKof7xsne1XbyfB
 FzyEGMqAWrpmtdxqr/tU7ycx/FVOYKn3tjesD/9ET4jiETsG/PfyIer0dnMRpa4Gm1Be
 Ogt/VvZYjVxm2v1zIgHj2eyRZK/kbhymx187PiSxdQxPKT2utsYQd8n+tXQ6VtIRikgT
 M/Gpd5AqvLrTtPmLDn0btbtMtg8uwHBXoOU6OdBU4jJygBVcRkVJs7jl0ZwtgIjKMwqW
 Fb7Mjb2kK+KVen9pBNAt/44BSksCukfXRkDW/k6hbkTGe57vGsPy4auEYEa5NFyXExq0
 S1SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqMIjoeyUF3vuaEHPTK/1AKMz8Xf/L9UjP8G8+XoHB84So/BOrSOfQGPhz6UP4aH6t6oGX2YI4UHRR2cr9oPfTQrpVCg==
X-Gm-Message-State: AOJu0YxB3P19z08uE0awVXXthlnUmiITKOkR/xyvvVn5BXIiZWY1E9hx
 gxJxKyUXTVKiGJsT2oerPqOWFWaelxDxtP8J2nVwUEDRmjjxci4a8vm5lY1EupvePQChODZgoj8
 RioZN1DR75mm59WeVgLpxaBaN5C3Uyg==
X-Google-Smtp-Source: AGHT+IH+f9g7S16MNu8ys8lrd4MVoeabVeY+oFClKasWZ38t1A6PsUuA1VjUpJlL1LdgbmOAHy+r8bu2KQcq+SJaWZI=
X-Received: by 2002:a05:6a20:3f24:b0:1aa:a384:5e73 with SMTP id
 az36-20020a056a203f2400b001aaa3845e73mr970371pzb.0.1713488256606; Thu, 18 Apr
 2024 17:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
 <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
 <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
 <CAOMZO5DL683849BczPa9aJvMJxZm536vp-wE5P+jcCK1KLkGEg@mail.gmail.com>
 <6783be1a-ade0-4cf2-89d6-b6ec29df5ce0@denx.de>
 <CAOMZO5B36vz1w9ZZzJ+oZtypanTb7k6PvXNwG6KP8QBqcniGOg@mail.gmail.com>
 <CAOMZO5COnoM3FGLkEgn1ke=+ZEhx_eGLRV0XGS7uSgWm_RvCJw@mail.gmail.com>
In-Reply-To: <CAOMZO5COnoM3FGLkEgn1ke=+ZEhx_eGLRV0XGS7uSgWm_RvCJw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 18 Apr 2024 21:57:24 -0300
Message-ID: <CAOMZO5Btv8DjwNaAEJcFjV_Jdg36SCEAcpMLgoygDMsSdSa7mA@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Fabio Estevam <festevam@denx.de>,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com,
 Claudius Heine <ch@denx.de>
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

On Thu, Apr 18, 2024 at 9:47=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> I don't get the error if I pass CONFIG_FSL_CAAM_JR_NTZ_ACCESS=3Dy:

Ops, sorry. This is not correct. CONFIG_DM_RNG was unselected. Please disca=
rd.
