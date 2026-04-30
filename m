Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44ABCD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A714A84671;
	Thu, 30 Apr 2026 10:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jc0B188m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FDFA84656; Thu, 30 Apr 2026 10:06:48 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F80784658
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso7150285e9.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777536405; x=1778141205;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLSc6xjnBHE8wv4ilMU5QxwihI4JWdlstUWj8PScQNs=;
 b=jc0B188mKNK8DB1zzN9kBXmPKz1YASouHYCdQgeE2+XwXr6k0nWthYBkeJIK5L5jH+
 ybbb6skiQKgG76JBtWepaONd9TV3k7Mr5mdKs4Kvzmtexqz+Eli8DEep5ZFXySCvUDY9
 ARxh+Hi4vFtKtq6kJ9UpsdWoKX0Q8+kf8X5aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536405; x=1778141205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eLSc6xjnBHE8wv4ilMU5QxwihI4JWdlstUWj8PScQNs=;
 b=fngnGbKMXID40MWGcE7g2bXrP33N3VY4/afh5N4keBeP5wAn5BXk4nP5FVJ4pxMINg
 Yji1woVyDmnwbChc/nsfOpJjs3ZSUw8Jtwz+pXVj/GkBVGYuofcS8w0sKpHgjRkObm6u
 pzDvzVVHffQEH5jH74tr0Dph0fW3sv9tsRbuzJKJ4Rxi2h0jTuEacbqeQAgg1IVaCNk4
 dVWR/6boR5Iz99OcVFv1kIKW5S9bIyXymY9ZEy0D9MOHOphESyO3PCIMiZ0BtTvMyyJZ
 gcvLjUft3amjFhbIDZfeSuuymPUVGtVPtT3GoXjoMl/IJaozUlEEETINBu2/v9uMl7ls
 7Smg==
X-Gm-Message-State: AOJu0YytO0XGTqWMVZ0zODG47RYWngmLh5NxRVK2bmA3zfru5HTSkW6m
 Tg9HYTN/eL97m+kb6zddOkMlotuXT0VvC1kKXdXszKpdfjtetFLixuPn36eTGc6iDU//KZOWvWR
 2nfBA
X-Gm-Gg: AeBDieu43aKc81NuBVDo+srgCFs/p9Kjc9OWrHXfKJJ3Rz3i6eP17rNU+jBWGdUyrIU
 iZyeXulbx6ApDWFkoN0avC68HXzhP+Tkra0QroSuOHCINlBPiw0AiBYEzhNF7xMTFn2my85J0CI
 VD00l7csKLmVSFrxzZO5EqXqILBaqB/45JZGUOnNDZBR1ug8Zvn2I7oK0chAndRh9vZv+yeDyIR
 xT148WxMJPlA37jqMzaA4y3WnJ+EH+/n12KE2omMk31V+Yagh85tj9HXHEpdPccLM6mYIWDRjrL
 lfjVmtoJMoXcfWCENc7ydxMrJx1gTFLQf8TG+AEILUDEp/fLEsAJdcH3cWmgilqTpz1rgFRcjfQ
 9ciXXVHSXPJXvnBh2cdgsS3Ie6rLQDzzRJN7GTw++eU4CB6VrFsmp0R0nrukCN8mkRQRU1gOYZ+
 53ZTgplBKCdOjVGKNLf9+8PAVa15t4xLewpateBGdHte5FWIuoUVqLadb/Zs4gaSQCUskuwtm9H
 rZqI7vP2kJIgVXR/SNPySGRhIquI9vTFOCUmLfI8Qf1Xn4pQ+l9kV/lKOkkk38KCsufs5rdURtV
 3fwTfmSOJjLhGkY1FuOZJvHZQCd/sL07Lgo=
X-Received: by 2002:a05:600c:198a:b0:48a:5970:2005 with SMTP id
 5b1f17b1804b1-48a83d66cc4mr27304945e9.2.1777536405223; 
 Thu, 30 Apr 2026 01:06:45 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm668071f8f.31.2026.04.30.01.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:06:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 5/8] test: cmd: part: add UUID lookup tests
Date: Thu, 30 Apr 2026 10:06:06 +0200
Message-ID: <20260430080627.849636-6-dario.binacchi@amarulasolutions.com>
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
index cac57a1a0e35..e0149011476c 100644
--- a/test/cmd/part.c
+++ b/test/cmd/part.c
@@ -90,6 +90,20 @@ static int cmd_test_part_number(struct unit_test_state *uts)
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
@@ -134,6 +148,21 @@ static int cmd_test_part_start(struct unit_test_state *uts)
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
@@ -178,6 +207,21 @@ static int cmd_test_part_size(struct unit_test_state *uts)
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

