Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E31C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 16:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B94A88190;
	Mon, 15 Apr 2024 18:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DA65ZW0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F3AE880D6; Mon, 15 Apr 2024 18:30:56 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BA8880F8
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 18:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9D094CE0E62;
 Mon, 15 Apr 2024 16:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07216C3277B;
 Mon, 15 Apr 2024 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713198651;
 bh=2IH65rDRcbckoboL1nZ9DranuYRGgKSwoocm9NUQxX0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DA65ZW0VW6uXMx/m//qL1G20sZzOF4GplYsl2z1sZhlgeguymn2sBPjO+kqjZcKgE
 UEoXPCww8LvRbrypMDlrXnlPN5WJSwZdF8qkCUNrkbAVMEZNCmu29glv+rEHbnKfEp
 QwkeD4Vw6Vo6YQEwXIrlcELsbfeYbjoGUoKCqqc9v/9olt7P4LGC4BH8pRx6VSKHFz
 mMH4VnEt41z98wXVFdgI12UntwXD3cjcveuR+D/Hi0yX3m9+kTJ/wLjFOeU5WxPHyC
 5dMkAt3nCqF/RJVvynxhxOZSVDBM6VyJ14GD0g5Eet2/Q/yexposiIup2mxu+1AfyJ
 CXTT3X4jexkeg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 03/10] ddr: marvell: a38x: debug: Define
 DDR_VIEWER_TOOL variables only if needed, and make them static
Date: Mon, 15 Apr 2024 18:30:36 +0200
Message-ID: <20240415163043.7482-4-kabel@kernel.org>
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

The variables is_validate_window_per_if, is_validate_window_per_pup,
sweep_cnt and is_run_leveling_sweep_tests are only used if
DDR_VIEWER_TOOL macro is defined, so define them only in that case.

Make them static since they are only used in ddr3_debug.c.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/ddr/marvell/a38x/ddr3_debug.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ddr/marvell/a38x/ddr3_debug.c b/drivers/ddr/marvell/a38x/ddr3_debug.c
index c659ae92d8..d32d42c408 100644
--- a/drivers/ddr/marvell/a38x/ddr3_debug.c
+++ b/drivers/ddr/marvell/a38x/ddr3_debug.c
@@ -114,13 +114,14 @@ u32 ctrl_adll[MAX_CS_NUM * MAX_INTERFACE_NUM * MAX_BUS_NUM];
 u32 ctrl_adll1[MAX_CS_NUM * MAX_INTERFACE_NUM * MAX_BUS_NUM];
 u32 ctrl_level_phase[MAX_CS_NUM * MAX_INTERFACE_NUM * MAX_BUS_NUM];
 #endif /* EXCLUDE_SWITCH_DEBUG */
+
+static u8 is_validate_window_per_if = 0;
+static u8 is_validate_window_per_pup = 0;
+static u8 sweep_cnt = 1;
+static u8 is_run_leveling_sweep_tests;
 #endif /* DDR_VIEWER_TOOL */
 
 struct hws_tip_config_func_db config_func_info[MAX_DEVICE_NUM];
-u8 is_validate_window_per_if = 0;
-u8 is_validate_window_per_pup = 0;
-u8 sweep_cnt = 1;
-u8 is_run_leveling_sweep_tests;
 
 static struct hws_xsb_info xsb_info[MAX_DEVICE_NUM];
 
-- 
2.43.2

