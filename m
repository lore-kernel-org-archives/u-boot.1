Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0404DCA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 05:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 339BF8318E;
	Wed, 10 Sep 2025 07:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kodlL76Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 305498319C; Wed, 10 Sep 2025 07:28:39 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93ED0830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 07:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b5229007f31so2472047a12.2
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 22:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1757482115; x=1758086915;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyGm4gozBLXHjLzIatyqccILqmFw3ks6VhZE6W6MgcU=;
 b=kodlL76Qb34LyzNfO3lt8HBcSj5607cWEpRIRJ+5Uy1ugW4jKago91YaU+lpQOsS7V
 YhuYrvJ2WnZeDY+QVx3mcwA4u4PQyr4ofCzF7rOPM65Y9GBF2KEnoIIXCaYGKAehNJEK
 B2RcCm7ki9hqANQwSZdrEuh6QOxiNywDWKqsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757482115; x=1758086915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tyGm4gozBLXHjLzIatyqccILqmFw3ks6VhZE6W6MgcU=;
 b=nmF9ynbeDsHxrZDPOq3lEqRizYf4G6g69Mi8FigdkCN2troOnXuruc+dPK2WH/KMoK
 OHvjl87zewazya2wGYL+P5wcCyRLLIo1xbudQRiHdyrVbucQDHAaTp2Hqxi6yHpIRS3w
 sR5bphpKACZSTvNl/yD/kCIXUFmAUPzX0UDMG8OtQwAkYMnoL68eavoHZ2ZCk0CDUexQ
 iqfJ9cWN5Ebu80u/zkZmxjRJTlo+T5uzBfm5zKzvy6WCgcGOG4gX6akfPsjaScc7FbaK
 BbHNGQPlkQ9rLbu6cs4AKfK3YRmagBRePq3AudjAu2LXOZxgjCKenhKRl/5vZW5VLhl8
 +8/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6xWWNODCppCA1pXP5Ss8+LTr73CJ3Rorze8xhOBzinbCi+n51pqAQlmTTDonYPKj1BhZBohA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2tRos8eBIWLfIZL3ilva/gqj0qYMIS5Ya6Jm1OKKmC0bVM+Be
 Uc//0kr55wglxkhi9an8C82ZVMHj6DykBfta0qREYpT4MPvPYBpNs4bgPEcG4SkAGs6VxSmypLB
 exqLelBJJQDJvkW/S9MmMxJ6pWUMMdFuFW2AxodLn5w==
X-Gm-Gg: ASbGncuycs+UKDxKmoxCpPLfOFPkTvZJTn6PuUXSzU23aphiejSr+kt0JHlhHipPI9g
 dk1++cSZm6x3X2vNFhNF0+oXc0qJioyHLkQ/TikUQR46GTYZi2oaP4Y9sNGHiRgRUo1yj5YcXnb
 b5DKyKsPtiE+hgcLZUvrKlLtwvDrG4G7KRwv5OVlgfxf29VjqtVd48bQ4BjlkTDwPQgeyv+NwEm
 ky2EvaT4qwQHX9X6Q==
X-Google-Smtp-Source: AGHT+IHLQsFXjpAl2Mun/HZT/hIZEkRPtycffygBs7jbYzBXUmnEgrmGyCLVSYIQDrB/yltKmqAvVRXeKZ1FUuDTRbQ=
X-Received: by 2002:a17:902:ef0a:b0:24b:2336:e1c5 with SMTP id
 d9443c01a7336-251734f2ecdmr179384525ad.55.1757482114610; Tue, 09 Sep 2025
 22:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250702092313.970234-1-miquel.raynal@bootlin.com>
 <87a534exwc.fsf@bootlin.com>
 <CAMty3ZDG=MtRbzNPaRs=dz9AUkcTA5cHX+0=wgqyEbMqPhyxrQ@mail.gmail.com>
 <0efa621a-6cc5-4c1b-a5c9-9ab86f84692f@ti.com>
In-Reply-To: <0efa621a-6cc5-4c1b-a5c9-9ab86f84692f@ti.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 10 Sep 2025 07:28:22 +0200
X-Gm-Features: AS18NWBFusAPfER3h10VK9AOkYJVobyQU9uHQ1uxU2uU9SD3Retc_BTR8aldHK0
Message-ID: <CAOf5uwk5gHPkhF1emwpUyp8aDYXhsO-6JQ_x1gicEK4kkajiiw@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: winbond: Make sure w25q{01,
 02}jv behave correctly
To: "Raghavendra, Vignesh" <vigneshr@ti.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Steam Lin <stlin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi all

On Tue, Sep 9, 2025 at 7:08=E2=80=AFPM Raghavendra, Vignesh <vigneshr@ti.co=
m> wrote:
>
>
>
> On 9/9/2025 5:37 PM, Jagan Teki wrote:
> > On Tue, Sep 9, 2025 at 3:43=E2=80=AFPM Miquel Raynal <miquel.raynal@boo=
tlin.com> wrote:
> >>
> >> Hello,
> >>
> >> On 02/07/2025 at 11:23:13 +02, Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote:
> >>
> >>> These chips are internally made of two/four dies with linear addressi=
ng
> >>> capabilities to make it transparent to the user that two/four dies we=
re
> >>> used. There is one drawback however, the read status operation is rac=
y
> >>> as the status bit only gives the active die status and not the status=
 of
> >>> the other die. For commands affecting the two dies, it means if anoth=
er
> >>> command is sent too fast after the first die has returned a valid
> >>> status (deviation can be up to 200us), the chip will get corrupted/in=
 an
> >>> unstable state.
> >>>
> >>> The solution adopted here is to iterate manually over all internal
> >>> dies (which takes about 30us per die) until all are ready. This appro=
ach
> >>> will always be faster than a blind delay which represents the maximum
> >>> deviation, while also being totally safe.
> >>>
> >>> A flash-specific hook for the status register read had to be
> >>> implemented. Testing with the flash_speed benchmark in Linux shown no
> >>> difference with the existing performances (using the regular status r=
ead
> >>> core function).
> >>>
> >>> As the presence of multiple dies is not filled in these chips SFDP
> >>> tables (the table containing the crucial information is optional), we
> >>> need to manually wire the hook.
> >>>
> >>> This change is adapted from Linux.
> >>>
> >>> Link: https://lore.kernel.org/all/20250110-winbond-6-12-rc1-nor-volat=
ile-bit-v3-1-735363f8cc7d@bootlin.com/
> >>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >>
> >> Same question for this one, no feedback for the past 2 months, I'm not
> >> sure who's supposed to take these, Jagan and Vignesh you are marked M:
> >> in maintainers, any chances this can get it?
> >
> > Unfortunately, I was off quite some-time. Need little bit of time.
> > Vighnesh is off for years.
>
> Thats not true. I dont have access to U-Boot SPI trees. So patches have
> been flowing through individual "platfor/SoC" maintainers trees
> unfortunately. Tom picks the patches from TI contributors once
> me/Nishanth Acks where as AMD/Xlinix bits have been picked up by Michal
> Simek and so on...
>
> Happy to help out if you help to manage a merge window every now and
> then or just review things. Most of the SPI NOR/NAND follow from linux
> where its reviewed by set of maintainers and tested (example this one is
> tested on TI board).

I will go through the patches over the weekend and review them. I will
prepare a branch
spi-nor-next and try to ask to test from there

Michael

>
> > In the meantime, Michael will help in
> > review but need help on testing.
> >
> > Thanks,
> > Jagan.
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
