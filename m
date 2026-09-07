Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293E7C79FA0
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 15:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D44C7606B3;
	Mon,  7 Sep 2026 15:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IbIUYvZyu5fh; Mon,  7 Sep 2026 15:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EC4C66066F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788795393;
	b=jdrjgNfp7o31hK9mGRGscaWck5Q8XrKkiSiM3qWJIUXaxeBcJelCYB4iOTSzt9p43eRT
	 tuukLrfV//hdPMLL613e+4qUNm+o00r0MkbDB4xHFUTrs6+wWMxvGz+po7el04UG7fKR0
	 nVXSSh1vR6QV6HPIhizem99mrDXo7y/y3Y7IkERkcHiR4r/XInk/bpymjF9famaUcpg3O
	 Lr563pKknQ7blYyVNgzd46VG3GwQgJJ2heRuhNH5w/fjCWQAlU/+SPJaaEhAeoGIHUc35
	 fr+Loy77jGzit4OoZhz5WoSVCdgFaXszDDal5wa7yhM110HjnG+uqgwBxVj8eF2X55w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788795393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OgozNta1eKW7d5Stx1dvirnny4effV46ghByzNNVHzI=;
	b=GV1hCzLDWdtR8ISksxVZyQgUZtIdzbP70WvFudE349kItzWxSRE3ICAkUWkqjQUqj/Mw
	 AH00yEa+adu6ooqr2RW2Va7HcEhf8cg9tx4MZnpfOvpdhab9NquMGq//mbU4EefS1qtCK
	 UWZDcOl4aHL9XNEIbQHP1BoIn2tjRDLECFQr77F6v6a1XnWqOUvsjP+7sVBbjj9v04y7u
	 zy0Qmfsj458ZBcMe/0nLfD4Xq87ljM9OQS4+fOFzGk6Dzch+S4RLY5xkbh/lPMifnR+9T
	 ju1R8mItZBQAxQhU4KrjOlUchRQgrGZ7o8Y1ZSGLJNno/cfekgphbVl+HGoE6frSu2g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=QwUxD2RU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788795393;
	bh=OgozNta1eKW7d5Stx1dvirnny4effV46ghByzNNVHzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nLdq3k7f1ODJtejlL4L6EOhj0HiM4pIytNthSLnXqbQ9XTMLCdofUNw+Do8d6ekoh
	 vma+bNFG4PjP1Jw5Tz4fHtIJI9011NK78CtxShp/HeOxXmqMZeMBicyAZaTTtyUQw8
	 BjmziyiodvoZbg/SYKlZo+p8nsFpLov6qOnv0j2LZqws1SJ5JGjIjVzxOdQsZ6sy6y
	 xL+lsdss5JRAU+fKpCBeUetAitkWzc8I+PFUrPrI267rdqcZoTQMQUMJdFl8dpyTE1
	 I2NVZq97D6vMIDlfOuZflV/SORJCpHYbqhFqg6F4+Zyug9H+pMkus3UiqQARMd9kuM
	 zNFk8TtvmDFNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC4C66066F;
	Mon,  7 Sep 2026 15:36:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B21DB9CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A38F56066F
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p-70-Xb6GLVh for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 15:36:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D58EA6066E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788795391;
 b=gM1QBWFXgO0D15doPbEhptFQLMeLYWE3x9gs9N+Q94Df8KyBaln8Tm83VIWDMV18NPgy
 zi0NS+F+AdyE3d9PvbF/QOy/DynlnMZ373tnU7I1GCDuQWrLmFzB6mX8bv5gqhrJKftdj
 MePcIjUfjPA98uAO9DVOmiM1lMYS5c6dF83xXpWIuxzodnBgnPuF4VJZRwFVK7Fue7Q9l
 0C6p0+MVOZh+nXSKGulNdHRk8QoBGXXUt+U+0cAEc0Zi6QmlfqhL2Pn7HG47yfKcSlXmX
 YYpByS3TEDdGGyCVJZEcMWGDP6/34pF2Wjf0uwClwvKKiaOF/RkZvofijumbSY5avLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788795391;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=OgozNta1eKW7d5Stx1dvirnny4effV46ghByzNNVHzI=;
 b=FRabZJMHInc5e4fxK7mJRurNFDfElHUX9x08Pbu4YT19Te3GurkGMtQLzesieCu/dWqt
 pRFMrEMamNFtUIaYxFM2WKRmijGyWgS8Wh89B1sNG/0bBf0VWVWbKZVLgoPE3UoJLI6cl
 owmUih2W2fsELbagOecZzUKHYz3VF1iVJijTv0hGs3xiOP1pWaZi0dJ1H5IDbEsn36grg
 bVdR30djiU8Rm/LmlDkWbTJTgoQRhMzuKJmheMEgK5QnxSIMpPYgSkfrCY30FvIqpzxW1
 +beoOYTsYmxO2uT25QHBJubF770xs1fNCMxz7sGaDPLHHiR29mOOaDzoTaLpBSCsKVw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=QwUxD2RU; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=QwUxD2RU
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D58EA6066E
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 52CA8B00539;
 Mon,  7 Sep 2026 17:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1788795387;
 bh=xt0deyXDvt6jiX0APVQUsX6tmXRcEWxZnPH5rX5cW3U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QwUxD2RUWy3VG0+5UGXRreCBKAvzw2R2JJb5cr6f0HWOIGdGb718/fuQoJNabf4Nx
 nQCQE+Sp9dbKyqmQ6qE9b4JA6bv6sBj8n1lrc4mEDuyZHIYxZOos8Yrhw9lWQJK9yh
 h7s5NIWeY2MSjV/ZyrV8W2v0XjeBJdeK8jgr5aYrDSdAWD9KljpCSVI+JgexPxwtBV
 aBK4srdlsop8n5us8iivnDeh6HuNpwsLv5GKcP02q8tO/VikKaUv5QuaNoXmVXm60K
 +SALpUkEMncAnXNxtQ0rOORnOROn0/fv92QS+oEGgbW8xnJI99nlrL42VRUjaKVTa4
 XUEExN/FcEQWw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 6/8] board: nbxv3: select carrier at boot
