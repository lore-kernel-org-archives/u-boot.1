Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474B6C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 17:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10FAC416F4;
	Wed,  2 Sep 2026 17:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YISEzqbozCmn; Wed,  2 Sep 2026 17:08:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788368825;
	bh=nheWTTk02hwaLxBCexgDnVpYbUmhcjTTJsH8Rs1uBQk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ImvaAwK80lj6140w0eiOwxyv08YbZ1w28259jpHwQgwLdGXqeoEMHQBFxn6+u4xYU
	 OIiUw5OeVJZ+L83b2Emc5UiPGvSD7Cs2HjE5/OXNx6W9ugsfI8vMSXkw6KEXaLl+3c
	 2XxeW0Og/RF087eF6HJyhpOYjF8/Ugkz2VuIkl2pzEYO/As+pRce3xA1BgddD3G0H4
	 DzZkuCQKDE+DQ/fn8APHxHALsnWGqJVOrsKnaHbUXiRz3agNmIEYe48gX14MKGR8ya
	 koxLnyfpKWBInZWkylrsNGEMn+fekdmvqh89kd0T6IcHg9TyorjNVS5ZW4eLT/7laJ
	 tj5Nubwegn99g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 262A2410B8;
	Wed,  2 Sep 2026 17:07:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E2ECC363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8D8660B24
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:07:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ed3knuiqUXHg for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 17:07:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=o3FiAtmV; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ai0uYTTH
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAA8761363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:06:23 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682Gfgep1947608
 for <u-boot@lists.u-boot-project.org>; Wed, 2 Sep 2026 17:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nheWTTk02hw
 aLxBCexgDnVpYbUmhcjTTJsH8Rs1uBQk=; b=o3FiAtmVgiLI6//BP+/Gbg04NHq
 NzFVVhgngshvez4P8h9co4tJcs7x09NrA2bODoG5pNjpTZzH3+Gh9pOSpvQrJ9MS
 A3o2/hk4i3o1JUuQr2JhRf8HsDuJIeHdUR5VuYFHDAIm08CufHO4plScTOdxIiK2
 cN5rP/c442NpPeopLkyMHVshJtMzzI8hZuT+vdkHxKRf43BHBeA/CeOHkS4M8OUP
 DC46D4DryLz1OTjjsBVbzQLZw9/cUt8dQr/PrfDUTTy8liNUScTIMbTyd3jKvO5j
 KidIBLiFI4/2uw3h9Vex68Q3v8JgUFBOlKjNVfIidS/8yazyC3Gdi+yVOzw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdrk5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 17:06:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbee6bb8408so1770829a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788368781; x=1788973581;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nheWTTk02hwaLxBCexgDnVpYbUmhcjTTJsH8Rs1uBQk=;
 b=Ai0uYTTHlRZ7NYHD6m+vfBgjAUYhPRWn85W74eZ4Tmjv2jxa1NRScnmeh+W8zQZL3y
 /g0ke6IkgFvAFf0OlV8JxDuin3N4jbWjQVyKkue+eAAKkB+v5I2TQ4PgLhGg+Xcyha9f
 aboUz4qxF3Gol1k2pDy2sMbKFXBk0NurMr+Q0GhPtrdfA5WJHP8SerH4MfNdSoGFAj5v
 pS3IdsnhszeoglUfBuDOxfjFu0m4m1MpABcrpaXdN9JfLwZaxj3XmMqUCmGoAt6or3De
 g7mFBKByeWDywY4U/xT1G+KbqMubrV5rw462/YPZDvaUScl0vw2qf+TTlEVhDvwi0cXB
 F4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368781; x=1788973581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nheWTTk02hwaLxBCexgDnVpYbUmhcjTTJsH8Rs1uBQk=;
 b=MNotk0map5nLQMCN2leU5EQISYUKeI98IIXvemVngZzfZxy4JDIrI+DBBNbbPm6wM8
 ePiyzJ7ilDG763dvpaHv603K0SO/svKtiMFyquzWBtrn1imcdctUjfCflOyKMQMhNxEt
 h39EvPoJC+IoZ/1lo7hOfgKbkPSeaOsDPqdNp4zFggQlMCVGLbFJ21mt+/vdUvsBllYD
 QA2bRAoAioWxrs1jduSERwAPhCh0MZVIzvtn2kO4+xcZwPzHnmelwkZcJOnLOe8PL7bb
 Lp3cP/Sn4uKUvKFDt5cKjwnReL2z6sObJbEscErW5yp6g5/UQCLTYdND4/qzJrmv+wCK
 6ncg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvi/otawfuHHzOYNvCz7GaVdEAheS60hPU78nO0PjV4rDXZTV6DuMyXH9A3nGLH3dJBEyX9M8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mNfo3Bzdw2J5ZFurHxetnRokMY3vSAhmyxUk6honU4hubaTRTl
 m3oOlvqNShXllfMi/OYnjJhNfOxTJTNx41aCuuaSuBTwc5vSvo4+gi7KEo2oFcsKcaKeit6vBmb
 jslxoQop5CDPNs5FTbS/CTD0EwazKENreZftuRkWqh2b6eiyRnZnJCkIkcCsmgBG/13Aq8IE=
