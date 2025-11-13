Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71492CD5BCE
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7B3683E1E;
	Thu, 13 Nov 2025 12:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHbH6nad";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGEovJmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC01183E20; Thu, 13 Nov 2025 12:35:15 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F9B83E1B
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AD8jMhj2962404
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o5f3iTYNkNP
 APLzKwefuES3HbY5qsuModu48iwMTL2A=; b=bHbH6nadxUGjYmziQoThgSmPdYO
 +C7CLJ5mJQIIm6ihuLB+ESjjgaVs9rz4pWyJznd3N2IDx30LaAhs/pT+Jv3Sf6n3
 7lceQAvAUZ+oblf0XSa3BfTtY0SlpJadarFkIhnYzfJ2hN0TAY+M5q+klWC5jhkB
 eP+XkGq/daR9ItmHub9g2LgA6AzswEkCjHQiZWF5lLGpG+yrYheo1UGfqVh/EmHj
 V3N6f5f8mKlmyYoaYvXDBZ+L3Y8cpLBgmtW8Z7tpJXcF/RETkNoo8eTDxsKytb6y
 tiaDq+cnyvajJ8nhRcR1IvlgR/SBo4g4AAbiD3OgIhioHavy1Lo0r5l7Ffg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acwbpuc0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:35:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2954d676f9dso6465945ad.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 03:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763033711; x=1763638511; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o5f3iTYNkNPAPLzKwefuES3HbY5qsuModu48iwMTL2A=;
 b=XGEovJmmhJTpl+twQmHSANeayncqYZH3XoZReLX6R54JJURa7Dit4+4nNGYfqYIokI
 EqrN88LqHQIsrbGrbIzRebtEhkU8MtmxZm9jcQ7Stel4pN9HsWGlv8o8W2kT0iLgKkYR
 KLuLaP25ptw24iJRrvACiWv8cdE1Ti2p7bo31dqZ3POyrqp0Zu4zCksyrW7byOXvoohH
 k9nlbmiQtqHa97+KkulQCDfNxW9fV2AQLeuIAS/Xc293xOsEy6KTKsGYS7QX3h8Q936G
 KkYQFqvLHjJlb05PXFarPtNNIKM8cmX3ICHgqQj0oSiK1CxZWquU1inNS2DUKI3+HZlP
 IYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033711; x=1763638511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o5f3iTYNkNPAPLzKwefuES3HbY5qsuModu48iwMTL2A=;
 b=tREaG12xAoEywzzHr3DBCtuKW6dzyUtNDXqjdUY4lrDyiwACSU9Oyt6t+nMfL3QCu1
 woxcDZGUBjLbCuyL33x1r8wZ1RjQFOrhpx1UvBtjFgeK0ptdOJHXznfWlsKDUB4Ns1/h
 7DbX2ExrXUNWJQyWPbLENUpv4DL4+9vsN/UllC+wd9VJIy1CcZuCe20XnmPt0bf5OM9T
 JGB5Lisf2/qxT8OV/SW20EoDE+mGXgGen0WXjOcjsrMz4/jkiNrL2h/o91LcWKLXAacV
 Diua0qc69t7+rD1F4Tp78Oql/buhlGNhykF8xjnJlLXEjXyV6czmjuPGRS+Qhv7DFJTb
 kcgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW207zeyxSEKMgMKYcJ1IWRFz3gVmklVac4IdCNakHuBRhJEM10aBNW94GThvp/8H9xnSaBO34=@lists.denx.de
X-Gm-Message-State: AOJu0YyIrufukUjeIDAmmMZakNPqrVyZh8ZEZaYJaY0fe6K3M9zyie5m
 FQHiuxMXMUqOU+RTTIxRNd+7IthC8w+T3DXsms27ibUgPDyohI8EaNOe1T9qnnxDUTcyHU4gnMw
 HxjxOTWDr27EHo64xL0ZY5itzj9znvUPLexhiNaR4nJwVqDCYFHb78QZK
