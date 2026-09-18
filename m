Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363DAC982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 09:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE1B240B4F;
	Fri, 18 Sep 2026 09:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H7UOrHiXy_PC; Fri, 18 Sep 2026 09:50:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D8CC540B25
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789725055;
	b=FwY7pS9k3ySDEdssRFKpSO+++A4Ji8aF6H+aZQZ6LRohGBSFAq1+28LAKawNMvkxf7cd
	 Kb6Db4DteB+E0agDmXsJu/QAqcdZqIHf6i7yBsA3BlhUDTNawNIFN4lApRk8DktttXG8R
	 guBzj3ulZNbGIrQcgyCZ4girekgSIW4PxZK7J5qdq1LT3+kNZXzVg/T8Eoc0A71steOez
	 s38fQrS3DJP9Or0IEpxJgGGzpRZqOxA3r0UCsmvKCWEgUJK3QXi3kBAlrhmx4Fr3I3UlV
	 D4Q0fhOvYPdpXcq1RNfFMqBgthBRSGCVvZVkP5uRKj/hFQv9N4havo/qhpTMw/BznbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789725055;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jIkPqratWSO8MI3JUpzEY7HW569Mapscc/ZxVAxO7wQ=;
	b=rlz24kZI0aQj0ttwJ5k4akEo/Ht7Af+DE34OH+p4MExsEWpSYTA+wfSAB5S4JQmgvDov
	 1E1fF/7i+mTQCdikJL7mhOxpYvoUhWfafxSSZHcayD3fXSBM/LG5X2Pxcf6PMv89USqDr
	 /Ke2hYHwzB0cmLVakfRB6wBs+ed6qbM7fxdOtdAUtVc+sC/7r0KmMUy1BZGztlAnj988z
	 6ZiGRjl98HT9vGVWQ0Cf2Rc3cfiDtexlGQXcgTkFNKoZVDdOkc9t+i+cPNnkrQv0LfP9a
	 xVC6WQHBiBRKxefb31b1LvwZbP1GTxLgR/RlAzgcB5ZO8Jnr2u7buMm28Y0DY/49Plg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=aKVrQ4XE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789725055;
	bh=jIkPqratWSO8MI3JUpzEY7HW569Mapscc/ZxVAxO7wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPMb1MNDlV9Z9v/OyikB/4xBRIbuNSzD9m4HmK94780cQzc3nAMzc8DFa/nTpQadv
	 uPRN1yDwIpCn9z6Uba180F6DHUaXWN4aNQglfk6EQwslJ6YrgnSMtVK6JXREuYteBo
	 k8MVZjJYcITYfMa1D+4W70jjQ6Btd7t9+67hZ/0EB4+XmYvEaLOnE/90w7CKsWmzb/
	 ykaSeaZ7xqOujoeYpaJMzvvIt2WHiWKZK9+5kI4goAgu+V9oZZ2Nrn6Vfjm5prO+wK
	 BcKFYensXmG6ACMzMx9HCw1VGkfYUJqmDRLfiqpiMTnMQiwOMNYgAZclDuLHevBcO/
	 Ye6DhNCnhUIWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8CC540B25;
	Fri, 18 Sep 2026 09:50:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EF75362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CA8D40B24
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iky_OgJ2HHgx for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 09:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A266D40B25
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789725052;
 b=i8UEWYvj01zzrgf+BcPC5Mj65vV6hbXjaJEoaT1CuW/C+7R2VeTf3B5sXQtjGBnf9gDm
 nUq2jxQ/WuNFFJwQf1LHlQgTxUEU4RAbFTOjOFNdZ2dZbfo3HPny4ztFN2GwB7+Srqbn3
 E6ntUGfooz2T227ZoBDu0LdMPtuzaPTUU+jq4/A36FwdSg1cuPYIgOE7LfduOs602CM3z
 gKad4CwBYCFdblmLnzYmmXPFMSaAgPA/t+7Pb/EahxFoHI/5sB4yObGuQFktPoAPAFFfc
 W9KGNOd7Puqmc20J/9M0bCe9zWZh1+1fOCAF3JA9bJB7n8NC8FGZdWkSAWk57K9lOsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789725052;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=jIkPqratWSO8MI3JUpzEY7HW569Mapscc/ZxVAxO7wQ=;
 b=QaKTEOj75JnvgHqf4UzbTzPRFbuog1kfmaM6+37lc2uwZeq/bFtW6ZcAu+Qj3pY9JF9A
 bvMUsye8SiNGepoO5gR52/QZmHItxin7jUVY2yZsDjtGF9SJFtBlAdNnFKlAxMPu5vjTO
 CgqXMaKarRnGrYfxV6u78Yv+mzbiRFOOBlyKYLD8ijeTpbUGprFwx4iux/0zrOGwLnz8V
 6zx5CcdbiehUMil6z9CpzMz3WonF81O8yicS4HO5adBZh1kiCmJIB5C4Kl8+dclGsCIRG
 6NcGdlOYDsxohSgD3gxYGmTdcEOLFOmAcQJmajNZeSgasIa1TpANsepuM3wBoBHXhug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=aKVrQ4XE; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=aKVrQ4XE
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A266D40B25
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D9E82B005AB;
 Fri, 18 Sep 2026 11:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789725049;
 bh=9ZolGzah4Rv8hXDLCUiCmAyWrqKkeqErkOmzZVRuBfI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aKVrQ4XE8/9gVXiotEwpec6LTF0unGuNdGKT0FkuiG6irkVTIlbNLYup2TAk9Fiz5
 OHJxnrF0iQtkeslIVPA+/JfG+jFj005VFT5Xrx8tOwy6cZWYX3NKHZNAfOlCTIh1/r
 /nV4LPpbeiJ51rd9BCkdMVaGqHJGsWiw4klsxMOVX6LADac8uV9fNsYBil87vAu0C1
 mAw9ruMRH/LPqj8Opl+LJEKH0g4w8v/8C9GKoOxO4vz8MpN3FCJrEbtOJBpJMT5xcw
 xfT6sxnsxROwcZdazQn3wCc1FRpbR1KTTbJ7LRAysw59qU4Ozl0aulEc9jAeI3wzgc
 HBziBdPDSxKSg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 2/2] pmbus: be generic for any devices
