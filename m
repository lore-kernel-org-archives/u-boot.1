Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAA7F588F9
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 16:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0BF842B7;
	Mon, 20 Apr 2026 18:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z26rdLn3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CoTcccj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33AD842BF; Mon, 20 Apr 2026 18:35:17 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE60784258
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gurumoorthy.santhakumar@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KCxJin3455879
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 16:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=cACC5b4ghg/lbmwNERUp37c4Zo6SBXH5xqw
 YJ/Qtsx4=; b=Z26rdLn3SXhK+zxBfRYySQKD3mVi9h2rb6iYf5Bsa7tAbtJoVvX
 IJVDxlgsSHnciT8kdFrJXML/7GvP2JlZtvZk/q41oqpmkm/ewcQouw8oGEUh19pi
 1KeVfG2CB+zLfb5odijme8CsYOWdKCPyPpPJfj644rir5RcZV6CmqnNvuzMCOQaW
 S9pZcCTcGo/RmHBpTXGlt/e3g7yc/oJHdnJcAcZIfz4BsQn/sHexuZhedBsqj4Kh
 jYFxbU4BgcwtJTSuPJXcuM7Jffig1bn2WShnqT0gO/3hcOms5+PWoIgpbcfJWZnn
 XEzv6JYdLAzFVDyOAH66VIIJcR9XXWUxElQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfvjt6xp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 16:35:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2e6ee9444so35492405ad.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776702910; x=1777307710; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cACC5b4ghg/lbmwNERUp37c4Zo6SBXH5xqwYJ/Qtsx4=;
 b=CoTcccj3RcWN5T/8ORyV8o6FT2swLAHWKt3GvI+cynrkAaaR0ddDwWKP00hGGsagzr
 +bi2bMhMR8QGqIkY6c7+atzpP9fvIcyBndq+XnxO38dbtvcsn1z3+zlv3DTOS4SMDQGo
 PaBP32B/G6KZ0aaKWQRTAHP4rvY7f7nNF4VrHj4Nwu/u5MXS1w+Dzz7mtA0rAZInBfxT
 9xbL5ZY6F9pHkLPXfo6DGM2DieFJHVlQzfNGnCmqyURlFaMvs9PtKCEJjdFXv2RhoMv2
 9jjiDl9iNjYozs2kD1JQWhGgy+bthbyYPk3njv6cCmIwJxFyjyayIGaUF9nisJRz+oCn
 7yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776702910; x=1777307710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cACC5b4ghg/lbmwNERUp37c4Zo6SBXH5xqwYJ/Qtsx4=;
 b=bxrIWC1j5fPp26pf4/rjmIXtCxsyLVkZV4waFXPyaUhWNsXTUmlDfpl4CQwwjLWmc2
 FjQ9wLGv3SQ7HijMGN6030quJH+kT4bHtHievZJ46ydeRDSwnYTTtnw0Hmz29sByrXSo
 MzyX1gr6o0UkEsBf9l+2CQTAynGNDuQB5kbM+8GBu3JYytXhmkHe9eevWXhjx+Nblmmz
 nKXIhUzyu0tpPQfIH0G37VHXdyGXDVDSQSfGGbBrXOL8RpJ+CdNpYqplrq7FKAeGHyBD
 si4hCZpTClaOvBa9WE/cP8dCleBVPPltY6vmE1sw87Ks2JFaKYocutV3ZV25SeHVcKg2
 TQ/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UyYCN0YcFX2S5XfS9iSI27NfqFKGTurohI5ZRnKmZUy0jfixxAYiXb9/Ei90Wa3UBWZqmSXE=@lists.denx.de
X-Gm-Message-State: AOJu0YyywaiawBVIrhmKiXggpJq0ithxt21s4lcUPMTAShRu+pldfJ/P
 sWKWcNFSd+mEdg4oVL4L67nnvrKXL2784rttBc0KIV2BeP1nV/JVKm/JGmqx+0EHhWLYK3blLJD
 VZncgyqlDfGxhc2m81vJt8BKMm+KzeG6C6RpzZ8XPK2ajy0lgukiaLCr4
X-Gm-Gg: AeBDieuXkSXGA1ePknK7wv6740kSlnCk6cf7Ie5bvmXogai1JBLYKE1l+OTje8w6Ljy
 ZPr+20qV3haQmAdMQztjqE/O3OP6OUR4dIQctx1PFEK/QSgUQ4AsQT3b3fjQfROlRIYRI2JpUdB
 UCeI6nYnTfWUOn8Qkku3mYnGQU0OYdsMmN1ovk4kmSJvBC6hE0UMV4EaoTWXTIfCrc/U1LeLJo+
 1E2LCdnAtClstAJZq2BH+eKw24rFScVDQMJOpU5aXvutPN3FeK6VAPeCyvWIBZ0NElO2oq7eX4d
 lPe4+As1C+jnEbYsQFx6mvMpdV8NIUR85LsmN8bnS7IsvQq1Chi/eRk5pVaHlwQyfMJJ02ynzYa
 v+C1n0nI3Yt7VEutJQOe6QEbnAy1a9wLOw8jhd0NV06hpl2MR4PY39XbhDWwkDklq0JqN4U+lPS
 lBg6OA1tblyw1xIZwdGzLbhXZs0KNzgtmHiLEBAoqroSAF6KpLNec3LfN5K+y4mWCRKjc=
