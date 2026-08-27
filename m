Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF8BC61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F8D980D4F;
	Thu, 27 Aug 2026 07:34:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VHxJsDfMRAsz; Thu, 27 Aug 2026 07:34:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816097;
	bh=NBBGj3pwrj1yB7HW8yIm4c8gAAvs1p7o7YZsqUwYXZc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=01jgCIKuEAZWqFP5NUjKid7ECSBQiDmqtTFazRu/l8RZsb3Y0JsuldpXsJFcUFDAe
	 d8sBCd3Y1NvjWK4wfmUoK787xuaAqtaEBKb2BOtkU+3TVgDegK/LYUFiTxLoyhXkoq
	 MWPDvXb5BF8HR9FMK4PPzaqQtrzHLzqdsfo5lorkLXS8GeWPdUOzt1w4ZMaH7w9pm5
	 lEVkWgNqsScMUP5VUylbHYse+q9BSv8McY/XnyJO2iYZSTHmyIzHYKlXZnh75gBPOE
	 /fgWvFOr61u25jSsUoxTMPoHSrRNQlzY6KQ7750lMRRer2L9Xo9TAOp9pxL4qy62Uo
	 62qTAV5Hiwtkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56A3280D3F;
	Thu, 27 Aug 2026 07:34:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6568539E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 548F360770
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yk_1r2AmUD3l for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:34:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XXwj9g6B; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ztlm8yTE
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BDDF6076B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R3mD3039387
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NBBGj3pwrj1
 yB7HW8yIm4c8gAAvs1p7o7YZsqUwYXZc=; b=XXwj9g6BANQ4z0yQ0gAAolS9oIP
 iseDGoG8nnk0QpJeUSFNnxvDSRmmHAsOpM3fDAGRUbKHQss9zAVid4SD0UrR9nXK
 K3gC4GfLQtH61ig46XTXuhupqLstNnU9Iy6KvLhv2KiTuJFrTCwnWSIioAkK9+aK
 QwP9CY2YsKwJ5Bvf9FehtqGNtS6VYQIfqQmELJ3Blca5adWCtcfQ9Gc35bTMlo0A
 SJtZUe+R5ZNyXX11nQZ5ubHKBoC6sLjqYTm5fBcSBRZ3yHaq3SayH8XKnV5NBfmf
 /0XG91CyIhUiz1N6BC1+WsNJ6DEMs8ebPmqOD4mwtJ6Uaow8HgnBa135kJw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03abt2q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:53 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbbb9c9bfc3so1619070a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787816093; x=1788420893;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NBBGj3pwrj1yB7HW8yIm4c8gAAvs1p7o7YZsqUwYXZc=;
 b=Ztlm8yTEA/TFqJawJmC/OANgGcR3+GKVt82u314WxTU0F5WyDWOZNB7dpy/pAGAI53
 PGahzFgKcNq1b+iSJNkOPiQVD2qhQKXmUF/BCaiboh5WMyTbvAP/P/gPHabzEbk4HYoo
 HiE+2Oqjp+XXLKsrDS48+RtinvmjXdvdsw1cB17UnbZDV7i6d0X/6hHJLWZfJbRpnwbx
 Q2XjAMo0O5KgbpDdr/U+OD0K2o8dBhIJyFf20j7g7c5e3OW6bTXg8NCeuCar9pZeb0Tq
 dUjAX/2kHnVQZGXWse5MIJGL2gRagtvJ3hGCHml1sPOwjsRro2lhbvwdHzCs0DulCNKN
 ODeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816093; x=1788420893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NBBGj3pwrj1yB7HW8yIm4c8gAAvs1p7o7YZsqUwYXZc=;
 b=LqXo+BAx1Dr3UzXA+ZU+eGemmLGIWC0XM5rSDxDYAy2T92cm/mi1ubm/yLZBScWcJ0
 XcIGUG8M1IJeOXWuyaytuB+EtnQL3u13yOTGUw0Zbw/Og4XiESw1zJCdUL3ryJOtJjLL
 82y7xQ+pB893e4ZlwebH2Od9a4EmuJYiMfJRe/0jU9G5Qkc5LHE2EuB1WOd6NmB8ES9L
 meKIyCUO8/83p2bkmEOAJwem4QDfk9wfrJ0u4AanqCTwf9++TpDze7+a9yvKLXQba+nz
 EE/wJUKNXByrFN3syuoVk7QX8W0APE3AH9OEBkVm8sGp4qGCK3LCiWl4sPVggX74gPsm
 /dHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/ak4b8PAE6D6qeD1WJSMg5S68CJB3Dn/P4sGw4z8FnEKgGW77Fxj8SG66uvR0O2qrkQ71X4s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kv45SjAtw7eTwsf0cUTlH11g9WvbHHTmblTswUk9iUiJv5eZQE
 O5LJalehcuBQtZ2ddUI3FiwmjtQofmR67cctRvfg2AeMuUj00vKeoJmYXvUntfPSNmIalYnlzTB
 G3tTwOnUXPKsby1VVVz8WYPrtDmjOAdZGAdYMgt4iDrqlQZdwtnJvUbc5A6DUgY4nuU9LQ8c=
