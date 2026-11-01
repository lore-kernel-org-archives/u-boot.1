Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D7606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S7n1i5Gy;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=oq9HOEkU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 536E340638;
	Sun,  1 Nov 2026 14:51:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXb8MwaT-yNr; Sun,  1 Nov 2026 14:51:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F3D44062C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793544714;
	b=Nrc8xYfqpYZrI2MrOP4x5XNi2CRCSQh+MnJUBnZAhAf/7Rq9rmQWWkvJvkluwocf0qoG
	 lHqAz8LvnXX1CQqSH498nXlapmLdnXEFkvNSTjMtFODcKIQFyruzoFiqMBRzsvapDFR+K
	 qrbCd926Ri6Fr2pTHzZZImiu87VUOcJ3GES6/otnATB+yLTQ9GP05hRSmjKbsN9FNw0D0
	 gez4n3SvRM7O9dHow9AsYLAWU3SnXevOZcqtJmwzbv8qEqHsRgp6F0MbpiIGlFIRpvd4/
	 69MN/R979GKBbwk2PwnYs2TnoGOVx0u5cNCfFXle0KpEtmwZECkEMlmF3T8j88MavTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793544714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6qSkueYQkVk7U1vQJ/pLVXWD+JlJUCf8ekFmabtFJV8=;
	b=d4tRTFfwR5Vaq8o0bTmTJspTjbxh42O1gYA18c8WtVMD01ZScbSkzWbDuCgtt8bkuQxB
	 rtXWijtsr9nkD1Z0rXalwvQTGEfu8c+jtkw+HzdXcevJV+TOMwwZYId3kcUpGM3azXB1a
	 2KHUzaByg3dvlBe3YmI7xaCuF9nzPd1DFZ24l40j9QbrXozcp1JGrve4wzl/SUdQ34BtA
	 KUevlIpsw8dD7xKF0ku+iat8/FxAi3LAyihvO+n+XL8FshNdnkvmGH2Jf18Uek7GFKmm4
	 ABrSwK4pjuxpz3iXoQHMDPE+bGTpvKDYwzUpqjQxU3qLgr0kRweTgQPfgn33dza4hpA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=oq9HOEkU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793544714;
	bh=6qSkueYQkVk7U1vQJ/pLVXWD+JlJUCf8ekFmabtFJV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S7n1i5GykHARYq4MdR0ZKnaxFG4IF3o52xgJ/MPRHE0JP8Oedgja0bBimvtEE4WEH
	 7fUt/AOwSqzC8G5OibudHc1152mKGCkcc/96Tmq1mAGS8u4u81+muTqB+ci89FSg+5
	 pUKFqVRZwl5YSS2pQOQNa1flI2txcnTjOVM8l2V/ZjHdpEpEKry7JKEcU7Ci5GzGxp
	 5OHsb8rmSN3v+qap+5vlInzursAYglmBxm9rV7RxjI1hdEs2p7462gd0cMkfGOURzE
	 tfa8e5JkjrNwMs7FOASWQbXB/fcXKR36gq7f0+ECteXrsjjc3gZm8xNB1oeCsvQuj/
	 uTuc5LxVZZcUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F3D44062C;
	Sun,  1 Nov 2026 14:51:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85F4B323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 75BA8405E8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:51:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1LDfn0z_A5SM for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 14:51:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9AD5A405E5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793544711;
 b=A1gSiUpIk/lXAR3y9y7yPYRpJiZ/dVm3roTNMJTwhL86S2M20JGOZOm9qCUFzySnGLco
 LLg/4E7j47riYVxZBom4MYBk0C643bn9oV6+0ASvTEijOWTQH/a84uvJsc5pPX3MJSRbL
 KEI40ast2jA9AUDhNdBEBYCphbY79Nszr6o/lYKo90L3Ap79N/qiCCdF/T5Bo+sRK0m8v
 RQzHzrd57dfk7kTME5c6vknfkE3mKssJfREqsy2DSmFrZ0b7tVVRpsfxi9eZO4DBVp7FJ
 nx4seOaTelvwoQ7skyGHQV02o0Fy4nCNWzz/kfRB0Obceo6WYaK9/9WoH45lpj7z5Mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793544711;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6qSkueYQkVk7U1vQJ/pLVXWD+JlJUCf8ekFmabtFJV8=;
 b=VunTDJcsRuwbzzn4l56Fw0EevjsuRwsK38u98xVVzY3NZqp+klZdt0QHbGLGW08guGKl
 qCOQ99h8nw2HN4ct78R99JDqY5ARc8Ztm05iuUR54LbVi8RLzMIFS6r01PqlPbFKofk1p
 TeOz8DHdbZjMXZLpytvTP06LUGuKERnoaB7g3auvAd6PAXDMjq9p/diLWTywf+5Wqe9E0
 kFpRsKpandX2QpxmOip0xALwpArCjnjRK3wUCJ1NsmRjDtNRgxPfgTKH4MOYVDROnesCt
 GDMjve+6gPmMrZF9HQF72gssbc6FLpXGedciurNTSUprBThTtBuYLmFA7rlVeL52nZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=oq9HOEkU; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=oq9HOEkU
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9AD5A405E5
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 9FFB9B00548;
 Sun,  1 Nov 2026 15:51:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793544707;
 bh=JXFzRtn6c9tWWw02l8ZSxtBGRNoH/75KceKvfRRjeBM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oq9HOEkUWG8E+G7BGAU7prlSojr3j7nwo9FiNncV2+DclAqSjcBGUlWNMOTOTgJ3t
 07K896u7nvBca8pMY04gw5FyTY5U739rl8kBMRAQSeNT8k2hzxzUC12zwlH8c8boLJ
 3H5AdYXdssZMFSTcMzFAAKOYrIahgHpmMKoUc20ICUZ2roggjbEWCYS4dtgg+tr/X1
 FAslYotHtJJyS6Qv+UqjTeUIEHP461+xdMlwXMvUIyefSmuyyJKlw7elkbSN6BTRBp
 GrTisYe98x3/HVsie8nyeEe8cXTK7AXXXDSSMmDam64cwpAAUiZJODR7jkkkq+uM0M
 OQbXDeB1pKZGQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 1/3] board: nbxv3: get carrier from the RCW build stamp
