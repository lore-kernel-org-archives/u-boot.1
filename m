Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DBDC83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 14:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C6A82E26;
	Mon, 28 Jul 2025 16:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T5cQhsUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FE9482E52; Mon, 28 Jul 2025 16:26:49 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3407B82CBB
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a528243636so2699001f8f.3
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753712796; x=1754317596; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2dOJXrzVJRcRsAPo/E1pCAJmnrruqwYsH3qGTCuPOUs=;
 b=T5cQhsUhWPVdfvrVRCgjKD09Y3m77WA3GtU7Z1VmK/w6SjOW06+/ydN/opXjs3uxgH
 aDqZypv1UwqX8Z8xgX8LTdhzR8jqfZ3DMZU41foajTznUa8lDerFkO4uCZK/yu+WH6Yw
 H9A8VXeZOKGPgISOEjB0TCV05LyWF8rVe1bYuf8y3s/LQQTKrUmWbeFi6sZ5sPPI4YzA
 Ch1L8OCEIHvHkboENCjGcnIv/w1p+Ph99OahQwIkJVZa/+keg9FLyOkgk49eID9aKZY6
 NNMMcEogkkMS5nFb9mbZP9FuiSW+/0DAMtdtPfS0Vfshj9cWM34eosZU4/hdDcvksGRV
 +6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753712796; x=1754317596;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2dOJXrzVJRcRsAPo/E1pCAJmnrruqwYsH3qGTCuPOUs=;
 b=g//CvPNIGswwBZ9i3weYYDDJ9rRyayo760VecCDzJ6L+sy2wnIYoJdHm8RxTyljOpr
 96g+XkBbnedIx+VQHoX2I5ZdpAzkFJFhswPnsv403MlLQnCNNfUD16VA99gbJLQylEcA
 wyWSA2pb9e5E8Swh5V5RBaB20LFiioxCgqNjuQpzQrjoVIv42PjHF20yQjEhRNwjFsAU
 qLGYwbhiqlw0iY8Jr3xX9sKUEIamhwZJAThYeJkSV9HYOYGD0kmTj7ZYwbbfVqE4v0PV
 Ab81vgIqFZqreszPLt+iIMMs3c+y1PAsuQ+8gmyeVTDgDtDatN7yHiQy4WYHFgll8k1H
 dG7w==
X-Gm-Message-State: AOJu0Yy5h1c50vfAhEd4i3xeCx+yj6VYUzo7aK3wE+SgSzn9yXOs9v9w
 S/luzqAXKzTiQr8fZTVgeyJA4tcDoJyr4pOrCmhUf5UKw/mIpV1vf5d6wOKkpDXF1f3SETi7Xbw
 +p9jt
X-Gm-Gg: ASbGncvtC51TzmSDQ/XyyZ0WFR7dUCX7oTZFzrgmoc2S7/5uHk8GJcnIKtFIKo+1EJN
 I93TdBIJi3bcjFrCDtPZRiRNnrHtxmy6abUU4z14HA2hnD5ypXS+C1Az9D5CX8zEdBJ0yTffUhG
 6X+kqgRn1CcOK1UJOnwoWfHK8n2RI5Ux/N8RYfLbd/w7mQMRNZvZGY2YbGTGNJQJHwVj9JCQZtM
 xPcjT3DV0LnZf+8liATXVMIAIiHK7JtLQFX8OUwaq/bUGYyh042wEdP+8sDDgeAsI2HlKdvhOA1
 rrKka8gNhp6hXdMJpWNT/Ce22vmaLq+FInVtFKpOcIf9a0mS3yG3Vm2HHRCSe/IqrcseaVCglEm
 RstdhzmKBVQeUmu+niq/bRSxg8AnNLuM53ZXZWFSBcX4zNCH2gA==
X-Google-Smtp-Source: AGHT+IHzjp/Gcr6uF6tO0uwUrpd1GDTL1q1dLjnHdHWaIIzGYpJ9YS+FZa2Bs4vH72LeXJePjcWDRg==
X-Received: by 2002:a05:6000:1a8c:b0:3a4:f663:acb9 with SMTP id
 ffacd0b85a97d-3b7765e59b3mr8559018f8f.9.1753712795666; 
 Mon, 28 Jul 2025 07:26:35 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b77db8a944sm7791914f8f.52.2025.07.28.07.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 07:26:35 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 28 Jul 2025 15:26:34 +0100
Subject: [PATCH] ddr: marvell: a38x: Fix unsigned issues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-a38x_ddr-v1-1-4102aa87697c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJmIh2gC/x2NQQqEMAxFryJZT8GpWotXGQaJbdQs7EgigyDe3
 ery8d/nHaAkTApdcYDQn5V/KcP7VUCYMU1kOGYGW9qmbK03WPm9j1GMq4Nro0dXoYWsD6hkBsE
 U5vuwoG4k97AKjbw/jc/3PC/JAnwKcwAAAA==
