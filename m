Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB5AEE49A4
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CC78728C;
	Tue, 22 Aug 2023 05:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SwB4mac3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD4F871CB; Tue, 22 Aug 2023 05:17:19 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E01DA871CB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34bbb4b580eso12201345ab.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674235; x=1693279035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxCzNdyN/y+e8c/ViHLqGlb1mKPr0eQmuK+T7gEnqzA=;
 b=SwB4mac3mW5Jr0dWzavtKM9EQabtpDkZ23tbYYn0LnUw5VI3k2lPy2GieZHbphRoZF
 IhWISPCJnEYt7UELzMJDPjBVn8w5EzRsaYRQNX4qauTJC0bLIx7kGc/3sj1/bMZod7Eh
 c/qDHhWRBHb6gK+9qvqx7GluY5kESy1ehIzzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674235; x=1693279035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxCzNdyN/y+e8c/ViHLqGlb1mKPr0eQmuK+T7gEnqzA=;
 b=YD0MPm91fYzNbbhn7Y6Stk1Bl8IulAyZbva47kO4vD7UUqXLrTFLkQutB4vJzm32A8
 metE5CqxSCyG3yf6IRfUy7iv8Z6nuJNea8Dg1Gr+gacNvJDj+TpRpb3eVRfxp+1IU6+P
 WEC3aMjLYCbLtOIW5tHYqK3EVRbTB+P3zTgPfKJaD+s4eNkR7dXVSkeE6AfiDtiR4q3N
 TZsvt9W393kUMD+RUxvwkCD3d1qiGPuzwkRTiUBYwxcIJDV01tU9fX9VFEnUAVyxVLeC
 +Tk9m8rjJV9Dww6xXu+bO18nNwfyouFQo6mtpTbSEM96sKmWC5GdEkkpHXlkNKDB5b4N
 350w==
X-Gm-Message-State: AOJu0Yw9TYdU0hDZSENGML7YNytAQtMQzETRWp5IEz96LNGEND8VNKcd
 TJJ/B4CVcHTIFRkj0ArGTqRCTX8j0zjOAnUQ6yY=
X-Google-Smtp-Source: AGHT+IFIEsONj0X1/JryJcfHEJNFGWJcGTr5eIcoCn9xKIi6MCo4lIoiM0zNd8j4B06rxLzMsMcHZw==
X-Received: by 2002:a05:6e02:1113:b0:34a:b6a6:7340 with SMTP id
 u19-20020a056e02111300b0034ab6a67340mr8876004ilk.22.1692674235483; 
 Mon, 21 Aug 2023 20:17:15 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 07/14] initcall: Support emitting events
Date: Mon, 21 Aug 2023 21:16:54 -0600
Message-ID: <20230822031705.1340941-8-sjg@chromium.org>
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

At present the initcall list consists of a list of function pointers. Over
time the initcall lists will likely change to mostly emitting events,
since most of the calls are board- or arch-specific.

As a first step, allow an initcall to be an event type instead of a
function pointer. Add the required macro and update initcall_run_list() to
emit an event in that case, or ignore it if events are not enabled.

The bottom 8 bits of the function pointer are used to hold the event type,
with the rest being all ones. This should avoid any collision, since
initcalls should not be above 0xffffff00 in memory.

Convert misc_init_f over to use this mechanism.

Add comments to the initcall header file while we are here. Also fix up
the trace test to handle the change.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_f.c            |  7 +-----
 include/initcall.h          | 25 +++++++++++++++++++
 lib/initcall.c              | 50 +++++++++++++++++++++++++++++++++----
 test/py/tests/test_trace.py | 11 ++++----
 4 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 2f986d9b2890..a485ba62fa17 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -836,11 +836,6 @@ __weak int clear_bss(void)
 	return 0;
 }
 
