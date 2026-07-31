Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDBCC55165
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 00:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86BD7606E5;
	Fri, 31 Jul 2026 00:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXYX5ht9rcV1; Fri, 31 Jul 2026 00:31:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BF986068C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785457899;
	bh=lgBW7YevUYwreDboHUVCvpTplwzE8oAzpILaiOMouiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xEWnwxNH7ZmatqICWvmaNLqUnXskDc1N0o2x5ZSoqozUkBNtDtJgm1IEsLYwW/879
	 uqIj+YD7AHPxoz5kemf6KXgnXN2h/Ee6fr+QfvSaWGLmXq0vMcjTy9tIwzdYUm+LqN
	 dejdPtwQw5tbgJg2luVjjn9vn2eTI3jt9ciRppP9532DOAgnNkauJsF2OwOJqVLWcb
	 XCkI0v095rNVlAEIVakvb/vjdenUuHr1haXm+WRisFUARqHSyAujmr4SwMqMmGiFbN
	 JAxQUi/a6lYeUbRV5Zz8XUQSOuRw/eQ15GxxQ3EitwKh7eTlqyYeo67iMzWIpTpfIJ
	 C1tnMWM9IploQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BF986068C;
	Fri, 31 Jul 2026 00:31:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B7EE218
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20A9540E48
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:31:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A0YG1QNsXPoe for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 00:31:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 45B4840C1F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45B4840C1F
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45B4840C1F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:31:34 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39c9bb9d2fbso3939231fa.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785457892; cv=none;
 d=google.com; s=arc-20260327;
 b=lO9LjX5Y/kosHN9ubxIPNbJPSNdTdN9J7FLaZXa89Z37b85Qm9a6ectR+8HCEkAr/I
 AFp4/MoQOXJA5GtPn1CXpQNoaE4SOUVJLR2u9EpMC/uFuC8+dnb0Yd+rx178aH2UhVtU
 DFL5pwsbqkpYVToMrzvuAIIetCDuLx4wmLuzo2RxJgEbDlAHlIHCHjSbKQWepJR2hJ0k
 awwUge7oCDGl3sG/a31YLeD4KL38QyOCdItFvL83YfgE1jFGEuptqTJ0N/hcAVdXNXzd
 nVeIwKVucOcJsci7ekkEFwIe5L+JhOIxZ6dy6Cf0+6yYoFAJVOsB1V/LO6LXvpD3M8TC
 VbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lgBW7YevUYwreDboHUVCvpTplwzE8oAzpILaiOMouiY=;
 fh=X7GaGBmrkqcYmHy+Bv8N5LcLLVSUYcz5OIhcfWfMeVM=;
 b=aR3sEljZExCxJV70fzhaU4HEd7XmNS23n6RUwobZtCfa2RMh5Edi+blt4ca7BRecIo
 fuR9lrPnxtlw82/F5WNpagPo/O3sH1Cfi+cgbS3iNs76fKkjVGFKTlkYADisOAsyT5hV
 ih881QoapDdyLl00K6wlZW4qQzZuwIKmlTx/b8O/j3eCi+r/OXXBNF0lWRmg8yHpHSbS
 IJxd89iXw6FvF5cw8VWdD1w5VJKrZSiBNHP5pBMj7QXVknnom4Zhi61Ornxot5MyT2rY
 GGUg1iHAWVC/TjKQ25bjg7idGU4bSJKF4ztqQ5PoAEdtG4G+PEN6uxJAdeCSZRlJyrCb
 fj/g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785457892; x=1786062692;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lgBW7YevUYwreDboHUVCvpTplwzE8oAzpILaiOMouiY=;
 b=RQSsGa0bpCblYt36qevMVQKWqyzD+W8SShRjiy+uQWii7riev1cEc5ePEO4djUosZa
 s561QlEG95J17U2sMDv/W9e1Ts5b/bdKWPTweJMEqxEfoByHmJBzTgzRm6M0pbUUlSf+
 D2Mw4hM9mKTzTY61fhKnHA2Ef0njUqtfAtYdJElG1lqiSs9XO539/tov/LJmKv6bGrYv
 x7wzZcAz6ibGzWfN96OMmNIEs/LFuCQLJev+2tguCBhz5b/QKaE+uND1/rxE6je/sxJh
 8sDVhjoyRvRFgRpkPuIgbwpctSChH7sM12V+KiGS/OcKDEtznseGQFt4GLTfQ7shuDj5
 QE0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrNZSJ+6pKEnROo9o+VB6+q4fO/U75BcXN5CPdEVTVwgDvYVbCF8h5IjR/soUEoXuyZjPAIpE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxawj9+La98kS/ssvTXYQYRErnKxZmsh+NxktQaBl+RcBDf0Cjd
 c3UyGxsPMsP60SAwHa6gQRHctO2pphv3+nX3FMn5sq8kder7seq3ZxEWaP90lh1qzeBtS2CDu/V
 iWtQivRP9Cqv077EJKwTsUqwBxxFKOFv4DvCuj/ocWw==
