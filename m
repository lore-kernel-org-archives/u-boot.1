Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EFAC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 19:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B64F487D5F;
	Tue,  2 Apr 2024 21:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="E5rRPdlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A141487BE0; Tue,  2 Apr 2024 21:08:18 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E5187E9D
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 21:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA2DB3FB77
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712084894;
 bh=CT3Yu5j5MdfeLryPaJrOZbjRhZfvERWOvThuGrioxDA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=E5rRPdlfg+aEqG4y7KPoimyoFFokHb8vpG5jewxrLBcQG2/YsmHH1laqBkDcIxNKa
 /XJLXqw6F6y/qbzrLe3LUDgs+slenTkxXk944TcLIzSwcrHOnmkypgpBxJMfKlFb4o
 VsqBHTYP+o2pnx3oKq6ffP+FrF+RF2kcHzmtStZaguvHFzmsrwKwARc/FVRaKP2E9F
 2ZzzB0fdkBajU1sp2Mueldy8osi6PJbM9KjLaMdVQI5TJYfw9n2aV3j7l4mu6K6lE2
 ZtJj/Cmqq/6P3mQjnPqV29G0RT68Bv/hVrM3h4HgtsY8+RoFPSk24xL65nBgWFLCWX
 KUGU65qArSABg==
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5a46b025acbso5873534eaf.3
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 12:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712084893; x=1712689693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CT3Yu5j5MdfeLryPaJrOZbjRhZfvERWOvThuGrioxDA=;
 b=MhmEakuODRIyd1tVKzt2dy7z2pv2eDAFRNKtOTkUYlO9uT3sXZwWxVlV43MH9SygCl
 eZQdSZdANIJzVZLsS/IXOeiIK+zhMD90GfhadvQlbdZ6l747SxtNdi+rS0JIkTv+2axQ
 JLiR4ir1EdQqZ5cIiNazBwYKvObLgTrBLgOK467l1HFlGoyAopuxkD8Rgoi39hSRrlb3
 JFr7D8IoDQAuGhXNLBFgvHDkiQtiQ/jB6c2UiSOQ5NZudKE0A/uPtvkI1CsMCXYTKT1h
 78imhxq4PDh70N5KgtXuPJssDwSN9mN5CE0SEAoga4LDquIDyuAI4psYGx8H+Y6uMWeM
 wo/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOn1ynP3hAodyJFoCTx7s9k/3F96FjaDpdVjXgwwP5ZQwgLF1jL1ecHjI2+Ma5UQR6cuGcId/Y7no0lku8m33HtHHPvw==
X-Gm-Message-State: AOJu0Yy3pdLr97q2b9BKkKI+M1XbjXvs4RggBlHSQBZgSGrBRyHgXRXK
 Hq8r8Iqfc3TDhfuaqYFCecQio4eppHYBXi0qcz+az6p1NC+QLRl7nFF3xJIewTaRaEggMZlsnwm
 jKhQUhzA2nAc29jcn7BxMcRvSsqWIyWzCHg/2UvK7vrxjaXfTTaCo2oDL3bvZGMAM9vKcck3CWH
 koZ6hCwxfg1WlVrtWw/GlTDba6duZZGO/5TOI541/fAQ==
X-Received: by 2002:a05:6358:939b:b0:17f:8831:2b7c with SMTP id
 h27-20020a056358939b00b0017f88312b7cmr498999rwb.25.1712084893072; 
 Tue, 02 Apr 2024 12:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZexTtIofi2AHMa0Cs7aCfHOrfuHih42RnqkrPdJhOm/WYlcqtc+NbAc2Ie9yQnZPNbDHcpDAmdX/PCTqpEOs=
X-Received: by 2002:a05:6358:939b:b0:17f:8831:2b7c with SMTP id
 h27-20020a056358939b00b0017f88312b7cmr498973rwb.25.1712084892646; Tue, 02 Apr
 2024 12:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240330175948.80931-1-bigunclemax@gmail.com>
 <20240330175948.80931-2-bigunclemax@gmail.com>
 <4c80330c-e12a-4652-89c2-857d572d6a7b@canonical.com>
 <CALHCpMgEr6kB+TcnqOAex=gpNqZex4sUyeEXjEVh2_0E4cdL5w@mail.gmail.com>
In-Reply-To: <CALHCpMgEr6kB+TcnqOAex=gpNqZex4sUyeEXjEVh2_0E4cdL5w@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Tue, 2 Apr 2024 21:08:01 +0200
Message-ID: <CAM=mAOmdRJLx4Rr1UaswaGMcvp7EkdhzmDFSbr8La0gWwWCKGQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] mmc: snps_sdhci: Add sdhci driver support for
 TH1520 SoC
To: Maxim Kiselev <bigunclemax@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Geis <pgwipeout@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Maxim Kiselev <bigunclemax@gmail.com> schrieb am Di., 2. Apr. 2024, 19:19:

> i, Heinrich!
>
> =D0=B2=D1=82, 2 =D0=B0=D0=BF=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 17:47, He=
inrich Schuchardt
> <heinrich.schuchardt@canonical.com>:
> >
> > On 30.03.24 18:59, Maksim Kiselev wrote:
> > > Add support for DesignWare SDHCI host controller on Alibaba TH1520 So=
C
> > >
> > > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> >
> > Thank you for driving the TH1520 support forward.
> >
> > Locally I updated the Lichee Pi4A device-tree based on the Linux
> > device-tree and built th1520_lpi4a_defconfig with
> >
> > CONFIG_CMD_MMC=3Dy
> > CONFIG_MMC=3Dy
> > CONFIG_MMC_SDHCI=3Dy
> > CONFIG_MMC_SDHCI_SNPS=3Dy
>
> You can also enable following options:
> CONFIG_MMC_IO_VOLTAGE=3Dy
> CONFIG_MMC_UHS_SUPPORT=3Dy
> CONFIG_MMC_HS400_ES_SUPPORT=3Dy
> CONFIG_MMC_HS400_SUPPORT=3Dy
>
> For HS400_ES mode also needs to add `mmc-hs400-enhanced-strobe`
> line to the emmc node in the Lichee's DT.
>

Could you, please, send a patch series with all these changes.

Best regards

Heinrich



> HS200/HS400/HS400_ES modes work fine with eMMC on my Lichee Pi4A board.
> MicroSD works fine at UHS SDR104 too.
>
> Bus Speed for both devices is 198MHz
>
> > I tested reading from eMMC and SD-card as well as writing to SD-card an=
d
> > found no problems.
> >
> > Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Thanks for testing!
>
