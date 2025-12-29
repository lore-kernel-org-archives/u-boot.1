Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268ABE8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 11:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD5483A94;
	Mon, 29 Dec 2025 12:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="quNFXtWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 035A183B0B; Mon, 29 Dec 2025 12:43:38 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7AF83966
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 12:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AEFE160010;
 Mon, 29 Dec 2025 11:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D86C116D0;
 Mon, 29 Dec 2025 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767008614;
 bh=iu12h08Bd529YbowTWTu/ABoRg5Y3fIE5tw/2dSfr5w=;
 h=From:To:Cc:Subject:Date:From;
 b=quNFXtWeXcJx1l962nORcuVEj2t0UidXSqPQd7B9dge87NuI9awyitFQV96+o73sT
 awYWaVsAetTh8Sj8ZgPOaW8WzzifHr7ZACmnDVNMxBBdyPC0aiPHH3n954FnhIB2QT
 Js3R28A5yKfZkrSC0ED6cHPDEHQANKJr4uar6TUBe9Ds45MrgjVu77xLpBv3RwbDiv
 1giwdZX24OrN0Va5bOaNKCPMqV1KWwP2qbHcfqViva9zhHJYyGSC53Gd/mmZcSw7e7
 Tw/Zyry9GvDLtngsn7iW+pI3ca27hm6gMaW4b4D19bYYZsvp/TObQ2hDG8kcNhtYXF
 RpaTNy860/hyA==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 1/2] mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
Date: Mon, 29 Dec 2025 17:13:11 +0530
Message-ID: <20251229114312.668068-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
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

Note that this fixup only gets applied if CONFIG_OPTEE gets enabled.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/of_fixup.c | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index eec2c0c757e..29a99f73cf3 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -146,6 +146,37 @@ static void fixup_power_domains(struct device_node *root)
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
@@ -160,6 +191,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 	time_call(fixup_usb_nodes, root);
 	time_call(fixup_power_domains, root);
 
+	if (IS_ENABLED(CONFIG_OPTEE))
+		time_call(add_optee_node, root);
+
 	return 0;
 }
 
-- 
2.51.0

