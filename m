Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FACC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 05:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C30880BA8;
	Wed, 23 Apr 2025 07:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KZAEkm2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A11080EE5; Wed, 23 Apr 2025 07:11:44 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1282A8082A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 07:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id EF7A7A4BF73;
 Wed, 23 Apr 2025 05:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D44C4CEE2;
 Wed, 23 Apr 2025 05:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745385100;
 bh=ZFEQ4btRPtt9cLeMaSyjapkPHDFx9Y0feJ7uT63NeoM=;
 h=From:To:Cc:Subject:Date:From;
 b=KZAEkm2uXMBIXraUP3i2Aa+E94xddT3tLOxDcrnw80ql1brPr4KitgHz3koHIJhVB
 gEe42NMvLCn4vwnBjXlq3oEwzNGyzIv9GdnjzMJNrD3IjZaZkG5sHkDwBaG2J/UR0Z
 Rp16tI6sJ7TuLc5yGJ11Ijazq7kX/tk4gZePW/6BuyZcBAJq08qM6SZqlXt0lI6ARt
 8jMCOIfOTH5h15QzcE/HemOIXIsPPBOITGo3zYpa62wotVYn1FXdUINLII/fKXo8Og
 r8qzTkRPpeIh2xe1WDQy6EgK3fCBe6xty58VjjyPykXCvY3mG+3hTaxg2eQbAdP3mU
 WYO+hLLyW7XHg==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 loic.minier@oss.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH] mach-snapdragon: Update fdtfile logic to work for RB1 and RB2
Date: Wed, 23 Apr 2025 10:41:32 +0530
Message-ID: <20250423051132.292329-1-sumit.garg@kernel.org>
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
 arch/arm/mach-snapdragon/board.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index deae4d32378..dc8220e89b4 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -437,16 +437,24 @@ static void configure_env(void)
 
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
-- 
2.43.0

