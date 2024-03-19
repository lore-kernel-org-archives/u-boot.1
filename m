Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B83C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CAE687DE3;
	Tue, 19 Mar 2024 13:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="E3bDSmy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3557387861; Tue, 19 Mar 2024 10:20:07 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ABE18751B
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 10:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jixiong.hu@mediatek.com
X-UUID: d5c22608e5d111eeb8927bc1f75efef4-20240319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=l+SaChThKwvKcOL6hEYPfcxE5k0G7CYDfBcPL0Xh6qo=; 
 b=E3bDSmy4t8de70tYgNl2sbo0uFwWBCes2dhqhDQIHJtCdh+bdmWxAFGegugy+NfINgKHAeSru42p0cuNQwGErgu2PPS0It0JCwkFcg1ku7CznpqwVnvs8xBH76W6h2EX4BK6VM1hdl9LiFyQEX7a4yVAkIiGCWbZTSb34APHtl0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37, REQID:3c6d961b-bd97-4262-b15f-82229cbcc5ed, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:6f543d0, CLOUDID:94759390-e2c0-40b0-a8fe-7c7e47299109,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d5c22608e5d111eeb8927bc1f75efef4-20240319
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <jixiong.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1969830491; Tue, 19 Mar 2024 17:19:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Mar 2024 17:19:47 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Mar 2024 17:19:47 +0800
From: Jixiong Hu <Jixiong.Hu@mediatek.com>
To: <u-boot@lists.denx.de>
CC: <jjhiblot@ti.com>, Jixiong Hu <Jixiong.Hu@mediatek.com>
Subject: [PATCH] fs: ext4: Change the Settings of file permissions
Date: Tue, 19 Mar 2024 17:20:40 +0800
Message-ID: <20240319092041.8089-1-Jixiong.Hu@mediatek.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.676500-8.000000
X-TMASE-MatchedRID: WY68sLfT96/qouWR3W5zBuQoIU4rAATMYpovC7zX5q+8NrbzjPvzJ2sk
 psLNM/2rHMJVy4EIUAs9ihzfHXEWBGJZXQNDzktSyeVujmXuYYUEa8g1x8eqF83zT82XTqF+G0u
 iJ5nq4vQspKJBx9J3JNy0SYmVqqZBoNQxMWUln00dNyNDtbgUEX0tCKdnhB58I/9UW5M5dRMpg5
 yOcdoVgo6HM5rqDwqtCATVll4NZmW6iIz/g8qdPvB/27pBZw++CsmyDY1VjeP9felmTMluJw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.676500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6CF68B013EDFD8005F8D04123DC279952295EBEFB2314BE148A302E0F1908EB82000:8
X-MTK: N
X-Mailman-Approved-At: Tue, 19 Mar 2024 13:12:10 +0100
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

When a file is created in the linux and corresponding file permission
is set, if the file needs to be modified in uboot during the startup
process, the modified file permission will be reset to 755. Therefore,
when the ext4fs_write() function is called, if the file already exists,
the file permission of the new file is equal to the file permission of
the existing file.
---
 fs/ext4/ext4_write.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index ea4c5d4157..c0b4803700 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -847,6 +847,7 @@ int ext4fs_write(const char *fname, const char *buffer,
 {
 	int ret = 0;
 	struct ext2_inode *file_inode = NULL;
+	struct ext2_inode *existing_file_inode = NULL;
 	unsigned char *inode_buffer = NULL;
 	int parent_inodeno;
 	int inodeno;
@@ -900,6 +901,16 @@ int ext4fs_write(const char *fname, const char *buffer,
 	/* check if the filename is already present in root */
 	existing_file_inodeno = ext4fs_filename_unlink(filename);
 	if (existing_file_inodeno != -1) {
+		existing_file_inode = (struct ext2_inode *)zalloc(fs->inodesz);
+		if (!existing_file_inode)
+			goto fail;
+		ret = ext4fs_iget(existing_file_inodeno, existing_file_inode);
+		if (ret)
+		{
+			free(existing_file_inode);
+			goto fail;
+		}
+
 		ret = ext4fs_delete_file(existing_file_inodeno);
 		fs->first_pass_bbmap = 0;
 		fs->curr_blkno = 0;
@@ -948,9 +959,15 @@ int ext4fs_write(const char *fname, const char *buffer,
 			sizebytes = 0;
 		}
 	} else {
-		file_inode->mode = cpu_to_le16(S_IFREG | S_IRWXU | S_IRGRP |
-					       S_IROTH | S_IXGRP | S_IXOTH);
+		if(existing_file_inode) {
+			file_inode->mode = existing_file_inode->mode;
+		} else {
+			file_inode->mode = cpu_to_le16(S_IFREG | S_IRWXU | S_IRGRP |
+						       S_IROTH | S_IXGRP | S_IXOTH);
+		}
 	}
+	if(existing_file_inode)
+		free(existing_file_inode);
 	/* ToDo: Update correct time */
 	file_inode->mtime = cpu_to_le32(timestamp);
 	file_inode->atime = cpu_to_le32(timestamp);
-- 
2.18.0

