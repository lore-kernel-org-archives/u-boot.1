Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB84CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFA5E8487F;
	Fri, 15 May 2026 22:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CoxexzWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE15E8487F; Fri, 15 May 2026 22:33:57 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799C58483C
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dea1272943so178370a34.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877233; x=1779482033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tt9eSTdKvaBZN7kFnackIwxUbOyH7DHw46vEqXpQkpk=;
 b=CoxexzWuudIzzPwSudPuROyRbrjfIkSeDWhTAcou8ccQeW9ShKVOFMa7dFL7Sluvcd
 7PgW0M5+EPeu8Eg1KGZwgaRjAZo6Kkx5DZ66eA34tcCNZtc3SzTBc+HtZZvLjxLXWfXz
 S7Xjh5ff64v3n1NUEQfbAYEjdeuq5kNWC5ky4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877233; x=1779482033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tt9eSTdKvaBZN7kFnackIwxUbOyH7DHw46vEqXpQkpk=;
 b=d9TdLnYL4df0a7iUsVujwPLoTaJ8Of2uP5kINHo2y250iQD5IhLEvM6zhXo5hGRgH1
 WQ3n3kWNg+rv4RDZPargL1yQV2dg1IbdyFlB4iqBsj6gbljj6WgU+T5ybD0gDesMjrHy
 ASMen4bHN4/OBIMuCnxePI8TOZBOpaKggNcDE8uEoTt88O/Kos8xPHDq/sO81ukN7Roy
 VAHgOxWe2FUK4xHvvnSt0hIXeUP12iPzcgOhBsvgZ1y5Ek8XeTT50X163pQCkbKvbtBn
 9yR3IcxkJ4BGwOoOyNndPS7je434fPrFh6Qt00jt7NDcKD7IjdmmwJhXbuaOKPt5AsK1
 75Aw==
X-Gm-Message-State: AOJu0YyAVh98Tu9Sxicj+psPC/DTI7T66s64NG7IEy2JkVClG4W5PTmS
 QngBT5bK8ljM90tvNd5SC7jYpH60d3JqkDC+ZZ4N5+nfs8FJuVMHU0XFbDu1YOCCidYX0mSp+S6
 NYaD0BQ==
X-Gm-Gg: Acq92OH8pju4HJfBzhg0Tr0I/nWNm+am+QNFpuz869kbTsshFOW7SVPHdOLRBIrixJP
 R/bi8CF+vLCGWxdYw3wYsyfFcH7OYd9JrYC2NfGehvVdxApK74jyb8kfE7Y6ENL0JIWfOMXK6Yq
 UpyfInDK9hmPrxAhRQYfNyNCwKLNOEXoBpwQmP6GrdS2CeBaoSYlky4XXTJrc6/rpvYn/6euaqV
 zbLBQm3FB7NBuRZLkct+/7+MyKDmXagQUyZhYTLDkHqQIS3x5fdFc+cC6ma5dCVnZwMI3Svy8zS
 qSdSJWY6TJrc2VSYWT8g5BWVEPst/BPDlHorB5RlPjFMBHOViPhBN6LoUnDBf6pvnneTCbKCmCq
 AbPL2wpqRhcE3MyFPMG3lK1MvhzTI3zTE3patCPjIznu05V2Xrx4IMnbocne9FA3fytGazj0y6b
 7gqoXisay5TnstaiSLkg==
X-Received: by 2002:a05:6830:6f4b:b0:7d7:d0f1:a132 with SMTP id
 46e09a7af769-7e4fa0455d6mr4101210a34.22.1778877233420; 
 Fri, 15 May 2026 13:33:53 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 11/11] doc: commands: Recommend getopt() for option parsing
Date: Fri, 15 May 2026 14:33:02 -0600
Message-ID: <20260515203311.2555651-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515203311.2555651-1-sjg@chromium.org>
References: <20260515203311.2555651-1-sjg@chromium.org>
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

