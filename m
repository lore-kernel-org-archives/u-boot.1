Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5602FC79F99
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 18:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0CEE605CE;
	Mon,  7 Sep 2026 18:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zd2_JR2aVySE; Mon,  7 Sep 2026 18:00:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AF11B605D8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788804011;
	b=TYFTH9jl+eSuolLxB+9eC/sA/WiRwpK9kPL6GXpgclGvmmnKNTp0tfrFaA4nhyzoDz74
	 7E+Hm0+0d2i4qKDMESROgHBJBprp83a2jrGhpcf4MiGODQXUzVsio2jVFc/rxIddRJ0e6
	 UKjWBThuj3WsdqLrfLnvpWJQrXHAkXMIWlN2Y3ZO9ZHfsrrSZM1jBXJzc1XXHIZPozB3X
	 DWDGChh3c0YDFqV8DV+wWv3KOd9uTAtFM4yvnuKIHAv+bUCOKi8mvxOac+FxNEH5SfNBa
	 +aCGhE5NcY7JWz7E2pk3gT4OeuHLbzk0hTzFyoBDg40dttzhCNhVTGv5JO+b4PtnpCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788804011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LFPP52Z2QW20qbhogzcNmGoaccVg08wo1RbaXcam1xg=;
	b=F+Yy0jDxKgn30Ug0tY3nnkGvVfqYB2I7B4KVOOFRhB0WnkykPS1NEuE29CGn4tABh/mP
	 OKMvqOuncw7rWJMxyiHrGyoZl8SkHSSt2CNut3OR7IRFC2F47oKBgNvCZRgM3kzeP88Za
	 lMddgofIC5mkQ4o8G9KZCQco9QbvvCVCcB8SLkO73rI1Q+U0XQKvhSNDn9AUIT2wgKz4X
	 xnZJPXfpsp1pQ1kOBNgoNDUO5KAg/gjJSYZ07IhO+Esf+bcbTZfzSNJ62EoVbFE3ej/R8
	 pSXQDrJrAZEBB8Bh0XdQZSLcX8bn9ANUcP+J1+hBfCtGCXzjPNBVT6idvp7HJsQXjBg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788804011;
	bh=LFPP52Z2QW20qbhogzcNmGoaccVg08wo1RbaXcam1xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sk+CyJ8YPZE3UUYwNI2REfMML5j22EwHIN6pDPFShHJDRk+tuu2DvIPpOySNnX2AL
	 I8C+5M7g38ujPlQd70+4deWJbVur5gFZCLMpYm2+DFEWtcHbkp5Gn3MPS9IHCMukIX
	 o3OwGAgRTMW8CefC4HxboQtRI/DcNnDC5/33K87hPTsE4V44qor6ZVGj5SZ6IKVOzN
	 NirW+msLZ+JQdlpn/z//1GeSSGXFV7eb3NSYDwDNrURAogiCQmQOgtkuJcWYK3kfnz
	 MfdfZbBetvFKe19T7QCKoXAiG8qP+5/OpJPD6RAfZuVLHakSTpJVOqeDJUaK3qKfiJ
	 pjYAt5Qdczp6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF11B605D8;
	Mon,  7 Sep 2026 18:00:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C4DFAEB
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E49B807B6
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u0gvOdkXJsqF for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 18:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F22F88086E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788804008;
 b=JvO8en1vnUG8QMj0VJQedMewfXpSZC33APPTLVBEaMyadR9iTtj0q2mvXanDkYwFFlzz
 gxaqV7eOxToaczTDPTWIM1OW0SGLv7xoa4Y9RMGc9okqGGxaFUkL3Zgxeynk46m/zn3Nx
 TM4FxAnUM3OJIQkPdwJiB1j+CR7X0fGEF1qy1oS63/lmV4/QeUUisW4xu0yWtWEhWBgYk
 WFOYnmF6wsBZHkjZPL2HGbYMVadtr0fViA82mMEZPvAwTq4JEw6as5OCIC2pYHq3oKKKQ
 Sxmptcu4XVFJcItepc3Jpk6eK6yXSbjdtgMMhXAbDk0XI7Ksr2eHgJqYB+HV4frZlbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788804008;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=LFPP52Z2QW20qbhogzcNmGoaccVg08wo1RbaXcam1xg=;
 b=R9WHLFKTFXr5quqdslvfGXyTjaSNlU/O+TGXkBAhGtj4vE+p6Eji2PFO06xFwateOtrM
 mDsyggn+Q5Kj1i4iSoYE1SrWPOsMUB5MuAa27eqL8KwTBB9dDMzViC2elr0/mQjSzgumw
 32mw25WsRJxz86246mWNR+rmao5qzQQTMbv5/ns0kftQ8qayL/r2FQvvUwWOQAeZsS8Ji
 6/YFKY18RItygqciD2A5p9e5CTRi9GuWt2smx0PDUzh0pcMbOqJBWW1s8wHJYAHVlIoOp
 AFWpYCh1Ifnl2tG7YeSCpYzj1KEqdo4XS1Z/FD6pT2twTsb8FAjtsCaPsD3R0typZuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=TSFOzb6M; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=TSFOzb6M
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F22F88086E
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788803988; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hs1WZDAG+Burwm7RIVtBZIzHziEj/kIeot/ZW7tA0UEzeI6xsdf8VP5CCh73Xknywq9tWutSIatkS0Z8j7x+6vV/GiPfZppfpAUpVlfr4uQR3cQL83PhuZN2wxQNzKJrYXhNNOsvsdKROaxwUm0QW5YJcO1g2Wx7bDKF5T2wA+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788803988;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LFPP52Z2QW20qbhogzcNmGoaccVg08wo1RbaXcam1xg=; 
 b=amfWYx2K0J0k0D2WpSX4ChqaFWi5pTjiTPqXhqM9BXi6GuGn0V066HSce8Vw3dTtLpgPBVDVMMgDeVpjVwocNjEMYDByp6mVJI868zec2YknjjyHb6d/9TR/+S1YkBd9w+nOiws/RAvvfZUue/K7/zo1O42dWWhVJO2oxc2/vzg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788803988; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=LFPP52Z2QW20qbhogzcNmGoaccVg08wo1RbaXcam1xg=;
 b=TSFOzb6M5BIZEWqdLeRUZpI7nheXhanj2pmixohRPvwxyQcW8Y2/YnZPgvPXzkHE
 Y8Bo+ZlorCLRuD8qt5naN9asiSVIwvBy82I/9cxZjAYZFH9TSF+o7FKnerRyuHcniCf
 SJSj4wLfFJxDB1NCrySlO+QCsHZi0Snz24hNlpJM=