X-Gm-Gg: AYBFou1968XyVZ17Vb6y7FSFkttOIKdBiROWB6pGhu/79oWgyKcZG/K28Qh4MKndUsj
 jOVCkVheQ8eMkhFBhYIw38WvlsuTZxpyxSpRL6JmxzFpOP1d8X1EoD6Viu6Srs9fpBxb8kC0uGz
 ITlFhWAQZrkmujCpkkOlbxmoJVMw+4Kvnbg3pOXDRJF44PSgeKpSRTaWUGhI0vU30P7pZl8ufzC
 O24mDyUEBfROkZVmj54BbNTGxYxhMZdDZ5Z9/knBzWEltvLsqH7vd5FEqGMwV9HVkaK+/CMIDM4
 KU3k3dIOrsXosklEmldbiQBLMzc7HCFN4mxb9g+r7InJGwdlfK91dwwlgUSeOy34r58A0e9ORHo
 9BPja9GuwnX67GSt3jzrUNTyY83knu4JWZDwBdyYRsTUTdSgWsbH2lPRCGjTsIDYC7q1UwSnGC6
 Gw31wYN12tZKYXhchUtCk=
X-Received: by 2002:a17:90b:6cc:b0:398:9bd5:490d with SMTP id
 98e67ed59e1d1-39aee0eafb9mr9779368a91.20.1788368780173; 
 Wed, 02 Sep 2026 10:06:20 -0700 (PDT)
X-Received: by 2002:a17:90b:6cc:b0:398:9bd5:490d with SMTP id
 98e67ed59e1d1-39aee0eafb9mr9779224a91.20.1788368779586; 
 Wed, 02 Sep 2026 10:06:19 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07bde5bfsm8105688eec.27.2026.09.02.10.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:06:19 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 2/3] mmc: msm_sdhci: add HS200/HS400 support
Date: Wed,  2 Sep 2026 22:35:58 +0530
Message-Id: <20260902170559.3225833-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
References: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a98578d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=k2CUB_93P8OP9VXmglEA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: u4FhDlzTE6iKPMwpIxrjuekmj9Co4AVw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MCBTYWx0ZWRfX3rHqauIP0H0a
 K3NO0AuAnq7njYZwXKizX4+7SuiwPya+5O4viZkFTKgxU8C9xUw9ia2CHW/J3aZJq1XrIxgCA1b
 I0afCliTAAR0DtHRfI9Rh8sgBz7kcwRPGbXiCEy3NJP/mD1RrD8Gownx5KWu1FEPDJx3UihsMRJ
 OapmRJ0dwuuu5fOoxm06NIrKhdu13foqdGl16VTYYNaWGGZERw90n9xPAxSmp9Dyra+dMA7woyY
 oCWHRNJDwOmrZ1mxpRAahevilvUvVnjb+uPJjWuDEmzdfL9qzCbjmC/WD/0fqFSb8wE4yAj2VSH
 pSUMxlW7cI314+WznYNOsIe3inLS07tzdqXawWEu7Oj+c0+S9pB9VOPSGoW956hEAqT1h6SMg/B
 5C76AdCtY/XI+dGUGNUZoysR70T6oMWB2sPSLGR1SwCYi42bt4EOkLsL77xT93qJJbGNHYnetgE
 iZRD5JIAlL85sEpdSKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MCBTYWx0ZWRfX2z5anSdc+1XH
 L8asZ/iO00xT74ftSrCkLWyRK93zv2Kd/I2B+zQpUv2J4bQHOhuR4YoDN66zq+edzGs86VjIKIc
 rJmMGxRXDqcmwXwTjGk8caoLP8WD3B8=
X-Proofpoint-ORIG-GUID: u4FhDlzTE6iKPMwpIxrjuekmj9Co4AVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020150
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
already distinguished in this driver.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 752 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 751 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index e0753a1cd5d..668aadf6c6e 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -15,7 +15,9 @@
 #include <wait_bit.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/iopoll.h>
 #include <power/regulator.h>
+#include <memalign.h>
 
 /* Non-standard registers needed for SDHCI startup */
 #define SDCC_MCI_POWER   0x0
@@ -38,6 +40,52 @@
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
@@ -50,14 +98,39 @@ struct msm_sdhc {
 	void *base;
 	struct clk_bulk clks;
 	struct udevice *vqmmc;
+
+	/* HS200/HS400 tuning and calibration state */
+	bool tuning_done;
+	bool calibration_done;
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
@@ -149,12 +222,624 @@ static int msm_sdc_mci_init(struct msm_sdhc *prv)
 	return 0;
 }
 