X-Gm-Gg: AR+sD10X8KR1kVq8A8ph6JMwep07LICQ3fMJZbxzN6PkdxYx8unxA6y5dsuCKgdzs3t
 Gqc55qvMhxFo/ofdBrR6e+yWUtQtGWqrkT5GGqv/GqiBmFAoABhPa+e7dvcsaNAY1Nd23d92y2p
 BLDry0MXXBzWFMA0hKMhQzzv1363vcgHf/g32aOVLL5h2hQ3QkNnKhoAUsca9b8sjzcj795c6Rl
 8RjBP/Fwj5LOzObjRBoMS2kgGor/CBqbjhI7oUX3eX+LpamqeYNRsIxQtoicHgeiepoeNAtAHuT
 BEa7/JJZISYXi8L8j5qo5RZ1RGidWacawyOU8A15QSZ7IzVlkEvIfT/QlO1Z6nNMZ7wFAlIBDh1
 1dap4xBPx5XamcpSvBu6VhcsU+zLG0psGnlmdM4LPV1ibIukq8KvISlua9p9ti5Gwj94mnT8OqD
 8P74kyTuJL08fHyaYT35U=
X-Received: by 2002:a05:6a20:430b:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3cf84e51a6fmr21547630637.17.1787816092537; 
 Thu, 27 Aug 2026 00:34:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:430b:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3cf84e51a6fmr21547541637.17.1787816092014; 
 Thu, 27 Aug 2026 00:34:52 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d886256sm17981719eec.16.2026.08.27.00.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:34:51 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, stefan.roese@mailbox.org, xypron.glpk@gmx.de,
 jbx6244@gmail.com, hehongbo918@gmail.com, quic_timple@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1 1/2] serial: msm_geni: Skip UART TX when no cable is
 connected
Date: Thu, 27 Aug 2026 13:04:35 +0530
Message-Id: <20260827073436.4113558-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827073436.4113558-1-aswin.murugan@oss.qualcomm.com>
References: <20260827073436.4113558-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: n432tBEqVG7wbfuEEn6uCHIpivDW78jm
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8fe89d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=113EMbRxfQZ4BKd80b0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: n432tBEqVG7wbfuEEn6uCHIpivDW78jm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfXx5tjP60b2h60
 wB5FqfqTMP/mW+YE5Rv0LuXgHOJy0DInsCkRbzQwfvwxudkcsBlirHAP0l1K3kik09npHlPsdxm
 41L/1pB5PvT1KeNjccBkCv8COazr3VhBz5XE63z5LDhC0RvpH/ZXoAGnHrDEN7Vy9PFWtjF8vrn
 tal5UaNqGWsm0air9Qe+E2602njEgq+jcCPAfLvmVh2tKVLybNWn8o7IzKeiKK5UxHvthBjUMY/
 W5qbajtaFvipyUyyPtHYG1K6ouddudr6zuoEKhC5FaVXU58yFBp5Whk1Z8esPetxPFVv1tJ3Lt/
 V5lEqvqOLMymCyTm0H5ILo/XA++Xt4esmS2LdXGtYKMneXss+AZeTvTW6t2JVnN4+/fGevULjKY
 M12Z/Msbg15VJPj0/VB/wB1ndkBVLvpsp4hkx2XodFHjjwOdVsi7NYR0Ibd5i7tIuNPKtOXGGEH
 0Lj0EZBgeDPGOAFgnWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX2qNvd/7+VDo+
 Oxu+tW9Uir7eCNjqOcyUvfh1rlcS7cRGODsyD0+Wi8JWmkDE3FUqMlnZgd1IAEc6DxKrUZ5y0Jv
 6JJWmTqJxmfY7LDa0nPWOiU1/Ei5mu4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270061
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

