Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45687C54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 11:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6503D87DEA;
	Thu, 14 Mar 2024 12:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="WW5T5TVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B44AA87CFF; Thu, 14 Mar 2024 07:41:10 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B3B587F40
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 07:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jixiong.hu@mediatek.com
X-UUID: d1841572e1cd11ee935d6952f98a51a9-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=A3LjOzOmIiKjrvWsj0QP2qVXykW+yr8tVyZinCWfs2I=; 
 b=WW5T5TVnilajpOE6+2eskYPXPpBjQOPnnFR4YiJP2UTHVyngPD5mYsmGyes/8swpstY9VScnlTa2VgqPabq6BR+ivse17/S9zvcunT03sFysN9iV4DgN2e3hwrFGd+CnSYiDK1GyhbH1PPRV0pVEHrjtYqKRyMW2shi2rrRxEjo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37, REQID:22f9b897-c5b2-4048-849e-8661993a25b8, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:6f543d0, CLOUDID:23f67c81-4f93-4875-95e7-8c66ea833d57,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d1841572e1cd11ee935d6952f98a51a9-20240314
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <jixiong.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 649379454; Thu, 14 Mar 2024 14:40:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 14:40:56 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 14:40:56 +0800
From: Jixiong Hu <Jixiong.Hu@mediatek.com>
To: <u-boot@lists.denx.de>
CC: <jjhiblot@ti.com>, Jixiong Hu <Jixiong.Hu@mediatek.com>
Subject: [PATCH] fs: ext4: Fixed file permissions
Date: Thu, 14 Mar 2024 14:41:29 +0800
Message-ID: <20240314064130.25113-1-Jixiong.Hu@mediatek.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.366300-8.000000
X-TMASE-MatchedRID: zs/B+fsn51OiwkztVCsqb7iMC5wdwKqdWjWsWQUWzVo0QmmUihPzrGPS
 xOujrIyY8Xs+MIRNTQVBAiJopeTv0DlcyhHfhEXKSHCU59h5KrEaJDwYgQY/f83zT82XTqF+G0u
 iJ5nq4vRu/AyldOGVntbXmuHFRooXCrAs37thYWWeAiCmPx4NwGmRqNBHmBvepuP9zg477pEqtq
 5d3cxkNZd/mwLf2BVU3jszJwahGh4EXTWUBADSqbwjUUJ/29hvVrOIwqwEu7BfCOKFKuVYGg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.366300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F5BE237854C77FA22AA794D3ACC9FEC5F2155F941F46AFCC6F87DEEBE268C9902000:8
X-MTK: N
X-Mailman-Approved-At: Thu, 14 Mar 2024 12:03:30 +0100
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

Modified the ext4fs_write function to create a new file that
inherits the inode->mode of existing file. To fix an issue
where file permissions are changed after modifying the contents
of an existing file.
---
 fs/ext4/ext4_write.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index ea4c5d4157..6da4a26b71 100644
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
@@ -948,8 +959,13 @@ int ext4fs_write(const char *fname, const char *buffer,
 			sizebytes = 0;
 		}
 	} else {
-		file_inode->mode = cpu_to_le16(S_IFREG | S_IRWXU | S_IRGRP |
-					       S_IROTH | S_IXGRP | S_IXOTH);
+		if(existing_file_inode) {
+			file_inode->mode = existing_file_inode->mode;
+			free(existing_file_inode);
+		} else {
+			file_inode->mode = cpu_to_le16(S_IFREG | S_IRWXU | S_IRGRP |
+						       S_IROTH | S_IXGRP | S_IXOTH);
+		}
 	}
 	/* ToDo: Update correct time */
 	file_inode->mtime = cpu_to_le32(timestamp);
2.18.0