Date: Fri, 18 Sep 2026 11:50:26 +0200
Message-ID: <20260918095026.3635222-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918095026.3635222-1-vjardin@free.fr>
References: <20260918095026.3635222-1-vjardin@free.fr>
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

The pmbus it not for MPQ only, clean the comments.

No functional change.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 doc/develop/pmbus.rst                  | 40 +-------------------------
 drivers/power/regulator/pmbus_helper.h |  5 ++--
 include/pmbus.h                        | 30 ++-----------------
 lib/pmbus.c                            | 10 +++----
 4 files changed, 10 insertions(+), 75 deletions(-)

diff --git a/doc/develop/pmbus.rst b/doc/develop/pmbus.rst
index efc9f9a95e5..7ff1d4611b2 100644
--- a/doc/develop/pmbus.rst
+++ b/doc/develop/pmbus.rst
@@ -562,7 +562,7 @@ Decision tree:
    non default coefficients), an alert can't be decoded (chip has
    vendor specific status bits), AVS is needed (the boot path has
    to actively trim VOUT before kernel handoff), or the chip has an
-   ADDR-pin auto promotion / VID coercion / vendor register quirk.
+   address scan / VID coercion / vendor register quirk.
 
 DT alignment with Linux
 -----------------------
@@ -588,44 +588,6 @@ declare each rail as a child regulator node with ``reg = <page>``;
 each child binds as a UCLASS_REGULATOR with that PMBus PAGE setting
 applied at every read/write.
 
