Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2B9C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DF5180D09;
	Thu, 27 Aug 2026 07:34:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pEVpPV0Qd1wl; Thu, 27 Aug 2026 07:34:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816040;
	bh=g8VrOTwWfJom6mhYuASS1Et1arU+xy/fHbEjXxn0eyI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GNvADDP7Ad2pdZr1TZnzTJ+KSCKo8DUP8hypZlT3G6x/LM+CSZjHDsSwAJjzyMfHW
	 e/fGYRPT41gNGShebIe8UAvEd1jXORRkqjE5nHq3MSBV02OIPpqDn0SUGEaVmkR6c7
	 LCOjRBkgvB1wuILL2bHaASuELqhRRArWRbomdxkzPhTEs2wnKMGsOyzqAOxE4BZCVk
	 7YOwsh1ru72X69FSowzAgsT6TepttvM5G5gS24WwYxCME4LSqm4zAwBWm/nHHLh1yM
	 FNDo9kMSc0wXM0riK7B6hMzyC6Vkb/E2RM6pURmDMEOCv8DDvrMftkxKoIDIXmCSv1
	 Pf+eGim0mZg7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA43780D1C;
	Thu, 27 Aug 2026 07:34:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FB4A3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EDE480D1C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FHXu3-_0kwI6 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:33:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=WaqsXOKG; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=S32dr9IL
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C991E80D09
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:57 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R9OI3257853
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=g8VrOTwWfJo
 m6mhYuASS1Et1arU+xy/fHbEjXxn0eyI=; b=WaqsXOKGf+rZsvgoMfPjKgX3VUh
 /zov8uMHr22d/5yKi3yAhjkVuqTjq7ZUzDlQIy+KDfqB7Yvi8uMFy0P0SyGW86zs
 Z3mZHBbfOtdZ5CsEiXDSppVIJLsO9vUSyJsQQaH+0MZpiFZKiZEhyA3/HdsoU1RV
 mtuOX9+M9yJMmCyjAejQrjvlX3pFBdFckSzwzRJpaxZ5n57jQRRX/Kjb2S3Nh/un
 dIOP8xSFQdz/asxTALBltdNJbwEHMzWGsHIdLXqHiu3WTTj8+BR9NEkmoxUJ52UG
 4wpMkxCgEeA75cdTbP1IWuRNEF1/RcOPCu5jg7i4KUF1GK9K1pCNYkNqBkQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ecajpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso3075581a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787816036; x=1788420836;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g8VrOTwWfJom6mhYuASS1Et1arU+xy/fHbEjXxn0eyI=;
 b=S32dr9IL06AmKx8siwnz0dLuDzGnJLTxkiCN5v4HAI6CT40/oYH8s+FSPu3jbjrJjK
 l/fw2g7WoL0H/hyISRTSYXTQI8R8Srlqz+ddd1lWezuBA8rWOZ4Xo3XKLG22ed09CAd9
 ft/4tMJqsCnumNo/odvf7gxoCOGO+kzS323FgJTKxi7Nug1YfFs2H9qOqAew5PgNVf/P
 m2v5Rq5m+Ba19SKbL0aLT0Ai5nrV8N0kraDDiD/TlAIRUtb5+fuzI2BFv/spoRgLIL6V
 8KFetrbwk8J1nieNGy5ct9gPX2741r9Zss7VX1MtHHxb56gD2sEChKrZQQJXB0AEB0c3
 nhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816036; x=1788420836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=g8VrOTwWfJom6mhYuASS1Et1arU+xy/fHbEjXxn0eyI=;
 b=QCj3oLQ/2YcxlavV5N4eJOOc9lcNacNNBKC+GzYxueabD1RweKE0B2Qxz3kaBffxJ5
 7i8BG4wISPgXorufZ/oq62snT3vFmA+GJLbq+htZHwhj5cIEiqMHNkd0vCWUxB31SgF3
 Z1JUSycb8LroMINmeurCWULcLEYkIiCXiBXsiDf+hc7xE7eSAUVvU9IHbCz7n17/4noK
 ZtayE9N1qPKSB0QZKuirznwfcPCFmrUjDa6lu24PdOLQxlpHhvx14hY7CvE1+wVr6SR2
 5x5rgVkTLCifCkYUOTHPJJSHK5e5VjMIMi5R2ty9ahZHxd6bQ7/z7FvjaVVnAeCnyMm+
 e0rQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQAnpM9p1ap2x66tOvvdRfyadvbzdND5gnjVH3m+bPnD38d7LE83/kfkHpiwx7bM4KR4D2yC8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kCo0+7Vf+ftGmP8GQv+attp0669OAp8ywrGyrP4MNfufQwBc7L
 7lWakgekf+81WDC+9ihOmFWLujmHtNm9ATt+fBk99A3mQDtC/kJtHDSbYUqG4cR3a3/2Z+hGyZW
 iMP2g0/z6lr7pChC7JIrzFL14X0Xv6IIkfF3/FYTzYC/vMK+hiXTEEUO5yR5rPTfqur/ARmA=
