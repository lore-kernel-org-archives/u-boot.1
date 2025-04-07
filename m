Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE696C36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A6282F54;
	Mon,  7 Apr 2025 19:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L60Lisnk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825C082F65; Mon,  7 Apr 2025 19:56:32 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3498E82F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dxej017537
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 17:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ifnhd5DRjcI
 Bvozccmlh5KJuYT2KcrqnZXdRLKmSBN0=; b=L60LisnkLe6iuVAvTBdCNoI6FNQ
 BPjP3zBrULdZg6Y31+ge0yh2CYj344/eY9iPv2HXpV3HiQfTDjSi5BMPkEX8i5Nb
 2nFcWvDBxtRq2yYMIQnS/164LRl8cD/+JPIgBp3LhlVVyW1jH6bIzPWePcoXi9uV
 YZlAHocSHYlhERqFw2Xu4mLfWS9N5tbzPV+A8xzTfOwFKVIxfK6sypLQH6x04Pa+
 Nfqc/1Oab1c8wMmHWZrB8T2X1/eVf3AMUIaXxCZyegjFpY/OmhMMQo3nsWyqchGq
 Aog714PJ/+Ku57IPjiTR/jYrmf1vwxfNbZwIEK/Tquu8yMyoUYmzzhZYqNw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3d1tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 17:56:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c54e7922a1so1025562485a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744048588; x=1744653388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifnhd5DRjcIBvozccmlh5KJuYT2KcrqnZXdRLKmSBN0=;
 b=fehF1SSm9xumGxLYbZL56JFQax5b+Ba2AYObvyzHw2DxWjRwiFIQPWJ5oLZfXN60ZQ
 I6Gp9ohRk4YWhOpj/xOJfBqluHOaBnk6bNDJiWKw8HDmqFZXLJz2fzWBTIspxzQh+ase
 O4x7RIzJkbWxMNP4ncCQRXYuyNdP56MDPrcMOLR0Z7iZROOClbiJR73BjfwizDZmtQgl
 CCw7MriyJHhxRIEcA2/RfcbtTs4SfIApfVcgg01sFZVmTuPeLybgzjmF8RcZIgQ5zkE6
 60MeaRYpB4zKhA5ihNF0u6wnSvJ47kS9SFQ3emPP83Z5H4z1yg2jGWUqKqQkYOhKVUTe
 gM+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbH+iIvsyU0NTrpDmYWAjk9xbCY860v2t2F+D/lhwVTvUvVji9S+t1aXtsyLpUe8zX50Rm2A0=@lists.denx.de
X-Gm-Message-State: AOJu0YxNNC1bT1h6/+S7LW1/oFLkVMgo0Nn3hn/x1zEeXJPAx3tZW3/j
 e2Ov0qwh68GqcA5t3l64lg4uwqRlZA0I9v+NoA+ruCX5sYrrdlQ78vzKlNvA0YwFLyC2QEt0kv/
 6NfdkCIPV50WsZ/dkTOJweaMxr/+rY08vWZMcF7bdQYCdbmgp4/Sn
X-Gm-Gg: ASbGncsVWGvzfF6dYWBAKlFs88BfA0J5kowmVnjNf6jQIy9jLYD+B7pPyX8jfSapV+2
 K8G8VUZW8nzLq2QypPkgc4ZkfZK2oDmswZbmyxZrWjuMGK8eLD7FzZFES3Sbg9Ws7HY8rEnv6/9
 +XcEWpYFCyyA43nEp3mANbPiRysUMGr9MCtcOx2YowLzzAn3Ha06GPvw1aNoT9n4560QtL2HDk2
 X00lqdsYAYHs6m/EbnaEfXjaXJeAMny686m+wjGSOcptjrijhYtZ4CHKVNm4ljEhQHFi1xTfnF4
 dqHyce2R9ak5qWJCTG/0W+/Ex5pbC0JD5PP3Ste9bGASc9rEEgfXmdxVN4kFXbIG0lM=
X-Received: by 2002:a05:620a:1a18:b0:7c5:674c:eecc with SMTP id
 af79cd13be357-7c774d718bfmr1726800085a.32.1744048588027; 
 Mon, 07 Apr 2025 10:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/RfwopNY07qt/Rkr18Pf/nv1NjUxX5gRXe2Szyi1F97yS1ZXcXSZiVaywowiOXJppzKISRw==
X-Received: by 2002:a05:620a:1a18:b0:7c5:674c:eecc with SMTP id
 af79cd13be357-7c774d718bfmr1726797385a.32.1744048587712; 
 Mon, 07 Apr 2025 10:56:27 -0700 (PDT)
Received: from trex.. (65.red-79-144-193.dynamicip.rima-tde.net.
 [79.144.193.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a1fesm139346005e9.3.2025.04.07.10.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:56:27 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 2/5] clk/qcom: apq8096: fix set rate for the uart clock
Date: Mon,  7 Apr 2025 19:56:14 +0200
Message-Id: <20250407175617.3494506-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AIYbLbXp77XlTOwy8HdypfIiC5lMI4m0
X-Proofpoint-ORIG-GUID: AIYbLbXp77XlTOwy8HdypfIiC5lMI4m0
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f411cc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=K4l/FCcx7sfGu+4G7WjjoA==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VxBHH_N8Pzh9LFQFIGIA:9
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070125
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

The function should return a valid rate.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-apq8096.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index c77d69128b0..bc00826a5e8 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -87,7 +87,8 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
 		return clk_init_sdc(priv, rate);
 		break;
 	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
-		return clk_init_uart(priv);
+		clk_init_uart(priv);
+		return 7372800;
 	default:
 		return 0;
 	}
-- 
2.34.1

