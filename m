Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650C6D637AE
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 20:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01488392C;
	Tue, 16 Dec 2025 21:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FjkiFHB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E27583979; Tue, 16 Dec 2025 21:52:55 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428E38334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 21:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c730af8d69so3063031a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 12:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765918372; x=1766523172; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8N7SXow2ipjo+t/+XfPMNITpPxLWoaX1+MmyYvsotzM=;
 b=FjkiFHB95e+Zqs72p8n4FECEC9ll8HL0QKbZuSv/mDRCZHnK8rT5m6H91AI1w6LgZv
 +dyZR16qwSp5DR5T7c3HGReCQ2fUy/cxDGgQ/SwxK1y1fj0Dj83eB9ZZsnAtVig+6Tfn
 EqqveC4uUKr4Ha7HIZK0GzF0ZGbVOKfPBszTI60v61DtYf4Wk04eC+1pSjYK2WMpOYLQ
 8oYneMCmT7yxuopSMp7vGTyf7/GtMZ/84t41aMpxKIsigTeqqk0Vmv+H5E87GL3F1UOr
 4CAL41lqklOqlayFuwRIjfIwmhKV3M2D2+RPke6NMVHiYkZyDU3DYXmRMc4X/NG08dmO
 4/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765918372; x=1766523172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8N7SXow2ipjo+t/+XfPMNITpPxLWoaX1+MmyYvsotzM=;
 b=jxxEDLewhLgxshU5QrtAeJJ/gsHnUyz1s++uDi9Ie4g2oW2atWftruzFRnMpOLeAyw
 HgL2iENwnfQi/NA0JUuMbZW75XyA3dJy0hnzkeDbp7s50U5XRBfUWUNB460hXYrBc+Gn
 nrGWkp0IZUQn8gq1k+TsRbnE8v94x16i783GPv4iTay9rNqdj1J4wYngsyU1jlEVQqHi
 /GdEDrwNrDcKVBrW3Y2SzkJq0dWnaNl4jaPncAUkrpl115K0ty314aAiG/Hiv9ui7cBE
 3qR9qL/6L4VZ5nqU+zxr7h/o3gXknM0Z4cLQcufhmBJB5UZLpbPJe0wLy+aHK5OnVwvU
 YAfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXKcCNDnMoX8RN1jJCY5dDM8hvBhXQ7md3k1uVg6YT/Q8h+YIdrMV40joLOcxY2AyD6rw9EFk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj2ET5K8RHZVHQf5u4Pg3PuhJttUY8p0dykWdqSWwBNtGEube7
 wvA8REdvtiqZWuec4Wau1kN1q8wzg0e5yu+poFMFKZaTKkh5FVyw4QS5KRD7tA5USXnEuunVezT
 CHDScXHEd9skXhbcR9BVygS1V3XIfFzU=
X-Gm-Gg: AY/fxX6KULPFpO9B370O9XdMEtrZc2Yzvpsntqkh4EnkFINIFQz88hGwaan4PQ8TYkv
 5hpUJqozevO1NumfjTRmONuCWBFY/U2/8OLXidHtE72t8JGHeK6h9ETmsiJ4l1WBEPa0k0WWKlN
 8nc3Ru/aKNl8wGDoew6vKtHMiHeKarvBvnIooUmfbYeOn3LK59ZywiEh8fjnPh3X5lCopgIC4aV
 Wl+OppilYSYH0opbB3HVIgUb/4kApvQstixH4IgUrahgeLyo2YHVT1UGYPND2L/3A2iSxSK
