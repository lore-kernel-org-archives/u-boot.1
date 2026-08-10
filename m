Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324BAC5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35B3340565;
	Mon, 10 Aug 2026 22:36:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id woVDo_Cubr4T; Mon, 10 Aug 2026 22:36:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AC3A406DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786401378;
	bh=POrGjUrEFByW6g5ZbvHJmSDH+o5yyzrSeVlAVppgLEQ=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AKRjLXoEt+8A6jAvqSTL9AR/ViTBKi2CC/jJTjq90zsAHmZ+64r5ZN/CwmngL+ha5
	 r14GCvnETDj+0JAG5mcI0RihFPXSjJRxRr/Kl0x34iN5RHTHk9xG29jb2/fPmzyIA0
	 I83fRdT2l95GZUa6IzbiKwPU1mtv3wBH8cudaRQXrQO3V/syhJgDVi/yNACJeiMNIV
	 xtp1wK26bIEmlnIpTRu+Fcp9yqNcwZNZX8s+X+hdHaqLNFBKXEqdoIJ3yadzssuoRG
	 y410bwmfpZxaZ39a3RqJURva6C0mwUA41/qrGns5SGGV34kykP5EZ2hUJKeCklYF5C
	 tUXWQIKcBNzTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AC3A406DB;
	Mon, 10 Aug 2026 22:36:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D7A31AF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54557406D0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k0JdVH81sg8T for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:36:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4A09F406C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A09F406C0
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A09F406C0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:15 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hJqNY0xxJzMlJ9;
 Tue, 11 Aug 2026 00:36:13 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] remoteproc: renesas: rsip: Extract SCP initialization
 from board file
Date: Tue, 11 Aug 2026 00:35:04 +0200
Message-ID: <20260810223604.1333043-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
References: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cgxn3ofb35f57ogkkfuf4qcxn1np3gx1
X-MBO-RS-ID: 50e08b7f9684508ff93
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=POrGjUrEFByW6g5ZbvHJmSDH+o5yyzrSeVlAVppgLEQ=;
 b=dMuRDAoz9N8yAktnHSqBh78NwxislU5FAO4L1flTKrHTRFCpB2oUpKvkA+1PekZ7Uf8S0z
 pRoAhOh+RyH/aRZ2RYe0AbgAvmpPCvikUL6icwFXVEoi+0z3Shgi/tugzYVDki9hU0VGn4
 IIiuuccj3V4R/V6DrH/2rGBRUMvGNAuaZ01sE1xzDr6IGo/8t6R3l9NzCYrWhxiaaQiMG/
 0O+Ecjw6enoW98Sg/xvr3AqdPxUJHl72sjxvaWi7ImynK9AKWmBvHkAGEFaHk9IUq0hJ8Q
 q1/2h38cJl6gXys37n02xH0lyb1TproXMH+38aw/aPl5A4tjjWvb34xaaqHqtA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=POrGjUrEFByW6g5ZbvHJmSDH+o5yyzrSeVlAVppgLEQ=;
 b=joGHGpL+jTR3wNszFyqDvEqz8HaqeieiOeFQKc917kDx7yLgpPphoePiaigxCDvuedLtia
 NLkWGVtQJHYEMpEylHANS30WdL/VHZ4lCpD2vXb0dBGIP79pKNplJCla+dvdh3ZRfE2UPh
 JHlZ/K1Pe1mxChaXNOBdTGFIz9Azvhwa2XydWGjKgGa9LFufrZizwJ8SPIfCLF+w1yFYE6
 PpkJ5TveNlmsHUoA4Bh/BWBaxbO5pJL/40/37VkfAZX7JcHm1xSccYpd7quI0QePN4R91H
 jEgDk01gWwNv1T6C+laYUj3DtbQJr6rLA8BSH5plJwRVjhaMX+aln4UQaLyIYQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=dMuRDAoz; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=joGHGpL+
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Move the SCP initialization from board file into remoteproc driver
where this is supposed to be. Add SCP MDLC DT node and describe the
SCP reset controlled by the SCP MDLC in remoteproc DT node. Adjust
the driver to control the SCP reset via reset framework instead of
the current board-specific register poking.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 .../dts/r8a78000-ironhide-cm33-u-boot.dtsi    |  1 +
 arch/arm/dts/r8a78000-u-boot.dtsi             |  8 +++
 board/renesas/common/gen5-cm33.c              | 70 -------------------
 drivers/remoteproc/renesas_rsip.c             | 45 ++++++++++++
 .../dt-bindings/reset/r8a78000-reset-scmi.h   |  2 +
 5 files changed, 56 insertions(+), 70 deletions(-)

