Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1EFC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 09:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381378824B;
	Wed, 15 May 2024 11:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="koOX4PqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C3B881D6; Wed, 15 May 2024 11:24:42 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 785C68824B
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 11:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 65C86CE0A12;
 Wed, 15 May 2024 09:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E6FC116B1;
 Wed, 15 May 2024 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715765075;
 bh=hT3vTOAaIkshrP9d2Ce3z2RUtW1ZrCA5+kqxAkYSKyM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=koOX4PqJKVaRUc+ri4gb5BK5DGx64GWAuTzjRYVM6ye5qrq7LtORDgLPRLydF2dDQ
 HVFc3W9ZdfDoh6vHZzQRgtlThBTX8reziSKZse0gX7w8AL9AI326RYjK4vwyObOxqn
 iK72R999oHP41ry4pJZcwiZMiNp+6AubNE2qRu8eI8DduZuldWJ5qOmVioCgdxriwh
 v0Xgo53FMwNakjwjOcadrkxEsP4nQ5M2niJeYClYdjq0wIlRFcig/PEpXZ62Cyuq6D
 q/cqlP2YulwzgiM9SYWq+dO+AJ0PUiyCN8UGIPyZXdD6Dk1xqZeYERq0KCQssPi3SD
 M0cdADPlbQlfg==
Date: Wed, 15 May 2024 11:24:31 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH u-boot-mvebu 10/10] arm: mvebu: turris_omnia: Support
 old DDR3 training, selectable via env var
Message-ID: <20240515112431.5ba3f2a0@dellmb>
In-Reply-To: <8ea997c2-e164-4ea1-9a75-28bbf159827b@denx.de>
References: <20240415163043.7482-1-kabel@kernel.org>
 <20240415163043.7482-11-kabel@kernel.org>
 <149e251a-baa7-4512-990a-d332d0d6177f@denx.de>
 <20240515105906.3cfca4fb@dellmb>
 <8ea997c2-e164-4ea1-9a75-28bbf159827b@denx.de>
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

On Wed, 15 May 2024 11:10:09 +0200
Stefan Roese <sr@denx.de> wrote:

> Hi Marek,
>=20
> On 5/15/24 10:59, Marek Beh=C3=BAn wrote:
> > On Mon, 6 May 2024 12:03:55 +0200
> > Stefan Roese <sr@denx.de> wrote:
> >  =20
> >> Hi Marek,
> >>
> >> On 4/15/24 18:30, Marek Beh=C3=BAn wrote: =20
> >>> Support old DDR3 training code on Turris Omnia, selectable by U-Boot
> >>> enviroment variable.
> >>>
> >>> Users experiencing DDR3 initialization failures or random crashes of =
the
> >>> operating system due to incorrect DDR3 configuration can select the o=
ld
> >>> DDR3 training implementation to fix those issues by setting the
> >>> environment variable
> >>>     env set omnia_ddr3_training old
> >>>     env save
> >>>
> >>> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> >>> ---
> >>>    arch/arm/mach-mvebu/Kconfig                   |  1 +
> >>>    board/CZ.NIC/turris_omnia/Makefile            |  1 +
> >>>    board/CZ.NIC/turris_omnia/old_ddr3_training.c | 79 +++++++++++++++=
++++
> >>>    board/CZ.NIC/turris_omnia/turris_omnia.c      |  2 +-
> >>>    4 files changed, 82 insertions(+), 1 deletion(-)
> >>>    create mode 100644 board/CZ.NIC/turris_omnia/old_ddr3_training.c =
=20
> >>
> >> For turris_omnia_defconfig, this is dropped when compiled:
> >>
> >> drivers/ddr/marvell/a38x/old/ddr3_debug.c:776:12: warning:
> >> 'ddr3_tip_access_atr' declared 'static' but never defined
> >> [-Wunused-function]
> >>     776 | static int ddr3_tip_access_atr(u32 dev_num, u32 flag_id, u32
> >> value, u32 **ptr);
> >>         |            ^~~~~~~~~~~~~~~~~~~ =20
> >=20
> > And it also seems that there is still something wrong with this
> > old DDR training code port. Some boards still experience random bugs
> > with this, but not with the U-Boot from 2015. :-( =20
>=20
> Hmmm, strange.
>=20
> How to continue? Are these "old DDR training patches" on hold for now?

The first 5 patches should be fine, the "old DDR training" comes in the
second half. Is it possible to merge only the first 5? And also the one
patch I sent on April 30:
  arm: mvebu: turris_omnia: Fix ethernet PHY reset gpio FDT fixup

Marek
