Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA19CDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C9086E81;
	Thu, 12 Oct 2023 17:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="hC/vH5t1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E2E486E06; Thu, 12 Oct 2023 17:08:33 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C64886D6E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CF7Glu021761; Thu, 12 Oct 2023 15:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fUKOrp88pbIr50CnW5wB0IfDCj/Uze721+lvrgrjPGg=;
 b=hC/vH5t1ztvVcYzBdoEro4p/dz0ZEB8zoWewIFCK735NUhVdobW6vb2Ridrz2Td2UNq1
 yz2h7Kn/p6dw4F2MTE3Q62MgAksO3Ui7B6M7VegmEzdrauax2u0uDZeyqK0gw62zBWp+
 Lv/p6hwnLMlJoYf/CUMGXt+TaLWBUPnz7lsVzyXVAiL5+34Eashwsvq9TofjPZzMFGgD
 aVlr3mkKNY79hmkMGgRXY74JidXLy+ZcaOdAxfksSURdmBGFV2Wn0S2isPiakJmLYkU+
 WTUJP+sLQ2HMCrpkL9ObDhMhsjVqyE0YBFvqLbcWb/fjDI6fzmSrlsjQH7mGuWbEwNEe Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpk5p029s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 15:08:20 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CF7RYw022308;
 Thu, 12 Oct 2023 15:08:18 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpk5p019m-10
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 15:08:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CEYCf8024458; Thu, 12 Oct 2023 14:45:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnt0f66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 14:45:52 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CEjq1f37946058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 14:45:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA0BE58064;
 Thu, 12 Oct 2023 14:45:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7DED58065;
 Thu, 12 Oct 2023 14:45:51 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.23])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 14:45:51 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v12 1/8] tpm: Fix spelling for tpmu_ha union
Date: Thu, 12 Oct 2023 09:45:44 -0500
Message-Id: <20231012144551.679551-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012144551.679551-1-eajames@linux.ibm.com>
References: <20231012144551.679551-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3ZzbrnZF07O077rdNy3VMR5-ZcZ2sUNC
X-Proofpoint-GUID: vA5lUdZLeO6w7wPP8YWduM9mB68Z0hhc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 mlxlogscore=867 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120125
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

