Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E22606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G967s56r;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KAzr1lfx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E75C80E33;
	Mon,  2 Nov 2026 11:47:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YjWrsz8jiiNh; Mon,  2 Nov 2026 11:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BC8580DF8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793620066;
	b=iKQO8qVc7C+izD16uM8GQKarrDVxHCp0U1zt1e0L6TCjPKpa5rudrkSqoY3rOe4KVeE1
	 S6D72uUoVgyLg3KX2YqLCNjVGhjEGyu4YLkg8xA3W0vmkBFLZy5G73w9REF3zFfvP24jX
	 dNOO44hozrfUlKtX/rKqWyfhUPWKvUEvCtT3gWK/XnRCDw6ql5MhmXVSr9pIgPA0xGKil
	 mOhVc7LJKGyv7/qXyZWY7bAZDEY+X/xZc27gVoZoUkItjj+9cuwV58CHmSc8YIJJKrVGY
	 2H0iH3OwsCtTeTzRPkRxyCu1nIvuZKR+HaOvH57BrK/c92fnmpAlD81F8fYs1Xwb3Pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793620066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6jIrwCWfM/73IE1fRx3+JLPaGMWY04PIxkrFEWTBRis=;
	b=TCqxfxNKcRPtp0f7MtZSSHM06uHpszxHezuL0OTRrmy04clNvm+/U5XvOSIstUVubscX
	 DGm4gCiJ3qfQqNnlNpiOvRe5IpYzj5iIy6JRhAKDqvfPuCp7ImpZCDI2FDhlsyP3YnyXh
	 DV6cKU0UlOvhy9bonQ+0T9/2Pqjq4zNjTFshFx1YhiPt770a3x0pfAzMwUFVSUOhiKOsN
	 LMehGd1TsdoQEFnCfqWD6kDjK/X6jkdPZksJEbCBysHYI42YTx8eVR/oZ4WwnmV8A5AHO
	 FEUuPIYz/YqUViq+f/MZ+kChK4Gws8XBTJrwBF0NpUL3E7Kw62/hs5tBMPxZ82D2ceQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793620066;
	bh=6jIrwCWfM/73IE1fRx3+JLPaGMWY04PIxkrFEWTBRis=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G967s56rH2R/IQmIm1O/fP5JcKIO7kYKouDruzVIto/0LbhCGvPQKce0l5LEvSIj7
	 IjH9LWd6f8ptqeq8dAhiQe0YWhdEayn8pgWlY31a8Opf2IPwJr143EPDdsE2Wqg2nD
	 HQ/PyqGwIHNp2ftI7fcj4HrP6cK9tO7vS76aZMDiwiDy4zC4CkjM33qBR7W2NXxCsq
	 wvnbBuewv/PGojr+ztBmgMxHiCMyU954uDL0Xlyk7nuSkNCVEoFEPczVGaI+wuqcDO
	 KUBx024n0QTMnpLA4oAsnZ9pLpiCOLzVWjb5R6lAt0odQ7klH/nTOMhwkDKhmzeTlM
	 n908AN8f0VRXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BC8580DF8;
	Mon,  2 Nov 2026 11:47:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D72BFD3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 11:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BCECB400A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 11:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iEnm-nkFmnKW for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 11:47:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 28FD040079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793620063;
 b=cKA3Rn4Mcrkx/hR/LOqsCgTn3yxgWQXV+eTjM3cM49bbhvYtadKAKPZ0E1UAYwr7o73D
 nh1S61W8Tip2OiqCHSMptkBZ91hNTjubGdBXq2OXMPyNGjCG+qDeqG6gx7rWxoVwr4P16
 1VjTilxTd1M3hksxjJX8O2j4Puv+Hocj2H5jCfw35iZIgoMtDHpzw49Zgp9zw8Hum3u2M
 ISHkCDteUkifh5fs8QdIJ3x8VDzsoDhT/onXBhqTbbeeFZ6QJj1nOb7ZY7sO/JmwlOjYJ
 blrZut1Z9D4uFPbRFFAhq3W3GdtBf3FJynlwDtnK9GpOkeCZrGIUFnGymK9h1PhBTiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793620063;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=6jIrwCWfM/73IE1fRx3+JLPaGMWY04PIxkrFEWTBRis=;
 b=UtyN3CEc+MH8W7wdWvdpcMAy2Nn4vEcPsZoWiYyaGRlIN0n1ht734o2aTeyTULIXn4N/
 HDSwcLz7pliO5ttCHfEpXdVw20+etaTN4W3vXEDgBUUVNktIVCb5tYKAg6Fy7FMGBjz0+
 WyMdBnSuafw6BFWt7EoH+WGhs2pZpjozZ14/1g8VdpMGRgyNKbsjmBW81RHE4adjgTCbh
 vVmM5JCAEgjFd7W1iKH923oHvC1mNdp1TM5MpGoWEiR6/HTZknRUcWix3ku9iFl0weyzc
 muUgx5ysGs/G+wq0ZrXFU6HECOgjGee8jj9ku+sx+CbgQCxwyJ0xqS9JlEId6Li348Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=KAzr1lfx; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=KAzr1lfx
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28FD040079
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 11:47:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08AA01FC4;
 Mon,  2 Nov 2026 03:47:38 -0800 (PST)
