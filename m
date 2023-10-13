Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AC2CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A711686E5E;
	Fri, 13 Oct 2023 18:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SAWElfMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5424A86E5E; Fri, 13 Oct 2023 18:29:08 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5169286A4C
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-79f82b26abfso81943939f.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697214541; x=1697819341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4uIJWVfIJ2bSoGhpMTZcVJe265wVB0CVztI/dvEFhUA=;
 b=SAWElfMfTTXCL2vNikPGYdwm7GhyaX4Jt6nQ9T/4N2esvf6sGzSvaewej0JMkvAvnD
 bieW8I6+zlT7MWjjBAy0h5tCaxwjdFNBEhNkSeHlmRDlJPv2S7QtIozlvBBSUdhVjcFy
 N48/aGlZkm4RC4BpsnyL2WFc9M6STm2kt5gb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697214541; x=1697819341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4uIJWVfIJ2bSoGhpMTZcVJe265wVB0CVztI/dvEFhUA=;
 b=EM+yHFvSlPbVZP12He0dRvfOXYHix64ToYkCtAsf60PW/BWW5m/stgPhsprWXmWm15
 k6q+R1iRXnUn2VYCdnfAd3Kk3ovmRtvKF85EBKbSbVn9qGdXPKW+h9c7qT03zjrRBTkG
 oCl65u7jtIpRPnfxUrrkwuIq233ozbUqle9lMZNz/jQfz1JjkIWKEG5cpLWbvb1ibgHl
 DYMn3L9HwU2a0E3aiRVwTjGlHjYIvkJje508Up6tsxuVXbuD3rTkqgz/Ptn2DAjmm7AA
 771KXBWko/HYcYs5qYFDnt3eP2rmUtEjlva87OzP+mptLwPNzm+/OlqMAvnz4WX5HdZN
 wlew==
X-Gm-Message-State: AOJu0Yx801K3JCvsdcC87rCXUaRPqSTBqPnb1za9u+sGNO0FpcoRjY8e
 /puUB4t3X/QjMVFW4Nrj/R/p67o46V+ElHWXmJMlGg==
X-Google-Smtp-Source: AGHT+IHcPTv4jmh41NLYhruXJUgI0zUcCRARJ213e92pxX4SwaR292WP2GCUhDqkZ3w2mnvmjyoKJg==
X-Received: by 2002:a5d:9946:0:b0:79f:dbec:ac4d with SMTP id
 v6-20020a5d9946000000b0079fdbecac4dmr30482638ios.19.1697214540780; 
 Fri, 13 Oct 2023 09:29:00 -0700 (PDT)
Received: from sjg1.www.unitedwifi.com ([75.104.104.107])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a5edd42000000b0077a1d1029fcsm4816757iop.28.2023.10.13.09.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:29:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lars Feyaerts <lars@bitbiz.be>
Subject: [PATCH v2 1/2] checkpatch.pl: Make common.h check boarder
Date: Fri, 13 Oct 2023 09:28:32 -0700
Message-ID: <20231013162836.1911982-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
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

From: Tom Rini <trini@konsulko.com>

At this point in time we should not add common.h to any new files, so
make checkpatch.pl complain.

Signed-off-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Only check one header at a time in checkpatch.pl

 scripts/checkpatch.pl           | 10 ++++++++--
 tools/patman/test_checkpatch.py |  9 +++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 488d73a0ed77..b8eb57f38c74 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2636,12 +2636,18 @@ sub u_boot_line {
 		      "All CONFIG symbols are managed by Kconfig\n" . $herecurr);
 	}
 
-	# Don't put common.h and dm.h in header files
-	if ($realfile =~ /\.h$/ && $rawline =~ /^\+#include\s*<(common|dm)\.h>*/) {
+	# Don't put dm.h in header files
+	if ($realfile =~ /\.h$/ && $rawline =~ /^\+#include\s*<dm\.h>*/) {
 		ERROR("BARRED_INCLUDE_IN_HDR",
 		      "Avoid including common.h and dm.h in header files\n" . $herecurr);
 	}
 
+	# Don't add common.h to files
+	if ($rawline =~ /^\+#include\s*<common\.h>*/) {
+		ERROR("BARRED_INCLUDE_COMMON_H",
+		      "Do not add common.h to files\n" . $herecurr);
+	}
+
 	# Do not disable fdt / initrd relocation
 	if ($rawline =~ /^\+.*(fdt|initrd)_high=0xffffffff/) {
 		ERROR("DISABLE_FDT_OR_INITRD_RELOC",
diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index a8bb364e42b2..f8117460ced2 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -238,7 +238,7 @@ index 0000000..2234c87
 + * passed to kernel in the ATAGs
 + */
 +
-+#include <common.h>
++#include <config.h>
 +
 +struct bootstage_record {
 +	u32 time_us;
@@ -401,10 +401,15 @@ index 0000000..2234c87
     def test_barred_include_in_hdr(self):
         """Test for using a barred include in a header file"""
         pm = PatchMaker()
-        #pm.add_line('include/myfile.h', '#include <common.h>')
         pm.add_line('include/myfile.h', '#include <dm.h>')
         self.check_single_message(pm, 'BARRED_INCLUDE_IN_HDR', 'error')
 
+    def test_barred_include_common_h(self):
+        """Test for adding common.h to a file"""
+        pm = PatchMaker()
+        pm.add_line('include/myfile.h', '#include <common.h>')
+        self.check_single_message(pm, 'BARRED_INCLUDE_COMMON_H', 'error')
+
     def test_config_is_enabled_config(self):
         """Test for accidental CONFIG_IS_ENABLED(CONFIG_*) calls"""
         pm = PatchMaker()
-- 
2.42.0.655.g421f12c284-goog

