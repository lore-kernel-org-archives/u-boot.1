Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EE9C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 04:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B8F688190;
	Wed, 15 May 2024 06:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A1F88191; Wed, 15 May 2024 06:37:30 +0200 (CEST)
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E4E87C75
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 06:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=tkos.co.il
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baruch@tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.tkos.co.il (Postfix) with ESMTPS id 6C54D440699;
 Wed, 15 May 2024 07:37:08 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
 s=default; t=1715747828;
 bh=X3Foo9o3RuBN8ePVT2QnwvTQ7lmOyMVGuaFH1o+cTK8=;
 h=From:To:Cc:Subject:Date:From;
 b=Zz3CGdytsB9SdNiOy0QvFQWCs1LOms5aQOe9wMQvytTYnqL91sNmASPoV8iJ1wacd
 B2dGf/uet5tBpik73s4F4PaHqbwJ+7FRCYcv1AwQnXkZv4EwszBuT2eBB4rI4hIiMQ
 OK7jk24YysgCEEEqBAXnLAZsv037HJWlAnQfdvxq3P+do6YJoUTxwAe2bUFC0Jctf+
 npVfshv+iHuQU9r0skLZZ45PZ8Q8G0eYGnkwia0WSIsPT1MsUKsP5Cxpt8eCYKimpi
 OM1uaDOO41Q1c4oqbFD5BGl1EpqsbLiGQed8Jt03JIJNi9i4c62Jn3jH4h4QbvGrcL
 WPwXE3zvX8l7w==
From: Baruch Siach <baruch@tkos.co.il>
To: u-boot@lists.denx.de
Cc: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] fs: relax ext4_write_file() dependency
Date: Wed, 15 May 2024 07:37:16 +0300
Message-ID: <845fdc163529638fcd2c16ef084a075c61fadc76.1715747836.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
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

ext4_write_file() depends on CONFIG_EXT4_WRITE. Allow build without
CONFIG_CMD_EXT4_WRITE.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 fs/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs.c b/fs/fs.c
index bed1f7242f41..0c47943f3339 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -224,7 +224,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ext4fs_exists,
 		.size = ext4fs_size,
 		.read = ext4_read_file,
-#ifdef CONFIG_CMD_EXT4_WRITE
+#ifdef CONFIG_EXT4_WRITE
 		.write = ext4_write_file,
 		.ln = ext4fs_create_link,
 #else
-- 
2.43.0