Received: from e142021.arm.com (unknown [10.57.16.239])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3D9D3F632;
 Mon,  2 Nov 2026 03:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793620061; bh=nR/FSboM1kdNQcftReoViBrMkqqMLHor271rH3y7YwM=;
 h=From:To:Cc:Subject:Date:From;
 b=KAzr1lfxMR/CNdt0wXJrGoJswibAf5vrwYQ0UBN1egnzmbjyMPVR8AEMCpdYYt+mr
 BL5kqmo4Ywg92DCZbxE3vhmiwkBHFPqbORAF0Sil2dvW2IToynDuzCkBoZypHkkpzv
 NMw//kdFrAtdCSGyd0k44R/FQdNRMt38GnI3qfrQ=
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
Subject: Pull request: u-boot-sunxi/master for 2027.01
Date: Mon,  2 Nov 2026 12:47:33 +0100
Message-ID: <20261102114733.3468703-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

please pull these sunxi changes into main. Please note that's the master
branch on the remote side, the main branch is immutable, so I couldn't
push a fix there again.

Not much to report here, some cleanup for some older V3 SoCs, also a PMIC
fix for some Olimex A20 board.
H6 boards with 3GB of DRAM now work again, and the A133 build process gets
adjusted to the now mainlined TF-A support.

There are bigger changes lined up, but they depend on DT bindings which
have not been merged to the kernel repo yet.

Gitlab CI timed out, but worked fine until then.

Thanks,
Andre
===========================================================
The following changes since commit ee9fc27f2a2a43f253a6fe18d7a6f7c4eb0cda3b:

  cmd: mdio: check argc for extended mode (2026-11-01 13:35:30 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sunxi.git master

for you to fetch changes up to 685b13ba1a3c3bac34761d9f4afbac3b05da9f1d:

  sunxi: Reduce inrush current on Olimex OLinuXino-A20-Lime (2026-11-02 01:38:11 +0100)

----------------------------------------------------------------
Andre Przywara (1):
      sunxi: a133: adjust TF-A load address

Christian Ratzenhofer (1):
      sunxi: Reduce inrush current on Olimex OLinuXino-A20-Lime

Jernej Skrabec (1):
      sunxi: dram: only probe DRAM inside the addressable range

Paul Kocialkowski (3):
      sunxi: disable secure SRAM on sun8i platforms missing it
      power: axp: Add default voltages for V3s/V3/S3
      sunxi: Add support for the Lichee Pi Zero with Dock

 arch/arm/cpu/armv7/Kconfig            | 14 ++++++++------
 arch/arm/mach-sunxi/Kconfig           |  2 +-
 arch/arm/mach-sunxi/dram_dw_helpers.c |  4 +++-
 board/sunxi/MAINTAINERS               |  5 +++++
 configs/A20-OLinuXino-Lime_defconfig  |  2 ++
 configs/Bananapi_M2_Ultra_defconfig   |  1 -
 configs/LicheePi_Zero_Dock_defconfig  |  6 ++++++
 configs/LicheePi_Zero_defconfig       |  1 -
 configs/bananapi_m2_berry_defconfig   |  1 -
 configs/netcube_kumquat_defconfig     |  1 -
 configs/pinecube_defconfig            |  3 ---
 drivers/power/Kconfig                 |  8 ++++++--
 12 files changed, 31 insertions(+), 17 deletions(-)
 create mode 100644 configs/LicheePi_Zero_Dock_defconfig
