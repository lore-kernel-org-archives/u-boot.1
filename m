Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A42C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 605448888B;
	Wed, 22 May 2024 18:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UId5aUFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1278889F; Wed, 22 May 2024 18:04:48 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2DCF88851
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a5a7d28555bso1074547266b.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393886; x=1716998686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V16hnpl7Taq4RqXcRkOQcbjFB47V8F5llW3zbxbqSJ4=;
 b=UId5aUFfVltQyY4KBrCoQQLPd39Lj0yIBrZszH81ceoK4nfU5M6IUWAFqJ7wtn+waB
 NzR7J4dJa+Jp7FBA1YLNBxanGsi6p65srAxqRYZANETHjUU6JQUzQ+jBZssKhs23ezvG
 K2kmjkg1a3LKyPvWpb/VXbFpVxlduDVhNKLhBruGaIt64Iq5LwiJJWVwgVq6N1xnWEzQ
 HQmi2HMsOihHdzr9MhJYZavhqZn9zqN/ByJIN/zMwhK3HZNSdUFh4BbazG2O0V+wjdZN
 KhpzzpCEEYrtD2vZ8DLfDS9ANuTrjwPdXADXCjFayzgcp2dVE6udmjGvByMc+tR6NiW5
 N81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393886; x=1716998686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V16hnpl7Taq4RqXcRkOQcbjFB47V8F5llW3zbxbqSJ4=;
 b=AEzhK7zQ2T1UuZcf+miU55VgDQ38RAOuqpWJZD7PrL/VewxHRcXI+w7dd7WgBzr51B
 0p+amwr69lULXmnKcfqJcKIMBmvgPfDirvfOvLYTnLVxWsO4x6YANdA3+he9OGJp7+oj
 I474i/FeUM88369NSWn7I1f9IAZ4K+xs75CaSv+KQV9ixKlU92j5a+z6oIBtuXtFX1Hf
 4F7wE1VXz3LNbyUyQ5wgPoqQsBxU+w29gbWwj1ALqkzl8nGiWUF5olh8w/uF454hImkL
 8PYMDkQzRA7DncEEf1KB11tD4w140y8Fof7sEhwSuRbR26kV/Le9HmB9583NyKX2Vfg0
 IJBg==
X-Gm-Message-State: AOJu0YxPdKC6aLCDuMRhAHKgvf8bCKBFw+l5/gLi4ER5krq0SV2y94zB
 POWB3xrhtYAacSlOmstJ2cEy5nwLcgh3QR+KqHpAdyX8DNzgVYmKxMzAr3zqmv9UJpRS4sCHjM3
 rliVuZhaB
X-Google-Smtp-Source: AGHT+IE/o+Ev2QArpmhnxJoBnyofLQldI1mUDIeGX5o20VFJU4F1SLK58rIcfsQ7vR64bxf/gzg7yQ==
X-Received: by 2002:a17:906:6148:b0:a59:c963:82b with SMTP id
 a640c23a62f3a-a62280b4751mr163314866b.33.1716393886237; 
 Wed, 22 May 2024 09:04:46 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:45 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCH 13/15] test/py: net: add _lwip variants of dhcp,
 ping and tftpboot tests
Date: Wed, 22 May 2024 18:00:13 +0200
Message-Id: <f9cea6e3c5f7fada11a7234ef25609b6b42a7f41.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
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
index 038a473b23..ba30780903 100644
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

