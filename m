Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB80DC982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 09:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8919660BF7;
	Fri, 18 Sep 2026 09:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T0Vl22LcpTfQ; Fri, 18 Sep 2026 09:50:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 519ED60C1D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789725043;
	b=LRVVCnV3nrisVeEbiwi1FdPfbqgYdOex47An64JF1VHhf/g9frjV15iBgB+AqzJ5I1Fh
	 Mu/Y8JCaOLcDvELwJR7DXC7p+h0EemlwhO7aoDqg4XKkCnVZLcOdCymJujgjooUUmbgkj
	 pNTZOFCJ3go0m9DzVLvCk8M/lnoagdE2pIbJ/yBdOA0/BOQy263Yze2NYusYCQ9LHckEV
	 ifQwxQFoFjMkLopcG6kC6l6ZSufnCNjXwAvaHlqic1bxMlfiMM+kXB9cotA4C851jKzD/
	 ga2bU3N3MOpAn30VyiCn13K/bwUZ+0JO8tHlfHTJGMkjwvCw/AsNBY+fZXFmM7iVxBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789725043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cu3GYuLp0MWaMkANVl5A8PCBcQgWtgPv4qho4OalPRU=;
	b=mNRgojrCGO0OBibDLHR5kepNN3ZRinD37xVRK0Homiy3wcLzsfVixynUjX3EIFVIuknW
	 6Lx15/MqOVefSsMhRuX1vabUH/uALLrkpqTqh0a0MXM+HqcoiA3oEAwchVIq8oCGLodVo
	 yq4M10cVNdStzxnWoab7kzUorwm/xneYfofR26EFqK7iqna6Bn7Hjm3Yq8fKW/+PzEVtE
	 0zkB0fJ+HUcvW0E8B1cx65hY5kIOsRc71sey7OfKG6/SHhWqQ8LTGJXPOV2JKj3DPg4IY
	 qa42Rz4+sfAh0gBDBqqiW8KbBPJnEQHT8r31i7SvgI7phKrC7f6PyjNOv9jZqGIcrSw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789725043;
	bh=cu3GYuLp0MWaMkANVl5A8PCBcQgWtgPv4qho4OalPRU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s/F9lYMyizMWpsFa7uD7MW/HplU5Gd4N8/0V7jaRu1kO6DIPzjuZy3LZhjVzBZGue
	 gXBv02EaeNG1xsO11RkGopdC1okuIsR2b4gTuwLli68B1yKyY7Me3iLk+Le5Xz+Q4S
	 c3p+GhKQVNA/fGfL5Lh0g37oG07rJoO9+MdjxCO4f7noI4kUDN5jHf9l3HIrP5LDtL
	 mE9N0KgbHNbvOT+H7//Nh1foY6SxV+NdtdW1p+PlB88GbKFX3Yy41wtU1O1xQfM3xZ
	 bRUmQ+DS3RDSD/nLaFrjarBtQiEQ1OsnF7ZCEN9lisT2JgUIzMi3MZ0sTdd3eK6qM5
	 4Fx4DpqIbwqbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 519ED60C1D;
	Fri, 18 Sep 2026 09:50:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 59CA23B6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BAA5404F1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6doZhedTNRkc for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 09:50:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4A03F404E6
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789725040;
 b=qwcti1mMu1szBuN3m6cH2M513mfd8jYITNVDFonlyg5UrQg2LU/IbSK5BrhHUiikXKX9
 x7c2nt19um0lyI2Eu+yf+mK0P64QN2hhXFX6sdk8UsAM2ok41eON3Oc6NnxkHIG+zJSio
 BMaekkbLG+oqit8FqB8v0FRrVZK+V/dZYwfCaLLC23+/EXsWNBZseZCW0G3kuU7LbuB5B
 oXbOrhgYrPGFfm7gkg7OhZ+QhdT+ReL9WC9V66MMHPC5K+CnJVPCth07/UNjb0ecMhG4B
 JvATYEQeC50LKaa/dMFRVr0C8vybZ5BhsWnbZzJF+3Bhs53+ZxS73xztIMQQZAqZlvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789725040;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=cu3GYuLp0MWaMkANVl5A8PCBcQgWtgPv4qho4OalPRU=;
 b=TY1f8Z5Nq6SsPSX3Lh+ktbVh9HLlH3DvyxmCCWd1jZKk1xQf83vV5ec4AOnq918xS3Ia
 rnFKJJBfo4zsmJ//rm4jkquoqDG9i9b5PvIJkPIPaCX19sXKLveJPj9H3AudNzxWyp5dD
 iReRfdscbky7lHqFscFMXEKDWXjSouQqN94Q838mXXevJ0k7QB86g9IC4tHpqBAQtjHVB
 E8V1XCg9Axrqbl5seSyyw1Go9AbgNT65UaMktrZfPIY1UPwTj7xPTieHbJN9VEbixOCHH
 teHLJGK+26BW0euI4W8wYYpvLeubJSLP8lVqz5OLeDJCITg5cB1cjvzp+tNDPrEL2WA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=mnUXeVl8; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=mnUXeVl8
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A03F404E6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id F2F9FB0054E;
 Fri, 18 Sep 2026 11:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789725036;
 bh=TaTNv6nPuVeZRhDkU2Y0XyCz5gt47/IwtkYzG9T1+w4=;
 h=From:To:Cc:Subject:Date:From;
 b=mnUXeVl8tbQDdt8J2dAas0aZIbwxmIDOwRYr7XG0J1l8gg7Yyyz9pLHZUoCcAJoS3
 6zj4y9aEeohI+Z6sd9vUpd3aXluHGO4at5nRG7ygdMHcOdN4oYI2AhxKUucKqbD1wp
 3RIdWVezjjfKVfTUPjhUsW7cvYrrVvHi6f5c6Lr/hCFkHlUPIs12L0jj/K5eUAvz1y
 Fd6SF3d7ApEZClcEmPhW8InxSmsDfJudP8XA9aNbpWK7KqMO4kU5giGmNavCA3DyBC
 aT3hGgltTDxOqfi68b6Z+nUCecxL2TK67BAsvS/4z/MB+j4mPVVV+nqA2hvL8ST8au
 FwcVfz25ZY6hA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 1/2] power: regulator: mpq8785: avoid scan, use DTS address
