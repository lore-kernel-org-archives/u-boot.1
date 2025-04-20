Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A18BC369D2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 09:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C18708210D;
	Sun, 20 Apr 2025 10:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cpuV0tR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04AD082114; Sun, 20 Apr 2025 10:59:57 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E907D8209F
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 10:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-177.46.114.pool.telefonica.de
 [46.114.111.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1287340443; 
 Sun, 20 Apr 2025 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745139593;
 bh=J6HlSC2XirqvVY/W4bEfut+sgbdwPQaLbg79wc+i+Oc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cpuV0tR3hkR0U5i8YoiYUzZK+TG2AVwW0piphIvfPBFZZoUZCH0v7SKAKKJD5iqHj
 C2Zl4+gSC1SDpoy0MEGc3iLBQyMQOkJHZrVRXP3Rci7SfyQlXChuAdViLojrd1Yguf
 IoYXD5sGJkxKAiiouq9wCaWhlFnrxqMmdHjVXKDVU4iD+hqN9utp7D7gi0GDShf7U/
 FhkMk1pwUNKF8Pfyfm8v4AE/t5gCkkC2BTeWoRn/grasV3KGsGCZzUS1wX5jrVz20w
 kGUZQgcBkZ6FTm8EUeZNFW3RqMU3Fr/wTASfM4t3Hh4q4c0mYX7e2iQMBECf/SY7b8
 FcXSOYCeOVwmg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/4] MAINTAINERS: add all qemu_arm64* defconfigs to VIRT
Date: Sun, 20 Apr 2025 10:59:27 +0200
Message-ID: <20250420085929.36226-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250420085929.36226-1-heinrich.schuchardt@canonical.com>
References: <20250420085929.36226-1-heinrich.schuchardt@canonical.com>
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

Add the following boards to VIRT which otherwise would be unmaintained.

* qemu_arm64_acpi_defconfig
* qemu_arm64_lwip_defconfig

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-arm/MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index 7bc0ee698c5..538769f8040 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -5,6 +5,5 @@ F:	board/emulation/qemu-arm/
 F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
-F:	configs/qemu_arm_defconfig
-F:	configs/qemu_arm64_defconfig
+F:	configs/qemu_arm*
 F:	configs/qemu-arm-sbsa_defconfig
-- 
2.48.1