X-Gm-Gg: AR+sD108GvIjpOPwBWjEPF1rNldTpxry/GUQH0CsLwk1fdHCPcPSos2aMOrRo+HAF4q
 I8LdppGbeTWFJz/0bU/CldugTI5euLfmsdNVCeN2k8dhXfq7rXnmLraHm0AeoNvAGtTdXh9/Vl8
 YtcXoDbJAMPAALlbZLuWCxsHihUj4AlNrJ/cfF+b+PIl5zbKb2U3miEMITjhhhBufxxP+DQZv4W
 U/1kLvQKTFlaUnMZTz9rGvjMYDUCCpHNjnOaax2QeMXU6GgWgpym3Iozxp+ZiTjBeD1EeWov9cq
 R9a5NYZFFkNL3LuIuTpdZIV0yevSeFlqCqU1MlEJewtoESDskTKAlkS5L5RkSjm4PyhUGn3s7Z/
 Jq4WgUK7VlXTdGcp+XJA2X0mzfRsrkOjJ4PIq52XPipKAgoxyO/4Mj/y1myu7i24c5M7QF2hx5Q
 H9g0XjBGiQ8UVV1/558No=
X-Received: by 2002:a17:90b:3848:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-3966d178358mr25082754a91.3.1787816035336; 
 Thu, 27 Aug 2026 00:33:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3848:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-3966d178358mr25082602a91.3.1787816034698; 
 Thu, 27 Aug 2026 00:33:54 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d8dc465sm15146713eec.24.2026.08.27.00.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:33:54 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 2/3] mmc: msm_sdhci: add HS200/HS400 support
Date: Thu, 27 Aug 2026 13:03:24 +0530
Message-Id: <20260827073325.4113071-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com>
References: <20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8fe864 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=FzCUeY47Uhv9KLmMyuoA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: x4WvfKFvkXAKdg2DmK3VocNzBi3D_1xB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfXwzY2uYjjBf6C
 IoJLvb1N6Yuvpu/2SgXZBXxrnAg1qfqSKo6wvcjE/1SD2u0ulku/Mjis12xLmi/W6Rm39qMnaoU
 TTmiLugQ2miP+cmfYLjSD5LgvkXOGhSVIojmJO3HD6oinSKzJlsi/LCPb3TxQ3HX/GUhoysDjek
 9WGIBmYWU1Qt9G1QKQBbYN4I+k7uIQoebxjEHxKWPmj6zLz+oDEf653eWitJOB8m+w048cazNoZ
 Kxbl3qYaGKe0PFVJynErdAQgBu2nRRfatCRxcwOgBHnROWrsEP3u5V0rI+8QtaI/aBh177yKSP8
 N65WSTqTH2e4lig0YmtfrckcYNpGZ9olT3GM0ud5GlNOGJFRCI8UTmCHL75xzi06Bsyh2wZdtIu
 YZEFlDBW9uROlZcC5Gxx2kzZkty6D9hTs5rZyMwUk7zJIe5OYRfAJxpeWSXCye0vhwDdK+FI7rl
 Sfi8muaBk5Fvc/TYnvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX2ZHEYDa7Oytt
 VBKNtp8v1Hkza0Zjw2fomTgWrbhifC4FBColBqJnxFmyERr8xS8HX52df0gjPfWWK1DVlaiyO6K
 eWK5bN63iQOaPWG7ebAUK2UarZBAWXQ=
X-Proofpoint-GUID: x4WvfKFvkXAKdg2DmK3VocNzBi3D_1xB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270061
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The Qualcomm SDHCI driver lacked DLL init/calibration and tuning
support, so it never negotiated above high-speed/DDR52. Add the
CM_DLL init/phase-tuning sequence for HS200 and the SDC4 DLL
calibration for HS400, matching the SDCC core generation variants
already distinguished in this driver (core_minor-gated 14LPP/
Tassadar DLL reset paths).

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 855 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 854 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index cbf565be426..8525d5d7534 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -16,6 +16,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <power/regulator.h>
+#include <memalign.h>
 
 /* Non-standard registers needed for SDHCI startup */
 #define SDCC_MCI_POWER   0x0
@@ -38,6 +39,52 @@
 #define CORE_DLL_PDN		BIT(29)
 #define CORE_DLL_RST		BIT(30)
 