+static int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
+{
+	u32 ck_out_en;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	int ret;
+
+	ret = read_poll_timeout(readl, ck_out_en,
+				(!!(ck_out_en & CORE_CK_OUT_EN) == poll),
+				1, 50,
+				host->ioaddr + var_info->core_dll_config);
+	if (ret) {
+		printf("%s: CK_OUT_EN bit is not %d\n",
+		       host->name, poll);
+		return -ETIMEDOUT;
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
+ * Programs the MCLK_FREQ (CMUX_SHIFT_PHASE) field. Must be set before
+ * enabling CORE_DLL_EN/CORE_CK_OUT_EN, otherwise the DLL will not lock.
+ *
+ * host->clock is not updated by the generic sdhci.c, so mmc->clock is
+ * used instead.
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
+	u32 dll_status;
+	struct udevice *dev = host->mmc->dev;
+	const struct msm_sdhc_variant_info *var_info =
+		(void *)dev_get_driver_data(dev);
+	int ret;
+
+	ret = read_poll_timeout(readl, dll_status,
+				(dll_status & CORE_DLL_LOCK),
+				1, 50,
+				host->ioaddr + var_info->core_dll_status);
+	if (ret) {
+		printf("%s: DLL failed to LOCK (DLL_STATUS=0x%08x)\n",
+		       host->name,
+		       readl(host->ioaddr + var_info->core_dll_status));
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/* CM_DLL initialization sequence */
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
+ * (core_minor >= 0x34).
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
+ * clock > 100MHz.
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
+static int sdhci_msm_execute_tuning(struct mmc *mmc, u8 opcode)
+{
+	struct sdhci_host *host = mmc->priv;
+	int tuning_seq_cnt = 10;
+	u8 phase, tuned_phases[MAX_PHASES], tuned_phase_cnt = 0;
+	int rc;
+	struct udevice *dev = mmc->dev;
+	struct msm_sdhc *priv = dev_get_priv(dev);
+
+	if (!sdhci_msm_is_tuning_needed(host))
+		return 0;
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
+		rc = mmc_send_tuning(mmc, opcode);
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
+ * Configure HC mode selection. On the first HS400 transition,
+ * calibration_done is still false, so the HS400 mux-select bits are
+ * deferred until calibration completes in msm_sdhci_config_dll(); see
+ * sdhci_msm_hs400_select_in().
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
+		 * Clear these bits for every non-HS400 mode so a previous
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
+ * Selects HS400 in the HC_SELECT_IN mux. Must only be called after
+ * sdhci_msm_hs400_dll_calibration() succeeds.
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
+	 * This controller has no HOST_CONTROL2 encoding for HS400. Keep the
+	 * UHS field at SDR104 (same as HS200) for HS400 too; the data path
+	 * is switched to HS400 timing via the vendor-specific
+	 * CORE_HC_MCLK_SEL/CORE_HC_SELECT_IN bits instead.
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
+			/* Calibration must be redone once the clock returns to HS400 speed. */
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
@@ -169,12 +854,33 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 		writel(config, host->ioaddr + var_info->core_dll_config);
 	}
 
+	/*
+	 * HS400 requires a dedicated DDR/SDC4 DLL calibration step, performed
+	 * once per calibration cycle once the clock is running above 100MHz.
+	 */
+	if (enable && clock > MHZ(100) &&
+	    mmc->selected_mode == MMC_HS_400 && priv->tuning_done &&
+	    !priv->calibration_done) {
+		int ret = sdhci_msm_hs400_dll_calibration(host);
+
+		if (!ret) {
+			priv->calibration_done = true;
+			/* Safe to switch the data-path mux into HS400 timing now. */
+			sdhci_msm_hs400_select_in(host);
+		} else {
+			printf("%s: Failed to calibrate DLL for HS400 mode (%d)\n",
+			       host->name, ret);
+			return ret;
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
@@ -186,6 +892,7 @@ static int msm_sdc_probe(struct udevice *dev)
 	struct sdhci_host *host = &prv->host;
 	u32 core_version, core_minor, core_major;
 	struct reset_ctl bcr_rst;
+	struct blk_desc *bdesc;
 	u32 caps;
 	int ret;
 
@@ -235,6 +942,24 @@ static int msm_sdc_probe(struct udevice *dev)
 
 	log_debug("SDCC version %d.%d\n", core_major, core_minor);
 
+	/* Feature support depends on the SDCC core version. */
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
@@ -249,6 +974,12 @@ static int msm_sdc_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (plat->cfg.host_caps & MMC_CAP_NONREMOVABLE) {
+		bdesc = mmc_get_blk_desc(&plat->mmc);
+		if (bdesc)
+			bdesc->removable = 0;
+	}
+
 	host->mmc = &plat->mmc;
 	host->mmc->dev = dev;
 	host->ops = &msm_sdhci_ops;
@@ -318,16 +1049,35 @@ static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
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

