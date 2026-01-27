Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6805DD2594B
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 06:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78BA83FA3;
	Tue, 27 Jan 2026 07:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UwXSiGuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F8883FAA; Tue, 27 Jan 2026 07:24:12 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E077D83F85
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 07:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E486409A2;
 Tue, 27 Jan 2026 06:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E61FC116C6;
 Tue, 27 Jan 2026 06:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769495048;
 bh=+2zT9OdFnpFJJ5fGPWTUleM8x5J+pZakUQDtI/Tyupo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UwXSiGuLQQET7bdgiIihaeFxNmESDjROnhJVrCPXkep1cK47YE9Ovf0K5R2P8kea5
 VsLuqMPBT98RctbgYJHZ6+b1ZmAAXGtpZs9K5PrgG3g9XOvhZV2xYhvzaJK2IReuUQ
 Q6dCyODhH/7ZkPRxePQmoxFVWBXM7ErzF7ii/AQOC991IwMxs4bC+bSWiiODJwHuhP
 WjSVJx/AGwkC+rk2POiFtcV/0Y4aqCICmbUsFbkBY7/A/KDbFX4cd/G13TKJMPP9CV
 lIx4wqZEDJV2BTYkgPgxn24gdAYl/4ZA92VQRyPtSCLo222PDjhXe2DFHJUQQqo1tA
 3A4nJHDLzDASQ==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v3 2/3] mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
Date: Tue, 27 Jan 2026 11:53:40 +0530
Message-ID: <20260127062341.723966-3-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127062341.723966-1-sumit.garg@kernel.org>
References: <20260127062341.723966-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Add support for OP-TEE live tree DT fixup support which enables U-Boot
OP-TEE driver to be probed. As well as the EFI DT fixup protocol allows
the live tree fixup to be carried over to the OS for the OP-TEE driver
in the OS to probe as well.

Note that this fixup only gets applied if OP-TEE support is detected via
checking for OP-TEE message UID.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/of_fixup.c | 35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 5b6076ea8e5..644afc22d88 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -25,6 +25,7 @@
 #include <fdt_support.h>
 #include <linux/errno.h>
 #include <stdlib.h>
+#include <tee/optee.h>
 #include <time.h>
 
 /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
@@ -164,6 +165,37 @@ static void fixup_power_domains(struct device_node *root)
 	}
 }
 
+static void add_optee_node(struct device_node *root)
+{
+	struct device_node *fw = NULL, *optee = NULL;
+	int ret;
+
+	fw = of_find_node_by_path("/firmware");
+	if (!fw) {
+		log_err("Failed to find /firmware node\n");
+		return;
+	}
+
+	ret = of_add_subnode(fw, "optee", strlen("optee") + 1, &optee);
+	if (ret) {
+		log_err("Failed to add 'optee' subnode: %d\n", ret);
+		return;
+	}
+
+	ret = of_write_prop(optee, "compatible", strlen("linaro,optee-tz") + 1,
+			    "linaro,optee-tz");
+	if (ret) {
+		log_err("Failed to add optee 'compatible' property: %d\n", ret);
+		return;
+	}
+
+	ret = of_write_prop(optee, "method", strlen("smc") + 1, "smc");
+	if (ret) {
+		log_err("Failed to add optee 'method' property: %d\n", ret);
+		return;
+	}
+}
+
 #define time_call(func, ...) \
 	do { \
 		u64 start = timer_get_us(); \
@@ -178,6 +210,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 	time_call(fixup_usb_nodes, root);
 	time_call(fixup_power_domains, root);
 
+	if (IS_ENABLED(CONFIG_OPTEE) && is_optee_smc_api())
+		time_call(add_optee_node, root);
+
 	return 0;
 }
 
-- 
2.51.0

