Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B54BC55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 15:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0581B608B7;
	Thu, 30 Jul 2026 15:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vuxmp41mABR; Thu, 30 Jul 2026 15:21:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFC44608B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785424914;
	bh=3FEz9KAXwXSV0DubdjMTh9RowUCVMIHhMZdC//NuVWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ye9xqqIQMpTethyYmEXh/uhCVUSHbBdWnQLIJ4r9qMdZU9QXLJEGcKkr43YVW50zA
	 BLgYCRJ5Qn/Xr6BHQw+2HHYpKbl0opNIyiupk2ZIayZyMvtcHTdMGMOH6rA98o7une
	 WNOnohH/pQopqnEPj8T6sza6no+zk+q28AFLOXn3WEXroLNbnFySCzAZVmc4gDGrbI
	 LvAX7nhaWI8C2gilUtIjelccKsVPJ4/BKf2t2A5x6yrUf8SEBjaLgB4veeGbzNDgDC
	 uAQn3YBT1yoRm1H0Qzjxy2z48WmI52A7LUk7befZSaiHxXSBmWMMhe/sMC+RxE5nKA
	 uRhBuUe4ts/Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFC44608B1;
	Thu, 30 Jul 2026 15:21:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D83EB2CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDBEA408CA
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WUXTlexAtmo4 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:21:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 01B6640657
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01B6640657
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01B6640657
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785424895; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F2z7sPb7a/Pfj4jjK3bYIldxeJmcDrUXxi82I0OiaZ5PEXzVTXtw9tnbVuZpR5RvqSwkcqvaCWP3xwbSVHwqWUpzghn40ogSPvoRdrdnEZ7Mws0VPptE/Ek3Kcsitu17OC9dqFUKg4ELsTU9zAZpFbglSqqGSDvMRhyhiJBcEyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785424895;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3FEz9KAXwXSV0DubdjMTh9RowUCVMIHhMZdC//NuVWY=; 
 b=Ui3V3VbNAfvKlH9DHk+PEWF3w/IrOV14ewcaOAOsIK7cSapq4/GOTvLwBb2Sv/AToMSVtL0GEZX2L/aN27u8LumvdCCUX6LTVjBULfImA5dvdRxAe3cTcS/UU9hPzkhl+yWXym6UtgQNUPpGY+rQgZ/aH1k5ha/OmusuQBrY7SU=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785424892972784.1568140941549;
 Thu, 30 Jul 2026 08:21:32 -0700 (PDT)
Date: Thu, 30 Jul 2026 15:20:52 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>
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
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Subject: Re: [PATCH v6 09/11] doc: spacemit: flash on K1 SoC based boards
Message-ID: <amtr1G8oFZ9J64Uo@pie>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-9-2f58566d48ca@riscstar.com> <ameUvEoCHjeygBEd@pie>
 <CAH22mJy8_gd2V_DFUT0DQYiBSO6B3u5aX-V=uD20v0G+m1cArw@mail.gmail.com>
 <amh6JjTtUhi57H-b@pie>
 <CAH22mJwL+Op+99iBTePTkdGfArRy_inFRXm=DJjG-jJ=sYEi2g@mail.gmail.com>
 <amoc8umyQwc6UmXl@pie>
 <CAH22mJzjH2d6bd+HQhhkCiOYSr9cqYFZDCpB7zECaFPMZHBdVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH22mJzjH2d6bd+HQhhkCiOYSr9cqYFZDCpB7zECaFPMZHBdVQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.416.17
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785424895; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=3FEz9KAXwXSV0DubdjMTh9RowUCVMIHhMZdC//NuVWY=;
 b=O6EN+YAzu8juMPqmu8jlA1VwFvjb/5lz774HgSH4BWsGsVtjOAZAjkTOwYagMEXO
 unEdYIH31fKWZnRDcfj0K5SwlpAie6/pcdgsr4MW76/jsxKMs6epbfInil01PNFXsxK
 sKuXuMbBil1UNaTBJKdi7FLKTcdF+q3rm7ORRgBk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=O6EN+YAz
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

