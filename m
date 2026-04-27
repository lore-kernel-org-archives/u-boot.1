Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF74FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7089384119;
	Mon, 27 Apr 2026 11:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YjMJw99T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F8AUMsHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E044184119; Mon, 27 Apr 2026 11:26:50 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB58C84310
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8TCoe4054507
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o1+cjrBwUj1pKBRQFtvSrcFD3gj9cikJ6qNORoBsjvY=; b=YjMJw99TyQ+c80Oh
 fYWeZK4ahiCcXWW2ae0R2eME8OOwgYS8aTIDA9LD+qXrWs/GiEoqe7GcVabOsUHO
 n5Dq/EsvOaPcmz3Ozk2f4fKHb1Klr9u6gidLndCe7YDDpHwJopdB2yuBnBGCroHn
 tyYx2hOjE5t6B71VBDyYPME99yn18IMTrnF7N27e98AMENAVaUBDwvd/m6bDXxS9
 FH79OvVUv0yqkIbEzEkr6T7mMOV8IQJxmZRjS3TQK7IFAREBGtAjLHcDG2gHv7f2
 DXenHOc+cX2g5RvF0ZDmg4Sm8HXJf04ENQZrV6PMWapPcTKLQTgQqMJ6PGR+J22c
 f7G43w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnkxdfmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:26:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f07078eaaso7643183b3a.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777282006; x=1777886806; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1+cjrBwUj1pKBRQFtvSrcFD3gj9cikJ6qNORoBsjvY=;
 b=F8AUMsHZnMaL7TLEmJ5a6XllaRxQssBmnynLPlUkiehpsD2NsimZWha54wit2oDR9b
 Nyp/g1/KWmevwRFYI0dZ46RXWQt6LZl5Nar7V2DFv/FWYGptbcWfB/a3xw2KhJ0smrFE
 9JI0lXBKhc08IYn6Avz1WN5w3o9y/M6zJ7WdQpluubNa+nU9BN5DD9AhImSvI+E+3Ma9
 mgVSrK45OGT0ujA2GfFy9BL9/4xF1d+/47crMljSh1stQlhjGwUTquijyN3vkPWCFR4y
 7hbnur4sxCaKwIZOiDIN9qF939pGgYFbqdm7e//lwqVrtwiiogx0jpfa/I8wF1Kylsb6
 WTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282006; x=1777886806;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o1+cjrBwUj1pKBRQFtvSrcFD3gj9cikJ6qNORoBsjvY=;
 b=QrZT4mhDsNVnUI9bLn54iqnbqv26zc9T8psbavaKBhWpOcnsWs4mntWt1Omo5gqiCr
 IBkdhrwurwSq9gUmNFzIU5y7EWoKpgKDsEjz7kIPc0dUyHXOaymTs92wAjlRFM6xSgWY
 obcDzzRZ19t+8O+TAinHw0iFg9iwaBbtpxpNoy2JBoRzyyo+kptwI2z50UR1ottyVmYm
 n/BM4TPaM20vsYVdUexApFLCVsd/eCZ3PFi4wTIV/0g3LBKzvE9dkaySIAfBzcE8qR+z
 co3yI31U4aS5fb+ysSRbHKuptSGASOB4H+vpsK4t+mMa4cWNF1Mjl6++bO7fg8X7n3BD
 9NJg==
X-Gm-Message-State: AOJu0Yx5qdmE56vTEM3fTcpXEbBty2u3krlzOlfn8eRTogtPMnRKY9eM
 UsMs8iYuB/gDweRckgVFEV5ZzTilEXlD31PrwN6wKq+lbJPvguuU/yp6uSZdu5tobEcYNZTeBzs
 jA4N3b/2XQmcC4H2rCOvs2LnB7R8kvorxxjk6Zb6Nh3hzecoLwhkRQWga
X-Gm-Gg: AeBDiesqY4fvOI3HmD8fuyDW6HyfsHjHTiUMWCYFiK9KevrmrOtSMd1vw+cYqcnIUQv
 DB0F3mXGyn1j+njEfa3xgsGOMPkwkMKQoLMGX+2x63FjF6ydxpqw9+9XE634ZAS+qGUP8dXZ4BL
 dmHf41U/lrj6vGeSa5sfAo8AFDF7kqq2NK+TeYIl1xA+TwOW3pmtwKBWg2ZIwV9mMtqyKLPao+T
 P1+WdQTEKPdWIcqsCO9EsLDu1/w3MEyJKbI3wxEpwp4cCKeI8fGlExrMyJb0nf2uf+IO7MBV+gZ
 Zd6KUfpdZ73XK69f3er0HcljgC83XGhcJX+H14r/55rGVnUAOwOUypK/F+wyLRtcRCtVFIThpKU
 GjB0p8xskRkldpCWUs5s4ShF2hUZG8hWWjYt9fqkw3rboqcNz1ycnyMvbw1ont/0iLPAsBL10vZ
 ho1UIKq7XzbWw/6fhoBwxrgvQjRKSbXASh/tT5fojYEv/uXaFKJ2TNuZtFmTDR
X-Received: by 2002:a05:6a00:e08:b0:82f:776f:a79a with SMTP id
 d2e1a72fcca58-82f8c8bc107mr43558175b3a.29.1777282006124; 
 Mon, 27 Apr 2026 02:26:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:e08:b0:82f:776f:a79a with SMTP id
 d2e1a72fcca58-82f8c8bc107mr43558148b3a.29.1777282005625; 
 Mon, 27 Apr 2026 02:26:45 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9819fesm31903133b3a.4.2026.04.27.02.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:26:45 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:56:10 +0530
