Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD97C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 296DC8120E;
	Wed, 29 Jul 2026 13:49:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cY3np64bXnwb; Wed, 29 Jul 2026 13:49:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9F22811E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332986;
	bh=qeWt5EUQpDLr2smPQC42RiwR1EsMQfnARJcgfbGvhk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lVFP2XKLTBpl02ueUaWWKQQvDLR1WbuMtVJslizg5lsiV6BlvjFSkri+GIpwa3dz7
	 NSF4i+U4p9WLe+iWMUU/rnv/uRbIjVBkl7Ii+lXryLeSulmE+kg21yIxFqpSh3H9eK
	 LEiS8QVtDxQbLsMHrMjv7ccesmHgVTQzReR/OQg4USwFvrsdC1XvKoiaT9a9kdD+On
	 upimEGZXforFGaXuKTcZI7x3la3lxN1pbp3FAn1xCax1LCSjYf/a/m/nFRWEwhVX2T
	 BIyQ6IY7WNvAmgj5WWTSneFiThHV0HAiIItc/8EWdlaMxLMa76o1e4+MvcG+FlUs1H
	 1m3xzQu6qHPxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9F22811E2;
	Wed, 29 Jul 2026 13:49:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 582E5788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4345C60AD4
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BRIw9toOwdRH for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:49:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CEE6160B0F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEE6160B0F
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEE6160B0F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:49:40 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-39c86945164so7127451fa.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332978; cv=none;
 d=google.com; s=arc-20260327;
 b=HZB9KvBt/ugfrxYIt1oM17PIdiV3QI1punj4G63UzcVY1XCooQA/LecgsxFG6EaGTw
 BZ4PUyZRuOPMuiaO/HI9bxFC07x5b9qeuzyIv1jznnCs7Xx5cTd855WuPGKYTWezNzP/
 b98jQlVZQK0XlvTB3uGzrKO0Q0hdr5BO0EgWYCX/pckQsx1fIcaBrxetBCe9ub1TYqzp
 0YOF25Op9PunmK3xJ2uA5COLTyVJXfk8sa0AN5XHZ5k83RvrtN4rmNLLL9o58qVa/mB5
 4ysEDaSNINqOpzrAPia+WlZb0S2RCcIYktX8rg2u3cBvPDhNSMtqZpdmyZkAVTPnBLdb
 qjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qeWt5EUQpDLr2smPQC42RiwR1EsMQfnARJcgfbGvhk0=;
 fh=+YGUQGdlQdw4Oal7ArawebLkDslVyjTbsjXJamrr2Kc=;
 b=E0qIY0icE6yZKV/L1h61y2ACx3C7zl2qCDuudGK2tBQKBlMXecZoDzGtLTWdPBr+p3
 pjCLX7oKiyvNYdUFLqPfHfGQk5TvYpaoSO3QfFMZd4hj6xrGJpS0fl4UpmJni+oBLgvC
 rlc3A6Jeqe1af56fa32Z1tmw7kWo/uQF0I9giJOvCEluukJSFek8RhYo/OdcyncyrcO9
 ehH1cgocnbRZN9JV8WfXVbGRKF0yYA94bZ5/7+bBT7ZlKQfilqDuL93QbV96sUImgBm6
 wuhsuADP7IWtOffc5KXot/Lc/Tzou9HWa2wfDzcHqzh6HUjYnIIpxKE+7oyOhMKXO4BV
 g9jw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332978; x=1785937778;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qeWt5EUQpDLr2smPQC42RiwR1EsMQfnARJcgfbGvhk0=;
 b=qtCj4IWv2rfuan5fAbNmSq3sXOxygB/cOGDfFxWN8B7Yax6KTos5mCNlZNZMv6H+3f
 OE/GMQvTSyfxtywTMT2vi5yIaFBeL6JpcYeb7EaAmKSFH06GMYnvuYnfPEyvhKuxOfQZ
 5PqexttAdvwj7tj9KD3HXBJCKHt1fuNAeDvIv8Ig8sU6WfxqKnzYQ2J5FKSC5oXJZ3Rf
 fsQeD+lkxak3fv8nShvojyMQ6RwUNaXP64IZQbTBXTE2GT/1He1jxWJ74T4fxsPQIGJ6
 M/dPSKFT2FC477taH6Rqf9D4eCnjgFmTlVS8Vpspki5Bwh43K4Ghs7DYB6gm+ak3j+La
 F0fw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbSPuEvyK6CpcTZ8EQWRYO7w0HZ22blZ012QVahsCCaBgBl3bSrmmzBvIxdb0fdzEtWW2mrK0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwpYaHH5elNq7CD1P2So272xxUafssVOaJM2YcCTo2DFj0sjNqM
 Fun+5KvjFyZlijixF2XTgy8xHLJ8ztBEnAUYgY4r6CmMsMvAePpEe1V3yPFoXBqF6mPBOtRgUFq
 995j+HhRBQXifNRNHGoEgId2L7O+TX+fpb7mJvAFZjg==
