Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4290F01812
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 08:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C30F83FB2;
	Fri,  6 Mar 2026 09:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="HY6Td4m0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B7383F9B; Fri,  6 Mar 2026 09:58:49 +0100 (CET)
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A50C1839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 09:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1772787527; x=1773046727;
 bh=zwGZxuSbnp5xiIy6fx7GKsFOMdUtaxj1ACVNviRAaC4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=HY6Td4m05+8O+fCfAwEzlZXLiGxhm5BdM2nzh/53RTjCvse5L1ZMr2iW0MOmn8tjM
 qljR2vRfQBHtcoZ0U8vMFqPMHCKDLFDuEJinAgTFTxdWmoQCgfaNsUpe5Uhehk0y30
 R2RuewYLe1yxCiLdt8YTUniDq4U3fqCWMsJZKfSLnLHlOqGQzxNje0RNjhUM8OR06I
 nd7KU1ixZ/PsbuhlHa/FMVErzQ0zR7/XHtjTunUEY64hvIneKyCyg0LEcvOKU2mwxK
 /bvM0GuukxjFDaRVzbQ4C4a8Y9enjC824vZgAKZy+kSaspmGkryITx6J+r114JxHcI
 NUL1JT/M4xEYQ==
Date: Fri, 06 Mar 2026 08:58:43 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip.molloy@analog.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] ddr: imx: Remove unnecessary macro argument
Message-ID: <20260306085824.886254-5-philip@philipmolloy.com>
In-Reply-To: <20260306085824.886254-1-philip@philipmolloy.com>
References: <20260306085824.886254-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: e2c4429d6d4672c45ceb54d2201c8c8a2d9548fa
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

IP2APB_DDRPHY_IPS_BASE_ADDR() is always passed 0, which is then
multiplied by 0x2000000. Since that results in adding 0 to the base
address, remove 0x2000000 and the argument entirely. Instead use
DDR_PHY_BASE, which was already defined in imx9. Add the missing
definition to imx8m.

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---

 arch/arm/include/asm/arch-imx8m/ddr.h |  8 ++++----
 arch/arm/include/asm/arch-imx9/ddr.h  |  6 ++----
 drivers/ddr/imx/imx8m/ddr_init.c      |  8 ++++----
 drivers/ddr/imx/phy/ddrphy_utils.c    | 14 +++++++-------
 drivers/ddr/imx/phy/helper.c          |  2 +-
 5 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx8m/ddr.h b/arch/arm/include/asm/a=
rch-imx8m/ddr.h
index 47086d6b9f1..63c3aa682aa 100644
--- a/arch/arm/include/asm/arch-imx8m/ddr.h
+++ b/arch/arm/include/asm/arch-imx8m/ddr.h
@@ -10,9 +10,9 @@
 #include <asm/types.h>
 #include <asm/arch/imx-regs.h>
=20
+#define DDR_PHY_BASE=09=09=090x3c000000
 #define DDRC_DDR_SS_GPR0=09=090x3d000000
 #define DDRC_IPS_BASE_ADDR_0=09=090x3f400000
-#define IP2APB_DDRPHY_IPS_BASE_ADDR(X)=09(0x3c000000 + (X * 0x2000000))
=20
 struct ddrc_freq {
 =09u32 res0[8];
@@ -635,7 +635,7 @@ enum msg_response {
 #define DDRC_DFITMG3_SHADOW(X)         (DDRC_IPS_BASE_ADDR(X) + 0x21b8)
 #define DDRC_ODTCFG_SHADOW(X)          (DDRC_IPS_BASE_ADDR(X) + 0x2240)
=20
-#define DDRPHY_CalBusy(X) (IP2APB_DDRPHY_IPS_BASE_ADDR(X) + 4 * 0x020097)
+#define DDRPHY_CalBusy (DDR_PHY_BASE + 4 * 0x020097)
=20
 #define DRC_PERF_MON_BASE_ADDR(X)            (0x3d800000 + ((X) * 0x200000=
0))
 #define DRC_PERF_MON_CNT0_CTL(X)             (DRC_PERF_MON_BASE_ADDR(X) + =
