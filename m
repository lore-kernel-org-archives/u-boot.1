Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D442C021B0
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 07:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C7780F6F;
	Thu, 20 Feb 2025 08:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="fxkE+jcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE4D80F5C; Thu, 20 Feb 2025 08:40:33 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9063D80F9E
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6Ww6r002627;
 Thu, 20 Feb 2025 07:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TmLnoZp+vGJOGey8KWkFIhbd13S3bjl7rjOt5gHp+L4=; b=fxkE+jcHQng+pYC9
 Clj8AOk6VRKnzJD+/Ua7Mj0ysbyJlYVlUIs/gKq58F0AFWsLcCSli+6jBFqOh0dD
 3yi+SYc6k7xhPCNdGmBa+mj4mmn4dXJFnQ9+LzVSht/I90Qki8/nSKh3wisiixyD
 f8AYE1SHka2wwWGxoTAx1B7vLdcvCl+vfmUo9gdjrve7FjlkOK7Dv/w3qlfDc3Fb
 S11/6833D9AYaeUOi3ShxSsPEC4DN5rozUk/f4wXD9Z5uMsxUuCKkhGN0IFZIEeC
 oppfDiGgoliGjDt+zTZGx+b29Ehg1TUaF9Hi1STo3GnkV79q23riLU3y9u3JV3X0
 5T0DFw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy2da46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 07:40:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K7eFti003375
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 07:40:15 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Feb 2025 23:40:10 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <Volodymyr_Babchuk@epam.com>,
 <sjg@chromium.org>, <lehmanju@devpi.de>, <pbrobinson@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: [PATCH v4 4/7] pinctrl: qcom: Handle get_function_mux failure
Date: Thu, 20 Feb 2025 13:09:34 +0530
Message-ID: <20250220073937.133687-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220073937.133687-1-quic_varada@quicinc.com>
References: <20250220073937.133687-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: fzlP8KQML1xGAe28j1oT8EOV-37igI45
X-Proofpoint-GUID: fzlP8KQML1xGAe28j1oT8EOV-37igI45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200054
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

Presently, get_function_mux returns an unsigned int and cannot
differentiate between failure and correct function value. Change its
return type to int and check for failure in the caller.

Additionally, updated drivers/pinctrl/qcom/pinctrl-*.c to accommodate the
above return type change. Only compile test done.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-apq8016.c  | 4 ++--
 drivers/pinctrl/qcom/pinctrl-apq8096.c  | 4 ++--
 drivers/pinctrl/qcom/pinctrl-ipq4019.c  | 3 +--
 drivers/pinctrl/qcom/pinctrl-qcm2290.c  | 2 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c     | 5 ++++-
 drivers/pinctrl/qcom/pinctrl-qcom.h     | 3 +--
 drivers/pinctrl/qcom/pinctrl-qcs404.c   | 4 ++--
 drivers/pinctrl/qcom/pinctrl-sdm845.c   | 4 ++--
 drivers/pinctrl/qcom/pinctrl-sm6115.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8150.c   | 4 ++--
 drivers/pinctrl/qcom/pinctrl-sm8250.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8550.c   | 4 ++--
 drivers/pinctrl/qcom/pinctrl-sm8650.c   | 4 ++--
 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 4 ++--
 14 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index 0c7437822f..9ae07d43d9 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -50,8 +50,8 @@ static const char *apq8016_get_pin_name(struct udevice *dev,
 	}
 }
 
-static unsigned int apq8016_get_function_mux(__maybe_unused unsigned int pin,
-					     unsigned int selector)
+static int apq8016_get_function_mux(__maybe_unused unsigned int pin,
+				    unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
index 132ece868b..eaa927c6e2 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
@@ -43,8 +43,8 @@ static const char *apq8096_get_pin_name(struct udevice *dev,
 	}
 }
 
