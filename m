Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E279CCDB483
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 16:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46660874AA;
	Thu, 19 Oct 2023 18:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="AY5DHEeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8104874B6; Thu, 19 Oct 2023 18:22:04 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4ECF8745E
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 18:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JGJV1e009060; Thu, 19 Oct 2023 16:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fUKOrp88pbIr50CnW5wB0IfDCj/Uze721+lvrgrjPGg=;
 b=AY5DHEeEBacbiMmKM8gz4bXaVUt7UgIC3bIh14OMQ77KwiKyhGvnoAHeh4Pp8EOEmC3Y
 7JB8QWZpOwaoMJHm91a/eGWYZpcQnXmAqCTVMtpsVR5U2lul9ABb96sSvcykPKDfevgL
 gQuPtuW/v2HRvOU4vN7N+WdPT9jhXH+4yPiqNNV9iVyFTwfLXmT7GjS1fdFSK4YngflV
 L0UB1L5TlB50UfB8PfuRaInsVF1PGeCK7v2MAMDvyue1EdRoLqJ/X6AcHL+6N3mnqBrd
 OqUCyf0NCYGVQTD1l+ey/uzc3TftPY5HdUYnCyxnfR7WHppRYrxdYMmpOxdxg7RjVla4 UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu7vgg6jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:59 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JGKCqu011734;
 Thu, 19 Oct 2023 16:21:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu7vgg6j7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JEQXxj020486; Thu, 19 Oct 2023 16:21:57 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6anhy3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JGLudx34472528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 16:21:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCFBC58052;
 Thu, 19 Oct 2023 16:21:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E1AC58062;
 Thu, 19 Oct 2023 16:21:56 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.89.2])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 16:21:56 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v13 1/8] tpm: Fix spelling for tpmu_ha union
Date: Thu, 19 Oct 2023 11:21:49 -0500
Message-Id: <20231019162156.80982-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231019162156.80982-1-eajames@linux.ibm.com>
References: <20231019162156.80982-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fvpn0az4iAqWW0TvnOFLO31UhDUBqUF3
X-Proofpoint-ORIG-GUID: H3d34ZhqI-D0ANyUy00b3URuUePXjjbb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=868 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190138
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

tmpu -> tpmu

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/tpm-v2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 2b6980e441..6684033deb 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -169,7 +169,7 @@ struct tcg_pcr_event {
 /**
  * Definition of TPMU_HA Union
  */
-union tmpu_ha {
+union tpmu_ha {
 	u8 sha1[TPM2_SHA1_DIGEST_SIZE];
 	u8 sha256[TPM2_SHA256_DIGEST_SIZE];
 	u8 sm3_256[TPM2_SM3_256_DIGEST_SIZE];
@@ -185,7 +185,7 @@ union tmpu_ha {
  */
 struct tpmt_ha {
 	u16 hash_alg;
-	union tmpu_ha digest;
+	union tpmu_ha digest;
 } __packed;
 
 /**
-- 
2.39.3

