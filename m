Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672D2D6A22C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 20:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDA388DF5;
	Thu, 14 Nov 2024 21:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MpQhLHml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1311988DC6; Thu, 14 Nov 2024 21:19:04 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F0888DF5
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 21:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb4fa17044so11755801fa.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731615541; x=1732220341; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CbP5Qobpm53RFvBE1CP34v3kUoOEuNeVW4nYgu38wZ4=;
 b=MpQhLHmlaOonUtHkKp6il3w+tFDVkZb1qJVunEH5gEV+riwi7IDlAj3IyEZRHyOtDy
 iIB9D94C6roMKeNQ/E9tcjBmWAM5I1SAP8WeX8Ky7jBFsnAJ8FM/1DUFAqWDhrufFYXJ
 rJ4rr3Ca2G+VtC4njsaQ616OIYt72hBqo2XChQBZTvrEEWrqM5TbWLInhnA8dHvepwvf
 Stj+jQpIrjZ4+1rvrkqOH66hyEwhPER4oCQmylX/yTOoQoLCHnoz1miyWySM+NkR4qNr
 OtTT9KkSD6FaUHl5MEe86eBZA1P1xWDJL0fkmpv/GTRrEFVDFjzxbDdaknG2XXi1suW6
 D2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731615541; x=1732220341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CbP5Qobpm53RFvBE1CP34v3kUoOEuNeVW4nYgu38wZ4=;
 b=UctuC5X8htsNjjasqX89V5SxRGbnE49y/3IPTB54HJssNd3ViUwTprh8HeJl73q+gI
 bMYNqaRzXA/IDuHZYkwFZRtDUvvTESnu8y/3Uke8t3i5aelnvWJOwBJ09bKrK/VsfuG3
 3vOWDxpw7t8g2lNs9VCWtV/NpJhCcVw5m/FxhCn11+PFvsHYMGNApYiOeawCsx0MadaK
 5THc6kBVa4fKTEr7+L6tss8uxPIj2QLGs8Q48sWKLM0q8hA4qArlas7E2ncVPPiWsVvt
 3CzTlLKteT6RdiNySKB0vAOTDdDqvC+MGh/2vyNcLStSPOye3vDtm7SwaZVXmKjSPkbX
 nPKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTvRqNWBxvxxpT448I8twLI0Utn1Uf81Tiw91cpB7Oqf3xYaptHg1B6e0jGujJuMVTuFAAr9I=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/nVNiml+aBOaNgGbsHscruQ2q4peOwR1L9MEv0VRgbg3IkFzF
 7RO5wzJGbi//CIuDtyjZt6EuC9PFlZZKpDEy79aTqEhXogLQi+4eD5f7BYPjKxGdaKUXc3yNSe3
 kB+ki+wvSXHrXb/MrKmISSnnSsPY=
X-Google-Smtp-Source: AGHT+IFEJPM+AtkcDiXnPn0Ts72gM75d8k4tha8vbBg+ogpqukC102WUAufftbwOLnD+ajKtuE60TezB3kjDibBTt1M=
X-Received: by 2002:a2e:bea0:0:b0:2fb:6057:e67e with SMTP id
 38308e7fff4ca-2ff606efc11mr2103301fa.32.1731615541072; Thu, 14 Nov 2024
 12:19:01 -0800 (PST)
MIME-Version: 1.0
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
 <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
 <20241114163354.GH3600562@bill-the-cat>
In-Reply-To: <20241114163354.GH3600562@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 14 Nov 2024 12:18:49 -0800
Message-ID: <CAJaLiFyw5jba5g=8h6R_aB26wqJvdN9eLvu3T6FJBBpm4LkzhA@mail.gmail.com>
Subject: Re: ZDI-CAN-24679: New Vulnerability Report
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Wolfgang Wegner <w.wegner@astro-kom.de>, 
 Thomas Weber <weber@corscience.de>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>, 
 Phil Sutter <phil@nwl.cc>, Siddarth Gore <gores@marvell.com>,
 Luka Perkov <luka@openwrt.org>, 
 Holger Brunck <holger.brunck@hitachienergy.com>, Heiko Schocher <hs@denx.de>, 
 Evgeni Dobrev <evgeni@studio-punkt.com>, Stefan Roese <sr@denx.de>,
 Ilko Iliev <iliev@ronetix.at>, Dave Purdy <david.c.purdy@gmail.com>, 
 "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Tom,
Hi Stefan,

On Thu, Nov 14, 2024 at 8:33=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Nov 14, 2024 at 04:07:15PM +0100, Michal Simek wrote:
>
> > Hi,
> >
> > On 11/14/24 15:56, Tom Rini wrote:
> > > On Thu, Nov 14, 2024 at 04:02:29AM +0000, zdi-disclosures@trendmicro.=
com wrote:
> > >
> > > > Hi,
> > > > Do you have any updates to share regarding this vulnerability repor=
t?
> > >
> > > Michal, microblaze-generic is the most active platform that enables
> > > FS_JFFS2 by default and so vulnerable here. Can you find some resourc=
es
> > > to look in to fixing this please? Thanks.
> >
> > We have actually discussed this recently and we have other issues with =
jffs2
> > and not going to fix it or recommend to use it.
> > JFFS2 should be removed from our configs and it is also not under our r=
egression.
>
> Ah OK, thanks. Adding a few more maintainers now then.

Does this affect only boards that explicitly use CMD_JFFS2? how about
boards that have not been converted to bootstd and still use "nand
read" like this:

include/configs/openrd.h

#define CFG_EXTRA_ENV_SETTINGS  "x_bootargs=3Dconsole=3DttyS0,115200 " \
        CONFIG_MTDPARTS_DEFAULT " rw ubi.mtd=3D2,2048\0" \
        "x_bootcmd_kernel=3Dnand read 0x6400000 0x100000 0x300000\0"      \

All the best,
Tony
