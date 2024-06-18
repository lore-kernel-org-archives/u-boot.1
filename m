Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9301C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 21:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E36A788307;
	Tue, 18 Jun 2024 23:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DEv0Eohg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1128839A; Tue, 18 Jun 2024 23:41:46 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5383E8644E
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 23:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52c89d6b4adso5337347e87.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718746903; x=1719351703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g7k9BtTdjjzYpnnwqSx7jrcx8gt24jwN3T2Nm2RyPXk=;
 b=DEv0EohglAOVvcchZX560FsU5S0DedS6Pa6hS36D7zqytagZLwL7+1CHjlN1D0yECC
 CD7KVJf4QgJHLvEkjQ7uc/zpmWcLjTq70ZXjK5EQu6vt9Y09gG0zmNTnxi+vX7+7i0/5
 353SUkT3zO0PU/qcbNgqvYZuZ/d3o5lba1IhZQZ/5K8+UN/iGSEiecnopL0vIaQt+029
 3CvRkED0PnSr4jT+9wytUM+KPUxh8CYCMB5NWskVz/BSyO9gW8PMQW0IfiR2pfcoIk5M
 O8P4PwpVpZg16zkXskEH+5DmpTzUYksfPC6lVqHVFed4VzsczYAQT1i8+18LYTzTKitO
 NWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718746903; x=1719351703;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g7k9BtTdjjzYpnnwqSx7jrcx8gt24jwN3T2Nm2RyPXk=;
 b=nHm0+CyAxTEW7lS2t7YlcFq/sIxbI7tXLK6mGZP0xKCcETTBR8m2QIyHkA0nnmeL5F
 lq/KilzLup0ko2RILdZJi4f7cyLY3qE/NzudFGnSoh5QpI3DOHXlYsO0zVhX3R2mALcI
 IlMitD1HayMuqBjsmCBuKlfcvj28kKgRE8sh+6czV01+nODf2ODVN+cFZqYBBsAKoOQd
 uZHUH79U3ZCtnd9e631pX6klMTJs2pCMX1EW7jakQJaXHdgcH7Y0j4qv9KH3lIQXnVzu
 yUd/zbiUdIvtWqBXRRRCCTx9MgVrVfxJ215GeGc/BZPmJ+oKJSyYf8Nl+ALMtuA2iOUz
 Ty4Q==
X-Gm-Message-State: AOJu0YyjRetPDnT2ZfaEEibdUm0R5n5pHt5SQu1knVBip4C0OzS9rjDR
 vL+kQi0NorIVN9B9RBD0AFoGIoI9m+1UBZYGdmoopimEESUuEwRWOPQOmPQvmpQ=
X-Google-Smtp-Source: AGHT+IHZIL1z+wb+CAL98GpzdKi7cSRa4vsKIH9HNf7wWoP+CFLLlitthxQAj+Z2W2WWXfiIVWb82w==
X-Received: by 2002:a19:5e19:0:b0:52c:814b:3ac2 with SMTP id
 2adb3069b0e04-52ccaaa8dcbmr356921e87.68.1718746902954; 
 Tue, 18 Jun 2024 14:41:42 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ca287263bsm1603006e87.165.2024.06.18.14.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 14:41:41 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>,
 linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fs: btrfs: fix out of bounds write
Date: Wed, 19 Jun 2024 00:41:38 +0300
Message-Id: <20240618214138.3212175-1-alexthreed@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix btrfs_read/read_and_truncate_page write out of bounds of destination
buffer. Old behavior break bootstd malloc'd buffers of exact file size.
Previously this OOB write have not been noticed because distroboot usually
read files into huge static memory areas.

Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
Fixes: e342718 ("fs: btrfs: Implement btrfs_file_read()")
---

Changes in v2:
- fix error path handling
- add Fixes tag
- use min3

 fs/btrfs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4691612eda..3998ffc2c8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -640,7 +640,11 @@ static int read_and_truncate_page(struct btrfs_path *path,
 	extent_type = btrfs_file_extent_type(leaf, fi);
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 		ret = btrfs_read_extent_inline(path, fi, buf);
-		memcpy(dest, buf + page_off, min(page_len, ret));
+		if (ret < 0) {
+			free(buf);
+			return ret;
+		}
+		memcpy(dest, buf + page_off, min3(page_len, ret, len));
 		free(buf);
 		return len;
 	}
@@ -652,7 +656,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
 		free(buf);
 		return ret;
 	}
-	memcpy(dest, buf + page_off, page_len);
+	memcpy(dest, buf + page_off, min(page_len, len));
 	free(buf);
 	return len;
 }
-- 
2.34.1

