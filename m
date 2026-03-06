Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AD5F01812
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 08:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D33B883F7F;
	Fri,  6 Mar 2026 09:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="GZEl3vtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 676D1839A8; Fri,  6 Mar 2026 09:58:43 +0100 (CET)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB8783F98
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 09:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1772787520; x=1773046720;
 bh=L6oRhtrGCxl6uQOwOEDFJO5XM2tombOwEVBbHxnNcK8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=GZEl3vtGLtg9/77Q04mVv0TUQsDu9/0tLcOlOObw2hkbkkdJW5iP2/r0NhXNbKmPL
 Hpfcf8h91kFbaPHQ1Dzd6VuJpsopcrgvufPyqbF59gxK5B+z0LjoNOfySNH2OY//NV
 wvKWOp3doSENOFdGM3dgptAsOVHpVGorautQcYPNDG5c+eaEZwlqUcu2KOD8YV1R2Y
 6hU5eNsdXBP5mH3t1mc4cw7T7DmSMT5ssQZkPEy8gKt3+mPUGE9hk+zKsEN82gOBJ3
 dkvQ69HO5iXoG2qvfs3dYejzQjPEGGNNmOv3KuRZjVsGegbWHkxNcuM5ZCg32kUwYY
 ENvoDB6XENEUQ==
Date: Fri, 06 Mar 2026 08:58:38 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip.molloy@analog.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] ddr: imx: Remove unused macros
Message-ID: <20260306085824.886254-4-philip@philipmolloy.com>
In-Reply-To: <20260306085824.886254-1-philip@philipmolloy.com>
References: <20260306085824.886254-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 5945549702b9fb6cbead913fb1122ba9dba72506
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

From: Philip Molloy <philip.molloy@analog.com>

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---

 arch/arm/include/asm/arch-imx8m/ddr.h | 1 -
 arch/arm/include/asm/arch-imx9/ddr.h  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx8m/ddr.h b/arch/arm/include/asm/a=
rch-imx8m/ddr.h
index bf2d1f6bc40..47086d6b9f1 100644
--- a/arch/arm/include/asm/arch-imx8m/ddr.h
+++ b/arch/arm/include/asm/arch-imx8m/ddr.h
@@ -13,7 +13,6 @@
 #define DDRC_DDR_SS_GPR0=09=090x3d000000
 #define DDRC_IPS_BASE_ADDR_0=09=090x3f400000
 #define IP2APB_DDRPHY_IPS_BASE_ADDR(X)=09(0x3c000000 + (X * 0x2000000))
-#define DDRPHY_MEM(X)=09=09=09(0x3c000000 + (X * 0x2000000) + 0x50000)
=20
 struct ddrc_freq {
 =09u32 res0[8];
diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/ar=
ch-imx9/ddr.h
index f6ae3baf3b0..6c2069b9707 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -35,7 +35,6 @@
 #define REG_SRC_DPHY_SINGLE_RESET_SW_CTRL=09(SRC_DPHY_BASE_ADDR + 0x24)
=20
 #define IP2APB_DDRPHY_IPS_BASE_ADDR(X)=09(DDR_PHY_BASE + ((X) * 0x2000000)=
)
-#define DDRPHY_MEM(X)=09=09=09(DDR_PHY_BASE + ((X) * 0x2000000) + 0x50000)
=20
 /* PHY State */
 enum pstate {
--=20
2.53.0


