Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAE7CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 16:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F234606EA;
	Mon, 28 Sep 2026 16:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uk5MkB2wWCwS; Mon, 28 Sep 2026 16:30:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B6AB9606CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790613027;
	b=T12sXY/rSZiOV4XUPW6Ua2biTwUH2y0Xzf5ZsMKEuii9FqZcy5xnETeXcwgTwDlsKMA4
	 ZTZ1QSxvU4nkNnIcDuwWx3eZrImyIZhMdR0Dvul7pzJi7SD4P1sn2uLCWTBLh7vzEcIbS
	 CWclSMiFCoFOzPxF1xe3zLRKqg8TWFT3aM/p7jESrgkLucqtJ1PC3MN2bn1xJPfwfpefb
	 EN887nuB8rDZIrd3eyXFQ+Ve1LT6rpoIKeohlv2qlkiqISUfkkwUG9r2rkD9PlcYyJGVR
	 T+4nCI6Riol+OvW92qGQZS3Xj8OWpPUlSKIT8tWW/pE3hRLWXX55h/lNoW526Qgfzzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790613027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QNX6zVZpMG4zRCsXia6DLDzE1+d/cazD29abIiUMscg=;
	b=Vx/5jLBdPp14OACLScSnWCUzwvS1TiaUush150hRfOtroZ2J6L2GvPEfNPojCAWfjk2R
	 XGFeC9CnIvU6AJoFTpOP6sSpcmqoNWiF4IthrRlVt21NHz7gvmfG3kI79+H/YH5AbziJn
	 1iUi2ZRB0tfNMuQ25rvbVs6+ZckN/V6QKjAuscatkuUWU3VRYn2ehjG4RyaCO7Xw8Vv0Y
	 fgLWaUF8Y/zaOj0kTl0jB9xX+2bBovnWNm9MDaCogOoFJD82oHZGRB9y7IKFj8dJq0+Kr
	 gapdgYYDuQSVKd2Pbg5IyFyAQMEix/8wau7C+vpWcq+CW6B6xhlXmLHHZh5HzEBOXxA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790613027;
	bh=QNX6zVZpMG4zRCsXia6DLDzE1+d/cazD29abIiUMscg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0+T3J4M4c/4/1ZDJgtL1BRAWVxZQGG6NLpJAdVqf211vW9Q1U0+46+qJYd1acNpt
	 QAZjMiJivap/vpvkXq1ZWDbALCrNNOlRsB43yZHxQQkccjIpyVDOjkw/YqeCDLtvcG
	 ruF8fNuMLTL968KVHdIlqocsN+5Su9pj8QYubvz+hA703pXiOucwtO9LTq1CjKDGoA
	 l/H/AG5FVpGEdQJiEk1gbivcLBFnBFQvfALGcD1giYAVILpGVaai5FfPLIlley2bNv
	 GvdgvnKtir1wTKxtPcDjEDo3VZSGbQ0Smpnp7VJQ8Qnr3AkCUpvRvOPrAkiZH4yz4q
	 RVqCY/x1bG+vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6AB9606CE;
	Mon, 28 Sep 2026 16:30:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AF2F3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 807A880C77
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vg4uGAwPguhr for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 16:30:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ABCFB80DC8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790613025;
 b=pHYuxMBcJSqniMYdx6PVOF3Yey54//kmqsW5ln0GzvllDP87HaN9w89a2fw10hHxoxe7
 o0IlCVm35BMPXozrfSG+xuv/8czJhkGL1DWmspJivdiZkY9tPKSOq0G4/JskOW8fRr2GI
 XgBQWolwoyh4NPMoQdYsw6nf/wzS7tnDjMGOrWQ8x45agq2PmHCstdPlzXzvQXiAhRhxj
 emsdvNHgPzRDsb1co5tnzgwDnKk9JCi0vEOrSM2+FaWNgytlikpNDSvmc52OtLio7HkHK
 NKvBoI7LtScZlhST1YYhJb8T0+w1xSDDtJHizOQ5zVN4iDrb72eM2/5K8P5Mkf8cuUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790613025;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=QNX6zVZpMG4zRCsXia6DLDzE1+d/cazD29abIiUMscg=;
 b=Ilw6AaqVpjmcM+h4fbxN98Rp4akkDNev5G7VsPFYACg+Gl+rV+1eh4HTCytRuEIcM1bU
 DTJ3YgfTKu4Ox1gXbvFVEmksjWQCZxXRTOFfN/sG3fXA1NekCPpBMJwapW2oJy0ZndPwK
 TSd2MqubcBqKuwUSGoGhVFf670fuGLXXJDI8rATpq+LxMww2h1sOXcBrHJ4xDrM8GpI8Y
 7TGxQtyek9mO0B0CBysDRYP/4Rvgw7X66Y9WTJNdJ7rB6aRaIjSZ+rzbemBhCVrT4b1Sl
 e3Sr2R+ayswFgKm0+G0TsAWsr82lUiHckfZlhwXcEBLxqAYMBphSXUn8qsy5AuDFd/Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=gbTsyDhQ; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=gbTsyDhQ
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABCFB80DC8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2C7C8B00565;
 Mon, 28 Sep 2026 18:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790613022;
 bh=84BOhi9/eXMo6gTb09UuGSLO2Bltss0ZdmgKr7IQPD0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gbTsyDhQ73IzQGO4LCRb0bUkvbYEKKikHKw+g2xM3BWCXo+yo8PGM6WZL+FQvtvTc
 PwSQC/BZgg1U2gTtI8owTEXtc/oN5WruN2ef4DB69lxHEGgBsvz5k4ErDtUB235Tpm
 rY10FoS3U7zw8BWxM25cg5NHt8ely7DKap49io02wPyDwIQJWcAufm3LvyQr6bD913
 wNY497928DtOUtBIYLB2bJqWAH46hZlyI7NU6lSwKe/DWaZr/X55rPOgfSGIX9ZgOn
 wqBAWfpGVgzYNiKArAUQLTNDd6zFAe1mCuHmrl2enM93d6tDqse9RjqPi7Dp1L2Lwx
 vvzVNDSF8GBTg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Nicolas Perrin <nperrin@freebox.fr>
