Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CE1C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066978879C;
	Tue, 11 Jun 2024 22:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EhX28Cd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CAA88732; Tue, 11 Jun 2024 22:02:29 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11538870E
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-37588517095so19782025ab.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136145; x=1718740945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xuhSU9HTCauKB+4KV1rteE+u47LRYZE6pFbP//jaf9k=;
 b=EhX28Cd1YpvDs8D+2JWs4yheBuJgwpgPiLJk+zeBCiSCRApjrLFbM6zzGcGZeA4KTr
 dYpLqMULM64qhqjA4uc0rzkDDRJHSUmkhTRWsvhKAWoaLkqvqBjf5UnzqYNoE2g8LjBm
 BeQalRCjU0lr52FMFw2Ei/gstLxF4lCXEtF7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136145; x=1718740945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xuhSU9HTCauKB+4KV1rteE+u47LRYZE6pFbP//jaf9k=;
 b=HO8xUige/zL17CycaNPnrw7Pu5ogWzy92buwhqbITwBhhy+WFAVxNJ/ZxWLb2khEfJ
 rCoPvCshmV8wSw5th3SRwqBwt131COL0eor2/FLtOHFIF1hv3uBFUKYcqIiQX98xYlIw
 p5MhezpmHHwwd5asmeVX1cXU/VcRxORkiNIsZjfLOLx3t1meXg36zPWSeGr1In2OmnP7
 voXEXQBR4j3HvdUKTDamMDzLDPKbc+7mL6FoBrcsPCl1CGRdp96iWnA2zAnFtgH7wRP1
 R/1mT9AfIdKuaZquGo1yM1yQP9JjH1FF4zC+RvX5N50wSs8uz8GDkd1JvH/a0yrMwq3E
 9FLw==
X-Gm-Message-State: AOJu0YyF7owztm+ayT7dB9wamFW65b45iFxbQyIdUdUFZj8Qd9YrNp55
 GiwiB6o5MrtFj8tgUK7c9ECa6C7BReWgoBQPRS3AeAVPcqXyGgeBE/IqHHpPMHxbO2WohhxmRyb
 rSw==
X-Google-Smtp-Source: AGHT+IHRxLzuuaXZ0Q34W9G7viBxlV6eO+Kr0Qq+8BqcIA/KxHJI4BA6FjmWcTwWyHj8Bbz7OkKJEA==
X-Received: by 2002:a05:6e02:1aa2:b0:375:af5f:67ea with SMTP id
 e9e14a558f8ab-375af5f6ab8mr49147985ab.18.1718136145330; 
 Tue, 11 Jun 2024 13:02:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 14/42] initcall: Correct use of relocation offset
Date: Tue, 11 Jun 2024 14:01:28 -0600
Message-Id: <20240611200156.2245525-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

The relocation offset can change in some initcall sequences. Handle
this and make sure it is used for all debugging statements in
init_run_list()

Update the trace test to match.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/initcall.c              | 6 ++++--
 test/py/tests/test_trace.py | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/initcall.c b/lib/initcall.c
index c8e2b0f6a38..2686b9aed5c 100644
--- a/lib/initcall.c
+++ b/lib/initcall.c
@@ -49,13 +49,14 @@ static int initcall_is_event(init_fnc_t func)
  */
 int initcall_run_list(const init_fnc_t init_sequence[])
 {
-	ulong reloc_ofs = calc_reloc_ofs();
+	ulong reloc_ofs;
 	const init_fnc_t *ptr;
 	enum event_t type;
 	init_fnc_t func;
 	int ret = 0;
 
 	for (ptr = init_sequence; func = *ptr, func; ptr++) {
+		reloc_ofs = calc_reloc_ofs();
 		type = initcall_is_event(func);
 
 		if (type) {
@@ -84,7 +85,8 @@ int initcall_run_list(const init_fnc_t init_sequence[])
 				sprintf(buf, "event %d/%s", type,
 					event_type_name(type));
 			} else {
-				sprintf(buf, "call %p", func);
+				sprintf(buf, "call %p",
+					(char *)func - reloc_ofs);
 			}
 
 			printf("initcall failed at %s (err=%dE)\n", buf, ret);
diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index f41d4cf71f0..ec1e624722c 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -175,7 +175,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     # Then look for this:
     #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.006 us   |      }
     # Then check for this:
-    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    initcall_is_event();
+    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    calc_reloc_ofs();
 
     expected_indent = None
     found_start = False
@@ -199,7 +199,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
 
     # The next function after initf_bootstage() exits should be
     # initcall_is_event()
-    assert upto == 'initcall_is_event()'
+    assert upto == 'calc_reloc_ofs()'
 
     # Now look for initf_dm() and dm_timer_init() so we can check the bootstage
     # time
-- 
2.34.1

