Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F32ED609DE
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 20:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947B88392C;
	Tue, 16 Dec 2025 21:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z5I/izfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA4A83979; Tue, 16 Dec 2025 21:18:05 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8908334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 21:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c03eb31db80so3570413a12.2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 12:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765916281; x=1766521081; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CT1Q1h+UcqjvARwk/PPUYmdm3V0ISmpxOBJyZXFXRq0=;
 b=Z5I/izfaCmpLmJvTw/lcS9ijecm6fEWFznisyneAJmwg1qXVeh0Rt7awUnFq0ifl2w
 JRxT6HtZaLSyBagohInw7Sd2DBi8VeLzJlf1MaBjIXxum/B3EECP0g9I9MuXD2V1PHUH
 OCtaTbEGcQxmRbYCOKH1dMrVirrsXgpghLIRa1+vC81INVdxeZCkaluLBjIhdgpbVgox
 ZRurWIdq9+Jh2wBGdWj5bHvOuqEM1vnPkczNb7y6s1abz+wimcCGpiwhnBdC1xvx8vCF
 ftau4qJcdnwzNx+5FRZtOJhiH+XXBkxlJr9turzbwmAW9yH9M+XTXImz+UStXmNNahU/
 Q2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765916281; x=1766521081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CT1Q1h+UcqjvARwk/PPUYmdm3V0ISmpxOBJyZXFXRq0=;
 b=VhO9lFyrV95z1Nneu6xQFe2n8XbqLbQHl8o0hcXG5wX+9xQ39TvtnwqRuEtARt82Up
 2Lqd25q3z30WI3400djIcF/YVJ/BJU72c1TqI/u/wNZcWzC3/JYcZ67TGW6XbmMhnEc4
 t985wFsEQHDEG7MX3ZkUmVfVMFCKVctzQNTyDPT3sTNbnNmv4VWsaU+rWASDRDSCaNEg
 mgo0aZaOSESFmA/lKQkRu1dz9o0UknscS+mthTbw0wlqx0unKojPsusi224jvQD8bpVT
 1vhwukJeFRzQ/AhbfDDVKLp4PrJiEoDVc38VC7aSwPiEdxr9xBUspIuBdCDL3dcPq4wc
 O+PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNwHiJlJxCyHfDYjFGwVDGq17NVyuXY8guT9sfIqfIgQB9lFHWO9NI7st07akdKH+VHDcf69Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzRBdZX+XAR80P/UbCS3xFB7nDBrKkXUau/CIR6LIkHF3aB1Sho
 3OycTl2/TEYVsZKacjGqu/Y8/qK2NbNYm2BwRs/VlCqhnf1P+KFm+x/rZ+s57I2cj52/e9ZuX/+
 5L8Yu7p58BfEB4f0juhfRrpEUzu9Btfj+GyP4E2HWzQ==
X-Gm-Gg: AY/fxX710XWwdgoaoXkc+wfRIyFyxMbTZ0GIvSKMM40Cgf/VmxYp/NSLRBzyzAASS59
 8bxj2es/rdhwVacH3GeIPhw5oAsOz8lmo6mY2ynyiFHJ85F2IPwvC0g+y/bCB+l5r/lOV9Vfcte
 Lsgv4+Ii0J4XLJskjr9/CJfjhMbtQK4OHWXpAdFVpqaBHB9a8hItuc6HoF69yjoUWtgqGdwAkd7
 0mSlWzyhpH4hemzdCKHTEkFhTPjelqni0OYBT6kxf2GL5kU3XAi7F+yYL0jwQoGhmkfQvl4Sw==
X-Google-Smtp-Source: AGHT+IEf9xGR1mNGgRZ1fr9oewmb0BS/4JANUwj1bltBHFybVYwhFRw76pv8vXg0Gm5txBnjHhSk2j3f0qmZxKEcdA0=
X-Received: by 2002:a05:7300:d211:b0:2ae:581f:ce5 with SMTP id
 5a478bee46e88-2ae581f0dc7mr1127980eec.7.1765916281365; Tue, 16 Dec 2025
 12:18:01 -0800 (PST)
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
In-Reply-To: <CAN7C2SA=X3Pk9ehcVWDcugUzJ2wD-8ooeA6-=zGnVa-4nQ11Mw@mail.gmail.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 16 Dec 2025 15:17:53 -0500
X-Gm-Features: AQt7F2obSiQunP6Kq30PVCrDUMp9Jhb_DhB3PYq0Y8maV3oEKXAzlMOZNVk3kus
Message-ID: <CANp-EDaG1vdok9S-LQuKuK9-fU2=ZbW9qRfEtruGSJMsZKWJ+Q@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>
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

On Thu, Dec 11, 2025 at 2:15=E2=80=AFPM Sune Brian <briansune@gmail.com> wr=
ote:
>
> > > Issue 2:
> > > For DRAM size larger than 1GB, when w/o O.C. and using as stable
> > > setting as possible.
> > > Even it passed the calibration it will not cont'd boot when
> > > sdram_gen5.c is turned on debug flag via "#define LOG_DEBUG"
> > > However this issue is not found on 1GB nor 512MB.
> >
> > I was able to get access to board with 2GB, and it boots successfully.
> > Memory calibration completes, and subsequent test with u-boot "mtest"
> > basic memory test is also passing.
>
> For your 2GB case it is w/o CYCLIC and WDT right?

Correct. Both my 512MB and 2GB are without CYCLIC and WDT.

> For this may I ask what DDR3 speed you used? 400MHz?

Yes, it is 400MHz, at least on the 512MB board.

> For 2GB there are different die configurations 512x16 itself also come wi=
th
> different forms. If possible can you provide the actual die part #?

Unfortunately I don't have physical access (nor schematics) to check that.

> The most puzzling part is this. It only dies on the U-Boot stage.
> The ddr sequence.c was somehow cropped to a point for only size and
> speed for the file comments.
> All boards or cases that even by luck passed the calibration phase on U-B=
oot
> do not have any issue on all stressapptest nor memtester under distro.

I guess I have been lucky then. My only real problem was that
CONFIG_TIMER_COUNTS_DOWN needs to be enabled. And it was quite an
adventure to find that (using git bisect). There are other issues,
such as watchdog kicking in if there are too many printfs(), and also
early uart access is broken.

Ralph
