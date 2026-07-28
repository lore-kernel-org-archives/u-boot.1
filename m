Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA206C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7CC94092A;
	Tue, 28 Jul 2026 09:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aW5pODbsxmuv; Tue, 28 Jul 2026 09:45:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95809408FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785231952;
	bh=OJemN0K1dsTkABAvPU70M4dB/dSI7NTxmNyOay4ZNIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WqhFzVnV6fJ2yJkZDE/KncgU8TTW7+0ZXqfpxuiHX7NNk7FB2+oVj0O7p1laQ61S6
	 631/73yje6HWTA8IOqf2voxF37VKNg4HJb7RZYu3UvdafuoZf77jEGibI3siphhNj8
	 XYlNpn2XYRMjXgCxhdI+iVu3w2/WuL0wG/TJ8d2xuD2srt/IwDYBM3SKCdVnDwyjTK
	 gK0R1Ot1mWh+yfOZrIG8ijIP4MQSi5eC1KOltrtwA2cBHSVP67MKUwK2w6Wo7vQnWy
	 2Mg/poQULPwsUKjfRfmK/H7ItX1K/yoWYuA9tWcOacBxRUMWNYM1fFLz1hDtf277ws
	 8ZG/wBW1cOGbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95809408FF;
	Tue, 28 Jul 2026 09:45:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B98A945B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6FB5400EF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:45:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t15X1l-G6h_U for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:45:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 50812401FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50812401FC
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50812401FC
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785231931; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j+DSqLG2ZZbFqk/0hxjc/705gLiJmaHdJAk4PCL75dqNQiRq05pVUldY69UueyJBfAUHOHOmaQif2OTu1Bvb+MvLauNHB+EJBgn53/DutdzYtGCL4indGWF8+MYINODk/7VpnfaaonWmJ5ljwI4RNo36erHdArhfdsSWhcT6jss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785231931;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OJemN0K1dsTkABAvPU70M4dB/dSI7NTxmNyOay4ZNIE=; 
 b=l6eMiBfOaVkmrpU/QPSkuTCDZlE0brG1ueU8sRPxogqRYpDOjaxPsElpZmf1AZhqUQqZRPhA7ibtKm2bI4E951UT8wycwNGJqdwh7W46Xxkh75D79KEa8/W8MfjF+EQYsTxK+VAW1wr0nvoZAC8dIEnrRx+cN+c1kIaVXF2EXPc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785231928606510.3195787579052;
 Tue, 28 Jul 2026 02:45:28 -0700 (PDT)
Date: Tue, 28 Jul 2026 09:45:10 +0000
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
Message-ID: <amh6JjTtUhi57H-b@pie>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-9-2f58566d48ca@riscstar.com> <ameUvEoCHjeygBEd@pie>
 <CAH22mJy8_gd2V_DFUT0DQYiBSO6B3u5aX-V=uD20v0G+m1cArw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH22mJy8_gd2V_DFUT0DQYiBSO6B3u5aX-V=uD20v0G+m1cArw@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.228.97
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785231931; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=OJemN0K1dsTkABAvPU70M4dB/dSI7NTxmNyOay4ZNIE=;
 b=XNPBm1w47FM0u0PI4Er/t3fS7xVoroNlDZTMFt4rQhWDOIrsM1fkXdNz1ekfjwQ0
 UPm6UXrKxj3Cub9TSc5mNh+OHNJQ65kIXQu81RevI/30xDoBPTsyymY4Z0v3Zi6LCt2
 tn4grBqJxWsMbkOVqTNFsw7umW2Ng8EmrK8uYioQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=XNPBm1w4
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

On Tue, Jul 28, 2026 at 08:53:02AM +0800, Eric Chung wrote:
> On Tue, Jul 28, 2026 at 1:26 AM Yao Zi <me@ziyao.cc> wrote:
> >
> > On Mon, Jul 27, 2026 at 02:59:11PM +0800, Eric Chung wrote:
> > > Add document on how to flash images into eMMC of K1 SoC based boards.
> > >
> > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > >
> > > ---
> > > v3:
> > > - Add document on how to flash images into SD card.
> > > ---
> > >  board/spacemit/k1/MAINTAINERS |   2 +-
> > >  doc/board/spacemit/index.rst  |   1 +
> > >  doc/board/spacemit/k1-mmc.rst | 320 ++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 322 insertions(+), 1 deletion(-)
> >
> > ...
> >
> > > diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
> > > new file mode 100644
> > > index 00000000000..b0fe78c75ce
> > > --- /dev/null
> > > +++ b/doc/board/spacemit/k1-mmc.rst
> > > @@ -0,0 +1,320 @@
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
> > > +- A microSD card (at least 8 GB capacity recommended)
> > > +- A card reader for your host computer
> > > +- A Linux host system (for ``dd``, ``fdisk``, ``lsblk`` commands)
> > > +- The Bianbu SD card image from
> > > +   <https://spacemit.com/community/resources-download/Images%20Collects/K1/Bianbu>
> > > +- A custom ``u-boot.itb`` file (device tree blob or U-Boot FIT image) to be
> > > +  written to the U-Boot partition
> > > +
> > > +Prepare the SD Card & the image
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +**1. Download the image**
> > > +
> > > +Download the released package from the official SpacemiT website:
> > > +
> > > +<https://archive.spacemit.com/image/k1/version/bianbu/v2.3.5/Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip>
> > > +
> > > +**2. Extract the image**
> > > +
> > > +.. code-block:: console
> > > +
> > > +   $ unzip Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip
> > > +
> > > +**3. Identify the SD card device**
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
> > > +**4. Write the image to the SD card**
> > > +
> > > +.. code-block:: console
> > > +
> > > +   $ sudo dd if=./Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img of=/dev/sdb bs=1M status=progress
> > > +
> > > +The SD card is now ready as a bootable Bianbu system disk.
> >
> > This looks out of scope of describing how to create a bootable SD card
> > with U-Boot. In my opinion, you'd better describe the requirements of
> > parition layout and image position for SD-card booting, to allow readers
> > to create their own images/bootable medium from scratch more easily,
> > instead of sticking to the vendored image.
> >
> 
> Creating a bootable SD card from scratch would be valuable, but I'll address
> it later due to time constraints.

In case I didn't make myself clear enough, the documentation *SHOULD*
describe how to create bootable devices from scratch, instead of
alternating an existing OS image to use mainline U-Boot. I don't think
the current documentation helps much for downstream users/distributions
to adapt U-Boot for their own use cases, or at least it could be written
in a much more clear, vendor-neutral way.

So here's my NAK for this patch. I'm not sure what you mean by "time
constraints", but please keep submitted patches in a good shape.

Thanks,
Yao Zi
