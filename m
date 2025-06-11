Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA1CC61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 09:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB00828A2;
	Wed, 11 Jun 2025 11:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bx/FdS1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5F382B20; Wed, 11 Jun 2025 11:16:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FFBB80050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 11:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DFKx013448
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 09:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=AGX650IkolazgrI4yCnDOK578v598F0A4OT
 IQHaJEPU=; b=bx/FdS1htAenQUPMm4k3YBh+Fp0GZaxU7KVwTZLj4C4VVg6qC7b
 IYvxXZW6DT0FFU/NJJipYnrtcyM6Oz/AMP2dULUpX/q7SJb+hUerhumWSs6qErKn
 WFjTkZTwYpBM/Zds1Tr75CQ8praMwoVQc+Px5JqgTiFqIIHZDmo1yz8fFQuPhQtm
 2RiehDQTutfD5UMTJxZIu7CreXbJTCBENAng2Yqh206BknulMoGa5eFtM3DAGH57
 VnjW9LqQv3qdsiawTJbqFjbbPt7RFZK29Fbhv+VixUjrIgYlJzmHymGlUJ/YfD7f
 B3D7z8BFvRiClrCcxOeWLWwbmZkUZhQdbVg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476fmnc0q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 09:16:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2358ddcb1e3so97368135ad.3
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 02:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749633374; x=1750238174;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGX650IkolazgrI4yCnDOK578v598F0A4OTIQHaJEPU=;
 b=Vg7rW3Bk6ZgwVe9E/hI0/Byh3tU/HYRaUx3amzYPv78IKUtEKTbaOibMwfKUb5nYoh
 J2KHJkzHfO7H5XTTuVZH+RG7SEmXkJw7dmkHyVcP/jkvcZGiudLSBCKsjVXmTJhInAIg
 uBYscIitKonjDBThCADmZc461U7NT6eVMPiN/EXWNX+cboNp6LoZRhDwc/v6VzBMtUzZ
 6riGIjsgUST+pdotk58Va9N+We1BBs2wiEeogPgP7HCBjxA/XGjpR3VOjTn3UnupOIbK
 lRT8fVnyvsshWS37rI486FwbvI+1G5RXD/4ZJiMEgZjrrKqBm6DZZSpYJuAk2efHNrvI
 LTfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMq6w52734s67Ku8TtK/1/5VaHDajc0zIx+fowcUWrDwra+iDNiQgO4g3yQXrJ+vVMgcbF2go=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8ILXYVli3V5Xd+N6hsq8C00vhkM+UOXVg5yiiNxn8JNJ8ZVTk
 YFf3FnCAzXICTxPQmnpJe8BRHjOfB0itEk4Ef0SpCiJxXsY2WuGKse2fW3dXtS+OPdRIg26NOWN
 +fca/r/a8VAEMChIsg/1jERgW5mbTqh/LxtNxCkllFVx3dN0ckCy0h8k+
X-Gm-Gg: ASbGncs/zHGNvrNkMOIUbgMk8MJiUCl0/gEPTSeWZvDhtR7i/H5K/2DozDUMs/ItojI
 BrmPdsUmqpqmSUieQPAIpdR45A30gok1WRwjJL6p3K/+dQ29ucnCDHhWjF9xow4st8h6kRIYoSY
 BbWbPh+x7jYRWNfkEJ9skusHq7IgcjGPoJm1Hjq/E7AsZfGcBD7QYt+QZMMeCFgxyBE2xjzsh+7
 JRpCpXZDaaddQH7CbDcrLbW1+C5WD6AQ6K5fsdd/HJj04QPiqPSvdZCEiGuNP2CdrLfrC3EOmsg
 LCoLYBsAEGha5YRBK+DDEeA3f0E2AcjGZxG8Ip5sxQcvMEQHuoHpMfo65tGWYR2gARUIFeTRh0S
 mOQEsP7vfA7NSJFLt8uMDH35+JMEqwjR/FIULjrMq2w==
X-Received: by 2002:a17:902:da86:b0:235:cbcb:48b7 with SMTP id
 d9443c01a7336-236426a012fmr31223645ad.34.1749633374448; 
 Wed, 11 Jun 2025 02:16:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDCezctEmj8wV45BqkuMcsv+XTiWpUs7Px7pgshFYd8H7cEUpRKFsTz/YVSfUgMzimXHOCUw==
X-Received: by 2002:a17:902:da86:b0:235:cbcb:48b7 with SMTP id
 d9443c01a7336-236426a012fmr31223195ad.34.1749633373882; 
 Wed, 11 Jun 2025 02:16:13 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603077f21sm83408595ad.48.2025.06.11.02.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 02:16:13 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2] board: qualcomm: Add MAINTAINERS entries for Dragonwing
 platforms
Date: Wed, 11 Jun 2025 14:46:07 +0530
Message-Id: <20250611091607.3512332-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u07vMfTnMKrXTW3i9uLtMxAXSGDGtIW7
X-Proofpoint-GUID: u07vMfTnMKrXTW3i9uLtMxAXSGDGtIW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfXwAy6Zp/fS1bW
 rKyw3z07XEqFn5qpmA8ROlFyMldOjPAeDKSLjmWwbq5z5xccE90IrksbNTAaIrPr9ALu0S0ByF3
 I74X3lWTjz9RpzMHXDe5md1gayFZZUIKjQWzM0xZj69Dgkjbl0LpETT6A4YbCcjnV9xSFPW+DcG
 86cxPR5WNLYA1J7AberSu2ZHZssE31LSXaQufv9krXp6rtcKnVXMrxQtmWV0qSNQ/0msX9Fg9mZ
 Y3enGsvclDjucrfgHDTG8d85inkXag6KyN8iZKf1G26dO//yBygKxTFZc1NHCHcSUzfe4oX8i9d
 fuozqjfgZk85t119V2TjJCSeg8/CoMGNe21QaWDOqSBa/Zr9atb6N8J6C/8v5IosA3Y9yn5XbQ7
 DucX+pY7L9TPEtA2nbVMmwrkumwDHfxpVZiYsrvbadZuT1uCTJiTRlZyfKYmpOzlgu4u6SO3
X-Authority-Analysis: v=2.4 cv=K8wiHzWI c=1 sm=1 tr=0 ts=6849495f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=8PpNXUQT7V2mpWS3gWkA:9 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 mlxlogscore=790 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110079
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

Added MAINTAINERS entries for the Qualcomm Dragonwing platforms, following
the discussion in the referenced thread.
https://lore.kernel.org/u-boot/20250603192206.GK1382132@bill-the-cat/

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Acked-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- Fixed no newline patch warning
- Link to v1: https://lore.kernel.org/u-boot/20250610093732.2060702-1-aswin.murugan@oss.qualcomm.com/
---
 board/qualcomm/MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 board/qualcomm/MAINTAINERS

diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
new file mode 100644
index 00000000000..16b9aac5559
--- /dev/null
+++ b/board/qualcomm/MAINTAINERS
@@ -0,0 +1,14 @@
+QUALCOMM DRAGONWING QCS614
+M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
+S:	Maintained
+N:	qcs615
+
+QUALCOMM DRAGONWING QCS8300
+M:	Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
+S:	Maintained
+N:	qcs8300
+
+QUALCOMM DRAGONWING QCS9100
+M:	Varadarajan Narayanan <quic_varada@quicinc.com>
+S:	Maintained
+N:	qcs9100
-- 
2.34.1

