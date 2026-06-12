Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4434CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED5384951;
	Fri, 12 Jun 2026 22:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZK96e2x/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB8784951; Fri, 12 Jun 2026 22:19:35 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BD3384949
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-517a5cafc3dso14192541cf.3
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781295572; x=1781900372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHLO/bJhAoXuOwGVkLKs1RWlC8CCSCFK5b5yj/jraxc=;
 b=ZK96e2x/xwXs4M2420FEJQaOr3Tx+/FSNky3naNN4oSXcWKhzY5M52URnKPyOexqKU
 R5RfOWY/bVm8q8dzhTAr9PdWyqPL8KWi9vFzS+DmIpArXSlyPCMWU/r+5iOisvr0gHy2
 NoquWOuvODoZ/3AJ9JRdg1Qna730H09Di/0OhZzCNofgISCCI2KuCm5vsY3fnf6SYa1Y
 nUJY3BeCAuqaQpxTSkD/CiwA/BP2lyRoxnInLzO/R0dEUUJZKoyPqT67Uq27KXaaMX4W
 HRZSV7rXQRi6WD/2sNNh0ovOH6JkH5HnEu7+9HxKu6ijt7CZwIsr2xYiIPzrXzWeAi7F
 qViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781295572; x=1781900372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GHLO/bJhAoXuOwGVkLKs1RWlC8CCSCFK5b5yj/jraxc=;
 b=ClOojk5f96SzNU6UvuXlRAqoEbe6QjqpKwF6qW8J5PurF0m8Qs2bJWt282trJrZrY9
 PuTHYbHRYlJC/SmePFEa7MBmmGGo5L6XIlHGPGxcg2yd838zFNNmXSh8TUYCrPJPX5DY
 WHe8l8/AS/v/4GhSXtxYunI0n77qS7TgK0Dciw05/XKmemCF0hADJCwzKgUCC1xbkmH0
 ekfb1VWa7MJI55zG5e/iZlzHOWNG9bJZJ4D/Uwdik59tX+BK4y2IGmQSLCo4yT1uUaYf
 e6xOBgDOkZyHc1Jlgrvo2FmoDWwY3OVPmBn9KUT9hckQdsXNiQR0l87fkY4QP2PYuvyP
 uXXw==
X-Gm-Message-State: AOJu0YyW1jP9lTsEFQeeJE3BL++hexcmp0qHsOOP1Trp6xJf2/lVRowC
 FLv+sd6Mcavn+mqEqV4DLsmMHPVS93rxU2paKdC1mRaBjY4kbLL/CRtbASu8Debi
X-Gm-Gg: Acq92OGUn/DoWD4rWdShSBJLIfjDZDB4yqE3ngYlHlUh16tuVi7l5rDHX/YbXGueSXg
 PSfp94uc3M0xcg5IBX4R53NC440g9XTzpfvKDH/tT6oqFLJ5JZq1u3KrWUxd4fPMcPrsG2DAiLN
 a5J/lVkcp2ovHE/0by1gUOxGb6/Ust0g7e9yEuqJRlnh0O1iESGN09dh3GJ6XJsEHv7PhamZUne
 iVzDREnShqA77waXoYbmQXE6J9OG2NQVUeG4hsNTOQvyfktGlKNTOd0CqEtMIo5OHz2WWo/M6QF
 5rEcwBJyy24NCHVUkJEsOOldQvXSHQYtEttMbFmZdZnFRX09686GSk0tJEo658udWD1lQtmyk8J
 YZC8dXcthqAB0bqQy03p5Ics0hBci4la/9E4Ru4lex1i7teu1O3JG625ZpbHcFre9vzSSBsIQwe
 wGcP1Wzp8y7NrOiU+aCrmKd2aUfNfUJoMIKg23rdaT5hhI29mnfcVYoR/xWrBfmpQbA1qU5xQZ4
 xZ0wGwv
X-Received: by 2002:ac8:5d06:0:b0:517:74f2:e57f with SMTP id
 d75a77b69052e-517fe25ba24mr62695501cf.15.1781295571919; 
 Fri, 12 Jun 2026 13:19:31 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb7a3c4asm31304551cf.14.2026.06.12.13.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 13:19:31 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH 8/8] cmd: tlv_eeprom: fix accessing invalid parameter
Date: Fri, 12 Jun 2026 16:19:01 -0400
Message-Id: <20260612201901.73657-9-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260612201901.73657-1-raymondmaoca@gmail.com>
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
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

From: Guodong Xu <guodong@riscstar.com>

=> tlv_eeprom dev
Unhandled exception: Load access fault
EPC: 000000007ffb351a RA: 000000007ff7c302 TVAL: 0000000000000000
EPC: 000000000024b51a RA: 0000000000214302 reloc adjusted

SP:  000000007ef3ec90 GP:  000000007ef48e40 TP:  0000000000000000
T0:  000000007ef3eda0 T1:  0000000000000000 T2:  0000000000000000
S0:  0000000000000002 S1:  000000007f05c0a0 A0:  0000000000000000
A1:  0000000000000000 A2:  0000000000000000 A3:  00000000d4017000
A4:  0000000000000002 A5:  00000000d4017000 A6:  0000000000000001
A7:  0000000000000000 S2:  0000000000000001 S3:  000000007f05c0a0
S4:  0000000000000002 S5:  000000007fffbbec S6:  0000000000000000
S7:  000000007f05c080 S8:  000000007f05c0a0 S9:  0000000000000000
S10: 0000000000000000 S11: 000000007f05afa0 T3:  0000000000000005
T4:  0000000000000009 T5:  0000000000000006 T6:  000000007ef3ed80

Code: 0007 3513 0015 70a2 7402 64e2 6145 8082 (4683 0005)

Command "tlv_eeprom dev" should not access argv[2]. argv[2] should be
only accessed by command "tlv_eeprom dev [dev]" command.

So add a guard to prevent this invalid access.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 cmd/tlv_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/tlv_eeprom.c b/cmd/tlv_eeprom.c
index 3127660dd9e..b2b0b5a6fab 100644
--- a/cmd/tlv_eeprom.c
+++ b/cmd/tlv_eeprom.c
@@ -450,7 +450,7 @@ int do_tlv_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	cmd = argv[1][0];
 
 	// select device
-	if (cmd == 'd') {
+	if (cmd == 'd' && argc > 2) {
 		 /* 'dev' command */
 		unsigned int devnum;
 
-- 
2.25.1

