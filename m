Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B857DFF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4E184119;
	Sun, 26 Apr 2026 17:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VZs9xOdi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D33CB84137; Sun, 26 Apr 2026 17:41:08 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D340A842D7
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so48927985e9.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218066; x=1777822866;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3edTpCbQLoF2GLZoQuCSJDpFP7hzTahHYvj6ql2yGM=;
 b=VZs9xOdi6vWK1flleRxAhFs18GDUiu5wfB64W42vkigzPz35yX2mCeBewhdhfB5op9
 nukBXaIDPltLOjF2qGiu1YhZc85gM+DBtDYGnY0muIOAygGWGn246dhE0BFIPb8vRDxP
 61tl7h0CcTQzPC7H0X4OiWv89yHHobPU2WSSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218066; x=1777822866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V3edTpCbQLoF2GLZoQuCSJDpFP7hzTahHYvj6ql2yGM=;
 b=PULRpJcsaYkI3osoWlKHMUixWXjCZr7zdOdKuPaWYHMYn5t27fIoFeab2K+b7YsL5T
 ABJwPHhv6heiaQyvjzcrJDAN0cHhAyCZucpGANeOyzNe4a6lByCMbDBFryjJWNVyhwRJ
 LmhtAOkKFKPBnMM+UCTEqNzfUR9wXpE5+oYXlM1a2BSLmBfBkvujxtZNLTi7nZMtVfoC
 f8iJIFtOi9vWHS7AlNqE9Zp1umbCVhlQ8PIeolAr7w8ssmEeWA8w2aXGvdmrsHeLbtzQ
 60FnmB0rmLBAClc3hBy5eVztWwIMQ2Q6wiLK85XEutiMmlsi0qPwkengfBAFlLjbveRb
 K3ew==
X-Gm-Message-State: AOJu0YwDNuyGxKdpmVpC9ejXo7tXukbfUl5Xh9IfMicrlDkPdrLhWWfV
 AgpOwvFhD+IcJysUEVB+oFzL9BzCJIGtmos3cZ64c2360r7tltlxmgCYnaWR3dB1qtyBQkMLUbW
 kztV8
X-Gm-Gg: AeBDietij/WaFOEXpzp2Oz4s/oZ0/vI2eDBb7FBe1uWT0R+tIzPfyMh2KEyPcGqXKJ7
 h7ToUnW7u1A2r2cdjjfOfyiLM4uJW4I+S5G6N6P/WEVkx9/89GwteVUUN3w26TYdeLqa/XxzaXE
 CJG8G5WXSwnu/SLWebxaMIZbl/b/PfhqwUZ0wcQAzOBlYSnQGrZccksA3YTZ8sdE2OrI1mT1b7z
 +L6V9WlQ7dFWdEvnyK1tbb5v9pw/zF8qRPrYPTl5xl3Kq5nxdC7DAijgD3AB+nZ7OG8FGlTXviI
 G4pE4EplvQxAz2GyJdoes1xtcqZmi26PKqSm9GQ8OxsijzE6PVWIqpgRKGswS2BSEbBNM9rzPCy
 MqyX7WsXmM334XsUaRO/WoV1Wr3opfYTJLc9P3jctOw3MMNiY9+syNIkzO70AuI49awYbdA+jeZ
 0TkDi6/y3KMk0sVgQc67LkgTaSx0zzPcHmW+rlkJ0E/sBuZsRtInfM8ne/8JwzNau8pYw7jAc07
 tIP2SnYHM0qna9BPdDAE51Al5FXLsH+a4Vjihp1Q3fBVvOHzD4YF3x0FANUq6ucwgS9iMD6Vv1J
 cS6hvBmBA541VEM15QeMvTK4rXBinw==
X-Received: by 2002:a05:600c:3150:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-488fb8b9debmr105416965e9.13.1777218066047; 
 Sun, 26 Apr 2026 08:41:06 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm802593765e9.14.2026.04.26.08.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:41:05 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 5/8] test: cmd: part: add UUID lookup tests
Date: Sun, 26 Apr 2026 17:40:37 +0200
Message-ID: <20260426154054.2040932-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
References: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
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

Extend the 'part' command unit tests to include partition lookup via
UUID.

This ensures that the 'number', 'start', and 'size' subcommands
consistently handle UUIDs as partition identifiers, maintaining
parity with the name-based lookup functionality.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v3)

Changes in v3:
- Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
- Add Reviewed-by tag of Simon Glass

 test/cmd/part.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/test/cmd/part.c b/test/cmd/part.c
index 5751dd315dd8..0069fe5bfea7 100644
--- a/test/cmd/part.c
+++ b/test/cmd/part.c
@@ -80,6 +80,20 @@ static int cmd_test_part_number(struct unit_test_state *uts)
 				    mmc_dev_num));
 	ut_assertnull(env_get("partnum"));
 
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partnum", NULL);
+		ut_assertok(run_commandf("part number mmc %u %s partnum",
+					 mmc_dev_num, gpt_parts[i].uuid));
+		snprintf(expected, sizeof(expected), "0x%x", i + 1);
+		ut_asserteq_str(expected, env_get("partnum"));
+	}
+
+	env_set("partnum", NULL);
+	ut_asserteq(1, run_commandf("part number mmc %u %s partnum",
+				    mmc_dev_num,
+				    "00000000-0000-0000-0000-000000000000"));
+	ut_assertnull(env_get("partnum"));
+
 	return 0;
 }
 CMD_TEST(cmd_test_part_number, UTF_CONSOLE);
@@ -120,6 +134,21 @@ static int cmd_test_part_start(struct unit_test_state *uts)
 				    mmc_dev_num));
 	ut_assertnull(env_get("partstart"));
 
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partstart", NULL);
+		ut_assertok(run_commandf("part start mmc %u %s partstart",
+					 mmc_dev_num, gpt_parts[i].uuid));
+		snprintf(expected, sizeof(expected), "%lx",
+			 (unsigned long)gpt_parts[i].start);
+		ut_asserteq_str(expected, env_get("partstart"));
+	}
+
+	env_set("partstart", NULL);
+	ut_asserteq(1, run_commandf("part start mmc %u %s partstart",
+				    mmc_dev_num,
+				    "00000000-0000-0000-0000-000000000000"));
+	ut_assertnull(env_get("partstart"));
+
 	return 0;
 }
 CMD_TEST(cmd_test_part_start, UTF_CONSOLE);
@@ -160,6 +189,21 @@ static int cmd_test_part_size(struct unit_test_state *uts)
 				    mmc_dev_num));
 	ut_assertnull(env_get("partsize"));
 
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partsize", NULL);
+		ut_assertok(run_commandf("part size mmc %u %s partsize",
+					 mmc_dev_num, gpt_parts[i].uuid));
+		snprintf(expected, sizeof(expected), "%lx",
+			 (unsigned long)gpt_parts[i].size);
+		ut_asserteq_str(expected, env_get("partsize"));
+	}
+
+	env_set("partsize", NULL);
+	ut_asserteq(1, run_commandf("part size mmc %u %s partsize",
+				    mmc_dev_num,
+				    "00000000-0000-0000-0000-000000000000"));
+	ut_assertnull(env_get("partsize"));
+
 	return 0;
 }
 CMD_TEST(cmd_test_part_size, UTF_CONSOLE);
-- 
2.43.0

