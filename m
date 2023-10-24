Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F4EC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D9E28703D;
	Tue, 24 Oct 2023 09:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Jtp0yrZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F1B870F1; Tue, 24 Oct 2023 09:26:34 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9122787030
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9CFD741F6F; 
 Tue, 24 Oct 2023 07:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698132390;
 bh=vAYOtRAU3QvyT0sFJzGYU2sSrSXKBnXxYsyMwonN0BM=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Jtp0yrZQfu00faPm2ltnbrpR+XGUMmIQVKpkWIIhK2D7PqEH1oYqrcEmNGQ3nhBCK
 xOOzt9n52RMBrcGJgWv2DH9sAwOxLjTpuwmxghoa81IGdTU2syjFUgthpm1PE+qooG
 FZW/fLC8/GHnmaeHOUo89rjkfYDUJzWUwZnqINzCxKRrh7qA3Lxk3A1+fptzqD5TqU
 gUkreDTfiFoto892W12b/JZ7AgzwgZJHtOZpzhKy8fJeX9kLs8kKj9pbvFMV+F+RPO
 lVWBd53gtZ0fabEexAj2dxNq8R8XvF0b/aA1SOS6k4f1dOKo7O9FhCmuItLFL9Ercp
 HCx5jY76l2x+g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Yanhong Wang <yanhong.wang@starfivetech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools: mkimage: fix sfspl_image_extract_subimage()
Date: Tue, 24 Oct 2023 09:26:38 +0200
Message-Id: <20231024072638.39798-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Do not leak file descriptor if writing fails.
Correct the error text if opening a file fails.

Addresses-Coverity-ID: 467054 Resource leaks
Fixes: 64fd30d367a1 ("tools: mkimage: Add StarFive SPL image support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/sfspl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/sfspl.c b/tools/sfspl.c
index ec18a0a77e..c76420ce21 100644
--- a/tools/sfspl.c
+++ b/tools/sfspl.c
@@ -99,7 +99,7 @@ static int sfspl_image_extract_subimage(void *ptr,
 {
 	struct spl_hdr *hdr = (void *)ptr;
 	unsigned char *buf = ptr;
-	int fd;
+	int fd, ret = EXIT_SUCCESS;
 	unsigned int hdr_size = le32_to_cpu(hdr->hdr_size);
 	unsigned int file_size = le32_to_cpu(hdr->file_size);
 
@@ -110,16 +110,16 @@ static int sfspl_image_extract_subimage(void *ptr,
 
 	fd = open(params->outfile, O_WRONLY | O_CREAT | O_TRUNC, 0644);
 	if (fd == -1) {
-		perror("Can write file");
+		perror("Cannot open file");
 		return EXIT_FAILURE;
 	}
 	if (write(fd, &buf[hdr_size], file_size) != file_size) {
 		perror("Cannot write file");
-		return EXIT_FAILURE;
+		ret = EXIT_FAILURE;
 	}
 	close(fd);
 
-	return EXIT_SUCCESS;
+	return ret;
 }
 
 static int sfspl_check_image_type(uint8_t type)
-- 
2.40.1

