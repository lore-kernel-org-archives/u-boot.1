Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE38AC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 08:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE0182D4A;
	Mon,  7 Apr 2025 10:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNdWHJcW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7E282CF8; Mon,  7 Apr 2025 10:19:44 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF55982CD3
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 10:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53766AHU008718
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 08:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zwhPqUs7PW7
 ddoYpTqJKMOvw4B+SsWYA0GunejhWArU=; b=QNdWHJcWZrrWIYVMBMXwtqQ4fYu
 NZj9E38Af9SteWMywmqZqtrPavAUxnb+xx1W3w7vN77Ov17NtmirnrvzqrRKVYn5
 RmtGJpOG4FcEmzhjUbVkLkCODqHZnJs62wklgZDQlzDCUcAxTIqmgpaNyZUiwmU8
 hTZj9x7BhHI8cjlWhs/X0PsmhvPjeOrq7lbP4Mk+lmb7INisIjkpaDtMAsQuMB/F
 artm4qnK9/pnfCDKfU7X4Kb3CaIRkmbQNgoIA0YG2gQ4mM1z7KD0JxMSR4hPVhve
 wCucrggfiHgVJB9kjahDEUt5GH24ZRi+GskDlF6ChA0bfj5PMuwDD8/byxQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrbeda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:19:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c5c77aff78so1235847485a.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 01:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744013979; x=1744618779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zwhPqUs7PW7ddoYpTqJKMOvw4B+SsWYA0GunejhWArU=;
 b=r6U46NvU6uQ/13cNT09ZEJgarpDdiMUj25uZwabqNonOt7GPnXId00iscy1gPIVlcQ
 fmdZcxLIZ1xl3KpmwWtwu6L8hruaaaWOkfvYujxH7eqHdqxb2NkgniiPzDK0zpv00KQy
 SibQzurvssV+I4S6/KX2m6vNgjvubbH5/SwvC307NsXOti5eEZIbXCQIUCg5rAWceeIf
 /6UtrMjSbc4oTpCr2heQw9RRIVu6aJC9tuAHJXY1UdaAj0ddXkRyG4kY9lxbUZpV8tu0
 bnzQknqpI0FG2G91NR7zznAMzW/3VLqnNUEvPcvF8ptfXFDCvR40UdKxknIWZrlEDfKm
 WB4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvfSQBKj9C9teoULEIMnlvJxndrHBNeCxd3oxCigrLhTSyWGqh7lJvmKo6Lw30nWB4wMaxvLY=@lists.denx.de
X-Gm-Message-State: AOJu0YwMQ3dA8cYXAsODDdUp5zS5I8yYxGDj2DoX+prze9vkFwdqHvxu
 RdnYayfV3AOK8sMOamZTvZ+F8/T6WBdqmAsaQ6ra5+sZ/9l4QPbehC8yqg1cchjdpGSBR0AyCxJ
 fHYb5Qe0kKd1uYQwTDOotLnn++2bHUKM8vKw+nnhXrWu7LnKSGDlBbSIMs0hL
X-Gm-Gg: ASbGncui3j4FA3OwqI06zG21qtHk2Tcw2s7Q+OH4b7FGY59J2o3aX8mCyv11OGUz4wK
 UFi9ONPg2HCXYWhk+lH5UwVlxEXBVY6q+uVQ2iw9odtqJ9d35EVFekzmz9WHZ/vyafkduKlPRsM
 mWJncqNiXGjxZuXTypQMtBQavqSKDCkDuWd1E25E06pPo7qY3/q0fNs973JnRL06RQ2/qHHmTiT
 07GmJ+do8Msg+XlHpzXi6qXWjcn2Bn9UbTPTxMn4LO0qNKlI1nWaKG/Jc4EpWVk+21FeuPmIomX
 DD5t66AUpOyyGN1FFutdGQsy9SBrdRqVEgsIos1Ga7pmMon064jSjvhG0BWXqoc6ImPxRg==
X-Received: by 2002:a05:620a:28c8:b0:7c5:57b2:2cb7 with SMTP id
 af79cd13be357-7c774dfade7mr1624787185a.56.1744013979516; 
 Mon, 07 Apr 2025 01:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGzx28z8p2bD7i/+1qTX6XfGCFPliY8iH1lCXmQwJJK2jy72Y/VljlLepEYmD21LyjhIUCuw==
X-Received: by 2002:a05:620a:28c8:b0:7c5:57b2:2cb7 with SMTP id
 af79cd13be357-7c774dfade7mr1624785485a.56.1744013979186; 
 Mon, 07 Apr 2025 01:19:39 -0700 (PDT)
Received: from trex.. (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169b4e4sm125815155e9.20.2025.04.07.01.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 01:19:38 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 6/7] mach-snapdragon: board interface to enforce fdt
Date: Mon,  7 Apr 2025 10:19:26 +0200
Message-Id: <20250407081927.138915-7-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: L5o9lVtnp1Yrlri2o0TYVgJGHSeV-YIM
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f38a9c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=5uKnyaFRDP6ZZ46_rXQA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: L5o9lVtnp1Yrlri2o0TYVgJGHSeV-YIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=962 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
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

Some platforms might require the external fdt to boot.

This change provides a mechanism to the board initializaion code to make
the requet explicit.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 2ef936aab75..1bca9dce20f 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -150,7 +150,13 @@ static void show_psci_version(void)
 /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
  * or for supporting quirky devices where it's easier to leave the downstream DT in place
  * to improve ABL compatibility. Otherwise, we use the DT provided by ABL.
+ *
+ * Alternatively the board can enforce the external fdt.
  */
+bool __weak qcom_board_fdt_external(void)
+{
+	return false;
+}
 int board_fdt_blob_setup(void **fdtp)
 {
 	struct fdt_header *fdt;
@@ -161,6 +167,12 @@ int board_fdt_blob_setup(void **fdtp)
 	external_valid = fdt && !fdt_check_header(fdt);
 	internal_valid = !fdt_check_header(*fdtp);
 
+	if (qcom_board_fdt_external() && external_valid) {
+		debug("Using external FDT\n");
+		*fdtp = fdt;
+		goto out;
+	}
+
 	/*
 	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
 	 * Bail out while we can still print a useful error message.
@@ -178,6 +190,7 @@ int board_fdt_blob_setup(void **fdtp)
 		*fdtp = fdt;
 	}
 
+out:
 	/*
 	 * Parse the /memory node while we're here,
 	 * this makes it easy to do other things early.
-- 
2.34.1

