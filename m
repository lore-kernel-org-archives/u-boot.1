Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97E3C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC0188415;
	Tue, 18 Jun 2024 17:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fvpaJnoi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86166883A8; Tue, 18 Jun 2024 17:34:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B51B88354
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4B70C617DF;
 Tue, 18 Jun 2024 15:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F3BC4AF1C;
 Tue, 18 Jun 2024 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724889;
 bh=Loks44TuMatVwM0xSmgQ+VzkAwUMu+itOqdL+NR+4Ec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fvpaJnoi3NQSJ1Sg+4j3FOw3vO92s+gYW2gJjwUNkdyiDA9wtUuLXR61EgqrPg4t4
 puKjoShAd0s5xpBMMocJDuMGz0OqsbOpCgy65WRD6c5L6Ayi+xP91g21tQPiHsn2l8
 uYuqZKqMvBoF0lPHPU9SxwNShRBN0lmX+ejlt6NugJKm8pCvJgDLDXf9dsJ8z3sSmJ
 Zt9fj/OxouyRD0mXRL7l9CA2j7GchOoatKwnjODEAFlDpaoto1LPPxngjGTd2b7lwV
 kyL7N+vzQbLK0vxY8UazAcdXGVImTq8Z6c83DN5eh/+LDZ6VakZfQCJlelSQXz4OcK
 apuxdK6B21gqg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 04/16] ddr: marvell: a38x: debug: Define
 DDR_VIEWER_TOOL variables only if needed, and make them static
Date: Tue, 18 Jun 2024 17:34:27 +0200
Message-ID: <20240618153439.9518-5-kabel@kernel.org>
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
2.44.2