Date: Sun,  1 Nov 2026 15:51:16 +0100
Message-ID: <20261101145119.348038-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101145119.348038-1-vjardin@free.fr>
References: <20261101145119.348038-1-vjardin@free.fr>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

${carrier} selects the kernel's DTS and the MC's the DPC + DPL
to beloaded from the FIT.

Into the FIT, they should have the following names:
  conf-, dpc-, dpl-${carrier}

The console shall display the selected carrier.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 board/nxp/lx2160a/nbxv3/carrier.c | 87 ++++++++++++++++++++++++++-----
 doc/board/nxp/nbxv3.rst           | 35 ++++++++++++-
 2 files changed, 106 insertions(+), 16 deletions(-)

diff --git a/board/nxp/lx2160a/nbxv3/carrier.c b/board/nxp/lx2160a/nbxv3/carrier.c
index c810fe01957..61bab54d5ef 100644
--- a/board/nxp/lx2160a/nbxv3/carrier.c
+++ b/board/nxp/lx2160a/nbxv3/carrier.c
@@ -15,13 +15,22 @@
  *   mcinitcmd  imxtract ... dpc-${carrier} / dpl-${carrier}
  *   mc_init    bootm ${kernel_addr_r}#conf-${carrier}
  *
- * For testing, we can enforce, change it from the prompt and make it persistent:
- *   setenv carrier nbv32 && saveenv && reset
+ * ${carrier} comes, first match wins, from:
+ *   1. the environment, e.g. a saved one:
+ *        setenv carrier nbv32 && saveenv && reset
+ *   2. the RCW build stamp in DCFG SCRATCHRW13, see below
+ *   3. NBXV3_CARRIER_DEFAULT
  */
 
 #include <env.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <vsprintf.h>
+#include <asm/io.h>
+#include <asm/arch/immap_lsch3.h>
+#include <asm/arch/soc.h>
 
 #include "carrier.h"
 
@@ -30,35 +39,85 @@
 #endif
 
 /*
- * Placeholder for strap/EEPROM based identification.
- * Returning NULL means "cannot tell".
+ * RCW build stamp. The RCW must already match the carrier, because it
+ * sets the SerDes protocols and the pinmux, so its PBI also writes the
+ * carrier it was built for into DCFG SCRATCHRW13:
+ *
+ *   31   28 27   24 23   16 15    8 7     0
+ *  +-------+-------+-------+-------+-------+
+ *  |CARRIER|  TAG  |  YY   |  MM   |  DD   |
+ *  +-------+-------+-------+-------+-------+
+ *
+ * TAG is 0xB. Any other TAG, including the reset value 0 of the
+ * register, means no stamp. YY MM DD is the RCW build date in BCD, for
+ * the operator only.
+ *
+ * CARRIER:
+ *   0     any nbv3 carrier: one RCW for all of them, it names none
+ *   1     NBV30 / NBV31
+ *   2     NBV32
+ *   3     NBV32 with SerDes 1 at protocol 20 (2x 40GE) in the RCW
+ *   4..F  unassigned, treated like 0
  */