Date: Mon,  7 Sep 2026 17:34:08 +0200
Message-ID: <20260907153411.2207773-7-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907153411.2207773-1-vjardin@free.fr>
References: <20260907153411.2207773-1-vjardin@free.fr>
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

The Nodebox v3 CPU module runs on several carriers. They share one
kernel Image but they need different DTBs and different DPAA2 DPC/DPL,
so the kernel FIT carries every carrier's set as fdt-<c> / dpc-<c> /
dpl-<c> with a conf-<c> configuration each, and U-Boot picks one:

  mcinitcmd   imxtract ... dpc-${carrier} / dpl-${carrier}
  mc_init     bootm ${kernel_addr_r}#conf-${carrier}

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 board/nxp/lx2160a/nbxv3/Makefile    |  1 +
 board/nxp/lx2160a/nbxv3/carrier.c   | 64 +++++++++++++++++++++++++++++
 board/nxp/lx2160a/nbxv3/carrier.h   | 17 ++++++++
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c | 10 +++++
 4 files changed, 92 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/carrier.c
 create mode 100644 board/nxp/lx2160a/nbxv3/carrier.h

diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
index 68fab9bf18f..f6df35ed7c5 100644
--- a/board/nxp/lx2160a/nbxv3/Makefile
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -6,3 +6,4 @@ obj-y += eth_nbxv3.o
 obj-y += mps_pmbus.o
 obj-y += psu_pmbus.o
 obj-y += vid_handoff.o