On Thu, Jul 30, 2026 at 02:25:31PM +0800, Eric Chung wrote:
> On Wed, Jul 29, 2026 at 11:33 PM Yao Zi <me@ziyao.cc> wrote:
> >
> > On Wed, Jul 29, 2026 at 09:49:26PM +0800, Eric Chung wrote:
> > > On Tue, Jul 28, 2026 at 5:45 PM Yao Zi <me@ziyao.cc> wrote:
> > > >
> > > > On Tue, Jul 28, 2026 at 08:53:02AM +0800, Eric Chung wrote:
> > > > > On Tue, Jul 28, 2026 at 1:26 AM Yao Zi <me@ziyao.cc> wrote:
> > > > > >
> > > > > > On Mon, Jul 27, 2026 at 02:59:11PM +0800, Eric Chung wrote:
> > > > > > > Add document on how to flash images into eMMC of K1 SoC based boards.
> > > > > > >
> > > > > > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > > > > > >
> > > > > > > ---
> > > > > > > v3:
> > > > > > > - Add document on how to flash images into SD card.
> > > > > > > ---
> > > > > > >  board/spacemit/k1/MAINTAINERS |   2 +-
> > > > > > >  doc/board/spacemit/index.rst  |   1 +
> > > > > > >  doc/board/spacemit/k1-mmc.rst | 320 ++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  3 files changed, 322 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
> > > > > > > new file mode 100644
> > > > > > > index 00000000000..b0fe78c75ce
> > > > > > > --- /dev/null
> > > > > > > +++ b/doc/board/spacemit/k1-mmc.rst
> > > > > > > @@ -0,0 +1,320 @@
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > +Chapter 2: SD Card Boot
> > > > > > > +=======================
> > > > > > > +
> > > > > > > +
> > > > > > > +SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
> > > > > > > +==================================================================
> > > > > > > +
> > > > > > > +This guide explains how to prepare a bootable SD card with Bianbu OS for
> > > > > > > +SpacemiT K1 based boards and how to replace the U-Boot binary on the SD
> > > > > > > +card with a custom build.
> > > > > > > +
> > > > > > > +Prerequisites
> > > > > > > +~~~~~~~~~~~~~
> > > > > > > +
> > > > > > > +- A SpacemiT K1 based development board
> > > > > > > +- A microSD card (at least 8 GB capacity recommended)
> > > > > > > +- A card reader for your host computer
> > > > > > > +- A Linux host system (for ``dd``, ``fdisk``, ``lsblk`` commands)
> > > > > > > +- The Bianbu SD card image from
> > > > > > > +   <https://spacemit.com/community/resources-download/Images%20Collects/K1/Bianbu>
> > > > > > > +- A custom ``u-boot.itb`` file (device tree blob or U-Boot FIT image) to be
> > > > > > > +  written to the U-Boot partition
> > > > > > > +
> > > > > > > +Prepare the SD Card & the image
> > > > > > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > +
> > > > > > > +**1. Download the image**
> > > > > > > +
> > > > > > > +Download the released package from the official SpacemiT website:
> > > > > > > +
> > > > > > > +<https://archive.spacemit.com/image/k1/version/bianbu/v2.3.5/Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip>
> > > > > > > +
> > > > > > > +**2. Extract the image**
> > > > > > > +
> > > > > > > +.. code-block:: console
> > > > > > > +
> > > > > > > +   $ unzip Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip
> > > > > > > +
> > > > > > > +**3. Identify the SD card device**
> > > > > > > +
> > > > > > > +Insert the microSD card into your card reader, then run:
> > > > > > > +
> > > > > > > +.. code-block:: console
> > > > > > > +
> > > > > > > +   $ lsblk
> > > > > > > +
> > > > > > > +Compare the output before and after inserting the card to identify
> > > > > > > +the new device. It will typically appear as ``/dev/sdb``, ``/dev/sdc``,
> > > > > > > +or ``/dev/mmcblk0``.
> > > > > > > +
> > > > > > > +**4. Write the image to the SD card**
> > > > > > > +
> > > > > > > +.. code-block:: console
> > > > > > > +
> > > > > > > +   $ sudo dd if=./Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img of=/dev/sdb bs=1M status=progress
> > > > > > > +
> > > > > > > +The SD card is now ready as a bootable Bianbu system disk.
> > > > > >
> > > > > > This looks out of scope of describing how to create a bootable SD card
> > > > > > with U-Boot. In my opinion, you'd better describe the requirements of
> > > > > > parition layout and image position for SD-card booting, to allow readers
> > > > > > to create their own images/bootable medium from scratch more easily,
> > > > > > instead of sticking to the vendored image.
> > > > > >
> > > > >
> > > > > Creating a bootable SD card from scratch would be valuable, but I'll address
> > > > > it later due to time constraints.
> > > >
> > > > In case I didn't make myself clear enough, the documentation *SHOULD*
> > > > describe how to create bootable devices from scratch, instead of
> > > > alternating an existing OS image to use mainline U-Boot. I don't think
> > > > the current documentation helps much for downstream users/distributions
> > > > to adapt U-Boot for their own use cases, or at least it could be written
> > > > in a much more clear, vendor-neutral way.
> > > >
> > > > So here's my NAK for this patch. I'm not sure what you mean by "time
> > > > constraints", but please keep submitted patches in a good shape.
> > > >
> >
> > In case that I still didn't make myself clear enough, by "bootable SD
> > card", I mean a minimal medium with only a bootable U-Boot, you could
> > refer to Rockchip or StarFive's documentation.
> >
> 
> I checked Rockchip or StarFive's documentation. And I can't find any mention of
> creating a bootable SD card.

