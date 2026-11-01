Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E01606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TWjfyZgZ;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Dtx4bUct
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 870BF404F5;
	Sun,  1 Nov 2026 21:32:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dnf3n2iT1mnS; Sun,  1 Nov 2026 21:32:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC53E40523
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568732;
	b=enGJMO2Zx3eJoIK0tlK+Z7CUwGk1JwuJjPf0qZXjbRGCZnJKgoxX5aqVEr1Wh8LudleA
	 YR1FwGvSZu/4J2jDc7Etpw0vHKUoHhHwkui8xx2MIstkstf36LzDwsUECHa33XfcxNjU5
	 qHYX8+6vFgFsofpiduaytG5hoAsbfLTwqZA6NULDROf1B3I4EIrKAuH96aXVZerhEf0Ot
	 aXEv5OWzhICRgwSkNzK8hNqKuJgvShw9XLdd9rQbsuwbzcwZfYAR5aU1NJPN6ghmdlF2J
	 IPYO1cR9f/0M8Ym9rf84SlHlSgEsCYHB11sesjyAJ99nH492EVFKt/3mEDCr3K55NBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DZy48tBRKI59TOM1cb6T2kNXciErHHSs1CTh7naBlQM=;
	b=Elrs/87AuWV41MxGdMuDn0QqfYwCloGtNay9bXe4pXCLZLuU+Yl7RMnsK7sjOhJDmpBE
	 pfWFdznMahUcR2dfWuT0J2NJOqjPX/Hp9RP4rXg/wHckVVhfR1jdYMHNjoKJkBLxpekZm
	 f5suXJVCG3lpaedBcnhfp1NkaIzbEPmJEAWrahlxoF608PYhUZTr9vimDStQql7cncsN2
	 eIsgnamtz9jmZsqmmepAxhJrB3cMS13NUGfP513ucHd78LUdDDjPrUCZ1aD6VXaeKRKL+
	 ordq9Uwp1eyhjclkW5Z91gpuClekP8DCe7eKjVpumKZ6Bm/YPqnFgDgDMQCWTI3h76Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568732;
	bh=DZy48tBRKI59TOM1cb6T2kNXciErHHSs1CTh7naBlQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TWjfyZgZJcHiz46Ygp2nrwMNZ6qpnTM78+HJ39ubs4UwuGGxcekqtWoOLz4q7u9Pg
	 4WlqrKpqollRxpWFX5WHDKQvph3RWxFko0nyocc/5K6CKgzjIAIxXGOyNMqAU6HFyr
	 tDx7eghdW/WiIQBNCGtQrzlhELN2L+arRQ4DuDCBgtf4XJjk8LPQrFKQCltxf8ewzU
	 FsYmMglVFXxShCN4tGhOumCb87zargpKV5ZZgIp7x7n/auzUhsREc5GrKo8hfuwSk/
	 wgDc1jKyFqIGVnzEXgc6tMt8b2Xp7JGKhmCimgKppaEkehC8diVXgTfOymO3TiXtMP
	 hyoOggsPs9WJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC53E40523;
	Sun,  1 Nov 2026 21:32:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 910E0435
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EB6B60623
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:32:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lD3ycX1whqKL for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:32:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6463460612
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568730;
 b=FKp6+ZpqIwTa97cBEP8tPAk11fyQMcLOT65yn20Z3yfK6mKUpgNPrALmoVByD2ti0OoP
 Ba2Da2rkf7fqjEP6QZpCyMHGrDMEu0U89VV55YMsmsRZHtuGMA9deC1bUoEdDKsG+EITe
 xZBf4Gjlf30H03/iNXmBWzsoPSRJl+JbrjrvSY5rR6pRLVCAFnp6KMxklIEOL4mxIl8vL
 CgCtt15ZixuHX86FGNRJCWuRZlGKwU+VtZ/MpCawCCqZ4pXz5sbumTzgVZiz/O/hNNsjj
 ZHh6LK/KOhZmFhn87ZftkPAOtqMqxxW9io144WvEy18A6CzkQVAEiGN8dzexyu6PSdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568730;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=DZy48tBRKI59TOM1cb6T2kNXciErHHSs1CTh7naBlQM=;
 b=qRFx30Oa7i+TFi5oTN0z4CLoIvQAGFId65jF5qMtu//xye7xtE9VB1EiORl4iivf6Ni/
 j2nW6ObgcVmCrqKjgu8MyfFKUHlp6KgPGSsn10OHq5rNCBl6luoO5UBEKDX6WTRF6liyg
 GbZTE1stob0W7gXOVaDr7UxedQ9q0KmiRTeFIKo6LcDhcsvk8/R5TkFmLK/Qcnh/mWi+a
 Gh760c45LSxGtMa6SSxsP1RUYC362z6iW0kYRvXDi00Jg5QBWwCEN0rGHlN19Wg16c05h
 GdRG8RiXlmCw6FMXRpLegDEvbPZ8HX383j4aUxnExydzy2wPdFQ0zusaGsT3l2IunMw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Dtx4bUct; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Dtx4bUct
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6463460612
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:32:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8E140B0053E;
 Sun,  1 Nov 2026 22:32:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793568727;
 bh=40YqoSYnbLm55qOP8RpxFdz1X3rRRXwGbuVkBL82U1w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dtx4bUctd+/KX3a2WzHvlXBE1vKd15P7dPXH+xczB6TnYL/Desk6QtYJz9uLrsne9
 VBcpUgLEm53mddC8F2Kggee2HzxZmOptaJAmMGQOcfzZNEswfCKbm7reeEnfSmUlxR
 ThjaqZstmLOD4vPUSvr/QF5oG9Ir3XWJVkSgIktWZ4BW9aodGzctHZZ6Q8ZOq0tv+x
 k9+osnxYJDLbjglPlAIasYmSgiF/XkNgeU/Ey0xM06k6OO/yplZOLsdHBSKhYab2dw
 J+wGzk59Cxp3q22A4J4x6DH7RMhUNTudLSFoPb1VxABVl6bAr4iMDzCEi8oH6CnGqS
 HfCeyogFSwKiQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 3/4] board: nbxv3: serses 1 lane settings
