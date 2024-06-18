Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B79EC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDFEC88365;
	Tue, 18 Jun 2024 17:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pFqIUBGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA78A8819D; Tue, 18 Jun 2024 17:34:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC967882EF
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A7133617DF;
 Tue, 18 Jun 2024 15:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C22FC3277B;
 Tue, 18 Jun 2024 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724886;
 bh=J5BnbFVc9JNZak57au9RJy1uTBZfIa/8FQ148kuVOj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pFqIUBGjF7kLASoaEsj9JqdXtOAeBSdC+Syopc076qIkDsny+LvrDC5a0e3LK/SZw
 sS9lZe1tAbHjM92U3eBpuqFVr0hS9aaI2cbrmRjGG7u2JctSZzQyTIhrb9XJDv2dQT
 yl9I75mrIXMC+4NvyqX7Jn6pMopi2lzm4aFyI7IyJpM4sHUqxkmeZ9ngQAYrBh8yN1
 WcucAln/tjI7j/zJFrLTM8sctWYCkkJHLCT3YpnPTifiHb6vukt62uYd0qWx/QQv7p
 5tHIxLLBfvZtJGWiNq8aoN9tJ3YH66ouJh6eBgUwlRk5ptDFjHsUNn9SzOdg1DEjCg
 eSKKg+RNVHhFQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 02/16] ddr: marvell: a38x: debug: return from
 ddr3_tip_print_log() early if we won't print anything
Date: Tue, 18 Jun 2024 17:34:25 +0200
Message-ID: <20240618153439.9518-3-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240618153439.9518-1-kabel@kernel.org>
References: <20240618153439.9518-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Return from ddr3_tip_print_log() early if we won't print anything
anyway.

This way the compiler can optimize away the VALIDATE_IF_ACTIVE() calls
in the for-loop, so if the SILENT_LIB macro is defined, no code is
generated for the rest of the function, which saves some space.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/ddr/marvell/a38x/ddr3_debug.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ddr/marvell/a38x/ddr3_debug.c b/drivers/ddr/marvell/a38x/ddr3_debug.c
index 9e499cfb99..0374a84387 100644
--- a/drivers/ddr/marvell/a38x/ddr3_debug.c
+++ b/drivers/ddr/marvell/a38x/ddr3_debug.c
@@ -399,6 +399,15 @@ int ddr3_tip_print_log(u32 dev_num, u32 mem_addr)
 	}
 #endif /* DDR_VIEWER_TOOL */
 
+	/* return early if we won't print anything anyway */
+	if (
+#if defined(SILENT_LIB)
+	    1 ||
+#endif
+	    debug_training < DEBUG_LEVEL_INFO) {
+		return MV_OK;
+	}
+
 	for (if_id = 0; if_id <= MAX_INTERFACE_NUM - 1; if_id++) {
 		VALIDATE_IF_ACTIVE(tm->if_act_mask, if_id);
 
-- 
2.44.2