X-Received: by 2002:a17:902:db11:b0:2b2:5070:8b with SMTP id
 d9443c01a7336-2b5f9da50b3mr128466465ad.1.1776702910237; 
 Mon, 20 Apr 2026 09:35:10 -0700 (PDT)
X-Received: by 2002:a17:902:db11:b0:2b2:5070:8b with SMTP id
 d9443c01a7336-2b5f9da50b3mr128466045ad.1.1776702909591; 
 Mon, 20 Apr 2026 09:35:09 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa326f5sm102751225ad.32.2026.04.20.09.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:35:09 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, andrew.goodbody@linaro.org,
 swboyd@chromium.org, gurumoorthy.santhakumar@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] serial: msm-geni: configure RX watermark register
Date: Mon, 20 Apr 2026 22:05:00 +0530
Message-Id: <20260420163500.4138411-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: J3wsziB5zB3fs-Q_ASphUzxE5qKCFJIE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE1OSBTYWx0ZWRfX8zphEsPmGn6j
 0lLSP+Cal372zUp3jFltJmRmvUqYFU4snSKvtvYaXUOzggu0nyo0loFBRTvT8OeF9b8Ia9udIPa
 DTJvs4ZAiFgHT781B+OpYnpgf4KXWcULwDuK8Fls7K4TRvVIqSap4+A28sYTypaKvNgCnMKbp1O
 wEdPor+9mdXILfyX8QES9ILQagPnIMDKtCbvmWec/ZgTOaV+YTRNFT02t+bjoxlCiHTvB5O2sly
 Ca6e9DzJ4zdV6+ZPHLoqzVObW7MtH9fyzACfn1zW4Kt4pCMz59zqQ6/G7W4IMRwB8sGeBzJiFHu
 wRpRognV4gAHD3BkB1EbbSUAGDKu9VXRv6yylaFZ409eqCaFbjnTFgYsQnANxpzbSCzDu3iVN8v
 gdFQU5Dwe+v6pVoG+p82tB5m+9hUxEKXkL9zF60kfY1c1QHYYE2hKo8crj6W8c8XYSYhW21rOIU
 iayi5lpi7v4lDxigBvw==
X-Authority-Analysis: v=2.4 cv=XNMAjwhE c=1 sm=1 tr=0 ts=69e655bf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=EUspDBNiAAAA:8 a=JQEU1KsGukfSeQCV5iwA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: J3wsziB5zB3fs-Q_ASphUzxE5qKCFJIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200159
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

The SE_GENI_RX_WATERMARK_REG was not being programmed in the RX
setup paths. Set it to DEF_RX_WM (2) in qcom_geni_serial_start_rx(),
msm_geni_serial_setup_rx() and _debug_uart_init() to align with the
Linux kernel driver behaviour.

Without this, the RX FIFO watermark interrupt threshold is left at
its hardware reset value, which may differ from the expected value
and can cause RX data loss or missed watermark interrupts.

Link: https://lore.kernel.org/all/20200227132223.864425794@linuxfoundation.org/
Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 drivers/serial/serial_msm_geni.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 3dca581f68f..ae4015e0fdc 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -55,6 +55,7 @@
 #define SE_UART_RX_PARITY_CFG	0x2a8
 
 #define DEF_TX_WM	2
+#define DEF_RX_WM	2
 /* GENI_FORCE_DEFAULT_REG fields */
 
 #define UART_START_READ	0x1
@@ -345,6 +346,7 @@ static void qcom_geni_serial_start_rx(struct udevice *dev)
 
 	geni_se_setup_s_cmd(priv->base, UART_START_READ, 0);
 
+	writel(DEF_RX_WM, priv->base + SE_GENI_RX_WATERMARK_REG);
 	setbits_le32(priv->base + SE_GENI_S_IRQ_EN, S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
 	setbits_le32(priv->base + SE_GENI_M_IRQ_EN, M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
 }
@@ -373,6 +375,7 @@ static void msm_geni_serial_setup_rx(struct udevice *dev)
 
 	geni_se_setup_s_cmd(priv->base, UART_START_READ, 0);
 
+	writel(DEF_RX_WM, priv->base + SE_GENI_RX_WATERMARK_REG);
 	setbits_le32(priv->base + SE_GENI_S_IRQ_EN, S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
 	setbits_le32(priv->base + SE_GENI_M_IRQ_EN, M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
 }
@@ -616,6 +619,7 @@ static inline void _debug_uart_init(void)
 	phys_addr_t base = CONFIG_VAL(DEBUG_UART_BASE);
 
 	geni_serial_init(&init_dev);
+	writel(DEF_RX_WM, base + SE_GENI_RX_WATERMARK_REG);
 	geni_serial_baud(base, CLK_DIV, CONFIG_BAUDRATE);
 	qcom_geni_serial_start_tx(base);
 }
-- 
2.34.1

