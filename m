Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5260C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 07:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFD582C4C;
	Tue, 24 Jun 2025 09:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jks5rUsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 905E782BCD; Tue, 24 Jun 2025 08:19:27 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6CF681F66
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 08:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gopinath.sekar@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NI0dtu008761
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 06:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=p2XTHHM+Hw8cJnDvf6Luvc5UDsF2hb2R6PH
 Vh4VVuf8=; b=Jks5rUsxfvDqxE+g0Oav3eSIstri9ta57p851+jpct3eRaXF5vK
 /tlydb3Q/stucV10Njqb0haX/QnGp7SdL6sB1ldmyqd63nABjeA4pGPXZ8eR3vUg
 KjV+vs7brHZ54mU0QVwc8IMPr7qiNIWN7qTkyM7IWmXHaRnnTTsT7CiULy+oEnEe
 i6dCpZGpfgHCQWQPMYy3ilc5YmVlo9uUzZmnj6Qs9tY3bW0Xx7QhdNh1SddRWsO5
 d2wOc61MFxycLpFXjZY9xBps9a3YB7DiJJlWKwZMWLe9XJxW/o7xx9ZlBXQQUxH6
 Gk6om13xHqpmcYPh1A29R12Sag84FxWWFsw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmmnme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 06:19:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3132c0c961cso1195821a91.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 23:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750745962; x=1751350762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p2XTHHM+Hw8cJnDvf6Luvc5UDsF2hb2R6PHVh4VVuf8=;
 b=CQpkFMENULmfYGat2tZagiK9k9qWldYCC8dHxnaVo9sju05o8N0tAnJjs14gKlW/fu
 JCag1RM/VGTgz6CFnwiKIe55T5Bmy032jRDUmYsZJ3Xs0sqSQuu3fretXXcaYy9cAWOF
 a/SsXyFPxZhrLKaI4eCQo+Kk04BVnCa1gsv/9qZbh9A7v6Rml0iWIhP4P8tkZKJksQte
 fgRxaXLpKsJLqkayz8MWvkHrQ0Hje0oYQ3bzOUFuXOPe5Tn0NnaNVIqA1GgLu3ZN3Xq5
 a5d7F9IdDZjRUM8u1U5lbgFfWX/Y+h5vdh0n0EkPmpVBxuExtJss70MBKNWYWwT+epMd
 34Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY94t6BG/UVXSNQ8xPwxcz8rSZwGUP/D1GArHs33W70B4BUgjExB67480ZyXezDtvKfFVMMuQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzmmn7GhW8oOqt5Hds71XN+ZOaUWvMd+jvORSjqjGN2zysDYQ0B
 46zzkHiNd3lKpKZ+UjlBO0Npbvke8aBaaB+p2b77FCEiMwTu8fCo1rfUS0Va57YFC9OHKg+EXYx
 T+CNKgCUNPhXn9SteEL1x7hVMsGkOVXh3YgF8GWjRmPWYMNoRoO38P7RQ
X-Gm-Gg: ASbGncsSHuQ2kliUKMjIjf+virboy7f07ko/4QNr3wZ0e0lB3TyVyUKdpnZl7I0A4yR
 WfjVYplTPTfRoLY1Eagh281xPGENQYpAZrg7hoLT1GxWST4P0bHsFOVHRuMgxq0d2I527AUcMfW
 vbPAHdV6IfcLgLKO15JLXbPZ63M03WmKEt6UM1KIPSFkEhd2DZQtolXzSMPFg7IKTT4GJ7fyO7g
 XhQmdp1xAar7ai7Ya3RkheyyvOTFObc5JKTRSWksVJoX8v8sAC4Y0vO7E1Ijud4cIDnldNcJAqm
 BMfKRXbIJ7W1w1MODp3ZRiTGiWYdufmT64JGlH43LzVgIURHIuArkKojIVC6mnhWXLAu5KBjA+n
 RnHuQVGmaU9rboJNphyUH6t0J4jVcL8EFCf6zfSBcQ6I=
