Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC1FC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5792885DD;
	Fri, 21 Jun 2024 21:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Veq26pjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D637B8859F; Fri, 21 Jun 2024 21:52:24 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A278856F
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7f39116e564so44994139f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999541; x=1719604341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooBER8KresWFK5aE58J9ZGYyYKZCAYkwPknAO0n10g4=;
 b=Veq26pjgelPWLdoW+PGCsE/ps/6T/5EWl4aVnKOz4y6aIUBrbPj1M3D4YGH9sDl6V6
 X7iDIa/Y+2AGMZy0FjzSlaqMAxEMhHCIHUNdBce8af0wFQ2bOWbPQyAveHExOAD7v6cp
 R8K9U6usdIS+O3O3TT1svioWRds7IfNuHzf74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999541; x=1719604341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooBER8KresWFK5aE58J9ZGYyYKZCAYkwPknAO0n10g4=;
 b=qkInpfus5cn+QmM4TMDILEUbqtG/QQyw1v69n1+nN/GMHalNB3ZcxSP8MMuuMM5zeV
 kssVNbMmxMqN2RHwYkf8ORNO06qoyrdwrnbc5UcsXTWvQqirKzzH4i5S1ix8LA7T+FAn
 5IrfOPmOaFC1zuyTCcA21xEUTb2lUdPXIDua8SV+Txv4rkmL0Ii3XDuHoaOwLmI1f+u2
 NIRG8F87ZHGiBwG2JkiUCcP+O8nF+QOF7BLTxrmhLF2g3Xj9Zf46glfZxR7XmPe1H8xv
 NiDd/Ad44Sre3zYZZGloqVDRgK1Lg8c4iibnrDk1aA32+Nmm7bmw5s+EjLpUpUy6cJpg
 WnPQ==
X-Gm-Message-State: AOJu0YyQtm8cGAZPX++lpcOTliYV0J3+AVinXJsFUjvEooK+p1XMZ8jS
 mlu0zuBw+BvpiW6O+untX96xcqq5LntctkRA/JD9z6OvZg3/6q+kakIeiY22/tqhG+dCLGhXNXX
 3DA==
X-Google-Smtp-Source: AGHT+IFWOsFFUhUBLbX8jg3IuV00sBLCoWQUV9uzM/nm2FDKUV5cmfBpmr6y0GHCfEuqqLR/VafS/g==
X-Received: by 2002:a05:6602:6414:b0:7e1:7d6c:4bf0 with SMTP id
 ca18e2360f4ac-7f13ee8f9f7mr1113769439f.16.1718999541291; 
 Fri, 21 Jun 2024 12:52:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 14/43] initcall: Correct use of relocation offset
Date: Fri, 21 Jun 2024 13:51:35 -0600
Message-Id: <20240621195204.2675252-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

