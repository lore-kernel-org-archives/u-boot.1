Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B57C35FE7
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 05:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E6B88D78;
	Sun, 15 Sep 2024 07:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aaR+mxRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D1A88C7D; Sat, 14 Sep 2024 22:09:05 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B8B88CD1
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 22:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6dc7280e238so436967b3.3
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726344541; x=1726949341; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGNq/5QDOkGOhbzqZdbVwe3Va+H2WaUr6rMehGCglQs=;
 b=aaR+mxRaJpX3M+IssNpSzB2JdS38AOTZLsTMVh9n4cNJUwRBEWN9ZuRT+fZ/xFbDT7
 To4GTKfMkCtZ7IhWiFS+l6W0othxlnx0YawofLrF9s9YZ9EJYIx9KwfkTwH2WcygIv1E
 4OvgMvvlfyoQer2/PWdbOI2n0F4DaQA3mYLJJnzT98rDJHcTGyNuFoabRFUo542OXSXS
 TCZvdnuUL7N3RpyI6Pfq3TEWX/bWOfHUMKeDAvLUPsZadeA09QYsHOoDgvJq0H/QzFxg
 xewPHfcF3lGZYI3vmglM0Sk8AiXxLFMgeK3l3Lr8ZQacX2TJTWOHcMCthkyJzmXLrup1
 fMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726344541; x=1726949341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGNq/5QDOkGOhbzqZdbVwe3Va+H2WaUr6rMehGCglQs=;
 b=mxfUmBLFpGAhb9WliysVoMNeCFCm3y/sQwWD5xpMKW1/LKqCZmQqmfKRWQDpfFNLCI
 Zg5QJ3Gy/AEIbEsOsTLZfslFFv8E014CvQhcw5WA9/zZ3sLbN6IZbBCGboKf7E6ZrreE
 T8A9iknd2xMVum+/Rm153NAeXGfMNc9LrlcPEgvRol/jOOdpZQ1CfpK58yVzBIYu6B70
 fc4Q0TTUmzfSPvUNq/Z5s8052ANVDaWsbIbXkPjSJW59tc/kMaBI+xJqM++ziFYFhFz2
 e/9BU4QIU3CfXgOkjy6yvsHwBlsJ41rX3unxEPwobTWKYv+W0XIW+U59lZs4IuIAehKG
 A4ww==
X-Gm-Message-State: AOJu0YyxMCH+yi6h+SibjImraFFjy2gi+ZDYLR3CK11bsspBk8Vl7bUy
 l9LPppDAaAMsRhT1VC8pNiKQa7vhrfNH65tmCHuzrM7OFdJJQOoamBdexP8BjuHnT8nPd/fLnHR
 Hc4HWbflinZzbe9Do9iA267Q5bW652g==
X-Google-Smtp-Source: AGHT+IFIEPaFFw9NC0i/2pJb8nqx8gc1QOd8eaw2dKBlNo6aJmmPsxye3tobRGTyEfWgbryn8HgBckShIeX9/IBjCvA=
X-Received: by 2002:a05:690c:385:b0:6d3:c7d:5eaa with SMTP id
 00721157ae682-6dbb6b9d317mr40105877b3.8.1726344541253; Sat, 14 Sep 2024
 13:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-2-l.rubusch@gmail.com>
 <960222cf-03dc-4fbb-98b1-1d38f9956636@denx.de>
In-Reply-To: <960222cf-03dc-4fbb-98b1-1d38f9956636@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 14 Sep 2024 22:08:25 +0200
Message-ID: <CAFXKEHYs6=ZfmoOzVOkGq7VJ_sz4vxRSfZJCgveUuWtgPRNCww@mail.gmail.com>
Subject: Re: [PATCH 1/9] doc: board: enclustra: add Enclustra Intel AA1 SoM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 15 Sep 2024 07:28:04 +0200
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

On Fri, Sep 13, 2024 at 1:11=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 9/12/24 8:06 AM, Lothar Rubusch wrote:
> [...]
>
> > +Mercury AA1 Module (Arria1 10)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +
> > +- SoM: https://www.enclustra.com/en/products/system-on-chip-modules/me=
rcury-aa1/
> > +- Carrier board Mercury+ ST1: https://www.enclustra.com/en/products/ba=
se-boards/mercury-st1/
> > +- Carrier board Mercury+ PE1: https://www.enclustra.com/en/products/ba=
se-boards/mercury-pe1-200-300-400/
> > +- Carrier board Mercury+ PE3: https://www.enclustra.com/en/products/ba=
se-boards/mercury-pe3/
> > +
> > +There are slightly different variants of the AA1 SoM, going by the ide=
ntifier.
> > +
> > +- Me-aa1-270-2i2-d11e-nfx3
> > +- Me-aa1-270-3e4-d11e-nfx3
> > +- Me-aa1-480-2i3-d12e-nfx3
> > +
> > +The u-boot setup is specific to a quartus design. Generate handoff fil=
es from
> > +the design. Pass them to a python script to produce a handoff.h file. =
This is
> > +needed as input for building the device-tree for u-boot. Eventually, b=
uilding
> > +the final u-boot depends on the particular Quartus design, the particu=
lar
> > +carrier board, the selected boot media and boot mode.
> > +
> > +Enclustra provides reference design examples which can be built with y=
octo
> > +using their meta-layer.
> > +
> > +- Reference Design AA1 on ST1: https://github.com/enclustra/Mercury_AA=
1_ST1_Reference_Design
> > +- Reference Design AA1 on PE1: https://github.com/enclustra/Mercury_AA=
1_PE1_Reference_Design
> > +- Reference Design AA1 on PE3: https://github.com/enclustra/Mercury_AA=
1_PE3_Reference_Design
> > +- Yocto meta-layer: https://github.com/enclustra/meta-enclustra-socfpg=
a
>
> OpenEmbedded .
>

Ok

> > +Quick Start
> > +-----------
> > +
> > +- Setup and build a Quartus design project
> > +- Obtain the hps.xml file from the Quartus design project
> > +- Generate the handoff.h file for u-boot
> > +- Adjust the device-tree file according to your setup
> > +- Build u-boot
> > +- Flash u-boot
> > +
> > +Build U-Boot
> > +------------
> > +
> > +The Quartus design produces a design specific ``hps.xml``, an ``emif.x=
ml`` and
> > +a corresponding ``id`` file contained in a folder ``handoff``.
>
> s@folder@directory@ on unix systems.
>

Ok

> [...]
>
> > +.. code-block:: bash
> > +
> > +    $ sudo fdisk /dev/sda
> > +        n,p,1,2048,+20M
> > +        t,1,c
> > +        n,p,2,409600,+1M
> > +        t,2,a2
> > +        n,p,3,425984,<REST>
> > +        t,3,83
> > +        w
>
> Have a look at 'sfdisk' tool, scriptable fdisk , that is preferable .
>

Ok, ich changed it using sfdisk

> [...]
>
> > +Boot Media
> > +----------
> > +
> > +Alternative boot media are possible as officially documented by Enclus=
tra.
> > +
> > +* Micro-SD card
> > +* eMMC
> > +* QSPI
> > +
> > +NB: eMMC and QSPI can be flashed from off the u-boot shell. Usually af=
ter
>
> What does 'NB:' stand for ?
>

I'll change this for "Note:"

> > +flashing, the coorect boot mode needs to be set by a BSEL switch. Appr=
oaches
> > +are described consistently in the offical Enclustra documentation acco=
rding to
>
> "official", typo, run the docs through e.g. aspell to catch those typos.
>

Thank you for the review and the hints. I'll apply the changes in the
next version of this set.

> [...]
