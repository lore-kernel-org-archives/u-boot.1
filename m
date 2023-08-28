Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A30C83F14
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44FB8864E0;
	Mon, 28 Aug 2023 23:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFq+ecH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D285180569; Mon, 28 Aug 2023 23:56:45 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE092864D7
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a7aedc57ffso2677890b6e.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259801; x=1693864601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9VdaNUPgo5/Ue3uagalF2D7WfXLcG75Z5vSrJFR7LU=;
 b=kFq+ecH372Siq8y48seATYXpQV14K91hB3JUvfh9ubSGrZd6pq1zsSdzBHg10tv8ap
 AXaP7x8OGq6BGPa9fYw7MqA7x6kV9s/DeCOqmmJJGZ4OWBUOpHEnkPb66i1pp6Qvq7ZV
 5VDElWMgvLpMdeNr9eV0uHbgD7WXCRr+aLTt1AXb/sBf2/1SzlpX0L6/K8ydUhpiMJlk
 EJNLYGi0pg1SzE9wLVfAK+LDGiPtALIAG+J7V10jE1eqCAuPN2sATN4JNldf9ZARQrq2
 dcoHnT7hIPto15X7BDrg7+b3n30empP9/A9C1LQSjprnLj97zCLDWMdBRV0LNgZpa7Sy
 BjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259801; x=1693864601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9VdaNUPgo5/Ue3uagalF2D7WfXLcG75Z5vSrJFR7LU=;
 b=PJHvhl4YHfqi/ACYw0R9EIxvtoKm6w7cz0wthN4gbOXHzJBlVhucNOp83yEPdmbTrV
 aRzmxpijcRSYbTgEYnQSlUmhCww6h9qemRUsVGMWCKAfmu4YLVdolFo6KkjpIlIukjLg
 QNaLR43iv4OmsShPTHb4oWFDn6qys4j/IR/MyacX1RwHb2wbKWL+xFkm3j9AAkaaPIko
 S0nWuosTl4RQ0gRzWsRSv4mkVFL/VBgTCg/Mj2Nb2yyy9YgXDa07ORVSqLxSdSvW9Cju
 /VRnTbSA+H4oLkTnHY5XuPcwODJLGwRRfAJPhJDj+lp31DZpcAXhPR0exuPsxG/yfc3F
 vXdw==
X-Gm-Message-State: AOJu0YyeEzAyq6G2nBK54zFpogXn3B+PtdHrUsCJ/vxZS5pjmC0f1cKa
 FN8jMahQD/dbN1R03uFEmvGqisPmVS8=
X-Google-Smtp-Source: AGHT+IHgS1ZbvqJCBoM7SIGpCNo/W3sM2bIRekkT3VmpzLOu93RVvo21zT2IGZufqjbirm4Nktf0aQ==
X-Received: by 2002:a05:6808:656:b0:3a7:d857:c588 with SMTP id
 z22-20020a056808065600b003a7d857c588mr11303964oih.2.1693259801045; 
 Mon, 28 Aug 2023 14:56:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::c239])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a0568080b2800b003a7527207b5sm3856298oij.7.2023.08.28.14.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 14:56:40 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 3/8] tests: gpt: Remove test order dependency
Date: Mon, 28 Aug 2023 15:56:10 -0600
Message-Id: <20230828215623.3727536-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230828215623.3727536-1-JPEWhacker@gmail.com>
References: <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230828215623.3727536-1-JPEWhacker@gmail.com>
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

