Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A11CD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40AA784E58;
	Sat,  9 May 2026 02:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pH1Ew3M/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D36884CE5; Fri,  8 May 2026 23:32:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6A5484CFD
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 23:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B9243FEC7
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 21:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1778275959;
 bh=yiddp9x9S6gdCPetEGdIOtFmgLoQQUErMs3L72I6tIM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=pH1Ew3M/wj6SrApYWslkF+dvTBCOIJevZFoTvXomkvQLaWVA4FJOiod4fIOLn+4Py
 9pBX/sqSd4vzCzttX7Ke09zxWvPEIH2LVPSqsmGepdHEB5mHPnVkGO5JGgDy7swBA1
 qHvAyjv3CczS1POKwWTSdLYVqNJZenkDpCTlCqCWk3h8xp3rs2CPRQePbf9GIHlF/r
 wdbnluZOWSHuizVT9tCgTEj8uNXkWnseA+WsLyzz+BKgFMETWu9qF0ccPXyuPWx/tj
 GyQ4eYOsl61vjKMBAMkPYKImJU4YVAqxKDQ6duQhOwxDngWzvuf93m4dZqW3CsdRnE
 U8fxqWGKYVWaH3HiSMQAHjWPPql8eVjCNjulbGNacg3dzAGTzzF6A7daso818JHRT4
 2/KYD10XCFSKxzFB9eSAC4qmZhev/xKDPsKFgsa74XWfLzup2Y14rrHzr8aRyWu+BG
 YDL/p8DFdAW1SrjuoDcZT+ETMH5rliNh30LLK+s5WwZSrUCksu1LdiNrrV3ha5qFSt
 I1NOI9Mr/bPnB+DFhOkRn6lphHli/FLDQF0Lbb4b54kF+wgpD4aQjM7algDLgTrh/K
 t+ygCDySO3ek197WZVLimCYDOFGm1+SD0Rswxw9y5YQr+3Be9WOk49iw+9GKkcPcGY
 R9SKw1xvMxFPyCHBQpzs7Jj0=
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f9429f49cso2841521b3a.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 14:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778275958; x=1778880758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yiddp9x9S6gdCPetEGdIOtFmgLoQQUErMs3L72I6tIM=;
 b=rwLmjmnq/Dl9sImUFc0l6fiZHJ8HlC0moowq0OevSpkzb5gygyrZgftu234myUf0w2
 txYPBeSpoDG2f4PgdklzPS2Mt+oMxopmIRRqyohKqcxn3yjHxFnSBthPg+N6o1LtfxP0
 rAhvkEsgYD7Y0lQ13AdH5RepVePMVL2fOmnGfQp3wacimc9cr1ookzfJPUzhua372eBi
 cuLElLsBRAnkZK4f+ne+wKXhDCBI56fjN8z1/l0nJelaFgWRoWvVf/Zo6qnDPXDhaIj3
 XfeZ5ysVV+yAUaYAfg5Rdz7aQPI4u4o9omgx/l2qQ8OzlDuR7wyYE4bHgzUooaxSdY/I
 x2Hg==
X-Gm-Message-State: AOJu0YyP+AO7HNw83lkV2XCjTzIfP7IWMh/e5r5iOVMDvhrsm24/8H8O
 xJ6hjWEpg2uikLUpwtOpmpX/i7XrlxIlmv/1iXIvy3JDWSBXz+VYf55So47+gUfy43SViY03NNN
 1IXqZkEhBCeWwDOq5OneP3eJrlie+0ooLMuVYCo04hloYlj6MUHTn8lupvvpzBZ5sB+tlmtipBI
 Mrz5gLTVWR