-Common pitfalls
----------------
-
-These have all bitten contributors during nbxv3 bring up; record them
-here so the next port doesn't repeat them.
-
-* VOUT_MODE/DIRECT format confusion. Most generic PMBus call
-  sites assume LINEAR16. Several MPS chips report VOUT in DIRECT
-  format with chip specific m/b/R after a single VOUT_MODE read,
-  the same chip read at the same address produces different
-  numbers depending on the format the driver applies. Always read
-  ``VOUT_MODE`` at probe time and switch the decoder accordingly.
-  Linux's per chip ``identify()`` callbacks document the exact
-  rules; copy them rather than guessing.
-* SMBus block read protocol. Some I2C controllers strict check
-  block read transactions: the master must read the length byte
-  first, then reissue the read for the payload. Over reading a
-  fixed length and ignoring the length byte works on lenient
-  controllers but errors on strict ones. ``pmbus_read_string()``
-  does the two stage read; use it.
-* I2C bus number stability. ``uclass_get_device_by_seq()``
-  uses the DT alias index (``i2c0`` -> ``UCLASS_I2C`` seq 0) when
-  aliases are declared, otherwise falls back to probe order which
-  varies with which controllers are enabled in the defconfig.
-  Always declare DT aliases for I2C buses you reference by index.
-* ADDR-pin auto addressessing. Some chips (notably MPS parts) decode
-  their PMBus 7-bit address from an external resistor divider on
-  ADDR_VBOOT. The "default" address in the datasheet is the
-  factory fused slot; a board with a different divider or a die
-  with a different revision can land in another window. If the
-  driver hardcodes the default and the board side scan finds the
-  chip in another window, auto promote the working address rather
-  than failing the probe.
-* MFR string byte order. Most PMBus chips return ``MFR_ID``
-  characters in human order. Some MPS personalities reverse them.
-  Pass ``reverse_bytes=true`` to ``pmbus_read_string()`` for those;
-  spec compliant chips pass false.
-
 References
 ----------
 
diff --git a/drivers/power/regulator/pmbus_helper.h b/drivers/power/regulator/pmbus_helper.h
index 82f263cd513..f82b782781e 100644
--- a/drivers/power/regulator/pmbus_helper.h
+++ b/drivers/power/regulator/pmbus_helper.h
@@ -11,9 +11,8 @@
  * via the tree level <pmbus.h> framework.
  *
  * Per chip drivers retain control of identify hooks (VOUT_MODE based
- * format selection), chip specific quirks (vendor registers, ADDR pin
- * auto promotion), and DT property handling (e.g. MPS
- * mps,vout-fb-divider-ratio-permille).
+ * format selection), chip specific quirks (vendor registers,
+ * address scans), and DT property handling.
  */
 
 #ifndef _DRIVERS_POWER_REGULATOR_PMBUS_HELPER_H_
