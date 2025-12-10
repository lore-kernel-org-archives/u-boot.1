Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799A1D3B9BE
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C7483C7B;
	Wed, 10 Dec 2025 18:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntItYP3N";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F+8q68Ut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E09D08307F; Wed, 10 Dec 2025 16:55:11 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B9A83C94
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=loic.poulain@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BAB6Jks2419783
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tQ+yF3BOzoK
 IKvB4iYNvpFrwgQnIxXzuLY3HDowECXw=; b=ntItYP3NH/9z746cCGnG095/WAR
 pNLbpWXRJhlIj+KRuCAGbk+90uULhj19C2YJROqbEyB7IUnyhuwoFt8OXRfWMY/4
 D9Brb8ymXMqDrTKkKxCFnp+JDbsXLpYGjjZNfNWzDcYMDsxQuCGbO0d3PKHcsJLz
 e4vYC7NNgGwAV8BDK76vtwnQQNt89YoJUPd3VxyauIprM7PZ0pjVXYIbnQRdVvzE
 tk0fY8PFWt+B/wmi27Fx99/aZde2qQY2magNZsfDA6vJV4WKWzLQ5c1Eyoc4WKuJ
 JqE97ZICd+BrSlgvf4cV0xbH8fI4D1FCFnHMnRjZCodJuqlsExjUfa6xQtg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay7pp0vr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:55:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4edaf9e48ecso180533381cf.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 07:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765382104; x=1765986904; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQ+yF3BOzoKIKvB4iYNvpFrwgQnIxXzuLY3HDowECXw=;
 b=F+8q68Ute/8cReXo2UqLFUYmTEQ0ACQKpIrwZqXlCv6fh6GULEWg90ULBCvXDqKXCV
 YCwlradsN/qAIWzDnnessW084kJUNHG8cI16sT+WE4WreUopNn8GYavQWU0gRz1a/jKu
 dZ1MWX1PUS0IaAd1i65ZG4psMvaPa+4Qa0v4bjH1RJG6JpNil+QTdohe99sdiVR6tz0t
 KnqWIFv2GtOuePVfGtDf99BLBd+4rxZGAOdwAWbIqE5pjGAr6BCxoSX8Uh3trsRVGZ57
 NaZGk92lxv+7Itj5vshe8DKp8Fnft9w/1gIphl3PEOHDBk/eeNj0n94g/Vb74iGsl8Ep
 dpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765382104; x=1765986904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tQ+yF3BOzoKIKvB4iYNvpFrwgQnIxXzuLY3HDowECXw=;
 b=DaQOt33pHWYnEww+VAGMXqcQpPiJPxWNjDtgfp7XwWisD4KBrCiMFjrYKOxXVOMJ96
 VGD6Bz99zJ0x404yHO0vGKscJ3BPc+b2ED4rLcGXh3p6nX5Nqc7gWZbruX2GAUHhyHxi
 zexCb++yO4L2RTSe24M/CdI+0xxroeDPWK1cxXvmCMSX6wP0bbLhpYrERsW2gqTxUStW
 j/akdQH9q8suTnplD1U+gze43u52BiVbWA38LQrj7Oiaaci3dPjDBFz9XAbacb/muNX7
 txK8g3D9UTe/5H6mSru8pRMSvSVN8E0QnQ3pphesd7P9p95QxBzCO5CqwAgmW51G0ITV
 TKHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbE2m4h4EQDvd+Ci4DijsSZ2qAXpNq2qzk6yob5EPjYRWNIJv8LOhOI46+KLB3HCxawDd3QAs=@lists.denx.de
X-Gm-Message-State: AOJu0YyA6Ps+WTjFmjHrzQqYnewYFBEEKxI5in7/jY0IuuDs5WokwRfN
 Z9uIyz45PAmGWmjVhq+fqABTv+v/B90i6axqKgIDsXaoVHukXZX4u7XLHjWZ1lYDn2gogiOOQnQ
 cqxzngsPykBkKqoGK/nNR1LQgQ4swhKhBXPUSvQuyDJxsp2LKmFdcilz9
X-Gm-Gg: ASbGnctL2IivFNuZBLB+yEPefNPN8S+X48Dg7B6JE6Di3TIs2NwsdkEr46HCPMS5ZDR
 7d5BDf0VNsZedlTVMpXNG1CM81AkGAJSFdvQfqUuanvsohaoYSkKcWfFlxwDXaIqOhMu9BzQqTr
 KuFt9qlpAXBJNYDMoHjm+j3oBL5rHOnW73bVND321ODwqCUiCCOwmlpd0LvlZ5j7/AYiynBCVkv
 XJTPIPfwfXt0WQ3YFZNUrmoGgaYyvCUtOicozfmnONxNwWJuQq4Y0o1iDvpGOtvfbiRWCOl1xUp
 w881PP/oBpMAashcwR2EzdEUTFQp7bEQnwTbLOj6Scf1rarmwTz1Tqr7sUJAEcTL9CA8NgNX6Nn
 wDWBaFQ+jBn4pgBHG+s1QUxXof2dt5ETu28jGjbw3HpagTSSfhgB4RMpFxIfI5n3VJT9vDMnKe2
 nQ
X-Received: by 2002:a05:622a:1c05:b0:4ee:210d:32c9 with SMTP id
 d75a77b69052e-4f1b1ac8d02mr34664281cf.68.1765382103714; 
 Wed, 10 Dec 2025 07:55:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdPh6LFVFw3VzQVg+UjEs2LeUZxg/BRn2ePjuE0+p9+qf3I0iJqmsARLsmFrIU5uxmXU0DjQ==
