Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E72EC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 15:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7F08797B;
	Tue, 24 Oct 2023 17:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="druyzw8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D880087440; Tue, 24 Oct 2023 17:44:48 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A5D8797E
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 17:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFejZ4029592; Tue, 24 Oct 2023 15:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fUKOrp88pbIr50CnW5wB0IfDCj/Uze721+lvrgrjPGg=;
 b=druyzw8CR0XfD3W8lfyEpfhXXIJ3FLzdI9bH/3ibGNyNJF+e+DAKtfT4vjttUyCEEVPY
 VWBUQYe7P8AKHMpYSr6H2PqHDEzMwLBR7BD//pKRAcu+JB1hPpFEy1vyslo0NqTRiwLQ
 JJPAMz5yPML6CiP/lxw5WIY4lzeeh/5x1N5Uo9oalMFWQVj7m0y076U4z+U4aLmN/gAB
 PMDLk5CupJAmRlACyK1hayhKpwLO/T7nq3nDnraiR6bBiOyw6O+gOzw5ARAlCrUwLdPU
 gFbJ77lslElgUCigo/cGcT6EkFIpi0Cz9G/NhLhMfxUCd3dSYqWjfVflTP8RV6PtDSi9 Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgs6r42m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:44:39 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OFfEIE030810;
 Tue, 24 Oct 2023 15:44:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgs6r3bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:44:05 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OEdSUJ005097; Tue, 24 Oct 2023 15:43:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvtfkg7w5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:56 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OFhtML52167210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 15:43:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BD9858043;
 Tue, 24 Oct 2023 15:43:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B5F15805D;
 Tue, 24 Oct 2023 15:43:55 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.72.218])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 15:43:55 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v14 1/8] tpm: Fix spelling for tpmu_ha union
Date: Tue, 24 Oct 2023 10:43:47 -0500
Message-Id: <20231024154354.197524-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231024154354.197524-1-eajames@linux.ibm.com>
References: <20231024154354.197524-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fXpcs19FeaKXulJAHavlbS3r1ZzlJM8E
X-Proofpoint-GUID: 8Vf4EfQMn01mz7uWTVuRZuD5f9hVNAZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=849 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240135
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

