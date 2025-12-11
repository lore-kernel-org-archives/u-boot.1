Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B69D41C24
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 19:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEEC800B1;
	Thu, 11 Dec 2025 20:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LU8v2/x0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AED5808AF; Thu, 11 Dec 2025 20:15:08 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29FF800AD
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 20:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c7660192b0so289002a34.0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765480504; x=1766085304; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+c/5Ckg2bevwdOSM1fp0BY6wEI3P6ZfVBWLYKh4A5ho=;
 b=LU8v2/x0gcRLPQnh+X2Cw0XyrAlN2lneiedLAcOyFjHU7EUIdJaWooyRM+ZV5SMbyk
 tYTE9AYAI4c1jjeXshzOmnzC+w+vRiZPD4qAkf2IGWY+n62bwDMZ5Zy+dTezTF/e4ThQ
 JqpIms8PUqJtntgQ78C+LoPV/ExwONOYkhMg/qrNx8pCleRCFssQiGm3Sgj5Z/3L/unr
 b/1nf2UhNts7O8Gx22XxDre7z7p2Nhsc4zoCQbNcasqxz2VYKBWKh/5DwyCMNu1S8myx
 Tp8EyLHgDlVYFgwEo5iihUkqKhDig66c1B1RC30N9qBWr9da5W2ZcNidqno0vITOc64J
 XH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765480504; x=1766085304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+c/5Ckg2bevwdOSM1fp0BY6wEI3P6ZfVBWLYKh4A5ho=;
 b=H4KxMtW2PhQjmEQvSsL3GEfG3HSgCmWx16eq4L2Mr6MglJUDaZ055XvhBNe0nU6uMH
 YI2QkQN340St5qaywp/JxNU9GLBw3OXeLG0l5cMiHYSvvhBHbpF0y6PeErZaFz7w0wB5
 cvSd6vFvLOZQarBZjWF98DvFkd+Fe/4+dJEWSgf8625nW93N+XFud5n+Iasw26megWA4
 9CVs1STc8htSJvu0NxznTm/0VsDrIGFsRz8Wf+08DuvPFFqS/qioYL+H3FNipCdiz9DU
 okFHsYbTCkFRvB0yWgMh9pPpqeEG/n0a/GCG7VdWaUgcAoy/SV9vSkWn4hYp8AZg2r9p
 pjQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6qGHi0S4WoaTiS1kH6+jGuHZg0zaockU+nuPcJx3fRtmyivaLxFjNE5kkJ54hbdnNMxGUDF0=@lists.denx.de
X-Gm-Message-State: AOJu0YwXlXbOb1tCSkx60dKacSAeFXReSWnSrr2rhXcgwhxeSsZ+G6J6
 3sAjy+7drtnchJjScnCE+NWltvoevp3R6cjqho6MR/Bl37BkWAyvqROyEpNhO1TuiBPgy3xxVon
 VLgjLwEIMSL3qyNlySDOWn/0pQdGlqPQ=
X-Gm-Gg: AY/fxX7xFKLwe/sBmCxB4ac5cKPCLZ0zYcxBgzgTJmE1GeBdYhoZ+DXDz9nhqFKLR3+
 GBV+vQ2OK+Gl3o6e4lqFR2APbJDUvOlXxZtmfx/d/6pK/WBvFNn1vuxB2tt5Eh8IK6DzAklahzA
 CNxau+r+fxHm9A31iVDQZ+CXeTqM6wO0oXFnJZvmVfFJW6PhQuurWfLgpE5FxtgV6kvdyXQMaP2
 IJvogqq7nZUFWT1PD9DlafdtB5UhKCDpcgvKdQyRRjfSVt7VkOMZHwx56Mnb2kL3FpQ+Ds=
X-Google-Smtp-Source: AGHT+IFzhd/5djjvSZgJiB2fTZcAS+7FMuvrNSa7kCht2Jqk1kG+weDLRrYNalik1GVmFJRUF1iiaVckn2uHrc14Nkg=
X-Received: by 2002:a05:6830:211b:b0:7c6:8bfe:f5e with SMTP id
 46e09a7af769-7cacec462f4mr5005014a34.32.1765480504234; Thu, 11 Dec 2025
 11:15:04 -0800 (PST)
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
In-Reply-To: <CANp-EDb+Txnrb15KuXBof6PMZp02WZ1MOy-LkrGoW-OLE8mWCA@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 12 Dec 2025 03:14:52 +0800
X-Gm-Features: AQt7F2or9UvM0WNYTm7vebPpCBY8iKR3LfFiByF_0e2H5681iTEH56vF4D-XYKI
Message-ID: <CAN7C2SA=X3Pk9ehcVWDcugUzJ2wD-8ooeA6-=zGnVa-4nQ11Mw@mail.gmail.com>
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

On Fri, Dec 12, 2025 at 1:36=E2=80=AFAM Ralph Siemsen <ralph.siemsen@linaro=
.org> wrote:
>
> Hi Brian,
>
> On Thu, Dec 4, 2025 at 1:09=E2=80=AFPM Sune Brian <briansune@gmail.com> w=
rote:
>
> > If possible I would like to check if this is aligned disregarded to DRA=
M size.
> > On U-Boot latest or after 2025.07.
>
> Sorry for the delay. I am testing on 2025.10 version with a few
> additional changes. It is a custom board using its own Quartus memory
> parameters (which have been unchanged in many years).
>
> > Issue 1:
> > sequencer.c if turned on debug by including this at the very top.
> > "#define LOG_DEBUG" and "#define DLEVEL 1 or 2"
> > If will stall somehow on any brand of board my side current had.
>
> I also encountered this, but it was solved by disable the watchdog, by
> toggling L4WD0 reset. After doing this, there is no problem with using
> DLEVEL 2. I even took it a step further and logged every single write
> to the DDR control registers.

For issue 1 it is just a debug issue but I could also try a bit of your met=
hod.
Didn't deeply investigate this.

>
> > Issue 2:
> > For DRAM size larger than 1GB, when w/o O.C. and using as stable
> > setting as possible.
> > Even it passed the calibration it will not cont'd boot when
> > sdram_gen5.c is turned on debug flag via "#define LOG_DEBUG"
> > However this issue is not found on 1GB nor 512MB.
>
> I was able to get access to board with 2GB, and it boots successfully.
> Memory calibration completes, and subsequent test with u-boot "mtest"
> basic memory test is also passing.

For your 2GB case it is w/o CYCLIC and WDT right?
For this may I ask what DDR3 speed you used? 400MHz?
For 2GB there are different die configurations 512x16 itself also come with
different forms. If possible can you provide the actual die part #?

For the latest test result.
1) all boards can run properly w/o watchdog or cyclic but only works on
400M on any size from 512M to 2G.
2) For die itself it is shown that twice die performs much more stably.
3) The DDR calibration itself is so touchy on time and opening CYCLIC or
WDT highly improves the bootup stability on all timing bins.

>
> I'm also running memtester on my 512MB board and it hasn't found any
> issues after a few hours runtime.
>

The most puzzling part is this. It only dies on the U-Boot stage.
The ddr sequence.c was somehow cropped to a point for only size and
speed for the file comments.
All boards or cases that even by luck passed the calibration phase on U-Boo=
t
do not have any issue on all stressapptest nor memtester under distro.

> Regards,
> Ralph
