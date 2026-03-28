Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E092810BA425
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 07:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40ECD83F14;
	Sat, 28 Mar 2026 08:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mEaeWeri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E887283C14; Sat, 28 Mar 2026 07:01:54 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB1BB8394E
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 07:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngotra27101996@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c763c294cccso1916003a12.1
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 23:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774677711; x=1775282511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3rWUha5tdrdUYusGsLO/bnQLFbcmmdnYjkADhLg/p0=;
 b=mEaeWeriIHzG09ezGVTlqmrUhSXuGZTA4tAoNpHlpki+cpeeGcF8jLXkJYCsfJMe2s
 4YFtU4ldZslqMqwYAKGJaEUEEhsXhMy3Ko7LL2URchGivNlLOf7E01A6ptkjam5xJ+vb
 S+Pu2i8mq3YZ95pcrqBm2zK9Z1LFOxUB5uppk8Vm/hvc9YOESTlFPuPEcQLRijIwBpNa
 3nXCGNqqN/39RwEG0aaunwCNuDfg0YKh19QG7zdBe4VAGh4iGsN0zEwxC56umAuhpR1S
 7GTaF/PH9fY8FmyD/kGZNBJ1h6j6X82XuA1KOrCtHhUrbm37KpL82bLYBKa4A3MzKGnn
 1p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774677711; x=1775282511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u3rWUha5tdrdUYusGsLO/bnQLFbcmmdnYjkADhLg/p0=;
 b=o+XpJ0o1CI2NZ0NhzV3QDN7767Wpu1z4CI3hkvmACwAgPBxbfNsuBOP2BwCY5mGJHR
 mGh+w1fdbp0aNQXTgRIOuIC6/NXnWk2xlNzWki5w/N8ivHqf/SR9YIjHcgRCxildB9rc
 pL0P5Kku1VbZS4bU6MmWGUAdN0JsgikkjDtpepEpq5uw5qeAKNNbhQBgbTBgbgrqGmps
 VwkfBTw6bjAfpxahUV5JWM8+DHiU0ykggHDGSGHI0NF4XF5Oik1xYm5qg1lmcsROUZBB
 hF+I0kGYjXF6GhRnBvy6aSnyFw1D8xgdGxKB8/qtTklArdmvFFdizYUo3qeW4IiuDv5n
 kN7g==
X-Gm-Message-State: AOJu0YwdF649fzr5l8Om9PMfthYwQ5CgLHqRTqOOr13xFP05L8/410uJ
 d8PWNe3a9ihStnjuMfBM8ZNPZzPezaz63xRB4w3cLWJhLf3OE9f8NhPStM+QFhpz
X-Gm-Gg: ATEYQzwekS7KynzYb1WLnqKsr7sWt0aPrmDWQcO/fMjj+f3Obu8DHbybGcxLKHCj+I0
 BOQ35vxUlzNWI47LRH2xiy8ItxKPwSl7BzGeW8khVFWGFlEr8xT/tseZHdMYX+QeZaQo2T5vo+D
 JFnn26b7YxvikrH1kTfkG8jrz0y/c1KqImNH91v6bQ7XfV87LvMZtSjaUjSxb37V+huUkP9MCrE
 p7bEbwpygI6kO9J59nEfa0AIxd279juqftsL1iBT9aAfw8QmpVRHs8SkDcYifdNtEh30Ia3RQ8L
 X9Q8HiVEZK6TlydzONk3K3RN9NcP7+mz7wTxxQ+/5N3a4XecDc/fh4ZrbzM0vGvng3X2/3UniLe
 XICim5IVhZu134PW4vdOXPdpu/HBojBiFiuIXoJLylmz4ykxK7k3eamK9GJ+BdzPY1kjVRlHRAA
 2Qg7FER3fsn2+c9A7szaUEudXGzp2TtmLAwbsqAipcKUKyJIkEFacfd0/BvLzP41JRysi/SiAvx
 A==
X-Received: by 2002:a05:6a20:7352:b0:39c:39d1:dbf4 with SMTP id
 adf61e73a8af0-39c87bed5a0mr5436002637.46.1774677710845; 
 Fri, 27 Mar 2026 23:01:50 -0700 (PDT)
