Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A21FCA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 12:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91DDE8362A;
	Wed,  3 Sep 2025 14:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="oYmwxLSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E86F835D8; Wed,  3 Sep 2025 14:26:56 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 632C88354B
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 14:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1341feccc4=raphael.gallais-pou@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BVFLS008803;
 Wed, 3 Sep 2025 14:26:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 PXery0EkTwFhsgyc45KbvKfY3Gic9n6DQJsNgo85PBY=; b=oYmwxLSVPU6AhtYu
 ZFDQBVqXQhRqQ5WeL6lVUfLfe2Af9xNmB6oytEYQwVgRQC1FducTjEYFWMgabHWH
 ZB2vLUz0z4Y/CDMh0rfAmI9JgU6qMsIg2omVvUCm+jb2oE4IiW2DMFxVi/vjrKWg
 uIGcxaH8mmDf4RY9Fq2HLFTBWhyc8WNbm1ihvPNVcZm6y2taYgwcgJi/DvRyjA0k
 bzVldh7sU5sB7iG/kqj4NQNzfvHoiD1dXb0B2/2bch95ZaOwL9jW8qAdiMqM7b5S
 wR8Cn/xu/x9r9s93+xeZwZmSDKNWU4yNcvZitFtGmf+HMngluIdr1It5Zj3nL2T8
 U7Wuxw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48urmxgyfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 14:26:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BD49740046;
 Wed,  3 Sep 2025 14:25:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C2D7539C6EA;
 Wed,  3 Sep 2025 14:25:39 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 14:25:39 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Wed, 3 Sep 2025 14:25:35 +0200
Subject: [PATCH v2 1/7] ofnode: support panel-timings in
 ofnode_decode_display_timing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250903-master-v2-1-5cdf73bff42c@foss.st.com>
References: <20250903-master-v2-0-5cdf73bff42c@foss.st.com>
In-Reply-To: <20250903-master-v2-0-5cdf73bff42c@foss.st.com>
To: Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Dillon Min
 <dillon.minfei@gmail.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [10.130.74.180]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
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

The "Display Timings" in panel-common.yaml can be provided by 2 properties
- panel-timing: when display panels are restricted to a single resolution
                the "panel-timing" node expresses the required timings.
- display-timings: several resolutions with different timings are supported
                   with several timing subnode of "display-timings" node

This patch update the parsing function to handle this 2 possibility
when index = 0.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 drivers/core/ofnode.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index e040e3f2806ffe74c58dcd82f36307351acd5a99..5a721b46e5a3214e7bd437739776362c2d22a3c9 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1221,13 +1221,16 @@ int ofnode_decode_display_timing(ofnode parent, int index,
 	int ret = 0;
 
 	timings = ofnode_find_subnode(parent, "display-timings");
-	if (!ofnode_valid(timings))
-		return -EINVAL;
-
-	i = 0;
-	ofnode_for_each_subnode(node, timings) {
-		if (i++ == index)
-			break;
+	if (ofnode_valid(timings)) {
+		i = 0;
+		ofnode_for_each_subnode(node, timings) {
+			if (i++ == index)
+				break;
+		}
+	} else {
+		if (index != 0)
+			return -EINVAL;
+		node = ofnode_find_subnode(parent, "panel-timing");
 	}
 
 	if (!ofnode_valid(node))

-- 
2.25.1

