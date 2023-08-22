Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F87EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 520228723A;
	Tue, 22 Aug 2023 05:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ka2t6/J5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D46E1871D5; Tue, 22 Aug 2023 05:17:16 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F7B871CB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7923483bb68so46296939f.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674230; x=1693279030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrYyH5UuD4RVe0aArX9a0J8biH7Oazqj+BPhPrDD/jQ=;
 b=ka2t6/J5jfmxFDVxdcQbmgZBYRGXHx81RkzcazzUtPAnuq6X8/YgE6U5cvzkn2IKrn
 S8qHdxP7aaFufLh5IwWucwbbDTQ7TM9F51b2DoJm/zrO390emo5ht6UBJHk3Vyupoiza
 5Z9yQ+ZDVtpd9M8Dhv+otRGU07hgJeMjJUdzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674230; x=1693279030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrYyH5UuD4RVe0aArX9a0J8biH7Oazqj+BPhPrDD/jQ=;
 b=R7DLr/q/xk1wxwffI3SS4com7dfKPV/6hN4L8XdAZJwDxrXFkGpfbzYo/595Q4W1Gq
 iz1IfoeG3vr+u+s33+UWl7VyAD076WfVzYzjhAYHWKMVp6xV3XYai9ZpVMGpnSiu1WzB
 iAbnNoyY+GdWK2FHda/T4kLdCMn4vT8LPWEsZe0pwVTan9gFKbwM1eZTLTPgQvcjeXwR
 V7Zzy+DDxKXxACz0ZJDkiKH9NCwH+pwozIlSeghctP43t80uqQplE2nt9VRyE2OAa38b
 ylbs5SX/yFqbCMbPqBclzJQ4fc8x1O3247mdRED3JjHz71RM0heIXJSt5WdurLCcyF+c
 tJTg==
X-Gm-Message-State: AOJu0YyRYco7k/0YjYsUEcxRc1RsKJaW62KM90YdXrwTZ3knjnTLhI9j
 Z4VXW9CLhFLx1NqPm1wtc6eIXx5yngm309/5qKE=
X-Google-Smtp-Source: AGHT+IF3kkBeROTLn125clcZyiH8IdzQ1+g3GyFDM0CAvzkMkeyXXQF8tA/9dXRQVevNkVreUjxVIA==
X-Received: by 2002:a05:6e02:1523:b0:34b:b16d:aa38 with SMTP id
 i3-20020a056e02152300b0034bb16daa38mr11094070ilu.29.1692674230735; 
 Mon, 21 Aug 2023 20:17:10 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 01/14] event: Support a simple spy record
Date: Mon, 21 Aug 2023 21:16:48 -0600
Message-ID: <20230822031705.1340941-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
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

The current event spy is always passed the event context and the event.
The context is always NULL for a static spy. The event is not often used.

Introduce a 'simple' spy which takes no arguments. This allows us to drop
the adaptation code that many of these spy records use.

Update the event script to find these in the image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/event.c                   |  9 ++++++-
 include/event.h                  | 41 ++++++++++++++++++++++++++++++--
 scripts/event_dump.py            | 12 ++++++----
 test/common/event.c              | 22 +++++++++++++++++
 test/py/tests/test_event_dump.py |  3 ++-
 5 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/common/event.c b/common/event.c
index 3224e2812224..7e2590eb0400 100644
--- a/common/event.c
+++ b/common/event.c
@@ -71,7 +71,14 @@ static int notify_static(struct event *ev)
 
 			log_debug("Sending event %x/%s to spy '%s'\n", ev->type,
 				  event_type_name(ev->type), event_spy_id(spy));
-			ret = spy->func(NULL, ev);
+			if (spy->flags & EVSPYF_SIMPLE) {
+				const struct evspy_info_simple *simple;
+
+				simple = (struct evspy_info_simple *)spy;
+				ret = simple->func();
+			} else {
+				ret = spy->func(NULL, ev);
+			}
 
 			/*
 			 * TODO: Handle various return codes to
diff --git a/include/event.h b/include/event.h
index daf44bf8a83b..0e3222c2e243 100644
--- a/include/event.h
+++ b/include/event.h
@@ -99,19 +99,48 @@ struct event {
 	union event_data data;
 };
 
+/* Flags for event spy */
+enum evspy_flags {
+	EVSPYF_SIMPLE	= 1 << 0,
+};
+
 /** Function type for event handlers */
 typedef int (*event_handler_t)(void *ctx, struct event *event);
 