Date: Sun,  1 Nov 2026 22:31:09 +0100
Message-ID: <20261101213111.483600-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101213111.483600-1-vjardin@free.fr>
References: <20261101213111.483600-1-vjardin@free.fr>
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

Derive the mode from ${carrier}:

  nbv32              100g4x25g   1x 100GE + 4x 25G
  nbv32-40g          2x40g       2x 40GE
  nbv32-40g-4x10g    40g4x10g    1x 40GE + 4x 10G
  nbv32-100g-4x10g   100g4x10g   1x 100GE + 4x 10G

so that "setenv carrier <name>" alone selects the lanes and the data
path that describes them.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

(no changes since v1)

 board/nxp/lx2160a/nbxv3/carrier.c   | 97 +++++++++++++++++++++++++++++
 board/nxp/lx2160a/nbxv3/carrier.h   |  6 ++
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c |  4 +-
 doc/board/nxp/nbxv3.rst             | 22 +++++++
 4 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/board/nxp/lx2160a/nbxv3/carrier.c b/board/nxp/lx2160a/nbxv3/carrier.c
index 06a54bed0eb..26b079a1d3a 100644
--- a/board/nxp/lx2160a/nbxv3/carrier.c
+++ b/board/nxp/lx2160a/nbxv3/carrier.c
@@ -23,16 +23,20 @@
  */
 
 #include <env.h>
+#include <hwconfig.h>
+#include <malloc.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <vsprintf.h>
 #include <asm/io.h>
 #include <asm/arch/immap_lsch3.h>
 #include <asm/arch/soc.h>
 
 #include "carrier.h"
+#include "../serdes_split.h"
 
 #ifndef NBXV3_CARRIER_DEFAULT
 #define NBXV3_CARRIER_DEFAULT "nbv30"
@@ -148,3 +152,96 @@ void nbxv3_carrier_env_init(void)
 	printf("Carrier:       %s (%s, not saved; setenv carrier <name> && saveenv to pin)\n",
 	       carrier, origin);
 }