Received: by mx.zohomail.com with SMTPS id 1788803985450717.4270751207542;
 Mon, 7 Sep 2026 10:59:45 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:59:22 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v12 6/7] doc: spacemit: flash on K1 SoC based boards
Message-ID: <ap77enyr-SzG4TQq@pie>
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
 <20260906-m4-v12-6-89eb5a8f879d@riscstar.com>
 <ap560PSIq5GenBe4@pie>
 <CAH22mJzKt2ihLLA22AN56SB3Q7jOpayyzLZrrRLAsN+u=Pz_5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH22mJzKt2ihLLA22AN56SB3Q7jOpayyzLZrrRLAsN+u=Pz_5w@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.793.29
X-ZohoMailClient: External
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

On Tue, Sep 08, 2026 at 12:31:10AM +0800, Eric Chung wrote:
> On Mon, Sep 7, 2026 at 4:51 PM Yao Zi <me@ziyao.cc> wrote:
> >
> > On Sun, Sep 06, 2026 at 05:11:08PM +0800, Eric Chung wrote:
> > > Add document on how to flash images into eMMC of K1 SoC based boards.
> > >
> > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > >
> > > ---
> > > v9:
> > > - Add to generate the partition table of SD card.
> > > v3:
> > > - Add document on how to flash images into SD card.
> > > ---
> > >  board/spacemit/k1/MAINTAINERS |   2 +-
> > >  doc/board/spacemit/index.rst  |   1 +
> > >  doc/board/spacemit/k1-mmc.rst | 271 ++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 273 insertions(+), 1 deletion(-)
> >
> > ...
> >
> > > diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
> > > new file mode 100644
> > > index 000000000000..0be5d5fa1c39
> > > --- /dev/null
> > > +++ b/doc/board/spacemit/k1-mmc.rst
> >
> > ...
> >
> > > +Chapter 2: SD Card Boot
> > > +=======================
> > > +
> > > +
> > > +SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
> > > +==================================================================
> > > +
> > > +This guide explains how to prepare a bootable SD card with Bianbu OS for
> > > +SpacemiT K1 based boards and how to replace the U-Boot binary on the SD
> > > +card with a custom build.
> > > +
> > > +Prerequisites
> > > +~~~~~~~~~~~~~
> > > +
> > > +- A SpacemiT K1 based development board
> > > +- A microSD card (at least 4GB capacity recommended)
> > > +- A card reader for your host computer
> > > +- A Linux host system (for ``dd``, ``sgdisk``, ``lsblk`` commands)
> > > +- The Bianbu release package from
> > > +  <https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-Minimal-K1-V2.3.3-20260128183217.zip>
> > > +- A custom ``FSBL.bin`` and ``u-boot.itb`` file to be written to the U-Boot
> > > +  partition
> > > +
> > > +Prepare the SD Card & the image
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +**1. Obtain the release images**
> > > +
> > > +Unpack the release package to get the image files. Replace the ``FSBL.bin``
> > > +and ``u-boot.itb`` with your custom builds.
> > > +
> > > +**2. Identify the SD card device**
> > > +
> > > +Insert the microSD card into your card reader, then run:
> > > +
> > > +.. code-block:: console
> > > +
> > > +   $ lsblk
> > > +
> > > +Compare the output before and after inserting the card to identify
> > > +the new device. It will typically appear as ``/dev/sdb``, ``/dev/sdc``,
> > > +or ``/dev/mmcblk0``.
> > > +
> > > +**3. Write the image to the SD card**
> > > +
> > > +Run ``sgdisk`` to generate the partition table, then use ``dd`` to write
> > > +the images to the corresponding partitions.
> > > +
> > > +.. code-block:: console
> > > +
> > > +    $sudo sgdisk -o /dev/sdb
> > > +    $sudo sgdisk -a 128 \
> > > +        -n 1:256:767 -t 1:8300 \
> > > +        -n 2:768:895 -t 2:8300 \
> > > +        -n 3:2048:4095 -t 3:8300 \
> > > +        -n 4:4096:8191 -t 4:8300 \
> > > +        -n 5:8192:532479 -t 5:8300 \
> > > +        -n 6:532480:4726783 -t 6:8300 \
> > > +        /dev/sdb
> > > +    $sudo dd if=FSBL.bin of=/dev/sdb1 bs=512 seek=0 status=progress
> > > +    $sudo dd if=env.bin of=/dev/sdb2 bs=512 seek=0 status=progress
> > > +    $sudo dd if=fw_dynamic.itb of=/dev/sdb3 bs=512 seek=0 status=progress
> > > +    $sudo dd if=u-boot.itb of=/dev/sdb4 bs=512 seek=0 status=progress
> > > +    $sudo dd if=bootfs.img of=/dev/sdb5 bs=1M status=progress
> > > +    $sudo dd if=rootfs.ext4 of=/dev/sdb6 bs=1M status=progress
> >
> > The bootfs/rootfs part aren't U-Boot-related stuff, so please omit them
> > from this documentation to keep it simplified.
> >
> > Then the only binary we need to extract from the "SpacemiT release
> > package" is env.bin and fw_dynamic.bin.
> >
> > For env.bin, I think this U-Boot port depends on no specific environment
> > setttings? If no, please omit it, too; otherwise please provide a .env
> > file in upstream U-Boot tree, and make it the default environment to
> > use.
> 
> OK. I can drop these binaries.
> 
> >
> > For fw_dynamic.bin, I think SpacemiT K1 support has been landed in the
> > upstream OpenSBI tree? Please check if it works with upstream U-Boot.
> > If no, please try fixing it, and then it's okay to stick to the
> > downstream OpenSBI, but you need providing a guidance to build it from
> > source if possible.
> 
> The patch set is for MMC/SD. OpenSBI is another topic that does not
> belong to u-boot either. They should not be mixed together.

At least "which OpenSBI variants are compatible with this port" should
belong to this documentation, because your port requires a functional
OpenSBI image to boot.

If you really do not want to include the build steps here, though it
could be very brief to only one or two paragraphs, please check
upstream OpenSBI, and if it works, describe the minimum required OpenSBI
version, and the platform to build; if not, please mention which
downstream OpenSBI should be used instead, how to build it, and if you
could figure it out, why.

> I prefer to address one topic per patch set.
> >
> > Then you could fully omit the step of downloading the "SpacemiT release
> > package".

Regards,
Yao Zi