X-Gm-Gg: AR+sD12lYVJuxec+bWMD7VJQmLNHyz+K1VfAn0ybF/odRo5vbn+PyPT2bFFDwRktcVp
 9mKTvlv/JuhRIblhqdsA35NDoh0K5Y4IVlNAyEjsVuA36kipiPiAPFag6gi56oy4veLYH+InD/x
 JjJIxXm80tnILsb8F1g88OUjwAB+XlHM64yBsDHYd4u1J9Z3z/b3fk+WvsgAOs+OQYPHHkTgsy3
 zyOjF8MlcPM/mxaA9hQlDNBdDn36BZWjnV7EvIYqdaveEyZZOCxG6iIHVwysaw1QuYyKg+szcOw
 3XMXjM0C9iymqy855ahyaBjsccE2A01hdj7wCbe+dPBXOA1cVcDNrF64fYYFp7xaKbVVdu7n0jw
 VS/6tZIb2FOEIyqTyRvEdW4jImAoanJy7xqaVmYUA88jOBU5UxqJEINBlqUxmL++oajX1Yollnb
 2amw==
X-Received: by 2002:a2e:be9e:0:b0:39b:128e:ae68 with SMTP id
 38308e7fff4ca-39f7e21ecd0mr53301fa.0.1785457891177; Thu, 30 Jul 2026 17:31:31
 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-9-2f58566d48ca@riscstar.com> <ameUvEoCHjeygBEd@pie>
 <CAH22mJy8_gd2V_DFUT0DQYiBSO6B3u5aX-V=uD20v0G+m1cArw@mail.gmail.com>
 <amh6JjTtUhi57H-b@pie>
 <CAH22mJwL+Op+99iBTePTkdGfArRy_inFRXm=DJjG-jJ=sYEi2g@mail.gmail.com>
 <amoc8umyQwc6UmXl@pie>
 <CAH22mJzjH2d6bd+HQhhkCiOYSr9cqYFZDCpB7zECaFPMZHBdVQ@mail.gmail.com>
 <amtr1G8oFZ9J64Uo@pie>
In-Reply-To: <amtr1G8oFZ9J64Uo@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Fri, 31 Jul 2026 08:31:19 +0800
X-Gm-Features: AUfX_mzTaxuLNmW4mcp3CYMHZBfcoOO0LhB42eZUCiqkaBUMeqKHjTtIAr7fyAY
Message-ID: <CAH22mJzdj2zX2nXc9u75_SbYqdcM+jLNG0Q7+mrvnn+2XDRCFg@mail.gmail.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785457892; x=1786062692;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lgBW7YevUYwreDboHUVCvpTplwzE8oAzpILaiOMouiY=;
 b=IGNKaC73yxxpOVqmJwWnpPW/2d5+zTpO9bL3YHb1JRVHkwyx+M/qN2ss8BfZb+N4Zb
 jZG/Sx+thBB64NheM7w3uJBJderlEo2/FXK8HXvfP4brQXWEkx6b/0RyZRtT3fy3x3k8
 6Df8hTF+VQY5+umFIWV+kIKy7R0Qz2qXWGR0Nb6rLVRZ7HyouIbUrAQ9GAtfTPA8YwMv
 pGQpf9QX5yHRSy5SvKNhqMiSEXUSfRew8YVlH3WgJQhd0w52lPvjsMY3zgn0EbPXJYwF
 qVfh5oGyhP2qx3zZ4ldawHR0R4cd0wkMQhnN01prZFplPrStRKWdGGDHdAFPIibMShAa
 XKhA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=IGNKaC73
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

