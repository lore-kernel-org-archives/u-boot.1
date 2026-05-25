Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C573DCD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A13847AF;
	Mon, 25 May 2026 04:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="V5DyaGEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7907883EF9; Mon, 25 May 2026 03:29:17 +0200 (CEST)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2068039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=qgz2mric3fferdau45izurnf74.protonmail; t=1779672555; x=1779931755;
 bh=YDuaC9QVr6q8o5rQM8mzpHMt9Jaidz4BzOTUSKYvoX8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=V5DyaGEggOFFI5CkN6TH7fTEkrfXkocUxeVe3DKVuEnU4qQbT7BHyya2AVavHuvrr
 2jz0F0n1FZeUZKPpyGYLS8rQQJICKEDbrxBG4dhi5BfsjdPM6GQSuDA1Z76bH0VcCK
 mMZODJ7KfAO5sxU0M/DJSyiOk64gLYhX8Hi14cxbHlAmrVbjt9BiilH8dumCUTxw6r
 Z6LbSt0Sr/KQ8BOPFenPyL28vpwQP+qbNjGpRi0/MbSHKNEHPIPbhqrSVxoa8CCIEH
 Z7m2QGZsH8RPtRJkVw7W/3e5BWfYRK1G1qcIpK3SX94IcXGy0HmGOKrD9wd9TES1e4
 J/6D4DrR/3iwg==
Date: Mon, 25 May 2026 01:29:10 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 05/14] ram: rockchip: sdram_common: add LPDDR4X and
 LPDDR5 support
Message-ID: <20260525012824.121-6-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 2ba9e253111c8ff03aaa1a82319ed16d8ea52e8d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 May 2026 04:30:57 +0200
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

sdram_print_dram_type() and sdram_detect_dbw() only handled types up to
LPDDR4.  Adding RK3576 with LPDDR5 exposes two gaps:

1. sdram_print_dram_type(): LPDDR4X (8) and LPDDR5 (9) fell through to
   "Unknown Device".  Add the missing cases.

2. sdram_detect_dbw(): the fixed-dbw=3D1 branch covered DDR3 and LPDDR4
   but not LPDDR4X or LPDDR5 (both use x16 dies =E2=86=92 dbw=3D1).  Extend=
 the
   condition to include the new types.

LPDDR4X and LPDDR5 enum values are already defined in sdram.h as 8
and 9 respectively.

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 drivers/ram/rockchip/sdram_common.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/sdr=
am_common.c
index b7a8fce607c..777e1044b40 100644
--- a/drivers/ram/rockchip/sdram_common.c
+++ b/drivers/ram/rockchip/sdram_common.c
@@ -29,6 +29,12 @@ void sdram_print_dram_type(unsigned char dramtype)
 =09case LPDDR4:
 =09=09printascii("LPDDR4");
 =09=09break;
+=09case LPDDR4X:
+=09=09printascii("LPDDR4X");
+=09=09break;
+=09case LPDDR5:
+=09=09printascii("LPDDR5");
+=09=09break;
 =09default:
 =09=09printascii("Unknown Device");
 =09=09break;
@@ -285,13 +291,14 @@ int sdram_detect_bg(struct sdram_cap_info *cap_info,
 =09return 0;
 }
=20
-/* detect dbw for ddr3,lpddr2,lpddr3,lpddr4 */
+/* detect dbw for ddr3,lpddr2,lpddr3,lpddr4,lpddr4x,lpddr5 */
 int sdram_detect_dbw(struct sdram_cap_info *cap_info, u32 dram_type)
 {
 =09u32 row, col, bk, bw, cs_cap, cs;
 =09u32 die_bw_0 =3D 0, die_bw_1 =3D 0;
=20
-=09if (dram_type =3D=3D DDR3 || dram_type =3D=3D LPDDR4) {
+=09if (dram_type =3D=3D DDR3 || dram_type =3D=3D LPDDR4 ||
+=09    dram_type =3D=3D LPDDR4X || dram_type =3D=3D LPDDR5) {
 =09=09cap_info->dbw =3D 1;
 =09} else if (dram_type =3D=3D LPDDR3 || dram_type =3D=3D LPDDR2) {
 =09=09row =3D cap_info->cs0_row;
--=20
2.45.1.windows.1


