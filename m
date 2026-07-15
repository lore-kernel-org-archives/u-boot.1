Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDDFC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 12:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA9F184AEB;
	Wed, 15 Jul 2026 14:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="G0EkSNkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 296D984A3A; Wed, 15 Jul 2026 14:27:39 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19D6784ABB
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 14:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso95606166b.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784118455; x=1784723255; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CZM1MN7mKMTaJdG69jL2MOoyb+VUfmPW2PvgdyGDqLg=;
 b=G0EkSNkQ4hIej5YGItMCqKFVNiv1dMa1eYV4itACX3NjKz52CpeDoVUBEFB8W8B/td
 IrQtBRWm7BXTG1m25ELgnHN4p28u76gqbjRD4ZDds17o9sVDtuFi9COu+bwIj7NRxdJr
 nyqjszdS1QWb4NgPQtCcfJVyuveWXl4BbRiCrSoAsAn+h3lRQJbNFss5WIvOBC8iuZ8S
 hbe2KlDbSxLo8tQdwRl6ZTwBaJdq8iPz6ULVe/ILg+dc/Ev4GeNSg5tz2uwZLm7Y7ay7
 5J4481ifRorKXJhjAzd1rOUq/P+7MYRIP9kFHXXhpoJl4lkNUzLYldgrfrpTmfN7JCEW
 IIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784118455; x=1784723255;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CZM1MN7mKMTaJdG69jL2MOoyb+VUfmPW2PvgdyGDqLg=;
 b=Kdy+DhTHmhHPaMABS/7XV6u4bMz8uxJuGDEkAH6lfIuKZUhSCFtTdeRj77ko3a+xSi
 Hi+6MgqqCvYJwXO8kfkn1ON22t6B1tIRsH73xdcSyxL2WdaEY5OumTLjSFyLrZt8BUps
 6lELdrPCxyOfxUG9ybEP1cPUvUUlfLzM8OqZyef2XGS5ZNPlRBhtx2IvQeG1GfjG65rR
 PmnoGeNIvhFRddGvxyMkDAAdvemM0VFV7Sq/Sok8O7QomBOBbQ+YtvslFqMpdKtAhYUE
 ohm2cH+PVJZWIUOPeKl2LaFsjpbenl/yucZ7lNz375Me2YIlvmsk4Tc7ndfZ5WIn998z
 3yaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RocK2FupK0VVNnFo53Hy5L0MN7FS/5zwdWRRXFeZWftiese88CtF+LDTPO4wflc6FJoKia8ULs=@lists.denx.de
X-Gm-Message-State: AOJu0YwxLvzA5v+u67eToQp39YOToL6vuXv6DsawgPxzpYu0UWum+Lsq
 Od9Z1gNU8E3Ky/BhmIHPU0RH5/gcByrK7seU6kevgM63FXgM16iTp/OkNzFQmH5P08HoDXB6DWv
 vDi3h
X-Gm-Gg: AfdE7clQgbfjee1ylYGEYxraNgqKAlK049h+0ozo7sUcIcL2/DG25EIYekusw9+9bcg
 4w1k5MC76s1VhA4JNN118k9/5aHWOm85d32UkvUUi8rhJbEnp4F85vkhf7JmiVcSs9DXGzuL7o4
 miNwJxfIldnr0fo5au17f3GT2hmvXj9tL/on+9qvBWKWHXUO/9c9BB7HqP5YwEN3HEobXH5+t1I
 CkDK4FVOh/QooA7Qs2PKcRijCFOjri/MbO5nQNYj9XfjdrwGRtAEGE8gRq6kt/fZXCC3iFXHoXP
 PgN/tIqD4+ieRzy/XYBJdXXsnQnAg1+oqfidEgQP8K8zHwM0v6Fw2zYcjEg1DKb4PH/mJTomY9M
 S0TjNRC0YTbhqlMMZ0tTYLXW4FV/NiJgrIhC5tSmrj2qNVpkR+TmlzVksIp3yx9Qbg94upYJXRb
 Bx+Dk4Po1M7PX9yxzP5RRweMt+zg26XAjv6ee8nTzTa07BnaZsMtf1i9ftCAQd41RnaxE=