Subject: [PATCH v2 6/7] drivers: ufs: qcom: Initialize and enable clocks
 before hardware access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ufs_clk-v2-6-36e10a7c0ef6@oss.qualcomm.com>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
In-Reply-To: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777281967; l=3268;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=F+/MdzqZ7MJBPdDUl3oJyvSzZv0L68jynoHvDX8iidI=;
 b=ynIDfYgaoMe9otaQDUe4w0OwYweeQG1Bxjwek3UYCEFgmevFdiNbPc1Ae4CyRx6VHs4HnijBq
 GoVr3wmF9IaBeQJyXsDw61a3mIRaOVf2dnHLfgfHl8N6cgJuX9ifV50
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: MilUVneqVp4uF7ISO-rwB62A2QmGSEXF
X-Proofpoint-ORIG-GUID: MilUVneqVp4uF7ISO-rwB62A2QmGSEXF
X-Authority-Analysis: v=2.4 cv=TuPWQjXh c=1 sm=1 tr=0 ts=69ef2bd7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=k-6STp4to-FPYlxJchoA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwMCBTYWx0ZWRfX8prCvB1NidL4
 lHH8crvczA/GtaTEECXNVQSM54+LYOqVdH1RsMLn+h/4pDr16L9MJkpg9uI5gvsY1Wwypd7HyfL
 FzpfeU9u2slibxv1m8BeZ+tqTt3vr/iXDYFcziI5JxBQrLjeeqnmFIYrk6PJt9afoZzjzA169W1
 Ac4Sh0vOPMXfbRODkjPBsFNooowEmL7zRB/bxwnTD2Mfun+rVRKyjcR0SEb5i16t2hZvC30F1x5
 WUM6P8qs6ECaZObInPX1Ke9LXRXaY4yQfXxWhQB6hsBUhT5fz0T3sV1aPdf3hrdGCTXm3+m8ZxE
 vNrlbJwlJC19dvNnmYGasxly9Zsl9NS7+dty8sU4hOs+PWX9YGkV1/cxpLgjCbwLbqRcsQtwYT5
 Bg5PDvcCc5bxnKBuxFec/i3OddQeN1HUzb05Wic1EHb+cpcEFDH76M3Md9d7Qs7QdSMaGFlxbKG
 XSjiAb0YUpCBjR5U5KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270100
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

Move UFS clock initialization and enabling before hardware setup
to ensure clocks are running when accessing UFS registers.

Previously, U-Boot depended on earlier bootloader stages to
initialize UFS clocks. When these bootloaders failed to do so,
UFS registers became inaccessible, causing initialization to fail.
This change makes U-Boot initialize and enable UFS clocks early
in the init sequence, removing the dependency on previous
bootloaders.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Remove ufs_qcom_init_clks function and move the clock enabling and
      rate set codes to ufs_qcom_init
- Add clk_release_bulk if ufs_qcom_enable_clks fails
---
 drivers/ufs/ufs-qcom.c | 53 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index dc40ee62daf..ae33f62fbee 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -30,6 +30,7 @@
 #define UFS_CPU_MAX_BANDWIDTH	819200
 
 static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable);
+static u32 ufs_qcom_get_core_clk_unipro_max_freq(struct ufs_hba *hba);
 
 static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
 {
@@ -47,17 +48,6 @@ static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
 	return 0;
 }
 
-static int ufs_qcom_init_clks(struct ufs_qcom_priv *priv)
-{
-	int err;
-	struct udevice *dev = priv->hba->dev;
-
-	err = clk_get_bulk(dev, &priv->clks);
-	if (err)
-		return err;
-
-	return 0;
-}
 
 static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
 {
@@ -557,10 +547,45 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
 static int ufs_qcom_init(struct ufs_hba *hba)
 {
 	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	struct udevice *dev = hba->dev;
+	struct clk clk;
+	u32 max_freq;
+	long rate;
 	int err;
 
 	priv->hba = hba;
 
+	/* Get maximum frequency for core_clk_unipro from device tree */
+	max_freq = ufs_qcom_get_core_clk_unipro_max_freq(hba);
+
+	/* Get and configure core_clk_unipro */
+	err = clk_get_by_name(dev, "core_clk_unipro", &clk);
+	if (err) {
+		dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
+		return err;
+	}
+
+	rate = clk_set_rate(&clk, max_freq);
+	if (rate < 0) {
+		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
+			max_freq, rate);
+	}
+
+	/* Get all clocks */
+	err = clk_get_bulk(dev, &priv->clks);
+	if (err) {
+		dev_err(dev, "clk_get_bulk failed: %d\n", err);
+		return err;
+	}
+
+	/* Enable clocks */
+	err = ufs_qcom_enable_clks(priv);
+	if (err) {
+		dev_err(dev, "failed to enable clocks: %d\n", err);
+		clk_release_bulk(&priv->clks);
+		return err;
+	}
+
 	/* setup clocks */
 	ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
 
@@ -579,12 +604,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		 priv->hw_ver.minor,
 		 priv->hw_ver.step);
 
-	err = ufs_qcom_init_clks(priv);
-	if (err) {
-		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
-		return err;
-	}
-
 	ufs_qcom_advertise_quirks(hba);
 	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
 

-- 
2.34.1

