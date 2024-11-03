Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1841D11195
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 22:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE25689152;
	Sun,  3 Nov 2024 23:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="grlaQ79o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEBEF88F12; Sun,  3 Nov 2024 23:42:39 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC24888F7B
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 23:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-238.46.114.pool.telefonica.de
 [46.114.105.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C0E343FE15; 
 Sun,  3 Nov 2024 22:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730673756;
 bh=VPBQnCrIt4lHZpO2j1hyIy1hVSZx4ZHFp+FQOYqkdPg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=grlaQ79oMHfkA5TQaW1SauE6y6Wx21ZxsrHoBHxcAZVCE7IuMDDtGwK/iN3XJNYE8
 Vx6W1Zy0Gqb+5KsJ7hBsrutx1i2bZz+tBIlkIH95TyA571iLCc0Rkn2LGY6yWL8N1r
 P2Ma07kFZj42yC6/wTBh7w+61wqlUT10IBeDt2sBuJF4GYQ106dXQWI9BRi+vQe3Hs
 SCRYI04NXDh/0aWRCQRZ1a4tXB/2DgZ34J1POJBDok7BC1Jv2PMF9pUrUJdtQKybt6
 t481XPheESohoHFXKjCBj4rsFl4R9705wbkq3mNYpXng6ZUkg2bDUBVpXGCPjhm7lh
 NWN3crmri/P4A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/4] configs: enable UNIT_TEST on qemu_arm_defconfig
Date: Sun,  3 Nov 2024 23:42:23 +0100
Message-ID: <20241103224223.195255-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
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

The lib_test_uuid_to_le test fails on 32-bit systems. But we never caught
this in our CI because we never ran any of our C unit tests on 32-bit.

Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 configs/qemu_arm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index d042aea49bb..cc4f4540fd5 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -67,3 +67,4 @@ CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_TPM=y
+CONFIG_UNIT_TEST=y
-- 
2.45.2

