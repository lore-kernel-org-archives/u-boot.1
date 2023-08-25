Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04981C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 19:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8793386B06;
	Fri, 25 Aug 2023 21:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pgzGZVpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9526486B05; Fri, 25 Aug 2023 21:38:48 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF7B86AE7
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 21:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bcade59b24so934719a34.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692992324; x=1693597124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9VdaNUPgo5/Ue3uagalF2D7WfXLcG75Z5vSrJFR7LU=;
 b=pgzGZVpf5MwlK/jw15W2aqKvGUJdgK0D9CVvcyVm1OPUJoV2PWxQZbX/fdGBKfFkPT
 6HTaryK5sysmjYoAgdhZ6tg69/wZELPLnc3noJ6hF+yteMom/SXlHydPoFLTJcqD0pqx
 ZDzElDU1j7PiRnQCQGfzl1IHMK6rZVw9M6HjVTJpWHPf1CHlkgm0w0jKR5I1fMHxydlr
 vb4GcmiWamCfB3TLrCOUNqa4QN73t7jVGlz23yhrXxSa2sH8EygtyPxBxndtF+9TPwal
 xA/QetnXf0urbTSRyBYkYX40jZRIQRO8CmXWWS3PnmxJjYtmYnVU/VYmLfR3qpsWCNTI
 4s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692992324; x=1693597124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9VdaNUPgo5/Ue3uagalF2D7WfXLcG75Z5vSrJFR7LU=;
 b=SIsXCzdHK8w1Nj0K+XSc859spRGLL8JYi5qhIYcMgI69rc520yYtmT1OBFIBbY+9LU
 pQ4Zn8cxq71heRSUVxMZyMc49cW4N1tam2zeEi+UdluqEMHnTwrEuOipr5+CRquYo54I
 vIawYQBkgqYHJvZZ2Gn9WQ1CNlsM+nc87TqdybwGKss4EuMY6f7MufWHjEfoDrJiwe/h
 z6WIPRETtYy+g7mqojwzXnZXxsdbq1lK7h/6RsOJFgO6U5PA7mFPEFmAyFk7eE231CiM
 LoXnyiRbtb82g8IGcPn4H0wVyIrJEiQfGVHUmBbX25VLhr9KFZcOYylJpVSNK+BVdhST
 gB5w==
X-Gm-Message-State: AOJu0YwxN6B1E/lbJWbb9xdXdi3XxyZSyPzLmIGXgH9kygI2E/ewRR2B
 f10fO45Lw/XgljTxZCFc2+x+ywVLTfs=
X-Google-Smtp-Source: AGHT+IF1ekeuf2zeL0dLJvaJVWAAgnBv64wHLKTexrkvxp5b4xPZ4/W/UOa7xLAikWabhxRmtZ5T0Q==
X-Received: by 2002:a05:6830:109a:b0:6b9:48fb:1b5a with SMTP id
 y26-20020a056830109a00b006b948fb1b5amr6617521oto.8.1692992323749; 
 Fri, 25 Aug 2023 12:38:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a9d7e8d000000b006b871010cb1sm1171022otp.46.2023.08.25.12.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 12:38:42 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 3/8] tests: gpt: Remove test order dependency
Date: Fri, 25 Aug 2023 13:38:19 -0600
Message-Id: <20230825193830.2753640-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230825193830.2753640-1-JPEWhacker@gmail.com>
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
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
2.33.0