Add MSM_GENI_SERIAL_CABLE_DETECT Kconfig option and detect a
persistent RX-line BREAK condition (no S_GP_IRQ_3 after
S_GP_IRQ_2) to identify a disconnected debug UART cable, and
suppress TX output in that case to avoid driving an
unterminated line.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/serial/Kconfig           |  9 +++++++
 drivers/serial/serial_msm_geni.c | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ffc58d663ff..326088c7027 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1020,6 +1020,15 @@ config MSM_GENI_SERIAL
 	  Driver works in FIFO mode.
 	  Multiple baudrates supported.
 
+config MSM_GENI_SERIAL_CABLE_DETECT
+	bool "Disable GENI UART TX when no cable/console is connected"
+	depends on MSM_GENI_SERIAL
+	default n
+	help
+	  Detect a UART RX-line BREAK condition, which indicates that no
+	  cable is connected to the debug UART port, and suppress UART TX
+	  output.
+
 config MXS_AUART_SERIAL
 	bool "MXS AUART"
 	depends on DM_SERIAL
diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index ff91e0018fa..8bf5f6eea26 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -98,6 +98,7 @@ struct msm_serial_data {
 	u32 baud;
 	u32 oversampling;
 	struct clk *se;
+	bool cable_connected;
 };
 
 unsigned long root_freq[] = {7372800,  14745600, 19200000, 29491200,
@@ -298,6 +299,28 @@ static u32 qcom_geni_serial_tx_empty(u64 base)
 	return !readl(base + SE_GENI_TX_FIFO_STATUS);
 }
 
+/**
+ * qcom_geni_serial_is_cable_connected() - Check UART RX-line BREAK condition.
+ * @base:	Pointer to the concerned serial engine.
+ *
+ * A serial cable that is not connected leaves the RX line in a state that
+ * the UART hardware reports as a BREAK condition that never ends, i.e.
+ * S_GP_IRQ_2 (RX_BREAK_START) gets set without a following S_GP_IRQ_3
+ * (RX_BREAK_END). This function checks the secondary sequencer IRQ status
+ * for that pattern.
+ *
+ * Return: false, if no cable is connected, true otherwise.
+ */
+static bool qcom_geni_serial_is_cable_connected(u64 base)
+{
+	u32 s_irq_status = readl(base + SE_GENI_S_IRQ_STATUS);
+
+	if ((s_irq_status & S_GP_IRQ_2_EN) && !(s_irq_status & S_GP_IRQ_3_EN))
+		return false;
+
+	return true;
+}
+
 /**
  * geni_se_setup_s_cmd() - Setup the secondary sequencer
  * @se:		Pointer to the concerned serial engine.
@@ -384,6 +407,10 @@ static int msm_serial_putc(struct udevice *dev, const char ch)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
 
+	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT) &&
+	    !priv->cable_connected)
+		return 0;
+
 	writel(DEF_TX_WM, priv->base + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(priv->base, 1);
 
@@ -565,6 +592,11 @@ static int msm_serial_probe(struct udevice *dev)
 	qcom_geni_serial_start_rx(dev);
 	qcom_geni_serial_start_tx(priv->base);
 
+	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT))
+		priv->cable_connected = qcom_geni_serial_is_cable_connected(priv->base);
+	else
+		priv->cable_connected = true;
+
 	return 0;
 }
 
@@ -615,6 +647,8 @@ static struct udevice init_dev = {
 #error Clocks cannot be set at early debug. Change CONFIG_BAUDRATE
 #endif
 
+static bool debug_uart_cable_connected = true;
+
 static inline void _debug_uart_init(void)
 {
 	phys_addr_t base = CONFIG_VAL(DEBUG_UART_BASE);
@@ -623,12 +657,19 @@ static inline void _debug_uart_init(void)
 	writel(DEF_RX_WM, base + SE_GENI_RX_WATERMARK_REG);
 	geni_serial_baud(base, CLK_DIV, CONFIG_BAUDRATE);
 	qcom_geni_serial_start_tx(base);
+
+	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT))
+		debug_uart_cable_connected = qcom_geni_serial_is_cable_connected(base);
 }
 
 static inline void _debug_uart_putc(int ch)
 {
 	phys_addr_t base = CONFIG_VAL(DEBUG_UART_BASE);
 
+	if (CONFIG_IS_ENABLED(MSM_GENI_SERIAL_CABLE_DETECT) &&
+	    !debug_uart_cable_connected)
+		return;
+
 	writel(DEF_TX_WM, base + SE_GENI_TX_WATERMARK_REG);
 	qcom_geni_serial_setup_tx(base, 1);
 	qcom_geni_serial_poll_bit(&init_dev, SE_GENI_M_IRQ_STATUS,
-- 
2.34.1

