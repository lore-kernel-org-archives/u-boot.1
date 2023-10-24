Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80103C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 15:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA30B8701D;
	Tue, 24 Oct 2023 17:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="bKyEVlbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BEF8796D; Tue, 24 Oct 2023 17:48:34 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4AC864E8
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 17:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OFkb7V014774; Tue, 24 Oct 2023 15:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9bMf6Ws4vtt2RTh6Bno2x2VAuZUeaw9xJhWUq0oIKNU=;
 b=bKyEVlbsFZK5FAjZdNpyQZCXRYXwJVivC6T5QH9p0U1QiBHDTLsTuaXKj5nXOa3sAyB2
 le/PvZC659IMlh1RSAFzHYV4aH9WWp6e0iogJuhRKcoVKOd8eNczT+Nd95bknNm5CHIy
 4A69CFdOl5u68ugbUYfjAakGkwAfE0uL6ZEjHTsrPGb5e0FfPphnN5l+lpUi7XDsNoC1
 3oXrcxnVKqEnaHMtOHmSyE+XIOru5RvDzNvGuTp2A2uewKo572lIoosRYdR66ptpkY5n
 0SDiuPL4LHm3PuVRVktSwn4aaEjPBnNGqYY0qWgVrat4jh2ojS+PONPCd0hAz4K6RpAI 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgqrgae1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:48:27 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39OFkmXG016077;
 Tue, 24 Oct 2023 15:48:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txgqrgaca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:48:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OE80JC026865; Tue, 24 Oct 2023 15:43:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsynrd75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 15:43:59 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39OFhveW51970804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 15:43:57 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F285A58043;
 Tue, 24 Oct 2023 15:43:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2D1F58055;
 Tue, 24 Oct 2023 15:43:56 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.72.218])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Oct 2023 15:43:56 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v14 7/8] efi_loader: fix EFI_ENTRY point on
 get_active_pcr_banks
Date: Tue, 24 Oct 2023 10:43:53 -0500
Message-Id: <20231024154354.197524-8-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231024154354.197524-1-eajames@linux.ibm.com>
References: <20231024154354.197524-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0MJnI5mQpU-5R3xmMQOOCtViP7hzhM9b
X-Proofpoint-ORIG-GUID: WdCQWutgl2bbeR2WoVtKDNRtXA5lPF3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240136
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
index b87c7900a8..2eaa12b83b 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -717,16 +717,16 @@ efi_tcg2_get_active_pcr_banks(struct efi_tcg2_protocol *this,
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