X-Received: by 2002:a17:907:7635:b0:c10:10c9:6d8c with SMTP id
 a640c23a62f3a-c15fe7f0172mr846887366b.28.1784118455431; 
 Wed, 15 Jul 2026 05:27:35 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e6ecsm15062266b.44.2026.07.15.05.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:27:35 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 14:27:05 +0200
Subject: [PATCH v2 3/4] clk/qcom: Add newly added GDSC flags to all qcom
 clk drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-gdsc-flags-v2-3-27704470a24c@fairphone.com>
References: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
In-Reply-To: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Ajit Singh <blfizzyy@gmail.com>, Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118453; l=17096;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=FPQI+eVSjoy2Eew1ygG5ruDq/BI29SFDYktNAsebqNQ=;
 b=UsqtobYYkBggci9Bvj0s0x5Zc6jlxoYFOLwEykHaelLcGZsSB3NpRXmSfVZcBsBLdX+mQnuZH
 f5L2PJIi/bOChuzu2c3x3okkY+L4ezsYc4Y7zD81QqEdKP/cqeGndiS
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 14:38:59 +0200
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

From: Alexey Minnekhanov <alexeymin@minlexx.ru>

In the future we will need to specify flags for each GDSC for it to
function properly. Copy flags field from respective Linux GCC driver.

Turns out, even among SDM845 not all GDSCs are the same. Some of GDSCs
do specify the POLL_CFG_GDSCR flag that changes the logic to check the
ON/OFF status, other don't.

Some qcom clock drivers in U-Boot don't specify any GDSCs at all
(apq8016, apq8096, ipq*, qcs404), or GDSCs in their linux GCC driver
do not have any flags (qcs615, qcm2290, sm6115, sm7150, sm8250)
thus making them unaffected by this change.

Add flags to all currently present qcom clock drivers that do need
this change (milos, qcs8300, sa8775p, sc7280, sdm670, sdm845, sm6125,
sm6350, sm8150, sm8550, sm8650, x1e80100).

Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/clock-milos.c    |  6 ++---
 drivers/clk/qcom/clock-qcs8300.c  |  4 +--
 drivers/clk/qcom/clock-sa8775p.c  |  4 +--
 drivers/clk/qcom/clock-sc7280.c   |  8 +++---
 drivers/clk/qcom/clock-sdm845.c   | 42 +++++++++++++++---------------
 drivers/clk/qcom/clock-sm6125.c   |  8 +++---
 drivers/clk/qcom/clock-sm6350.c   |  4 +--
 drivers/clk/qcom/clock-sm8150.c   | 14 +++++-----
 drivers/clk/qcom/clock-sm8550.c   | 16 ++++++------
 drivers/clk/qcom/clock-sm8650.c   | 16 ++++++------
 drivers/clk/qcom/clock-x1e80100.c | 54 +++++++++++++++++++--------------------
 11 files changed, 88 insertions(+), 88 deletions(-)

