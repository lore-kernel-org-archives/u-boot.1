Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422C3106ACF1
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 23:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F31841C2;
	Fri, 13 Mar 2026 00:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jYoESiRB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bd1lcF6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49A683F86; Thu, 12 Mar 2026 20:26:19 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D80383F2A
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 20:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=krzysztof.kozlowski@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62CICib61756621
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 19:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=rYgB/G2VwJz4ODO+hOn7U+DtZ5xKr8XPIXx
 5IU7AIX4=; b=jYoESiRB9Q6T7WboIjaPSHo9Z8LCGgNJzOsIEZKLR3qhSmpIdvH
 qNhihRAz81+zs5QZJoZQt1s90pqQaSd5jM6AVzAT0Ggzj/I+rio+P3Uj3SRevXAr
 Fo/+vrb7AmiE07l/iQpJndnm9dkM9dN06e2PRqwbvhD8t/LnXWBt8pwxlo/1N8bW
 xk3OlGhIHMeGmlDGh69uZKgAav4QI86E+MgdwAk/FABEhalfAjBPMRWDqyyGDN99
 BahOey0CTbWhB78cFbmsEQWPQjhpYDmDMnxIQVustghQb9WKz9va5P057Qu4F8xt
 cn7P+F06yGq3wd45sgmjJhilPvnRypk63Mw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh53ka77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 19:26:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5091782ab06so193580271cf.0
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773343574; x=1773948374; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rYgB/G2VwJz4ODO+hOn7U+DtZ5xKr8XPIXx5IU7AIX4=;
 b=Bd1lcF6SXUBMSFb3gCxLbldkaVXxIQw1Ki7i3h++Np5paLSNkfPSDH6BW/0NRH/RSo
 lP2OpOlEzYmrak6dmXo96Vu+zd2hWy/7w6sdjgRtjBPAZnqJj2Inzt3pIafUqOlX+peE
 M1MHArxDACS4ZuVYxq0+dP1c8n7OqNkXnalInWVdobmaM7P7LgmCYRdZmkup4UfGWqNw
 /lURYo7ToCarvqIoZm8oSq0y3sucZ7PBHGrT/etcO1if4lnoSJpR1ZV0SikFQ9AGGSSL
 Ywg2on3VdpKu6lVs7fE8ym9cFTuL4fX17Mp+582vyJmeZ1pSOhuymLUM89fMasF/fTkl
 zJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773343574; x=1773948374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYgB/G2VwJz4ODO+hOn7U+DtZ5xKr8XPIXx5IU7AIX4=;
 b=AGqCiEIAyDdKbtzfxovGDB2iPMBhCxW5kZ/e23eWUIdAUMfre/4JtfvEdNzw4rz1zT
 mtKgcfct7m6Jeo9/tAc0efqNDoTBjlXu3zHMX/P5Zc+jUCpP3Vel2uk0DIjXTj0YEHNu
 Bd2gaNrEpkhBKS8pwX/ZIkr3Vb1QbKIz6E+t6LAXn9O1kx9/kMTBVRvjjrkjDRssDdnx
 aIzv2wht6IViKKOiFC8lpWyvFI7CTmLhubA3TsD0v5DIMXcgKT+wCEOqJZV7RoDMzPTb
 +WZHx72uGi4xbPpw6zaC6UPcE6SXT614Ymi2EJbCpqIiLfv3QP5LjtexXhfrpEF7Y291
 gIiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpoguUQ4nb2zrq6oXSw5fLDJQCEueThzFv/E+M2nsqVrusArn+DR5fJpG1iFc4qr61gmgeto0=@lists.denx.de
X-Gm-Message-State: AOJu0YzD8oC6Rlg8bswkYDVlzLe6p3hmQmrzZcxZo34i0C8RbjS0bC/F
 0+KmdzGEbCE1xzKCe8Njh0XGAho0mkr0nglRTuOtXT4EOABKo/0KwpYOAlvRNPb/GkgMkZpetZV
 TjrMN2UdkcLyr4kWbizNKa15Drsapiw2VFHXlVU+2ZPOpqh7TYKNmbQHG
X-Gm-Gg: ATEYQzx15iHYntOmFk8dqiJf6v3gZ51xr+qjfFelmOTXiVkOswj2Q16YWpE1/Oy++QM
 5305DPCF5h5IaBgnHE+2NN+acbk2pwLw2SP1uY6ao/gvauGBiSRtlI0JA5DlQbILk/D5X35CFcF
 WcU7jX/CnT2liZga7ch70Wt9JbY762UXu+Q5NWlFBDskLpUi0bLfSqsuZhHJLKjOhuRPuGf6ieB
 QHE5ByVm39Gf0Tvsyu3bvsXg0Ghf/45HQay5MRZXcwwmpbhYCtV/HNmg5wzXaTxQc9a66NaVeOb
 jEbGLpfkqFAqTvA4CMkwERAbASsxQthvGBAcosRMDX0Hg9avsaMP3OHjxraim9u02mtR/F34RWH
 p0P6zXmWjGcodee8a9uATITrBZ1DTeE8OE4ib
