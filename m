Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913F6F4213F
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0437C8421D;
	Wed, 15 Apr 2026 20:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oBwWJab0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564308420C; Wed, 15 Apr 2026 20:33:14 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DBF5841CD
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso72756655e9.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776277991; x=1776882791;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMrUAAtuax7uvVus6CWUVq2R8GJCStf3Di3MtyLYARE=;
 b=oBwWJab0eHS/sepcDsMGuWVvcianrYs6QZAAaz6PDEvJ8EsfAmtynNs9ZDHVrM4QCr
 0xz8dLTnMa5rTa9xbdOh7UJRBJJ6vHWwHDZOhsnr56f73diMJTLSTEwryMhJt0Go9JPc
 1v83Be6vdF5M7hLnih4oorq0vQ025QbXdQ7Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776277991; x=1776882791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KMrUAAtuax7uvVus6CWUVq2R8GJCStf3Di3MtyLYARE=;
 b=LSMnzd/Zp5e65e2xLUXKEpJG2zj12uvCVREM/rkXUSL3q6nSoTqRq6XYM+uqM9jlBN
 xFnfbJH4gWW/fRkPIBmeHVU1MmpWbTKvzktN7t+U5I9OqH7HYAZvtKFlCzBo39XENU/W
 0EiZQbITQcmNt+mhdHaak6LlSc4kFsZ/Rtgd8BQ2GFyv2+dzg0EQ2Aaen2ZhNIFx6sqQ
 4AYLy0+SFREK2Cn7FDPNfLTdfdAohtfyi9Ll4CNG7fcHfcalzHrwdyuTZBzO1NINRc1w
 iltA9kmdXKbW0qR+4/hIXmjBJmfD46miWHdFiTy5bzgn0RJHi/9ZWb/VfMZXhT4Wgsn0
 BPnA==
X-Gm-Message-State: AOJu0Yz7P2ggMOiz+9Q7Ivsq7qxeRKP8dRBfYPmmncQU06tFi2OHyrbG
 z/wESoFPge9aahW26jVXYaLCmakAa2HPzryVM0fPUJP1nFRn6G6M0N1HPtdOJK2kPUQubJTnYqd
 gu+/z
X-Gm-Gg: AeBDievlrWhfAXyOCBP7RBE/1rLuMIAlYhSpiOr9efzEfwfVapAgLPcqZN8oVn3ONyV
 Xx/EheFUcimmgwfrblQzqheEQME6aE1k0F7V3xVzZEydw4DC0IahPTHbANrQ9g70+qK5IZ533Ad
 kvpn8MopdsCUgNun7VJneB85V2Rd1djuNjzdlJrEQkjeUq3GZuAn7lDqgnGkhEZTvqYKbdMOITq
 Nxa/XJw9zQNDhaB03UquLFMXVZpgv+L6rRxP4TLd+Pwj06GV10+94awhOAFAjXUoaKCUd8ZAKwE
 1ZwYUqK38DcA8qebYG5XgJF6F7SK2K9T0nn58PRm5yNG6ebKm+5trX5pwkE/xN89tySVGvHwqsV
 cRId8nPL7JG7xHNwjD9qk1PAeblRWKt0I+0uAjoq7pCoxWyfxmv7X93/QdL3SQOcquZjCdEKICW
 GQlNXT6WqWYlH5dIMuFNy+ypcTNP7FBO2n0jotISt+muo54WhKnAnBrDSr3TsP12+RY+OkwVKBp
 MwSo1CbUyUORqAL7KzCGMxK121aE+ZhZneEyuX9j2MzijGAciJ0V/qzQg==
X-Received: by 2002:a05:600c:450a:b0:488:a882:b7 with SMTP id
 5b1f17b1804b1-488d6ad17e6mr304461325e9.29.1776277991125; 
 Wed, 15 Apr 2026 11:33:11 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e72980sm34953115e9.5.2026.04.15.11.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:33:10 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 5/7] test: cmd: part: add UUID lookup tests
Date: Wed, 15 Apr 2026 20:31:32 +0200
Message-ID: <20260415183250.3031030-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
References: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
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

Changes in v3:
- Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
- Add Reviewed-by tag of Simon Glass

 test/cmd/part.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/test/cmd/part.c b/test/cmd/part.c
index f808ddbc87eb..3ac6b02cc368 100644
--- a/test/cmd/part.c
+++ b/test/cmd/part.c
@@ -76,6 +76,20 @@ static int dm_test_cmd_part_number(struct unit_test_state *uts)
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
 DM_TEST(dm_test_cmd_part_number, UTF_SCAN_PDATA | UTF_SCAN_FDT);
@@ -116,6 +130,21 @@ static int dm_test_cmd_part_start(struct unit_test_state *uts)
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
 DM_TEST(dm_test_cmd_part_start, UTF_SCAN_PDATA | UTF_SCAN_FDT);
@@ -156,6 +185,21 @@ static int dm_test_cmd_part_size(struct unit_test_state *uts)
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
 DM_TEST(dm_test_cmd_part_size, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.0

