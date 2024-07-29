Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B426AC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 21:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07D7788247;
	Mon, 29 Jul 2024 23:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="dU3p1xz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01CBD8854A; Mon, 29 Jul 2024 23:57:24 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029F6879C1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 23:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a20de39cfbso5774084a12.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 14:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1722290241; x=1722895041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ym86dVjwX6vWqPWq8/IfrdQY0deUSH2Z1g7pMcsbVhY=;
 b=dU3p1xz3CFXFZqOzzfXqcfaYBeNQlUPEbg/Oqtyj9f0VApVxzlVarggFrMt8yzQ2nP
 bAg5rdjyALaMaq3eH2EWf1QaTiTb9h5W1doJNHSV7WauWnQt7TRm+Y/7KfQb4xQ3Yvm7
 HxYYeAhllXmGmgK8U/Vf6ZY+wMZ+BS4iZ6EFwhHzIYIFLnNAyDPNaFlEDm3XcmMChB3U
 9KCXwMYWtc1lsuTv7hXasOoacU88Gj0vNK4FOKPQxutzRxY1GajkMIuMey7pp1njqVMP
 g/8P4TvikcTPe2yQbCsXbN+/ztnAYjeauP4GXYnyTcIOq8DkvUSKuaF3ejm616qgJUYu
 AUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722290241; x=1722895041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ym86dVjwX6vWqPWq8/IfrdQY0deUSH2Z1g7pMcsbVhY=;
 b=jgcRXYktJcZ1jjXFK33ze5hWDny3WMIrdePjPlRhKL7/mx9Bx9ZQL3ubuZw83eKzMD
 FQIMuhkSmrJvxrGAlHpry1c1bxHkQYWVa7OfzcoVpC+cupkiH11vuMBkKAsvS3sqpr+w
 K8IjeV6uwujESyDKKdcE9cypGWmOn7hgZ0th9l1IMmkqgcwwwZlx+P9ET8T9DfqrPvHY
 SB1tHKqriAN9kc0MHjUkh1/5jOyyROkG/SQAhDCzinTfv6MFzFC33+ZHblGkMlFX5SjG
 2AWuzLO+wdJ8Z6n89Xr9GGbU+2OdzIYpNMsb1BRv8wYBg0zuxE8Pc9fGbJSYVTe4Vfm+
 pwxQ==
X-Gm-Message-State: AOJu0YzDcjBSGhXxBnp4PTNLQQ8kJsTKDT7Vpa+926KmFXVKgOZDfuQ+
 ApfMq2pkjxwY5p50rVaFyO/yeJ7UG3eSocj3XErN+tovlv4yE5T+eq4mtRdOCtk=
X-Google-Smtp-Source: AGHT+IFwKN6cdlebArSuKSo2rKmabJaOXb09AoXYhxavnn185Ub6yfLRemxYr95fUytPy1U1uOGLOA==
X-Received: by 2002:a05:6402:268f:b0:58c:ccc1:17f7 with SMTP id
 4fb4d7f45d1cf-5b020bc1aa3mr6572626a12.15.1722290241141; 
 Mon, 29 Jul 2024 14:57:21 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5af758a6c36sm4773189a12.73.2024.07.29.14.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 14:57:20 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at
Cc: u-boot@lists.denx.de, patrick.delaunay@foss.st.com, yangshiji66@outlook.com,
 raymond.mao@linaro.org, n-jain1@ti.com, eugeneuriev@gmail.com,
 ilias.apalodimas@linaro.org, devarsht@ti.com, bmeng.cn@gmail.com,
 trini@konsulko.com, upstream+uboot@sigma-star.at,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] reloc_bootstage: Fix out-of-bounds read
Date: Mon, 29 Jul 2024 23:57:19 +0200
Message-ID: <12856391.hYdu0Ggh8K@somecomputer>
In-Reply-To: <CAFLszTg-bqTTv2NtVC-3m2O2nw+9eczcM9_wn41u6XMcujqNEQ@mail.gmail.com>
References: <20240712081118.29189-1-richard@nod.at>
 <CAFLszTg-bqTTv2NtVC-3m2O2nw+9eczcM9_wn41u6XMcujqNEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Simon,

Am Samstag, 13. Juli 2024, 17:13:50 CEST schrieb Simon Glass:
> Can you use 'bootstage' as the commit tag?

Sure.

> > +       debug("Copying bootstage from %p to %p\n", gd->bootstage,
> > +             gd->new_bootstage);
> > +       memcpy(gd->new_bootstage, gd->bootstage, sizeof(struct bootstag=
e_data));
>=20
> I would like to have the relocation addresses in board_f like with
> other relocations, so it is easy to see what is happening, in one
> file. So how about passing the old address to bootstage_relocate() so
> it doesn't need to access gd->new_bootstage ?

You mean passing the *new* address?

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


