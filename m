Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E760CD13CF
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 10:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF2688AB1;
	Tue,  3 Sep 2024 12:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="oSVSjhHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64DBB88B68; Tue,  3 Sep 2024 12:14:25 +0200 (CEST)
Received: from mxe-2-ad2.seznam.cz (mxe-2-ad2.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:ad2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 577AA88A9F
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 12:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxe-7df5484c66-k4bzx
 (smtpc-mxe-7df5484c66-k4bzx [2a02:598:64:8a00::1000:ad2])
 id 252f97ffdbdb255525a119e7; Tue, 03 Sep 2024 12:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1725358460;
 bh=x3tvDBTqrKBJpXlav+GwY4SUIu5UZKO8rs75Y0wOsbI=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:References:
 In-Reply-To:Mime-Version:X-Mailer:Content-Type:
 Content-Transfer-Encoding;
 b=oSVSjhHK2ExPfcnWopyfKQF3csq2z60SJqQD+gVAnmpJUJtmSvehyKUj0tFLy9SE6
 i0NZmMs+0AanNbmEsjMj+NmWYAdhGczPumae1zRnnZ4UJOMVDfpCegG1Nd2thcpp6Z
 kvTJ07cLhZzYJ/NkCIW9BEczHGAG1izJFAISSiexuMnI69rd5toaNVg3jJ2ceD9dqu
 Yh5Kqs3fsb9Vp6svODUbnzl0/1lQGFI8bf8pPcGaaK9pmT77fLuDw/lHFYFnfW7riI
 jqXHtCqv1+LxhaOuEHUrhBCrcASn6tmlPv0QcG/Iy9CbgrFKwvcfTGJKM5TW/agGH4
 slIOSRRjAXhaA==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Tue, 03 Sep 2024 12:14:17 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Quentin Schulz" <quentin.schulz@cherry.de>
Cc: <trini@konsulko.com>,
	<festevam@gmail.com>,
	<u-boot@lists.denx.de>
Subject: =?utf-8?q?Re=3A_=5BPATCH_v3=5D_cmd=3A_mmc=3A_Allow_using_partitio?=
 =?utf-8?q?n_name_in_mmc_erase_command?=
Date: Tue, 03 Sep 2024 12:14:17 +0200 (CEST)
Message-Id: <40q.ZbXp.GudlP{nFVV.1crk5v@seznam.cz>
References: <3hD.ZbWV.1{t85GxWb7T.1crWYj@seznam.cz>
 <63f3d458-e6c1-4995-b766-b0d04a69a837@cherry.de>
In-Reply-To: <63f3d458-e6c1-4995-b766-b0d04a69a837@cherry.de>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
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

> Same question as for v1, are we sure that the partition block size is
> the same as the MMC erase block size? Is this guaranteed by all
> standards (all MMC standards, and all partition table standards)?
> Otherwise I assume we should do some maths here to figure out the MMC
> start block AND block size based on the partition start block AND block=

> size and to pass the correct information to blk_derase(). I hope they
> also are guaranteed to be aligned somehow and that a partition block
> size is a multiple of an MMC erase block size? This maths seems to be
> done in mmc_berase() (at a quick glance, not sure it's appropriate).

Hi Quentin,

I'm no expert on U-Boot internals, but if you look e.g. to part_get_info_w=
hole_disk()
then you can see that blksz is directly copied from struct blk_desc to str=
uct disk_partition.
Both the start block and block size in struct disk_partition are multiples=
 of blksz, so I think that
they can be passed directly to blk_derase(), which later calls mmc_berase(=
).

Best regards

Tomas