+/** Function type for simple event handlers */
+typedef int (*event_handler_simple_t)(void);
+
 /**
  * struct evspy_info - information about an event spy
  *
  * @func: Function to call when the event is activated (must be first)
  * @type: Event type
+ * @flag: Flags for this spy
  * @id: Event id string
  */
 struct evspy_info {
 	event_handler_t func;
-	enum event_t type;
+	u8 type;
+	u8 flags;
+#if CONFIG_IS_ENABLED(EVENT_DEBUG)
+	const char *id;
+#endif
+};
+
+/**
+ * struct evspy_info_simple - information about an event spy
+ *
+ * THis is the 'simple' record, the only difference being the handler function
+ *
+ * @func: Function to call when the event is activated (must be first)
+ * @type: Event type
+ * @flag: Flags for this spy
+ * @id: Event id string
+ */
+struct evspy_info_simple {
+	event_handler_simple_t func;
+	u8 type;
+	u8 flags;
 #if CONFIG_IS_ENABLED(EVENT_DEBUG)
 	const char *id;
 #endif
@@ -119,9 +148,11 @@ struct evspy_info {
 
 /* Declare a new event spy */
 #if CONFIG_IS_ENABLED(EVENT_DEBUG)
-#define _ESPY_REC(_type, _func)   { _func, _type, #_func, }
+#define _ESPY_REC(_type, _func)   { _func, _type, 0, #_func, }
+#define _ESPY_REC_SIMPLE(_type, _func)  { _func, _type, EVSPYF_SIMPLE, #_func, }
 #else
 #define _ESPY_REC(_type, _func)   { _func, _type, }
+#define _ESPY_REC_SIMPLE(_type, _func)  { _func, _type, EVSPYF_SIMPLE }
 #endif
 
 static inline const char *event_spy_id(struct evspy_info *spy)
@@ -168,6 +199,12 @@ static inline const char *event_spy_id(struct evspy_info *spy)
 	__used ll_entry_declare(struct evspy_info, _type ## _3_ ## _func, \
 		evspy_info) = _ESPY_REC(_type, _func)
 
+/* Simple spy with no function arguemnts */
+#define EVENT_SPY_SIMPLE(_type, _func) \
+	__used ll_entry_declare(struct evspy_info_simple, \
+		_type ## _3_ ## _func, \
+		evspy_info) = _ESPY_REC_SIMPLE(_type, _func)
+
 /**
  * event_register - register a new spy
  *
diff --git a/scripts/event_dump.py b/scripts/event_dump.py
index 0117457526ef..24dfe2bda91f 100755
--- a/scripts/event_dump.py
+++ b/scripts/event_dump.py
@@ -19,8 +19,10 @@ from u_boot_pylib import tools
 
 # A typical symbol looks like this:
 #   _u_boot_list_2_evspy_info_2_EVT_MISC_INIT_F_3_sandbox_misc_init_f
-PREFIX = '_u_boot_list_2_evspy_info_2_'
-RE_EVTYPE = re.compile('%s(.*)_3_.*' % PREFIX)
+PREFIX_FULL = '_u_boot_list_2_evspy_info_2_'
+PREFIX_SIMPLE = '_u_boot_list_2_evspy_info_simple_2_'
+RE_EVTYPE_FULL = re.compile('%s(.*)_3_.*' % PREFIX_FULL)
+RE_EVTYPE_SIMPLE = re.compile('%s(.*)_3_.*' % PREFIX_SIMPLE)
 
 def show_sym(fname, data, endian, evtype, sym):
     """Show information about an evspy entry
@@ -88,12 +90,14 @@ def show_event_spy_list(fname, endian):
         fname (str): Filename of ELF file
         endian (str): Endianness to use ('little', 'big', 'auto')
     """
-    syms = elf.GetSymbolFileOffset(fname, [PREFIX])
+    syms = elf.GetSymbolFileOffset(fname, [PREFIX_FULL, PREFIX_SIMPLE])
     data = tools.read_file(fname)
     print('%-20s  %-30s  %s' % ('Event type', 'Id', 'Source location'))
     print('%-20s  %-30s  %s' % ('-' * 20, '-' * 30, '-' * 30))
     for name, sym in syms.items():
-        m_evtype = RE_EVTYPE.search(name)
+        m_evtype = RE_EVTYPE_FULL.search(name)
+        if not m_evtype:
+            m_evtype = RE_EVTYPE_SIMPLE.search(name)
         evtype = m_evtype .group(1)
         show_sym(fname, data, endian, evtype, sym)
 
diff --git a/test/common/event.c b/test/common/event.c
index 6037ae2ce3bc..c0912a3437bb 100644
--- a/test/common/event.c
+++ b/test/common/event.c
@@ -18,6 +18,8 @@ struct test_state {
 	int val;
 };
 
+static bool called;
+
 static int h_adder(void *ctx, struct event *event)
 {
 	struct event_data_test *data = &event->data.test;
@@ -28,6 +30,14 @@ static int h_adder(void *ctx, struct event *event)
 	return 0;
 }
 
+static int h_adder_simple(void)
+{
+	called = true;
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_TEST, h_adder_simple);
+
 static int test_event_base(struct unit_test_state *uts)
 {
 	struct test_state state;
@@ -46,6 +56,18 @@ static int test_event_base(struct unit_test_state *uts)
 }
 COMMON_TEST(test_event_base, 0);
 
+static int test_event_simple(struct unit_test_state *uts)
+{
+	called = false;
+
+	/* Check that the handler is called */
+	ut_assertok(event_notify_null(EVT_TEST));
+	ut_assert(called);
+
+	return 0;
+}
+COMMON_TEST(test_event_simple, 0);
+
 static int h_probe(void *ctx, struct event *event)
 {
 	struct test_state *test_state = ctx;
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index da196df4c3e6..041f8f9c9790 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -18,5 +18,6 @@ def test_event_dump(u_boot_console):
 --------------------  ------------------------------  ------------------------------
 EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
 EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
-EVT_MISC_INIT_F       sandbox_misc_init_f             .*arch/sandbox/cpu/start.c:'''
+EVT_MISC_INIT_F       sandbox_misc_init_f             .*arch/sandbox/cpu/start.c:.*
+EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
     assert re.match(expect, out, re.MULTILINE) is not None
-- 
2.42.0.rc1.204.g551eb34607-goog