Received: from localhost.localdomain ([171.244.188.41])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76916d26dbsm902635a12.13.2026.03.27.23.01.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Mar 2026 23:01:50 -0700 (PDT)
From: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
X-Google-Original-From: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
Cc: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Vitor Soares <vitor.soares@toradex.com>
Subject: [PATCH 2/3] board: toradex: fix tdx-cfg-block prompt buffer overflow
Date: Sat, 28 Mar 2026 13:01:32 +0700
Message-ID: <20260328060139.63221-2-S4210155@student.rmit.edu.au>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328060139.63221-1-S4210155@student.rmit.edu.au>
References: <20260328060139.63221-1-S4210155@student.rmit.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Mar 2026 08:05:42 +0100
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

Replace unbounded sprintf() with snprintf() using sizeof(message)
as the bound for all prompt string assignments in
get_cfgblock_interactive(), get_cfgblock_carrier_interactive(),
do_cfgblock_carrier_create() and do_cfgblock_create(). The
previous calls had no size limit and could overflow the
CONFIG_SYS_CBSIZE-sized stack buffer if SYS_CBSIZE was configured
smaller than the longest prompt string (71 bytes).

Fixes: 8b6dc5d3943c ("toradex: tdx-cfg-block: Cleanup interactive cfg block creation")
Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
---

 board/toradex/common/tdx-cfg-block.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 0fc3759695f..d75a6754c68 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -508,7 +508,7 @@ static int get_cfgblock_interactive(void)
 			       toradex_modules[i].name);
 	}
 
-	sprintf(message, "Enter the module ID: ");
+	snprintf(message, sizeof(message), "Enter the module ID: ");
 	len = cli_readline(message);
 
 	prodid = dectoul(console_buffer, NULL);
@@ -521,7 +521,8 @@ static int get_cfgblock_interactive(void)
 
 	len = 0;
 	while (len < 4) {
-		sprintf(message, "Enter the module version (e.g. V1.1B or V1.1#26): V");
+		snprintf(message, sizeof(message),
+			 "Enter the module version (e.g. V1.1B or V1.1#26): V");
 		len = cli_readline(message);
 	}
 
@@ -535,7 +536,7 @@ static int get_cfgblock_interactive(void)
 	}
 
 	while (len < 8) {
-		sprintf(message, "Enter module serial number: ");
+		snprintf(message, sizeof(message), "Enter module serial number: ");
 		len = cli_readline(message);
 	}
 
@@ -744,12 +745,13 @@ static int get_cfgblock_carrier_interactive(void)
 		       toradex_carrier_boards[i].name,
 		       toradex_carrier_boards[i].pid4);
 
-	sprintf(message, "Choose your carrier board (provide ID): ");
+	snprintf(message, sizeof(message), "Choose your carrier board (provide ID): ");
 	len = cli_readline(message);
 	tdx_car_hw_tag.prodid = dectoul(console_buffer, NULL);
 
 	do {
-		sprintf(message, "Enter carrier board version (e.g. V1.1B or V1.1#26): V");
+		snprintf(message, sizeof(message),
+			 "Enter carrier board version (e.g. V1.1B or V1.1#26): V");
 		len = cli_readline(message);
 	} while (len < 4);
 
@@ -763,7 +765,7 @@ static int get_cfgblock_carrier_interactive(void)
 	}
 
 	while (len < 8) {
-		sprintf(message, "Enter carrier board serial number: ");
+		snprintf(message, sizeof(message), "Enter carrier board serial number: ");
 		len = cli_readline(message);
 	}
 
@@ -799,7 +801,8 @@ static int do_cfgblock_carrier_create(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (valid_cfgblock_carrier && !force_overwrite) {
 		char message[CONFIG_SYS_CBSIZE];
 
-		sprintf(message, "A valid Toradex Carrier config block is present, still recreate? [y/N] ");
+		snprintf(message, sizeof(message),
+			 "A valid Toradex Carrier config block is present, still recreate? [y/N] ");
 
 		if (!cli_readline(message))
 			goto out;
@@ -907,8 +910,8 @@ static int do_cfgblock_create(struct cmd_tbl *cmdtp, int flag, int argc,
 		if (!force_overwrite) {
 			char message[CONFIG_SYS_CBSIZE];
 
-			sprintf(message,
-				"A valid Toradex config block is present, still recreate? [y/N] ");
+			snprintf(message, sizeof(message),
+				 "A valid Toradex config block is present, still recreate? [y/N] ");
 
 			if (!cli_readline(message))
 				goto out;
-- 
2.53.0

base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
branch: fix/sys-cbsize-overflow-series
