Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACE0C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 20:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46EBB8801C;
	Fri, 15 Mar 2024 21:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ex+Ovw7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE7478804B; Fri, 15 Mar 2024 21:40:00 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330E087F3E
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 21:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dde24ec08cso3727475ad.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710535194; x=1711139994; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nr6Nc5SIveMxl0+VkdPi4q+RLtuggjaBEjpCfeSDuq8=;
 b=ex+Ovw7PkHzpI+OkY3ctYp4wzUcPbKRznyTwzBoRdVBApGkzq+jhYAA05TusQh87qf
 X8N8g+bVby3Ziz4Vx/JNMzMsGEy+Qi9QC0L54Q0/ieOh3yHmXCdGbSfVwQzxLA+pgECd
 RwPG3IypxSazq2J22M1m6DLQ7s08sh6Cn+zaA8ZEPRydu7PYCX2hL1fRTgA3/xMbYPxD
 KlrkcmYLUXETzZx/pKfU6zzVCltMKJ37KzfIGM7LvhfMt2aaRYq7vIH32P02bwJhIeFu
 yaPPoJGXFSLPLjs4Rzqk3oH8CCmN1XPstUKhjkObY+c7d2RAoZO3sCzWMET/2POAvLjE
 GkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710535194; x=1711139994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nr6Nc5SIveMxl0+VkdPi4q+RLtuggjaBEjpCfeSDuq8=;
 b=DUpPdDMAos7+P6TyxiYF+1uXNk77p4jBgWsvYLfmGNafDxLx/mV7WOJDt7VNYNJDbp
 ObwbTwwjKQFMrR1I/YjSfBNMKBFwhJs9H2mD/JF6VEr7wG+pc0CkXw570fbYcy0K6u5e
 3EhpFMjkjHiYQMbMJEZAhXkf8dz7BcIOKbiISpvnq0Ln3AkyuR3XCGvx/fs0hpsaa0fB
 YRv7tXexF0rQcUqlsiAsBdvZb2CqAcKITLmF1OE2MLV6hhrdykmBLVrkRrQruogPlPpL
 28WK2il/RTmfhlPMnpcewGiJOcsfmLGj+oXM3gQja28f25oH1AS+VVJWqLL/MrkkmMMD
 xQiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8qRyT1fSDmLpdbtuPRh5jCWZ5FwXY/YVyqIV/J7hTUUF6EYBGhMP8omGrncc/uNTAnps/d0gvszs8Qf7T+FgTCP3xVg==
X-Gm-Message-State: AOJu0YzAuga5mhnpXe+QaUBMYI/Ekl70sLplQjhSOSjzkOvpGp/QlfF0
 qz3CfenbrMIpnNWw9Xu8T9dyTpKdnDQRcPdoshpKaeXFkJ0basumzuAu5kNiWUnUGzwQi4XYcGZ
 7wjPJffqKfmxUrr8XOQqoPftkqHM=
X-Google-Smtp-Source: AGHT+IFqMaL6usqC2vHWYT7H/SR98av6KbDT6Q5q1Es/iTwkIFVpADbuPDecsVEZrkCP7RZLdbCpf/gKLsGbtWFEFko=
X-Received: by 2002:a17:90a:8d10:b0:29b:ef73:44ff with SMTP id
 c16-20020a17090a8d1000b0029bef7344ffmr5609195pjo.1.1710535194536; Fri, 15 Mar
 2024 13:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240315143930.29155-1-hiagofranco@gmail.com>
In-Reply-To: <20240315143930.29155-1-hiagofranco@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Mar 2024 17:39:43 -0300
Message-ID: <CAOMZO5A9ewwMP8MEtJLCjp-g8jjyNmBtBz3qf=KnmQokLWWWJQ@mail.gmail.com>
Subject: Re: [PATCH v1] doc: board: colibri-imx8x: Update and improve
 documentation
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Hiago De Franco <hiago.franco@toradex.com>
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

Hi Hiago,

On Fri, Mar 15, 2024 at 11:39=E2=80=AFAM Hiago De Franco <hiagofranco@gmail=
.com> wrote:
>
> From: Hiago De Franco <hiago.franco@toradex.com>
>
> Update and improve the building documentation of Colibri iMX8X.
> The following changes were made:
> - imx-atf repository changed to nxp-imx GitHub.
> - imx-atf branch updated to 'lf_v2.6'.
> - imx-seco updated to version 5.8.7.
> - nxp-imx mfgtools link updated to GitHub releases.
> - General writing improvements.

Thanks for improving the documentation.

One minor suggestion.

I have recently followed this document and noticed that the
instruction to copy the
mx8qm-apalis-scfw-tcm.bin to the U-Boot source is missing. Please add it.

Also, since you are updating several components, shouldn't
mx8qm-apalis-scfw-tcm.bin be updated?

Currently, the version is from toradex-sumo-4.14.78-1.0.0_ga-bringup
which looks quite ancient.
