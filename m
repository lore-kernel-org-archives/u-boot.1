Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B269FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2187A841DF;
	Sun, 26 Apr 2026 17:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="N6m4PbZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14F6580087; Sun, 26 Apr 2026 17:36:30 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14ED080087
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so48914265e9.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777217787; x=1777822587;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1GVI373cyvvUNNV0++FED9gkmrJNOa3SBgfOLc2fAY=;
 b=N6m4PbZnG3bpJBuyEhd46iN5cQSZufwurDsG/dt7CcD3DKGNNe0OervIo4cKJWaTRU
 LWSVybUJhsZRIhq52HZJom65FTwTkPeLBhpJgW3Gu2Kq3MUvigujjggMblFZboWNYiuk
 iqLic5LOMb2RVbnN+4LktkTADdznpogp8LrU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777217787; x=1777822587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P1GVI373cyvvUNNV0++FED9gkmrJNOa3SBgfOLc2fAY=;
 b=YVGt36Vi79tcnkZW8twChL4f7RPCH7W2fs7rSH3bxn813yRPnrktjZVuWoO5edj/Xe
 xSjT9QCdjMswUiWH6Ms9p/KQd8ZR5irTldlOdFKH16caYZlEegW2C/6cnAf7dd4S9vJW
 c24mTa8u6oWzWo0n8VgRhJS9dm/rtey/iaF+/1MPmrN58LPgWSM8SgJGaBAbx2ra8Xvh
 3OcsurEznIpAdEJKOS6fDlBPhi6EB/6zcx48QJu7rBVdd8CZewks9v4o0yFe0g0q/f2i
 fFbkx6dC+s3B6Oqz7ABYo+0n8EjIheSwDLF3JpNfCEB1+JKogPDrtZ6GeNoLVYetnOp+
 Nq4A==
X-Gm-Message-State: AOJu0YyKP6iAE60f5wV4miMQQC8ciqwOA/jrrl+ORQWPFgQKdCqNdDaI
 ZS0+1MdH764NnT/CyUdgNlUNaHPEb0Y1GU+JfvRkao6cUrQ4oCceNhCpnr4qU5AlALip0S4jNVQ
 NXnJV
X-Gm-Gg: AeBDievE5oKgLG84m5ED+Mz9KZDM94/mU/z38p9fKLSm2FlY7DsP7KHullU2HZVapqY
 4VneR/lW0Se+Sk6GCje4uPFXMAdvExaKHidqgVtPHZ3ferla8OxpsAq4GPzxEh8B6Yk6uoeZZSV
 LezI6rPWMLRptvVOY/vn5/AhzV274PTE/2nOmxwwHT82TD6MQgNy6SXlaG9aVuRVxlHZrYDhCae
 W5NJzSwDmOcrfY7EusOLSWgp2sez09pKm1XIRFmNT6diKRWh4tCMRUpgxMdDJIQeqDMPJvvkO1R
 2OadEf/KRTG3j9sNKvCbeXpDDlmWHm+EouihgAvrCXAXTnpA79hW+IFJNupq79GJzCIDUhEbri9
 /eOaZOeAwxUAOZdspegKxHmsXifY5XqvRLkKc792og2CAqG3iRQTf5vti0PSFNc0sn58ujFveJ9
 SE5PJyQow3qJseoRXyo0D4sRZFMLMJPtPkSH9Z5IbNzQeWSmmm41D58Dq1GKWptRUCSi59lsdya
 TnlnLN/fC4RaDShzlebAWF2yNTQf8CAZhC+46C3ngiwk3QsLRNLLWPFggyzIjvmna+wZE5ZHfUV
 DmKl96XWHpXU98WbKFJ+i8arz3DagQ==
X-Received: by 2002:a05:600c:a305:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48a53cb8949mr270477285e9.14.1777217787265; 
 Sun, 26 Apr 2026 08:36:27 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5499b0edsm388438845e9.14.2026.04.26.08.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:36:26 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, John Toomey <john.toomey@amd.com>,
 Jonathan GUILLOT <jonathan@joggee.fr>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 4/8] cmd: part: support lookup by UUID
Date: Sun, 26 Apr 2026 17:35:29 +0200
Message-ID: <20260426153617.2039651-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
References: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
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

The 'part' command currently allows looking up a partition only by its
number or name.

Extend the 'number', 'start', and 'size' subcommands to support looking
up the partition via its UUID. Unlike names, UUIDs guarantee unique
partition identification, avoiding ambiguity.

The logic is updated to check if the provided string is a valid UUID
before falling back to a name-based search. The help strings for these
subcommands are updated accordingly.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v5:
- Update doc/usage/cmd/part.rst to reflect the changes related to the
  part command.

Changes in v3:
- Add Reviewed-by tag of Simon Glass

Changes in v2:
- Update commit message.
- Update help for 'part start', 'part size' to mention UUID.

 cmd/part.c             | 12 ++++++++----
 doc/usage/cmd/part.rst |  6 +++---
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/cmd/part.c b/cmd/part.c
index 5e520d707f39..3191d5861fdb 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -144,6 +144,10 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
 		err = part_get_info(desc, part, &info);
 		if (err)
 			return 1;
+	} else if (uuid_str_valid(argv[2])) {
+		part = part_get_info_by_uuid(desc, argv[2], &info);
+		if (part < 0)
+			return 1;
 	} else {
 		part = part_get_info_by_name(desc, argv[2], &info);
 		if (part < 0)
@@ -517,13 +521,13 @@ U_BOOT_CMD(
 	"      flags can be -bootable (list only bootable partitions)\n"
 	"part start <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the start of the partition (in blocks)\n"
-	"      part can be either partition number or partition name\n"
+	"      part can be either partition number, UUID or name\n"
 	"part size <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the size of the partition (in blocks)\n"
-	"      part can be either partition number or partition name\n"
+	"      part can be either partition number, UUID or name\n"
 	"part number <interface> <dev> <part> <varname>\n"
-	"    - set environment variable to the partition number using the partition name\n"
-	"      part must be specified as partition name\n"
+	"    - set environment variable to the partition number using the partition UUID or name\n"
+	"      part must be specified as partition UUID or name\n"
 	"part name <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the partition name using the partition number\n"
 	"      part must be specified as partition number\n"
diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index b91f6541f7f8..a0e7be08a9ab 100644
--- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -52,7 +52,7 @@ The 'part list' command prints or sets an environment variable to the list of pa
         an optional environment variable to store the list of partitions value into.
 
 The 'part start' command sets an environment variable to the start of the partition (in blocks),
-part can be either partition number or partition name.
+part can be either partition number, partition UUID or partition name.
 
     interface
         interface for accessing the block device (mmc, sata, scsi, usb, ....)
@@ -64,7 +64,7 @@ part can be either partition number or partition name.
         a variable to store the current start of the partition value into.
 
 The 'part size' command sets an environment variable to the size of the partition (in blocks),
-part can be either partition number or partition name.
+part can be either partition number, partition UUID or partition name.
 
     interface
         interface for accessing the block device (mmc, sata, scsi, usb, ....)
@@ -76,7 +76,7 @@ part can be either partition number or partition name.
         a variable to store the current size of the partition value into.
 
 The 'part number' command sets an environment variable to the partition number using the partition name,
-part must be specified as partition name.
+part must be specified as partition UUID or partition name.
 
     interface
         interface for accessing the block device (mmc, sata, scsi, usb, ....)
-- 
2.43.0

