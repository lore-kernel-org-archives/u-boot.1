Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97C9C79F61
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF732864DF;
	Wed, 23 Aug 2023 18:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a3skXnjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDD586467; Wed, 23 Aug 2023 18:48:20 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3BF864D3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b9e478e122so4137902a34.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692809297; x=1693414097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9VdaNUPgo5/Ue3uagalF2D7WfXLcG75Z5vSrJFR7LU=;
 b=a3skXnjz7biMS9p8DP7YrAWhugA0/oGcbglpEKZAftmn3AGEET1Or4h28PPZ6JFxvA
 EP5Gy2cNQAqqVhov2iqtWDJjMJTDUZO5H3a8Fm8ZhGn77SeFK6yFJ9454hrB3qSP0R6t
 Ts203yXNtCjfb4P7OY3Gwc7VQ5LyasJyuWbqKUeki943AqH2BypAHkrLyjEqbvNEfVrN
 /P85N0IeStDIQIsKxplkGY7T1YzvrX6OsQbno3Bgm0x7zcRzdaJuHyHnsmz6Mu5QQx6Y
 /HqlCSnPvTNjfLhWDS6/HlcEWXy5eJYQemG+1ylFZxHzL62onJdSev7bqQrqeJZ4QotD
 C/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692809297; x=1693414097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9VdaNUPgo5/Ue3uagalF2D7WfXLcG75Z5vSrJFR7LU=;
 b=J+7eso3Oh8lGIYPHoFej6znKG/I4UWWfrRicEu2G6yUdBLYMuX6e7XbuAoXLcOCizC
 rTVsvv20UF6jVWo+I43/VTdu50w2odiOeXVyduqwodGnxjSaTvrDfchv/QqNEeHHLkWF
 rAlVIyUZgm7x3tQ3MluU8xj389JEjJCXxhsVRSaDzQKquGnbkUbFcpC+xozKryWhV0JY
 4v/bZ66W9ql7YJeZOxLkH0Zu/NNylKqKjCJmQkpLlQMLqxdNbrMFTRiMIyZu0iSSmtjv
 5lrs4Tc9tDXoQWyZyzkkFgtbE+ly8M7w5JjLr8VAzbJ9gu1lPFFQRaFkhqa205TIgFwY
 owKw==
X-Gm-Message-State: AOJu0YwsS8FzShcMdX3D6qcDQwhI1stXDjQTtmlIT/C6Bw3YlsOqwZ9W
 +NvvJRgUPJmYMtYCbdnSV4Uheo/r0VQ=
X-Google-Smtp-Source: AGHT+IE0yn04UWg4WDTKWYdDaKPNoPxwWyFJGdvrrnzJyOHX2z2+6J2pgj66b28SjwVIDq61T/Z6xg==
X-Received: by 2002:a9d:750c:0:b0:6bc:f639:713d with SMTP id
 r12-20020a9d750c000000b006bcf639713dmr14438133otk.30.1692809296833; 
 Wed, 23 Aug 2023 09:48:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::751c])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a056830205600b006b9cb784553sm5794042otp.36.2023.08.23.09.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:48:16 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/8] tests: gpt: Remove test order dependency
Date: Wed, 23 Aug 2023 10:47:39 -0600
Message-Id: <20230823164755.2874792-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230823164755.2874792-1-JPEWhacker@gmail.com>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230823164755.2874792-1-JPEWhacker@gmail.com>
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