Please grep SD in doc/rockchip/rockchip.rst. For StarFive, it seems
the process of creating bootable SDcards has been removed a little
earlier, but in section "Zero Stage BootLoader" of
doc/starfive/jh7110_common.rst, the BROM's behavior is still described.

> > > I’m not sure why the documentation insists on walking users through creating a
> > > bootable SD card from scratch, especially when, at this stage, it
> > > still depends on
> > > the vendor’s tools.
> >
> > Please explain which tools it depends on. Now U-Boot for your platform
> > already has its SPL ported, and according to your instructions of
> > replacing the vendor U-Boot, it seems no extra post-processing is
> > required for the SoC to identify it.
> 
> The flashing process must begin with a USB transfer. The vendor's
> proprietary tool is required to download the images to the target
> device. To maintain compatibility with this tool, I need to use the
> same partition table that it expects.

So please make it clear whether the proprietary tool is required for
creating SD-card images, or it's only required for downloading the image
to the SD card. The latter seems impossible since you described how to
flash an image to SD with dd in this documentation.

I'm really confused with your description.

> Currently, the SPL (Secondary Program Loader) only boots U-Boot; it
> has no other function in the boot flow.
> 
> >
> > And after re-reading the documentation, it seems you don't make use of
> > the upstream SPL when creating the SD-card image, is this intended, and
> > why?
> >
> 
> Oh, I missed it. I need to append SPL part.
> 
> > > In practice, we’re required to use the vendor’s
> > > flashing tool for
> > > both eMMC and SD devices,
> >
> > Please explain the constraints, it's okay to depend on vendor's tools,
> > but for creating a SD-card image, I couldn't come up with a reason to
> > do so, at least by inferring from the current documentation.
> >
> 
> I’m required to use the vendor’s flashing tool, flashserver, for
> programming SD card images — mainly because it’s the only way I can
> properly program the RPMB partition.

But you don't do so in the documentation, dd is used. This wouldn't
program the RPMB partition AFAIK. And does it mean that K1 requires a
SDcard with RPMB support to boot? This doesn't match my experience with
the platform.

> The tool supports both eMMC and SD boot modes, and environment
> variables (ENV) can be stored on either medium. However, it would be
> unusual to boot from an SD card while loading the ENV from eMMC.
> Therefore, the simplest and most consistent approach is to keep the
> same partition layout across all critical components — including FSBL,
> ENV, and OpenSBI partitions — regardless of the boot medium.
> 
> > > and we must adhere to the provided partition table.
> >
> > Thus please clearly describe which part of the partition table must be
> > preserved for the SoC to boot.
> >
> 
> Mentioned above.

Please quote the text, you do provide an example partition table, but
there's no note describing which partitions are mandatory, and whether
their offsets could be changed.

If a user could only create their own SDcard images by trial and error,
this documentation loses its purpose. Please describe what is mandatory,
or only describe the mandatory parts like Rockchip's documentation.

> > > If users prefer to define their own partition layout, nothing prevents
> > > them from doing
> > > so on their own. That’s entirely up to them.
> > >
> > > The default SD image already includes the vendor’s U-Boot. My
> > > instructions simply
> > > explain how to replace it with the upstream version—nothing more.
> >
> > Best regards,
> > Yao Zi

Frankly, I'm really tired of this discussion, I don't think you
understand much of my questions, even though I tried to explain myself
once and once again. And your replies are self-contradictory.

Please make sure you understand my questions and reply with reasonable
answers. I wouldn't continue to review your patches before you resolve
questions in this thread.

Best regards,
Yao Zi