diff --git a/drivers/clk/qcom/clock-milos.c b/drivers/clk/qcom/clock-milos.c
index 54103adc114..bb2cb19aeb2 100644
--- a/drivers/clk/qcom/clock-milos.c
+++ b/drivers/clk/qcom/clock-milos.c
@@ -130,9 +130,9 @@ static const struct qcom_reset_map milos_gcc_resets[] = {
 };
 
 static const struct qcom_power_map milos_gdscs[] = {
-	[UFS_PHY_GDSC] = { 0x77004 },
-	[UFS_MEM_PHY_GDSC] = { 0x9e000 },
-	[USB30_PRIM_GDSC] = { 0x39004 },
+	[UFS_PHY_GDSC] = { .reg = 0x77004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[UFS_MEM_PHY_GDSC] = { .reg = 0x9e000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[USB30_PRIM_GDSC] = { .reg = 0x39004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
 };
 
 static struct msm_clk_data milos_gcc_data = {
diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
index cd8aecdf788..9cf48fc9d6d 100644
--- a/drivers/clk/qcom/clock-qcs8300.c
+++ b/drivers/clk/qcom/clock-qcs8300.c
@@ -112,8 +112,8 @@ static const struct qcom_reset_map qcs8300_gcc_resets[] = {
 };
 
 static const struct qcom_power_map qcs8300_gdscs[] = {
-	[GCC_UFS_PHY_GDSC] = { 0x83004 },
-	[GCC_USB30_PRIM_GDSC] = { 0x1B004 },
+	[GCC_UFS_PHY_GDSC] = { .reg = 0x83004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
+	[GCC_USB30_PRIM_GDSC] = { .reg = 0x1B004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
 };
 
 static struct msm_clk_data qcs8300_gcc_data = {
diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 7eec4aeae48..3a014c63c0c 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -243,8 +243,8 @@ static const struct qcom_reset_map sa8775p_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sa8775p_gdscs[] = {
-	[UFS_PHY_GDSC] = { 0x83004 },
-	[USB30_PRIM_GDSC] = { 0x1B004 },
+	[UFS_PHY_GDSC] = { .reg = 0x83004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
+	[USB30_PRIM_GDSC] = { .reg = 0x1B004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
 };
 
 static struct msm_clk_data sa8775_gcc_data = {
diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 91e3fcc27cb..9cf665552ba 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -282,10 +282,10 @@ static const struct qcom_reset_map sc7280_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sc7280_gdscs[] = {
-	[GCC_UFS_PHY_GDSC] = { 0x77004 },
-	[GCC_USB30_PRIM_GDSC] = { 0xf004 },
-	[GCC_USB30_SEC_GDSC] = { 0x9e004 },
-	[GCC_PCIE_1_GDSC] = { 0x8d004 },
+	[GCC_UFS_PHY_GDSC] = { .reg = 0x77004, .flags = VOTABLE },
+	[GCC_USB30_PRIM_GDSC] = { .reg = 0xf004, .flags = VOTABLE },
+	[GCC_USB30_SEC_GDSC] = { .reg = 0x9e004, .flags = VOTABLE },
+	[GCC_PCIE_1_GDSC] = { .reg = 0x8d004, .flags = VOTABLE },
 };
 
 static const phys_addr_t sc7280_rcg_addrs[] = {
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index c9a057cf6f9..df37f4bd33f 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -288,30 +288,30 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sdm670_gdscs[] = {
-	[UFS_PHY_GDSC] = { 0x77004 },
-	[USB30_PRIM_GDSC] = { 0xf004 },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { 0x7d030 },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { 0x7d034 },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { 0x7d038 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
+	[UFS_PHY_GDSC] = { .reg = 0x77004, .flags = POLL_CFG_GDSCR },
+	[USB30_PRIM_GDSC] = { .reg = 0xf004, .flags = POLL_CFG_GDSCR },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { .reg = 0x7d030, .flags = VOTABLE },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { .reg = 0x7d034, .flags = VOTABLE },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { .reg = 0x7d038, .flags = VOTABLE },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { .reg = 0x7d040, .flags = VOTABLE },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { .reg = 0x7d048, .flags = VOTABLE },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { .reg = 0x7d044, .flags = VOTABLE },
 };
 
 static const struct qcom_power_map sdm845_gdscs[] = {
-	[PCIE_0_GDSC] = { 0x6b004 },
-	[PCIE_1_GDSC] = { 0x8d004 },
-	[UFS_CARD_GDSC] = { 0x75004 },
-	[UFS_PHY_GDSC] = { 0x77004 },
-	[USB30_PRIM_GDSC] = { 0xf004 },
-	[USB30_SEC_GDSC] = { 0x10004 },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { 0x7d030 },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC] = { 0x7d03c },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { 0x7d034 },
-	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { 0x7d038 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
+	[PCIE_0_GDSC] = { .reg = 0x6b004, .flags = POLL_CFG_GDSCR },
+	[PCIE_1_GDSC] = { .reg = 0x8d004, .flags = POLL_CFG_GDSCR },
+	[UFS_CARD_GDSC] = {.reg = 0x75004, .flags = POLL_CFG_GDSCR },
+	[UFS_PHY_GDSC] = { .reg = 0x77004, .flags = POLL_CFG_GDSCR },
+	[USB30_PRIM_GDSC] = { .reg = 0xf004, .flags = POLL_CFG_GDSCR },
+	[USB30_SEC_GDSC] = { .reg = 0x10004, .flags = POLL_CFG_GDSCR },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { .reg = 0x7d030, .flags = VOTABLE },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC] = { .reg = 0x7d03c, .flags = VOTABLE },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { .reg = 0x7d034, .flags = VOTABLE },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { .reg = 0x7d038, .flags = VOTABLE },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { .reg = 0x7d040, .flags = VOTABLE },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { .reg = 0x7d048, .flags = VOTABLE },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { .reg = 0x7d044, .flags = VOTABLE },
 };
 
 static const phys_addr_t sdm845_gpll_addrs[] = {
diff --git a/drivers/clk/qcom/clock-sm6125.c b/drivers/clk/qcom/clock-sm6125.c
index 1fd72d55e88..6189c5070e9 100644
--- a/drivers/clk/qcom/clock-sm6125.c
+++ b/drivers/clk/qcom/clock-sm6125.c
@@ -176,10 +176,10 @@ static const struct qcom_power_map sm6125_gdscs[] = {
 	[CAMSS_VFE1_GDSC] = { 0x5403c },
 	[CAMSS_TOP_GDSC] = { 0x5607c },
 	[CAM_CPP_GDSC] = { 0x560bc },
-	[HLOS1_VOTE_TURING_MMU_TBU1_GDSC] = { 0x7d060 },
-	[HLOS1_VOTE_MM_SNOC_MMU_TBU_RT_GDSC] = { 0x80074 },
-	[HLOS1_VOTE_MM_SNOC_MMU_TBU_NRT_GDSC] = { 0x80084 },
-	[HLOS1_VOTE_TURING_MMU_TBU0_GDSC] = { 0x80094 },
+	[HLOS1_VOTE_TURING_MMU_TBU1_GDSC] = { .reg = 0x7d060, .flags = VOTABLE },
+	[HLOS1_VOTE_MM_SNOC_MMU_TBU_RT_GDSC] = { .reg = 0x80074, .flags = VOTABLE },
+	[HLOS1_VOTE_MM_SNOC_MMU_TBU_NRT_GDSC] = { .reg = 0x80084, .flags = VOTABLE },
+	[HLOS1_VOTE_TURING_MMU_TBU0_GDSC] = { .reg = 0x80094, .flags = VOTABLE },
 };
 
 static const phys_addr_t sm6125_gpll_addrs[] = {
diff --git a/drivers/clk/qcom/clock-sm6350.c b/drivers/clk/qcom/clock-sm6350.c
index ee6653848c7..aa92359fa49 100644
--- a/drivers/clk/qcom/clock-sm6350.c
+++ b/drivers/clk/qcom/clock-sm6350.c
@@ -160,8 +160,8 @@ static const struct qcom_reset_map sm6350_gcc_resets[] = {
 static const struct qcom_power_map sm6350_gdscs[] = {
 	[USB30_PRIM_GDSC] = { 0x1a004 },
 	[UFS_PHY_GDSC] = { 0x3a004 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0xb7040 },
-	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0xb7044 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { .reg = 0xb7040, .flags = VOTABLE },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { .reg = 0xb7044, .flags = VOTABLE },
 };
 
 static struct msm_clk_data sm6350_gcc_data = {
diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm8150.c
index 7dd0d56eb43..5667396ab01 100644
--- a/drivers/clk/qcom/clock-sm8150.c
+++ b/drivers/clk/qcom/clock-sm8150.c
@@ -279,13 +279,13 @@ static const struct qcom_reset_map sm8150_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sm8150_gcc_power_domains[] = {
-	[EMAC_GDSC] = { 0x6004 },
-	[PCIE_0_GDSC] = { 0x6b004 },
-	[PCIE_1_GDSC] = { 0x8d004 },
-	[UFS_CARD_GDSC] = { 0x75004 },
-	[UFS_PHY_GDSC] = { 0x77004 },
-	[USB30_PRIM_GDSC] = { 0xf004 },
-	[USB30_SEC_GDSC] = { 0x10004 },
+	[EMAC_GDSC] = { .reg = 0x6004, .flags = POLL_CFG_GDSCR },
+	[PCIE_0_GDSC] = { .reg = 0x6b004, .flags = POLL_CFG_GDSCR },
+	[PCIE_1_GDSC] = { .reg = 0x8d004, .flags = POLL_CFG_GDSCR },
+	[UFS_CARD_GDSC] = { .reg = 0x75004, .flags = POLL_CFG_GDSCR },
+	[UFS_PHY_GDSC] = { .reg = 0x77004, .flags = POLL_CFG_GDSCR },
+	[USB30_PRIM_GDSC] = { .reg = 0xf004, .flags = POLL_CFG_GDSCR },
+	[USB30_SEC_GDSC] = { .reg = 0x10004, .flags = POLL_CFG_GDSCR },
 };
 
 static struct msm_clk_data sm8150_clk_data = {
diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
index 7c06489b9c4..cf96f1c631f 100644
--- a/drivers/clk/qcom/clock-sm8550.c
+++ b/drivers/clk/qcom/clock-sm8550.c
@@ -263,14 +263,14 @@ static const struct qcom_reset_map sm8550_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sm8550_gdscs[] = {
-	[PCIE_0_GDSC] = { 0x6b004 },
-	[PCIE_0_PHY_GDSC] = { 0x6c000 },
-	[PCIE_1_GDSC] = { 0x8d004 },
-	[PCIE_1_PHY_GDSC] = { 0x8e000 },
-	[UFS_PHY_GDSC] = { 0x77004 },
-	[UFS_MEM_PHY_GDSC] = { 0x9e000 },
-	[USB30_PRIM_GDSC] = { 0x39004 },
-	[USB3_PHY_GDSC] = { 0x50018 },
+	[PCIE_0_GDSC] = { .reg = 0x6b004, .flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[PCIE_0_PHY_GDSC] = { .reg = 0x6c000, .flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[PCIE_1_GDSC] = { .reg = 0x8d004, .flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[PCIE_1_PHY_GDSC] = { .reg = 0x8e000, .flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[UFS_PHY_GDSC] = { .reg = 0x77004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[UFS_MEM_PHY_GDSC] = { .reg = 0x9e000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[USB30_PRIM_GDSC] = { .reg = 0x39004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[USB3_PHY_GDSC] = { .reg = 0x50018, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
 };
 
 static struct msm_clk_data sm8550_gcc_data = {
diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/clock-sm8650.c
index 7c49e99c005..dfe7bc6ce90 100644
--- a/drivers/clk/qcom/clock-sm8650.c
+++ b/drivers/clk/qcom/clock-sm8650.c
@@ -261,14 +261,14 @@ static const struct qcom_reset_map sm8650_gcc_resets[] = {
 };
 
 static const struct qcom_power_map sm8650_gdscs[] = {
-	[PCIE_0_GDSC] = { 0x6b004 },
-	[PCIE_0_PHY_GDSC] = { 0x6c000 },
-	[PCIE_1_GDSC] = { 0x8d004 },
-	[PCIE_1_PHY_GDSC] = { 0x8e000 },
-	[UFS_PHY_GDSC] = { 0x77004 },
-	[UFS_MEM_PHY_GDSC] = { 0x9e000 },
-	[USB30_PRIM_GDSC] = { 0x39004 },
-	[USB3_PHY_GDSC] = { 0x50018 },
+	[PCIE_0_GDSC] = { .reg = 0x6b004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[PCIE_0_PHY_GDSC] = { .reg = 0x6c000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[PCIE_1_GDSC] = { .reg = 0x8d004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[PCIE_1_PHY_GDSC] = { .reg = 0x8e000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[UFS_PHY_GDSC] = { .reg = 0x77004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[UFS_MEM_PHY_GDSC] = { .reg = 0x9e000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[USB30_PRIM_GDSC] = { .reg = 0x39004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[USB3_PHY_GDSC] = { .reg = 0x50018, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
 };
 
 static struct msm_clk_data sm8650_gcc_data = {
diff --git a/drivers/clk/qcom/clock-x1e80100.c b/drivers/clk/qcom/clock-x1e80100.c
index 542d6248d65..bed3b2b8f2c 100644
--- a/drivers/clk/qcom/clock-x1e80100.c
+++ b/drivers/clk/qcom/clock-x1e80100.c
@@ -269,33 +269,33 @@ static const struct qcom_reset_map x1e80100_gcc_resets[] = {
 };
 
 static const struct qcom_power_map x1e80100_gdscs[] = {
-	[GCC_PCIE_0_TUNNEL_GDSC] = { 0xa0004 },
-	[GCC_PCIE_1_TUNNEL_GDSC] = { 0x2c004 },
-	[GCC_PCIE_2_TUNNEL_GDSC] = { 0x13004 },
-	[GCC_PCIE_3_GDSC] = { 0x58004 },
-	[GCC_PCIE_3_PHY_GDSC] = { 0x3e000 },
-	[GCC_PCIE_4_GDSC] = { 0x6b004 },
-	[GCC_PCIE_4_PHY_GDSC] = { 0x6c000 },
-	[GCC_PCIE_5_GDSC] = { 0x2f004 },
-	[GCC_PCIE_5_PHY_GDSC] = { 0x30000 },
-	[GCC_PCIE_6_PHY_GDSC] = { 0x8e000 },
-	[GCC_PCIE_6A_GDSC] = { 0x31004 },
-	[GCC_PCIE_6B_GDSC] = { 0x8d004 },
-	[GCC_UFS_MEM_PHY_GDSC] = { 0x9e000 },
-	[GCC_UFS_PHY_GDSC] = { 0x77004 },
-	[GCC_USB20_PRIM_GDSC] = { 0x29004 },
-	[GCC_USB30_MP_GDSC] = { 0x17004 },
-	[GCC_USB30_PRIM_GDSC] = { 0x39004 },
-	[GCC_USB30_SEC_GDSC] = { 0xa1004 },
-	[GCC_USB30_TERT_GDSC] = { 0xa2004 },
-	[GCC_USB3_MP_SS0_PHY_GDSC] = { 0x1900c },
-	[GCC_USB3_MP_SS1_PHY_GDSC] = { 0x5400c },
-	[GCC_USB4_0_GDSC] = { 0x9f004 },
-	[GCC_USB4_1_GDSC] = { 0x2b004 },
-	[GCC_USB4_2_GDSC] = { 0x11004 },
-	[GCC_USB_0_PHY_GDSC] = { 0x50024 },
-	[GCC_USB_1_PHY_GDSC] = { 0x2a024 },
-	[GCC_USB_2_PHY_GDSC] = { 0xa3024 },
+	[GCC_PCIE_0_TUNNEL_GDSC] = { .reg = 0xa0004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_1_TUNNEL_GDSC] = { .reg = 0x2c004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_2_TUNNEL_GDSC] = { .reg = 0x13004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_3_GDSC] = { .reg = 0x58004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_3_PHY_GDSC] = { .reg = 0x3e000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_4_GDSC] = { .reg = 0x6b004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_4_PHY_GDSC] = { .reg = 0x6c000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_5_GDSC] = { .reg = 0x2f004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_5_PHY_GDSC] = { .reg = 0x30000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_6_PHY_GDSC] = { .reg = 0x8e000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_6A_GDSC] = { .reg = 0x31004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_PCIE_6B_GDSC] = { .reg = 0x8d004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE },
+	[GCC_UFS_MEM_PHY_GDSC] = { .reg = 0x9e000, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_UFS_PHY_GDSC] = { .reg = 0x77004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB20_PRIM_GDSC] = { .reg = 0x29004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB30_MP_GDSC] = { .reg = 0x17004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB30_PRIM_GDSC] = { .reg = 0x39004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB30_SEC_GDSC] = { .reg = 0xa1004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB30_TERT_GDSC] = { .reg = 0xa2004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB3_MP_SS0_PHY_GDSC] = { .reg = 0x1900c, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB3_MP_SS1_PHY_GDSC] = { .reg = 0x5400c, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB4_0_GDSC] = { .reg = 0x9f004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB4_1_GDSC] = { .reg = 0x2b004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB4_2_GDSC] = { .reg = 0x11004, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB_0_PHY_GDSC] = { .reg = 0x50024, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB_1_PHY_GDSC] = { .reg = 0x2a024, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
+	[GCC_USB_2_PHY_GDSC] = { .reg = 0xa3024, .flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE },
 };
 
 static struct msm_clk_data x1e80100_gcc_data = {

-- 
2.55.0

