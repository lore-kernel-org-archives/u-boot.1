Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75FDE9DE41
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 07:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179DE8407E;
	Thu,  9 Apr 2026 09:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JJU0L+d5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RWhF7fQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92791840D8; Thu,  9 Apr 2026 09:06:34 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F70783DC9
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 09:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6395CU8t3535075
 for <u-boot@lists.denx.de>; Thu, 9 Apr 2026 07:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=9Jbv9eSWqRpcDU9pAOqHTDoHpUXvNf7fcla
 EJuv+Mcw=; b=JJU0L+d5+o4KxEXNxtj4j6ggjfQKNfz57yIa/jzSpFK1pcfffWz
 4ZnTMLs+Z8M/MPrH/fd/SicJMl95C1iciXeHRd1G+U9M6dc7rWcHYOkw2mc97L/Z
 AF6F70lHTVtxQCeXvcccbG0gZbogY6mvJ1mprzLhay9uJ/3Ah2zC14xk9U0gAcA/
 9wAGsEsuM3xx5aHQMqGZoH+e6ScCihmePgkfs1LlU4nGYaJJbscxt1FnVN+HI3Ma
 CN4/OY9SmH5faaRvBWvGra0//mdED2wZsSt7QRpOHImjfgpGfimj9EuvYhMfsYZY
 deT+KqVcJi0z35FH8uswrDjxgBFLix52W0w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddw9mt0d2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 07:06:30 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35da8eb0553so683263a91.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 00:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775718390; x=1776323190; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Jbv9eSWqRpcDU9pAOqHTDoHpUXvNf7fclaEJuv+Mcw=;
 b=RWhF7fQVQybzYdU5riYT/4IAojNr+ZZjjTu7e2zAE+ykoSqGpdoAqcG7LS1yJrl7uR
 N4PL3pERazk+kRKWFYVet9FYW8+K5P7Oqwfj7zS5EwzipWX8axwVF9B3aHmApX8UMqdT
 ptjc9pJEydv4mAEJx4PUtwUBzxJ/sc5NCsR7NotXvYsXNudEnsmwIqxq2goHlg+vTyOt
 hymFkAZkuzhrUvVmPjVw/OXgUq39UxvStlVRg+WIwOUuBgBN4QDwr1f77802Cby+pSK1
 bZ8BKOmp4s0V4TLfRDxtmYCiwgARYd/Ge1J62SOBnw4bYrZuzhzqpzxj9ve/Kh4WMGfi
 70YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775718390; x=1776323190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Jbv9eSWqRpcDU9pAOqHTDoHpUXvNf7fclaEJuv+Mcw=;
 b=auFfLaReQK+JQFt8kX4A+FabcUD7DydNN+9wU4s983F8qZMcBDhwwdS0b5RK6rDGcZ
 X8TpU2mC/59/zEHOqnkQIp+oIMrQE7QcX1isDdBJq8MEbZlzsNYUyf2/hGyCdUgfj0mq
 7d6rho3qmYM2bDOLzlnqP4DOKmFkyLqflyR8v43LDaQxCGNXwkd8jtHI/FvlUdF8kgA2
 s4y2ad1FuJUeiRZDds6P3Ipdj7v47xv8rk/hYPcwaRP+AFuXbvLSWq7Le2yOgSJsfyNS
 JC15AG9tluD9ExBV1skoD9+mnjxmGf0XS2duocoSQx+Mev3iPvIz7QfPNjnQNej1gBfO
 E3Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxTdplk6MTH16Fy6EI8RvB0Bx0u14YFukgLR/BQCqz2VTjv1EAxP/4iBLhRw7lUMkj7MtWTR0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9ge3faDYPgNwf+E5xdeTJNUW52lHC10/xBhSFc6dqjvb2KGKW
 v/9Xnm+FEY1hRdcOHWW8bK+M6PKY/tZkma6TOw4ogLy70GvIb9lbwxaVathrsosO/d6XQza2GJi
 i6uK+CEsSIblcQTaznHfCESHS5jETOTpcp2MLNuae/ogbs4NTF8bXV787