+/* DLL configuration */
+#define CORE_DLL_EN		BIT(16)
+#define CORE_CDR_EN		BIT(17)
+#define CORE_CK_OUT_EN		BIT(18)
+#define CORE_CDR_EXT_EN		BIT(19)
+#define CORE_DLL_LOCK		BIT(7)
+#define CORE_CMD_DAT_TRACK_SEL	BIT(0)
+
+#define CDR_SELEXT_SHIFT	20
+#define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
+
+/* MCLK frequency selection (CMUX_SHIFT_PHASE) - required for the DLL to lock */
+#define CMUX_SHIFT_PHASE_SHIFT	24
+#define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
+
+/* 14LPP DLL reset / Tassadar DLL extras, for SDCC minor >= 0x42 / 0x71 */
+#define CORE_DLL_CLOCK_DISABLE	BIT(21)
+
+#define DLL_USR_CTL_POR_VAL	0x10800
+#define ENABLE_DLL_LOCK_STATUS	BIT(26)
+#define FINE_TUNE_MODE_EN	BIT(27)
+#define BIAS_OK_SIGNAL		BIT(29)
+
+#define DLL_CONFIG_3_LOW_FREQ_VAL	0x08
+#define DLL_CONFIG_3_HIGH_FREQ_VAL	0x10
+
+#define CORE_CLK_PWRSAVE	BIT(1)
+
+/* Timing mode selection */
+#define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
+#define CORE_HC_MCLK_SEL_HS400	(3 << 8)
+#define CORE_HC_MCLK_SEL_MASK	(3 << 8)
+#define CORE_HC_SELECT_IN_EN	BIT(18)
+#define CORE_HC_SELECT_IN_HS400	(6 << 19)
+#define CORE_HC_SELECT_IN_MASK	(7 << 19)
+
+/* HS400 DDR/SDC4 DLL calibration, needed alongside the SDR CM_DLL above */
+#define CORE_DDR_CAL_EN		BIT(0)
+#define CORE_DDR_DLL_LOCK	BIT(11)
+#define CORE_PWRSAVE_DLL	BIT(3)
+#define CORE_CMDIN_RCLK_EN	BIT(1)
+#define DDR_CONFIG_POR_VAL	0x80040873
+
+#define CORE_FREQ_100MHZ	(100 * 1000000)
+#define MAX_PHASES		16
+
 #define MHZ(X) ((X) * 1000000UL)
 
 struct msm_sdhc_plat {
@@ -50,14 +97,40 @@ struct msm_sdhc {
 	void *base;
 	struct clk_bulk clks;
 	struct udevice *vqmmc;
+
+	/* HS200/HS400 tuning and calibration state */
+	bool tuning_done;
+	bool calibration_done;
+	bool use_cdr;
+	u8 saved_tuning_phase;
+
+	/* DLL init sequence variant selection, from the SDCC core version */
+	u32 dll_config;		/* qcom,dll-config DT override, 0 if absent */
+	bool use_14lpp_dll_reset;	/* core_minor >= 0x42 */
+	bool uses_tassadar_dll;		/* core_minor >= 0x71 */
+
+	/* HS400 support */
+	bool use_cdclp533;		/* core_minor < 0x34, legacy calibration path */
+	bool updated_ddr_cfg;		/* core_minor >= 0x49 */
+	u32 ddr_config;			/* qcom,ddr-config DT override, else POR value */
 };
 
 struct msm_sdhc_variant_info {
 	bool mci_removed;
 
 	u32 core_dll_config;
+	u32 core_dll_status;
+	u32 core_dll_config_2;
+	u32 core_dll_config_3;
+	u32 core_dll_usr_ctl; /* Present on SDCC5.1 onwards */
 	u32 core_vendor_spec;
 	u32 core_vendor_spec_capabilities0;
+
+	/* HS400 DDR/SDC4 calibration registers */
+	u32 core_ddr_200_cfg;
+	u32 core_vendor_spec3;
+	u32 core_ddr_config_old; /* Applicable to sdcc minor ver < 0x49; 0 if N/A */
+	u32 core_ddr_config;
 };
 
 static int msm_sdc_clk_init(struct udevice *dev)
@@ -153,12 +226,714 @@ static int msm_sdc_mci_init(struct msm_sdhc *prv)
 	return 0;
 }
 