-static const char *nbxv3_carrier_detect(void)
+#define NBXV3_STAMP_SCRATCHRW		12	/* SCRATCHRW13 */
+#define NBXV3_STAMP_CARRIER		GENMASK(31, 28)
+#define NBXV3_STAMP_TAG			GENMASK(27, 24)
+#define NBXV3_STAMP_TAG_NBXV3		0xb
+
+/* CARRIER digit of the RCW build stamp, -ENOENT without a stamp */
+static int nbxv3_stamp_carrier(void)
 {
-	/* TODO, not available yet */
-	return NULL;
+	struct ccsr_gur __iomem *gur = (void __iomem *)CFG_SYS_FSL_GUTS_ADDR;
+	u32 stamp = gur_in32(&gur->scratchrw[NBXV3_STAMP_SCRATCHRW]);
+
+	if (FIELD_GET(NBXV3_STAMP_TAG, stamp) != NBXV3_STAMP_TAG_NBXV3)
+		return -ENOENT;
+
+	return FIELD_GET(NBXV3_STAMP_CARRIER, stamp);
+}
+
+/* NULL when the stamp names no carrier */
+static const char *nbxv3_carrier_detect(int digit)
+{
+	switch (digit) {
+	case 1:
+		return "nbv30";
+	case 2:
+		return "nbv32";
+	case 3:
+		return "nbv32-40g";
+	default:
+		return NULL;
+	}
 }
 
 void nbxv3_carrier_env_init(void)
 {
 	const char *carrier = env_get("carrier");
-	const char *detected;
+	const char *origin;
+	int digit;
 
 	if (carrier && *carrier) {
 		printf("Carrier:       %s (from env)\n", carrier);
 		return;
 	}
 
-	detected = nbxv3_carrier_detect();
-	if (!detected)
-		detected = NBXV3_CARRIER_DEFAULT;
+	digit = nbxv3_stamp_carrier();
+	carrier = nbxv3_carrier_detect(digit);
+	if (carrier) {
+		origin = "RCW build stamp";
+	} else {
+		carrier = NBXV3_CARRIER_DEFAULT;
+		origin = digit < 0 ? "default, no RCW build stamp" :
+				     "default, the RCW names no carrier";
+	}
 
-	if (env_set("carrier", detected)) {
+	if (env_set("carrier", carrier)) {
 		printf("Carrier:       WARNING: cannot set ${carrier}\n");
 		return;
 	}
 
 	/* Not saved on purpose: saveenv on every boot would burn the NOR */
-	printf("Carrier:       %s (default, not saved; setenv carrier <name> && saveenv to pin)\n",
-	       detected);
+	printf("Carrier:       %s (%s, not saved; setenv carrier <name> && saveenv to pin)\n",
+	       carrier, origin);
 }
diff --git a/doc/board/nxp/nbxv3.rst b/doc/board/nxp/nbxv3.rst
index 98d5cf9e17d..3eb87104a52 100644
--- a/doc/board/nxp/nbxv3.rst
+++ b/doc/board/nxp/nbxv3.rst
@@ -80,9 +80,40 @@ FIT image at NOR offset 0x1000000::
   /configurations/conf-<carrier>
 
 ``${carrier}`` selects the carrier set (``conf-<carrier>``, ``dpc-``,
-``dpl-``). It is set on every boot. For debug, to enforce another carrier::
+``dpl-``). It is set on every boot, from the first of:
 
-  => setenv carrier nbv32 && saveenv && reset
+1. the environment. For debug, to enforce another carrier::
+
+     => setenv carrier nbv32 && saveenv && reset
+
+2. the RCW build stamp, see below,
+
+3. ``nbv30``, the built-in default.
+
+RCW build stamp
+^^^^^^^^^^^^^^^
+
+The RCW sets the SerDes protocols and the pinmux.
+Its PBI writes the carrier it was built for into
+DCFG SCRATCHRW13 (0x01e00230)::
+
+   31   28 27   24 23   16 15    8 7     0
+  +-------+-------+-------+-------+-------+
+  |CARRIER|  TAG  |  YY   |  MM   |  DD   |
+  +-------+-------+-------+-------+-------+
+
+``TAG`` is 0xB; any other value, such as the reset value 0, means no
+stamp. ``YY MM DD`` is the RCW build date in BCD, for the operator only.
+
+======= ==================================================
+CARRIER ``${carrier}``
+======= ==================================================
+0       none: one RCW for every carrier, it names none
+1       ``nbv30`` (NBV30, NBV31)
+2       ``nbv32``
+3       ``nbv32-40g``: NBV32 with SerDes 1 protocol 20 (2x 40GE)
+4..F    unassigned, treated like 0
+======= ==================================================
 
 Boot flow
 ---------
-- 
2.43.0

