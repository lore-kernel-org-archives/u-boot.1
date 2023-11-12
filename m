Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EB4C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 14:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28ECE86FBD;
	Sun, 12 Nov 2023 15:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iMFpo0MI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 448A187126; Sun, 12 Nov 2023 13:52:05 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A0F86FA7
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 13:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.oniszczuk@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507c1936fd5so5131716e87.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699793522; x=1700398322; darn=lists.denx.de;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7exzIssafJT01O3gPuKWX0eoIaKwlXPN9O7ODn6Bsg=;
 b=iMFpo0MIsOSJ3Y8D26rLFIU2YRHfPmfof4Ivlmkk+ZeSSFq59ER76lHd5jZ5mudajQ
 5ACpGfEJd+vDjTJBN3/2nBcTXiv4NhfNm7c9VJF4RgQF5lZ/HS4XPINmFqTovgqBzHWR
 Yvh7NLy5F1YnQEwtZEfeVzQi/i+5orcn13/LuDKBZx5Yc7tIK5tlOUDFnI0wB2iDR8YS
 HeJRwhU5SQuZSbPHHhQCe304DpvmsF5jiPTen4LKVM0Yc2/truD2XfUuL6d/S3KPFeUL
 0gZVe5j064NqogDmSmLwDbWR1WIV2TQuH3nJXzPumsEoB6qgMp008vZdErqvHhG2JGNw
 Vvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699793522; x=1700398322;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7exzIssafJT01O3gPuKWX0eoIaKwlXPN9O7ODn6Bsg=;
 b=HcxRADplSsAVaO1oDNKxMwOtFQwIRumNqCLczXUdVFrkwrMDY8ImzL/QmUNko/gHkP
 ytXXJrC58XFCPX3zVtY3BeDxFgp1qZXvkeoVUsZ73qHKT0LEI0mpgHDN82hnui22VMLo
 Sz4ER+VNzHqBqkYBQ1EP9amGQb8zVtf3JeKMgQdz6d4coXMDzbXjmj3p+BLWEjXx0S6f
 3GzTOB5JluFl3iGlvrC28QaG+9UdAsVRdn2N0DgEwXBhXm1Jh/4PkZtsamPUfj+hN0mJ
 mVfa3Z/vxJPB9dsfylzPRTgFKL5jc/X1D1+Wdo8l+knENN7f+PrvQcyCMMTQmVQcgfYc
 HiuA==
X-Gm-Message-State: AOJu0Yz8m+w76kJg8GCtgtpaF9Jyt5NYxWo28Xe4LoRWoBg5L39SzAl+
 Kk7Siw/1FpXajTTBch/P4FQ=
X-Google-Smtp-Source: AGHT+IHXLZT2Ls2vboE0ngjQuU9T0Dq3FePVuL7ucGlrCpWO34hv711S3bp04pqEY75d8bma7htwSQ==
X-Received: by 2002:ac2:4a6b:0:b0:507:9b69:6028 with SMTP id
 q11-20020ac24a6b000000b005079b696028mr1221779lfp.24.1699793521804; 
 Sun, 12 Nov 2023 04:52:01 -0800 (PST)
Received: from smtpclient.apple (84-10-101-169.static.chello.pl.
 [84.10.101.169]) by smtp.gmail.com with ESMTPSA id
 o1-20020ac24341000000b00507a622185csm599902lfl.235.2023.11.12.04.52.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 12 Nov 2023 04:52:01 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH v4 0/1] sunxi: H616: add LPDDR4 support
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20231111091000.26744-1-iuncuim@gmail.com>
Date: Sun, 12 Nov 2023 13:51:58 +0100
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <C186AFEA-3FC0-41E6-BA1C-447A053C6E24@gmail.com>
References: <20231111091000.26744-1-iuncuim@gmail.com>
To: Mikhail Kalashnikov <iuncuim@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.15)
X-Mailman-Approved-At: Sun, 12 Nov 2023 15:39:03 +0100
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



> Wiadomo=C5=9B=C4=87 napisana przez Mikhail Kalashnikov =
<iuncuim@gmail.com> w dniu 11.11.2023, o godz. 10:09:
>=20
> From: iuncuim <iuncuim@gmail.com>
>=20
> At the moment, the driver only supports DDR3 and LPDDR3 memory.
> Add support for a new type DRAM.
> These changes have been successfully tested by me with orangepi
> zero3 4GB (DRAM: Rayson RS1G32LO4D2BDS-53BT).
> This patch should be applied after this:
> =
https://lore.kernel.org/all/20231014170236.16211-1-andre.przywara@arm.com/=

>=20
> Changes from v3:
> * added LPDDR4 part for mctl_phy_read_training()
> * added the new part in mctl_phy_configure_odt() as LPDDR4 specific to
> avoid possible problems with existing devices
> =
https://lore.kernel.org/u-boot/20231104062248.32938-1-iuncuim@gmail.com/
>=20
> Changes from v2:
> * added default value for TPR6 parameter
> * added panic for unsupported DRAM types in switch/case conditions
> * added new line at the end of the timings file, changed the =
description
> * added a few small missing parts obtained from boot0
> =
https://lore.kernel.org/u-boot/20231016053441.3197087-2-iuncuim@gmail.com/=

>=20
> Changes from v1:
> * replaced the phy_init array with one compatible with opizero3
> * added DRAM TPR6 parameter
> * adaptation to new mctl_phy_configure_odt()
> * added timings for the board orangepi zero3 4GB=20
> =
https://lore.kernel.org/u-boot/20230729111331.173768-2-iuncuim@gmail.com/
>=20
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
>=20
> iuncuim (1):
>  sunxi: H616: add LPDDR4 support
>=20
> .../include/asm/arch-sunxi/dram_sun50i_h616.h |   2 +
> arch/arm/mach-sunxi/Kconfig                   |  17 ++
> arch/arm/mach-sunxi/dram_sun50i_h616.c        | 218 ++++++++++++++----
> arch/arm/mach-sunxi/dram_timings/Makefile     |   1 +
> .../dram_timings/h616_lpddr4_2133.c           |  95 ++++++++
> 5 files changed, 294 insertions(+), 39 deletions(-)
> create mode 100644 arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
>=20
> --=20
> 2.42.0
>=20

> Mikhail

Mikhail,

FYI

Great work!

I launched 20h+ stress tests (continuous hd tv live playback) on my: =
ddr3, lpddr3 and lpddr4 h616/h618 devices and had stable operation on =
all tested devices.

Nice!
 =20
br

