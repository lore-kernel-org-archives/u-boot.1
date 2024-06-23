Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE22C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA6E884BE;
	Sun, 23 Jun 2024 22:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K12qvn/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B76B8843A; Sun, 23 Jun 2024 22:30:43 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70FC882A5
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7eba486df76so108359939f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174639; x=1719779439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooBER8KresWFK5aE58J9ZGYyYKZCAYkwPknAO0n10g4=;
 b=K12qvn/gYUCionetHbtSYL/ThgAxkfwCT13c9tjPWBz4+JQ2GMOI1tFlxWGfORir7D
 uhpKeBeOT0/5xEIw19abgjfDoh0WhtL+ofsChu6sv33hRJB8rXpvFOueZDij67CFrdhA
 Do0R/W5SgetHONY7VMW0QSzhjUQBQKCiMbXoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174639; x=1719779439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooBER8KresWFK5aE58J9ZGYyYKZCAYkwPknAO0n10g4=;
 b=nfPPcBPIAJ+8jBugyIXiAadJxCmJpH2F4LM8eAopx+SNT3i76GS41anuAizsGS+A8p
 05AWwxuejzj+ISDsW0q1NCXGpd7yoJ7Z3AqGle+cgyZiRsxHXBmNxwsX+4sPJsaOUhq5
 0UHPaeZJKgRGVqphP5Bp/88DlQnj21C3eDDhYu7bF2TomwuYpXtzei+JcuJNuhGtGIBr
 5gC4TJ6jnzZhcvIB2ve3vvJCDTWPUVzEa6EsLE5BtUrTobpPujzu/AgMkwaQtqDjnkmu
 ffT8Lhzx8iVrPmpw7iBXhhQaZ8HcyKEccvKrjjET7Ustvr4EPEi/WkXx5qG4hGsGCZo1
 FD1Q==
X-Gm-Message-State: AOJu0YyjSs3A7+G3e5biJV++CnSUTYeOWmzPPaTctorm35gvaktGSVVV
 z1TSTUIiz0zchMf4cDDULW9HYErecJpz565Ij74+emcFfZgGUaP4yb9tUMPyTZf5cm9x+nYwwtx
 E+w==
X-Google-Smtp-Source: AGHT+IFF0CiUgbD4kBuCenhIGJI/6/XuKXVuGy17byH+GcEx2UqJRyAFPbRTWAHeenyjpnqR6P7N8w==
X-Received: by 2002:a05:6602:3609:b0:7f3:a415:c736 with SMTP id
 ca18e2360f4ac-7f3a415cad3mr141895739f.8.1719174639401; 
 Sun, 23 Jun 2024 13:30:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 03/14] initcall: Correct use of relocation offset
Date: Sun, 23 Jun 2024 14:30:22 -0600
Message-Id: <20240623203033.1566505-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---

(no changes since v1)

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

