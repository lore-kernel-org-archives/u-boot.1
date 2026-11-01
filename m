Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E4606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wDhP7IeK;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=SihWJPgd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD00E40523;
	Sun,  1 Nov 2026 21:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R34vAjMmgTnY; Sun,  1 Nov 2026 21:31:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 026CB40538
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568701;
	b=BlU6ZnFaGCaoYQ5758/8oqMWrFdpK92Z27TLdErqvLPEL3wcuMoT+hydEc+5M8aos6NE
	 PPCKwuRlr3iD/6msi+A+PJcrZ55alcz0t1SVTIGwQADacG2Nj33c4zJ93WqTQPLUugnJn
	 E5fWvsdSBzsGIK7vOJdWbHVOdGh6+1yoLK8Pqk6VBuY35qsIN//Os9BWRZKVhDLr2oYiC
	 iFIUshgdzl6gTpJtOAY7vS0PT9RvtgnvioEmcXhRpdru8yGwBc9SWOl4F2Xnp2kZTFxgA
	 HP10iZtJcxXb/Wf8TLRBpbZGZpYngDWh/LMzVL0R4BcFTf9qaU9iXVYG8vAyrqF9wsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EEakDiCos1PG54Ql+ViqoxtX9xnq5Hzh2EHF2Wetlag=;
	b=suJZnWnbO7nwQHxinpkp/x9ltQD/pcmSdmzYd0m0uDufSPxRL2zRwZe9sN11QijXmhfA
	 J7tH/e7/z1LGKC2st8hHOIJfpqZVqgnU3Jm1np16HrLDE+CL2pIoGsMU6MGMC53ABOpiv
	 lzDT/4PTVrNmhKd2tmpegg36Z/Ao+UPYHkeJXisxjINFhigdse8OP0RieFVWhv7xCt6Ki
	 BRKs0DTgRCGihQF8iRQtv/xu3QyRUG/pSsqSQnlLquk90bhTogD3NYVpuY46r9l84JAMk
	 q/6xpwTk0H5Tj/+I2B1euHS9joSE3K7etIKeH1LC+url669Bkn9GWhudk0zXWa/pY+w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568701;
	bh=EEakDiCos1PG54Ql+ViqoxtX9xnq5Hzh2EHF2Wetlag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wDhP7IeKZFhuUXtBC5qoRjjcrdtaHuxmKtYDVkVCi4/VlsDz9m+6L7t3olLFzdgO9
	 RqjB2Fpxanmhbkjnag8P6uuOse/HztH8WuVyIgkmdUDZuemHx2gneocryzIUq9xZ/G
	 UE+hzbXP/rGjAZ9AHwCA+aQ1BGwO9IC8LdIbrFMFgmKM+uFBF7zCvF87iuVtHQYPgx
	 vueWWJSqfwSIIGKS7HdyhnfE1ViEqiNAhkJftzKvdwL0I2WH3I8y5k3DQz7xUvvZIh
	 wWfZaW0r2vcN579RDo7crjkxkzMSlzgqw4I0WVD7S1kjBmH2Ld8ruBLKsjBKu153Eu
	 oDQ1ZtNvwk43A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 026CB40538;
	Sun,  1 Nov 2026 21:31:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C437B2AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B64E980D9F
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iHw-UDC8lXXs for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:31:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB6E380D80
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568699;
 b=Qe14ITkHLftQ5cPtc1Xgw4pvws6TfONP5/7dJqKsnSqMiFSUSKTF2pnVKKNYYa9gRHiI
 2yMxXM0IuzFvGz71L84+je91bEd+uCQS3thVtATZMhYJeA3BRdvlDTO/nQE6SMNka7p/u
 sQMGg6EfanY4lxdPkFvyzJpsKV7wFhJ0wtqg6D+7M6f/ANC2h2bAB0MuhFOYtF3molvWk
 3+C+e3ikdn3Jer4cSG1zGz9mWgmfk7G+bJxGAeT+xMLRjA53vPTXoiXmRZLVLwOE8XoQe
 pw+3etFEKxIF4Ykl64kCet4lA0o9UO5kAQ5WPjsTbLomTzGchwchtT3TqmvPfhK1hdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568699;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=EEakDiCos1PG54Ql+ViqoxtX9xnq5Hzh2EHF2Wetlag=;
 b=qBZOPJx7XuWXYSzjx+/QBcquTLOXN/TY2N3gHYzzHEAG8TJ296q+h+03H+IQGT+mjK8p
 2RqP36OIGrixrM/L0o7VkyYsZOzktmUlUqRAQV0/NB1ZuCfSagvKl+duN2RhYC5Dh3Z1W
 /Dv4gILnL8zC3janLO9udRm8BrNUMrf/cNMr4GZdjdcJ3KKxf+bHfU2q6TMNec/A1VkrU
 TjNBPl0//rn+lW33Y8CYxUuCW0r/FZ7AaF8Rotp7+VfTlFf1EtcdM+RNJHFDwDVjz8Hyk
 o5v6xJ4fP8KJzn02Kcd8bqrxjMHe7OAoGzCvkZpuedrsrVJ9SY5BDQa10GAqy4aUnBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=SihWJPgd; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=SihWJPgd
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB6E380D80
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id EF1C3B00535;
 Sun,  1 Nov 2026 22:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793568696;
 bh=sDyRh6DmZ5Dyxpwip7rPujLhs45NCUl6vberB2xKRHs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SihWJPgd8reS93BJL/zAitauokI1ABtLbC/YchgSxvnR84jIlQ6/diYtSNvXBj4vh
 Bxo8hpZqXjmNfiB3vdRyMgkcxv2cUA/uEUbaZudJ73VN7TEriyJY+eLBJlxWnudwzl
 q0SniW4Ga2An+N5kOjyACv76UVb70zG+9XLkqlO8mpkAsTLDleQuxrWJufC5oykeFM
 h3koGeO6DWXsqzpR1Mpc+fdr1I76uaOLY4fuU3tgCAEfZiexy9RGEyI1+0wayqtY+W
 TEOjZJ0n/u0SHWtl+aBYt4TnAqBkwppOjZ3RgSAGPh1OcpfjcTvra5W0L/jpfq6gjQ
 G/Br76p6YkMBw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 1/4] board: nbxv3: get carrier from the RCW build stamp
Date: Sun,  1 Nov 2026 22:31:07 +0100
Message-ID: <20261101213111.483600-2-vjardin@free.fr>
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

${carrier} selects the kernel's DTS and the MC's the DPC + DPL
to beloaded from the FIT.

Into the FIT, they should have the following names:
  conf-, dpc-, dpl-${carrier}

The console shall display the selected carrier.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

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

