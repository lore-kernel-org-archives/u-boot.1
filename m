Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84987E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 13:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4818001F;
	Fri, 20 Dec 2024 14:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="gpm+0Vb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B3D280291; Fri, 20 Dec 2024 06:40:46 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D772780079
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 06:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=david.regan@broadcom.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee9b1a2116so160717a91.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 21:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1734673242; x=1735278042; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4JinOrfSUywBtoNmp92TMLyX2NNJ8+dMtcq2JQbZlj4=;
 b=gpm+0Vb+7iAd3xbtxs7EWJW6+NKxKnTVEk93gqeb2M3bwpRRNhIxuenRGmVzipcA6D
 UMhlF4SafHXWnSGRZ2GvN24MeKQXy1OepWldEdlWzHrUlbeWAhDC4lz1N2D7rNI0j+7U
 x1YhUJY9Ao/rCNXT7/e5yC1DB3clYR/hw3+U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734673242; x=1735278042;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4JinOrfSUywBtoNmp92TMLyX2NNJ8+dMtcq2JQbZlj4=;
 b=KEPVFBqT83KCKaGso0J5ft2p5zYsTts5kPxv0F05lcEdsHrHajW9divPqcF47H+02S
 V29teS18MSHZiUpD99qm8Za15PfZThOCEzIZ67Hwp9gQDPKZM84PjqM6jlXS4X7oLI0L
 IDvtU9CNNeMYSxiKyE/MDI2tAp9WE2l+fKCDpt35kMLz2BHGbMfPm2Ih5vjwCXoDWL/0
 P8M2ONdLfeCkKcMN0yxKUcJhdf5Wuqjg/G8lo947itJFI6j9gSBrG6b24StdZ6X3ByW2
 kBlrg7DZho0G3JHso7TtTgNzGyqj/zffoYE5m2F07PavnEwqjWk/9I8BCwB7CAy8RNqI
 qvvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbacFIFEW6K/iqsDY0V8K8N5x8d4rET4CXQfMvR5qXc8isXUOA2R8ZMJxQFsMud7525v5+y2U=@lists.denx.de
X-Gm-Message-State: AOJu0YxVTw84e4dxf0tnornP+GOvOlCXAI8MWbaJwSjaeAVgr+keFprX
 MQbEZ+B2b3x4kHEzSjp7wimPbJnpTfpXsRTZAjtkhcw/2a4LHlphR/I4MJPn5w7/g+DYt99Qkkr
 OdAm1VelAbfW53xeXjO34wC5ybzrZa/8De5jM
X-Gm-Gg: ASbGncv54OGNcV83Z3Bli9MACmadgFWnz/to5e2sUt9WxzmmQMMnnBcDQ6Ojb5X7ba4
 fHxxJp+wpXb1Z5lE93mkUwC31qRJVG9UpEZNUdVc=
X-Google-Smtp-Source: AGHT+IHd2NuxiVszMafiS5chOn4eyCDhdXAzdi9AJE3UtngVudord98k17al8oVOEMp2Q6cJmwKgwwBLmDDWWlczvZw=
X-Received: by 2002:a17:902:f64b:b0:216:30f9:93c5 with SMTP id
 d9443c01a7336-219e6e9e81fmr8225565ad.6.1734673242374; Thu, 19 Dec 2024
 21:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20241219184953.226978-1-dregan@broadcom.com>
 <20241219184953.226978-2-dregan@broadcom.com>
 <a9390faf-f4de-4c52-8149-5d3e7959a477@mailbox.org>
In-Reply-To: <a9390faf-f4de-4c52-8149-5d3e7959a477@mailbox.org>
From: David Regan <dregan@broadcom.com>
Date: Thu, 19 Dec 2024 21:40:30 -0800
Message-ID: <CAA_RMS54yCf0kyMgu-6-v=a1Y6xRn=JRtJA83TqWJKRKwsfNig@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: Use upstream dts for additional bcmbca
 devices
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: david regan <dregan@broadcom.com>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, dregan@mail.com
X-Mailman-Approved-At: Fri, 20 Dec 2024 14:05:25 +0100
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

Thank you, I'll update the patch set.

-Dave

On Thu, Dec 19, 2024 at 11:56=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.o=
rg>
wrote:

> On 12/19/24 7:49 PM, david regan wrote:
> > Make use of OF_UPSTREAM which uses Linux dts.
>
> ...
>
> > --- a/configs/bcm963148_defconfig
> > +++ b/configs/bcm963148_defconfig
> > @@ -9,7 +9,7 @@ CONFIG_TARGET_BCM963148=3Dy
> >   CONFIG_NR_DRAM_BANKS=3D1
> >   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x2000000
> > -CONFIG_DEFAULT_DEVICE_TREE=3D"bcm963148"
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"broadcom/bcm963148"
> >   CONFIG_SYS_BOOTM_LEN=3D0x4000000
> >   CONFIG_SYS_LOAD_ADDR=3D0x01000000
> >   CONFIG_IDENT_STRING=3D" Broadcom BCM63148"
> > @@ -17,6 +17,15 @@ CONFIG_ENV_VARS_UBOOT_CONFIG=3Dy
> >   CONFIG_OF_STDOUT_VIA_ALIAS=3Dy
> >   CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> >   CONFIG_HUSH_PARSER=3Dy
> > +CONFIG_CMD_NAND=3Dy
> This patch seems to be doing more than the commit message claims it does?
>