Subject: [PATCH v1 4/4] board: nbxv3: VID handoff writes table value,
 no droop compensation
Date: Mon, 28 Sep 2026 18:29:04 +0200
Message-ID: <20260928162904.1143614-5-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928162904.1143614-1-vjardin@free.fr>
References: <20260928162904.1143614-1-vjardin@free.fr>
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

The handoff compared READ_VOUT with the fused voltage, and when the
rail read low it wrote the table value, then a second VOUT_COMMAND
raised by the measured shortfall:
  cmd = target + (target - rail).

On a module fused 0x14 (850 mV) the loaded rail reads 824.2 mV, so it wrote
875.8 mV:

  VID handoff fuse=0x14 rail 824218 uV, target 850 mV -> write 850000 uV
  VID handoff verified 849609 uV (target 850000 uV, cmd 875782 uV after 1 correction)

The 25 mV is the load line the MPQ8646 applies from its NVM
(MFR_DROOP_CFG). It is the VR's design, not an error to correct, and
compensating it in software runs the core above its fused voltage.

Do what the VR expects: map the fuse through the LX2160ARM table and
write that value, unaltered, to VOUT_COMMAND. Compare the setpoint
(VOUT_COMMAND), never the loaded rail, to decide whether to write, and
read the setpoint back to verify.

READ_VOUT is printed for information only.

A module whose VR boots with a setpoint above its fuse, e.g. 850 mV on
a 0x12 (825 mV) part, now gets 825 mV written. The previous code left
it untouched, because the loaded rail happened to read 824.2 mV.

Reported-by: Nicolas Perrin <nperrin@freebox.fr>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 board/nxp/lx2160a/nbxv3/vid_handoff.c | 77 +++++++++++----------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/board/nxp/lx2160a/nbxv3/vid_handoff.c b/board/nxp/lx2160a/nbxv3/vid_handoff.c
index d3edaa61080..65f2814b30d 100644
--- a/board/nxp/lx2160a/nbxv3/vid_handoff.c
+++ b/board/nxp/lx2160a/nbxv3/vid_handoff.c
@@ -11,6 +11,7 @@
 #include <event.h>
 #include <linux/delay.h>
 #include <log.h>
+#include <pmbus.h>
 #include <vsprintf.h>
 #include <asm/io.h>
 #include <asm/arch/immap_lsch3.h>
@@ -40,27 +41,13 @@ static const u16 lx2160a_vid_table[32] = {
 	[0x14] = 8500,
 };
 
-/*
- * Write VOUT_COMMAND, let the slew finish, read the rail back.
- * Returns the rail in uV, or a negative errno from the write.
- */
-static int nbxv3_vid_write_readback(struct udevice *reg, int cmd_uV)
-{
-	int ret = regulator_set_value(reg, cmd_uV);
-
-	if (ret)
-		return ret;
-	udelay(NBXV3_VID_SLEW_SETTLE_US);
-	return regulator_get_value(reg);
-}
-
 static int nbxv3_vid_handoff(void)
 {
 	struct ccsr_gur *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
 	struct udevice *reg;
 	u32 fusesr;
 	u8 vid;
-	int target_mv, target_uV, actual_uV, cmd_uV;
+	int target_mv, target_uV, rail_uV, set_uV;
 	char *override_str;
 	unsigned long override_mv;
 	int ret;
@@ -98,46 +85,42 @@ static int nbxv3_vid_handoff(void)
 	}
 
 	target_uV = target_mv * 1000;
