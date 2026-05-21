Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBA5CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE068486D;
	Thu, 21 May 2026 17:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="YncMYHSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6F28469F; Thu, 21 May 2026 15:54:53 +0200 (CEST)
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86575846DF
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L8D1Sh262999; Thu, 21 May 2026 09:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=GreLl
 VVR5jMCytcF8ESLZl1cMfEcdg9HLPLIx5YZsLE=; b=YncMYHSeVSxz+fb64u5a6
 UMvgYR2xkLalfmJfbfIRapt+5Rmzlc2kmCW/5Qogp5prEN28q4C5XZxk43NSdXVF
 QFZVQRYg+cSP7/l5Tq7dCF+PbaXI1V/EExMHTID8L7S0PHrg4N56moZhjQfn03vN
 l5yJ5GZoYxtoLbLrt7CFtLVeb+lAz4UtFkvmWCPmjRT5/SqXZjlxuJUKYb8Z5Sdd
 jjQUbwIhH9EvIbmhTWLcKgsT7clanQLr3foiohsvrtIY/HS8+rpSriy7BkAM/TE2
 dhUF0d2IEfCBfCNC2tO9Lcg76Aup9DnXNfXIswHkORhaqYjg7vwpxMfVQL/+b0on
 Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e95e2ek4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsjZm046942
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:45 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqs016286;
 Thu, 21 May 2026 09:54:38 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 16/16] mach-sc5xx: Remove unused image offset Kconfig
 options
Date: Thu, 21 May 2026 09:53:27 -0400
Message-ID: <b09f7c86dc65b1eeeca2d491821d5e4393ecfd0b.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ljbXMgrXaUdFBwQ6-DeYV5Q_XUVXyTd9
X-Authority-Analysis: v=2.4 cv=Fd0HAp+6 c=1 sm=1 tr=0 ts=6a0f0ea6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=3QXsFvmxxAkkNRvvH2IA:9
X-Proofpoint-GUID: ljbXMgrXaUdFBwQ6-DeYV5Q_XUVXyTd9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX+5dfMOE8cV/U
 RUlYCrqaT7R8sgxovXsej51d9zA+azuaj+1dSnQNOnFB6PRmZBqjfDT13SnM6QWRRbJ9E8Gqxrc
 rSELslfWjZ//pgQzUaqf63EOlTHFv4tSEmIqZ4V7FkuVLj1v+P7FwY8ceJUQjfxoj1AH4ljIOWe
 kV5tclhH2nHaf9TZp4173dNSSOd35dnPGvRKZ/xCKqJILKu2fLCZx1KagNldGUV8WlkcpkM4V/h
 1I8OQkAftkaCqll88TbuH/YZoBtLHEvyPwtUjhfV97NKmO1LTOx0onIIi81YCUG44RZb4dniZTu
 jM5h4kHbgiTB/C9pKexYd8Q9oQ3QPH9mKiMtP6lk/m7HDkz/Wyr77TmxPvXkl/f8IOnswTX6YZK
 ZRMHabSGLcbx2oJfRu8box5wlnLaxggFWC3RO1zq5WKaXp0G0vM/fTfbkSp3cfycPtsbPuMqz7X
 mhcXCYJo/ybaolgx8Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210140
X-Mailman-Approved-At: Thu, 21 May 2026 17:19:00 +0200
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

Remove SC5XX_UBOOT_SPL_OFFSET, SC5XX_UBOOT_OFFSET, SC5XX_FITIMAGE_OFFSET
and SC5XX_ROOTFS_OFFSET as they are no longer needed in the Kconfig.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/mach-sc5xx/Kconfig | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 44402b2568d..0f4e63a355e 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -116,30 +116,6 @@ endchoice
 
 endif
 
-config SC5XX_UBOOT_SPL_OFFSET
-	hex "SPL offset"
-	default 0x0
-	help
-	  The default offset where the SPL is located.
-
-config SC5XX_UBOOT_OFFSET
-	hex "U-Boot offset"
-	default 0x40000
-	help
-	  The default offset where u-boot is located.
-
-config SC5XX_FITIMAGE_OFFSET
-	hex "FitImage offset"
-	default 0x1a0000
-	help
-	  The default offset where the fitImage is located.
-
-config SC5XX_ROOTFS_OFFSET
-	hex "RootFS offset"
-	default 0x102000
-	help
-	  The default offset where the rootfs is located.
-
 config ADI_IMAGE
 	string "ADI fitImage type"
 	help
-- 
2.34.1