diff --git a/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi b/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi
index 872cbfdbad6..5a76d9740a0 100644
--- a/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi
@@ -90,6 +90,7 @@
 	scp@c1340000 {
 		compatible = "renesas,r8a78000-rproc";
 		reg = <0 0xc1340000 0 0x80000>;
+		resets = <&mdlc_scp SCP_RESET_DOMAIN_ID_SCP>;
 	};
 
 	ram@e9800000 {	/* DBSC5 */
diff --git a/arch/arm/dts/r8a78000-u-boot.dtsi b/arch/arm/dts/r8a78000-u-boot.dtsi
index df21a9e03a2..67da58f6474 100644
--- a/arch/arm/dts/r8a78000-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-u-boot.dtsi
@@ -170,6 +170,14 @@
 		bootph-all;
 	};
 
+	mdlc_scp: system-controller@c1330000 {
+		compatible = "renesas,r8a78000-mdlc";
+		reg = <0 0xc1330000 0 0x1000>;
+		#power-domain-cells = <1>;
+		#reset-cells = <1>;
+		bootph-all;
+	};
+
 	i2c0: i2c@c11d0000 {
 		compatible = "renesas,i2c-r8a78000",
 			     "renesas,rcar-gen5-i2c";
diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/gen5-cm33.c
index b2f6087a943..f532daa16d5 100644
--- a/board/renesas/common/gen5-cm33.c
+++ b/board/renesas/common/gen5-cm33.c
@@ -535,12 +535,6 @@ static void clk_control_set_pll(void)
 #define MDLC_HSCN_BASE				0xc9c90000
 /* The addresses in range 0x08000000..0x1fffffff are incremented by 0xa0000000 */
 #define MDLC_RT_BASE				0xb9440000
-#define MDLC_SCP_BASE				0xc1330000
-
-#define MDLC_SCP_MSRES02			(MDLC_SCP_BASE + 0x908)
-#define MDLC_SCP_MSRESS02			(MDLC_SCP_BASE + 0x968)
-#define MDLC_SCP_MSRES02_SCP_MASK		GENMASK(1, 0)
-#define MDLC_SCP_PKCPROT1			(MDLC_SCP_BASE + 0xcf4)
 
 #define MDLC_PERW_MSRES05			(MDLC_PERW_BASE + 0x914)
 #define MDLC_PERW_MSRESS05			(MDLC_PERW_BASE + 0x974)
@@ -668,32 +662,6 @@ static void mdlc_rmw_msres(const u32 prot, const u32 res, const u32 mask, const
 	mdlc_write_msres(prot, res, reg);
 }
 
-/**
- * mdlc_set_reset() - Set IP into reset
- * @prot: Protect register
- * @res: Reset register
- * @stat: Reset register
- * @mask: Mask in the register to clear
- */
-static void mdlc_set_reset(const u32 prot, const u32 res, const u32 stat, const u32 mask)
-{
-	u32 status;
-
-	mdlc_wait_for_reset(res, stat);
-
-	status = field_get(mask, readl(stat));
-	if (status == MDLC_MSRESS_STOP) {
-		mdlc_rmw_msres(prot, res, mask, MDLC_MSRESS_STANDBY);
-		mdlc_wait_for_reset(res, stat);
-		status = field_get(mask, readl(stat));
-	}
-
-	if (status == MDLC_MSRESS_STANDBY || status == MDLC_MSRESS_RUN) {
-		mdlc_rmw_msres(prot, res, mask, MDLC_MSRESS_RESET);
-		mdlc_wait_for_reset(res, stat);
-	}
-}
-
 /**
  * mdlc_release_reset() - Release IP from reset
  * @prot: Protect register
@@ -1260,41 +1228,6 @@ static void load_perm_tables(void)
 	writel(0xffffffff, 0xe9a081fc);
 }
 
-#define SCP_STCM_BASE				0xc1000000
-#define SCP_BASE				0xc1340000
-#define SCP_CFGVECTABLE				(SCP_BASE + 0x0)
-#define SCP_CFGNSSTCALIB			(SCP_BASE + 0x10)
-#define SCP_CPUWAIT				(SCP_BASE + 0x30)
-#define SCP_CFGNSSTCALIB_13_3MHZ		0x010040f0
-#define SCP_CPUWAIT_WAIT			BIT(0)
-
-/**
- * scp_initialize() - Initialize SCP
- *
- * Put SCP into reset, configure SCP entry point address and systick timer,
- * release SCP from reset, and zero out SCP STCM regions.
- */
-static void scp_initialize(void)
-{
-	u32 addr;
-
-	mdlc_set_reset(MDLC_SCP_PKCPROT1, MDLC_SCP_MSRES02, MDLC_SCP_MSRESS02,
-		       MDLC_SCP_MSRES02_SCP_MASK);
-
-	writel(SCP_STCM_BASE, SCP_CFGVECTABLE);
-	writel(SCP_CFGNSSTCALIB_13_3MHZ, SCP_CFGNSSTCALIB);
-	setbits_le32(SCP_CPUWAIT, SCP_CPUWAIT_WAIT);
-
-	mdlc_release_reset(MDLC_SCP_PKCPROT1, MDLC_SCP_MSRES02, MDLC_SCP_MSRESS02,
-			   MDLC_SCP_MSRES02_SCP_MASK);
-
-	/* Fill zero to SCP STCM regions 0 ... 27 */
-	for (addr = SCP_STCM_BASE; addr < 0xc1061b00; addr += 8)
-		writeq(0, addr);
-
-	asm volatile("dsb sy");
-}
-
 #define GIC720AE_GICR_PWRR(cpu)					\
 	(GICR_BASE + 0x24 + ((cpu) * 0x40000))
 
@@ -1362,9 +1295,6 @@ int mach_cpu_init(void)
 	load_perm_tables();
 	gic720ae_init();
 
-	/* Release SCP from reset */
-	scp_initialize();
-
 	return 0;
 }
 
