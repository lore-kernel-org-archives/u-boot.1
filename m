Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996EDCD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D19984669;
	Thu, 30 Apr 2026 10:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T7JsWu4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4E9484669; Thu, 30 Apr 2026 10:06:46 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 878FE84663
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so333530f8f.0
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777536404; x=1778141204;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRUth/tej3+7h0oPp5SVnZPyDPN+il6XelJ/U9ZGoW4=;
 b=T7JsWu4DRbTSjsG/ll5HFeai9dJENoO03HLgHLwQmaOABkHCwyKJnsexUeqnr+F0Dg
 AkN/Dl9c9ObbPp1Zv2QKwcOkrkDoZZjBXaTpM+P6m2MQ/mX2uucITGLLTCfb9vCprpAM
 Ntw8mA1pNGKzxColdEhQ5TatP9KrF9aQJviCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536404; x=1778141204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xRUth/tej3+7h0oPp5SVnZPyDPN+il6XelJ/U9ZGoW4=;
 b=rvPMlNvDlWHXKVbBUM9UglpsxaV2Xx3IbrDWmGTmc70pciwZxHZFOS4pBtAPk/jx+a
 arlCIsY2gvCu5fFTKIKIJ8AmW3E9W2rFB01tdZKm1OrCJPw/Qye4KOxJNFrKPteJ674N
 Fiu99kvzESRzJKDbn+N7KYQvu/XvCNCR++Mer1GfYtBacRpmK8MK5e42Ff3PrjqS+dnl
 DyyMKDs2tbnMEd6K4Xy794WQNnPupVxgljzP/ttvWzl9KoqL0q5lUDLpo7IKKvsyYZLc
 lHn7aePDJzDH13RYZSNa7yoSUoIkCvacBaiOFiFDuLRDxkjxbvR50KC5YlUbAOdXsyUn
 xrPg==
X-Gm-Message-State: AOJu0YztpENh/nS573+PePOibLAofmNNLoB4MVsO4aqRfmm0BYOEUvgq
 zMXVq/Q1aJgpOI4ilM2Ft/Lj6K8ESE1nBadnwJbIxMQhL83QWyaQRK/1IBzF/9IUz3fTTGa8NiK
 j9z8+
X-Gm-Gg: AeBDieulugyenPqJ6jxsqlQQOGI4i79cpjYGHzD1yAOWojLI3XKUeACKgYkezQMxUO0
 H2hWjrTT1ugWUhhlz6iX32JW1RhP+SfDqCKKkd0JWxDABIgWce638kUD83+fq7fqR49hXx126/h
 DmH+pKx5zDUDZs92eI8zeSdPA8EyeZbCQ2IKIW0smBE3EIXB+0HKNvodGqSkVgxuwJT3BfW6YBY
 B7NSeqQgdjUPhLQENZC9/9JO6l7yFvbl97pQhP2Fgl3zodEqMDS7hYmWUcvxrvsPPKMwisvSAUQ
 kpfLPsQb/B+G5SatgyZqI7r449wZ9/9TdhE10zDDfxhWsedV5+oOUUua3fqS7PrhbaRVdbc/PHv
 uqMmEaG13oOB2MI7nUhtM6doPw3Ugmyb0TX7FkgqJXCqAeU6jEUR0WvMhZhh3Ieq3EsEYfRwesV
 BW/2Nu9vaf1tTl06yrc3vn4vksDqBPNuMzAMylAIehdaOEAOwt1z+n1LFjLOiRBkwBvWl5ewpP4
 9kxVBXpYQMXxTs51Lehml8EmlWhIrKb1XVTopMOacGFx4wAyAR5DIZlJYoP/ewmQvmIuH14aYZI
 hjw8Ox6VwI7YdfYOrTNEM+UKGpDS0IA1EOI=
X-Received: by 2002:adf:ec48:0:b0:449:9aee:4573 with SMTP id
 ffacd0b85a97d-4499aee466fmr794176f8f.18.1777536403431; 
 Thu, 30 Apr 2026 01:06:43 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm668071f8f.31.2026.04.30.01.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:06:42 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 John Toomey <john.toomey@amd.com>, Jonathan GUILLOT <jonathan@joggee.fr>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 4/8] cmd: part: support lookup by UUID
Date: Thu, 30 Apr 2026 10:06:05 +0200
Message-ID: <20260430080627.849636-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
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