X-Received: by 2002:a05:6a20:12c4:b0:203:cb2e:7a08 with SMTP id
 adf61e73a8af0-22026c818bfmr10126566637.5.1750745962166; 
 Mon, 23 Jun 2025 23:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0GXocMfcAmZI23msxi4URVwqZEkBSutjIxpPFB5/9obIxUEFeV5l/M1AewzdH249ne6ZRbg==
X-Received: by 2002:a05:6a20:12c4:b0:203:cb2e:7a08 with SMTP id
 adf61e73a8af0-22026c818bfmr10126553637.5.1750745961739; 
 Mon, 23 Jun 2025 23:19:21 -0700 (PDT)
Received: from hu-gsekar-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c887192csm979321b3a.148.2025.06.23.23.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 23:19:20 -0700 (PDT)
From: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
To: sr@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 gopinath.sekar@oss.qualcomm.com, hello@paulsajna.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v1] watchdog: qcom: Add max timeout check to prevent overflow
Date: Tue, 24 Jun 2025 11:49:07 +0530
Message-Id: <20250624061907.3893511-1-gopinath.sekar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6jW8gMDHlREvJ7VI2IxQa0RypqmhBIk7
X-Proofpoint-ORIG-GUID: 6jW8gMDHlREvJ7VI2IxQa0RypqmhBIk7
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685a436b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8YUH2e0Ys_Mie9xma7wA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA1MiBTYWx0ZWRfX9dZkqWeY6mzo
 E9xefETGzxO24maWBFCiOWZ4L9IIJ3hyJwpUv77O99gRC6b8e2gj6e+D16jexZ46h97hd7npsV0
 wLLSw60m+8KvMEzk1wto1f6K48oAYn3oHGGseSdqD/aVxfVtI2sXNc4S4hGFws1pCAV8ZK2iXzu
 YgLrVidSuQ7s//uxaeHYvLqGuj/c2OxN42bl2F1oZC6LDWjivjDh35U6TfLDOMW/KCeIbdReHOn
 Hul75dsKbjlVcWMpjI++qWI9b3gW4T8jAwf9+x7jZfaAkhtIqlig1JoPcdQ6b1ytxvkrAjKNyqR
 YEZ4EAhpzmSVNDjQ8TsjnFxLMRWsADSLqN52bnngkpwgbOI6hezaukDKA1AsOoq5PaLtAh2y9dc
 z+sNIkPFHZAQfJli88ehmRKiwq87uIvnffN+TGv4m0K5g3b2OGZAPJfnbo5KduFimDUzGfvf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240052
X-Mailman-Approved-At: Tue, 24 Jun 2025 09:17:41 +0200
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
does not exceed the hardware-supported maximum value.

The timeout is first converted to watchdog ticks and then compared
against QCOM_WDT_MAX_TIMEOUT. This helps prevent misconfiguration
and potential watchdog misbehavior due to overflow.

QCOM_WDT_MAX_TIMEOUT is set to 0xFFFFF, as Qualcomm SoCs typically
use 20 bits to store bark/bite timeout values.

This work builds upon the previous submission:
https://lore.kernel.org/u-boot/20250527124926.128413-1-balaji.selvanathan@oss.qualcomm.com/

Signed-off-by: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
---
 drivers/watchdog/qcom-wdt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index adbb5aacdc3..eeeea4c24b7 100644
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
@@ -55,8 +58,20 @@ static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
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
+		dev_err(dev, "Requested timeout (%llu ms) exceeds maximum allowed value (%llu ms).\n",
+			timeout_ms, ((u64)QCOM_WDT_MAX_TIMEOUT * 1000) / wdt->clk_rate);
+		return -EINVAL;
+	}
+	bite_timeout_s = (u32)tmp_timeout;
+
+	tmp_timeout = ((timeout_ms - 1) * (u64)wdt->clk_rate) / 1000;
+	bark_timeout_s = (u32)tmp_timeout;
 
 	writel(0, wdt_addr(wdt, WDT_EN));
 	writel(BIT(0), wdt_addr(wdt, WDT_RST));
-- 
2.34.1