On Thu, Jul 30, 2026 at 11:22=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Thu, Jul 30, 2026 at 02:25:31PM +0800, Eric Chung wrote:
> > On Wed, Jul 29, 2026 at 11:33=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
> > >
> > > On Wed, Jul 29, 2026 at 09:49:26PM +0800, Eric Chung wrote:
> > > > On Tue, Jul 28, 2026 at 5:45=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
> > > > >
> > > > > On Tue, Jul 28, 2026 at 08:53:02AM +0800, Eric Chung wrote:
> > > > > > On Tue, Jul 28, 2026 at 1:26=E2=80=AFAM Yao Zi <me@ziyao.cc> wr=
ote:
> > > > > > >
> > > > > > > On Mon, Jul 27, 2026 at 02:59:11PM +0800, Eric Chung wrote:
> > > > > > > > Add document on how to flash images into eMMC of K1 SoC bas=
ed boards.
> > > > > > > >
> > > > > > > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > > > > > > >
> > > > > > > > ---
> > > > > > > > v3:
> > > > > > > > - Add document on how to flash images into SD card.
> > > > > > > > ---
> > > > > > > >  board/spacemit/k1/MAINTAINERS |   2 +-
> > > > > > > >  doc/board/spacemit/index.rst  |   1 +
> > > > > > > >  doc/board/spacemit/k1-mmc.rst | 320 ++++++++++++++++++++++=
++++++++++++++++++++
> > > > > > > >  3 files changed, 322 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spac=
emit/k1-mmc.rst
> > > > > > > > new file mode 100644
> > > > > > > > index 00000000000..b0fe78c75ce
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/doc/board/spacemit/k1-mmc.rst
> > > > > > > > @@ -0,0 +1,320 @@
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > +Chapter 2: SD Card Boot
> > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > > > > > +
> > > > > > > > +
> > > > > > > > +SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Updat=
e Guide
> > > > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > +
> > > > > > > > +This guide explains how to prepare a bootable SD card with=
 Bianbu OS for
> > > > > > > > +SpacemiT K1 based boards and how to replace the U-Boot bin=
ary on the SD
> > > > > > > > +card with a custom build.
> > > > > > > > +
> > > > > > > > +Prerequisites
> > > > > > > > +~~~~~~~~~~~~~
> > > > > > > > +
> > > > > > > > +- A SpacemiT K1 based development board
> > > > > > > > +- A microSD card (at least 8 GB capacity recommended)
> > > > > > > > +- A card reader for your host computer
> > > > > > > > +- A Linux host system (for ``dd``, ``fdisk``, ``lsblk`` co=
mmands)
> > > > > > > > +- The Bianbu SD card image from
> > > > > > > > +   <https://spacemit.com/community/resources-download/Imag=
es%20Collects/K1/Bianbu>
> > > > > > > > +- A custom ``u-boot.itb`` file (device tree blob or U-Boot=
 FIT image) to be
> > > > > > > > +  written to the U-Boot partition
> > > > > > > > +
> > > > > > > > +Prepare the SD Card & the image
> > > > > > > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > > +
> > > > > > > > +**1. Download the image**
> > > > > > > > +
> > > > > > > > +Download the released package from the official SpacemiT w=
ebsite:
> > > > > > > > +
> > > > > > > > +<https://archive.spacemit.com/image/k1/version/bianbu/v2.3=
.5/Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip>
> > > > > > > > +
> > > > > > > > +**2. Extract the image**
> > > > > > > > +
> > > > > > > > +.. code-block:: console
> > > > > > > > +
> > > > > > > > +   $ unzip Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.=
img.zip
> > > > > > > > +
> > > > > > > > +**3. Identify the SD card device**
> > > > > > > > +
> > > > > > > > +Insert the microSD card into your card reader, then run:
> > > > > > > > +
> > > > > > > > +.. code-block:: console
> > > > > > > > +
> > > > > > > > +   $ lsblk
> > > > > > > > +
> > > > > > > > +Compare the output before and after inserting the card to =
identify
> > > > > > > > +the new device. It will typically appear as ``/dev/sdb``, =
``/dev/sdc``,
> > > > > > > > +or ``/dev/mmcblk0``.
> > > > > > > > +
> > > > > > > > +**4. Write the image to the SD card**
> > > > > > > > +
> > > > > > > > +.. code-block:: console
> > > > > > > > +
> > > > > > > > +   $ sudo dd if=3D./Bianbu-Minimal-K1-sdcard-V2.3.5-202606=
01180942.img of=3D/dev/sdb bs=3D1M status=3Dprogress
> > > > > > > > +
> > > > > > > > +The SD card is now ready as a bootable Bianbu system disk.
> > > > > > >
> > > > > > > This looks out of scope of describing how to create a bootabl=
e SD card
> > > > > > > with U-Boot. In my opinion, you'd better describe the require=
ments of
> > > > > > > parition layout and image position for SD-card booting, to al=
low readers
> > > > > > > to create their own images/bootable medium from scratch more =
easily,
> > > > > > > instead of sticking to the vendored image.
> > > > > > >
> > > > > >
> > > > > > Creating a bootable SD card from scratch would be valuable, but=
 I'll address