X-Gm-Gg: Acq92OFHqf9sdQV/tTm0twrwqeNe1FYiwz/f8q/5K4RAyiYhObP9o2nRjX3mY7ob+TM
 csR/PE1ckNelwymNd4sK91C/PXI3msZ+8JreOAjKu5+QX+fsT8eO4jJky30YERM6dpXH9Rwzgz5
 ba5LSYmf+1qzKjJ+8uro4DDILGQMQbbjVq3LLmoNNrMvmfEgnMFPomrkgfFU7An6wsGA+fJfUsw
 utVwR9LCX+4hRwBmd29eToPd88ZRvtWDr07kbLUuQn9pUksINgwH1DWk+gripgvm3QUOUq0c2eM
 dKwn2zLOBHnO/eYhAkzGIzVXYpirM3hstluJA/SGJ97OxWs0EAPEUIYheP4p1zfSMFvpSanM4jR
 9wkeDBw/+cdMsVuDW/pW8oqZZZzLOxkaXJdZp4Zzb0v1JDMzVkgjU2yjiOXuabU8GNhz/gyS9Nw
 J9zzXazmEUCCopjWk=
X-Received: by 2002:a05:6a00:190e:b0:82c:9e00:f958 with SMTP id
 d2e1a72fcca58-83e36e51082mr34645b3a.0.1778275957675; 
 Fri, 08 May 2026 14:32:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:190e:b0:82c:9e00:f958 with SMTP id
 d2e1a72fcca58-83e36e51082mr34613b3a.0.1778275957237; 
 Fri, 08 May 2026 14:32:37 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83962e7e3fcsm16196751b3a.0.2026.05.08.14.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 14:32:36 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v1 2/3] test: fit: regression test for default-config print
 with reversed node order
Date: Fri,  8 May 2026 21:32:00 +0000
Message-ID: <20260508213217.3807786-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508213217.3807786-1-aristo.chen@canonical.com>
References: <20260508213217.3807786-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:19 +0200
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

Add a test that builds a FIT whose /configurations node is defined
before /images in the source, runs iminfo, and asserts that the
"Default Configuration: '<name>'" line appears in the output.

Before the fix in the preceding commit ("boot/fit: read default-config
property from the configurations node"), fit_print_contents() read the
default-config property using the loop variable left over from iterating
/images children. With /images defined first that variable accidentally
pointed at /configurations and the line printed correctly; with
/configurations defined first the read returned NULL and the line was
silently omitted. The new test exercises the latter layout, which had
no coverage.

iminfo and the fit_print_contents() path had no test coverage at all
before this commit.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index bcaaa6a5fc4..a526307ea7a 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -438,3 +438,56 @@ class TestFitImage:
 
         output = ubman.run_command_list(cmds)
         assert "can't get kernel image!" in '\n'.join(output)
+
+    def test_fit_iminfo_configs_first(self, ubman, fsetup):
+        """Regression: iminfo prints "Default Configuration" even when
+        /configurations is defined before /images in the source.
+
+        fit_print_contents() in boot/image-fit.c used to read the default
+        configuration name from whatever offset libfdt happened to return
+        after iterating /images children. With /images defined first that
+        offset accidentally landed on /configurations; with /configurations
+        defined first the read returned NULL and the line silently went
+        missing. Fixed in commit "boot/fit: read default-config property
+        from the configurations node".
+        """
+        configs_first_its = '''
+/dts-v1/;
+
+/ {
+        description = "FIT with /configurations before /images";
+        #address-cells = <1>;
+
+        configurations {
+                default = "conf-1";
+                conf-1 {
+                        description = "first config";
+                        kernel = "kernel-1";
+                };
+        };
+
+        images {
+                kernel-1 {
+                        description = "first image";
+                        data = /incbin/("%(kernel)s");
+                        type = "kernel";
+                        arch = "sandbox";
+                        os = "linux";
+                        compression = "none";
+                        load = <0x40000>;
+                        entry = <0x40000>;
+                };
+        };
+};
+'''
+        fit = fit_util.make_fit(ubman, fsetup['mkimage'], configs_first_its,
+                                fsetup, basename='configs-first.fit')
+        cmds = [
+            'host load hostfs 0 %#x %s' % (fsetup['fit_addr'], fit),
+            'iminfo %#x' % fsetup['fit_addr'],
+        ]
+        output = '\n'.join(ubman.run_command_list(cmds))
+        assert "Default Configuration: 'conf-1'" in output, (
+            'iminfo output is missing the "Default Configuration" line for a '
+            'FIT whose /configurations node precedes /images. Output was:\n'
+            + output)
-- 
2.43.0

