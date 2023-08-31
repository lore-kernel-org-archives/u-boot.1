Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94817C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC03867D2;
	Thu, 31 Aug 2023 18:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jUgLv7ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D2F867D2; Thu, 31 Aug 2023 18:52:02 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91ADC866DC
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6bd3317144fso856244a34.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693500717; x=1694105517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYvlpM4lgLaMucltk416uBiXuUTBiksd6hvEr/SXYn4=;
 b=jUgLv7ll7yZ2R5nl41O+4A7f9lwXXM4UkvWv4rTDMiV6TdjfOTaaiHr7/qIfC2qxUp
 K6Xb4CbrH0T+coGQYh+KYxzvJMCDtX1owfxz88S37Qk5ums0QDp78wh2YOb//sUXuRVx
 rb78BghrcGjcpHOq+AeBzYIDkPAHHHVHVKz6X2PWwP7nQpuTTpl+ArqEwnna1WTq2ILI
 Eas90jKKjX72TC9HqMP+6bDoYxkerB9OCJPs0JfPIxmqjDf9gS633XmKrJgy+Enc+BKC
 SAvPyZgwNd3Cd5fXYnaUat9+m+YHZNRr5BP/26d03F+bDYAfGYwqtG9fduCNj6eP+zV3
 vGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693500717; x=1694105517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYvlpM4lgLaMucltk416uBiXuUTBiksd6hvEr/SXYn4=;
 b=eGhcnK6+6c3gZndij8AwicTIexgA4tLpxIWAvw7DGj/HDTxnsTVVgcQvAbDmX3XoGu
 tED/KMrYmImZoY7izSGAGhucu6YjSTu0EEk8HDcpRDrDNP+KurZZ5/JMM9RMwyBTS9cm
 VR5ZJAMNeJyoLnOjGXSLl0+UweVe2VSiQKJSRqzezY+AEfgFJzvFQFSEW60qcO/8neJ/
 6G+c6QFtmckotgcAJ3bUutCocPsP0YEazCmwLMGGqhjaPyI/BRlmrMI0h4hH9RNi1a0N
 M3S2vqnJuu6p0qQN0VzsDkAMdgU8SWWDbggdfcqsZlsqPZ4SYJ640fHBAnsYQzXDNGmt
 n22A==
X-Gm-Message-State: AOJu0YxK/mdnXjEsWSmeeqmQnCK8cAQwMzSL3ISRHC1fTq5gD0DgVskU
 oOwQ05LTAh2K2/hG5DTHr/vJKJl3z9s=
X-Google-Smtp-Source: AGHT+IF9jCQ0Mv0uWNfyla4XrgGRcYVhU01kxW8q6zZOyJfOyuhmiuumprz417bh8URB92FzuI1ZDQ==
X-Received: by 2002:a9d:6f17:0:b0:6bc:bc3e:f40b with SMTP id
 n23-20020a9d6f17000000b006bcbc3ef40bmr6388372otq.19.1693500717693; 
 Thu, 31 Aug 2023 09:51:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::b66b])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a9d6b8f000000b006bb334880d8sm867020otq.81.2023.08.31.09.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:51:56 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 3/8] tests: gpt: Remove test order dependency
Date: Thu, 31 Aug 2023 10:51:36 -0600
Message-Id: <20230831165144.592820-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831165144.592820-1-JPEWhacker@gmail.com>
References: <20230828215623.3727536-1-JPEWhacker@gmail.com>
 <20230831165144.592820-1-JPEWhacker@gmail.com>
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

Re-create a clean disk image for each test to prevent modifications from
one test affecting another

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 test/py/tests/test_gpt.py | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index 73bfbf77a2..339468bc12 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -61,18 +61,14 @@ class GptTestDiskImage(object):
         cmd = ('cp', persistent, self.path)
         u_boot_utils.run_and_log(u_boot_console, cmd)
 
-gtdi = None
 @pytest.fixture(scope='function')
 def state_disk_image(u_boot_console):
     """pytest fixture to provide a GptTestDiskImage object to tests.
     This is function-scoped because it uses u_boot_console, which is also
-    function-scoped. However, we don't need to actually do any function-scope
-    work, so this simply returns the same object over and over each time."""
+    function-scoped. A new disk is returned each time to prevent tests from
+    interfering with each other."""
 
-    global gtdi
-    if not gtdi:
-        gtdi = GptTestDiskImage(u_boot_console)
-    return gtdi
+    return GptTestDiskImage(u_boot_console)
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
@@ -186,12 +182,12 @@ def test_gpt_swap_partitions(state_disk_image, u_boot_console):
 
     u_boot_console.run_command('host bind 0 ' + state_disk_image.path)
     output = u_boot_console.run_command('part list host 0')
-    assert '0x00000800	0x00000fff	"first"' in output
-    assert '0x00001000	0x00001bff	"second"' in output
-    u_boot_console.run_command('gpt swap host 0 first second')
+    assert '0x00000800	0x00000fff	"part1"' in output
+    assert '0x00001000	0x00001bff	"part2"' in output
+    u_boot_console.run_command('gpt swap host 0 part1 part2')
     output = u_boot_console.run_command('part list host 0')
-    assert '0x00000800	0x00000fff	"second"' in output
-    assert '0x00001000	0x00001bff	"first"' in output
+    assert '0x00000800	0x00000fff	"part2"' in output
+    assert '0x00001000	0x00001bff	"part1"' in output
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_gpt')
-- 
2.34.1

