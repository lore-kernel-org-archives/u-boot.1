Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA91C531D0
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 00:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4388F81145;
	Tue, 28 Jul 2026 00:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id krVfEUaND4X3; Tue, 28 Jul 2026 00:53:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F41381098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785200002;
	bh=Vl8gx4paNq6gWFG3ain77vj5PtZyCMG2SBfDyXUoQh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G59Fdo8RR19C4AHCv4nxKS6xi7mWgoxRy9HaacielTl/fLlrB8xPrGDBWh85BBLVR
	 ZBxSkKTuwdhH18iiqfSjshh2XfsnXxTAnDE4rtIkRdPwTtSqGYlByqQCK3ra7DsDSh
	 gi/NjuPnszBb4P+l3sW+cgl6NNVwwWFGTF1x0AXPefBW6QSPSUfTw+986xc6DpsYWl
	 iWhglWRDuATVuIceJ1b/OsacqEhqTCHIvzhEGIHX0QWKfYWLGTvF2Hb3wWoM9FsWj3
	 YlwPRrD8ufjDn3/M9PiSrfcoBgCMVhxtBVH9ZW824V0gwdIZtieT6fmtTwwuJuGmdw
	 NzbE+jCVm+9BQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F41381098;
	Tue, 28 Jul 2026 00:53:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 897093B0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 00:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7AD5C81098
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 00:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IrXMLl7gAk_x for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 00:53:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8780380FA0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8780380FA0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8780380FA0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 00:53:17 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5b2a3166398so2754585e87.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785199995; cv=none;
 d=google.com; s=arc-20260327;
 b=MkEOsPYvh0GIZQkr8WbiwpfYErDaG5z35m7whrq0cSkJI7Eqz1LYLZRypImMOiwlBF
 ys3Jr6lD0bEC4vlPeGZrRQu9h34OVBmD1abgwBd7drwaAMSot5ne/5uTmzJdPAPBDWX5
 p84V0V1RZP/ftcGgKTG1CHPD6CSkeZM1RCPyDwAx0rTppcdpjz9H/RR6O3X2oT5JSL8r
 O/JMmEB4Bpe4Af+B5rlQNnNPAlSbTlbJvf7TQuFxbJc/jg9evFl52mc/kQXGscy6KzZf
 qItJlDLHSK78aqSzZAeTp6tn7l/t6LBBnjqUaNw5ZyU4Wz2m346DTh3LSd4p0mB9hRZo
 GdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vl8gx4paNq6gWFG3ain77vj5PtZyCMG2SBfDyXUoQh8=;
 fh=fzGSiFXmSXdIygXX6h4xvONEANWnW0kyWyGdTFuBMoo=;
 b=LawAmixU1JFFER/RYxmdeVyUhymyxMPkVhC9KDX9rrTqLVjuxyUSHSvWDqTAHf8w4w
 5BTEdnbUR/+gM6IsUnKppI/X4DTDPxgpUQWJu1yaSGYmohwSMaxGjlG2bvGSR1lih8Gl
 XcJfihg4Wj5JiJP6Qq+XxK17+L5P9LkYavIJuW3SoSRA07GnzvBpd+oq1C9JqEj/vQTo
 tINMwmgA6+ku5grpfDUDQDfifve8k3CSGKjNxhD2uNEYDgqpyQucOUznaCKx8wymJ2GG
 osVknGdZ8zGTm2zHs4tqQtnI0Pgd8tca+8JrnG/1w9Wg1eq0WEJbHvzyjIbFCcT4mbL1
 phKQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785199995; x=1785804795;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vl8gx4paNq6gWFG3ain77vj5PtZyCMG2SBfDyXUoQh8=;
 b=KjjqIPsFWWgpy9nPwnhKnhkfJzegWy9NVNBAeIBJTd33zZgzdZbSx8wF/2Cz/mcWKM
 kHLDZ8WPLOY07RuBx8mQfuzQKLdP/WQUCNdFJi0rXhSIG0bBznv6rTI4s8vxRW3Ifj3c
 RkPc9vJK+RS5+KXYgr+ODx+TM44SYQ/qudo7EExvr4xukWmNfh7nhlyjcLQe4HRtBPn0
 fX+PXKXZYeusNUqWhoCn0qhw5yYw7WVWBMizFTyQwSJABMdEtAse+bDx95RB6XBTWVMj
 DLv+y7KBP0NrFZU4TuSlyUd/HQjdFfYAZ3tXhf4lMBgu0KxPE9LqpA4Ck3y7xGSC1TdN
 crGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUd7VuKXmwAB3LomvLlFYmU5iZl9uHI3XD4KqLlUTE66P6acYaH0XKPLsJB3MMdNhp2dljIIo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzYjfD6atA6S9kuqHiATSRi2702B7RQXaFXrujm0d/nW1+jnyEa
 k1Luou8SzGDy4YNliuxiJz0LlpHem6RRoFLS7gTANQc6wrmAHuGAC35vDZ+Ec7RX4soPR18epVS
 hYaozEWyNFLRmsMGQWwpEK+MLF1/397dqHZ7XGJy2Vg==