X-Gm-Gg: AR+sD117wllycZT81OXMEu0V3bYQQ/iZQFgWIHSN8m4L49UPVqO+u2LJsnW7mJGeCmz
 rb3ti5FiVCodWIaw55sPpwxSJ6tQ59FRb2MtolLqPetnlT+L1O3z40EFi1tVVLxOOBBYrhhWLz6
 YqIrnmbePus276Pp37KaSqYP/wbVSGjIVzz0vaGF6N82/XOkghsOiVcsSpi3N7x3EfZw+QyYGzg
 NqHZ5z3kUZ8CqJlfYDDHANbnGFFCgwMUDGkkcBgJ0j1QwWev9diqc38N++vMuyxxR0z9H7NK4Jr
 chEIGwC/mQ+jHjGZ/y6f8kqnmH/EN7arqwMpt06nN6W8rxMwRW78EJmwi78BZzNEJiXLO0Ch7nX
 m0cMO541x24UYHV+I8v5DuDA3qCahjPt0B0YAk1+lVrorwUlnu0wAPMqI7uAkvIovvXBFCcZ9FC
 HQ9g==
X-Received: by 2002:a05:651c:1602:b0:39c:64f5:b91d with SMTP id
 38308e7fff4ca-39f51ee7746mr13748831fa.38.1785332978126; Wed, 29 Jul 2026
 06:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-9-2f58566d48ca@riscstar.com> <ameUvEoCHjeygBEd@pie>
 <CAH22mJy8_gd2V_DFUT0DQYiBSO6B3u5aX-V=uD20v0G+m1cArw@mail.gmail.com>
 <amh6JjTtUhi57H-b@pie>
