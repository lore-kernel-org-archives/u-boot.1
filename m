Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688C5C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 16:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4BC288167;
	Mon, 15 Apr 2024 18:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AwCU5B3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4403C87A0E; Mon, 15 Apr 2024 18:30:55 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E81ED87E75
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 18:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 136E1CE0E5D;
 Mon, 15 Apr 2024 16:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7302DC3277B;
 Mon, 15 Apr 2024 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713198649;
 bh=HknXOQaTyUBWD0O77hkErcv5jhDdH7H3lQgF0fy5HW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AwCU5B3YB8Tms2WFoBNRZM4lCJT4iy3hfHMKx3bBp24jPbkB3d4QbxvRT4ABCC0zI
 5oyDLqfyiQ3MXd4sj4bC2aVxPpWBGvWhq47QnfaUGe5xQG4Rx8iepiUULjU7GdzUqN
 1671z+8zmP/pmJuG3xjF1riTSNEEGAGl0EjprYNRTlIAlopL3ngtzYUpJjIEmFi/6o
 bU6jcMrBqV9T1fVzg5TViEg3QnZogBPwnegZYoSpdpNp2esomqqgMcHsehbgQ3Gb80
 c1ivMm0VY5P8nmj2btb/qrWgjBzMQXXrYmGIoLbsaHCoCPfym5eFknPKwZyOu6jTZK
 bSG4ACIdMOX6w==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 01/10] ddr: marvell: a38x: debug: return from
 ddr3_tip_print_log() early if we won't print anything
Date: Mon, 15 Apr 2024 18:30:34 +0200
Message-ID: <20240415163043.7482-2-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415163043.7482-1-kabel@kernel.org>
References: <20240415163043.7482-1-kabel@kernel.org>
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
2.43.2