diff --git a/include/pmbus.h b/include/pmbus.h
index 0e121fa6637..bb85a61e62a 100644
--- a/include/pmbus.h
+++ b/include/pmbus.h
@@ -288,12 +288,7 @@ struct pmbus_driver_info {
 	 * Bitmask (BIT(enum pmbus_sensor_classes)) of the sensor classes
 	 * this chip actually implements. When non-zero, pmbus_print_telemetry
 	 * prints exactly these classes -- mirroring the kernel's per chip
-	 * sensor set -- and skips the rest. This is how an MPS buck that
-	 * ACKs READ_POUT / READ_IIN with an uncalibrated value still hides
-	 * POWER / CURRENT_IN (the kernel's mpq8646 driver exposes neither).
-	 * Zero means "not declared": the telemetry printer falls back to a
-	 * live pmbus_word_command_supported() probe per class, which is what
-	 * the generic driver (compatible = "pmbus") relies on.
+	 * sensor set -- and skips the rest.
 	 */
 	u8 classes_present;
 };
@@ -311,11 +306,6 @@ struct pmbus_driver_info {
 /*
  * LINEAR11. Bits[15:11] = signed 5 bit exponent Y, bits[10:0] =
  * signed 11 bit mantissa N. Engineering value = N * 2^Y.
- *
- * Used by most PMBus chips for VIN, IIN, IOUT, TEMP. Some MPS
- * parts deviate (they report DIRECT format with chip specific m/b/R
- * coefficients); check the chip datasheet against PMBUS_VOUT_MODE
- * and the Linux per chip driver if porting.
  */
 s64 pmbus_reg2data_linear11(u16 raw);
 
@@ -416,10 +406,6 @@ int pmbus_write_word(struct udevice *dev, u8 cmd, u16 val);
  * work. Output is null terminated and printable only (non printable
  * bytes are substituted with '.').
  *
- * reverse_bytes: some MPS NVM personalities store ASCII strings
- * LSB first (chip returns "SPM" for the human string "MPS"); pass
- * true to reverse on copy. Spec compliant chips pass false.
- *
  * Returns string length on success or a negative errno on bus error
  * or invalid length byte. outsz must be at least 2.
  */
@@ -469,10 +455,7 @@ void pmbus_print_status_word(struct udevice *chip);
  *
  * Read READ_TEMPERATURE_1 (8Dh) from a UCLASS_REGULATOR device that
  * was bound by a pmbus_helper based chip driver, decode it through
- * the chip's pmbus_driver_info (so the MPS DIRECT 1 degC/LSB quirk
- * and the standard LINEAR11 encoding are both handled), select the
- * regulator's PAGE first on multi rail parts, and return the result
- * in millidegrees Celsius.
+ * the chip's pmbus_driver_info.
  *
  * This is what the generic drivers/thermal/pmbus_thermal.c companion
  * calls on its parent; keeping the decode here avoids exposing the
@@ -610,11 +593,6 @@ void pmbus_clear_active(void);
  * framework can associate an MFR_ID prefix (read at probe time)
  * with a vendor namespace ("mps", "lltc", "renesas", ...) and a
  * pmbus_driver_info pointer. The first matching entry wins.
- *
- * mfr_id_reverse flags MPS style chips that store the MFR_ID
- * string LSB first (chip returns "SPM" for the human string
- * "MPS"); the framework reads the string in both orderings and
- * matches against the prefix in the natural reading.
  */
 struct pmbus_chip_match {
 	const char *mfr_id;
@@ -646,9 +624,7 @@ int pmbus_resolve_by_name(const char *name, int *bus_seq, u8 *addr);
  * pmbus_active(), or returns CMD_RET_USAGE if the active device is
  * not from this vendor.
  *
- * Per chip drivers register their vendor handler at init time. The
- * MPS extension publishes pmbus mps last, pmbus mps clear last,
- * and pmbus mps clear force.
+ * Per chip drivers register their vendor handler at init time.
  */
 typedef int (*pmbus_vendor_handler_t)(struct cmd_tbl *cmdtp, int flag,
 				      int argc, char *const argv[]);
diff --git a/lib/pmbus.c b/lib/pmbus.c
index 62a66593638..e38f65a7979 100644
--- a/lib/pmbus.c
+++ b/lib/pmbus.c
@@ -17,10 +17,7 @@
  * layers do not apply; only the arithmetic carries over).
  *
  * No code in this file may reference a specific board, SoC, or
- * product. Per chip quirks (MPS DIRECT format LSBs, vendor registers,
- * VID coercion, ADDR_VBOOT auto promotion, and the like) belong in
- * per chip drivers under drivers/power/regulator/ or in board local
- * files under board/<vendor>/<board>/.
+ * product.
  */
 
 #include <ctype.h>
@@ -727,8 +724,9 @@ int pmbus_set_active(int bus_seq, u8 addr)
 
 	/*
 	 * Probe MFR_ID in both byte orders. Spec compliant chips return
-	 * "MPS" / "TI" / etc. in the natural reading (forward); MPS NVM
-	 * personalities store the string LSB first and need the reverse
+	 * "MPS" / "TI" / etc. in the natural reading (forward), but
+	 * support both like MPS NVM
+	 * personalities that store the string LSB first and need the reverse
 	 * read. Chip table entries declare which one is canonical for
 	 * the chip family they describe.
 	 */
---
base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
branch: for-upstream/power-mpq8785-auto-probe-v1

-- 
2.43.0