-static int misc_init_f(void)
-{
-	return event_notify_null(EVT_MISC_INIT_F);
-}
-
 static const init_fnc_t init_sequence_f[] = {
 	setup_mon_len,
 #ifdef CONFIG_OF_CONTROL
@@ -899,7 +894,7 @@ static const init_fnc_t init_sequence_f[] = {
 	show_board_info,
 #endif
 	INIT_FUNC_WATCHDOG_INIT
-	misc_init_f,
+	INITCALL_EVENT(EVT_MISC_INIT_F),
 	INIT_FUNC_WATCHDOG_RESET
 #if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
 	init_func_i2c,
diff --git a/include/initcall.h b/include/initcall.h
index 01f3f2833f10..62d3bb67f089 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -6,8 +6,33 @@
 #ifndef __INITCALL_H
 #define __INITCALL_H
 
+#include <asm/types.h>
+#include <event.h>
+
+_Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
+
+/**
+ * init_fnc_t - Init function
+ *
+ * Return: 0 if OK -ve on error
+ */
 typedef int (*init_fnc_t)(void);
 
+/* Top bit indicates that the initcall is an event */
+#define INITCALL_IS_EVENT	GENMASK(BITS_PER_LONG - 1, 8)
+#define INITCALL_EVENT_TYPE	GENMASK(7, 0)
+
+#define INITCALL_EVENT(_type)	(void *)((_type) | INITCALL_IS_EVENT)
+
+/**
+ * initcall_run_list() - Run through a list of function calls
+ *
+ * This calls functions one after the other, stopping at the first error, or
+ * when NULL is obtained.
+ *
+ * @init_sequence: NULL-terminated init sequence to run
+ * Return: 0 if OK, or -ve error code from the first failure
+ */
 int initcall_run_list(const init_fnc_t init_sequence[]);
 
 #endif
diff --git a/lib/initcall.c b/lib/initcall.c
index 0f74cef32f85..33b7d761dc7e 100644
--- a/lib/initcall.c
+++ b/lib/initcall.c
@@ -7,6 +7,7 @@
 #include <efi.h>
 #include <initcall.h>
 #include <log.h>
+#include <relocate.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -25,6 +26,23 @@ static ulong calc_reloc_ofs(void)
 
 	return 0;
 }
+
+/**
+ * initcall_is_event() - Get the event number for an initcall
+ *
+ * func: Function pointer to check
+ * Return: Event number, if this is an event, else 0
+ */
+static int initcall_is_event(init_fnc_t func)
+{
+	ulong val = (ulong)func;
+
+	if ((val & INITCALL_IS_EVENT) == INITCALL_IS_EVENT)
+		return val & INITCALL_EVENT_TYPE;
+
+	return 0;
+}
+
 /*
  * To enable debugging. add #define DEBUG at the top of the including file.
  *
@@ -34,23 +52,45 @@ int initcall_run_list(const init_fnc_t init_sequence[])
 {
 	ulong reloc_ofs = calc_reloc_ofs();
 	const init_fnc_t *ptr;
+	enum event_t type;
 	init_fnc_t func;
 	int ret = 0;
 
 	for (ptr = init_sequence; func = *ptr, !ret && func; ptr++) {
-		if (reloc_ofs) {
+		type = initcall_is_event(func);
+
+		if (type) {
+			if (!CONFIG_IS_ENABLED(EVENT))
+				continue;
+			debug("initcall: event %d/%s\n", type,
+			      event_type_name(type));
+		} else if (reloc_ofs) {
 			debug("initcall: %p (relocated to %p)\n",
-			      (char *)func - reloc_ofs, func);
+			      (char *)func - reloc_ofs, (char *)func);
 		} else {
 			debug("initcall: %p\n", (char *)func - reloc_ofs);
 		}
 
-		ret = func();
+		ret = type ? event_notify_null(type) : func();
 	}
 
 	if (ret) {
-		printf("initcall failed at call %p (err=%dE)\n",
-		       (char *)func - reloc_ofs, ret);
+		if (CONFIG_IS_ENABLED(EVENT)) {
+			char buf[60];
+
+			/* don't worry about buf size as we are dying here */
+			if (type) {
+				sprintf(buf, "event %d/%s", type,
+					event_type_name(type));
+			} else {
+				sprintf(buf, "call %p", func);
+			}
+
+			printf("initcall failed at %s (err=%dE)\n", buf, ret);
+		} else {
+			printf("initcall failed at call %p (err=%d)\n",
+			       (char *)func - reloc_ofs, ret);
+		}
 
 		return ret;
 	}
diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index ac3e95925e95..326d98e0d156 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -175,7 +175,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     # Then look for this:
     #  u-boot-1     [000]   282.101375: funcgraph_exit:         0.006 us   |      }
     # Then check for this:
-    #  u-boot-1     [000]   282.101375: funcgraph_entry:        0.000 us   |    event_init();
+    #  u-boot-1     [000]   282.101375: funcgraph_entry:        0.000 us   |    initcall_is_event();
 
     expected_indent = None
     found_start = False
@@ -197,8 +197,9 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
             elif found_start and indent == expected_indent and brace == '}':
                 found_end = True
 
-    # The next function after initf_bootstage() exits should be event_init()
-    assert upto == 'event_init()'
+    # The next function after initf_bootstage() exits should be
+    # initcall_is_event()
+    assert upto == 'initcall_is_event()'
 
     # Now look for initf_dm() and dm_timer_init() so we can check the bootstage
     # time
@@ -247,7 +248,7 @@ def check_flamegraph(cons, fname, proftool, map_fname, trace_fg):
     # We expect dm_timer_init() to be called twice: once before relocation and
     # once after
     look1 = 'initf_dm;dm_timer_init 1'
-    look2 = 'board_init_r;initr_dm_devices;dm_timer_init 1'
+    look2 = 'board_init_r;initcall_run_list;initr_dm_devices;dm_timer_init 1'
     found = 0
     with open(trace_fg, 'r') as fd:
         for line in fd:
@@ -272,7 +273,7 @@ def check_flamegraph(cons, fname, proftool, map_fname, trace_fg):
                 total += count
     return total
 
-
+check_flamegraph
 @pytest.mark.slow
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('trace')
-- 
2.42.0.rc1.204.g551eb34607-goog

