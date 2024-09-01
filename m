Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C8DC54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E79288C4D;
	Mon,  2 Sep 2024 00:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XhZOeQ/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 478BA88C69; Mon,  2 Sep 2024 00:27:12 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 378DB88A12
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-82a1dadc2d2so146384239f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229629; x=1725834429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qx08FS+dheN3ziTV0qlu0NuHakNPP/nfPuCplfjsi7o=;
 b=XhZOeQ/RHUbi8fGT6Srt2/I7bbBzA+fYp3SkYPlcG89RYmYa0+0GLHoR5+gDGMFnNV
 JayFwWBMgS1AR5PIomAPWdCcT3bvVN/b70uHTSAQ48HzazMIir3UJOn57/IXZA1qnstu
 Bi0BdRwwqxWgFptgqJJhUyrFteQoF8CYpi/6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229629; x=1725834429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qx08FS+dheN3ziTV0qlu0NuHakNPP/nfPuCplfjsi7o=;
 b=jXuh6kZ6cL5RPkdGlRHN1WmZoRybpfy29lwwPn9k8Nl2nQIrwQRKy4zUpurBLyAEX3
 v5mv0Wl3+ItTMTmPxxe7xcbywakyNQ9oUA1uQcg6hP5jPmdiLBZY1wA5FGGVXRWE//dV
 qbGne5uhyIHEQaFl5uH348ohxR9svWV4ke4blMnktXUyTG//BcGIloHkVY6KFzVhwNA8
 ruGjfhg84/deDWDGVXxZUBgQXlwgnL2x1edb0SHlty8CoPfYl7nbyKXXiGuDv6aR3vAh
 uK0c5cHbJPIHNNbKLPLYgh3mTBbD/QWhVZ6AS5iItS4QC7SocTnTU/0/yVHMPdPsN97O
 4g8g==
X-Gm-Message-State: AOJu0YzVibuNvNZP3SoIHdWajiuzPiexRDTfSC/sB6hj0RkmvrSCYByN
 hijoYyFA9anhLqpgT7F5Y0m1kMi9KlxtdMm53qdTtwWzve2ROTnI9RHNvuzGeccyJdQhf/Gvre4
 =
X-Google-Smtp-Source: AGHT+IHhisHc9fRbM/+gG52RSxvGiCDckLRYPpaJUur792F+EfU1N0CHLal3gimb5Y8Fcz4JWe3emA==
X-Received: by 2002:a05:6602:1510:b0:82a:1d33:b598 with SMTP id
 ca18e2360f4ac-82a344c4f71mr648768939f.12.1725229628627; 
 Sun, 01 Sep 2024 15:27:08 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 18/23] read: Tidy up use of map_sysmem() in the read command
Date: Sun,  1 Sep 2024 16:26:29 -0600
Message-Id: <20240901222634.460873-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

Rename the variable to 'ptr' since it is a pointer, not an address. Make
sure to unmap the pointer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Correct the commit subject and message

 cmd/read.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cmd/read.c b/cmd/read.c
index af54bd17654..8e21f004423 100644
--- a/cmd/read.c
+++ b/cmd/read.c
@@ -20,7 +20,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct disk_partition part_info;
 	ulong offset, limit;
 	uint blk, cnt, res;
-	void *addr;
+	void *ptr;
 	int part;
 
 	if (argc != 6) {
@@ -33,7 +33,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (part < 0)
 		return 1;
 
-	addr = map_sysmem(hextoul(argv[3], NULL), 0);
+	ptr = map_sysmem(hextoul(argv[3], NULL), 0);
 	blk = hextoul(argv[4], NULL);
 	cnt = hextoul(argv[5], NULL);
 
@@ -48,13 +48,15 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	if (cnt + blk > limit) {
 		printf("%s out of range\n", cmdtp->name);
+		unmap_sysmem(ptr);
 		return 1;
 	}
 
 	if (IS_ENABLED(CONFIG_CMD_WRITE) && !strcmp(cmdtp->name, "write"))
-		res = blk_dwrite(dev_desc, offset + blk, cnt, addr);
+		res = blk_dwrite(dev_desc, offset + blk, cnt, ptr);
 	else
-		res = blk_dread(dev_desc, offset + blk, cnt, addr);
+		res = blk_dread(dev_desc, offset + blk, cnt, ptr);
+	unmap_sysmem(ptr);
 
 	if (res != cnt) {
 		printf("%s error\n", cmdtp->name);
-- 
2.34.1

