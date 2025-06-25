Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FA1C7EE30
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 11:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D699E82977;
	Wed, 25 Jun 2025 13:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TfmD+3AE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A5C38006D; Wed, 25 Jun 2025 11:46:22 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58928006D
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 11:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gopinath.sekar@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P1pLmv001165
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 09:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=vIK9Ycw2+zNrSNz8tD3ycyRdm0B3i9KN/86
 fCkRnaxo=; b=TfmD+3AENAgd8oJEY0iZeR7t/dpnLdqpTLY6flUeGfZoyFycL2N
 2q0ebiuoXqMg3XQA3AOyagVJMqbdYaaj2C5R5uzd3NIGjzSHJsMHs19Jh2gb44/a
 cSS3Y62hzsTpaSwFhPszlthk8HT4NlDRmpQV7Z7zeJ+NMOt0kb5OmHRwGNtoa8mV
 5XBl9ziFk50otzXTBA9yh0ZhLgs0DVcWm+W5LcthzxVTKZTbr4eVslD5Xg0jW+gm
 67uxpQw2app0T1J5cHXSw4uRtWX+LEvvjh5gr+yp4EehoK5i9HUzYTX5pMkvtd0I
 QHeXnOKSbpHrIvxltJCZatAt9kEo0mM4saA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g7td97fu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 09:46:18 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-748f569321eso137547b3a.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 02:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750844777; x=1751449577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vIK9Ycw2+zNrSNz8tD3ycyRdm0B3i9KN/86fCkRnaxo=;
 b=Wr26mJQ4iU2dTKZ1N7CcbO0KT+GaCfb55CfUpAuW0jxxsvsXT3dnSLSxmXaSZhhvMs
 tdWJWgaWU4FiktjudpTUxYIMStgtTLANkT8q/x8sUuarFInlbp9u/L82TFCOayBZB7NJ
 klknDbs/K4CnQhienMtVynguZCjgaHxCf3005Qitd8pEmZFxYas2fIxfhVIuVneHTau0
 srMSp5AhlvfLh/Hi8hftf3wQ//um+zKgGSgUo2tVro8xHKYCJtpKFjxlUhJM6lMi1MAZ
 jA7W+VQT4GCXC75vTuwrAwl5E1JhwzFsf3wZeY5Qsf4djNjGX1CGrc2/S1YCxoOmw3Uy
 dSRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu2Th+5I1l693qxKL4tpMZnd2TR8/jZhNi+GPdpMiYtmCgmb1xBKHKhKbblFVFbeDbszJcmiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwuMBcQqumK7TdzVgrIq6g+ecTTlQoxsiNvpvaG9OOfNIeS+VqR
 wsT0hfT6DHgQmbIvgXQt/TIUW2GEtbj9c+87GitU0a2zMrrQlVOKiJPE4q9ERuo9mjQ1T5j3bjg
 UC+JqofVciJmBKoTR7LfLHyoLPHGf1zUwBU0oIt8ySBndHEViuhETLXxl
X-Gm-Gg: ASbGnctko3Y7OC3tNzGM+vVdeYaiYUgOFwcYcS6Gt1cEJKlHFxtou54r6CzRaddW4Fs
 MLbsGSSSV/Wa9DxCG0HYq5BmcpetM5qU/v+8VRKkq4oL+UCM4lx67gQl0fVVj7SPvuMNehkMJeS
 P58428/kq+2PAk/kQIio46GvlF9zWMxrDDDHPMzPubRVg7LdRdZ4Yzo0/rJd/i+dxf2A/Nk3A6q
 DjcNYinTg1buGhYkaNUt0UkKQT72byisP8vxAaKwqB48Jq87YXSOfcvUZ+u36OzMQG4tsGg1uy0
 mQPCkpE1kHfHckG6OuR2MX92nO9Zce1ujf2cPJfzqedknwj8GsiTmBsiu2eokK4FzkQm/V8DERO
 N7vTWE7ayOy3YOiSEBPcUZ5OD6vx55QyQIbFHdLa/lr4=
X-Received: by 2002:a05:6a00:a1f:b0:736:559f:eca9 with SMTP id
 d2e1a72fcca58-74ad4502b5bmr1512466b3a.3.1750844777083; 
 Wed, 25 Jun 2025 02:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY6+QDYen0yMCQDGng1lUt/O2Se+kNaz8rQ2CK9pQ8uYLEBtUgk6916oBC7l23qCSDqBwnnw==
X-Received: by 2002:a05:6a00:a1f:b0:736:559f:eca9 with SMTP id
 d2e1a72fcca58-74ad4502b5bmr1512448b3a.3.1750844776633; 
 Wed, 25 Jun 2025 02:46:16 -0700 (PDT)
