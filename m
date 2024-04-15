Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC47C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 16:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF21880F8;
	Mon, 15 Apr 2024 18:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WytM1Ojl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E208802E; Mon, 15 Apr 2024 18:30:54 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E394C87A0E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 18:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4B480CE0E63;
 Mon, 15 Apr 2024 16:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFCCC113CC;
 Mon, 15 Apr 2024 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713198650;
 bh=1rHiTuU6Oz8Ihm0YBx6HeiX/iFKsPhVkwb5nyg3qoh4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WytM1OjlZGHyLw5q7RxhYS/lTFEEfA7f8+bXwovfttPv4vcGn9sdLoL44t2PDpv6M
 iGfj2nreEItijUGaI0V9KxFfCY2WI4OrtLV8Sw+xaLnQhsbsBcrF2oWW9AISWQpkQX
 jiX27TzH/e0CFxUo+fUPvXOJrZPZcrlR48J626SSZZEPFu5NsVwMkvl7VvWOhJHljg
 1A2CuTI8EKNUHaWd9uSL3BjQWsTHXBosgt95xdfAaM4S0CT2My0uQ/Kz896oYMCbNU
 CuALABaWnpqBPUmRknYmoM02DN3wokIQoGpfHRFsyjm7YAAIN2F+KP+7pOcHGWOAqg
 1dnP6DnWn1xAQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 02/10] ddr: marvell: a38x: debug: Remove unused
 variables
Date: Mon, 15 Apr 2024 18:30:35 +0200
Message-ID: <20240415163043.7482-3-kabel@kernel.org>
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

The variables is_default_centralization, is_tune_result and
is_bist_reset_bit are never used.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/ddr/marvell/a38x/ddr3_debug.c | 3 ---
 drivers/ddr/marvell/a38x/ddr3_init.h  | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/ddr/marvell/a38x/ddr3_debug.c b/drivers/ddr/marvell/a38x/ddr3_debug.c
index 0374a84387..c659ae92d8 100644
--- a/drivers/ddr/marvell/a38x/ddr3_debug.c
+++ b/drivers/ddr/marvell/a38x/ddr3_debug.c
@@ -117,12 +117,9 @@ u32 ctrl_level_phase[MAX_CS_NUM * MAX_INTERFACE_NUM * MAX_BUS_NUM];
 #endif /* DDR_VIEWER_TOOL */
 
 struct hws_tip_config_func_db config_func_info[MAX_DEVICE_NUM];
-u8 is_default_centralization = 0;
-u8 is_tune_result = 0;
 u8 is_validate_window_per_if = 0;
 u8 is_validate_window_per_pup = 0;
 u8 sweep_cnt = 1;
-u32 is_bist_reset_bit = 1;
 u8 is_run_leveling_sweep_tests;
 
 static struct hws_xsb_info xsb_info[MAX_DEVICE_NUM];
diff --git a/drivers/ddr/marvell/a38x/ddr3_init.h b/drivers/ddr/marvell/a38x/ddr3_init.h
index 6854bb49de..9288073a78 100644
--- a/drivers/ddr/marvell/a38x/ddr3_init.h
+++ b/drivers/ddr/marvell/a38x/ddr3_init.h
@@ -116,7 +116,6 @@ extern u32 clamp_tbl[];
 extern u32 freq_mask[MAX_DEVICE_NUM][MV_DDR_FREQ_LAST];
 
 extern u32 maxt_poll_tries;
-extern u32 is_bist_reset_bit;
 
 extern u8 vref_window_size[MAX_INTERFACE_NUM][MAX_BUS_NUM];
 extern u32 effective_cs;
-- 
2.43.2