0x0)
@@ -741,8 +741,8 @@ static inline void reg32setbit(unsigned long addr, u32 =
bit)
 }
=20
 #define dwc_ddrphy_apb_wr(addr, data) \
-=09reg32_write(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(addr), d=
ata)
+=09reg32_write(DDR_PHY_BASE + ddrphy_addr_remap(addr), data)
 #define dwc_ddrphy_apb_rd(addr) \
-=09reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(addr))
+=09reg32_read(DDR_PHY_BASE + ddrphy_addr_remap(addr))
=20
 #endif
diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/ar=
ch-imx9/ddr.h
index 6c2069b9707..b6090a20a4d 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -34,8 +34,6 @@
 #define REG_SRC_DPHY_SW_CTRL=09=09(SRC_DPHY_BASE_ADDR + 0x20)
 #define REG_SRC_DPHY_SINGLE_RESET_SW_CTRL=09(SRC_DPHY_BASE_ADDR + 0x24)
=20
-#define IP2APB_DDRPHY_IPS_BASE_ADDR(X)=09(DDR_PHY_BASE + ((X) * 0x2000000)=
)
-
 /* PHY State */
 enum pstate {
 =09PS0,
@@ -136,8 +134,8 @@ static inline void reg32setbit(unsigned long addr, u32 =
bit)
 }
=20
 #define dwc_ddrphy_apb_wr(addr, data) \
-=09reg32_write(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(addr), d=
ata)
+=09reg32_write(DDR_PHY_BASE + ddrphy_addr_remap(addr), data)
 #define dwc_ddrphy_apb_rd(addr) \
-=09reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(addr))
+=09reg32_read(DDR_PHY_BASE + ddrphy_addr_remap(addr))
=20
 #endif
diff --git a/drivers/ddr/imx/imx8m/ddr_init.c b/drivers/ddr/imx/imx8m/ddr_i=
nit.c
index e9209ce8b61..39434334205 100644
--- a/drivers/ddr/imx/imx8m/ddr_init.c
+++ b/drivers/ddr/imx/imx8m/ddr_init.c
@@ -168,13 +168,13 @@ void get_trained_CDD(u32 fsp)
 =09ddr_type =3D reg32_read(DDRC_MSTR(0)) & 0x3f;
 =09if (ddr_type =3D=3D 0x20) {
 =09=09for (i =3D 0; i < 6; i++) {
-=09=09=09tmp =3D reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + (0x54013 + i)=
 * 4);
+=09=09=09tmp =3D reg32_read(DDR_PHY_BASE + (0x54013 + i) * 4);
 =09=09=09cdd_cha[i * 2] =3D tmp & 0xff;
 =09=09=09cdd_cha[i * 2 + 1] =3D (tmp >> 8) & 0xff;
 =09=09}
=20
 =09=09for (i =3D 0; i < 7; i++) {
-=09=09=09tmp =3D reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + (0x5402c + i)=
 * 4);
+=09=09=09tmp =3D reg32_read(DDR_PHY_BASE + (0x5402c + i) * 4);
 =09=09=09if (i =3D=3D 0) {
 =09=09=09=09cdd_cha[0] =3D (tmp >> 8) & 0xff;
 =09=09=09} else if (i =3D=3D 6) {
@@ -205,7 +205,7 @@ void get_trained_CDD(u32 fsp)
 =09=09unsigned int ddr4_cdd[64];
=20
 =09=09for (i =3D 0; i < 29; i++) {
-=09=09=09tmp =3D reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + (0x54012 + i)=
 * 4);
+=09=09=09tmp =3D reg32_read(DDR_PHY_BASE + (0x54012 + i) * 4);
 =09=09=09ddr4_cdd[i * 2] =3D tmp & 0xff;
 =09=09=09ddr4_cdd[i * 2 + 1] =3D (tmp >> 8) & 0xff;
 =09=09}