Received: from hu-gsekar-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e33386sm4174126b3a.61.2025.06.25.02.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 02:46:15 -0700 (PDT)
From: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
To: sr@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 gopinath.sekar@oss.qualcomm.com, hello@paulsajna.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v2] watchdog: qcom: Add max timeout check to prevent overflow
Date: Wed, 25 Jun 2025 15:16:07 +0530
Message-Id: <20250625094607.1348494-1-gopinath.sekar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CPYqXQrD c=1 sm=1 tr=0 ts=685bc56a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u984uYcrE88PmdX7pXQA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3MyBTYWx0ZWRfX+I1mtguXJA6H
 HvV/yecfSVYrU1fxDy3HzzgUhEPQiIgyfHkUL+ing/yGJKhNdEmVQkdr8kjipSSBNM+Oqw8oF4c
 Yzh90K7GIdLm0Hnw9AkXyX+MAf7mKi9uNW0H+vPB2HX8avhm62Td3lbJtSEWQGKBQk2D0IEwUgB
 iGpPJDY/F259YpoqKZtPU1E+0U4nXm67WrT1RgX+w0JlxstnOYmS6Wbt9YZHMwmtn0WAEM+et8p
 juhNtepODu2UiiPVZLOePbqT3ELcUfVuxZoQPxpFuMROiVWgKI7nv7eH4QlXW2KEkVjjAcHJpUM
 XzV0sS5kDwlxlXWzHAjTN73EXWITd6iRNCm1bN3vtZsR+nRDGILF2dz1cy9aQtYzPdL41iTW6Py
 06iCQvLa+Y7zvuFJMO3gR1gVmuPoKMiGeVPcYRyDu+5+Ljc6zP2v6DuJWARadqRv5fThWncz
X-Proofpoint-GUID: mYYtNnJtG1Akkbd60rHFWo6xnMlRBhka
X-Proofpoint-ORIG-GUID: mYYtNnJtG1Akkbd60rHFWo6xnMlRBhka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250073
X-Mailman-Approved-At: Wed, 25 Jun 2025 13:11:18 +0200
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

Added a check to ensure the requested timeout does not exceed the
hardware's maximum supported value. This prevents register overflow
and ensures watchdog reliability.

So, added a check in qcom_wdt_start() to ensure the requested timeout
does not exceed the hardware-supported maximum value. If the requested
value exceeds the maximum value, then the timeout is clamped
at maximum value.

The timeout is first converted to watchdog ticks and then compared
against QCOM_WDT_MAX_TIMEOUT. This helps prevent misconfiguration
and potential watchdog misbehavior due to overflow.

QCOM_WDT_MAX_TIMEOUT is set to 0xFFFFF, as Qualcomm SoCs typically
use 20 bits to store bark/bite timeout values.

This work builds upon the previous submission:
https://lore.kernel.org/u-boot/20250527124926.128413-1-balaji.selvanathan@oss.qualcomm.com/

Signed-off-by: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
---
Changes in v2:
- Made changes to clamp the timeout value at SOC supported max value
  if the requested timeout value is greater than max value.
- Link to v1: https://lore.kernel.org/u-boot/20250624061907.3893511-1-gopinath.sekar@oss.qualcomm.com/
---
 drivers/watchdog/qcom-wdt.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index adbb5aacdc3..af97b27e311 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -17,6 +17,9 @@
 
 #include <asm/io.h>
 
+/* Maximum allowed timeout value in Qcom SoCs*/
+#define QCOM_WDT_MAX_TIMEOUT	0xfffff
+
 enum wdt_reg {
 	WDT_RST,
 	WDT_EN,
@@ -55,8 +58,24 @@ static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
 int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
 	struct qcom_wdt *wdt = dev_get_priv(dev);
-	ulong bark_timeout_s = ((timeout_ms - 1)  * wdt->clk_rate) / 1000;
-	ulong bite_timeout_s = (timeout_ms * wdt->clk_rate) / 1000;
+	u64 tmp_timeout;
+	u32 bark_timeout_s, bite_timeout_s;
+
+	/* Compute timeout in watchdog ticks */
+	tmp_timeout = (timeout_ms * (u64)wdt->clk_rate) / 1000;
+	if (tmp_timeout > QCOM_WDT_MAX_TIMEOUT) {
+		dev_warn(dev,
+			 "Requested timeout (%llu ms) exceeds maximum allowed value (%llu ms). "
+			 "Using max timeout instead.\n",
+			 timeout_ms,
+			 ((u64)QCOM_WDT_MAX_TIMEOUT * 1000) / wdt->clk_rate);
+		tmp_timeout = (u32)QCOM_WDT_MAX_TIMEOUT;
+		timeout_ms = (tmp_timeout * 1000) / wdt->clk_rate;
+	}
+
+	bite_timeout_s = (u32)tmp_timeout;
+	tmp_timeout = ((timeout_ms - 1) * (u64)wdt->clk_rate) / 1000;
+	bark_timeout_s = (u32)tmp_timeout;
 
 	writel(0, wdt_addr(wdt, WDT_EN));
 	writel(BIT(0), wdt_addr(wdt, WDT_RST));
-- 
2.34.1

