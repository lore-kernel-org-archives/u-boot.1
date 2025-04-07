Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A42C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 08:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3037182D57;
	Mon,  7 Apr 2025 10:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fWWh7mX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1392C82D57; Mon,  7 Apr 2025 10:19:45 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD4882CEB
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 10:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53769UV5031859
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 08:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JjRXmD6Lgw/
 5bclHUpDqgh1qOdsu2REdVGNP1foSpNc=; b=fWWh7mX25mWsOQJcIjFapwgBpha
 R1rR5iP8tqba/NBGAj9glu5Lg8EWHSJltjTviLBxP2eTjwI1mLP0MIotMAyG1x0t
 FhGg0SgkGnsxmgKtUZBIMP8AjA+TIvDrwJs0wSRYcCp8mOqDnsT9jRMFDRxTdVJV
 quqodDYlOV4IUNfm8S+rSOdicoBxo2a3kilZ36BL45ugxd84bYzdxGaLXk+E3jFp
 xAVYpUho12U6Tapn3gIYBU8pSqD8RRxyl2eyOUxbOGxhrD/lq8dg8i3UPXZ3ksQS
 X6IXEEUvb4RM4V/7VRmXGz2dkibBfvUcPX8pEHiMsgbdsL5vzZy76d+qIkg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfkbdkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:19:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c54e7922a1so915793485a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 01:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744013981; x=1744618781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JjRXmD6Lgw/5bclHUpDqgh1qOdsu2REdVGNP1foSpNc=;
 b=lrtlOy9qGDJ5ZpcCk2mzZdwIKGuFSm+Rud4EzwhxZS1mxqQEUyjIuROIbu0d6LXxdV
 503u2NqHghOLYh0J/0xXRSC2mwdhtUKQtrTLaXSLzj546eknQvaAuxuC3/NfJqLpXoov
 ZiYROsJzDojC+DYoTzu2iS5Nc80pBcqPB7VFkhZZNdVItnt99R6wQvL1iDMkMVChLDDu
 +iT81l75ldrxBmWj1wJEm5wx6ar5qIbEYIsF5pDxVDx7tQWnRzV8/yc5rRAfZ9bsQh3Y
 iPuJCzpPDw6ReCYjIDIdg8f3YKQ+yDJgSpFF1VTTd2qDaueBA/EBCqYMGEINbXyZ9rpp
 EyVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuLVCV4gPQyHYdbFrfEI9ri0VmqufHINCH9l36EMLaPPyfl9tV3UdIPoR1caYfZddk6lnCziY=@lists.denx.de
X-Gm-Message-State: AOJu0YwkBTvwEPRijmAYAyGwMTFsJQqKsCITaA8jqzSyb0i90xmFKPdI
 TzQJU1WGLaIRKw7yVXE8lWZAoXRbEJ+kCgEjHPsTAmfYFR0MoCBsDadeRkKFuAfdJBgf3DJneQw
 bqHh/RPZQK0wybjHQsirQntgjhiuVnZMSDNxwrPuOSNuLAxskI5Ik
X-Gm-Gg: ASbGncsTjKzTmZznyoEXDnXQ15idYUrgFfD6L2Xk7/oSIVI87cUki/r0hXSwXyqzRkX
 hvVJoPVBIFibiJrZjlou5hhozHf1BaNZtvT9GLV0vKLTStXisstCYHvnvkkKAPRPaiHJoi67KFw
 NvVoHn9ngQg+n/EvWfVOo4rUbZV5Xriil7gUkE9p0UKmZUVPPji6r7U+dfUoHrbDN0k+avk/U+g
 F+nMYeZmxHVprPjSTCyXjqVdzglH3/JlZ0YN6S3uBYPb3Wn7sxYWM4npumkeNi+uH05i79Pey/m
 jDOjbW8/NLK/iQ0ikeu3R87xDvaU8yyLx62ZXZN62FF9Nu4BtyJU7kNo6of28a5sryy4mg==
X-Received: by 2002:a05:620a:2995:b0:7c5:3e76:bcd7 with SMTP id
 af79cd13be357-7c774dffd10mr1843051685a.37.1744013980586; 
 Mon, 07 Apr 2025 01:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGmKpjExNZ3u818ifbRrAz+VXheAnlIU5eLWubqmjBlchQxuQ6uu4y6Zrxui/A+5MaYjOGXA==
X-Received: by 2002:a05:620a:2995:b0:7c5:3e76:bcd7 with SMTP id
 af79cd13be357-7c774dffd10mr1843049785a.37.1744013980216; 
 Mon, 07 Apr 2025 01:19:40 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b4e4sm125815155e9.20.2025.04.07.01.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 01:19:39 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 7/7] board: qualcommm: dragonboard820c: external fdt
Date: Mon,  7 Apr 2025 10:19:27 +0200
Message-Id: <20250407081927.138915-8-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZawerRoSGKJptQPTthkpiOC4OUCF52fq
X-Proofpoint-ORIG-GUID: ZawerRoSGKJptQPTthkpiOC4OUCF52fq
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f38a9d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=49tc9iYzIXWVrItQNZ0A:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=931 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070058
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

The chainloaded u-boot requires the external fdt.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 board/qualcomm/dragonboard820c/dragonboard820c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
index d3333a59db0..e7f477b69fe 100644
--- a/board/qualcomm/dragonboard820c/dragonboard820c.c
+++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
@@ -94,6 +94,11 @@ static void sdhci_power_init(void)
 			rclk[i].val  << rclk[i].bit);
 }
 
+bool qcom_board_fdt_external(void)
+{
+	return true;
+}
+
 void qcom_board_init(void)
 {
 	sdhci_power_init();
-- 
2.34.1