diff --git a/drivers/remoteproc/renesas_rsip.c b/drivers/remoteproc/renesas_rsip.c
index cabcc2822bd..cbf999e88f2 100644
--- a/drivers/remoteproc/renesas_rsip.c
+++ b/drivers/remoteproc/renesas_rsip.c
@@ -13,6 +13,7 @@
 #include <linux/sizes.h>
 #include <malloc.h>
 #include <remoteproc.h>
+#include <reset.h>
 
 /* R-Car X5H contains 1 SCP core, 6 lockstep Cortex-R52 and 32 Cortex-A720AE cores. */
 #define RCAR5_SCP_CORES			1
@@ -20,6 +21,9 @@
 #define RCAR5_CA720_CORES		32
 
 #define SCP_BASE			0xc1340000
+#define SCP_CFGVECTABLE			(SCP_BASE + 0x0)
+#define SCP_CFGNSSTCALIB		(SCP_BASE + 0x10)
+#define SCP_CFGNSSTCALIB_13_3MHZ	0x010040f0
 #define SCP_CPUWAIT			(SCP_BASE + 0x30)
 #define SCP_CPUWAIT_WAIT		BIT(0)
 #define SCP_STCM			0xc1000000
@@ -248,6 +252,32 @@ static int renesas_rsip_rproc_is_running(struct udevice *dev)
  */
 static int renesas_rsip_rproc_init(struct udevice *dev)
 {
+	struct renesas_rsip_rproc_privdata *priv = dev_get_priv(dev);
+	struct reset_ctl *rst = dev_get_priv(dev->parent);
+	u32 addr;
+
+	if (priv->core_id != 0)	/* No init for non-SCP cores */
+		return 0;
+
+	/*
+	 * Put SCP into reset, configure SCP entry point address and systick
+	 * timer, release SCP from reset, and zero out SCP STCM regions.
+	 */
+
+	reset_assert(rst);
+
+	writel(SCP_STCM, SCP_CFGVECTABLE);
+	writel(SCP_CFGNSSTCALIB_13_3MHZ, SCP_CFGNSSTCALIB);
+	setbits_le32(SCP_CPUWAIT, SCP_CPUWAIT_WAIT);
+
+	reset_deassert(rst);
+
+	/* Fill zero to SCP STCM regions 0 ... 27 */
+	for (addr = SCP_STCM; addr < 0xc1061b00; addr += 8)
+		writeq(0, addr);
+
+	asm volatile("dsb sy");
+
 	return 0;
 }
 
@@ -299,6 +329,19 @@ U_BOOT_DRIVER(renesas_rsip_core) = {
 	.priv_auto	= sizeof(struct renesas_rsip_rproc_privdata),
 };
 
+/**
+ * renesas_rsip_rproc_probe() - Common rproc driver probe
+ * @dev:	corresponding remote processor parent device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_rsip_rproc_probe(struct udevice *parent)
+{
+	struct reset_ctl *rst = dev_get_priv(parent);
+
+	return reset_get_by_index(parent, 0, rst);
+}
+
 /**
  * renesas_rsip_rproc_bind() - Bind rproc driver to each core control
  * @dev:	corresponding remote processor parent device
@@ -358,4 +401,6 @@ U_BOOT_DRIVER(renesas_rsip_rproc) = {
 	.of_match	= renesas_rsip_rproc_ids,
 	.id		= UCLASS_NOP,
 	.bind		= renesas_rsip_rproc_bind,
+	.probe		= renesas_rsip_rproc_probe,
+	.priv_auto	= sizeof(struct reset_ctl),
 };
diff --git a/include/dt-bindings/reset/r8a78000-reset-scmi.h b/include/dt-bindings/reset/r8a78000-reset-scmi.h
index 3d84bfb073a..bf8c1b710f0 100644
--- a/include/dt-bindings/reset/r8a78000-reset-scmi.h
+++ b/include/dt-bindings/reset/r8a78000-reset-scmi.h
@@ -24,4 +24,6 @@
 #define SCP_RESET_DOMAIN_ID_MPPHY31	0x67
 #define SCP_RESET_DOMAIN_ID_MPPHY02	0x68
 
+#define SCP_RESET_DOMAIN_ID_SCP		0x20
+
 #endif /* __DT_BINDINGS_R8A78000_SCMI_RESET_H__ */
-- 
2.53.0

