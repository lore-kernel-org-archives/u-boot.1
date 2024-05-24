Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EB0C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63358866B;
	Fri, 24 May 2024 18:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jDCWuhRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 372ED88640; Fri, 24 May 2024 18:22:30 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9040088682
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-354fb2d8f51so1518821f8f.3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716567745; x=1717172545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kO0B51aoveaGtlk1f5Aam2nRiGQYJIZdbHMlcXi4I4M=;
 b=jDCWuhRxPbVAGETQ1rblz25S9ck2hdKorMaAjeddheHSRfEGSd+N/Ijq9tV01PLpGp
 cDdnr24r3W/ypzEN9KOOG92IBVqNwcgbahRMu7c7HtTJY9g24cAFSsx+5738alll8Uik
 lNZS6PwuRINHd4da+7hwFj9VxsBX7CYsAv4wi1bLbBNk6U5rUkrX9qY36fadfyoEPWKH
 ceSH2d7r4Am6cCSfUqTLBuBdNeGqIjKKnsFEs4AdeoAT3yVMrpXum33uikjiXI004mr/
 6slFadD+gClSdD4xfGrDT/YGsP/oIsaQY0BZDfSVKr9qCiz1y5GzKoxiUKo+y+J+hu5I
 ALGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567745; x=1717172545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kO0B51aoveaGtlk1f5Aam2nRiGQYJIZdbHMlcXi4I4M=;
 b=niaA8aR5fQaBLlIngTRFA5C/vIu+UoH8V0dLj19cDXoURhAhUrcKX60Fm6ojN40ytE
 z/Pj3XuF7/Lh643Y0/4vUonnz3TiBdA3QN1cjzP8p/fVz29mFK35Bpv14+BROafLLUye
 /NTka+tfP8HuYhir11SNX2aE3BZQHgk1hlZN2+1SXAkJHOeQgqOjee3f/GE6O5PmswSH
 zzNpVjzFRtA6HrUDy4y8pKHuqwAd8Xsksl6PSvBwsw7dCFsLDRKzXjiuKOQefkHyYuAV
 kuaxL8T4tpq8JYi4m+3hGPPQoGH1gHIWMa30GKuQmO4i1Ng+2pc8Lx1/jvkZWjXEwneC
 lXww==
X-Gm-Message-State: AOJu0YyX2XKwI9A+14MqHMJDagvOIDACQhZWGOfJTTzLtvszFhxeMlgY
 YRYFTy1fgplpJ8+azH/JoGTzO40g1qdpMN7nnhCeFAUcfqEkRzw6WNh2V7Tl2JHC2eDigMmG8yA
 vKQIP6rZ7
X-Google-Smtp-Source: AGHT+IFNQkVyFzMzIzwq0RdfdhtMiUp5fME86mUd7JYvOgpV0u1gxeJm0yyYRh28ExZhhZGDtlyaWQ==
X-Received: by 2002:a5d:6106:0:b0:355:42b:820c with SMTP id
 ffacd0b85a97d-35538b56d55mr1861759f8f.63.1716567744983; 
 Fri, 24 May 2024 09:22:24 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:80fe:af01:c137:b43b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c918csm1928465f8f.77.2024.05.24.09.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:22:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>,
 Maxim Uvarov <maxim.uvarov@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 12/14] test/py: net: add _lwip variants of dhcp,
 ping and tftpboot tests
Date: Fri, 24 May 2024 18:20:06 +0200
Message-Id: <9acc7630e5768ab9af673981a78ffb84b47aa62e.1716566960.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
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

WHen NET_LWIP is enabled, the dhcp/ping/tftpboot commands are enabled
via CMD_DHCP_LWIP, CMD_PING_LWIP and CMD_TFTPBOOT_LWIP, respectively;
therefore the config annotations in the Python test scripts need to be
cmd_dhcp_lwip, cmd_ping_lwip and cmd_tftpboot_lwip.

The console output of the tftpboot command with lwIP is slightly
different from the non-lwIP implementation. This is taken care of in
test_net_tftpboot().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/py/tests/test_net.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index 038a473b239..ba30780903f 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -127,6 +127,10 @@ def test_net_dhcp(u_boot_console):
     global net_set_up
     net_set_up = True
 
+@pytest.mark.buildconfigspec('cmd_dhcp_lwip')
+def test_net_dhcp_lwip(u_boot_console):
+    test_net_dhcp(u_boot_console)
+
 @pytest.mark.buildconfigspec('cmd_dhcp')
 @pytest.mark.buildconfigspec('cmd_mii')
 def test_net_dhcp_abort(u_boot_console):
@@ -230,6 +234,10 @@ def test_net_ping(u_boot_console):
     output = u_boot_console.run_command('ping $serverip')
     assert 'is alive' in output
 
+@pytest.mark.buildconfigspec('cmd_ping_lwip')
+def test_net_ping_lwip(u_boot_console):
+    test_net_ping(u_boot_console)
+
 @pytest.mark.buildconfigspec('IPV6_ROUTER_DISCOVERY')
 def test_net_network_discovery(u_boot_console):
     """Test the network discovery feature of IPv6.
@@ -255,7 +263,7 @@ def test_net_network_discovery(u_boot_console):
     assert '0000:0000:0000:0000:0000:0000:0000:0000' not in output
 
 @pytest.mark.buildconfigspec('cmd_net')
-def test_net_tftpboot(u_boot_console):
+def test_net_tftpboot(u_boot_console, lwip = False):
     """Test the tftpboot command.
 
     A file is downloaded from the TFTP server, its size and optionally its
@@ -279,10 +287,11 @@ def test_net_tftpboot(u_boot_console):
         output = u_boot_console.run_command('tftpboot %s' % (fn))
     else:
         output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
-    expected_text = 'Bytes transferred = '
     sz = f.get('size', None)
-    if sz:
-        expected_text += '%d' % sz
+    if lwip:
+        expected_text = f'{sz} bytes transferred'
+    else:
+        expected_text = f'Bytes transferred = {sz}'
     assert expected_text in output
 
     expected_crc = f.get('crc32', None)
@@ -295,6 +304,10 @@ def test_net_tftpboot(u_boot_console):
     output = u_boot_console.run_command('crc32 $fileaddr $filesize')
     assert expected_crc in output
 
+@pytest.mark.buildconfigspec("cmd_net_lwip")
+def test_net_tftpboot_lwip(u_boot_console):
+    test_net_tftpboot(u_boot_console, True)
+
 @pytest.mark.buildconfigspec('cmd_nfs')
 def test_net_nfs(u_boot_console):
     """Test the nfs command.
-- 
2.40.1

