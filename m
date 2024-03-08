Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE210C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 13:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4621787EFD;
	Fri,  8 Mar 2024 14:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="azF2pfP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 433FB88077; Fri,  8 Mar 2024 14:34:40 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5784D8744F
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 14:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3797bb48b6=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 428ANYgS013915; Fri, 8 Mar 2024 14:34:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=LT6imjd
 1pbZ2pm3hr05e7A5Aa2LnDIyI6r7KoKAFsRw=; b=azF2pfP+CAZXXLGtC1mGeOo
 cuztc90U1f/kvX7fKvKq9AEXqS/gWuYWDrxJE0Fh2S6XwAn8I29+yu8wO/kNYSCG
 yMlxKTmVCRT0peEoFSA8U1/zTBiS4i/YidiiJ50rhi9JlZDZTDd8SHO50ZMRjN2A
 DXP8SGzsDMwHFpEnILl4tFzzQV5QFyr5dao/RCtZw+StvNZJnAiIvfCP2bBsP7qm
 arUADjk+3mtHf/ZbOhQABZ3AQN/m0EIQ+VSLSclC6V0iIgWtCu6+R8iGz8dPL/Gj
 GFcFc9PIZknAHxxDXgdWzT8+TLBGPMJEv2mxQ1aC4hHgADnzezvwnm4tSPpnFyw=
 =
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wmej5k4td-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 14:34:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2B19640046;
 Fri,  8 Mar 2024 14:34:31 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD34D276F28;
 Fri,  8 Mar 2024 14:34:06 +0100 (CET)
Received: from localhost (10.252.7.115) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Mar
 2024 14:34:06 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] fdt_support: fix fdt_copy_fixed_partitions function()
Date: Fri, 8 Mar 2024 14:34:04 +0100
Message-ID: <20240308133404.2619848-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.7.115]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
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

Move variable declaration at the beginning of the function.

Fixes: 163c5f60ebb4 ("fdt_support: add fdt_copy_fixed_partitions function")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 boot/fdt_support.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 090d82ee80a..f948cf8cd42 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -1053,9 +1053,10 @@ void fdt_fixup_mtdparts(void *blob, const struct node_info *node_info,
 int fdt_copy_fixed_partitions(void *blob)
 {
 	ofnode node, subnode;
+	const u32 *reg;
 	int off, suboff, res;
 	char path[256];
-	int address_cells, size_cells;
+	int address_cells, size_cells, len;
 	u8 i, j, child_count;
 
 	node = ofnode_by_compatible(ofnode_null(), "fixed-partitions");
@@ -1101,9 +1102,6 @@ int fdt_copy_fixed_partitions(void *blob)
 			if (!ofnode_valid(subnode))
 				break;
 
-			const u32 *reg;
-			int len;
-
 			suboff = fdt_find_or_add_subnode(blob, off, ofnode_get_name(subnode));
 			res = fdt_setprop_string(blob, suboff, "label",
 						 ofnode_read_string(subnode, "label"));
-- 
2.25.1

