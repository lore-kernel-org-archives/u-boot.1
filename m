Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDABC021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9F5E810E5;
	Tue, 25 Feb 2025 17:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F2cUOsGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31BEE80FDE; Tue, 25 Feb 2025 17:35:24 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E54A80FED
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso35279225e9.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501321; x=1741106121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g32Gn3NGNQSm88vcGRaPIMIYwfFfaWb2XPLHqfXE5po=;
 b=F2cUOsGBmOvFwJebDSXU4UVT9hoAHY48+VZmpNMS+Q+cJdIiuG4N43Po6h1IvyfuY1
 AWgmxoCa2Rc/1nVTbt+kSAsqzvFAryAE05G3BpAZSCjm/AqWwHBMlwfXZimsEq9wkKni
 SIMT/VVOchfARKPUqYKipDtbU6WQoHDGgzzkfTRr6W0YZVQ4NJ1Ry2mrRm7tSfdqCPPT
 Z5ZWTrd9QTLI9okJtVV4Hs0RPmzW1CcceqZrOyj8FgpNDCe7+2Cy299KFjFo80FgwpBm
 h9pUc0IkXi43TnXij1r0jKLNO3ShIHGSsPCoIBb8eTYHqBAed+yBbGE81VLb4o5u45gi
 odsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501321; x=1741106121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g32Gn3NGNQSm88vcGRaPIMIYwfFfaWb2XPLHqfXE5po=;
 b=DrXY8KpsYYY5UqnSYqGAom8PcJckpTFQRjWnP8CZmEpXXK9TfWBjhaBJBvWHEfhx7d
 uR+pvEW+B9EVZdXe3juCMk9xwHdfQDnjO4fa2nYPKgpaPe/fp5QCWpp6wiun2JHnjLme
 me/Bq83LZzxgvgQrKmgfxYwTwi2sTV2YAvAEqm87LEn1Tqxjisbjiqr0eLK/EAVxa8QG
 ohwYMCNoei/GdjDNNj5JDjBp5wAabZr3re5aoGNT/8OBlbep5wFJ6PU/Lb2YxocvT02N
 fuyYvH2IVm79Bo6zDya32DU+BrE/TyQus92rQryr8RZeF3GYk6890OK5N84hQPRcGtQW
 u4qw==
X-Gm-Message-State: AOJu0YyTotT0PQv2axuUBQ2VAJ5jcQkOsndclLiyIvd4K12Ci5wG1+yA
 P0VMJSI1fKWPt3I6fKuGRi6sx28g1wrzQo5fugKbTsplPk1AmnHxJveDAZPevm9ug3anHphA7CM
 CYjMGhg==
X-Gm-Gg: ASbGnctWjru9ejt651KJ/qdf72LkgCEqtEmt6Cf6qPLjmF5Cu+3EdEBy0+pSXLJpvKl
 vpFoH5hs+zjnPf3HzstPwXTXpVMHrGPEoutleNRW32ODXrornLRcfgiGRDuWMNlWkzk17RPdbbs
 luvm9+FloUdhCKhHXqXqAe/c7cxJbK+hg2vaWUDbYoA+/qutf28xedQpHh8JiBrA+qTogUQ2PWX
 eIZq4LuUTewAnFsT32b+3HXksGI+oXdMwLx3W6ox+zCPrrkS7leuPT/QxWRGFh5YkIVMAo3n7nl
 huKSWeNqgnMaCN5uKadpsWtBGI2XTC2nXNU=
X-Google-Smtp-Source: AGHT+IHTiNR5fflsZ1FuzVFwQovguwngfOyWG/rappxn4HQi0eX+5LRJhxI1kFb8//NyFNE1fx+P5Q==
X-Received: by 2002:a05:600c:6b66:b0:439:96a4:d2a8 with SMTP id
 5b1f17b1804b1-439a2fb2c41mr162929195e9.5.1740501320917; 
 Tue, 25 Feb 2025 08:35:20 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:20 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Dahl <ada@thorsis.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 09/14] doc: develop: add documentation for uthreads
Date: Tue, 25 Feb 2025 17:34:35 +0100
Message-ID: <3160c00fe82fc3e627c5c03456f55501ad1ca111.1740499185.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740499185.git.jerome.forissier@linaro.org>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
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

Add documentation for the uthread framework.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 doc/develop/index.rst   |   1 +
 doc/develop/uthread.rst | 136 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 doc/develop/uthread.rst

diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index d9f2a838207..89c171c2089 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -53,6 +53,7 @@ Implementation
    spl
    falcon
    uefi/index
+   uthread
    vbe
    version
 
diff --git a/doc/develop/uthread.rst b/doc/develop/uthread.rst
new file mode 100644
index 00000000000..a7dc48ebc9c
--- /dev/null
+++ b/doc/develop/uthread.rst
@@ -0,0 +1,136 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. (C) Copyright 2025 Linaro Limited
+
+Uthread Framework
+=================
+
+Introduction
+------------
+
+The uthread framework is a basic task scheduler that allows to run functions
+"in parallel" on a single CPU core. The scheduling is cooperative, not
+preemptive -- meaning that context switches from one task to another task is
+voluntary, via a call to uthread_schedule(). This characteristic makes thread
+synchronization much easier, because a thread cannot be interrupted in the
+middle of a critical section (reading from or writing to shared state, for
+instance).
+
+`CONFIG_UTHREAD` in lib/Kconfig enables the uthread framework. When disabled,
+the uthread_create()  and uthread_schedule() functions may still be used so
+that code differences between uthreads enabled and disabled can be reduced to
+a minimum. See details below.
+
+Function description
+--------------------
+
+See `lib/uthread.c`.
+
+Usage
+-----
+
+This section shows how uthreads may be used to convert sequential code
+into parallel code. Error handling is omitted for brevity.
+Consider the following:
+
+.. code-block:: C
+
+   static void init_foo(void)
+   {
+        start_foo();
+        while (!foo_is_ready())
+            udelay(10);
+   }
+
+   static void init_bar(void)
+   {
+        start_bar();
+        while (!bar_is_ready())
+            udelay(10);
+   }
+
+   void init_foo_bar(void)
+   {
+        init_foo();
+        init_bar();
+   }
+
+This example is a simplified version of typical device initialization, where
+some commands are sent to a device and the CPU needs to wait for the device
+to reply or change state after wich the device is known to be ready.
+Assuming devices 'foo' and 'bar' are independant, and assuming they both take
+some significant amount of time to initialize, then the above code is clearly
+suboptimal because device 'bar' is started only after 'foo' is ready, although
+it could have been started at the same time. Therefore a better version would
+be:
+
+.. code-block:: C
+
+   void init_foo_bar(void)
+   {
+        start_foo();
+        start_bar();
+        while (!foo_is_ready() || !bar_is_ready())
+            udelay(10);
+   }
+
+
+Unfortunately, refactoring the code like that is rarely so easy because
+init_foo() and init_bar() would in reality involve dozens of functions
+and result in deep call stacks. This is where uthreads are helpful. Here is
+how.
+
+.. code-block:: C
+
+   /* Unchanged */
+   static void init_foo(void)
+   {
+        start_foo();
+        while (!foo_is_ready())
+            udelay(10);
+   }
+
+   /* Unchanged */
+   static void init_bar(void)
+   {
+        start_bar();
+        while (!bar_is_ready())
+            udelay(10);
+   }
+
+   /* Added only because init_foo() does not take a (void *) */
+   static void do_init_foo(void *arg)
+   {
+        init_foo();
+   }
+
+   /* Added only because init_bar() does not take a (void *) */
+   static void do_init_bar(void *arg)
+   {
+        init_bar();
+   }
+
+   void init_foo_bar(void)
+   {
+       int id;
+
+       /* Allocate a thread group ID (optional) */
+       id = uthread_grp_new_id();
+       /* Create and start two threads */
+       uthread_create(do_init_foo, NULL, 0, id);
+       uthread_create(do_init_bar, NULL, 0, id);
+       /* Wait until both threads are done */
+       while (!uthread_grp_done(id))
+           uthread_schedule();
+   }
+
+When `CONFIG_UTHREAD` is enabled, do_init_foo() is started and quickly yields
+the CPU back to the main thread due to udelay() calling uthread_schedule().
+Then do_init_bar() is started and it also calls udelay(), which in turn calls
+uthread_schedule(). With the main thread entering the scheduling loop, we
+effectively have three tasks scheduled in a round-robin fashion until
+do_init_foo() and do_init_bar() are both done.
+
+when `CONFIG_UTHREAD` is disabled, uthread_grp_new_id() always returns 0,
+uthread_create() simply calls its first argument, uthread_grp_done() always
+returns true and uthread_schedule() does nothing. In this case, the code is
+functionally equivalent to the sequential version.
-- 
2.43.0