> > > > > > it later due to time constraints.
> > > > >
> > > > > In case I didn't make myself clear enough, the documentation *SHO=
ULD*
> > > > > describe how to create bootable devices from scratch, instead of
> > > > > alternating an existing OS image to use mainline U-Boot. I don't =
think
> > > > > the current documentation helps much for downstream users/distrib=
utions
> > > > > to adapt U-Boot for their own use cases, or at least it could be =
written
> > > > > in a much more clear, vendor-neutral way.
> > > > >
> > > > > So here's my NAK for this patch. I'm not sure what you mean by "t=
ime
> > > > > constraints", but please keep submitted patches in a good shape.
> > > > >
> > >
> > > In case that I still didn't make myself clear enough, by "bootable SD
> > > card", I mean a minimal medium with only a bootable U-Boot, you could
> > > refer to Rockchip or StarFive's documentation.
> > >
> >
> > I checked Rockchip or StarFive's documentation. And I can't find any me=
ntion of
> > creating a bootable SD card.
>
> Please grep SD in doc/rockchip/rockchip.rst. For StarFive, it seems
> the process of creating bootable SDcards has been removed a little
> earlier, but in section "Zero Stage BootLoader" of
> doc/starfive/jh7110_common.rst, the BROM's behavior is still described.
>
> > > > I=E2=80=99m not sure why the documentation insists on walking users=
 through creating a
> > > > bootable SD card from scratch, especially when, at this stage, it
> > > > still depends on
> > > > the vendor=E2=80=99s tools.
> > >
> > > Please explain which tools it depends on. Now U-Boot for your platfor=
m
> > > already has its SPL ported, and according to your instructions of
> > > replacing the vendor U-Boot, it seems no extra post-processing is
> > > required for the SoC to identify it.
> >
> > The flashing process must begin with a USB transfer. The vendor's
> > proprietary tool is required to download the images to the target
> > device. To maintain compatibility with this tool, I need to use the
> > same partition table that it expects.
>
> So please make it clear whether the proprietary tool is required for
> creating SD-card images, or it's only required for downloading the image
> to the SD card. The latter seems impossible since you described how to
> flash an image to SD with dd in this documentation.
>
> I'm really confused with your description.
>
> > Currently, the SPL (Secondary Program Loader) only boots U-Boot; it
> > has no other function in the boot flow.
> >
> > >
> > > And after re-reading the documentation, it seems you don't make use o=
f
> > > the upstream SPL when creating the SD-card image, is this intended, a=
nd
> > > why?
> > >
> >
> > Oh, I missed it. I need to append SPL part.
> >
> > > > In practice, we=E2=80=99re required to use the vendor=E2=80=99s
> > > > flashing tool for
> > > > both eMMC and SD devices,
> > >
> > > Please explain the constraints, it's okay to depend on vendor's tools=
,
> > > but for creating a SD-card image, I couldn't come up with a reason to
> > > do so, at least by inferring from the current documentation.
> > >
> >
> > I=E2=80=99m required to use the vendor=E2=80=99s flashing tool, flashse=
rver, for
> > programming SD card images =E2=80=94 mainly because it=E2=80=99s the on=
ly way I can
> > properly program the RPMB partition.
>
> But you don't do so in the documentation, dd is used. This wouldn't
> program the RPMB partition AFAIK. And does it mean that K1 requires a
> SDcard with RPMB support to boot? This doesn't match my experience with
> the platform.
>
> > The tool supports both eMMC and SD boot modes, and environment
> > variables (ENV) can be stored on either medium. However, it would be
> > unusual to boot from an SD card while loading the ENV from eMMC.
> > Therefore, the simplest and most consistent approach is to keep the
> > same partition layout across all critical components =E2=80=94 includin=
g FSBL,
> > ENV, and OpenSBI partitions =E2=80=94 regardless of the boot medium.
> >
> > > > and we must adhere to the provided partition table.
> > >
> > > Thus please clearly describe which part of the partition table must b=
e
> > > preserved for the SoC to boot.
> > >
> >
> > Mentioned above.
>
> Please quote the text, you do provide an example partition table, but
> there's no note describing which partitions are mandatory, and whether
> their offsets could be changed.
>
> If a user could only create their own SDcard images by trial and error,
> this documentation loses its purpose. Please describe what is mandatory,
> or only describe the mandatory parts like Rockchip's documentation.
>
> > > > If users prefer to define their own partition layout, nothing preve=
nts
> > > > them from doing
> > > > so on their own. That=E2=80=99s entirely up to them.
> > > >
> > > > The default SD image already includes the vendor=E2=80=99s U-Boot. =
My
> > > > instructions simply
> > > > explain how to replace it with the upstream version=E2=80=94nothing=
 more.
> > >
> > > Best regards,
> > > Yao Zi
>
> Frankly, I'm really tired of this discussion, I don't think you
> understand much of my questions, even though I tried to explain myself
> once and once again. And your replies are self-contradictory.
>
> Please make sure you understand my questions and reply with reasonable
> answers. I wouldn't continue to review your patches before you resolve
> questions in this thread.

So let it be simple. I'll remove the SD card part from this document
in the next round. Then we don't need to discuss it any more.

Any new comments on this series? If no, I'll send the next round in this we=
ek.