+obj-y += carrier.o
diff --git a/board/nxp/lx2160a/nbxv3/carrier.c b/board/nxp/lx2160a/nbxv3/carrier.c
new file mode 100644
index 00000000000..c810fe01957
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/carrier.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Nodebox v3 carrier selector.
+ *
+ * The CPU module is used on several carrier boards (nbv30, nbv32, ...).
+ * They share a same kernel Image but they need different DTBs and different
+ * DPAA2 DPC/DPL.
+ *
+ *   images:         fdt-<carrier>, dpc-<carrier>, dpl-<carrier>
+ *   configurations: conf-<carrier>
+ *
+ * and then the boot env picks one with ${carrier}:
+ *   mcinitcmd  imxtract ... dpc-${carrier} / dpl-${carrier}
+ *   mc_init    bootm ${kernel_addr_r}#conf-${carrier}
+ *
+ * For testing, we can enforce, change it from the prompt and make it persistent:
+ *   setenv carrier nbv32 && saveenv && reset
+ */
+
+#include <env.h>
+#include <linux/kernel.h>
+#include <vsprintf.h>
+
+#include "carrier.h"
+
+#ifndef NBXV3_CARRIER_DEFAULT
+#define NBXV3_CARRIER_DEFAULT "nbv30"
+#endif
+
+/*
+ * Placeholder for strap/EEPROM based identification.
+ * Returning NULL means "cannot tell".
+ */
+static const char *nbxv3_carrier_detect(void)
+{
+	/* TODO, not available yet */
+	return NULL;
+}
+
+void nbxv3_carrier_env_init(void)
+{
+	const char *carrier = env_get("carrier");
+	const char *detected;
+
+	if (carrier && *carrier) {
+		printf("Carrier:       %s (from env)\n", carrier);
+		return;
+	}
+
+	detected = nbxv3_carrier_detect();
+	if (!detected)
+		detected = NBXV3_CARRIER_DEFAULT;
+
+	if (env_set("carrier", detected)) {
+		printf("Carrier:       WARNING: cannot set ${carrier}\n");
+		return;
+	}
+
+	/* Not saved on purpose: saveenv on every boot would burn the NOR */
+	printf("Carrier:       %s (default, not saved; setenv carrier <name> && saveenv to pin)\n",
+	       detected);
+}
diff --git a/board/nxp/lx2160a/nbxv3/carrier.h b/board/nxp/lx2160a/nbxv3/carrier.h
new file mode 100644
index 00000000000..e7eb42265e4
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/carrier.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ */
+
+#ifndef __NBXV3_CARRIER_H
+#define __NBXV3_CARRIER_H
+
+/*
+ * Ensure ${carrier} is set before anything consumes it.
+ * It is idempotent, and it never overrides a value already present
+ * in the uboot's environment.
+ * It shall run after initr_env and before ${mcinitcmd} is evaluated.
+ */
+void nbxv3_carrier_env_init(void);
+
+#endif /* __NBXV3_CARRIER_H */
diff --git a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
index 8aec68c571f..a8d249c5cac 100644
--- a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
+++ b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
@@ -14,6 +14,8 @@
 #include <exports.h>
 #include <fsl-mc/fsl_mc.h>
 
+#include "carrier.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 int board_eth_init(struct bd_info *bis)
@@ -24,6 +26,14 @@ int board_eth_init(struct bd_info *bis)
 #if defined(CONFIG_RESET_PHY_R)
 void reset_phy(void)
 {
+	/*
+	 * MUST come first: mc_env_boot() evaluates ${mcinitcmd}, which
+	 * imxtracts dpc-${carrier} / dpl-${carrier} out of the FIT. If
+	 * ${carrier} is still unset a subimage named "dpc-" and the MC
+	 * firmware never starts.
+	 */
+	nbxv3_carrier_env_init();
+
 	if (IS_ENABLED(CONFIG_FSL_MC_ENET))
 		mc_env_boot();
 }
-- 
2.43.0

