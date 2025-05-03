Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4B5C369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 13:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0694B8288D;
	Sat,  3 May 2025 15:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TkFKgblp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5397182153; Sat,  3 May 2025 15:32:08 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D67482162
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 15:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-064.46.114.pool.telefonica.de
 [46.114.111.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 24F0A3FAC9; 
 Sat,  3 May 2025 13:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746279122;
 bh=SxskxPD0EealAoDaA1QBCaZXU5ichEMh/r0OU5pJA9k=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=TkFKgblp5RS93VycfjUEVxcp7cFNVa5JoELbGlbiL6EkHcB30g/7L0o052zVV8Bfy
 dVx9NrtdA534P0UkUqfm+d/KmndSKhmSa0InGm06Cyve52BT0d6/0XDVztgoRI9R1/
 lcQQJwKeQrUgw1deXBRMvv0kE/cRvzWPb0dc7YliboRxKNc1bG4cMvgzyudB1XR8fJ
 PT3wWtj45119csljhAaY+qm5mdmxsWo4tz93O9husPdpl6PobO+uST8chc3SI/cJ1M
 lXG8s/zWfcRK0zF7Db6qJZwv66PygR02Tf6BxKmDrwr53a5ucN9V11O3soQlMOG+/G
 Jb94wABrE/GxA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] test: allow testing with NET_LWIP=y
Date: Sat,  3 May 2025 15:31:55 +0200
Message-ID: <20250503133155.55412-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
References: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
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

Adjust network tests to run with CONFIG_NET_LWIP=y.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_efi_loader.py | 2 +-
 test/py/tests/test_fpga.py       | 4 ++--
 test/py/tests/test_net.py        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 58f2655191f..86292f2ae33 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -96,7 +96,7 @@ def test_efi_setup_dhcp(ubman):
     global net_set_up
     net_set_up = True
 
-@pytest.mark.buildconfigspec('net')
+@pytest.mark.buildconfigspec('net', 'net_lwip')
 def test_efi_setup_static(ubman):
     """Set up the network using a static IP configuration.
 
diff --git a/test/py/tests/test_fpga.py b/test/py/tests/test_fpga.py
index 74cd42b910e..299a8653f74 100644
--- a/test/py/tests/test_fpga.py
+++ b/test/py/tests/test_fpga.py
@@ -506,7 +506,7 @@ def test_fpga_loadfs(ubman):
 @pytest.mark.buildconfigspec('cmd_fpga_load_secure')
 @pytest.mark.buildconfigspec('cmd_net')
 @pytest.mark.buildconfigspec('cmd_dhcp')
-@pytest.mark.buildconfigspec('net')
+@pytest.mark.buildconfigspec('net', 'net_lwip')
 def test_fpga_secure_bit_auth(ubman):
 
     test_net.test_net_dhcp(ubman)
@@ -534,7 +534,7 @@ def test_fpga_secure_bit_auth(ubman):
 @pytest.mark.buildconfigspec('cmd_fpga_load_secure')
 @pytest.mark.buildconfigspec('cmd_net')
 @pytest.mark.buildconfigspec('cmd_dhcp')
-@pytest.mark.buildconfigspec('net')
+@pytest.mark.buildconfigspec('net', 'net_lwip')
 def test_fpga_secure_bit_img_auth_kup(ubman):
 
     test_net.test_net_dhcp(ubman)
diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index 4732e4b57f8..3bf91608654 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -199,7 +199,7 @@ def test_net_dhcp6(ubman):
     global net6_set_up
     net6_set_up = True
 
-@pytest.mark.buildconfigspec('net')
+@pytest.mark.buildconfigspec('net', 'net_lwip')
 def test_net_setup_static(ubman):
     """Set up a static IP configuration.
 
-- 
2.48.1