Date: Fri, 18 Sep 2026 11:50:25 +0200
Message-ID: <20260918095026.3635222-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

In case we have the "reg" provided by the DTS, let's avoid probing
to avoid "noises" on the i2c bus. Let's run a scan only on purpose
when "mps,auto-probe" is requested.

The scan notes on the mpq tests for the pmbus are irrelevant and they
were using only for the mpq bringup.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 doc/develop/pmbus.rst             |   2 +
 drivers/power/regulator/mpq8785.c | 113 ++++++++++++++++--------------
 2 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/doc/develop/pmbus.rst b/doc/develop/pmbus.rst
index f5550541e83..efc9f9a95e5 100644
--- a/doc/develop/pmbus.rst
+++ b/doc/develop/pmbus.rst
@@ -532,6 +532,8 @@ The per chip quirks that carry over:
   flag for this case.
 * ``mps,vout-fb-divider-ratio-permille`` DT property maps to
   ``VOUT_SCALE_LOOP`` write at probe time.
+* ``mps,auto-probe`` the chip decodes its PMBus address using a scan
+  to find ``MFR_ID = "MPS"``. Ignore ``reg``.
 
 The quirks that do not carry over:
 
diff --git a/drivers/power/regulator/mpq8785.c b/drivers/power/regulator/mpq8785.c
index 72bfaa5bf8c..e8896d7ebad 100644
--- a/drivers/power/regulator/mpq8785.c
+++ b/drivers/power/regulator/mpq8785.c
@@ -11,8 +11,8 @@
  * Hooks the shared pmbus_helper UCLASS_REGULATOR ops + adds the MPS
  * specific identify (VOUT_MODE switch between LINEAR16 and DIRECT
  * m=64 R=1 for the chip's "VID" mode), the MPS vendor extension
- * (pmbus mps last|clear last|clear force), and ADDR_VBOOT auto
- * promotion when the DT declared address fails the MFR_ID probe.
+ * (pmbus mps last|clear last|clear force), and an address scan
+ * ("mps,auto-probe") for the eight MFR_ADDR_PMBUS.
  */
 
 #include <command.h>
@@ -320,39 +320,44 @@ static const struct pmbus_vendor_op mps_vendor_op = {
 		   "pmbus mps clear force  : force clear via MFR_CFG_EXT bit[6] (DESTRUCTIVE)\n",
 };
 
-static void mpq8785_identify_vout(struct udevice *i2c_dev)
+static int mpq8785_identify(struct udevice *i2c_dev)
 {
-	enum pmbus_data_format fmt;
+	u8 vout_mode = 0;
+	int ret;
 
-	/*
-	 * Let the shared helper read VOUT_MODE and pick the base format
-	 * (the single source of truth for the bit layout). The MPS quirk:
-	 * this family encodes VOUT in DIRECT with m=64 R=1 whenever
-	 * VOUT_MODE reports VID *or* DIRECT -- override the helper's
-	 * generic DIRECT m=1 / VID-unwired result in those two modes.
-	 * LINEAR and IEEE754 keep the helper's selection unchanged.
-	 */
-	fmt = pmbus_regulator_identify_vout(i2c_dev, &mpq8785_info);
-	if (fmt == pmbus_fmt_vid || fmt == pmbus_fmt_direct) {
+	ret = pmbus_read_byte(i2c_dev, PMBUS_VOUT_MODE, &vout_mode);
+	if (ret < 0)
+		return ret;
+	if (vout_mode == 0xff)
+		return -ENODEV;
+
+	switch (vout_mode >> 5) {
+	case 0:
+		mpq8785_info.format[PSC_VOLTAGE_OUT] = pmbus_fmt_linear;
+		break;
+	case 1:
+	case 2:
 		mpq8785_info.format[PSC_VOLTAGE_OUT] = pmbus_fmt_direct;
 		mpq8785_info.m[PSC_VOLTAGE_OUT] = 64;
 		mpq8785_info.b[PSC_VOLTAGE_OUT] = 0;
 		mpq8785_info.R[PSC_VOLTAGE_OUT] = 1;
+		break;
+	default:
+		return -ENODEV;
 	}
+	return 0;
 }
 
 /*
- * The MPQ8785 datasheet revision letter changes which window the
- * analog ADDR_VBOOT level resolves to. Boards have been observed at
- * 0x10 (later die rev) versus the 0x20 the original driver assumed.
- * If the DT declared address fails the MFR_ID probe at probe time,
- * walk the three documented windows looking for an MPS responder.
+ * Address selection has two modes, chosen by the DT:
  *
- * Each window covers 16 consecutive 7 bit I2C addresses; the low
- * nibble selects the chip's MFR_ADDR_PMBUS slot within the window.
+ *   default            "reg" is the address. follow the Linux driver.
+ *
+ *   mps,auto-probe     boolean. If set, "reg" is ignored, then
+ *                      scan for MFR_ID="MPS"
  */
-#define MPS_ADDR_VBOOT_WINDOW_SIZE	16
-static const u8 mps_addr_window_starts[] = { 0x10, 0x20, 0x60 };
+#define MPS_ADDR_WINDOWS		8
+#define MPS_ADDR_WINDOW_SIZE		16
 
 static int mpq8785_probe_addr(struct udevice *bus, u8 addr,
 			      struct udevice **chip_out)
@@ -376,12 +381,15 @@ static int mpq8785_probe_addr(struct udevice *bus, u8 addr,
 static int mpq8785_scan_windows(struct udevice *bus, u8 *found_addr,
 				struct udevice **chip_out)
 {
-	unsigned int i, j;
+	unsigned int x, slot;
 
-	for (i = 0; i < ARRAY_SIZE(mps_addr_window_starts); i++) {
-		for (j = 0; j < MPS_ADDR_VBOOT_WINDOW_SIZE; j++) {
-			u8 addr = mps_addr_window_starts[i] + j;
+	for (x = 0; x < MPS_ADDR_WINDOWS; x++) {
+		for (slot = 0; slot < MPS_ADDR_WINDOW_SIZE; slot++) {
+			u8 addr = (x << 4) | slot;
 
+			/* 0x00 is the PMBus all-call address, never a chip. */
+			if (!addr)
+				continue;
 			if (mpq8785_probe_addr(bus, addr, chip_out) == 0) {
 				*found_addr = addr;
 				return 0;
@@ -419,36 +427,33 @@ static int mpq8785_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Verify the chip answers MFR_ID="MPS" at the DT declared
-	 * address. If it doesn't, walk the documented ADDR_VBOOT windows
-	 * looking for it (a die rev address shift). On a hit, replace
-	 * priv->i2c_dev with the discovered chip handle and continue.
-	 */
-	{
-		char id[PMBUS_MFR_STRING_MAX] = "";
-
-		ret = pmbus_read_string(priv->i2c_dev, PMBUS_MFR_ID, id,
-					sizeof(id), true);
-		if (ret < 0 || strncmp(id, "MPS", 3) != 0) {
-			struct udevice *bus = dev_get_parent(dev);
-			struct udevice *promoted;
-			u8 found = 0;
-
-			if (mpq8785_scan_windows(bus, &found, &promoted) == 0) {
-				printf("MPQ8785: DT addr 0x%02x silent, auto promoted to 0x%02x\n",
-				       (unsigned int)dev_read_addr(dev), found);
-				priv->i2c_dev = promoted;
-			} else {
-				printf("MPQ8785: no MPS responder found in 0x10..0x1f / 0x20..0x2f / 0x60..0x6f\n");
-				return -ENODEV;
-			}
+	/* mps,auto-probe: ignore the DTS "reg" address, scan */
+	if (dev_read_bool(dev, "mps,auto-probe")) {
+		struct udevice *bus = dev_get_parent(dev);
+		struct udevice *found_dev;
+		u8 found = 0;
+
+		if (mpq8785_scan_windows(bus, &found, &found_dev)) {
+			printf("MPQ8785: auto-probe: no MPS responder in 0x01..0x7f\n");
+			return -ENODEV;
 		}
+		if (found != (u8)dev_read_addr(dev))
+			printf("MPQ8785: auto-probe: MPS chip at 0x%02x, DT reg 0x%02x ignored\n",
+			       found, (unsigned int)dev_read_addr(dev));
+		priv->i2c_dev = found_dev;
 	}
 
-	/* MPQ8785/MPQ8646 specific: refine VOUT format from VOUT_MODE. */
-	if (chip_id == MPQ_MPQ8785 || chip_id == MPQ_MPQ8646)
-		mpq8785_identify_vout(priv->i2c_dev);
+	/* VOUT_MODE sets the VOUT format, use it for the presence check. */
+	if (chip_id == MPQ_MPQ8785 || chip_id == MPQ_MPQ8646) {
+		ret = mpq8785_identify(priv->i2c_dev);
+		if (ret) {
+			struct dm_i2c_chip *chip = dev_get_parent_plat(priv->i2c_dev);
+
+			printf("MPQ8785: no usable chip at 0x%02x (VOUT_MODE: %d)\n",
+			       chip->chip_addr, ret);
+			return ret;
+		}
+	}
 
 	/* Apply mps,vout-fb-divider-ratio-permille if present in DT. */
 	fb_div = dev_read_u32_default(dev, "mps,vout-fb-divider-ratio-permille", 0);
---
base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
branch: for-upstream/power-mpq8785-auto-probe-v1

-- 
2.43.0