X-Gm-Gg: AR+sD13Lkvx+/XBYOz6yXUGdW/6MgSzMPJK9DCGvzcXLIZ90G7ocuBwT5f/u4kPH/xu
 3hIRduhhUI39/Ixjo2jIjDE2fR2B+EKCo98NAtoiI07LCE7axZI3F5IRGIhiCkrL73TBNL56Q5t
 Sr4D45DPNFdE8+8NzZ2OxEHIniXmiN4wH56QtPEJOy2+Q3s5bSvpf+J5m4Qg5yu4IpToJra37mn
 k4ggzaEYKroK4pHnoMynU2XH12P8rZ6Zydieiw5tfX7Et0oJBFpErcNQuBl3MSG4C79MsHDaAjA
 /H24vP+GZ/aL2nj1nCNYh1vsDmEpJ0uMAj3h68PzkSDCUmxKsRPRcyOCH/heJGYVWHhbmEsBOdn
 cBm5MKAX6XQIHXIvqqhE=
X-Received: by 2002:a05:6512:2303:b0:5b2:9dcc:8e26 with SMTP id
 2adb3069b0e04-5b2d0272fe3mr27862e87.60.1785199994890; Mon, 27 Jul 2026
 17:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-9-2f58566d48ca@riscstar.com> <ameUvEoCHjeygBEd@pie>
In-Reply-To: <ameUvEoCHjeygBEd@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 28 Jul 2026 08:53:02 +0800
X-Gm-Features: AUfX_myjdsTO4AIeL1n8aUwcCSG77pMI4wGAAHIXP1JdiH0EQiSpbxbj5QxQM1M
Message-ID: <CAH22mJy8_gd2V_DFUT0DQYiBSO6B3u5aX-V=uD20v0G+m1cArw@mail.gmail.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785199995; x=1785804795;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vl8gx4paNq6gWFG3ain77vj5PtZyCMG2SBfDyXUoQh8=;
 b=UR5XAlHtB4xvb75qr8DUPa989Jscfb8X0hrc9Ce8AaDk1ZgGVwh5NFyJvoSTlfnR3W
 DhEazmrQOFYWgZlwSaq3d++0hNqDIDLjfI8A2N96NilXVBAGVjgUcoiBJPxCvCfSEXtv
 bFJSmKitsK9mO7lbWYYmJnXGPKRclu7j5tKWQ6GLbLdQGndSUvcfe6J4b2Dh6/gxHxjN
 48ypMj39xwSmUvuboNGPyeEr3mwWC/FfIHMDpqeMIARjBXbxWDbv48X/FV7xQ/vEgddH
 GW3s2waYGs5PZ7ztRQrbYpm1nn/aZxi8OlwR4gLEcBzO+rMI+inUzvu469YJFvUJ7H3N
 zsaw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=UR5XAlHt
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

On Tue, Jul 28, 2026 at 1:26=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
>
> On Mon, Jul 27, 2026 at 02:59:11PM +0800, Eric Chung wrote:
> > Add document on how to flash images into eMMC of K1 SoC based boards.
> >
> > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> >
> > ---
> > v3:
> > - Add document on how to flash images into SD card.
> > ---
> >  board/spacemit/k1/MAINTAINERS |   2 +-
> >  doc/board/spacemit/index.rst  |   1 +
> >  doc/board/spacemit/k1-mmc.rst | 320 ++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 322 insertions(+), 1 deletion(-)
>
> ...
>
> > diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.=
rst
> > new file mode 100644
> > index 00000000000..b0fe78c75ce
> > --- /dev/null
> > +++ b/doc/board/spacemit/k1-mmc.rst
> > @@ -0,0 +1,320 @@
>
> ...
>
> > +Chapter 2: SD Card Boot
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +
> > +SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This guide explains how to prepare a bootable SD card with Bianbu OS f=
or
> > +SpacemiT K1 based boards and how to replace the U-Boot binary on the S=
D
> > +card with a custom build.
> > +
> > +Prerequisites
> > +~~~~~~~~~~~~~
> > +
> > +- A SpacemiT K1 based development board
> > +- A microSD card (at least 8 GB capacity recommended)
> > +- A card reader for your host computer
> > +- A Linux host system (for ``dd``, ``fdisk``, ``lsblk`` commands)
> > +- The Bianbu SD card image from
> > +   <https://spacemit.com/community/resources-download/Images%20Collect=
s/K1/Bianbu>
> > +- A custom ``u-boot.itb`` file (device tree blob or U-Boot FIT image) =
to be
> > +  written to the U-Boot partition
> > +
> > +Prepare the SD Card & the image
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +**1. Download the image**
> > +
> > +Download the released package from the official SpacemiT website:
> > +
> > +<https://archive.spacemit.com/image/k1/version/bianbu/v2.3.5/Bianbu-Mi=
nimal-K1-sdcard-V2.3.5-20260601180942.img.zip>
> > +
> > +**2. Extract the image**
> > +
> > +.. code-block:: console
> > +
> > +   $ unzip Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip
> > +
> > +**3. Identify the SD card device**
> > +
> > +Insert the microSD card into your card reader, then run:
> > +
> > +.. code-block:: console
> > +
> > +   $ lsblk
> > +
> > +Compare the output before and after inserting the card to identify
> > +the new device. It will typically appear as ``/dev/sdb``, ``/dev/sdc``=
,
> > +or ``/dev/mmcblk0``.
> > +
> > +**4. Write the image to the SD card**
> > +
> > +.. code-block:: console
> > +
> > +   $ sudo dd if=3D./Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img=
 of=3D/dev/sdb bs=3D1M status=3Dprogress
> > +
> > +The SD card is now ready as a bootable Bianbu system disk.
>
> This looks out of scope of describing how to create a bootable SD card
> with U-Boot. In my opinion, you'd better describe the requirements of
> parition layout and image position for SD-card booting, to allow readers
> to create their own images/bootable medium from scratch more easily,
> instead of sticking to the vendored image.
>

Creating a bootable SD card from scratch would be valuable, but I'll addres=
s
it later due to time constraints.
