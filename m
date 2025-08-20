Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12206CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 17:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD7E81E13;
	Wed, 20 Aug 2025 19:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GEpPnQXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1601582F49; Wed, 20 Aug 2025 18:20:20 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D72DB8006D
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 18:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=03278829c7=raphael.gallais-pou@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KFcvI6016862;
 Wed, 20 Aug 2025 18:20:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 9AxZFwbA/EIWXLEX/M9RCkQFS5uZmk2vj9oxuowKPqU=; b=GEpPnQXW3wC1XgQ1
 k/dW53fid8H1KphVeEdKHTsDcgjC5JfV52PN8Ot/+E8641XiG8hXXdB7wI7mKXEO
 J5sQ+7oXlsEzViNjPKiw1PbmVuaBJEI6w4MO34ajZziHnTQgg243PwPZO6qjGSmx
 OL3msCY1/TegR3198uJVlnbLvUFze4faMsb4XW5cZTbe8jhFhbWMStIvHgEyJLfW
 OEQPms3kHD/96O/NtjPBvjq97JG0pR4Cp1qQUrwU4Taa+JAAtMT6BwngX+HIxZ4p
 9P8l8j5b6e5VCDzZoHH3g7QjGSP8WIDxLXLH45tIKCtMfKR0a9jCVVaAMoG6TLUf
 YvN7Lw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n7w5tm9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 18:20:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 278404004F;
 Wed, 20 Aug 2025 18:19:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F6B072B811;
 Wed, 20 Aug 2025 18:18:56 +0200 (CEST)
Received: from localhost (10.252.7.99) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 18:18:56 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Wed, 20 Aug 2025 18:17:40 +0200
Subject: [PATCH 1/8] ofnode: support panel-timings in
 ofnode_decode_display_timing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250820-master-v1-1-fc76f18ab2fd@foss.st.com>
References: <20250820-master-v1-0-fc76f18ab2fd@foss.st.com>
In-Reply-To: <20250820-master-v1-0-fc76f18ab2fd@foss.st.com>
To: Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Dillon Min
 <dillon.minfei@gmail.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [10.252.7.99]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Mailman-Approved-At: Wed, 20 Aug 2025 19:14:09 +0200
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

