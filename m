Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BBDC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 05:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A497A8858A;
	Tue, 23 Apr 2024 07:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nakato.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nakato.io header.i=@nakato.io header.b="tcv1vuXn";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="AnnZerz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 108D188591; Tue, 23 Apr 2024 06:53:55 +0200 (CEST)
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com
 [103.168.172.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93BA88582
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 06:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nakato.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nakato@nakato.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id 9E727138010D;
 Tue, 23 Apr 2024 00:53:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 23 Apr 2024 00:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nakato.io; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1713848029;
 x=1713934429; bh=gbcAla7RI9jnUxMmJKJWuHf2BhAbtD0b40C1zYpmrvE=; b=
 tcv1vuXnaoN8Ue4Dd3jZm0aUeKqTHr1mQiBmRrrEfE0GRS2Uf2k+GnMdPALYeF/s
 KdaEz0yfNPydKCYoOMvCWuTx+xWq30ETzA6FnbL+twrJ8hwyyo3wuCfGGigjWhmx
 HnC4eU9IRwEq63Liudiyggw8SVScGZ6pFYvXqMUVQ+UancugGznkbPGYt2XbkS0K
 gEaE/rQoua2HNE9l1c9+dvCIPEYJT+1hF0Zn0A9tuQMbf0+dr2G9Ubi+ItpcRHvm
 qe28cQRk5b3pOKhe5FAJquYKjP14NTAZ0F2QbBgG87uqw8gKWiXYei+lWRi4hXRk
 YF/dOW6aaW6NaeHRFdbEJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713848029; x=
 1713934429; bh=gbcAla7RI9jnUxMmJKJWuHf2BhAbtD0b40C1zYpmrvE=; b=A
 nnZerz+A9HAxFqgCCkTMctYLK4FN1VQZOfWU/S8KEDCEso8ClvlS/rjyTISXp13E
 +Pv8QziqQ5CH6oEcx0jp2OYI7Cp6VwDAvNrtL+a6y58KGbRdkABbivZwpS9q0NQ2
 pxC6/68Xd1JrZah0MVAjfJ36fwHVSqtbN11HGF/b15BqMLiV9sXGOK2a5Oz++kyD
 mHh7EqXMwuy0n4Gasxr4HIg6moihVQ5Z2LU2BkqjX6zlleIO5nUHrjrB8thkbn+2
 rzZOadPlg2wL1OY9seUhmnulOen0D8NS+U6BRHWc7lJvckwO87bYhcWvvD7twlMG
 bYOC7Mj3OdGsLioWZ/K2Q==
X-ME-Sender: <xms:3T4nZrig2_xMA_yz0KeTTsQokA0HKM0kTt_baaY7QN_XHWPWLIgF6g>
 <xme:3T4nZoDafv0h_5JiB3ue0mWvSaUpKdV4omyTbgH5_ytZijwjncQZSLIrURkZMGjLo
 RTPn7w2KpHfrX9NtA>
X-ME-Received: <xmr:3T4nZrFgskwd82cEYLd7AThbpOgAskyod30AEloU1qFm3CW_aqi03FQu35X6R1tVERL_7LPL2FNBEt4oMqYD5S3-OE51GhuqSVDQghVnLmj1W3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgledvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtqh
 ertddttdejnecuhfhrohhmpefurggthhhiucfmihhnghcuoehnrghkrghtohesnhgrkhgr
 thhordhioheqnecuggftrfgrthhtvghrnhepfeevffdvieduvdffkeduffefledukeevff
 dtfeeigeeuvdeiudelledvudeuleefnecuffhomhgrihhnpehnrghkrghtohdrihhonecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgrkhgrth
 hosehnrghkrghtohdrihho
X-ME-Proxy: <xmx:3T4nZoSd4dAQfCmWehawCsBAxFyijvir1qRXWpgQCBXiQbUSt0fDLA>
 <xmx:3T4nZoxtiI17Iu0tHt2c9iaCAnflEQqiNsVL8Xgs-9QujnP0LLzlrQ>
 <xmx:3T4nZu4IebtzbzRVk258msVcjm0txRNCOS1E6uhRfeImoyaZZOU48A>
 <xmx:3T4nZtwylKJz6604pPW8pMiZXSNqseITGILUB8yE0yd_3GcTpINfYw>
 <xmx:3T4nZnrXoZkaIBfBSfSLHOh6l3urUpdSn5Y82zN0j302rQizN4G3_vB->
Feedback-ID: ic8e14276:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 00:53:46 -0400 (EDT)
From: Sachi King <nakato@nakato.io>
To: u-boot@lists.denx.de, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: kabel@kernel.org, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: BTRFS use-after-free bug at free_extent_buffer_internal
Date: Tue, 23 Apr 2024 14:53:45 +1000
Message-ID: <4299748.mogB4TqSGs@youmu>
In-Reply-To: <995dd168-8e1e-4b99-896c-ece4dc88d6e9@gmx.com>
References: <3281192.oiGErgHkdL@youmu>
 <995dd168-8e1e-4b99-896c-ece4dc88d6e9@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Tue, 23 Apr 2024 07:25:05 +0200
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

On Monday 22 April 2024 5:15:50=E2=80=AFPM AEST Qu Wenruo wrote:
>=20
> =E5=9C=A8 2024/4/22 16:07, Sachi King =E5=86=99=E9=81=93:
> > Hi,
> >
> > I've hit a bug with u-boot on my BTRFS filesystem, and I'm fairly certa=
in
> > it's a bug and not a corruption issue.
> >
> > A bit of history on the filesystem.  It is a fairly new filesystem as i=
t was
> > being used to give me access to test a wayland application on a
> > Raspberry Pi.  The filesystem was about 3 days old when I hit the bug, =
and
> > I'm fairly certain it never had an unclean shutdown.  I have checked the
> > filesystem with "btrfs check" which has found no errors.  The filesystem
> > mounts on Linux and is functional.
> >
> >> # btrfs check --check-data-csum /dev/sda2
> >> Opening filesystem to check...
> >> Checking filesystem on /dev/sda2
> >> UUID: 18db6211-ac36-42c1-a22f-5e15e1486e0d
> >> [1/7] checking root items
> >> [2/7] checking extents
> >> [3/7] checking free space tree
> >> [4/7] checking fs roots
> >> [5/7] checking csums against data
> >> [6/7] checking root refs
> >> [7/7] checking quota groups skipped (not enabled on this FS)
> >> found 5070573568 bytes used, no error found
> >> total csum bytes: 4451620
> >> total tree bytes: 370458624
> >> total fs tree bytes: 353124352
> >> total extent tree bytes: 10010624
> >> btree space waste bytes: 62303284
> >> file data blocks allocated: 6786519040
> >>   referenced 6328619008
>=20
> Since btrfs check reports no error, the fs must be valid.
>=20
> But considering how new it is, it may be related to some new features
> not properly implemented in Uboot.
>=20
> Is it possible to provide the whole binary dump of the fs?

Sure, here's a copy of the disk image.  The BTRFS is at partition 2.
http://maribel.nakato.io/u-boot-newtest.img.zstd

> >
> >
> > I've made an image of the filesystem so I could reproduce the bug in an
> > environment that doesn't require the physical SBC, and have reproduced
> > the issue using the head of the master branch with "qemu-x86_64_defconf=
ig".
> >
> > My testing qemu was produced with the following:
> >> # make qemu-x86_64_defconfig
> >> # cat << EOF >> .config
> >> CONFIG_AUTOBOOT=3Dy
> >> CONFIG_BOOTDELAY=3D1
> >> CONFIG_USE_BOOTCOMMAND=3Dy
> >> CONFIG_BOOTSTD_DEFAULTS=3Dy
> >> CONFIG_BOOTSTD_FULL=3Dy
> >> CONFIG_CMD_BOOTFLOW_FULL=3Dy
> >> CONFIG_BOOTCOMMAND=3D"bootflow scan -lb"
> >> CONFIG_ENV_IS_NOWHERE=3Dy
> >> CONFIG_LZ4=3Dy
> >> CONFIG_BZIP2=3Dy
> >> CONFIG_ZSTD=3Dy
> >> CONFIG_FS_BTRFS=3Dy
> >> CONFIG_CMD_BTRFS=3Dy
> >> CONFIG_GZIP=3Dy
> >> CONFIG_DEVICE_TREE_INCLUDES=3D"bootstd.dtsi"
> >> EOF
> >> # make -j24
> >
> > bootstd.dtsi is placed at "arch/x86/dts/bootstd.dtsi" and contains:
> >> / {
> >>          bootstd {
> >>                  compatible =3D "u-boot,boot-std";
> >>                  filename-prefixes =3D "/@boot/", "/boot/", "/";
> >>                  bootdev-order =3D "scsi";
> >>                  extlinux {
> >>                          compatible =3D "u-boot,extlinux";
> >>                  };
> >>          };
> >> };
> >
> >
> > The VM was run with
> >> qemu-system-x86_64 -bios u-boot.rom -nographic -M q35 -action reboot=
=3Dshutdown -drive file=3D/mnt/dbg/u-boot-debug.img
> >
> > The error message I recive on boot is
> >> BUG at fs/btrfs/extent-io.c:629/free_extent_buffer_internal()!
> >> BUG!
> >> resetting ...
> >
> >
> > I added a print statement to free_extent_buffer_internal that prints the
> > start address of the extent_buffer as I'm not sure what to be looking f=
or
> > here.  This print statement is before the decrement.
> >> printf("free_extent_buffer_internal: eb->start[%llx] eb->refs[%i]\n", =
eb->start, eb->refs);
> >
> > The last message before the crash reported eb->start to be "0", with 0 =
refs.
> >> free_extent_buffer_internal: eb->start[0] eb->refs[0]
> >
> > The extent at 0 struck me as odd, so I tried commenting out the freeing=
, by
> > removing the call to free_extent_buffer_final, and this resulted in boo=
tflow
> > succeeding and showing me the boot menu, which suprised me.
> > I expected to see the bug reproduce itself, with refs being zero, but e=
b->start
> > pointing somewhere valid, but I instead got a valid address with refs a=
t 2.
> >
> > I'm assuming that the order free_extent_buffer_internal is called is
> > deterministic, so by counting the print outputs the line that prior held
> > the extent_buffer with a 0 start was replaced with:
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >
> > Interestingly, as can be seen in the full logs with my included print
> > messages, 249c000 is being used just before this, with a ref count of
> > 2.  249c000 does appear to reach a point where it should have been freed
> > in the past, before it gets used again as seen in both logs.
> >
> > The failing boot log:
> >> U-Boot SPL 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:32:37 +10=
00)
> >> Trying to boot from SPI
> >> Jumping to 64-bit U-Boot: Note many features are missing
> >>
> >>
> >> U-Boot 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:32:37 +1000)
> >>
> >> CPU:   QEMU Virtual CPU version 2.5+
> >> DRAM:  128 MiB
> >> Core:  13 devices, 13 uclasses, devicetree: separate
> >> Loading Environment from nowhere... OK
> >> Model: QEMU x86 (I440FX)
> >> Net:   e1000: 00:00:00:00:00:00
> >>
> >> Error: e1000#0 No valid MAC address found.
> >>        eth_initialize() No ethernet found.
> >>
> >>
> >> Hit any key to stop autoboot:  0
> >> Scanning for bootflows in all bootdevs
> >> Seq  Method       State   Uclass    Part  Name                      Fi=
lename
> >> ---  -----------  ------  --------  ----  ------------------------  --=
=2D-------------
> >> scanning bus for devices...
> >> Target spinup took 0 ms.
> >> SATA link 1 timeout.
> >> Target spinup took 0 ms.
> >> SATA link 3 timeout.
> >> SATA link 4 timeout.
> >> SATA link 5 timeout.
> >> AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
> >> flags: 64bit ncq only
> >> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
> >>    Device 0: (0:0) Vendor: ATA Prod.: QEMU HARDDISK Rev: 2.5+
> >>              Type: Hard Disk
> >>              Capacity: 58680.0 MB =3D 57.3 GB (120176640 x 512)
> >> timeout exit!
> >> Scanning bootdev 'ahci_scsi.id0lun0.bootdev':
> >> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[0] eb->refs[0]
> >> BUG at fs/btrfs/extent-io.c:626/free_extent_buffer_internal()!
>=20
> The eb[0] seems very weird.
> Even for superblock reading, we got eb at 64K, and every eb should have
> at least one ref at creation time.
>=20
> So this indeed looks like the direct cause.
> But without a full call trace (is it possible inside U-boot runtime?), I
> do not have an immediate clue.
>=20
> Thanks,
> Qu
>=20
> >> BUG!
> >> resetting ...
> >
> > The succeeding log with the removed freeing:
> >> U-Boot SPL 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:38:25 +10=
00)
> >> Trying to boot from SPI
> >> Jumping to 64-bit U-Boot: Note many features are missing
> >>
> >>
> >> U-Boot 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:38:25 +1000)
> >>
> >> CPU:   QEMU Virtual CPU version 2.5+
> >> DRAM:  128 MiB
> >> Core:  13 devices, 13 uclasses, devicetree: separate
> >> Loading Environment from nowhere... OK
> >> Model: QEMU x86 (I440FX)
> >> Net:   e1000: 00:00:00:00:00:00
> >>
> >> Error: e1000#0 No valid MAC address found.
> >>        eth_initialize() No ethernet found.
> >>
> >>
> >> Hit any key to stop autoboot:  0
> >> Scanning for bootflows in all bootdevs
> >> Seq  Method       State   Uclass    Part  Name                      Fi=
lename
> >> ---  -----------  ------  --------  ----  ------------------------  --=
=2D-------------
> >> scanning bus for devices...
> >> Target spinup took 0 ms.
> >> SATA link 1 timeout.
> >> Target spinup took 0 ms.
> >> SATA link 3 timeout.
> >> SATA link 4 timeout.
> >> SATA link 5 timeout.
> >> AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
> >> flags: 64bit ncq only
> >> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
> >>    Device 0: (0:0) Vendor: ATA Prod.: QEMU HARDDISK Rev: 2.5+
> >>              Type: Hard Disk
> >>              Capacity: 58680.0 MB =3D 57.3 GB (120176640 x 512)
> >> timeout exit!
> >> Scanning bootdev 'ahci_scsi.id0lun0.bootdev':
> >> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
> >> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
> >> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
> >>    0  extlinux     ready   scsi         2  ahci_scsi.id0lun0.bootdev /=
@boot/extlinux/extlinux.conf
> >> ** Booting bootflow 'ahci_scsi.id0lun0.bootdev.part_2' with extlinux
> >> ------------------------------------------------------------
> >> 1:      NixOS - Default
> >> 2:      NixOS - Configuration 5 (2024-03-04 11:00 - 24.05.20240205.faf=
912b)
> >> 3:      NixOS - Configuration 4 (2024-03-02 15:05 - 24.05.20240205.faf=
912b)
> >> 4:      NixOS - Configuration 3 (2024-03-02 14:26 - 24.05.20240205.faf=
912b)
> >> 5:      NixOS - Configuration 2 (2024-03-02 14:06 - 24.05.20240205.faf=
912b)
> >> 6:      NixOS - Configuration 1 (1970-01-01 10:00 - 24.05.20240205.faf=
912b)
> >> Enter choice: 1:        NixOS - Default
> >> Retrieving file: /@boot/extlinux/../nixos/gq8jsgxnhq2wvsjrni3cjw1wb554=
0wjw-linux-6.1.63-stable_20231123-Image
> >> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
> >
> >
> > I'm not sure where to go from here with the bug, so I'm hoping for some
> > help in tracking it down so it can be fixed.
> >
> > Thanks,
> > Sachi
> >
> >
> >