+static int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
+{
+	u32 wait_cnt = 50;
+	u8 ck_out_en;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+
+	ck_out_en = !!(readl(host->ioaddr + var_info->core_dll_config) &
+		       CORE_CK_OUT_EN);
+
+	while (ck_out_en != poll) {
+		if (--wait_cnt == 0) {
+			printf("%s: CK_OUT_EN bit is not %d\n",
+			       host->name, poll);
+			return -ETIMEDOUT;
+		}
+		udelay(1);
+
+		ck_out_en = !!(readl(host->ioaddr +
+				     var_info->core_dll_config) &
+			       CORE_CK_OUT_EN);
+	}
+
+	return 0;
+}
+
+static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
+{
+	int rc;
+	static const u8 grey_coded_phase_table[] = {
+		0x0, 0x1, 0x3, 0x2, 0x6, 0x7, 0x5, 0x4,
+		0xc, 0xd, 0xf, 0xe, 0xa, 0xb, 0x9, 0x8
+	};
+	u32 config;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+
+	if (phase > 0xf)
+		return -EINVAL;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~(CORE_CDR_EN | CORE_CK_OUT_EN);
+	config |= (CORE_CDR_EXT_EN | CORE_DLL_EN);
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	rc = msm_dll_poll_ck_out_en(host, 0);
+	if (rc)
+		return rc;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CDR_SELEXT_MASK;
+	config |= grey_coded_phase_table[phase] << CDR_SELEXT_SHIFT;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CK_OUT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	rc = msm_dll_poll_ck_out_en(host, 1);
+	if (rc)
+		return rc;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CDR_EN;
+	config &= ~CORE_CDR_EXT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	return 0;
+}
+
+/*
+ * Programs the MCLK_FREQ (CMUX_SHIFT_PHASE) field, required before enabling
+ * CORE_DLL_EN/CORE_CK_OUT_EN or the DLL never locks. Matches the kernel
+ * driver's msm_cm_dll_set_freq().
+ *
+ * host->clock is never updated by this U-Boot's generic sdhci.c, so
+ * mmc->clock is used instead.
+ */
+static void msm_cm_dll_set_freq(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct mmc *mmc = host->mmc;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 mclk_freq = 0, config;
+	unsigned int clock = mmc->clock;
+
+	if (clock <= 112000000)
+		mclk_freq = 0;
+	else if (clock <= 125000000)
+		mclk_freq = 1;
+	else if (clock <= 137000000)
+		mclk_freq = 2;
+	else if (clock <= 150000000)
+		mclk_freq = 3;
+	else if (clock <= 162000000)
+		mclk_freq = 4;
+	else if (clock <= 175000000)
+		mclk_freq = 5;
+	else if (clock <= 187000000)
+		mclk_freq = 6;
+	else if (clock <= 200000000)
+		mclk_freq = 7;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CMUX_SHIFT_PHASE_MASK;
+	config |= mclk_freq << CMUX_SHIFT_PHASE_SHIFT;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+}
+
+static int msm_dll_poll_lock_status(struct sdhci_host *host)
+{
+	u32 wait_cnt = 50;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+
+	while (!(readl(host->ioaddr + var_info->core_dll_status) &
+		 CORE_DLL_LOCK)) {
+		if (--wait_cnt == 0) {
+			printf("%s: DLL failed to LOCK (DLL_STATUS=0x%08x)\n",
+			       host->name,
+			       readl(host->ioaddr + var_info->core_dll_status));
+			return -ETIMEDOUT;
+		}
+		udelay(1);
+	}
+
+	return 0;
+}
+
+/* Matches the kernel sdhci-msm.c msm_init_cm_dll() sequence */
+static int msm_init_cm_dll(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+	int ret;
+
+	/*
+	 * Keep the clock enabled while DLL tuning is in progress; PWRSAVE
+	 * may otherwise turn it off.
+	 */
+	config = readl(host->ioaddr + var_info->core_vendor_spec);
+	config &= ~CORE_CLK_PWRSAVE;
+	writel(config, host->ioaddr + var_info->core_vendor_spec);
+
+	if (priv->dll_config)
+		writel(priv->dll_config, host->ioaddr + var_info->core_dll_config);
+
+	if (priv->use_14lpp_dll_reset) {
+		config = readl(host->ioaddr + var_info->core_dll_config);
+		config &= ~CORE_CK_OUT_EN;
+		writel(config, host->ioaddr + var_info->core_dll_config);
+
+		if (var_info->core_dll_config_2) {
+			config = readl(host->ioaddr + var_info->core_dll_config_2);
+			config |= CORE_DLL_CLOCK_DISABLE;
+			writel(config, host->ioaddr + var_info->core_dll_config_2);
+		}
+	}
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_DLL_RST;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_DLL_PDN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	/*
+	 * MCLK_FREQ must be programmed while the DLL is reset and powered
+	 * down, unless a DT dll-config override is in effect.
+	 */
+	if (!priv->dll_config)
+		msm_cm_dll_set_freq(host);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CORE_DLL_RST;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config &= ~CORE_DLL_PDN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	if (priv->use_14lpp_dll_reset) {
+		if (!priv->dll_config)
+			msm_cm_dll_set_freq(host);
+
+		if (var_info->core_dll_config_2) {
+			config = readl(host->ioaddr + var_info->core_dll_config_2);
+			config &= ~CORE_DLL_CLOCK_DISABLE;
+			writel(config, host->ioaddr + var_info->core_dll_config_2);
+		}
+	}
+
+	/* Applicable to SDCC v5.1 onwards only */
+	if (priv->uses_tassadar_dll && var_info->core_dll_usr_ctl) {
+		config = DLL_USR_CTL_POR_VAL | FINE_TUNE_MODE_EN |
+			 ENABLE_DLL_LOCK_STATUS | BIAS_OK_SIGNAL;
+		writel(config, host->ioaddr + var_info->core_dll_usr_ctl);
+
+		if (var_info->core_dll_config_3) {
+			config = readl(host->ioaddr + var_info->core_dll_config_3);
+			config &= ~0xFF;
+			if (host->mmc->clock < 150000000)
+				config |= DLL_CONFIG_3_LOW_FREQ_VAL;
+			else
+				config |= DLL_CONFIG_3_HIGH_FREQ_VAL;
+			writel(config, host->ioaddr + var_info->core_dll_config_3);
+		}
+	}
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_DLL_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CK_OUT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	ret = msm_dll_poll_lock_status(host);
+	if (ret)
+		return ret;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CDR_EN;
+	config &= ~CORE_CDR_EXT_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	priv->calibration_done = false;
+
+	return 0;
+}
+
+/*
+ * HS400 DDR calibration via SDC4 CM_DLL, used when use_cdclp533 is false
+ * (core_minor >= 0x34). Matches the kernel's
+ * sdhci_msm_cm_dll_sdc4_calibration().
+ */
+static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config, ddr_cfg_offset, wait_cnt;
+	int ret;
+
+	/*
+	 * core_ddr_config defaults to the desired configuration on reset;
+	 * reprogram the POR value in case an earlier bootloader stage
+	 * modified it.
+	 */
+	if (priv->updated_ddr_cfg)
+		ddr_cfg_offset = var_info->core_ddr_config;
+	else
+		ddr_cfg_offset = var_info->core_ddr_config_old;
+	writel(priv->ddr_config, host->ioaddr + ddr_cfg_offset);
+
+	config = readl(host->ioaddr + var_info->core_ddr_200_cfg);
+	config &= ~CORE_CMDIN_RCLK_EN;
+	writel(config, host->ioaddr + var_info->core_ddr_200_cfg);
+
+	config = readl(host->ioaddr + var_info->core_dll_config_2);
+	config |= CORE_DDR_CAL_EN;
+	writel(config, host->ioaddr + var_info->core_dll_config_2);
+
+	ret = -ETIMEDOUT;
+	wait_cnt = 100;
+	while (wait_cnt--) {
+		if (readl(host->ioaddr + var_info->core_dll_status) &
+		    CORE_DDR_DLL_LOCK) {
+			ret = 0;
+			break;
+		}
+		udelay(10);
+	}
+
+	if (ret) {
+		printf("%s: CM_DLL_SDC4 calibration was not completed\n",
+		       host->name);
+		return ret;
+	}
+
+	/*
+	 * Skip CORE_PWRSAVE_DLL for the 14lpp DLL reset variant: it cannot
+	 * guarantee the MCLK-gating timing PWRSAVE_DLL depends on.
+	 */
+	if (!priv->use_14lpp_dll_reset) {
+		config = readl(host->ioaddr + var_info->core_vendor_spec3);
+		config |= CORE_PWRSAVE_DLL;
+		writel(config, host->ioaddr + var_info->core_vendor_spec3);
+	}
+
+	return 0;
+}
+
+/*
+ * HS400 DLL calibration, performed once when transitioning into HS400 at
+ * clock > 100MHz. Matches the kernel's sdhci_msm_hs400_dll_calibration().
+ */
+static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+	int ret;
+
+	ret = msm_init_cm_dll(host);
+	if (ret)
+		return ret;
+
+	/* Restore the phase found during HS200 tuning */
+	ret = msm_config_cm_dll_phase(host, priv->saved_tuning_phase);
+	if (ret)
+		return ret;
+
+	config = readl(host->ioaddr + var_info->core_dll_config);
+	config |= CORE_CMD_DAT_TRACK_SEL;
+	writel(config, host->ioaddr + var_info->core_dll_config);
+
+	/*
+	 * use_cdclp533 only applies to legacy SDCC (core_minor < 0x34); our
+	 * supported targets always use the SDC4 calibration path.
+	 */
+	if (priv->use_cdclp533) {
+		printf("%s: CDCLP533 HS400 calibration path is not implemented\n",
+		       host->name);
+		return -EOPNOTSUPP;
+	}
+
+	return sdhci_msm_cm_dll_sdc4_calibration(host);
+}
+
+static int msm_find_most_appropriate_phase(struct sdhci_host *host,
+					   u8 *phase_table,
+					   u8 total_phases)
+{
+	int ret;
+	u8 ranges[MAX_PHASES][MAX_PHASES] = { {0}, {0} };
+	u8 phases_per_row[MAX_PHASES] = { 0 };
+	int row_index = 0, col_index = 0, selected_row_index = 0;
+	int i, longest_range_len = 0;
+	bool found = false;
+
+	if (!total_phases || total_phases > MAX_PHASES) {
+		printf("%s: Invalid argument: total_phases=%d\n",
+		       host->name, total_phases);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < total_phases; i++) {
+		ranges[row_index][col_index] = phase_table[i];
+		phases_per_row[row_index] += 1;
+		col_index++;
+
+		if ((i + 1) == total_phases)
+			continue;
+
+		if (phase_table[i] + 1 != phase_table[i + 1]) {
+			row_index++;
+			col_index = 0;
+		}
+	}
+
+	if (row_index == 0) {
+		ret = phase_table[total_phases / 2];
+		goto exit;
+	}
+
+	for (i = 0; i <= row_index; i++) {
+		if (phases_per_row[i] > longest_range_len) {
+			longest_range_len = phases_per_row[i];
+			selected_row_index = i;
+			found = true;
+		}
+	}
+
+	if (found) {
+		ret = ranges[selected_row_index][longest_range_len / 2];
+	} else {
+		ret = -EIO;
+		printf("%s: Failed to find a valid phase\n", host->name);
+	}
+
+exit:
+	return ret;
+}
+
+static bool sdhci_msm_is_tuning_needed(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+
+	return mmc->selected_mode == MMC_HS_200;
+}
+
+static int msm_send_tuning_cmd(struct mmc *mmc, u32 opcode)
+{
+	struct mmc_cmd cmd;
+	struct mmc_data data;
+	const u8 *tuning_block_pattern;
+	int size, err;
+
+	static const u8 tuning_blk_pattern_4bit[] = {
+		0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
+		0xc3, 0x3c, 0xcc, 0xff, 0xfe, 0xff, 0xfe, 0xef,
+		0xff, 0xdf, 0xff, 0xdd, 0xff, 0xfb, 0xff, 0xfb,
+		0xbf, 0xff, 0x7f, 0xff, 0x77, 0xf7, 0xbd, 0xef,
+		0xff, 0xf0, 0xff, 0xf0, 0x0f, 0xfc, 0xcc, 0x3c,
+		0xcc, 0x33, 0xcc, 0xcf, 0xff, 0xef, 0xff, 0xee,
+		0xff, 0xfd, 0xff, 0xfd, 0xdf, 0xff, 0xbf, 0xff,
+		0xbb, 0xff, 0xf7, 0xff, 0xf7, 0x7f, 0x7b, 0xde,
+	};
+
+	static const u8 tuning_blk_pattern_8bit[] = {
+		0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
+		0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc, 0xcc,
+		0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff,
+		0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
+		0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd,
+		0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
+		0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff,
+		0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff,
+		0xff, 0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00,
+		0x00, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0x33, 0xcc,
+		0xcc, 0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff,
+		0xff, 0xff, 0xee, 0xff, 0xff, 0xff, 0xee, 0xee,
+		0xff, 0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd,
+		0xdd, 0xff, 0xff, 0xff, 0xbb, 0xff, 0xff, 0xff,
+		0xbb, 0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff,
+		0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
+	};
+
+	if (mmc->bus_width == 8) {
+		tuning_block_pattern = tuning_blk_pattern_8bit;
+		size = sizeof(tuning_blk_pattern_8bit);
+	} else if (mmc->bus_width == 4) {
+		tuning_block_pattern = tuning_blk_pattern_4bit;
+		size = sizeof(tuning_blk_pattern_4bit);
+	} else {
+		return -EINVAL;
+	}
+
+	ALLOC_CACHE_ALIGN_BUFFER(u8, data_buf, size);
+
+	cmd.cmdidx = opcode;
+	cmd.cmdarg = 0;
+	cmd.resp_type = MMC_RSP_R1;
+
+	data.dest = (void *)data_buf;
+	data.blocks = 1;
+	data.blocksize = size;
+	data.flags = MMC_DATA_READ;
+
+	err = mmc_send_cmd(mmc, &cmd, &data);
+
+	return err;
+}
+
+static int sdhci_msm_execute_tuning(struct mmc *mmc, u8 opcode)
+{
+	struct sdhci_host *host = mmc->priv;
+	int tuning_seq_cnt = 10;
+	u8 phase, tuned_phases[MAX_PHASES], tuned_phase_cnt = 0;
+	int rc;
+	struct udevice *dev = mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+
+	if (!sdhci_msm_is_tuning_needed(host)) {
+		priv->use_cdr = false;
+		return 0;
+	}
+
+	/*
+	 * The SDHCI core may call execute_tuning before host->clock is
+	 * updated to match mmc->clock.
+	 */
+	if (host->clock != mmc->clock) {
+		rc = sdhci_set_clock(mmc, mmc->clock);
+		if (rc) {
+			printf("%s: Failed to set clock for tuning\n", host->name);
+			return rc;
+		}
+	}
+
+	priv->use_cdr = true;
+	priv->tuning_done = false;
+
+retry:
+	rc = msm_init_cm_dll(host);
+	if (rc) {
+		printf("%s: Failed to init DLL\n", host->name);
+		return rc;
+	}
+
+	phase = 0;
+	tuned_phase_cnt = 0;
+
+	do {
+		rc = msm_config_cm_dll_phase(host, phase);
+		if (rc) {
+			printf("%s: Failed to set DLL phase %d\n",
+			       host->name, phase);
+			return rc;
+		}
+
+		rc = msm_send_tuning_cmd(mmc, opcode);
+		if (!rc)
+			tuned_phases[tuned_phase_cnt++] = phase;
+	} while (++phase < MAX_PHASES);
+
+	if (tuned_phase_cnt) {
+		if (tuned_phase_cnt == MAX_PHASES) {
+			/*
+			 * All phases valid is close to as bad as none valid:
+			 * likely no phase is really reliable. Retry a few
+			 * times rather than guessing.
+			 */
+			if (--tuning_seq_cnt) {
+				tuned_phase_cnt = 0;
+				goto retry;
+			}
+		}
+
+		rc = msm_find_most_appropriate_phase(host, tuned_phases,
+						     tuned_phase_cnt);
+		if (rc < 0) {
+			printf("%s: Failed to find appropriate phase\n",
+			       host->name);
+			return rc;
+		}
+		phase = rc;
+
+		rc = msm_config_cm_dll_phase(host, phase);
+		if (rc) {
+			printf("%s: Failed to set final phase %d\n",
+			       host->name, phase);
+			return rc;
+		}
+
+		priv->saved_tuning_phase = phase;
+	} else {
+		if (--tuning_seq_cnt)
+			goto retry;
+		printf("%s: No tuning point found\n", host->name);
+		rc = -EIO;
+	}
+
+	if (!rc)
+		priv->tuning_done = true;
+
+	return rc;
+}
+
+/*
+ * Configure HC mode selection. Runs from set_control_reg(), which the
+ * generic sdhci_set_ios() always calls before sdhci_set_clock() - and it is
+ * sdhci_set_clock() that triggers config_dll(), which performs the SDC4
+ * CM_DLL HS400 calibration. On the first HS400 transition, calibration_done
+ * is still false here (it only becomes true after config_dll() runs later
+ * in the same set_ios() call), so the HS400 mux-select bits are deferred
+ * until calibration has actually completed - selecting HS400 in the mux
+ * beforehand would switch the data path into HS400 timing while the DLL is
+ * still configured for the previous mode/clock. The first write of these
+ * bits happens from msm_sdhci_config_dll() via sdhci_msm_hs400_select_in()
+ * once calibration succeeds.
+ */
+static void sdhci_msm_hc_select_mode(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	struct udevice *dev = mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	bool is_hs400 = mmc->selected_mode == MMC_HS_400;
+	u32 config;
+
+	config = readl(host->ioaddr + var_info->core_vendor_spec);
+	config &= ~CORE_HC_MCLK_SEL_MASK;
+
+	if (mmc->selected_mode == MMC_HS_200)
+		config |= CORE_HC_MCLK_SEL_DFLT;
+	else if (is_hs400)
+		config |= CORE_HC_MCLK_SEL_HS400;
+	else
+		config |= CORE_HC_MCLK_SEL_DFLT;
+
+	writel(config, host->ioaddr + var_info->core_vendor_spec);
+
+	if (is_hs400) {
+		if (priv->calibration_done) {
+			config = readl(host->ioaddr + var_info->core_vendor_spec);
+			config |= CORE_HC_SELECT_IN_HS400;
+			config |= CORE_HC_SELECT_IN_EN;
+			writel(config, host->ioaddr + var_info->core_vendor_spec);
+		}
+	} else {
+		/*
+		 * Matches the kernel's msm_hc_select_default(): explicitly
+		 * clear these bits for every non-HS400 mode so a previous
+		 * HS400 attempt never leaves them stuck set.
+		 */
+		if (!priv->use_cdclp533) {
+			config = readl(host->ioaddr + var_info->core_vendor_spec3);
+			config &= ~CORE_PWRSAVE_DLL;
+			writel(config, host->ioaddr + var_info->core_vendor_spec3);
+		}
+
+		config = readl(host->ioaddr + var_info->core_vendor_spec);
+		config &= ~CORE_HC_SELECT_IN_EN;
+		config &= ~CORE_HC_SELECT_IN_MASK;
+		writel(config, host->ioaddr + var_info->core_vendor_spec);
+	}
+}
+
+/*
+ * Selects HS400 in the HC_SELECT_IN mux. Must only be called immediately
+ * after sdhci_msm_hs400_dll_calibration() succeeds - see the comment in
+ * sdhci_msm_hc_select_mode() for why this can't be done there.
+ */
+static void sdhci_msm_hs400_select_in(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+
+	config = readl(host->ioaddr + var_info->core_vendor_spec);
+	config |= CORE_HC_SELECT_IN_HS400;
+	config |= CORE_HC_SELECT_IN_EN;
+	writel(config, host->ioaddr + var_info->core_vendor_spec);
+}
+
+static void sdhci_msm_set_control_reg(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	struct udevice *dev = mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	u32 config;
+
+	/*
+	 * The Qualcomm SDHCI controller does not implement the generic
+	 * SDHCI_CTRL_HS400 (0x5) HOST_CONTROL2 encoding that
+	 * sdhci_set_uhs_timing() would write for HS400. Per the kernel
+	 * driver's sdhci_msm_set_uhs_signaling(), it instead keeps
+	 * HOST_CONTROL2's UHS field at SDR104 (identical to HS200) for
+	 * HS400 too, relying entirely on the vendor-specific
+	 * CORE_HC_MCLK_SEL/CORE_HC_SELECT_IN bits (sdhci_msm_hc_select_mode()
+	 * below) to switch the data path into HS400 timing.
+	 */
+	sdhci_set_voltage(host);
+	if (mmc->selected_mode == MMC_HS_400) {
+		u32 ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		ctrl2 &= ~SDHCI_CTRL_UHS_MASK;
+		ctrl2 |= SDHCI_CTRL_UHS_SDR104;
+		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+	} else {
+		sdhci_set_uhs_timing(host);
+	}
+
+	sdhci_msm_hc_select_mode(host);
+
+	/*
+	 * Below 100MHz the feedback clock must be provided without the DLL,
+	 * so tuning can be skipped.
+	 */
+	if (mmc->clock && mmc->clock <= CORE_FREQ_100MHZ) {
+		if (mmc->selected_mode == MMC_HS_200 ||
+		    mmc->selected_mode == MMC_HS_400) {
+			config = readl(host->ioaddr + var_info->core_dll_config);
+			config |= CORE_DLL_RST;
+			writel(config, host->ioaddr + var_info->core_dll_config);
+
+			config = readl(host->ioaddr + var_info->core_dll_config);
+			config |= CORE_DLL_PDN;
+			writel(config, host->ioaddr + var_info->core_dll_config);
+
+			/*
+			 * Calibration must be redone once the clock is set
+			 * back to HS400 speed, matching the kernel's
+			 * sdhci_msm_set_uhs_signaling().
+			 */
+			priv->calibration_done = false;
+		}
+	}
+}
+
 static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 {
 	struct udevice *dev = mmc_to_dev(host->mmc);
+	struct mmc *mmc = host->mmc;
+	struct msm_sdhc *priv = dev_get_priv(dev);
 	const struct msm_sdhc_variant_info *var_info = (void *)dev_get_driver_data(dev);
 	u32 config;
 
+	if (clock == 0)
+		return 0;
+
 	if (enable && clock < MHZ(100)) {
 		/*
 		 * DLL is not required for clock <= 100MHz
@@ -173,12 +948,40 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 		writel(config, host->ioaddr + var_info->core_dll_config);
 	}
 
+	/*
+	 * HS400 requires a dedicated DDR/SDC4 DLL calibration step,
+	 * performed once per calibration cycle after the divider has been
+	 * programmed and the clock is running above 100MHz - the analogue
+	 * of the kernel's sdhci_msm_set_uhs_signaling() -> sdhci_msm_hs400()
+	 * trigger, which runs right after the SDCLK divider is set.
+	 */
+	if (enable && clock > MHZ(100) &&
+	    mmc->selected_mode == MMC_HS_400 && priv->tuning_done &&
+	    !priv->calibration_done) {
+		int ret = sdhci_msm_hs400_dll_calibration(host);
+
+		if (!ret) {
+			priv->calibration_done = true;
+			/*
+			 * Only now that calibration has actually succeeded
+			 * is it safe to switch the data-path mux into HS400
+			 * timing - see the comment in
+			 * sdhci_msm_hc_select_mode().
+			 */
+			sdhci_msm_hs400_select_in(host);
+		} else {
+			printf("%s: Failed to calibrate DLL for HS400 mode (%d)\n",
+			       host->name, ret);
+		}
+	}
+
 	return 0;
 }
 
 struct sdhci_ops msm_sdhci_ops = {
 	.config_dll = &msm_sdhci_config_dll,
-	.set_control_reg = &sdhci_set_control_reg,
+	.set_control_reg = &sdhci_msm_set_control_reg,
+	.platform_execute_tuning = &sdhci_msm_execute_tuning,
 };
 
 static int msm_sdc_probe(struct udevice *dev)
@@ -239,6 +1042,27 @@ static int msm_sdc_probe(struct udevice *dev)
 
 	log_debug("SDCC version %d.%d\n", core_major, core_minor);
 
+	/*
+	 * Match the kernel driver's version-gated feature detection so the
+	 * DLL init sequence matches what this SDCC IP revision needs.
+	 */
+	if (core_major == 1 && core_minor >= 0x42)
+		prv->use_14lpp_dll_reset = true;
+
+	if (core_major == 1 && core_minor >= 0x71)
+		prv->uses_tassadar_dll = true;
+
+	if (core_major == 1 && core_minor < 0x34)
+		prv->use_cdclp533 = true;
+
+	if (core_major == 1 && core_minor >= 0x49)
+		prv->updated_ddr_cfg = true;
+
+	dev_read_u32(dev, "qcom,dll-config", &prv->dll_config);
+
+	if (dev_read_u32(dev, "qcom,ddr-config", &prv->ddr_config))
+		prv->ddr_config = DDR_CONFIG_POR_VAL;
+
 	/*
 	 * Support for some capabilities is not advertised by newer
 	 * controller versions and must be explicitly enabled.
@@ -249,6 +1073,16 @@ static int msm_sdc_probe(struct udevice *dev)
 		writel(caps, host->ioaddr + var_info->core_vendor_spec_capabilities0);
 	}
 
+	/*
+	 * HS400 uses DDR signaling, and host_caps MMC_CAP(MMC_HS_400) is
+	 * already set unconditionally by the generic drivers/mmc/sdhci.c
+	 * whenever CONFIG_MMC_HS400_SUPPORT=y, so advertising DDR50/SDR104
+	 * support here is all that's needed to enable HS200/HS400.
+	 */
+	caps = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
+	caps |= SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_DDR50;
+	writel(caps, host->ioaddr + SDHCI_CAPABILITIES_1);
+
 	ret = mmc_of_parse(dev, &plat->cfg);
 	if (ret)
 		return ret;
@@ -322,16 +1156,35 @@ static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
 	.mci_removed = false,
 
 	.core_dll_config = 0x100,
+	.core_dll_status = 0x108,
+	.core_dll_config_2 = 0x1b4,
 	.core_vendor_spec = 0x10c,
 	.core_vendor_spec_capabilities0 = 0x11c,
+
+	.core_ddr_200_cfg = 0x184,
+	.core_vendor_spec3 = 0x1b0,
+	.core_ddr_config_old = 0x1b8,
+	.core_ddr_config = 0x1bc,
 };
 
 static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
 	.mci_removed = true,
 
 	.core_dll_config = 0x200,
+	.core_dll_status = 0x208,
+	.core_dll_config_2 = 0x254,
+	.core_dll_config_3 = 0x258,
+	.core_dll_usr_ctl = 0x388,
 	.core_vendor_spec = 0x20c,
 	.core_vendor_spec_capabilities0 = 0x21c,
+
+	.core_ddr_200_cfg = 0x224,
+	.core_vendor_spec3 = 0x250,
+	.core_ddr_config = 0x25c,
+	/*
+	 * core_ddr_config_old not present on V5 - updated_ddr_cfg is
+	 * effectively always true here since V5 implies core_minor >= 0x49
+	 */
 };
 
 static const struct udevice_id msm_mmc_ids[] = {
-- 
2.34.1

