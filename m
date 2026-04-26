Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A4AFF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2868D84150;
	Sun, 26 Apr 2026 17:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="W3tv7DC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D7D08412A; Sun, 26 Apr 2026 17:47:38 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3AC84309
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so5328495f8f.2
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218455; x=1777823255;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRUth/tej3+7h0oPp5SVnZPyDPN+il6XelJ/U9ZGoW4=;
 b=W3tv7DC7Zc23BIWmXihJKHGa6of/oR2entbgfAMcTb4ewFvafaRToC4y4M8+554JVg
 ZniT/aTXUMnzMy2bqlxzu1GxlPVjBYP8S0ltXPhZ5rIqCAdOVthfCrSjDa2QfXikLHLd
 2AvUF0loVbqCpWnYJ/edOSDr2Grvu1DpXGK58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218455; x=1777823255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xRUth/tej3+7h0oPp5SVnZPyDPN+il6XelJ/U9ZGoW4=;
 b=hVU7vwhmw0ZDLLCezJF238h6lM7FQewZZexjpnrEFU6WT1xkkZEsjcpIdGkR12Qx7g
 dRxj/bpk5UQFuyeP7Zz/rs9vAOyTJyINFHqD2efFiGRDtOm5bl0voGJXMKBoB/97rrUs
 onEZXd7y0ZWkXupzw8qvjV6y89ICr/oK2Ax44/ct911rZzwKV7e4W8UO0Y1h4opWMA/l
 nbOohSnCE0/bf2BdStACUSl/WOdZ27qh2sMN/cCJxhWEUOp4eUdqOPhnaQU2wiIljYI5
 BGcLl1l7MTh9xYEbWdinaSBkWBgdVJRD09Q83Nv/t39aYj4lzfgs46gb/8v8v8mbvHgg
 vpRA==
X-Gm-Message-State: AOJu0YwNicxKSaVIs6T43Gy7p1sSNIRrMzDcMW+J09sbB8GthPut3w9A
 o6yXTn8o1SZl7SC+rW0EWPAtno/KEq5rLFYxbCGlCd3/ZkNxH+qtOIL6dYryqUapzcWxulBSbiM
 MRsfP
X-Gm-Gg: AeBDievDpf2dxEMzav+LxKb5IwUyqIhmbMR9RpWo3/ztClpSqWffFTLG8lV5HgPqf5g
 8j7/T4ZfCN+18QWF9D40cLMtiiSxzJgIoPYNctPks8j+261bJFdIL4cz+crOJSLspDfSKAieYjv
 1YCrQeYl0DcMaTO6isXXlZngNSL8HWehUyMvU8uN4wF5Ksxzjdbo8tC4h8sM4GtSw5mEWjqcpkR
 nG46N6CvZItJfUZgjZoFqtCH5M5aDV3GKN6uh534kqywXGVdBTydCBJcSyjaO1oHwL9FAjh/Td5
 podjsRQVMgftazCDx+z4J6X2ISx7m8d0tljDdqa+z6WzAH3a9WCWSh3S38voUtEIt1myKSBgqQK
 peHGZI5oyDXEN15w6ai/gBTxlYMqsn6fQTKHXzELf9KBwdCFfvAMi/6V380Cy8ujGI+0UbVKqZd
 qVydeCCLbRnbzimSVwS6xPhJoPVwLQy6867d5mBcqIFH2BNMjSKjX/ngrAtpNX+YgHQQDrJuZTC
 8NG9FHA53DdWZEDERXjv5cya2HV6/Af0kf9AI2T1c+ePn94rdVhxJCSDxXQSKVrSpjo+pHIbndx
 tzqTNEFgxPnW+sjdQGVGnHwmNl++6A==
X-Received: by 2002:a05:6000:230b:b0:43d:7cb5:43b2 with SMTP id
 ffacd0b85a97d-43fe3db3150mr60692893f8f.15.1777218454766; 
 Sun, 26 Apr 2026 08:47:34 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm34489985f8f.15.2026.04.26.08.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:47:34 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Jonathan GUILLOT <jonathan@joggee.fr>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 4/8] cmd: part: support lookup by UUID
Date: Sun, 26 Apr 2026 17:46:57 +0200
Message-ID: <20260426154724.2042569-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
References: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v5)

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

