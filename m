Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF71ED73094
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 15:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B0E8415C;
	Sat,  4 Apr 2026 17:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LqxHD5MN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6515D83C14; Sat,  4 Apr 2026 17:27:04 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3E6B83A8C
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 17:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43cf8fe9c2aso1541756f8f.2
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775316421; x=1775921221;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2xDFm3Kj+H5PjAtzXEa4wUX9xj4pjLrXMi8uYbQqOE=;
 b=LqxHD5MNKNUS6jLM8WtDFCPGy9aR4tl8yON+Q3zkILOI7Np+hpOb4z6MFQE6ZqYZRI
 Jx27vW5f4JOkS/gWWtugDOJ/V3GFWHprsK1Enor2kCnNAy6gFvDF2pnEzKtcxRFpA67u
 izTluDsoJV2uYDGIACal3G4sgg1D5/9x3oGGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775316421; x=1775921221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p2xDFm3Kj+H5PjAtzXEa4wUX9xj4pjLrXMi8uYbQqOE=;
 b=ghDhfQPKUPyBAcklDNAOZZIZmJEyzKZd6Tcgp89+TzXgHHVeZRejJCuOeUuVUt+QkZ
 GYgKmmmP4RtSb95oqxZFVZ13LrkCnVBM0sZerMJvLoTKdm0ZhG0egKcNhi9xfI3vyW0A
 DvpJh3plOGQsZg+T8QFp4Y2NVy6yku0XnsNC0Klugn6DQwF6GIDC5QNNpC2l06XD1Dsa
 aCLCzCzVAYZc/816EgbsRERVU0pb++RZBtVs2k1mIbdN8rN6R0oGpfeMCsEPGFGiDTbD
 LS2TjzB+u/X+tD1mwUcAWbvHoIzD9W4j0yJwJXB8ji/1J3aluaEJdDPCg8MWxETv1ncX
 R1PA==
X-Gm-Message-State: AOJu0Yw1PXcrGSRt+0Vr+e/f0QbAxh+wX3m9TWBTpeVtJVW6/JezSM72
 8uE+x75xh6BvHTI+I9hIS1vTYLyfGj0BhH+AuOeV6cDfx4vJjIznIP6qqsjnFL0L423D5d0phgd
 FA2fu
X-Gm-Gg: AeBDietZfVWsEh0UPEfYb+OATvI5r41nZi/IEFTzuH4Q62k5FakqsCe5xOJOMC6IFJL
 H+LqTm8tk9l93k/fy1Jnb+icQlNfjBc5AQfwez23UMyoxd7epzojvKRtHcCJXIgcgqBcNJPt9lY
 gfSU3OGMfFU++KG9XsK3UL5RLJ7I2DS36oNswMwbZTc1MBB9XVOyUjYJfj4+O6SO1WL4oYb+W9U
 +IzRE+yUWie7LphoP1wQmvXfjYzkKUJjeMeuK7CYRBekGT1seqSxIEYtOfqP/0kC2QrnuRGJGr1
 EJzhYtltKAvxF1iZloU3sVP+rLsfZdqyaHTi04W+VWHI8Ch3Nj6VDvTMBcqEOVrOrlHX0DeHwAB
 H2CbKuuuRxIVRLeiOc71H0HJI84tpknv74WapjCIBIX2wzPXSoUzlbRungt1gRBzhtTwKtM30Fj
 bHn/kwGtHnZ/dG1fDhMbBd3tkSQo7gPGWuA4AbL5mIEOBLsqbYlq67IVSc7N7awVEyU5k4c5OM7
 zg8ZYarIwhUCMSrb/BNGIKByvm3U8Vkk/qpnE81sYSNA6QFlzJr37Up5QIpgsD6AV8YFiJERYit
 Xy6OkqX6dbmEIPsrVQGqwabAeq3KWU4bUlo=
X-Received: by 2002:a05:6000:4010:b0:43d:1e97:d62e with SMTP id
 ffacd0b85a97d-43d292e4100mr10692538f8f.24.1775316420820; 
 Sat, 04 Apr 2026 08:27:00 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm28059462f8f.32.2026.04.04.08.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 08:27:00 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/7] test: cmd: part: add UUID lookup tests
Date: Sat,  4 Apr 2026 17:23:32 +0200
Message-ID: <20260404152640.3297713-6-dario.binacchi@amarulasolutions.com>
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

Extend the 'part' command unit tests to include partition lookup via
UUID.

This ensures that the 'number', 'start', and 'size' subcommands
consistently handle UUIDs as partition identifiers, maintaining
parity with the name-based lookup functionality.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 test/cmd/part.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/test/cmd/part.c b/test/cmd/part.c
index e60e0226b64b..8ab99e243290 100644
--- a/test/cmd/part.c
+++ b/test/cmd/part.c
@@ -72,6 +72,21 @@ static int dm_test_cmd_part_number(struct unit_test_state *uts)
 	ut_assert(ret != 0);
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
+	ret = run_commandf("part number mmc %u %s partnum",
+			   mmc_dev_num,
+			   "00000000-0000-0000-0000-000000000000");
+	ut_assert(ret != 0);
+	ut_assertnull(env_get("partnum"));
+
 	return 0;
 }
 DM_TEST(dm_test_cmd_part_number, UTF_SCAN_PDATA | UTF_SCAN_FDT);
@@ -112,6 +127,22 @@ static int dm_test_cmd_part_start(struct unit_test_state *uts)
 	ut_assert(ret != 0);
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
+	ret = run_commandf("part start mmc %u %s partstart",
+			   mmc_dev_num,
+			   "00000000-0000-0000-0000-000000000000");
+	ut_assert(ret != 0);
+	ut_assertnull(env_get("partstart"));
+
 	return 0;
 }
 DM_TEST(dm_test_cmd_part_start, UTF_SCAN_PDATA | UTF_SCAN_FDT);
@@ -152,6 +183,22 @@ static int dm_test_cmd_part_size(struct unit_test_state *uts)
 	ut_assert(ret != 0);
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
+	ret = run_commandf("part size mmc %u %s partsize",
+			   mmc_dev_num,
+			   "00000000-0000-0000-0000-000000000000");
+	ut_assert(ret != 0);
+	ut_assertnull(env_get("partsize"));
+
 	return 0;
 }
 DM_TEST(dm_test_cmd_part_size, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.0