@@ -401,7 +401,7 @@ int ddr_init(struct dram_timing_info *dram_timing)
 =09 * calibrating. Wait Calibrating done.
 =09 */
 =09do {
-=09=09tmp =3D reg32_read(DDRPHY_CalBusy(0));
+=09=09tmp =3D reg32_read(DDRPHY_CalBusy);
 =09} while ((tmp & 0x1));
=20
 =09debug("DDRINFO:ddrphy calibration done\n");
diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrph=
y_utils.c
index b406418840c..22cd091f6ee 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -15,7 +15,7 @@ static inline void poll_pmu_message_ready(void)
 =09unsigned int reg;
=20
 =09do {
-=09=09reg =3D reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_rema=
p(0xd0004));
+=09=09reg =3D reg32_read(DDR_PHY_BASE + ddrphy_addr_remap(0xd0004));
 =09} while (reg & 0x1);
 }
=20
@@ -23,13 +23,13 @@ static inline void ack_pmu_message_receive(void)
 {
 =09unsigned int reg;
=20
-=09reg32_write(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(0xd0031)=
, 0x0);
+=09reg32_write(DDR_PHY_BASE + ddrphy_addr_remap(0xd0031), 0x0);
=20
 =09do {
-=09=09reg =3D reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_rema=
p(0xd0004));
+=09=09reg =3D reg32_read(DDR_PHY_BASE + ddrphy_addr_remap(0xd0004));
 =09} while (!(reg & 0x1));
=20
-=09reg32_write(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(0xd0031)=
, 0x1);
+=09reg32_write(DDR_PHY_BASE + ddrphy_addr_remap(0xd0031), 0x1);
 }
=20
 static inline unsigned int get_mail(void)
@@ -38,7 +38,7 @@ static inline unsigned int get_mail(void)
=20
 =09poll_pmu_message_ready();
=20
-=09reg =3D reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(0=
xd0032));
+=09reg =3D reg32_read(DDR_PHY_BASE + ddrphy_addr_remap(0xd0032));
=20
 =09ack_pmu_message_receive();
=20
@@ -51,9 +51,9 @@ static inline unsigned int get_stream_message(void)
=20
 =09poll_pmu_message_ready();
=20
-=09reg =3D reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(0=
xd0032));
+=09reg =3D reg32_read(DDR_PHY_BASE + ddrphy_addr_remap(0xd0032));
=20
-=09reg2 =3D reg32_read(IP2APB_DDRPHY_IPS_BASE_ADDR(0) + ddrphy_addr_remap(=
0xd0034));
+=09reg2 =3D reg32_read(DDR_PHY_BASE + ddrphy_addr_remap(0xd0034));
=20
 =09reg2 =3D (reg2 << 16) | reg;
=20
diff --git a/drivers/ddr/imx/phy/helper.c b/drivers/ddr/imx/phy/helper.c
index 7b590ef397b..080a6fa1c57 100644
--- a/drivers/ddr/imx/phy/helper.c
+++ b/drivers/ddr/imx/phy/helper.c
@@ -20,7 +20,7 @@ DECLARE_GLOBAL_DATA_PTR;
=20
 #define IMEM_OFFSET_ADDR 0x00050000
 #define DMEM_OFFSET_ADDR 0x00054000
-#define DDR_TRAIN_CODE_BASE_ADDR IP2APB_DDRPHY_IPS_BASE_ADDR(0)
+#define DDR_TRAIN_CODE_BASE_ADDR DDR_PHY_BASE
=20
 binman_sym_declare(ulong, ddr_1d_imem_fw, image_pos);
 binman_sym_declare(ulong, ddr_1d_imem_fw, size);
--=20
2.53.0


