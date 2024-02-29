Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB5DC54E55
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 10:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24B5787B41;
	Thu, 29 Feb 2024 11:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZK7Lvxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1946187B63; Thu, 29 Feb 2024 11:23:46 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDF5B879DF
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 11:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-513235b5975so887667e87.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 02:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709202223; x=1709807023; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8M2+YJ/MT7yF2lssmgrFwul8i01yrTVBzld8HSUX4k=;
 b=kZK7Lvxfw63zxtSNEaZQy+Ri80nXUlBYwQt8yNdu8PxA/cRBiAJNuDvceKvxL0p7mK
 dBU7x01GvEr19I0W+Ci3nN+BY/zk2DmmE7LupeNyyxZCYlnpN1o/zSToJu3XzfthnkDc
 TmHgS4X30DnR/HKqyH+hirvOQ8MNQAMj9uoa0WiYRD7UOCwKNpLfTLe+agtxoFBvuMUB
 KGDIC/LVgj9Z8zURKvnTP9ksQKp24nftBgjpexx5FUbcvbECTq3jJfqNGgYVqZwITiUT
 honhocrUT5wB9XEAUB6x/vl7hrfhp9zEaxvJTepM2b/hpGJEAuwWAfFEqWJPiFtXRJnK
 qA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709202223; x=1709807023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8M2+YJ/MT7yF2lssmgrFwul8i01yrTVBzld8HSUX4k=;
 b=Vg61a2+UGMVc56Xv3dwCcpMnxVjdezIzOwKJYuHISj2AKUlAq34PC3QsP7h4hvY3G4
 7bjNiIKIVeZkicgMMH0JupVrlnfN/ACvwoh5m7O/rflvm+1aBll/ONO/4s+kvrXa5J8G
 G5MJpbBGiizOS6Mc+4a4TrRL/iAuDgMxU8zsyll0SjcXxs26cQYRtxyVkcJlcRSbjpmR
 Sp/8FLNjnDeOj8eNCXYZllkjn5fM0+t4r17mQlsZxPPrJ3h5QcVzdf+wL1CHZ5oC36Ja
 7l/F+59SxudHp81LFDnGQ0LqzdsQhI9NOrIaEkBwMCUBzgg0kZpOMlgPLJ7RP+XT2/gn
 n3Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz2mHA3o/Pyy/xQljPuwlc/H+tP8+XiTn+PUrpHy45WKFNsH/EBTXJ+6WafHwgoSGeUF83SKYOPLNK9dIdaRugM1xBmg==
X-Gm-Message-State: AOJu0YxRo+q0j4Z69y+cXLXQo7rq3/hirn3qTvKMrsej/qGRtTuFlh+g
 GOCCAic3lKQoFaW9SBZ+e1f5Vc7eQ0A0vShroAjHSFQ6leSRMu0x+2HRo3W/4ssdcBEcc8thlJc
 YB1UnynFfM0BxJWy2qKKeNYIcXFE=
X-Google-Smtp-Source: AGHT+IFnV7JG8idznDcjtM0/6zTo1Ch1pAukrSpuqxw/G9lTB4Y3viNW7SeGbRvTpse3QWjsu8SThlz7Yu9+jHnSJok=
X-Received: by 2002:ac2:554e:0:b0:513:26b5:139a with SMTP id
 l14-20020ac2554e000000b0051326b5139amr800216lfk.23.1709202222873; Thu, 29 Feb
 2024 02:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20240125201654.17685-1-clamor95@gmail.com>
In-Reply-To: <20240125201654.17685-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 29 Feb 2024 12:23:31 +0200
Message-ID: <CAPVz0n0x22t6x1Zu-GRqLYXjJVpyme-PikhB=_KyKyLEFreyvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Fix booting kernels with ATAGS and extlinux
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D1=87=D1=82, 25 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 22:17 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Currently, if boot with extlinux.conf and do not set the fdt
> U-Boot will provide its own device tree. This behavior is
> beneficial if the U-Boot device tree is in sync with Linux,
> but it totally halts the booting of pre-dtb kernels (3.4 for
> example) since it uses ATAGs. To fix this, pass `-` in the
> fdt extlinux field as a signal that no tree should be used.
>
> Tested with 3.4 legacy kernel and mainline 6.7 kernel on
> P895 (lg_x3 board).
>
> ---
> Changes form v1
>  - Added CONFIG guards
>  - Clarified documentation
> ---
>
> Svyatoslav Ryhel (1):
>   boot: pxe_utils: skip fdt setup in case legacy kernel is booted
>
>  boot/pxe_utils.c       | 27 ++++++++++++++++++++++-----
>  doc/develop/distro.rst |  6 ++++++
>  2 files changed, 28 insertions(+), 5 deletions(-)
>
> --
> 2.40.1
>

Hello, Tom! A month passed since v2 was pushed without any actions,
should I re-send it or maybe some adjustments are needed?