X-Gm-Gg: ASbGncvYmems4mhId4afeZh8xx1LE0h8VUVITC2pnabVtFM9xJOI0ZyRuzkADJSjG/i
 j7xBHub+QsBMgL4vTSci1LeHNomrdRFsv4I0aw/XAogie5/9O0n+tR1NjWyQ7fwqFyj6JKO57XW
 Guia2BceuDf+EEKfte/T4+O1MQdbphuFZ7vWAGpn7h6nG33JgWE0IZRq3yJFx2xiRzek83pLfvZ
 nIg7pkyDPOhsit77p8clDbbqjDiE3740WKzAKAzo8P6l7pbRAP1L7zg54i3H8t633wFEDMtQAP0
 IesodrfS28/teesEzS4ABTh0W83ydu+7L2GpWGr5KWRLadoMjZGk5+Bgl4vV9yZ5tmAbocoRP6w
 JmjxVgZaG0rbd9oLfWhsC0wXUvAMOIHnLxrIw52VoYe4+V5HHp3mNeSsKBqmSWuS3ypB2Pyye5K
 Kmo/+uo4DPYZKxRGCJQQ==
X-Received: by 2002:a17:902:d2d0:b0:295:bba8:3c4d with SMTP id
 d9443c01a7336-2984edeb572mr95151125ad.35.1763033711305; 
 Thu, 13 Nov 2025 03:35:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7LZAtZCPhfOtosT+tD1/JwGwP5i0w9RLLmDh35TA38X7OknbNW63a++fywOJxtocIT/Rj7Q==
X-Received: by 2002:a17:902:d2d0:b0:295:bba8:3c4d with SMTP id
 d9443c01a7336-2984edeb572mr95150705ad.35.1763033710718; 
 Thu, 13 Nov 2025 03:35:10 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c2346e6sm22573885ad.22.2025.11.13.03.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 03:35:10 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alif.zakuan.yuslaimi@altera.com,
 tien.fong.chee@altera.com, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v6 5/5] configs: qcom: Add QCOM_POWER_DOMAIN config
Date: Thu, 13 Nov 2025 17:04:27 +0530
Message-Id: <20251113113427.2218045-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
References: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NvjcssdJ c=1 sm=1 tr=0 ts=6915c270 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=sbwBSw1Q_kG3G2zi_HwA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KiA8c2jqGoOcbm9ouBuKtPtPfXwvRsQV
X-Proofpoint-ORIG-GUID: KiA8c2jqGoOcbm9ouBuKtPtPfXwvRsQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4NiBTYWx0ZWRfX8Iu7GvSVewjq
 5Istuu/ey68YtwDq1z/v929BQiASOAgxdaHXpaLsg1/+LA7ht+ykAQC5gV0W/UIJTGyJEHZF9AD
 PVhRjm8OAdlHyeoWyQdSHJL9WovflH1F79qcQTJpiyxJZMH+68PIhkcXx5dd4yNAqCwYkQrHYkE
 7WOBHYzB2WONSwH4cncyjYro1Vdc3Lw+1sk4hSaZqJ6nUzqTTwjLIjyxJvNg1MNZbhOIYsm0vMb
 NAsHMK6oQ3VCF1A0f73GEYB2l2nKFPFC6GlT0kWxBcD8a9UxeW7ArAiZ9CYiOocNBjmagHXqDzy
 s9oa0WB0QF9YPFaINqQR/nvi56IiEV40xSyOtjBJaxojS11g27OaBHVmN9bYqWx//eCfUSa1A3G
 74NMy5bchA1kshEsDrRUHzQ3Hvj2Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130086
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

Enable QCOM_POWER_DOMAIN config for qualcomm devices

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v6:
- No changes to this patch in v6

v5:
- No changes to this patch in v5

v4:
- No changes to this patch in v4

v3:
- Removed OF_LIVE_SA8775P config, since there is no SA8775p specific fixups are done

v2:
- No changes to this patch in v2
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e686ea857b9..bbee5d44a5d 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -139,6 +139,7 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_POWER_DOMAIN=y
 CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
-- 
2.34.1