In-Reply-To: <amh6JjTtUhi57H-b@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 21:49:26 +0800
X-Gm-Features: AUfX_mzNk6UbKMDkdQpk7MJ2Gs2cV8ofR8okpABpGmAtZrFfNIyJxXyWShjkxyo
Message-ID: <CAH22mJwL+Op+99iBTePTkdGfArRy_inFRXm=DJjG-jJ=sYEi2g@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] doc: spacemit: flash on K1 SoC based boards
To: Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785332978; x=1785937778;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qeWt5EUQpDLr2smPQC42RiwR1EsMQfnARJcgfbGvhk0=;
 b=JXiG6uDmGQ0soOmOGmFH3TshrJwm9Z5sv+hZWhEfyzM1LK8/uHwLYIXChVvdGeDa8+
 Ash9NgORqkHoTYnOCY5Mph6qSGHywJWOvwPsUUJGxD6WRJ6GCZVh82SGRy6e1rnRNOZm
 AIS99wC9LbuPKJ08IAlfT7fLlaxfLVGcz7vjKBZDUnWABQvcYWYj7TklO1w/muNBEq/O
 cCE/f26vHpoWwqsY4lv88shT7IfKE+3eks2QWTLgxph6QbGmZFPL4cg1hTT6Bf3HPSOk
 r3xDj5uBw7n/Gx+0SUYuyCaQ2RFpxnjfluVKEWKM0QRicBI7e2nen3xHZV8vTghhVKrF
 J4Qw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=JXiG6uDm
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, Jul 28, 2026 at 5:45=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Tue, Jul 28, 2026 at 08:53:02AM +0800, Eric Chung wrote:
> > On Tue, Jul 28, 2026 at 1:26=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
> > >
> > > On Mon, Jul 27, 2026 at 02:59:11PM +0800, Eric Chung wrote:
> > > > Add document on how to flash images into eMMC of K1 SoC based board=
s.
> > > >
> > > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > > >
> > > > ---
> > > > v3:
> > > > - Add document on how to flash images into SD card.
> > > > ---
> > > >  board/spacemit/k1/MAINTAINERS |   2 +-
> > > >  doc/board/spacemit/index.rst  |   1 +
> > > >  doc/board/spacemit/k1-mmc.rst | 320 ++++++++++++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 322 insertions(+), 1 deletion(-)
> > >
> > > ...
> > >
> > > > diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-=
mmc.rst
> > > > new file mode 100644
> > > > index 00000000000..b0fe78c75ce
> > > > --- /dev/null
> > > > +++ b/doc/board/spacemit/k1-mmc.rst
> > > > @@ -0,0 +1,320 @@
> > >
> > > ...
> > >
> > > > +Chapter 2: SD Card Boot
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > > +
> > > > +
> > > > +SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +This guide explains how to prepare a bootable SD card with Bianbu =
OS for
> > > > +SpacemiT K1 based boards and how to replace the U-Boot binary on t=
he SD
> > > > +card with a custom build.
> > > > +
> > > > +Prerequisites
> > > > +~~~~~~~~~~~~~
> > > > +
> > > > +- A SpacemiT K1 based development board
> > > > +- A microSD card (at least 8 GB capacity recommended)
> > > > +- A card reader for your host computer
> > > > +- A Linux host system (for ``dd``, ``fdisk``, ``lsblk`` commands)
> > > > +- The Bianbu SD card image from
> > > > +   <https://spacemit.com/community/resources-download/Images%20Col=
lects/K1/Bianbu>
> > > > +- A custom ``u-boot.itb`` file (device tree blob or U-Boot FIT ima=
ge) to be
> > > > +  written to the U-Boot partition
> > > > +
> > > > +Prepare the SD Card & the image
> > > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > +
> > > > +**1. Download the image**
> > > > +
> > > > +Download the released package from the official SpacemiT website:
> > > > +
> > > > +<https://archive.spacemit.com/image/k1/version/bianbu/v2.3.5/Bianb=
u-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip>
> > > > +
> > > > +**2. Extract the image**
> > > > +
> > > > +.. code-block:: console
> > > > +
> > > > +   $ unzip Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip
> > > > +
> > > > +**3. Identify the SD card device**
> > > > +
> > > > +Insert the microSD card into your card reader, then run:
> > > > +
> > > > +.. code-block:: console
> > > > +
> > > > +   $ lsblk
> > > > +
> > > > +Compare the output before and after inserting the card to identify
> > > > +the new device. It will typically appear as ``/dev/sdb``, ``/dev/s=
dc``,
> > > > +or ``/dev/mmcblk0``.
> > > > +
> > > > +**4. Write the image to the SD card**
> > > > +
> > > > +.. code-block:: console
> > > > +
> > > > +   $ sudo dd if=3D./Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942=
.img of=3D/dev/sdb bs=3D1M status=3Dprogress
> > > > +
> > > > +The SD card is now ready as a bootable Bianbu system disk.
> > >
> > > This looks out of scope of describing how to create a bootable SD car=
d
> > > with U-Boot. In my opinion, you'd better describe the requirements of
> > > parition layout and image position for SD-card booting, to allow read=
ers
> > > to create their own images/bootable medium from scratch more easily,
> > > instead of sticking to the vendored image.
> > >
> >
> > Creating a bootable SD card from scratch would be valuable, but I'll ad=
dress
> > it later due to time constraints.
>
> In case I didn't make myself clear enough, the documentation *SHOULD*
> describe how to create bootable devices from scratch, instead of
> alternating an existing OS image to use mainline U-Boot. I don't think
> the current documentation helps much for downstream users/distributions
> to adapt U-Boot for their own use cases, or at least it could be written
> in a much more clear, vendor-neutral way.
>
> So here's my NAK for this patch. I'm not sure what you mean by "time
> constraints", but please keep submitted patches in a good shape.
>

I=E2=80=99m not sure why the documentation insists on walking users through=
 creating a
bootable SD card from scratch, especially when, at this stage, it
still depends on
the vendor=E2=80=99s tools. In practice, we=E2=80=99re required to use the =
vendor=E2=80=99s
flashing tool for
both eMMC and SD devices, and we must adhere to the provided partition tabl=
e.

If users prefer to define their own partition layout, nothing prevents
them from doing
so on their own. That=E2=80=99s entirely up to them.

The default SD image already includes the vendor=E2=80=99s U-Boot. My
instructions simply
explain how to replace it with the upstream version=E2=80=94nothing more.