-	actual_uV = regulator_get_value(reg);
-
-	if (abs(actual_uV - target_uV) <= NBXV3_VID_LSB_uV) {
-		printf("MPQ8785 (%s): VID handoff fuse=0x%02x target=%d mV (rail already at %d uV, untouched)\n",
-		       NBXV3_VDD_REGULATOR_NAME, vid, target_mv, actual_uV);
+	rail_uV = regulator_get_value(reg);
+
+	/*
+	 * Compare the setpoint, VOUT_COMMAND, with the table value, never
+	 * the rail. READ_VOUT sits below the setpoint under load, by the
+	 * load line the VR applies from its NVM (MFR_DROOP_CFG): that is
+	 * the VR's design, not an error to correct.
+	 * Writing the setpoint higher to bring READ_VOUT onto the fuse
+	 * drives the core above its fused voltage. Don't do it !
+	 */
+	if (!pmbus_regulator_read_vout_command(reg, &set_uV) &&
+	    abs(set_uV - target_uV) <= NBXV3_VID_LSB_uV) {
+		printf("MPQ8785 (%s): VID handoff fuse=0x%02x target=%d mV, VOUT_COMMAND already %d uV (rail %d uV), untouched\n",
+		       NBXV3_VDD_REGULATOR_NAME, vid, target_mv, set_uV,
+		       rail_uV);
 		return 0;
 	}
 
-	printf("MPQ8785 (%s): VID handoff fuse=0x%02x rail %d uV, target %d mV -> write %d uV\n",
-	       NBXV3_VDD_REGULATOR_NAME, vid, actual_uV, target_mv, target_uV);
-
-	ret = nbxv3_vid_write_readback(reg, target_uV);
-	if (ret < 0) {
+	/* The table value, as is: the VR corrects internally */
+	ret = regulator_set_value(reg, target_uV);
+	if (ret) {
 		printf("WARNING: MPQ8785 (%s): VID handoff set_value(%d uV) failed (%d), rail left at %d uV\n",
-		       NBXV3_VDD_REGULATOR_NAME, target_uV, ret, actual_uV);
-		return 0;
-	}
-	actual_uV = ret;
-	if (abs(actual_uV - target_uV) <= NBXV3_VID_LSB_uV) {
-		printf("MPQ8785 (%s): VID handoff verified %d uV (target %d uV, cmd %d uV)\n",
-		       NBXV3_VDD_REGULATOR_NAME, actual_uV, target_uV, target_uV);
+		       NBXV3_VDD_REGULATOR_NAME, target_uV, ret, rail_uV);
 		return 0;
 	}
+	udelay(NBXV3_VID_SLEW_SETTLE_US);
+	rail_uV = regulator_get_value(reg);
 
-	cmd_uV = target_uV + (target_uV - actual_uV);
-	ret = nbxv3_vid_write_readback(reg, cmd_uV);
-	if (ret < 0) {
-		printf("WARNING: MPQ8785 (%s): VID handoff correction set_value(%d uV) failed (%d), rail left at %d uV\n",
-		       NBXV3_VDD_REGULATOR_NAME, cmd_uV, ret, actual_uV);
-		return 0;
-	}
-	actual_uV = ret;
-	if (abs(actual_uV - target_uV) <= NBXV3_VID_LSB_uV)
-		printf("MPQ8785 (%s): VID handoff verified %d uV (target %d uV, cmd %d uV after 1 correction)\n",
-		       NBXV3_VDD_REGULATOR_NAME, actual_uV, target_uV, cmd_uV);
+	ret = pmbus_regulator_read_vout_command(reg, &set_uV);
+	if (ret || abs(set_uV - target_uV) > NBXV3_VID_LSB_uV)
+		printf("WARNING: MPQ8785 (%s): VID handoff wrote %d uV, VOUT_COMMAND reads %d uV (%d)\n",
+		       NBXV3_VDD_REGULATOR_NAME, target_uV, ret ? 0 : set_uV,
+		       ret);
 	else
-		printf("WARNING: MPQ8785 (%s): VID handoff rail %d uV %s target %d uV after correction (cmd %d uV) -- VOUT_MAX / non-linear load line, fix on the VR side\n",
-		       NBXV3_VDD_REGULATOR_NAME, actual_uV,
-		       actual_uV < target_uV ? "below" : "above", target_uV,
-		       cmd_uV);
+		printf("MPQ8785 (%s): VID handoff fuse=0x%02x VOUT_COMMAND set to %d uV (rail %d uV under load)\n",
+		       NBXV3_VDD_REGULATOR_NAME, vid, set_uV, rail_uV);
 	return 0;
 }
 
-- 
2.43.0

