Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41599C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 15:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FABF86ECA;
	Sat, 11 Nov 2023 16:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ew52qKmI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A5086ED6; Sat, 11 Nov 2023 16:19:42 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B2D86D10
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ce322b62aeso1538664a34.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 07:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699715977; x=1700320777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H1IHmBGDE19eL56G4zksE8VbJ4hUcjng25FSdtJgaLs=;
 b=ew52qKmI7F38E4j9OhzzJej2YRjjFTHJKXk9zhD4f1JOMC5lapLb+Hb8Z4EC1KUx3d
 A579n1kUJt2JN4081PNLvKz2tXsnOuADCHhpIGeJtRNuRd9bMW0vy7b44TCMIm4yHar0
 9Yu+tf+/iYR3EaglZlt2dTtwaE9ePt+01ZzzJ6iWeNO1TXkWDMHdl6jECrtQsnvdwxZ3
 zWxUKy7CDK830EUP2thvFp4gUEguGGkjKlGqLHTloP5JeigM1NFRUAUw0llPIJls603f
 sv4+yWeQDi+Ml/RD59I8La02Xw+4OsX38LSPMMR2b/wDxN3Y/XCEES2zGOepLUHVirCG
 Zm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699715977; x=1700320777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H1IHmBGDE19eL56G4zksE8VbJ4hUcjng25FSdtJgaLs=;
 b=eiiEVbVJOY4xQlLRP+sn9s3pPsHjyeT0y2y+vN88jBIFDhMLPvEw621rMbzX506IhD
 hs70lLLHCpS+5f1xQm6kfpFOkoN0aoAzCgU2Sagb+xbsp2ag1dFMIm6VNmYUwQ9AL1TN
 V8lkQXpboEKU+nofjZ3o2iItjFDMXF8w/3O65iZgdTs7Hp45PVf4pSf5O+4xP2XDyfQ2
 7XV5j9j4qSVnd4hfDKBr0uyNGCmsnXfw1LjsbEGbKpQmddqLoOahHpnhNGiRZqkzZjlX
 QV48BF7iHMHAvsTyFH8wtD10tUd/tAKkSrQX4qqBWaefrLlKEKYzCvdcpfDjrWwts5js
 W7LA==
X-Gm-Message-State: AOJu0YxNYgeSWz6iQeQg0LKF4jryc/ND2tsfvU9Uc598cXAEmQ6wfybY
 zlaeVLoouLsZUSMaNBnqFzJgdV9LeFs=
X-Google-Smtp-Source: AGHT+IFS5zyHp+IUCNrTA6MHA1b71/razOviwYPBGw5A5PLIRqwKjmNkNQ9TGhEVZjVLvjzUTbOiXw==
X-Received: by 2002:a9d:6c81:0:b0:6c4:d08c:6a2 with SMTP id
 c1-20020a9d6c81000000b006c4d08c06a2mr2435312otr.9.1699715977588; 
 Sat, 11 Nov 2023 07:19:37 -0800 (PST)
Received: from celestia.nettie.lan ([2001:470:42c4:101:c815:2350:916f:4ef4])
 by smtp.gmail.com with ESMTPSA id
 ds20-20020a0568306c1400b006ce2f0818d3sm260596otb.22.2023.11.11.07.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 07:19:37 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH] fs: btrfs: fix reading when length specified
Date: Sat, 11 Nov 2023 08:19:04 -0700
Message-ID: <20231111151904.149009-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
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

The btrfs read function limits the read length to ensure that it
and the read offset do not together exceed the size of the file.
However, this size was only being queried if the read length was
passed a value of zero (meaning "whole file"), and the size is
defaulted to 0 otherwise. This means the clamp will just zero out
the length if one is specified, preventing reading of the file.

Fix this by checking the file size unconditionally, and unifying
the default length and clamping logic as a single range check instead.

This bug was discovered when trying to boot Linux with initrd= via
'bootefi' from a btrfs partition. The EFI stub entered an infinite
loop of zero-length reads while trying to read the initrd, and the
boot process stalled indefinitely.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/btrfs/btrfs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 4cdbbbe3d0..1149a3b200 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -228,7 +228,7 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 {
 	struct btrfs_fs_info *fs_info = current_fs_info;
 	struct btrfs_root *root;
-	loff_t real_size = 0;
+	loff_t real_size;
 	u64 ino;
 	u8 type;
 	int ret;
@@ -246,16 +246,13 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 		return -EINVAL;
 	}
 
-	if (!len) {
-		ret = btrfs_size(file, &real_size);
-		if (ret < 0) {
-			error("Failed to get inode size: %s", file);
-			return ret;
-		}
-		len = real_size;
+	ret = btrfs_size(file, &real_size);
+	if (ret < 0) {
+		error("Failed to get inode size: %s", file);
+		return ret;
 	}
 
-	if (len > real_size - offset)
+	if (!len || len > real_size - offset)
 		len = real_size - offset;
 
 	ret = btrfs_file_read(root, ino, offset, len, buf);
-- 
2.41.0

