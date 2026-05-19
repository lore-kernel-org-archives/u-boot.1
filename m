Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C77FCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC8B384927;
	Wed, 20 May 2026 01:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L4W0p8SS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A3E84949; Wed, 20 May 2026 01:33:14 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61CF84912
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6969c864c89so2333975eaf.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233589; x=1779838389; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iar+yAB6Vr6MFT6+Y3kZ5+pewTvzrT5tsG+5Aq1e1H4=;
 b=L4W0p8SSAHkGtt9whrK6hSaQsB0gtiiN9ZWABDhiNPN0s3wXwtqHoaT2nEUk0YqUgF
 R7unSPW81vtOHX5zyUbbPgb7+nGlqoPaccRUJEi1trqnJVj+DLqHJQRSu7T3c9H7ShhW
 MKFSkfQbJM/4WbdkIBS6CR0x1q+oTM7HZnk8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233589; x=1779838389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iar+yAB6Vr6MFT6+Y3kZ5+pewTvzrT5tsG+5Aq1e1H4=;
 b=NUqPviEaRxNGCXlqc8YLDaEz9gj6Ltfrrrs3sG4ixBOGSiOHxruz+qFu3e/8ue47QO
 phLzr09uV8G/nOKo/NeMrC11vcOxcJ+2rQLXErRhyXcIPTQ8GSvDAijFlqT93j6nv+XD
 bPW5AsYT/LoWIi6VIDqPOPhoeEVIh2e+5u/4UBM04UdqfT4HedW3HkihQ5wMvm3pf9bJ
 6efOcMS+6PVmuVILf8q3KZOTFnrSMU16cQBVr3J1np7V4Mb2jvRcUnorzB/jk2f7NUiy
 3VHDTOBR6wT+r6oDQsD7nBeEPf3z+evRPxEHDcP8jpzzPzJFQAHITIj4TjcIrmkXfZ6b
 2CmQ==
X-Gm-Message-State: AOJu0Yx+hJOgNnLQpkNomadNwEU2iPP0VEinZpmB7djSoV2/1Eam93Sm
 1Z4DfPBd6CibjVeIbtsCOghlErumMK3UmxGIvwR4ZIfAioOp3ZsoJOe+sfX8PgCfXkgnU63vjbO
 26Bnb0FUm
X-Gm-Gg: Acq92OFm9AM7JsEdp8w/AkXVOs4QA90kSj2haVjCGOwmu+EBIG8w/wHNnMugVDurkzi
 Ty8origG2Z5qC2kcc73WeUB4ZSGuuKTvc05A8tEq8lw9OguYB6Z7HwGy76oOh8D83gngrFPRHJb
 sfJjGqky1U9zF8vW3ADUdy7lqBtLrMJCh1+zfj7RbCr2RpAQ0P33SJhTB58gpX95d4XLkAlk30E
 o3PPJzFxOJ4f5Cy765XTE5XTk+t61EhojCw2/yiF+phezFNbEskH8QZ/9bFPxAS0pwiF9D2sqqp
 SERnlYWDDSGdG8SWGKT1QAw1gEzLc8sDfJegmfWfJ30e2lhJ0nlEJCD4bcW+XeK/TFqT2M9L56x
 Ok5T4wJM/kRZx54Mm62tNWvlOXbRmSLc+IKT4+zlOLlvrRMOh9/+zXJTR87cGm5Qtz2cgXjPq4S
 TU6Xim4eifyDeYS+gAOg==
X-Received: by 2002:a05:6820:1f12:b0:67d:e7c3:3c6c with SMTP id
 006d021491bc7-69c9bfbcb7bmr13456527eaf.53.1779233589332; 
 Tue, 19 May 2026 16:33:09 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:33:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH v2 17/17] doc: commands: Recommend getopt() for option
 parsing
Date: Tue, 19 May 2026 17:31:43 -0600
Message-ID: <20260519233207.2765755-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

The getopt() helper in <getopt.h> has been available since 2020 but
only two files in cmd/ actually use it; everything else hand-rolls
argv loops to detect -x style flags. New commands keep using ad-hoc
parsers because the developer guide for commands does not mention that
a shared helper exists.

Add a "Parsing options" section to the commands documentation with a
worked example.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/develop/commands.rst | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/doc/develop/commands.rst b/doc/develop/commands.rst
index 77a7a4d9c02..a1f0b59501d 100644
--- a/doc/develop/commands.rst
+++ b/doc/develop/commands.rst
@@ -118,6 +118,68 @@ CMD_RET_USAGE
     The command was called with invalid parameters. This value
     leads to the display of the usage string.
 
+Parsing options
+---------------
+
+Commands that take options (``-x``, ``-f file``, etc.) should use the
+getopt() helper in ``<getopt.h>`` rather than walking ``argv`` by hand. This
+keeps option handling consistent across commands, supports grouped flags
+(``-abc``) and arguments attached either to the option (``-ffile``) or in
+the next argv entry (``-f file``), and produces sensible errors for unknown
+or incomplete options.
+
+A typical use looks like:
+
+.. code-block:: c
+
+    #include <getopt.h>
+
+    static int do_foo(struct cmd_tbl *cmdtp, int flag, int argc,
+                      char *const argv[])
+    {
+        struct getopt_state gs;
+        const char *file = NULL;
+        bool verbose = false;
+        int opt;
+
+        getopt_init_state(&gs);
+        while ((opt = getopt(&gs, argc, argv, "vf:")) > 0) {
+            switch (opt) {
+            case 'v':
+                verbose = true;
+                break;
+            case 'f':
+                file = gs.arg;
+                break;
+            default:
+                return CMD_RET_USAGE;
+            }
+        }
+
+        /* Positional arguments start at gs.index */
+        if (gs.index >= argc)
+            return CMD_RET_USAGE;
+
+        return do_the_work(file, verbose, argv[gs.index]);
+    }
+
+A few points worth noting:
+
+* Each command owns a ``struct getopt_state`` on the stack, so getopt() is
+  reentrant. There are no globals like ``optind`` or ``optarg``; the next
+  unparsed argument is at ``gs.index`` and the option argument (when one is
+  expected) is in ``gs.arg``.
+* In the option string, ``x`` is a flag, ``x:`` requires an argument, and
+  ``x::`` takes an optional argument.
+* Unlike POSIX getopt(), this implementation does **not** reorder ``argv``,
+  so options must appear before positional arguments.
+* Returning ``CMD_RET_USAGE`` from the ``default`` case prints the command's
+  usage string for free; there is no need to call ``cmd_usage()`` directly.
+* Use getopt_silent() if the command should suppress the built-in error
+  messages and report problems itself.
+
+For the full API, see :doc:`../api/getopt`.
+
 Completion function
 -------------------
 
-- 
2.43.0