X-Received: by 2002:a05:622a:1c05:b0:4ee:210d:32c9 with SMTP id
 d75a77b69052e-4f1b1ac8d02mr34663971cf.68.1765382103326; 
 Wed, 10 Dec 2025 07:55:03 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.qualcomm.com
 ([2a01:e0a:82c:5f0:f840:4916:e7c3:a857])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee50sm38126808f8f.14.2025.12.10.07.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 07:55:02 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: lukma@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org
Cc: sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 3/3] mmc: msm_sdhci: Add DLL control hook to disable DLL below
 100 MHz
Date: Wed, 10 Dec 2025 16:54:54 +0100
Message-Id: <20251210155454.1561611-3-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210155454.1561611-1-loic.poulain@oss.qualcomm.com>
References: <20251210155454.1561611-1-loic.poulain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P2-jUVCD9umm7O1XT7Wy1zs8yF0fejbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDEyOSBTYWx0ZWRfXzKa/ZyPYAjs2
 Gp6xbtGaz51LQgWOeCTTPXriEXDYW0Xl4SvaTWOUuYTqRuypM0OxMAclrwNnxEriMd9Q6DJJvsS
 mcS8Fbhr4muWBrAwZA7uV3ddnHJYunZE616QP49QJSZHMGpPoVg9m4sTpGYi11MNKqGNp4CjuYe
 ESqwrSE7qP3EKQzUbHdxYqj65iFat3F+LWc9NKxt5zEz6jowRCqvq0PJkvclt1OdviM6xtD+F9D
 hdEtGLJLK1z4aa7yk6bSHfZ2VAiln4Xl8VJ6Ix/AI51v7k7tsLMT5npJmum9sCwIM5RHfVDfOys
 TtXgRqrjoUUpI5U2iQsQxvhXvoF8N9EWnpYHei83ZJyfbYZQG45KRC0/p/zDbkcwPVgzjPeUpng
 XTFNIfYVdJOOYM9oVAlc3r9bT9ZTog==
X-Proofpoint-ORIG-GUID: P2-jUVCD9umm7O1XT7Wy1zs8yF0fejbB
X-Authority-Analysis: v=2.4 cv=WaMBqkhX c=1 sm=1 tr=0 ts=693997d8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=364kCYYkphFGw5ZWDZIA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512100129
X-Mailman-Approved-At: Wed, 10 Dec 2025 18:11:14 +0100
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Introduce an SDHCI ops hook (config_dll) for MSM SDHCI and implement a
minimal DLL control routine that ensures the core DLL is disabled when
the bus clock is at or below 100 MHz. This approach mirrors the Linux
MSM SDHCI driver.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index ec003991928..38dc36a2194 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -36,6 +36,11 @@
 
 #define CORE_VENDOR_SPEC_POR_VAL 0xa9c
 
+#define CORE_DLL_PDN		BIT(29)
+#define CORE_DLL_RST		BIT(30)
+
+#define MHZ(X) ((X) * 1000000UL)
+
 struct msm_sdhc_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
@@ -51,6 +56,7 @@ struct msm_sdhc {
 struct msm_sdhc_variant_info {
 	bool mci_removed;
 
+	u32 core_dll_config;
 	u32 core_vendor_spec;
 	u32 core_vendor_spec_capabilities0;
 };
@@ -149,6 +155,34 @@ static int msm_sdc_mci_init(struct msm_sdhc *prv)
 	return 0;
 }
 
+static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
+{
+	struct udevice *dev = mmc_to_dev(host->mmc);
+	const struct msm_sdhc_variant_info *var_info = (void *)dev_get_driver_data(dev);
+	u32 config;
+
+	if (enable && clock < MHZ(100)) {
+		/*
+		 * DLL is not required for clock <= 100MHz
+		 * Thus, make sure DLL is disabled when not required
+		 */
+		config = readl(host->ioaddr + var_info->core_dll_config);
+		config |= CORE_DLL_RST;
+		writel(config, host->ioaddr + var_info->core_dll_config);
+
+		config = readl(host->ioaddr + var_info->core_dll_config);
+		config |= CORE_DLL_PDN;
+		writel(config, host->ioaddr + var_info->core_dll_config);
+	}
+
+	return 0;
+}
+
+struct sdhci_ops msm_sdhci_ops = {
+	.config_dll = &msm_sdhci_config_dll,
+	.set_control_reg = &sdhci_set_control_reg,
+};
+
 static int msm_sdc_probe(struct udevice *dev)
 {
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
@@ -223,6 +257,7 @@ static int msm_sdc_probe(struct udevice *dev)
 
 	host->mmc = &plat->mmc;
 	host->mmc->dev = dev;
+	host->ops = &msm_sdhci_ops;
 	ret = sdhci_setup_cfg(&plat->cfg, host, 0, 0);
 	if (ret)
 		return ret;
@@ -288,6 +323,7 @@ static int msm_sdc_bind(struct udevice *dev)
 static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
 	.mci_removed = false,
 
+	.core_dll_config = 0x100,
 	.core_vendor_spec = 0x10c,
 	.core_vendor_spec_capabilities0 = 0x11c,
 };
@@ -295,6 +331,7 @@ static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
 static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
 	.mci_removed = true,
 
+	.core_dll_config = 0x200,
 	.core_vendor_spec = 0x20c,
 	.core_vendor_spec_capabilities0 = 0x21c,
 };
-- 
2.34.1

