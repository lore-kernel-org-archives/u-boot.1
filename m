Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E79E88D9F
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 15:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F9B84148;
	Sat,  4 Apr 2026 17:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T3tyHYcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8616E84101; Sat,  4 Apr 2026 17:27:02 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AE7284120
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 17:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cfac48bc7so1437135f8f.0
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775316420; x=1775921220;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bH/vQA47RNzuJc4JhmoSlpcUcqjPq5pSBmxx+vWuA/s=;
 b=T3tyHYcRCQwDiXCmZGiZrKSJTbrajf3pFXxaS+Ef1B2OrugnsmaaQle6npSqlILrnI
 5GXqx/cK4GbLbnnuwqe6KEddWA85uwA6aGaVSfmKSNta5x4CQ/xIX3A14lndPyr97SwV
 W1Lc2/N9N0XG6QPxkjVbt/txa2UHRrpYxMP8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775316420; x=1775921220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bH/vQA47RNzuJc4JhmoSlpcUcqjPq5pSBmxx+vWuA/s=;
 b=YRxdZBuNHe1QGl3/iUOz1M5ldlUx9FNmnpbUzbm9Q19Ccr4WAq7oTkF4FyVnMWbirg
 ni1Kt064sx5UBrDbihIHm8K2W3kBRWcZTLhtUXfMa+3Y+CB4S6vHI8vsHF2ApvGhM1gS
 5H69JWjHK/SQr4k85Rg72ldvSJq3KWcCAoXfJeg/DNiHGhg7SKCRc3WX8s0v94Quo6fo
 /C64UKH0cZnAPir3p0k/nKJGDZMyOJnt2qkgVE0Y9miQXvosCrlb8x/sRDiWgCcFCAfR
 c1R1QOAaQZgdk7rR9c5btBe8bHZpRoB8Wrflwbb2hQz4eGpSpBuokwdoR+LKp9sL+s9J
 HrQA==
X-Gm-Message-State: AOJu0YyMoCtfAcAv8bCOOUh6vnHKt3TujcJAsGRnu595vg+sYsTMXOZW
 nTXMN0o2RH/U38hZeLZ5fHTj+kb3F/iz2ye+w6ePt1X3QZZ6ZhAF7jEEA6sl6Unfu5vzdB4wKdU
 +zv4/
X-Gm-Gg: AeBDietByDaP3H+kcOYsmVA06rdR10M0jAnkFt/5Tj4aspDDI39RD5BUOHSejr1xiL+
 f3bUM9a6ja0wEpLq2r/h/LlheeXXojPq5Ergi0Szy88Hp5r06aMWOOsCclO+VKtV2b2beq9MEMw
 booQW8pspmQ3ajwr2o2Tm7SMcxEzLzBnEyjMxEx71R3LKgjaaJ4YFxKNW3LfPBYoeC5SQKxugcT
 L7snK6oD+SWnB7u+B+pR/MrC8/zaCJyREGJJaiJw7IJ/A4LYT/DdputNQPlOx5aPrqbnur442nR
 l/v0jiCmjKKMRkujLqwc8pttiq/bSz45+NJmkk5lvTdz+ixLUvhldMMgWPgfu6qXtkLdGejWaMZ
 tXvLTnybWu/qArvZIYRhPEWm2NWQyxghzCOB3HOGxeeoh3figL6M0d0Mb4y5f3uONa6IAw8K5/f
 xqp9MJBP9VdG2Mnp0Ve5H7W3WTTulwe0HG8pYChFojDlHnFnIwqxHJW5AZ2yU7cWyN47PBo24cX
 xlOxcQNKHYqvB2nyTCHn006Q3rEwkzHH6LrfQweXWNnvzLlzaG/U3CTIuP03scEuHBx5VjZtGfa
 7i877EBRxKNOMvaAzuQBzslt
X-Received: by 2002:a05:6000:2dc1:b0:439:fbbc:d593 with SMTP id
 ffacd0b85a97d-43d292e14b3mr10596467f8f.27.1775316419632; 
 Sat, 04 Apr 2026 08:26:59 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm28059462f8f.32.2026.04.04.08.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 08:26:59 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/7] cmd: part: support lookup by UUID
Date: Sat,  4 Apr 2026 17:23:31 +0200
Message-ID: <20260404152640.3297713-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
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

---

Changes in v2:
- Update commit message.
- Update help for 'part start', 'part size' to mention UUID.

 cmd/part.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/cmd/part.c b/cmd/part.c
index 975a0a08a99d..c46ed25f37aa 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -139,6 +139,10 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
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
@@ -309,13 +313,13 @@ U_BOOT_CMD(
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
-- 
2.43.0

