Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C1BC4707B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 14:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0EA8780A;
	Mon, 15 Jan 2024 15:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Ovblmrxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58FAD86F80; Mon, 15 Jan 2024 15:08:37 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE5087441
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 15:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d57945=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FDrZme008279; Mon, 15 Jan 2024 15:08:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=sKHf0Ni4uIXcbg0Q1NoeDZySrQQk2iKm83Ne3QkvRj4=; b=Ov
 blmrxgqOCITnw+OJEEYomSgpS/LoU+KZijFnyK6SVFQRLceIqXUCkh5p5UbNotfZ
 En1Vjlffz6tjNqU34zNEMkCHqilDIjGaF3pgs5pAzYKwyhTt2sll4xNObehXL53N
 gF4wdWwYaGyqoUulz/G/fnnCrWE5OUPzX9nHYwiiirrQqTXDhpRXBMVk0RnDwzjd
 Swo1VkiVqy4nXCjX5N9JEhA7IAPaz/qm9arEJXkvTbvQ1RfCx8tUhtJGvrw4pwSB
 cYkyh67sqtRQOPcjxQpiR1/K/ie4no2ewveqD81QCjwoPqJAne0GLHHII1z8kL6n
 ITXs8ORDw7R9rmnIXxQw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmddrua5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 15:08:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A6D79100057;
 Mon, 15 Jan 2024 15:08:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9ECBB298667;
 Mon, 15 Jan 2024 15:08:34 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 15:08:34 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 11/14] board: st: stm32mp2: add checkboard
Date: Mon, 15 Jan 2024 15:05:54 +0100
Message-ID: <20240115150451.v2.11.I266d8c1df18ce288bebb30c6b14cbdfa9cc6edd1@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
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

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

(no changes since v1)

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

