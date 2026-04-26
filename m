Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBE5FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C58984353;
	Sun, 26 Apr 2026 17:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="A8kEPy0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C93AF8412A; Sun, 26 Apr 2026 17:47:38 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C65D983FF5
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so6360349f8f.2
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218456; x=1777823256;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3edTpCbQLoF2GLZoQuCSJDpFP7hzTahHYvj6ql2yGM=;
 b=A8kEPy0xS3Gw16IkE8jqEQpgfqDuLpmJSGM61WnUzzuzSH2Givm9UHf7Blo/Ezcs4z
 ZgV23+dQC4BbJcB0tEIg3O1F+ondV/+uJCYvYv8Hu2ot53FXPCFGek1vXgr+DCxI1rKd
 s5G2k9o/QHjMQzHj299jYBKDUdJST/zFHjd8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218456; x=1777823256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V3edTpCbQLoF2GLZoQuCSJDpFP7hzTahHYvj6ql2yGM=;
 b=Xc1zrthAX9SdO+vGIjl71/462V7LBdLZJAwjiwsvinP4zNvRV+2RlktGTHf5Sighj7
 P17iHm2TuV6Ysyp+ys0puFh+Q6ZBQLW/d5Rd6zvukfuhcxs6gXUyh4SOhra+vAm8ZCd9
 chMROH3eeDvyCWzccHWypRd1IAu7BpuGx1MhfVQam4QIPLMOEKZk+c3FEzRFod1epGg9
 ceFFlUJqfJa8EEWFBMMvBc/QJMCt6Euhugy/3rPVH8dGIPlXNveb/ewpFMiaseER8RuZ
 i8WtbVOx9hiN5uLPNrf1hVy7GMO97/1iCbURG5aDHP3IF08FAsvi/2JJ5Y5qfzlkcx//
 zdoA==
X-Gm-Message-State: AOJu0YywR32cFlXjROLgQJvVQ+7OTZcDslLk1lrhZQ2n3qIv5pC+8XH6
 Uis9fqAWghbYAzyETOqI0Wd93qGRumHpbfILRxtVqHn5HUBg274l84nVlW1VvKqo7i91IN8hSq9
 m2s6K
X-Gm-Gg: AeBDiesfaqgDvMePM+S92yt34XgozReLyAdURvx4Fs1HX7O6r7TDp0X317i3nbCYMd/
 pSOi0excueydQIUQpJIIQZynEQr1yhZXHdzXc+kAMn93PbGNiSmp222ouu+22I1qeYcFMviVmlN
 1L3pXhUczNo833Ks3JSJidXcP+cFHeG+qTXg4lpQa05vNP+WdAFPC4CuLlBaGbNiLtvFQulvZCR
 MI+uHWLv/mJUUI5KPiAbvvecGyzGH9qwcP0Y0u0d0zKDcBZ/hWUkQKT7QbnOG+HHsu6CWfjomf9
 YoU+/W8OPggulNqsKA5OHbWy6PD1eHKk1aYAAeAMU8B7GdsIbAERgclHRv2GSzOMJwJDOc6jC4z
 bc8ei7g/ORr8JbQpn3M8W/od/cyPhV4t9h9BA1zcdZ6P7uFNjfOZ9QJRBowy9w5zCuiy1cQsg6t
 3Vd5x0cAANrCgYo58wj8C3xI15q1wj0FXPn1Sv0t71SS7meccIJ7Owen3NMVLfQmf6WS/IMHdS1
 Brf3HTDEla6vGJFtNWet8VmhKca9rRfahXV+1F94JjpwDFa5WG2ziIXV46dbYJketzf2XAQtOmK
 G1drp9519xS4zRxY2IIZ79KbSNARkA==
X-Received: by 2002:a05:6000:2087:b0:43d:7403:4b5d with SMTP id
 ffacd0b85a97d-43fe3dc49ecmr60846653f8f.15.1777218455981; 
 Sun, 26 Apr 2026 08:47:35 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm34489985f8f.15.2026.04.26.08.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:47:35 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 5/8] test: cmd: part: add UUID lookup tests
Date: Sun, 26 Apr 2026 17:46:58 +0200
Message-ID: <20260426154724.2042569-6-dario.binacchi@amarulasolutions.com>
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

