Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B8CEEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2890D86915;
	Fri, 15 Sep 2023 02:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WxuQpl+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A374686496; Fri, 15 Sep 2023 02:22:56 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B83486496
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79329a8f78bso55171039f.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737373; x=1695342173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUQnWK6vyR/eSx0hsTdUDTACGaRMPeszII1aHbI0Hn8=;
 b=WxuQpl+MQ3WLVJvgNZjNgb2BDXgMW824I5E0DdDmIcOnXxQpf4Gq6nFIml4kJ4QPcK
 +HJ0aaKMmEj9YJsUMyiIj0V69GhNkUBf0VwyiDdXI87v8CV1KKY+0Ufh4sCU0E6e0Yu8
 4HOBYEukD0UEZYpQAdVzRG+FQS4pCZkwFPDPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737373; x=1695342173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUQnWK6vyR/eSx0hsTdUDTACGaRMPeszII1aHbI0Hn8=;
 b=fj2+IqwEofARjFlyHfgaGqmQRFsoj5pgyJnXasyPPnSSZwFUhMW2mxJD5kKVWfBLbC
 5kqDKkuIvh7NvRnnqhDqSEVkL71ZGo0Ske0tmrerESlHnoO6JC4oUS/kGaFTC7Sjz/RI
 i5CurVXEuxRwkozGu1kZjImYG51UqyCDdci1a6g0g/eBiT9/D4YeSk17j+Nh+H9syCfd
 TJQSg+eWnBNtIppOzafCv+O+j1oNLdQKwfoh/xV/tWsfauaQzjwQieDqg11d2OQO14M+
 ePZj5rRzyU9ywnQxvRxALqYU3e/Lsfpw9V6NZF52MHy2YqzhbEa+kKml5vjaebo4wl8O
 tGnA==
X-Gm-Message-State: AOJu0YyNXgWXgWorcZHtrSg/YDa1waCl7kQrLCAftuxsruhshad1mDBu
 mICx5y9z+KndX9g5J0s1z8+2uRg3Opt7rGPZZxs=
X-Google-Smtp-Source: AGHT+IG4fVDR64twGzRiV8wLFYx9pJ+Dcc4a567YfsHZC7e/XY86vW+c22XM1EMRGAirXPUt2qDu+g==
X-Received: by 2002:a5e:8915:0:b0:792:2cb6:5c65 with SMTP id
 k21-20020a5e8915000000b007922cb65c65mr70237ioj.8.1694737373285; 
 Thu, 14 Sep 2023 17:22:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 07/27] moveconfig: Drop suspicious boards
Date: Thu, 14 Sep 2023 18:22:09 -0600
Message-ID: <20230915002236.798760-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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

This code isn't needed anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 87a670f6e855..36202fe5134c 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -601,11 +601,6 @@ class Slot:
         """
         return self.failed_boards
 
-    def get_suspicious_boards(self):
-        """Returns a set of boards (defconfigs) with possible misconversion.
-        """
-        return self.suspicious_boards - self.failed_boards
-
 class Slots:
 
     """Controller of the array of subprocess slots."""
@@ -684,25 +679,6 @@ class Slots:
 
             write_file(output_file, boards)
 
-    def show_suspicious_boards(self):
-        """Display all boards (defconfigs) with possible misconversion."""
-        boards = set()
-        output_file = 'moveconfig.suspicious'
-
-        for slot in self.slots:
-            boards |= slot.get_suspicious_boards()
-
-        if boards:
-            boards = '\n'.join(boards) + '\n'
-            msg = 'The following boards might have been converted incorrectly.\n'
-            msg += 'It is highly recommended to check them manually:\n'
-            msg += boards
-            msg += '(the list has been saved in %s)\n' % output_file
-            print(color_text(self.args.color, COLOR_YELLOW,
-                                            msg), file=sys.stderr)
-
-            write_file(output_file, boards)
-
 class ReferenceSource:
 
     """Reference source against which original configs should be parsed."""
@@ -780,7 +756,6 @@ def move_config(toolchains, args, db_queue):
 
     print('')
     slots.show_failed_boards()
-    slots.show_suspicious_boards()
 
 def find_kconfig_rules(kconf, config, imply_config):
     """Check whether a config has a 'select' or 'imply' keyword
-- 
2.42.0.459.ge4e396fd5e-goog