X-Google-Smtp-Source: AGHT+IH2zpa66odtTM2/lylHUeppbA5pisExwWUddajNY4kmaizbi34nVqmrmdEA2jc2n4BW6ti9yqATtsMuUYji+PY=
X-Received: by 2002:a05:6830:4c07:b0:7c9:5821:7299 with SMTP id
 46e09a7af769-7cae83541bamr9218165a34.18.1765918371939; Tue, 16 Dec 2025
 12:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
 <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
 <CANp-EDZa0Y4NFOD2sco1xvONeLeixFQOrGLZ+hC275wMCHuF6g@mail.gmail.com>
 <CAN7C2SBop5h9WtF2GLRkWeNmLpBcDC5dHUmmR=WzRXTpr6-7VQ@mail.gmail.com>
 <CAN7C2SC7nfpDmQXjfJyZDw5m6HnfbSed+w_JNsS7+x2s190Huw@mail.gmail.com>
 <CANp-EDb+Txnrb15KuXBof6PMZp02WZ1MOy-LkrGoW-OLE8mWCA@mail.gmail.com>
 <CAN7C2SA=X3Pk9ehcVWDcugUzJ2wD-8ooeA6-=zGnVa-4nQ11Mw@mail.gmail.com>
 <CANp-EDaG1vdok9S-LQuKuK9-fU2=ZbW9qRfEtruGSJMsZKWJ+Q@mail.gmail.com>
In-Reply-To: <CANp-EDaG1vdok9S-LQuKuK9-fU2=ZbW9qRfEtruGSJMsZKWJ+Q@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 17 Dec 2025 04:52:41 +0800
X-Gm-Features: AQt7F2rKdTMsmUo2FNXuhuv0CavhBQO0ToCs_kT0VMQO70eTiEXliMyNu0QYp_E
Message-ID: <CAN7C2SDxEEBCDh1Q5iXqsc03tYU=VsJQZ-RNPPmhk7pjqP-6Ng@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 "Chee, Tien Fong" <tienfong.chee@altera.com>
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

Hi Ralph,

On Wed, Dec 17, 2025 at 4:18=E2=80=AFAM Ralph Siemsen <ralph.siemsen@linaro=
.org> wrote:
>
> On Thu, Dec 11, 2025 at 2:15=E2=80=AFPM Sune Brian <briansune@gmail.com> =
wrote:
> >
> > > > Issue 2:
> > > > For DRAM size larger than 1GB, when w/o O.C. and using as stable
> > > > setting as possible.
> > > > Even it passed the calibration it will not cont'd boot when
> > > > sdram_gen5.c is turned on debug flag via "#define LOG_DEBUG"
> > > > However this issue is not found on 1GB nor 512MB.
> > >
> > > I was able to get access to board with 2GB, and it boots successfully=
.
> > > Memory calibration completes, and subsequent test with u-boot "mtest"
> > > basic memory test is also passing.
> >
> > For your 2GB case it is w/o CYCLIC and WDT right?
>
> Correct. Both my 512MB and 2GB are without CYCLIC and WDT.
>
> > For this may I ask what DDR3 speed you used? 400MHz?
>
> Yes, it is 400MHz, at least on the 512MB board.

For this let me recap the situation.
1) 400MHz on any size could run w/o CYCLIC nor WDT.
Disregarded to die configuration nor die size aka page size 1k or 2k etc.
From 512 to 2G.
2) 533MHz only properly run w/o CYCLIC nor WDT on twinDie setup
3) 500MHz is required to backoff when CYCLIC and WDT is turned off on 2k
page size die on max 2G case.

So basically speaking it is about the delay tap on the sequence.c is very
timing dependent and toucky.

>
> > For 2GB there are different die configurations 512x16 itself also come =
with
> > different forms. If possible can you provide the actual die part #?
>
> Unfortunately I don't have physical access (nor schematics) to check that=
.
>
> > The most puzzling part is this. It only dies on the U-Boot stage.
> > The ddr sequence.c was somehow cropped to a point for only size and
> > speed for the file comments.
> > All boards or cases that even by luck passed the calibration phase on U=
-Boot
> > do not have any issue on all stressapptest nor memtester under distro.
>
> I guess I have been lucky then. My only real problem was that
> CONFIG_TIMER_COUNTS_DOWN needs to be enabled. And it was quite an
> adventure to find that (using git bisect). There are other issues,
> such as watchdog kicking in if there are too many printfs(), and also
> early uart access is broken.
>
> Ralph

Long story short when CYCLIC/WDT is off just back off DDR speed to stable.
However it makes no sense to trade off possible system speed when it is all=
owed
to reach 533.333MHz.

Brian
