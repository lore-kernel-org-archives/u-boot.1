Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C758C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADAD68219C;
	Thu,  3 Apr 2025 14:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RyWR098c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B81F81F69; Thu,  3 Apr 2025 11:46:12 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D94581CF0
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 11:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53382nMB012589
 for <u-boot@lists.denx.de>; Thu, 3 Apr 2025 09:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=QRwOc4x1V7V7YsJI1oFiYzUE4MxwZgY6kxE
 A/Zt+R+M=; b=RyWR098clS57AHwbLJT9gSKUfaJcywIXEmwp3+pQETn+D08lKNC
 U46s7si6Lj9tScqni+Fp7d1Jbi96rUL3SyqDGb9V6WJEzqeiqQp8UzLbnW+W4aeM
 dHFLyYCgOisK7qjQfrW24Mkjs/6O8hH0tN9jJrBDWXYnAeJBsZrT87edeUqjHbtB
 sgH9rwY5Bht52TiQeACcEVnqLRcKZsb79i+dn3H0EbxvmbsFD2Lp1G03vOTRslxn
 rz2sAFaloyt/XXReqm88a+skMjW1AsUkS14g9yEgiAymNlUTy/dz8jGVXwtzFI/y
 eUfkYSSA1qVj1GG5t3JPqmo4pm3MuBwnG2A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ruadvkbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 09:46:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5ac559cbaso129496385a.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 02:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743673567; x=1744278367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QRwOc4x1V7V7YsJI1oFiYzUE4MxwZgY6kxEA/Zt+R+M=;
 b=BeYW9Id9V62fhkUboJMhK8qd7UBAFd4zGO15tdqyEMktipDijJ3kx6TYQKL2lQKNaC
 zo3NvaDVj8ACS7SekFpoL+KCffJs0Q3AZVgJ/olcv2iYDoqud30b7P7vf5lkk2zepOlY
 kor0z6XwPK7HtNmIpeFN3hMyU4x2YHCdVXLmDJAbb0uGYxUsUZetM3WfpmEsmxbMSwvC
 UV/fhUWx9osDidnrA1yEv9EfGstN8NnNfx2PVluK3fI8NH1cX26Hoc0Qpfx+cukwI2Up
 MXTIW9YHuAsgK0NUWIIeutMlkJDSXPVeQuZTdA7ZPY92qz08ED+eGQXxuF/M3Anr5Dmv
 uwcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9bkOXkeK3rVEz4I47UnEvi6jYQq9mzfuLhIAHvpDWE2mlul9APQN3wm8+HxIuAAlhzmD+eNo=@lists.denx.de
X-Gm-Message-State: AOJu0YzdP55HMkMVB5AsVdY5NY0zEoJQPfzsPP1H5IRjJVWW/u4wbgdB
 3zBW0mGBqQSNxPc7y6vr80BH7cBFAO8XBbp/medfib6k6Aoa+IJD3wufsxTc2vzjHaYfcqd4HlM
 GT7fyEVqSPv/lFCFYsPghyuYr1LIR/8SjtHHDgFGKszT1eD2kicwR
X-Gm-Gg: ASbGncuX3n2ApLoqD+8WeIoaicijJnOsu2bMw2k47HvrTQ7ugt9vQlL3Z5uCb31t9KA
 zbBJpg8Hn6ntn17Bq/mCmb1xSlq8yqGXH5JEdD1GSB5eqztxwBEhuPzHFzXWe+aQsnp31NFk6hr
 4q/yvuUrdJROxlXIZu5jrQzhMeMv6N1jrX+ZdBlHL09U1n0P5Z3kC/giVTk2zhfh3S3aypuxcH1
 W/Mahw2aD/tCIddniqSsJAqL9q236O9Srz5B/ahsXQmMbCz9vOpLINNRARuHefIH+QXSBGjB7YJ
 yZUWskCWTJ0BOOh0wsWFFJ1ZjgNnSeTr7w8Qdk1xKDIiy42nB33S/6UivARjx3YlqSD8dA==
X-Received: by 2002:a05:620a:4693:b0:7c5:a513:1fe7 with SMTP id
 af79cd13be357-7c7664592d5mr630197385a.33.1743673566746; 
 Thu, 03 Apr 2025 02:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCWhJxvzYQVj7A8RXI3dmqZ8AX41TGwrjuGnNKtADLEgbGnP9qnEaj1Kl4Yf8L38MT+JQnww==
X-Received: by 2002:a05:620a:4693:b0:7c5:a513:1fe7 with SMTP id
 af79cd13be357-7c7664592d5mr630195785a.33.1743673566389; 
 Thu, 03 Apr 2025 02:46:06 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630de9sm16606455e9.1.2025.04.03.02.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 02:46:05 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH] MAINTAINERS: board: qcom: db820c: update contact details
Date: Thu,  3 Apr 2025 11:46:01 +0200
Message-Id: <20250403094601.9207-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VI/dn8PX c=1 sm=1 tr=0 ts=67ee58e0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=W9PH34dilRoXDr_7K3EA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: QWRkjFpqMfQZa63gJDnGk3CbN0Glr4lG
X-Proofpoint-GUID: QWRkjFpqMfQZa63gJDnGk3CbN0Glr4lG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_04,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=868 malwarescore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030034
X-Mailman-Approved-At: Thu, 03 Apr 2025 14:36:19 +0200
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

Update contact details

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 board/qualcomm/dragonboard820c/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/qualcomm/dragonboard820c/MAINTAINERS b/board/qualcomm/dragonboard820c/MAINTAINERS
index 7ef905bdf69..28741d98334 100644
--- a/board/qualcomm/dragonboard820c/MAINTAINERS
+++ b/board/qualcomm/dragonboard820c/MAINTAINERS
@@ -1,5 +1,5 @@
 DRAGONBOARD820C BOARD
-M:	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
+M:	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
 S:	Maintained
 F:	board/qualcomm/dragonboard820c/
 F:	include/configs/dragonboard820c.h
-- 
2.34.1

