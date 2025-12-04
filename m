Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFA9D2445E
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 18:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D428410C;
	Thu,  4 Dec 2025 19:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VERgeIRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AACF58412C; Thu,  4 Dec 2025 19:09:20 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2BD1840FB
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 19:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c7660192b0so1098747a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 10:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764871742; x=1765476542; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tL1HHcrelisV9/Kp3h2Ha4nMVvmfLJ5djDr4g/Hb6x8=;
 b=VERgeIRl6U5vbrgSTjKl0X6olPXOoS251IskTgxU1muiFkx0yWDKAhFH/8HJ7W3RAh
 HiHz13Ku9Efplw3d+q1Qr9rX4qVb9rQDryS9o9jTb7qKfnlXlF4ZbgexocW36N49jjSf
 jAI/PhpsgmRYoyjhkF2Uu6HVro8b71XBuqV/4XxJV1r3I0ODK+nUAIk66TnrD6t4vrju
 EhWWiVxs1yY/mWm95jAZYLzwW3wBlOXBd4hPtArEDO16zkbqGFrg4X1YD1qw++V19oqJ
 ka4T0iDqlhtClVnMJDkf+VpHrdjt2r6pd1Yr7KWdFyLWC/EtJVjr1VE9YnZJBlM0+NaC
 ZSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764871742; x=1765476542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tL1HHcrelisV9/Kp3h2Ha4nMVvmfLJ5djDr4g/Hb6x8=;
 b=N5mUNTKzC1mIMSt14j1b4g+Ub6G8WYBN12Mj6TB2pJQ4DqnGvIWQRrhguAakaN28pA
 2gwWSENbWQYW98ixsoTcOW8+u/QPwrbHbdkcw+5FuBpjbOhG9FzR/aQbbt0vaw/rpYyi
 oBcR2DRHOj7Q+ozBN8IS/1FUVafto3ILt96WQ9wujev8PCzMGjJv65iVHW+RcYd1pgV8
 IVJ4vpKGySz1SxxoCcWuzSQNWsj0Mlq+JyB9hTM9P4qo8lAPEVYNFBeHP/r2oVwmKlB+
 NxrBBTe1wJKoO2faLBNK5Y019YP0D2cetQKSXM4wARXib4P4szy7NR7UF+S14K5+nJyN
 w74w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTm30VmgNZO41259LLp0lIvFQOAsPkCXu6pc4QdC6L7xSOLpWcCy/hb63Yg9enoXeckiBSMTs=@lists.denx.de
X-Gm-Message-State: AOJu0YyforVgwB+LeWD+iEErVmyTjlM4BR6n0B47AjQCkeBqev7MvmyO
 1YE7hzb3D5lA0wikhvDH91oaxnppZXTIxQIi2L34rDHxIeEEAm8D+0Zj5hwM1Qd5Tx+5u9047RE
 5aNxiFCteoOYaU1zhYFdm3MbLgb4wZGg=
X-Gm-Gg: ASbGncvVqBhGbBCsHy38L4OZ1IEE9G3NaBbgwDR6HLi8hQuwm2I0Cr/ROTKbysJgRG2
 Ze6MzVu0hBn/Mkflld3ZixIiW+uNE9xybvymkbUiFpcmxvMA+SfEAfwPzdwnDhFkBJkAvEiQNdQ
 JMsvE9q+B8kn4WAW+57F3Xrhn2yo5WjYQ8H9EMhRnx0sZscbmPX268M06vecD7/cIzqF/NXAlex
 q8yP0JxrZlBBWDu4RAamEOc6IbIvQpAoGIy/btCftJxGVDYo3brmYXdEfQXu72Kly88Twum
X-Google-Smtp-Source: AGHT+IGgY/rSHJnC7H80Uxqdlf4eIurSeFF+GMmwGy9Ch0cKow/SZUD7/lFQ/wwDMIwz0hBP913RNI6eZ5+Htxy0WV8=
X-Received: by 2002:a05:6830:7182:b0:7c6:a62d:8663 with SMTP id
 46e09a7af769-7c94da3aa9cmr6186180a34.11.1764871742304; Thu, 04 Dec 2025
 10:09:02 -0800 (PST)
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
In-Reply-To: <CAN7C2SBop5h9WtF2GLRkWeNmLpBcDC5dHUmmR=WzRXTpr6-7VQ@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 5 Dec 2025 02:08:51 +0800
X-Gm-Features: AWmQ_bmfjgYCpDXxBsK3nlfkYIJ98CLtVP-11e83ye_GYIfAnqmgBN8E8II4nOs
Message-ID: <CAN7C2SC7nfpDmQXjfJyZDw5m6HnfbSed+w_JNsS7+x2s190Huw@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Ralph Siemsen <ralph.siemsen@linaro.org>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
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

Hi Tom,

Tom please reject his patch, thank you.

Hi Alif, and Ralph,

As you both had undergo a board test.
First sorry for cont'd bothering both of you.

If possible I would like to check if this is aligned disregarded to DRAM si=
ze.
On U-Boot latest or after 2025.07.

Issue 1:
sequencer.c if turned on debug by including this at the very top.
"#define LOG_DEBUG" and "#define DLEVEL 1 or 2"
If will stall somehow on any brand of board my side current had.

Issue 2:
For DRAM size larger than 1GB, when w/o O.C. and using as stable
setting as possible.
Even it passed the calibration it will not cont'd boot when
sdram_gen5.c is turned on debug flag via "#define LOG_DEBUG"
However this issue is not found on 1GB nor 512MB.

Finding 1:
This is very puzzling and completely lost control on what possible cause.
If SDRAM fails same WDT or CYCLIC simply bypassed it.
Aka 533MHz DRAM speed then it is a must to discover bitflip or any issue
under distro test tools "memtester" or "stressapptest" on long sanity test.
However neither of those return issue since the board used for development.

Finding 2
So long story short WDT or CYCLIC is not a solution to fix SDRAM
calibration fail.

Thanks,
Brian

> > On Wed, Dec 3, 2025 at 3:52=E2=80=AFPM Ralph Siemsen <ralph.siemsen@lin=
aro.org> wrote:
> > > Then it sounds like it is a recent issue... hmm... I'm currently on
> > > 2025.10 release version (plus some cherry-picks). I'll give a try on
> > > master/next once I get some other things stabilised...
> >
> > Just a quick note to say that master branch (with Jan's v2 patches) is
> > working fine for me. The calibration is passing on both cold/warm
> > reboot, as well as power cycling (I tried a few dozen times each).
> > Note that my board only has 512 MB.
>
> Thank you. Yet, no confirmation on 2GB situation. For 1G or 512M
> I can also repeat normal boot on different brand.
> Which for 512x16 ddr3 die can have several construction from the beginnin=
g.
> But the question still holds "WHY" CYCLIC or WDT can trigger a normal boo=
t?
> Cannot explain nor trace.
>
> Brian
>
> >
> > Regards,
> > Ralph
