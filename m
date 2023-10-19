Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3369CDB483
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 16:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC8D8874B9;
	Thu, 19 Oct 2023 18:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="dDphip4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB19A8745E; Thu, 19 Oct 2023 18:22:04 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C6B3874AA
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 18:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JGJVaZ009088; Thu, 19 Oct 2023 16:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9hT0jbAPiF0n7ZljUlwqFgAhHgdleI2rqCcY++Dk79c=;
 b=dDphip4+bxN8iOrsE05Ql5VrX+TP6GonztDosHcBHWnHl1S77Jjx1aKt0hFtxTJPl1QI
 u6ltPpn+OMM2csnelAm33F/R5ZKHlwU0fJECeUmw8lAxH7gvzgzZr8zG+qDJvJUR4xS4
 t+ulrfXUdit9NXkTF52gtm84DKhxqEpLdKmO+zrfgpgUskfYzcGCoWefCdHOxurfYN/9
 IoBqpLL7oKGsi34Ac4VX+sczG4ZHzoai9JNGMqG/SVu30i+roLqVEpraUJXDl8QIucCK
 gopG5J+uKxYpKmIDbFNd40ft8FkabLC/OOmzOisVnWx4cP47g37PlXX7ba81GbXJhIJy sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu7vgg6ku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:59 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JGKJv1012279;
 Thu, 19 Oct 2023 16:21:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu7vgg6kb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:59 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JEHnup020073; Thu, 19 Oct 2023 16:21:58 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6anhy3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:21:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JGLwXl38076916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 16:21:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0889758052;
 Thu, 19 Oct 2023 16:21:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE1735805A;
 Thu, 19 Oct 2023 16:21:57 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.89.2])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 16:21:57 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v13 7/8] efi_loader: fix EFI_ENTRY point on
 get_active_pcr_banks
Date: Thu, 19 Oct 2023 11:21:55 -0500
Message-Id: <20231019162156.80982-8-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231019162156.80982-1-eajames@linux.ibm.com>
References: <20231019162156.80982-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m23c4b_RKLUrCRbfaWGXwOb3kS9zMhYe
X-Proofpoint-ORIG-GUID: Xx7s-WzcAO0_NaXTh-o4Vd2eNHVONrgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

efi_tcg2_get_active_pcr_banks doesn't immediately call the
EFI_ENTRY() wrapper once it enters the function. Move the call a
few lines above to cover the error cases properly as well.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 7ada536568..dae1b166c8 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -949,16 +949,16 @@ efi_tcg2_get_active_pcr_banks(struct efi_tcg2_protocol *this,
 	struct udevice *dev;
 	efi_status_t ret;
 
+	EFI_ENTRY("%p, %p", this, active_pcr_banks);
+
 	if (!this || !active_pcr_banks) {
 		ret = EFI_INVALID_PARAMETER;
 		goto out;
 	}
-
 	ret = tcg2_platform_get_tpm2(&dev);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-	EFI_ENTRY("%p, %p", this, active_pcr_banks);
 	ret = tcg2_get_active_pcr_banks(dev, active_pcr_banks);
 
 out:
-- 
2.39.3

