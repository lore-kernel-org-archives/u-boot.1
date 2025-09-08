Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A141CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F47383045;
	Mon,  8 Sep 2025 10:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="alFkftjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC85D8307F; Mon,  8 Sep 2025 10:34:15 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DB5800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 95f7287e8c8e11f0bd5779446731db89-20250908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=dW97JJJ28c04w7wlRB+3M3flgGLGihGFz3Xc/TkJANA=; 
 b=alFkftjgrN6k3IDQSDUnnXj8c39COTw+5FcA7+RtsiyInJ0cG9mxf/UW6l45yl9EnGUZ8TXtHZYuJ56TJ0NEo9+tWQ99N9/44I7fS4/FSVsToAu65y5cePLQjE+8V6aQVS3sz+OSImJ19YLs3O7k3CrPWh/uluUsayMPadZbfRk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:00e8f9b5-0768-44a5-897e-cf81d3f82c18, IP:0,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-5
X-CID-META: VersionHash:f1326cf, CLOUDID:bcf314a9-24df-464e-9c88-e53ab7cf7153,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
 -3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 95f7287e8c8e11f0bd5779446731db89-20250908
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1991573575; Mon, 08 Sep 2025 16:34:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 8 Sep 2025 16:34:05 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 8 Sep 2025 16:34:04 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, "Lucien . Jheng" <lucienzx159@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH v4 1/5] misc: fs_loader: allow returning actual firmware data
 size in request_firmware_into_buf_via_script()
Date: Mon, 8 Sep 2025 16:34:02 +0800
Message-ID: <9ded02581f5ccd985470239f31dc2f2fdd6aea80.1757315849.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1757315849.git.weijie.gao@mediatek.com>
References: <cover.1757315849.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

It's important to return the actual firmware data size as some
firmware files may have no checksum and need the size as the only
way for firmware validation check.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
Changes in v4: none
---
 drivers/misc/fs_loader.c | 6 +++++-
 include/fs_loader.h      | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 60296d55f23..87acd385e23 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -229,7 +229,8 @@ int request_firmware_into_buf(struct udevice *dev,
 }
 
 int request_firmware_into_buf_via_script(void **buf, size_t max_size,
-					 const char *script_name)
+					 const char *script_name,
+					 size_t *retsize)
 {
 	ulong addr, size;
 	int ret;
@@ -269,6 +270,9 @@ int request_firmware_into_buf_via_script(void **buf, size_t max_size,
 		return -E2BIG;
 	}
 
+	if (retsize)
+		*retsize = size;
+
 	memcpy(*buf, (void *)addr, size);
 
 	return 0;
diff --git a/include/fs_loader.h b/include/fs_loader.h
index a433be1eb99..1cf6d6dd05f 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -71,6 +71,7 @@ int get_fs_loader(struct udevice **dev);
  * @buf: Pointer to a pointer where the firmware buffer will be stored.
  * @max_size: Maximum allowed size for the firmware to be loaded.
  * @script_name: Name of the U-Boot script to execute for firmware loading.
+ * @retsize: Return the actual firmware data size (optional).
  *
  * Executes a U-Boot script (@script_name) that loads firmware into
  * memory and sets the environment variables 'fw_addr' (address) and
@@ -87,5 +88,6 @@ int get_fs_loader(struct udevice **dev);
  * Return: 0 on success, negative value on error.
  */
 int request_firmware_into_buf_via_script(void **buf, size_t max_size,
-					 const char *script_name);
+					 const char *script_name,
+					 size_t *retsize);
 #endif
-- 
2.34.1

