Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE95DC3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53DAD81F7B;
	Mon,  5 May 2025 14:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C3qBXPqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E5F82076; Mon,  5 May 2025 14:43:49 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532F180F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 14:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EF0354A4E1;
 Mon,  5 May 2025 12:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0761EC4CEED;
 Mon,  5 May 2025 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746449025;
 bh=aXCxB9wZ6MmzS4IfZTgGoTNa3hrF4ntA/Gu2ZommeKc=;
 h=From:To:Cc:Subject:Date:From;
 b=C3qBXPqqvRXcvRLGIEY/uIuH650ODZsy8NIkvEjcflFNYdfrx+VrnDvKhYxFI1WTo
 ERBvabvdvREpPJai1vgmwH6xkhy3S3zEMQVz4JGqawQ08oX2TmbjyA8Dlqw2XHVf9I
 +nXvpZPvrPCRYu8u1TBcVQ0HuHrn+Mbk7bJs0p27TWT2tOdaafLF9e+db8cegFRtO5
 2APjqBVZI8fyvZVPzbD1IeltBdy2JtGX3W/FFYGxupWf+2jFDbgYe6bEzYFW3DN7iK
 azAfhT+bfRinFiyPeeVOyYinsMMkqDVAiWK20Jce+CaUCp2MhgieN+Nu8KXskzPzcF
 UXDiqpmugzOUg==
From: Sumit Garg <sumit.garg@kernel.org>
To: casey.connolly@linaro.org,
	neil.armstrong@linaro.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 loic.minier@oss.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2] mach-snapdragon: Update fdtfile logic to work for RB1 and
 RB2
Date: Mon,  5 May 2025 18:13:33 +0530
Message-ID: <20250505124333.12344-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.43.0
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

RB1 and RB2 have three root compatibles where the last one can't be used
to decode fdtfile name (qcm* vs qrb*). So rather just rely on the first
compatible to retrieve the SoC name.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 63 ++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 27 deletions(-)

Changes in v2:
- Avoid redundant env_set() for SoC name.

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index a3b39e3b4b3..5f241bafc85 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -417,52 +417,39 @@ static void configure_env(void)
 		return;
 	}
 
-	/* The last compatible is always the SoC compatible */
-	ret = ofnode_read_string_index(root, "compatible", compat_count - 1, &last_compat);
-	if (ret < 0) {
-		log_warning("Can't read second compatible\n");
-		return;
-	}
-
-	/* Copy the second compat (e.g. "qcom,sdm845") into buf */
-	strlcpy(buf, last_compat, sizeof(buf) - 1);
-	tmp = buf;
-
-	/* strsep() is destructive, it replaces the comma with a \0 */
-	if (!strsep(&tmp, ",")) {
-		log_warning("second compatible '%s' has no ','\n", buf);
-		return;
-	}
-
-	/* tmp now points to just the "sdm845" part of the string */
-	env_set("soc", tmp);
-
-	/* Now figure out the "board" part from the first compatible */
-	memset(buf, 0, sizeof(buf));
 	strlcpy(buf, first_compat, sizeof(buf) - 1);
 	tmp = buf;
 
 	/* The Qualcomm reference boards (RBx, HDK, etc)  */
 	if (!strncmp("qcom", buf, strlen("qcom"))) {
+		char *soc;
+
 		/*
 		 * They all have the first compatible as "qcom,<soc>-<board>"
 		 * (e.g. "qcom,qrb5165-rb5"). We extract just the part after
 		 * the dash.
 		 */
-		if (!strsep(&tmp, "-")) {
+		if (!strsep(&tmp, ",")) {
+			log_warning("compatible '%s' has no ','\n", buf);
+			return;
+		}
+		soc = strsep(&tmp, "-");
+		if (!soc) {
 			log_warning("compatible '%s' has no '-'\n", buf);
 			return;
 		}
-		/* tmp is now "rb5" */
+
+		env_set("soc", soc);
 		env_set("board", tmp);
 	} else {
 		if (!strsep(&tmp, ",")) {
 			log_warning("compatible '%s' has no ','\n", buf);
 			return;
 		}
-		/* for thundercomm we just want the bit after the comma (e.g. "db845c"),
-		 * for all other boards we replace the comma with a '-' and take both
-		 * (e.g. "oneplus-enchilada")
+		/*
+		 * For thundercomm we just want the bit after the comma
+		 * (e.g. "db845c"), for all other boards we replace the comma
+		 * with a '-' and take both (e.g. "oneplus-enchilada")
 		 */
 		if (!strncmp("thundercomm", buf, strlen("thundercomm"))) {
 			env_set("board", tmp);
@@ -470,6 +457,28 @@ static void configure_env(void)
 			*(tmp - 1) = '-';
 			env_set("board", buf);
 		}
+
+		/* The last compatible is always the SoC compatible */
+		ret = ofnode_read_string_index(root, "compatible",
+					       compat_count - 1, &last_compat);
+		if (ret < 0) {
+			log_warning("Can't read second compatible\n");
+			return;
+		}
+
+		/* Copy the last compat (e.g. "qcom,sdm845") into buf */
+		memset(buf, 0, sizeof(buf));
+		strlcpy(buf, last_compat, sizeof(buf) - 1);
+		tmp = buf;
+
+		/* strsep() is destructive, it replaces the comma with a \0 */
+		if (!strsep(&tmp, ",")) {
+			log_warning("second compatible '%s' has no ','\n", buf);
+			return;
+		}
+
+		/* tmp now points to just the "sdm845" part of the string */
+		env_set("soc", tmp);
 	}
 
 	/* Now build the full path name */
-- 
2.43.0

