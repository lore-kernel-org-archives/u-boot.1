Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E026C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 12:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03665874B1;
	Mon, 15 Jan 2024 13:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="zyn5vGEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46828743A; Mon, 15 Jan 2024 13:49:40 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7CFD874E0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 13:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d57945=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40F84c82025566; Mon, 15 Jan 2024 13:49:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=IXgISu0i/g3JrodBycaIQq7HQ/J3JTq0owHAvnAmH3c=; b=zy
 n5vGEVv1VkjwG8An6wAJJ8E/QxKegNU3iyAIXhy/Z+xi2cHeDp45GyzsbdIryXYt
 qrqUEirv2w2k/I0dsm9thhJznxbcVyTyeE9GzzwJtuRJw54HECcz7yKICE0/qtaV
 qYwbMgBuJkxXbTi0YuTil4i7s1aAv6lv5J7xPay/tPQ0cxeDPADmGIQThAj7Ymg/
 jfXzt+cD7abqoosHy3xc+tg3QFFpU+vH+KbaRTiH7oVNEaF5UnqzTcnWbvvh3h96
 6TiObPJaricdTG0nTaSUjj1YecHpSuyR8sudFXMOufsemd765zw+Ye3go3AbO4dL
 AvMPG3nPJmqlEaYIXJqQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmbh0g02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 13:49:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27EDD10002A;
 Mon, 15 Jan 2024 13:49:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 218E72721D5;
 Mon, 15 Jan 2024 13:49:38 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 13:49:37 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 11/12] board: st: stm32mp2: add checkboard
Date: Mon, 15 Jan 2024 13:46:56 +0100
Message-ID: <20240115134642.11.I266d8c1df18ce288bebb30c6b14cbdfa9cc6edd1@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115124657.39109-1-patrick.delaunay@foss.st.com>
References: <20240115124657.39109-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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

Implement the weak function checkboard to identify the used board with
compatible in device tree for the support of stm32mp2 STMicroelectronics
boards.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 board/st/stm32mp2/stm32mp2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index c97a7efff46e..9a881583d904 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -8,14 +8,28 @@
 #include <config.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <log.h>
 #include <asm/global_data.h>
 #include <asm/arch/sys_proto.h>
+#include <dm/ofnode.h>
 
 /*
  * Get a global data pointer
  */
 DECLARE_GLOBAL_DATA_PTR;
 
+int checkboard(void)
+{
+	const char *fdt_compat;
+	int fdt_compat_len;
+
+	fdt_compat = ofnode_get_property(ofnode_root(), "compatible", &fdt_compat_len);
+
+	log_info("Board: stm32mp2 (%s)\n", fdt_compat && fdt_compat_len ? fdt_compat : "");
+
+	return 0;
+}
+
 /* board dependent setup after realloc */
 int board_init(void)
 {
-- 
2.25.1

