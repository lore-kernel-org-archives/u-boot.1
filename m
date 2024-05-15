Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F47C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 08:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5977988248;
	Wed, 15 May 2024 10:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cd7K267R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FF4188248; Wed, 15 May 2024 10:59:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F3688249
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 10:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DE2D26147F;
 Wed, 15 May 2024 08:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E58C116B1;
 Wed, 15 May 2024 08:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715763550;
 bh=yrE/bfN6YTz64Ustrs4Tm9WY8XZz4Oz9+nv/RL3iQ9s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cd7K267R1/Diku/Us3ZS29JkMkILq7qRQKVK6AL3yjon8kMG90JMH0jcf1jSCEyVe
 Y0jq4fYkqWFyTBMac4t2wcWfOfM7F56bw+x4VjJfJquDi3SsB9j/Zqnxj4H9ib4bp2
 DInD4jM75Y1muVe4Z1tZF8XxIahqIJKR2SSbPpoa6KEBwlrac9inRM4LKpl1hqZZXZ
 ua2lz7iDHP5oAMsDOAMd3ZYtEQRaoTzTGU9T3ObOdN9zJjLZ7JNvFpd/Wiu+6bghGP
 GLkiPcKpodkjkRJ4LsmZsYBiyRAG+Ik1Lg1DCwEGuiKFq1Q9JGXkWAJWk1NM7kcdlK
 xiguSXibWLmoQ==
Date: Wed, 15 May 2024 10:59:06 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH u-boot-mvebu 10/10] arm: mvebu: turris_omnia: Support
 old DDR3 training, selectable via env var
Message-ID: <20240515105906.3cfca4fb@dellmb>
In-Reply-To: <149e251a-baa7-4512-990a-d332d0d6177f@denx.de>
References: <20240415163043.7482-1-kabel@kernel.org>
 <20240415163043.7482-11-kabel@kernel.org>
 <149e251a-baa7-4512-990a-d332d0d6177f@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 6 May 2024 12:03:55 +0200
Stefan Roese <sr@denx.de> wrote:

> Hi Marek,
>=20
> On 4/15/24 18:30, Marek Beh=C3=BAn wrote:
> > Support old DDR3 training code on Turris Omnia, selectable by U-Boot
> > enviroment variable.
> >=20
> > Users experiencing DDR3 initialization failures or random crashes of the
> > operating system due to incorrect DDR3 configuration can select the old
> > DDR3 training implementation to fix those issues by setting the
> > environment variable
> >    env set omnia_ddr3_training old
> >    env save
> >=20
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > ---
> >   arch/arm/mach-mvebu/Kconfig                   |  1 +
> >   board/CZ.NIC/turris_omnia/Makefile            |  1 +
> >   board/CZ.NIC/turris_omnia/old_ddr3_training.c | 79 +++++++++++++++++++
> >   board/CZ.NIC/turris_omnia/turris_omnia.c      |  2 +-
> >   4 files changed, 82 insertions(+), 1 deletion(-)
> >   create mode 100644 board/CZ.NIC/turris_omnia/old_ddr3_training.c =20
>=20
> For turris_omnia_defconfig, this is dropped when compiled:
>=20
> drivers/ddr/marvell/a38x/old/ddr3_debug.c:776:12: warning:=20
> 'ddr3_tip_access_atr' declared 'static' but never defined=20
> [-Wunused-function]
>    776 | static int ddr3_tip_access_atr(u32 dev_num, u32 flag_id, u32=20
> value, u32 **ptr);
>        |            ^~~~~~~~~~~~~~~~~~~

And it also seems that there is still something wrong with this
old DDR training code port. Some boards still experience random bugs
with this, but not with the U-Boot from 2015. :-(