+
+/*
+ * serdes 1 lane grouping of each carrier, as a hwconfig serdes1:<mode>
+ * of board/nxp/lx2160a/serdes_split.c. A carrier without an entry
+ * keeps what the RCW provides.
+ *
+ * nbv32-40g used to need an RCW at serdes 1 protocol 20. serdes1:2x40g
+ * builds the same grouping from the protocol 13 RCW, and it is void
+ * for a protocol 20 one.
+ */
+static const struct {
+	const char *carrier;
+	const char *mode;
+} nbxv3_serdes1_modes[] = {
+	{ .carrier = "nbv32",			.mode = "100g4x25g" },
+	{ .carrier = "nbv32-40g",		.mode = "2x40g" },
+	{ .carrier = "nbv32-40g-4x10g",		.mode = "40g4x10g" },
+	{ .carrier = "nbv32-100g-4x10g",	.mode = "100g4x10g" },
+};
+
+/* Is ${hwconfig} serdes1:@mode ? */
+static bool nbxv3_serdes1_is(const char *mode)
+{
+	const char *arg;
+	size_t len;
+
+	arg = hwconfig_arg("serdes1", &len);
+
+	return arg && len == strlen(mode) && !strncmp(arg, mode, len);
+}
+
+/* Does ${hwconfig} name a SerDes 1 mode ? */
+static bool nbxv3_serdes1_named(void)
+{
+	int i;
+
+	if (nbxv3_serdes1_is("2x100g"))
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(nbxv3_serdes1_modes); i++)
+		if (nbxv3_serdes1_is(nbxv3_serdes1_modes[i].mode))
+			return true;
+
+	return false;
+}
+
+void nbxv3_serdes1_apply(void)
+{
+	const char *carrier = env_get("carrier");
+	const char *mode = NULL;
+	const char *cur;
+	char *saved = NULL;
+	char *hw = NULL;
+	bool set = false;
+	int i;
+
+	for (i = 0; carrier && i < ARRAY_SIZE(nbxv3_serdes1_modes); i++)
+		if (!strcmp(carrier, nbxv3_serdes1_modes[i].carrier))
+			mode = nbxv3_serdes1_modes[i].mode;
+
+	/* Put serdes1:<mode> in front of ${hwconfig} */
+	if (mode && !nbxv3_serdes1_named()) {
+		if (hwconfig("serdes1"))
+			printf("Carrier:       ${hwconfig} serdes1 names no mode, serdes1:%s of %s used\n",
+			       mode, carrier);
+		cur = env_get("hwconfig");
+		if (cur && *cur)
+			saved = strdup(cur);
+		hw = malloc(sizeof("serdes1:") + strlen(mode) +
+			    (saved ? strlen(saved) + 1 : 0));
+		if (hw && (saved || !cur || !*cur)) {
+			sprintf(hw, "serdes1:%s%s%s", mode, saved ? ";" : "",
+				saved ? saved : "");
+			set = !env_set("hwconfig", hw);
+		}
+		if (!set)
+			printf("Carrier:       WARNING: cannot add serdes1:%s to ${hwconfig}\n",
+			       mode);
+	}
+
+	lx2160a_serdes_apply_hwconfig();
+
+	/* The DS250 retimers do not follow the SerDes on their own */
+	if (nbxv3_serdes1_is("100g4x10g"))
+		printf("Carrier:       serdes1:100g4x10g mixes 25.78125 and 10.3125 Gbd lanes, set each retimer CDR to the rate of its lane\n");
+
+	/* Put ${hwconfig} back; NULL deletes it again if it was not set */
+	if (set && env_set("hwconfig", saved))
+		printf("Carrier:       WARNING: cannot restore ${hwconfig}\n");
+
+	free(hw);
+	free(saved);
+}
diff --git a/board/nxp/lx2160a/nbxv3/carrier.h b/board/nxp/lx2160a/nbxv3/carrier.h
index 44b2ce1f047..063765821eb 100644
--- a/board/nxp/lx2160a/nbxv3/carrier.h
+++ b/board/nxp/lx2160a/nbxv3/carrier.h
@@ -15,4 +15,10 @@
  */
 void nbxv3_carrier_env_init(void);
 
+/*
+ * Apply the serdes 1 lane of ${carrier}, unless ${hwconfig}
+ * names a serdes1:<mode>
+ */
+void nbxv3_serdes1_apply(void);
+
 #endif /* __NBXV3_CARRIER_H */
diff --git a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
index 69873909733..6dd05b5fe23 100644
--- a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
+++ b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
@@ -15,7 +15,6 @@
 #include <fsl-mc/fsl_mc.h>
 
 #include "carrier.h"
-#include "../serdes_split.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -35,7 +34,8 @@ void reset_phy(void)
 	 */
 	nbxv3_carrier_env_init();
 
-	lx2160a_serdes_apply_hwconfig();
+	/* Then SerDes 1, from ${hwconfig} or else from ${carrier} */
+	nbxv3_serdes1_apply();
 
 	if (IS_ENABLED(CONFIG_FSL_MC_ENET))
 		mc_env_boot();
diff --git a/doc/board/nxp/nbxv3.rst b/doc/board/nxp/nbxv3.rst
index 8259ca85095..0e3578b5742 100644
--- a/doc/board/nxp/nbxv3.rst
+++ b/doc/board/nxp/nbxv3.rst
@@ -121,6 +121,28 @@ no data path for the MC to manage and starting it hangs the boot.
 U-Boot clears ``mcinitcmd`` for that boot, whatever ``${carrier}`` is,
 and does not save it.
 
+SerDes 1 per carrier
+^^^^^^^^^^^^^^^^^^^^
+
+Before the MC starts, U-Boot should set the serdes 1 lane grouping
+that the MC's DPC and the DPL of ``${carrier}`` expect, using
+the ``serdes1`` hwconfig option. It can be used to
+override the RCW's protocol grouping for SerDes 1.
+
+==================== ================= ==============================
+``${carrier}``       serdes1 mode      SerDes 1
+==================== ================= ==============================
+nbv30                (none)            as built by the RCW
+nbv32                100g4x25g         1x 100GE + 4x 25G
+nbv32-40g            2x40g             2x 40GE
+nbv32-40g-4x10g      40g4x10g          1x 40GE + 4x 10G
+nbv32-100g-4x10g     100g4x10g         1x 100GE + 4x 10G
+==================== ================= ==============================
+
+Example to switch an NBV32 to 1x40GE + 4x10G::
+
+  => setenv carrier nbv32-40g-4x10g && saveenv && reset
+
 Boot flow
 ---------
 
-- 
2.43.0

