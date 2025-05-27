Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D24C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 12:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53245803CC;
	Tue, 27 May 2025 14:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LBgwtftc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9586983093; Tue, 27 May 2025 14:49:40 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63EC8003E
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 14:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RA16wh003699
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 12:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=gDhSKph1ND85JNPpSI0H4dxFMRjhnS6bN4x
 EdVUnNtk=; b=LBgwtftcZTAiBLRJuO4FmJnVyYWbI7O1Jm/MOvRDzilpsaY1b90
 MGhZSj+2QCAQD0nOce03L4tOn3/iQRPPgdzuUrs+gm9ZQV0YTeh/DbsKsqy9CIaC
 bV+1Q4KCNfvd2LmhBlJZHekDQ8RVpbLPw/aqMR6ALaleGPGd47bwQ+zErns8u3gE
 TqyPAE2OBjSZ5q21/ZNpi7LeDC5u032fTIdzyVnzvrrt9XzS9ogBwBBgoD/wO+NY
 yVFoI7/B8XDg80O487vCCQC87WSJyIT1LwcoAQ16OiS8Jdbcvo4pTJudbUnEXyXX
 D9o676MEESa2RFTy4WijgTSM5QLVnUxDoNA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u3fq72b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 12:49:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-23495f5924aso6574855ad.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 05:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748350174; x=1748954974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDhSKph1ND85JNPpSI0H4dxFMRjhnS6bN4xEdVUnNtk=;
 b=ZNSw0UCfCtjhBBaG7udjIAkfNMXKHVHhJjEt92r6Agtgo6k8oPWhzg+z5JKDhDLnqO
 ggM0OYvo3Vd6wdQCYU+EgngZKtwkpnZp8I3ktmdRxExofE9ta+nlLEIbEset51XBF7BD
 OAoW/fd6fXLXpZQThmk0xxXRwWNwsY8BLc34gyOTh8zHTUv0loqckfNY3Z6kb9fOyFLV
 kn9t32m72TDwK2a11lx1GgWgbQ1Ditp2r2RSYJqymNmBSqPzDzk5KdRPH87CdmdYSrtV
 xJPrsd+besO3g/bUqjrNcAmM1F+S8x/WJPN6UHGMnzxyqzCUbO0e2iWmBm1Ss9hC03gz
 FbYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzDbpAq85EjWhD5wBAJAP12KzlJM/h2p9OtFlQDoNWRoLPwoyyRj3zIWW3AzGwnBbN3jC0bQY=@lists.denx.de
X-Gm-Message-State: AOJu0YwRCS8/K7woFwmJ47SE78Gyaoim8TlvbB6NRtriKV7gWcRLU6XV
 mMzSC9G7ITQB27DXn4+j8kgHA+oFV1dAvpxvIR3OlJp9VgBt0X/OJsapUtcAcPUnnQ6XQly9Skb
 gvweIRwPjizTzCdkqIMdFEcW+/Ig0NrSnhOumfreCQ4TKoEHyUXRbI3wU
X-Gm-Gg: ASbGncsdyt6Sg0+utJsMUrYWJko+jnWMbIWmgEuxXhAZg+Dm/AyNTFAbqO1xQtJ15p1
 8AR+aYixuF4iPywC7GiwQLUkv01MoT/XvphZuqQ+mQkbOG7v7VXvbx767vmcxX246FFmC/HAzHM
 DxPGUt8TOm6Z4tyzxshDUwAzRYUl0RnpIt//wh6oG8MoGt5XibkEsqOLR3ordTimoqerLFGqc09
 83ax1eIm0wAShc+Edk5+kwf6u7mA05G3aSW6Nkistk6wBojoviKBSpgB76lFlt15UVILOdEXZd9
 1QMFDtPeHkFSWy/FJyftvTMxR2bN7etL76dIZOahyvCpfa9BrkjxBXtOuJY4YxKc15JxzGySGGR
 zOdIQUGfZO0+65owyHMVMNBiiphMVbBJ2V92bklKn
X-Received: by 2002:a17:902:e84f:b0:231:e413:986c with SMTP id
 d9443c01a7336-234b7435f70mr7157985ad.11.1748350174270; 
 Tue, 27 May 2025 05:49:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqaPP/0X3yGp4xwBoGl66wlaR1MhcQadQuERYdqyw32eOER/FxqWFjZjHMzwzaVZBcUqzfvQ==
X-Received: by 2002:a17:902:e84f:b0:231:e413:986c with SMTP id
 d9443c01a7336-234b7435f70mr7157375ad.11.1748350173844; 
 Tue, 27 May 2025 05:49:33 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2340c0e72fasm63785465ad.239.2025.05.27.05.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 05:49:33 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: sr@denx.de, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 utsav.agarwal@analog.com, ian.roberts@timesys.com, hello@paulsajna.com,
 hs@denx.de, bastien.curutchet@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, nathan.morrison@timesys.com,
 ravi@prevas.dk, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1] drivers: watchdog: qcom: Add timeout configuration support
 in watchdog