To: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Cannot test an unsigned variable to be less than 0, it will always fail.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c b/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
index 31b6209416b..84156a1e8ad 100644
--- a/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
+++ b/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
@@ -64,7 +64,7 @@ static u8 center_high_element_get(u8 dir, u8 pbs_element, u16 lambda, u8 pbs_max
 static int mv_ddr4_centralization(u8 dev_num, u16 (*lambda)[MAX_BUS_NUM][BUS_WIDTH_IN_BITS], u8 (*copt)[MAX_BUS_NUM],
 				  u8 (*pbs_result)[MAX_BUS_NUM][BUS_WIDTH_IN_BITS], u8 (*vw_size)[MAX_BUS_NUM],
 				  u8 mode, u16 param0, u8 param1);
-static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8 *pbs_result, char delta, u8 *copt, u8 *dqs_pbs);
+static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8 *pbs_result, s8 delta, u8 *copt, u8 *dqs_pbs);
 static int mv_ddr4_copt_get(u8 dir, u16 *lambda, u8 *vw_l, u8 *vw_h, u8 *pbs_result, u8 *copt);
 static int mv_ddr4_center_of_mass_calc(u8 dev_num, u8 if_id, u8 subphy_num, u8 mode, u8 *vw_l, u8 *vw_h, u8 *vw_v,
 				       u8 vw_num, u8 *v_opt, u8 *t_opt);
@@ -659,7 +659,7 @@ static int mv_ddr4_centralization(u8 dev_num, u16 (*lambda)[MAX_BUS_NUM][BUS_WID
 	} /* if_id */
 
 	/* restore cs enable value*/
-	for (if_id = 0; if_id < MAX_INTERFACE_NUM - 1; if_id++) {
+	for (if_id = 0; if_id < MAX_INTERFACE_NUM; if_id++) {
 		VALIDATE_IF_ACTIVE(tm->if_act_mask, if_id);
 		status = ddr3_tip_if_write(dev_num, ACCESS_TYPE_UNICAST, if_id, DUAL_DUNIT_CFG_REG,
 					   cs_ena_reg_val[if_id], MASK_ALL_BITS);
@@ -895,7 +895,7 @@ static int mv_ddr4_copt_get(u8 dir, u16 *lambda, u8 *vw_l, u8 *vw_h, u8 *pbs_res
  * It provides with a solution for a single subphy (8 bits).
  * The calling function is responsible for any additional pbs taps for dqs
  */
-static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8 *pbs_result, char delta, u8 *copt, u8 *dqs_pbs)
+static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8 *pbs_result, s8 delta, u8 *copt, u8 *dqs_pbs)
 {
 	u8 dq_idx;
 	u32 pbs_max_val = 0;
@@ -952,7 +952,8 @@ static int mv_ddr4_center_of_mass_calc(u8 dev_num, u8 if_id, u8 subphy_num, u8 m
 	int t_opt_temp = 0, v_opt_temp = 0;
 	int vw_avg = 0, v_avg = 0;
 	int s0 = 0, s1 = 0, s2 = 0, slope = 1, r_sq = 0;
-	u32 d_min = 10000, reg_val = 0;
+	u32 reg_val = 0;
+	int d_min = 10000;
 	int status;
 
 	/*
@@ -2189,7 +2190,7 @@ int mv_ddr4_dm_tuning(u32 cs, u16 (*pbs_tap_factor)[MAX_BUS_NUM][BUS_WIDTH_IN_BI
 				for (dq = 0; dq < BUS_WIDTH_IN_BITS; dq++) {
 					idx = dq + subphy * BUS_WIDTH_IN_BITS;
 					reg_val = new_dq_pbs[dq] - dq_pbs_diff;
-					if (reg_val < 0) {
+					if (new_dq_pbs[dq] < dq_pbs_diff) {
 						DEBUG_DM_TUNING(DEBUG_LEVEL_ERROR,
 								("unexpected negative value found\n"));
 						return MV_FAIL;
@@ -2267,7 +2268,7 @@ int mv_ddr4_dm_tuning(u32 cs, u16 (*pbs_tap_factor)[MAX_BUS_NUM][BUS_WIDTH_IN_BI
 						idx = dq + subphy * BUS_WIDTH_IN_BITS;
 						pad = dq_map_table[idx];
 						reg_val = new_dq_pbs[dq] - dq_pbs_diff;
-						if (reg_val < 0) {
+						if (new_dq_pbs[dq] < dq_pbs_diff) {
 							DEBUG_DM_TUNING(DEBUG_LEVEL_ERROR,
 									("unexpected negative value found\n"));
 							return MV_FAIL;

---
base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
change-id: 20250728-a38x_ddr-64c67d8a63a2

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

