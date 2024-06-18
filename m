Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71E4C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 20:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE04882DB;
	Tue, 18 Jun 2024 22:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i3xt9xpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878C8831A2; Tue, 18 Jun 2024 22:23:50 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516FF882DB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 22:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5bb36de2171so3141548eaf.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 13:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718742227; x=1719347027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iClqt5kegRj4SBrJeo0SZFrXn010sXzhMSWyBk4DO7M=;
 b=i3xt9xpnkFwfyiMrQtvO2FY8bDJAtgbzJfJi+9fEwXv1k0PjdVnvbnT6vRMbVsqZBD
 PlwsDSSa+1UTslZxRM4wWpPvj1M5laqQ9RTJuObGX0Xh7Xr7lj/fGqX5Lu5tTcA7n2Fv
 k5Zl0Q48hHJqKrxpUfOHcxs53ZEJraD/7HbFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718742227; x=1719347027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iClqt5kegRj4SBrJeo0SZFrXn010sXzhMSWyBk4DO7M=;
 b=mZqF9hH3YaQKXbMex5Xbjx41e5mVyO1WU3jTwTGGecddtrHqmtt95LJ5YJVSnszyOV
 23eGal+PlHfKdB3F1OxGq7jSS++BV/V0+1pWd4h2gjLczjvPpMOLXHtZJzNP3e6SNdzT
 YsJmeubulwzMk55H+mY7tduSp52xEWqVeC4yNdC61Rxwreqr7DBDb6JPw83maCdxAjhp
 HPx3nXGYuS5tIO3m0orRcT8SQyh0xnwA+apMUg2+k9V6WbHhVmTK1x+96ZDxly0+DGXk
 eNeuDx2Df69PLTHd3N08x4D/ePCFWb3wBhTxSuRQIEEMQRb7sTbxUGGXU4Ris34Zrm85
 pDGg==
X-Gm-Message-State: AOJu0Ywj4HQn4nrkfYaoV+wcYzY5Y4EYARtRWMvluv1oCoDUiMGWQXYz
 18DjlZm5ZaFizxtddb+r5jHBexRpLBB4n4+JpDmJ7S7vqfi8qe06UCoc6I8OjiJJcgJB9zzFkns
 o3JomNw==
X-Google-Smtp-Source: AGHT+IFlXj/UGOsSwtjHtfylHZeqGb/UfuQTmxx61Jj0aHHAdA6NswUsFiMyrIfU1kSxrsHQExRv8Q==
X-Received: by 2002:a4a:8556:0:b0:5bb:672:404d with SMTP id
 006d021491bc7-5c1adc21617mr833313eaf.7.1718742227085; 
 Tue, 18 Jun 2024 13:23:47 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd5f4960fasm1555865eaf.32.2024.06.18.13.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 13:23:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Love Kumar <love.kumar@amd.com>
Subject: [PATCH] test/py/tests: Update some network dependencies
Date: Tue, 18 Jun 2024 14:23:43 -0600
Message-Id: <20240618202343.3332529-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

On tests which require "tftpboot" we need to depend not on cmd_net but
rather cmd_tftpboot. And on tests which require cmd_pxe we do not need
to also depend on cmd_net as this should be handled already via Kconfig
logic.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/tests/test_net.py      | 5 ++---
 test/py/tests/test_net_boot.py | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index 038a473b2394..ad143c19b0d2 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -254,7 +254,7 @@ def test_net_network_discovery(u_boot_console):
     assert 'Set gatewayip6:' in output
     assert '0000:0000:0000:0000:0000:0000:0000:0000' not in output
 
-@pytest.mark.buildconfigspec('cmd_net')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
 def test_net_tftpboot(u_boot_console):
     """Test the tftpboot command.
 
@@ -335,7 +335,6 @@ def test_net_nfs(u_boot_console):
     output = u_boot_console.run_command('crc32 %x $filesize' % addr)
     assert expected_crc in output
 
-@pytest.mark.buildconfigspec("cmd_net")
 @pytest.mark.buildconfigspec("cmd_pxe")
 def test_net_pxe_get(u_boot_console):
     """Test the pxe get command.
@@ -391,7 +390,7 @@ def test_net_pxe_get(u_boot_console):
     assert "Config file 'default.boot' found" in output
 
 @pytest.mark.buildconfigspec("cmd_crc32")
-@pytest.mark.buildconfigspec("cmd_net")
+@pytest.mark.buildconfigspec("cmd_tftpboot")
 @pytest.mark.buildconfigspec("cmd_tftpput")
 def test_net_tftpput(u_boot_console):
     """Test the tftpput command.
diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index 4729ccf07feb..63309fe82e12 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -156,7 +156,7 @@ def setup_tftpboot_boot(u_boot_console):
 
     return addr, timeout, pattern, chk_type, chk_pattern, config
 
-@pytest.mark.buildconfigspec('cmd_net')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
 def test_net_tftpboot_boot(u_boot_console):
     """Boot the loaded image
 
@@ -209,7 +209,6 @@ def setup_pxe_boot(u_boot_console):
 
     return f, bootfile
 
-@pytest.mark.buildconfigspec('cmd_net')
 @pytest.mark.buildconfigspec('cmd_pxe')
 def test_net_pxe_boot(u_boot_console):
     """Test the pxe boot command.
@@ -261,7 +260,6 @@ def test_net_pxe_boot(u_boot_console):
             u_boot_console.drain_console()
             u_boot_console.cleanup_spawn()
 
-@pytest.mark.buildconfigspec('cmd_net')
 @pytest.mark.buildconfigspec('cmd_pxe')
 def test_net_pxe_boot_config(u_boot_console):
     """Test the pxe boot command by selecting different combination of labels
@@ -341,7 +339,6 @@ def test_net_pxe_boot_config(u_boot_console):
             u_boot_console.drain_console()
             u_boot_console.cleanup_spawn()
 
-@pytest.mark.buildconfigspec('cmd_net')
 @pytest.mark.buildconfigspec('cmd_pxe')
 def test_net_pxe_boot_config_invalid(u_boot_console):
     """Test the pxe boot command by selecting invalid label
-- 
2.34.1