X-Gm-Gg: AeBDiev0Ldj63t9GPCUPba8WYH/r0HNXdbShm0/Ui3Ie4cS+TPORaxPcWBCEtDW3U2c
 WhNAgIHOJtUP/jN0Fzzvt0o36Q7KDUuaR5ojY0iB3VToJ5mZS7CRaHayFllgmQUgYh7KFz5LSPH
 /jT+t8kMFBGmUYNqcJrYXu+Hoo54gTipHkmU2Dl1GzF2+cnrAkT9unJTcCHkJ/ovCUuaP6Cst4z
 lnMGMDnMn4Y5tPFFwuQ7c5eM3vNhEcg0Xwj+QtmbNEWpg/H3Iaq2Vg4PLAgqkGuZRXcoTmCAhls
 XD08ikj9B0yhW++8M0rF2gvXIqjIfZUGLpwkTBKigvIV5p+yQitKm0+0pITpWwqDaVMYHsS7C0Z
 LYONxIjyAdkQvsOMRuA51FhR1ULyzTjK2Lm/w/lbXfYc3VlRpRNxkS8cU0fW7ZhG39rEkwAs8ZD
 012ZL6tenqNVGg288j/TuuuqQ7nI1LeXofyRJ7MSEKdsEBxbKyzRw=
X-Received: by 2002:a17:90a:d2ce:b0:35d:a1ce:c1 with SMTP id
 98e67ed59e1d1-35e353b3408mr2333810a91.8.1775718389659; 
 Thu, 09 Apr 2026 00:06:29 -0700 (PDT)
X-Received: by 2002:a17:90a:d2ce:b0:35d:a1ce:c1 with SMTP id
 98e67ed59e1d1-35e353b3408mr2333790a91.8.1775718389198; 
 Thu, 09 Apr 2026 00:06:29 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c65991a8sm21926708a12.28.2026.04.09.00.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 00:06:28 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, loic.poulain@oss.qualcomm.com,
 patrice.chotard@foss.st.com, varadarajan.narayanan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH] mmc: msm_sdhci: Use max-frequency to get clock rate
Date: Thu,  9 Apr 2026 12:36:20 +0530
Message-Id: <20260409070620.3655875-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cfPiaHDM c=1 sm=1 tr=0 ts=69d74ff6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=y39NnA_bIYQAsuYrnNoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: ULRAC_xldJXIhHpLNrMRr-Rzf1t-suXK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA2MSBTYWx0ZWRfX6WSiRQtHfcLE
 OqWhuTnLIzUqPt1OifXHfpMY2LcaeoYpXy24IAtBDmkmJoKh8JejaOrFokxUVGBZjm9Wo+EOAbL
 v1zE+Z3XQXBOJJECOPId1WLS7faS1FBk4bElk0BR0MLMtcHpwqTNZG5eIrMUXxd9u8NuzOsPuWf
 WbwnWKOzAOAyq2qtKPi+sgoo+e5SWn0oagZJeKEpwX/+bQXdv5H3vPtLR9D1pw68TqmC/pFeRUN
 i7VV2rwdE2COtxioayIrng3aN+CIX+B6r21W9lsFX15ZcCduna8vmLSIFPzt1YZXqQwpqL9BIEy
 VvNGRzwNZUEQ+5cUAohVwKG0xXg70LxUlT1uOrCkvoday2lOnwSG/Lo6EL7hYp5MzSuy9ID44Qw
 u8RUkoMbx118KyutBUUx+kx/JV3GQJi/nT9Ruxfz2fc3SB0z4EAjLp9ETVY9ay9hQ/0ks18w9Xe
 4ZZapdOb5fq3NdiJlag==
X-Proofpoint-GUID: ULRAC_xldJXIhHpLNrMRr-Rzf1t-suXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090061
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

msm_sdc_clk_init() uses clock-frequency to get the clock rate for SDC
clocks. However, the DT files seem to use max-frequency for the same.
Since msm_sdc_clk_init() doesn't find clock-frequency in the DT, it sets
201500000 as the clock rate and this results in timeout errors on IPQ
platforms. Hence, try to get max-frequency if clock-frequency is not
present.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 66f3cf2de4f..2e6120f18ff 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -71,8 +71,8 @@ static int msm_sdc_clk_init(struct udevice *dev)
 
 	var_info = (void *)dev_get_driver_data(dev);
 
-	ret = ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate));
-	if (ret)
+	if (ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate)) &&
+	    ofnode_read_u32(node, "max-frequency", (uint *)(&clk_rate)))
 		clk_rate = 201500000;
 
 	ret = clk_get_bulk(dev, &prv->clks);
-- 
2.34.1

