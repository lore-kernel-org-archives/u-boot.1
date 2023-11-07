Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6836CC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 09:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5ACA86DED;
	Tue,  7 Nov 2023 10:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="1WV/D5LA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F4686F90; Tue,  7 Nov 2023 10:18:09 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D2086DD2
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9675e29905=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3A76Trwm015372; Tue, 7 Nov 2023 10:18:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=AJzC+RB
 O44UsP5TDwImSqbDVdacR0OJ+YEgVNDrOfeg=; b=1WV/D5LANZMWYlf/FY82Voh
 3CnPsazWRqVv/KLdH6cbsoSwyHG1Ap3L83yOtZm4dSg4+E8QkCPANneAUyYoIiEs
 P6sao7g/aCMupx8apyZx0yGGLhCWhM0VMc5ctkOE3X8riHnhcPeueHd5tqpagn1L
 NX4Zafm0HSTvkyRQ9yAdIzpDt3ccrHqEfnK/fO+s2g/VGD2JzyafdfRWL/+eReju
 uEXpcDY7obHKWLY3JtEyd4LivdSMSKm9smUKux6ual8q0ngP33+SOjV8HsUMJ/IW
 BodgxdASmIAcYP1XITuc3uZa+RNLmqH1DdneQemwEdGWbmlrvtS3gBAq5obH5gA=
 =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u5eq2jxhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 10:18:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AAE1E10002A;
 Tue,  7 Nov 2023 10:17:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 18D53216821;
 Tue,  7 Nov 2023 10:17:58 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 7 Nov
 2023 10:17:57 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: <deffo@gmx.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>, U-Boot
 STM32 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] bootstage: Correct exhasuted typo
Date: Tue, 7 Nov 2023 10:17:40 +0100
Message-ID: <20231107101729.1.I843fdbc83d3f8522e4c43d47c72825b388643ac6@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
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

From: Simon Glass <sjg@chromium.org>

Correct this typo in the warning message shown when no more bootstage
records can be added.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---
I just cherry-pick the Simon's patch in the branch fix-bs-working
of the dm custodian git but it is not yet present in patchwork.

https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/8810b8dd3d233978c15203b23420fa819ab1e791

Regards

Patrick

 common/bootstage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bootstage.c b/common/bootstage.c
index a68d883c684c..0e6d80718fd5 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -137,7 +137,7 @@ ulong bootstage_add_record(enum bootstage_id id, const char *name,
 			rec->flags = flags;
 			rec->id = id;
 		} else {
-			log_warning("Bootstage space exhasuted\n");
+			log_warning("Bootstage space exhausted\n");
 		}
 	}
 
-- 
2.25.1

