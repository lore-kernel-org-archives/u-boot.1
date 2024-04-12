Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49400C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 02:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C54688005;
	Fri, 12 Apr 2024 04:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="m5qgTZqi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3FD881B2; Fri, 12 Apr 2024 02:19:24 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9753F8820A
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-617dfcf80aeso3709927b3.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 17:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712881159; x=1713485959;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z468rBTPCiV3ddRwztJBp1eK/3KomTfD14kkp2ceVnw=;
 b=m5qgTZqi42lyleWlVLE+A6/ntSqvfzdEubf0db19dk8RN7m+HGvj6QvCs9Kxv7KhQI
 W75Y7wDmuA7Deg/+4apJY1RdyA66yWvajjJTh3TY6k5mcrscfGtAIE7FYfbjfnn6Opu6
 OUa3l7ap/9iURjyf70pCojEwopkVDied2QdYTPfmD5izhiq9RymvVIFUQLd2Q05SjnT9
 DoaHj5+BG85WR4gv3cd/8ZM4gezym6iNXFyHrmwguEmA0tQRKi9DwJWXk4I2N1vgrUPc
 /wKK1tvbs25CjkLTac5FSHGfKaxThUkjteTyyLGSjfY7zNiiFwCJ/zUQkH3Na6gaMhqY
 Xw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712881159; x=1713485959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z468rBTPCiV3ddRwztJBp1eK/3KomTfD14kkp2ceVnw=;
 b=bp1sVq4Yz7svPupLSXWTQv7SgcMAlmsKSMBYCHrhUdrqMxEAcIGm1VJAN0XJNRTNyd
 9PlbUN2Es7aruOZ5h4ZE+jlIddk5+Gb6RBbvVQ0UXU2R+DnNoTXZ3yPkrj4VDR25wytM
 VJmWbxeEgx/AGjGqj2ICClOeBfOoNVz32HmDTmpZhI+hpMKm+xijq2IRa9dFtziG4o2o
 QFE9cVg7/6Eqzn4QHstJv1NDrqah842EEL69/ELmLpi2VG/18SRlxtWKIjUcIw1UVSjJ
 LJTU59/GO7vif87XmFFrEt4lwixK+tArC8VR8Ct4/apjOpgokyIdNWIz0SpOplvxzxN4
 o8ig==
X-Gm-Message-State: AOJu0YyXRq3mTo4exfhPd+9vqOeP0RtPKwV4TAgwGgAAGpgh4tdJ2F+j
 Cdgzq/n3TXl3pfzbxd54CNCVre1Th92eacIS5r8CiyjOnvIFAqY3cUdGeU4p0Z1lE20S2xiNxFK
 jgG8IRTFAUqX1lyFF4befn9bd3+Z/niBuaN5f
X-Google-Smtp-Source: AGHT+IHpFNy5iKTB0hcdw4kEY94JATIaDjMOb9xJZROilk9aqvwO/bC0H92bQBvfctlYJ09K1RurwPUzusOOFdfCdsw=
X-Received: by 2002:a81:8389:0:b0:617:d37c:ee46 with SMTP id
 t131-20020a818389000000b00617d37cee46mr1023408ywf.47.1712881159447; Thu, 11
 Apr 2024 17:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240411234021.14534-1-greg.malysa@timesys.com>
 <20240411235250.GK2493117@bill-the-cat>
In-Reply-To: <20240411235250.GK2493117@bill-the-cat>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Thu, 11 Apr 2024 20:18:57 -0400
Message-ID: <CAAjXUaoPoD_pN3QU=rxN6x3uOHex3TYgwkZDA_YZdj-Z_nmxfw@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm: Add Analog Devices SC5xx Machine Type
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Matthew McClintock <Matthew.Mcclintock@analog.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Alison Wang <alison.wang@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@sysam.it>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ian Roberts <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <monstr@monstr.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Priyanka Jain <priyanka.jain@nxp.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>, 
 Scott McNutt <smcnutt@psyent.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Thomas Chou <thomas@wytron.com.tw>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wolfgang Denk <wd@denx.de>, Yang Xiwen <forbidden405@outlook.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 12 Apr 2024 04:08:44 +0200
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

I'm afraid I have to admit I don't know. I'll work with our IT team to
make sure we can run CI locally, and when v2 comes around the answer
will be yes.

On Thu, Apr 11, 2024 at 7:52=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Apr 11, 2024 at 07:37:27PM -0400, Greg Malysa wrote:
> >
> > This series adds support for the ADI SC5xx machine type and includes tw=
o
> > core drivers that are required for being able to boot any board--a UART
> > driver and the clock tree driver. Our corresponding Linux support relie=
s
> > on u-boot configuring the clocks correctly before booting, so it is not
> > possible to boot any board without the CGU/CDU configuration happening
> > here. The clock tree itself is only used by the UART in this minimal
> > patch set, but is of course broadly useful for all other peripheral
> > drivers to be submitted in future patch sets. There are also no board
> > files or defconfigs included here, but some common definitions that wil=
l
> > be used to build board files currently are.
> >
> > Some of the configuration code in dmcinit and clkinit is quite scary an=
d
> > causes a lot of checkpatch violations. It is modified from code
> > initially provided by ADI, but it has not been fully rewritten. There's
> > a question of how important it is to clean up this code--it has some
> > quality violations, but it has been in use (including in production) fo=
r
> > over two years and is known to work for performing the low level SoC
> > initialization, while a rewrite might introduce bugs that could take a
> > significant amount of time to detect in the future.
> >
> > Please provide any feedback or comments that will be helpful in creatin=
g
> > a v2 of this patch that will be ready to submit for inclusion into the
> > main tree, as well as general observations that we should consider in
> > other driver patches before submitting them.
>
> Does this series pass CI currently? Thanks.
>
> --
> Tom



--=20
Greg Malysa
Timesys Corporation
