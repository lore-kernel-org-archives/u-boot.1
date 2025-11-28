Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4DFCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 06:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A6683B9B;
	Fri, 28 Nov 2025 07:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KlhDwiMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41011842E6; Fri, 28 Nov 2025 07:46:57 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E73B83B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 07:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-108-100.46.114.pool.telefonica.de
 [46.114.108.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3CE383F5DB; 
 Fri, 28 Nov 2025 06:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764312413;
 bh=APN4CFbOvyOFi/aKBePKI550W/QwGsniGMiXvue27Wk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KlhDwiMiL+jkGa3EuwWsfhrXuQTsDPGw3sybppV2DYkVMkHoLPrpI52qlnBDfS5DL
 4fouQQHK2IvIuXDD4CgnLDk8dT6k1uXqqhyQ80kGa2Q/AV1ixMysIDG68Tlyg1TjEd
 hxDEGZ/nvLuCVVx14H6HR0JFONiVNN0uE9pPKdmILEyFvxoV+LDTX1MA8Mlb5Ceb3W
 KAW8QcsJtnOuIR2awFmfwrMBJqE8zIEHyXA8JZ4kbFIXlfpwwR/d4Jau0AKdQdyoJ2
 gIJEPXo5mzuHMobGvEyekUHGgpiHcis3/rsufgm+hbePxRIEpq9Kr1u3X7K1H06Jil
 GVOgdXP+U6+lBWGr24kQ34yNrQfnJrWpdQJ0stK0U1qRMFKnTAiRQCG2VwRepxEoyn
 pwUgGeUOWU6KCtPptYB9daFeU2M9on4Wyb9EtcwIPLrdPJHMRRxCGZKeaZJLwHxw4U
 TqOTaRiGAZ2aONfgQJ1lvgvuPpY1M571WT9RNIl7OvaYjXl3AxLcfHJnmwlxh/5sMb
 PCvdDBxzb+nQHKrRfMyBk9czOPrJmMHxQBG7n0cTxOzgussy8whKz5f9XPd46hUQRY
 ujc4T6sj+HYFFbW3+2utRrdEkDeXs2Ox3MdZ4nKtX3mlEyuHazClzXW/3HIH29x5cE
 gEJbDFmN0taTInrUdu2cXaFE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] usb: xhci: avoid noisy 'Starting the controller' message.
Date: Fri, 28 Nov 2025 07:46:47 +0100
Message-ID: <20251128064647.12162-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

We should avoid overwhelming users with non-essential messages.

The message 'Starting the controller' is not written for EHCI.
We should not write it for XHCI either.

Adjust the Python test accordingly.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/usb/host/xhci.c   | 2 +-
 test/py/tests/test_usb.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3ee1f67190f..15d81da4447 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -158,7 +158,7 @@ static int xhci_start(struct xhci_hcor *hcor)
 	u32 temp;
 	int ret;
 
-	puts("Starting the controller\n");
+	debug("Starting the controller\n");
 	temp = xhci_readl(&hcor->or_usbcmd);
 	temp |= (CMD_RUN);
 	xhci_writel(&hcor->or_usbcmd, temp);
diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
index 1dcd0834f55..9226d1c174d 100644
--- a/test/py/tests/test_usb.py
+++ b/test/py/tests/test_usb.py
@@ -58,7 +58,7 @@ def test_usb_start(ubman):
     assert 'USB init failed' not in output
     assert 'starting USB...' in output
 
-    if 'Starting the controller' in output:
+    if ubman.config.buildconfig.get('config_usb_xhci_hcd'):
         assert 'USB XHCI' in output
 
     output = ubman.run_command('echo $?')
@@ -104,7 +104,7 @@ def test_usb_reset(ubman):
     assert 'USB init failed' not in output
     assert 'resetting USB...' in output
 
-    if 'Starting the controller' in output:
+    if ubman.config.buildconfig.get('config_usb_xhci_hcd'):
         assert 'USB XHCI' in output
 
     output = ubman.run_command('echo $?')
-- 
2.51.0

