Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF615C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 17:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22414871A2;
	Wed,  8 Nov 2023 18:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fekeSrYT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 406858716E; Wed,  8 Nov 2023 18:51:15 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E1D5871C1
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 18:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-41ccd38eaa5so75061cf.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699465872; x=1700070672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bpt0bR4H8I6B6riygEJD3UAhKy+WFFm8tpmXT0Fx8Yo=;
 b=fekeSrYT/xq8I0RTJoTJjtO+8Y8o6veWVIsIwmn2ChwDHXbhB3g19BNdKXe+FHN8L1
 53+RyDFYsi6qlnhRYigfhAWSqvQx0WdpbN+M4DO7Qy6RTEm3gSOj7un9OpQpeTMTbvBr
 h/A/jFfoJkqeQas0qpgkZXa8bemfr61U6H0DDLJofTpNJsMGNH8/i9waGMyaBNZ7Ggyb
 GgfbO5moc6IFnm2bfbISPcHRIO/CmjQHeaYtC/a1xcsouJFVt5b4CK3wTAn/R7nmf3K2
 +ihrxL51xPyMHBIcauZB1351ETjYPzLik4Yw8C7ppReUe3F0djUg28YsW0lcJM+5HjFi
 U/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699465872; x=1700070672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bpt0bR4H8I6B6riygEJD3UAhKy+WFFm8tpmXT0Fx8Yo=;
 b=ZKbFQKPVP72BPtKSMT2iWOOvJZLEetsMNXts7AaKmCyCk7kqa+25rbbwOL+Oqls6ue
 czi/7x6yEDxwGFKhxoLWaHvgRhPexN+WsLiqoosLfxJFoWceuvrOmzodiNxagpf+UBsl
 7Th86ST//1/YA3lZ2KsNJeoyNUWxLSpN8qkXx5zuHV90n6Owv+D/N8TyM32wPv1hiuqd
 edsAbkoJAWivFw10aP1FAR75ZGrUM0CdI8gQWX2wj/j4gTiu3F3CiWkUGc5CXXe57cAu
 k76NXdccBSypNlls9DylJTUFbdFGXnwXBtLXI0je+TL/9mwjsiQcv8CFJzZawEonQuki
 jHMA==
X-Gm-Message-State: AOJu0YzgPX5/ybCYboI2OO5YzPhkwKrrClGWItYhOQ2MIx/WGkjoU1e+
 DzmbWPTd4W1zB+i60iWO6I4=
X-Google-Smtp-Source: AGHT+IESBAFYWrf/pWPFc3C1zpguDoGlnZ1NlZ5hfVmBbNy/sCqXIC3k2XWfUChFdF88/chxLXpqBg==
X-Received: by 2002:ac8:7e8e:0:b0:412:2c24:f497 with SMTP id
 w14-20020ac87e8e000000b004122c24f497mr3572977qtj.26.1699465871767; 
 Wed, 08 Nov 2023 09:51:11 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 fp18-20020a05622a509200b00417fa0cd77esm1113894qtb.80.2023.11.08.09.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 09:51:11 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] fs: ext4: Remove unused parameter from ext4_mount
Date: Wed,  8 Nov 2023 12:51:09 -0500
Message-Id: <20231108175109.3507947-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The part_length parameter is not used. Remove it.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_ext.c  | 4 ++--
 env/ext4.c            | 4 ++--
 fs/ext4/ext4_common.c | 2 +-
 fs/ext4/ext4fs.c      | 2 +-
 include/ext4fs.h      | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index af836ca15b8..2f960956c44 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -29,7 +29,7 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
 
 	ext4fs_set_blk_dev(block_dev, &part_info);
 
-	err = ext4fs_mount(part_info.size);
+	err = ext4fs_mount();
 	if (!err) {
 #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		printf("%s: ext4fs mount err - %d\n", __func__, err);
@@ -84,7 +84,7 @@ int spl_load_image_ext_os(struct spl_image_info *spl_image,
 
 	ext4fs_set_blk_dev(block_dev, &part_info);
 
-	err = ext4fs_mount(part_info.size);
+	err = ext4fs_mount();
 	if (!err) {
 #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 		printf("%s: ext4fs mount err - %d\n", __func__, err);
diff --git a/env/ext4.c b/env/ext4.c
index 47e05a48919..da26705b8da 100644
--- a/env/ext4.c
+++ b/env/ext4.c
@@ -77,7 +77,7 @@ static int env_ext4_save_buffer(env_t *env_new)
 	dev = dev_desc->devnum;
 	ext4fs_set_blk_dev(dev_desc, &info);
 
-	if (!ext4fs_mount(info.size)) {
+	if (!ext4fs_mount()) {
 		printf("\n** Unable to use %s %s for saveenv **\n",
 		       ifname, dev_and_part);
 		return 1;
@@ -160,7 +160,7 @@ static int env_ext4_load(void)
 	dev = dev_desc->devnum;
 	ext4fs_set_blk_dev(dev_desc, &info);
 
-	if (!ext4fs_mount(info.size)) {
+	if (!ext4fs_mount()) {
 		printf("\n** Unable to use %s %s for loading the env **\n",
 		       ifname, dev_and_part);
 		goto err_env_relocate;
diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index f50de7c089e..ea9b92298ba 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -2368,7 +2368,7 @@ fail:
 	return -1;
 }
 
-int ext4fs_mount(unsigned part_length)
+int ext4fs_mount(void)
 {
 	struct ext2_data *data;
 	int status;
diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 4c89152ce4a..3b12ec54fa2 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -233,7 +233,7 @@ int ext4fs_probe(struct blk_desc *fs_dev_desc,
 {
 	ext4fs_set_blk_dev(fs_dev_desc, fs_partition);
 
-	if (!ext4fs_mount(fs_partition->size)) {
+	if (!ext4fs_mount()) {
 		ext4fs_close();
 		return -1;
 	}
diff --git a/include/ext4fs.h b/include/ext4fs.h
index dd66d27f776..d96edfd0576 100644
--- a/include/ext4fs.h
+++ b/include/ext4fs.h
@@ -147,7 +147,7 @@ int ext4fs_create_link(const char *target, const char *fname);
 struct ext_filesystem *get_fs(void);
 int ext4fs_open(const char *filename, loff_t *len);
 int ext4fs_read(char *buf, loff_t offset, loff_t len, loff_t *actread);
-int ext4fs_mount(unsigned part_length);
+int ext4fs_mount(void);
 void ext4fs_close(void);
 void ext4fs_reinit_global(void);
 int ext4fs_ls(const char *dirname);
-- 
2.37.1