-static unsigned int apq8096_get_function_mux(__maybe_unused unsigned int pin,
-					     unsigned int selector)
+static int apq8096_get_function_mux(__maybe_unused unsigned int pin,
+				    unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
index 3215c677b2..dafcd494df 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
@@ -311,8 +311,7 @@ static const char *ipq4019_get_pin_name(struct udevice *dev,
 	return pin_name;
 }
 
-static unsigned int ipq4019_get_function_mux(unsigned int pin,
-					     unsigned int selector)
+static int ipq4019_get_function_mux(unsigned int pin, unsigned int selector)
 {
 	unsigned int i;
 	const msm_pin_function *func = ipq4019_pin_functions + pin;
diff --git a/drivers/pinctrl/qcom/pinctrl-qcm2290.c b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
index af969e177d..0c2222ce66 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcm2290.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
@@ -38,7 +38,7 @@ static const char *qcm2290_get_pin_name(struct udevice *dev, unsigned int select
 	return pin_name;
 }
 
-static unsigned int qcm2290_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+static int qcm2290_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index 26a3fba194..24d031947a 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -92,7 +92,10 @@ static int msm_pinmux_set(struct udevice *dev, unsigned int pin_selector,
 			  unsigned int func_selector)
 {
 	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
-	u32 func = priv->data->get_function_mux(pin_selector, func_selector);
+	int func = priv->data->get_function_mux(pin_selector, func_selector);
+
+	if (func < 0)
+		return func;
 
 	/* Always NOP for special pins, assume they're in the correct state */
 	if (qcom_is_special_pin(&priv->data->pin_data, pin_selector))
diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.h b/drivers/pinctrl/qcom/pinctrl-qcom.h
index 49b7bfbc00..cd167e6386 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.h
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.h
@@ -18,8 +18,7 @@ struct msm_pinctrl_data {
 	int functions_count;
 	const char *(*get_function_name)(struct udevice *dev,
 					 unsigned int selector);
-	unsigned int (*get_function_mux)(unsigned int pin,
-					 unsigned int selector);
+	int (*get_function_mux)(unsigned int pin, unsigned int selector);
 	const char *(*get_pin_name)(struct udevice *dev,
 				    unsigned int selector);
 };
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
index fb6defaedd..c272595aa2 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -93,8 +93,8 @@ static const char *qcs404_get_pin_name(struct udevice *dev,
 	}
 }
 
-static unsigned int qcs404_get_function_mux(__maybe_unused unsigned int pin,
-					    unsigned int selector)
+static int qcs404_get_function_mux(__maybe_unused unsigned int pin,
+				   unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index f1a23f5109..3f55fc81c8 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -80,8 +80,8 @@ static const char *sdm845_get_pin_name(struct udevice *dev,
 	return pin_name;
 }
 
-static unsigned int sdm845_get_function_mux(__maybe_unused unsigned int pin,
-					    unsigned int selector)
+static int sdm845_get_function_mux(__maybe_unused unsigned int pin,
+				   unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-sm6115.c b/drivers/pinctrl/qcom/pinctrl-sm6115.c
index f07f39f4ac..7e80ea39a1 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm6115.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm6115.c
@@ -167,7 +167,7 @@ static const char *sm6115_get_pin_name(struct udevice *dev, unsigned int selecto
 	return pin_name;
 }
 
-static unsigned int sm6115_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+static int sm6115_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
index 1fb2ffb959..fe789e8639 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8150.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
@@ -123,8 +123,8 @@ static const char *sm8150_get_pin_name(struct udevice *dev,
 	return pin_name;
 }
 
-static unsigned int sm8150_get_function_mux(__maybe_unused unsigned int pin,
-					    unsigned int selector)
+static int sm8150_get_function_mux(__maybe_unused unsigned int pin,
+				   unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250.c b/drivers/pinctrl/qcom/pinctrl-sm8250.c
index cab42fa64e..992366250c 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8250.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8250.c
@@ -99,7 +99,7 @@ static const char *sm8250_get_pin_name(struct udevice *dev, unsigned int selecto
 	return pin_name;
 }
 
-static unsigned int sm8250_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
+static int sm8250_get_function_mux(__maybe_unused unsigned int pin, unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550.c b/drivers/pinctrl/qcom/pinctrl-sm8550.c
index 25b972a6d8..f7fcad0e4a 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8550.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8550.c
@@ -68,8 +68,8 @@ static const char *sm8550_get_pin_name(struct udevice *dev,
 	return pin_name;
 }
 
-static unsigned int sm8550_get_function_mux(__maybe_unused unsigned int pin,
-					    unsigned int selector)
+static int sm8550_get_function_mux(__maybe_unused unsigned int pin,
+				   unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8650.c b/drivers/pinctrl/qcom/pinctrl-sm8650.c
index 9146d6abd9..6b9d56b105 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8650.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8650.c
@@ -69,8 +69,8 @@ static const char *sm8650_get_pin_name(struct udevice *dev,
 	return pin_name;
 }
 
-static unsigned int sm8650_get_function_mux(__maybe_unused unsigned int pin,
-					    unsigned int selector)
+static int sm8650_get_function_mux(__maybe_unused unsigned int pin,
+				   unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
index f39dc426d6..319667bfc1 100644
--- a/drivers/pinctrl/qcom/pinctrl-x1e80100.c
+++ b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
@@ -72,8 +72,8 @@ static const char *x1e80100_get_pin_name(struct udevice *dev,
 	return pin_name;
 }
 
-static unsigned int x1e80100_get_function_mux(__maybe_unused unsigned int pin,
-					      unsigned int selector)
+static int x1e80100_get_function_mux(__maybe_unused unsigned int pin,
+				     unsigned int selector)
 {
 	return msm_pinctrl_functions[selector].val;
 }
-- 
2.34.1

