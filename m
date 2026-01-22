Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB8FC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 08:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 734B083B03;
	Thu, 22 Jan 2026 09:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W9jeDtwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAA083B22; Thu, 22 Jan 2026 09:58:56 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DFF283B0B
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BB8A1443CE;
 Thu, 22 Jan 2026 08:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55F5C116C6;
 Thu, 22 Jan 2026 08:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769072331;
 bh=uC4srptmu4l7fqxISflFqKBoooN1LLNCvJ0T2OMZ3yc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W9jeDtwVeK97bX4ffDk6nHBf2TxzTf4zpDbdh2fSVGZBsq8mAweLQyusGBHyu+l3c
 Q3V7Wvbhy69f3P5ueo7FccHk7fMuFHWzNledKnfQIECouDvahlj8PTVnur148XdvdI
 xSRy8au8orGvMybYKm7yzs7+4Nds6djjQKES3OoaRv+GkBupWRkuSzJ7/MLwPbJP6W
 i9/hihmk5BXnFS9RaffvqBr/x5A8SoxUwGf+nLygTyPuc2W20LUHPUkbkiYmGU0Qq7
 6OFQYk9G3fQ+x2/FlVaO26y28Z8bKyOU2DZ1IXjDgCH0wmo9In8XzoQhm02gj2dmaD
 xETKqbE8Fvv3A==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 2/3] mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
Date: Thu, 22 Jan 2026 14:28:05 +0530
Message-ID: <20260122085806.542149-3-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122085806.542149-1-sumit.garg@kernel.org>
References: <20260122085806.542149-1-sumit.garg@kernel.org>
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
index 5b6076ea8e5..3d19449f133 100644
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
+		log_err("Failed to add 'maximum-speed' property: %d\n", ret);
+		return;
+	}
+
+	ret = of_write_prop(optee, "compatible", strlen("linaro,optee-tz") + 1,
+			    "linaro,optee-tz");
+	if (ret) {
+		log_err("Failed to optee 'compatible' property: %d\n", ret);
+		return;
+	}
+
+	ret = of_write_prop(optee, "method", strlen("smc") + 1, "smc");
+	if (ret) {
+		log_err("Failed to optee 'method' property: %d\n", ret);
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
 
+	if (is_optee_smc_api())
+		time_call(add_optee_node, root);
+
 	return 0;
 }
 
-- 
2.51.0