Date: Tue, 27 May 2025 18:19:26 +0530
Message-Id: <20250527124926.128413-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UEpIJgIyWoWLPtt-fGib1MNxTmV6n0JY
X-Proofpoint-ORIG-GUID: UEpIJgIyWoWLPtt-fGib1MNxTmV6n0JY
X-Authority-Analysis: v=2.4 cv=X8FSKHTe c=1 sm=1 tr=0 ts=6835b4df cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=53EZ7TDeAAAA:8 a=EUspDBNiAAAA:8
 a=hL1VrFInjXzlMnsjldwA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=4uUo5ylOvWPqrpBE2UM3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNSBTYWx0ZWRfX63QKpIr/6aDC
 j6yztdnKmCRj8c61raqANP91bOrGuYx+uQ9iVh3DLWtCwX7zZsxNkY7xxaPrB2EKtn2pzufqLqH
 PM7wOLA4JlMBeg64Wpb+vgkoIhajgvj8uEopEODzxe78FqH8ClpBn3W0xhfmTtiYIFZhsecDc9n
 aNqLoIwUZSeqG0SfbXXNAMUwCG/33sCroYCSVAVzmiFFGT/zOI5WLfw8qUFL7o84msScKdq04Px
 sJJUdX3NlvhMvQvuzaCstXTMP44m397C+ekeTuNIqVBTgIH+RT27rek7T1DZ43cgfWq9j2qLmqF
 LrqxH2tB4eOZhj9n3eJW+JDE6nmGYFAfp+LdI6vh4nG/CP2j4rfpUeZqhlt90X1FJlsWCR035hQ
 Cad2Pq0pVuoA1WDUQ1IxJCu/wYQyNwjL/bVpi59iC+RIVB4kfwn+U9IF22EDwH6zQejzl8Zi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270105
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

This patch enhances the Qualcomm watchdog driver by introducing
support for dynamic timeout configuration. Specifically:

- Calculates and sets the bark and bite timeout values based on
  the clock rate and the requested timeout in milliseconds.
- Adds retrieval of the watchdog clock rate during probe using
  the common clock framework.
- Adds a default timeout value for ARCH_SNAPDRAGON
  in WATCHDOG_TIMEOUT_MSECS.

These changes improve the configurability and accuracy of the
watchdog timer on Qualcomm platforms.

This work builds upon the previous submission:
https://lore.kernel.org/all/20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/watchdog/Kconfig    |  2 ++
 drivers/watchdog/qcom-wdt.c | 24 ++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 808f4e578e2..45c5e20e2ed 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -29,6 +29,7 @@ config WATCHDOG_TIMEOUT_MSECS
 	int "Watchdog timeout in msec"
 	default 128000 if ARCH_MX31 || ARCH_MX5 || ARCH_MX6
 	default 128000 if ARCH_MX7 || ARCH_VF610
+	default 30000 if ARCH_SNAPDRAGON
 	default 30000 if ARCH_SOCFPGA
 	default 16000 if ARCH_SUNXI
 	default 5376 if ULP_WATCHDOG
@@ -338,6 +339,7 @@ endif
 config WDT_QCOM
 	bool "Qualcomm watchdog timer support"
 	depends on WDT && ARCH_SNAPDRAGON
+	imply WATCHDOG
 	help
 	  Select this to enable Qualcomm watchdog timer, which can be found on
 	  some Qualcomm chips.
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 3601ba93774..adbb5aacdc3 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -13,6 +13,7 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <wdt.h>
+#include <clk.h>
 
 #include <asm/io.h>
 
@@ -30,6 +31,7 @@ struct qcom_wdt_match_data {
 
 struct qcom_wdt {
 	void __iomem *base;
+	ulong clk_rate;
 	const u32 *layout;
 };
 
@@ -53,10 +55,14 @@ static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
 int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
 	struct qcom_wdt *wdt = dev_get_priv(dev);
+	ulong bark_timeout_s = ((timeout_ms - 1)  * wdt->clk_rate) / 1000;
+	ulong bite_timeout_s = (timeout_ms * wdt->clk_rate) / 1000;
 
 	writel(0, wdt_addr(wdt, WDT_EN));
-	writel(1, wdt_addr(wdt, WDT_RST));
-	writel(1, wdt_addr(wdt, WDT_EN));
+	writel(BIT(0), wdt_addr(wdt, WDT_RST));
+	writel(bark_timeout_s, wdt_addr(wdt, WDT_BARK_TIME));
+	writel(bite_timeout_s, wdt_addr(wdt, WDT_BITE_TIME));
+	writel(BIT(0), wdt_addr(wdt, WDT_EN));
 	if (readl(wdt_addr(wdt, WDT_EN)) != 1) {
 		dev_err(dev, "Failed to enable Qualcomm watchdog!\n");
 		return -EIO;
@@ -87,12 +93,26 @@ int qcom_wdt_reset(struct udevice *dev)
 
 static int qcom_wdt_probe(struct udevice *dev)
 {
+	struct clk clk;
+	long rate;
+	int ret;
+
 	struct qcom_wdt *wdt = dev_get_priv(dev);
 	struct qcom_wdt_match_data *data = (void *)dev_get_driver_data(dev);
 
 	wdt->base = dev_read_addr_ptr(dev);
 	wdt->layout = data->offset;
 
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(&clk);
+	if (rate <= 0)
+		return rate < 0 ? (int)rate : -EINVAL;
+
+	wdt->clk_rate = (ulong)rate;
+
 	return 0;
 }
 
-- 
2.34.1

