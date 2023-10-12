Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E45CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C5E86D33;
	Thu, 12 Oct 2023 17:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="A9aAHjr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E38A86B1B; Thu, 12 Oct 2023 17:08:45 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBABD86A9F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CF6DXB025503; Thu, 12 Oct 2023 15:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9hT0jbAPiF0n7ZljUlwqFgAhHgdleI2rqCcY++Dk79c=;
 b=A9aAHjr30fLujKRkLUx+ndQzxk1hyiy8RNQE9DguNPmR1gtsyp3D3mHqV5BB72K97eHB
 CWeA8XO10FCXgglAcnAjtqHHA+TD0dYHsFEXEEvBLqXWb799lGxhmjaF4rUi+A3uhMPh
 1vvCPdi1oBECTuzhbBNJHLcQuKhAy1NeQvdJFJ8s9bmk3HSMMMRgdZw/k+OVfJpielpF
 RjFApZNxn+phWwDkW+7b5sM5Mi09en4jdnxuLIrBM2QYnCoK02r2nUgAjuPd4wH79kiS
 nNspYz05Fjvf6APsCX3fKsLW5beOoxK8KHr9AoPjDnNzcPNdfxpJDuH5qt382cSG1wXi xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpk0yrbv9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 15:08:17 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CF6WIh028663;
 Thu, 12 Oct 2023 15:08:12 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpk0yrba4-9
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 15:08:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CBr5ev024461; Thu, 12 Oct 2023 14:45:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnt0f67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 14:45:54 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CEjrpI24314598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 14:45:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34DAB58052;
 Thu, 12 Oct 2023 14:45:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05FDF58056;
 Thu, 12 Oct 2023 14:45:53 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.23])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 14:45:52 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v12 7/8] efi_loader: fix EFI_ENTRY point on
 get_active_pcr_banks
Date: Thu, 12 Oct 2023 09:45:50 -0500
Message-Id: <20231012144551.679551-8-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012144551.679551-1-eajames@linux.ibm.com>
References: <20231012144551.679551-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -be2og25qwugyKybErokffgwkSx_EsGP
X-Proofpoint-ORIG-GUID: Ytlg97AWjqfkYkNTdGs4r_RYP5xUwfcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

