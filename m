Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB448CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5445984865;
	Mon, 25 May 2026 04:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="V2lerNBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F408039B; Mon, 25 May 2026 03:29:52 +0200 (CEST)
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E674D83DA6
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779672590; x=1779931790;
 bh=wOmo6D0x0bHhC7ivHYVCZSiEcZfRaHU4ebBNb8RmwZ4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=V2lerNBXWGon3TsSUw4u19WZz6OaFAt9orAugQdUftY1azE+eu/jWsFmLA5vSgaCK
 UVlWA6upaLXyyu8fBOD12ikQcp5TFNTP1zxikEAl6tEb1Ktzu/c12pZ6tq47LEdNLp
 ftwhGEXL9OWKbP2AC5gMWPa0c6bJuHSWBi0LUUORLlWXoyQw7bMu0pe7wCDvWZGIB8
 IU6rsa1wNAd8Gbn8+GRASeB4RUeK90AywYKlmru/Hvo2sDisIjJJgpNjF8EX4inb1V
 syJ3G7Ux6KoXyIIMjIyk2KrqPqXRVmnEb97wpsOkNVE92Q9MmBnQdFlXwKTPtpOLVI
 ioGdJbg9E+V0A==
Date: Mon, 25 May 2026 01:29:47 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 12/14] arm: dts: rk3576: add DMC reg spaces and DDR GRF
 syscon node
Message-ID: <20260525012824.121-13-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 6bad86db9f2e3f5a3290fbfa7b5b2b4d1e323d61
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

Two additions needed for BLOB-free TPL DRAM init:

1. DMC reg/reg-names (W13): add the four MMIO regions that the DRAM
   driver maps at probe time:
     - ddrctl0  0x28000000 / 16 MB  (uMCTL2 ch0, TRM Part 1)
     - ddrctl1  0x29000000 / 16 MB  (uMCTL2 ch1)
     - ddrphy0  0x2a020000 / 64 KB  (combo PHY ch0)
     - ddrphy1  0x2a030000 / 64 KB  (combo PHY ch1)

2. DDR GRF syscon node (W14): the DDR Global Register File at
   0x26012000 is not present in the upstream kernel DTS (it is an
   RK3576-specific block controlling PHY clock gating, LPDDR5 CS
   toggle and the dfi_init_complete mux).  Add it as a u-boot-only
   syscon node with bootph-all so it is available in TPL.

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 arch/arm/dts/rk3576-u-boot.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.d=
tsi
index 018c9cc8d69..881a594ce5c 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -15,9 +15,22 @@
 =09=09u-boot,spl-boot-order =3D "same-as-spl", &sdmmc, &sdhci;
 =09};
=20
-=09dmc {
+=09/* DDR Global Register File =E2=80=94 TRM Part 1, Table 1-1; no upstrea=
m node */
+=09ddr_grf: syscon@26012000 {
+=09=09compatible =3D "rockchip,rk3576-ddr-grf", "syscon";
+=09=09reg =3D <0x0 0x26012000 0x0 0x2000>;
+=09=09bootph-all;
+=09};
+
+=09dmc: dmc {
 =09=09compatible =3D "rockchip,rk3576-dmc";
 =09=09bootph-all;
+=09=09/* TRM Part 1, Table 1-1 */
+=09=09reg =3D <0x0 0x28000000 0x0 0x1000000>,=09/* DDRCTL0 (uMCTL2 ch0) */
+=09=09      <0x0 0x29000000 0x0 0x1000000>,=09/* DDRCTL1 (uMCTL2 ch1) */
+=09=09      <0x0 0x2a020000 0x0 0x10000>,=09/* DDRPHY0 */
+=09=09      <0x0 0x2a030000 0x0 0x10000>;=09/* DDRPHY1 */
+=09=09reg-names =3D "ddrctl0", "ddrctl1", "ddrphy0", "ddrphy1";
 =09};
 };
=20
--=20
2.45.1.windows.1


