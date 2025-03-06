Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C27C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 20:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3123A80F4C;
	Thu,  6 Mar 2025 21:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=os-cillation.de header.i=@os-cillation.de header.b="NzPFPuk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAF580F9E; Thu,  6 Mar 2025 21:16:40 +0100 (CET)
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0265680E94
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 21:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=os-cillation.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hd@os-cillation.de
Received: from core2024.osc.gmbh (p578a635d.dip0.t-ipconnect.de [87.138.99.93])
 by os-cillation.de (Postfix) with ESMTPSA id 82893C0288;
 Thu,  6 Mar 2025 21:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
 s=202409; t=1741292197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4i6+ydjSo4OcgC3c5KPMknnc0PLEWUSvQx3dWRHXGak=;
 b=NzPFPuk007BeuWMZcHFCK+8dyt3RcBDy9r7K4bfJrOqPoSLsu0ANiZpzHoUzYuMaaJRM4f
 pQtcivq+74Ar7vVJK7vo4OzCUc0zKXu9IbrQw3LA1LjG2XaHpGYxDaHlYp5B06NLadHDwy
 GeThDOH5UWifXNKkZu+uIZKjLt17yb2UoSjjmIGX6U1wlrIK296Ar8rcsaGjaarya9676i
 eD/rw8iOLyTuzkCR8kp30X8hxeYkXWzsPOMpMMtr5tzMX6Rh6UlROOaWFE6XH6SYHiipgb
 JCk7GGpTNQmcTnQNarn86kkf3RsRE5Kg+qjG/Hs1mRUfM4mu7DPGrcx5sdviZQ==
Authentication-Results: os-cillation.de;
 auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from hd2022.osc.gmbh (hd2022.osc.gmbh [192.168.3.45])
 by core2024.osc.gmbh (Postfix) with ESMTPSA id 274F42002ED;
 Thu,  6 Mar 2025 21:16:37 +0100 (CET)
From: Hendrik Donner <hd@os-cillation.de>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, Hendrik Donner <hd@os-cillation.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] checkpatch.pl: Report an error for CONFIG_xPL_BUILD in device
 trees
Date: Thu,  6 Mar 2025 21:15:39 +0100
Message-ID: <20250306201540.127646-1-hd@os-cillation.de>
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

The defines for the different build phases shouldn't be used in device
trees, currently they aren't even defined for device tree pre processing,
resulting in build errors.

Link: https://lists.denx.de/pipermail/u-boot/2025-March/582787.html
Signed-off-by: Hendrik Donner <hd@os-cillation.de>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b8eb57f38c7..119916d4c78 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2692,6 +2692,12 @@ sub u_boot_line {
 		ERROR("PRE_SCHEMA",
 		      "Driver model schema uses 'bootph-...' tags now\n" . $herecurr);
 	}
+
+	# Do not allow CONFIG_xPL_BUILD in device trees
+	if ($realfile =~ /\.dtsi?$/ && $line =~ /^\+.*CONFIG_(X|S|T|V)PL_BUILD.*/) {
+		ERROR("CONFIG_xPL_BUILD",
+		      "Do not use CONFIG_xPL_BUILD in device trees\n" . $herecurr);
+	}
 }
 
 sub exclude_global_initialisers {
-- 
2.43.0