X-Received: by 2002:a05:620a:1706:b0:893:2ba8:eec8 with SMTP id
 af79cd13be357-8cdb5bfbac2mr127226785a.79.1773343574196; 
 Thu, 12 Mar 2026 12:26:14 -0700 (PDT)
X-Received: by 2002:a05:620a:1706:b0:893:2ba8:eec8 with SMTP id
 af79cd13be357-8cdb5bfbac2mr127224385a.79.1773343573735; 
 Thu, 12 Mar 2026 12:26:13 -0700 (PDT)
Received: from quoll ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1abf84sm10323257f8f.14.2026.03.12.12.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 12:26:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH RFT] pci: imx: Properly support upstream Linux reset-gpios
 property
Date: Thu, 12 Mar 2026 20:26:05 +0100
Message-ID: <20260312192605.131132-1-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZN/aWH7b c=1 sm=1 tr=0 ts=69b31356 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ey_WZIOhSlKW_4Ed53gA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE1NyBTYWx0ZWRfX4BHKgaTXqrWF
 VuWGSLRFZqA3V6xAQfuwL208AySMS2jB5dZUIqdbpugwAOPyzciqXXfCIWX0fRGILWKxQyRfWpg
 dwh2Vv70si/xt20s2VTKB9pSNdb3qY0SZRsSIWKUXB/k3ujkq6YLuj2f08EtNdZpIBHMNKpDBgY
 7a7WfRq7HJtQgIFNWw2GZuTglMBa6WshVPRDiMSDly65uQtdDWXp5a2mE7R0FL7YkMAS7cH2f4O
 I7b8+o/NJXmsC3dGTvkpik8tQ0iWVAIdcFQ6LNCfgbiIXzfAPS7je/7yvT8tskIn/FnMdJdNepZ
 tMTMk+m4s+saXWznuWY6A452zNgm+tsjgsZQwoYd//uii4cxUQi2b9+09rEn9WBKs+nBV2o3XS9
 D8jGxQrj5UA4THV3QDRxlsGokrMFw22AJiBq3g9hN6n1gg8b6YM6yYNN0HFWWKtlFYlAeLjT6xP
 TWy9NcjgW0haIby4nfA==
X-Proofpoint-GUID: nadoHmbsG5sOOvbUY9kEwIBE2WdptNam
X-Proofpoint-ORIG-GUID: nadoHmbsG5sOOvbUY9kEwIBE2WdptNam
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120157
X-Mailman-Approved-At: Fri, 13 Mar 2026 00:03:43 +0100
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

The driver requests explicitly "reset-gpio" property, not the one with
"gpios" suffix but upstream Linux kernel deprecated it in 2021.
Existing upstream Linux kernel DTS is being changed to "reset-gpios"
property, thus update the driver to read that one too.

Note that driver is probably broken already, because it parsed GPIO in
standard way respecting the flags and on top of that applied the
"reset-gpio-active-high" flag, thus "reset-gpio ACTIVE_LOW" with the
"reset-gpio-active-high" property would be double inverted.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

1. https://lore.kernel.org/linux-devicetree/20260312-dts-snps-reset-gpios-v2-12-0d5040eb4a1e@oss.qualcomm.com/
2. See Linux kernel commit 42694f9f6407 ("dt-bindings: PCI: add snps,dw-pcie.yaml")
---
 drivers/pci/pcie_imx.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie_imx.c b/drivers/pci/pcie_imx.c
index 11c4ccbfc555..8d853ecf2c22 100644
--- a/drivers/pci/pcie_imx.c
+++ b/drivers/pci/pcie_imx.c
@@ -728,15 +728,31 @@ static int imx_pcie_dm_write_config(struct udevice *dev, pci_dev_t bdf,
 static int imx_pcie_dm_probe(struct udevice *dev)
 {
 	struct imx_pcie_priv *priv = dev_get_priv(dev);
+	int ret;
 
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	device_get_supply_regulator(dev, "vpcie-supply", &priv->vpcie);
 #endif
 
 	/* if PERST# valid from dt then assert it */
-	gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
-			     GPIOD_IS_OUT);
-	priv->reset_active_high = dev_read_bool(dev, "reset-gpio-active-high");
+	ret = gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
+				   GPIOD_IS_OUT);
+	if (!ret) {
+		/*
+		 * Legacy property, invert assert logic based on
+		 * reset-gpio-active-high. This won't work if flags are not
+		 * matching the reset-gpio-active-high.
+		 */
+		priv->reset_active_high = dev_read_bool(dev, "reset-gpio-active-high");
+	} else {
+		/*
+		 * Linux kernel upstream property, assert active level based on
+		 * GPIO flags, thus leave priv->reset_active_high=0.
+		 */
+		gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset_gpio,
+				     GPIOD_IS_OUT);
+	}
+
 	if (dm_gpio_is_valid(&priv->reset_gpio)) {
 		dm_gpio_set_value(&priv->reset_gpio,
 				  priv->reset_active_high ? 0 : 1);
-- 
2.51.0

