Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD94C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D32087B77;
	Thu, 26 Oct 2023 14:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07BBF87B66; Thu, 26 Oct 2023 14:51:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 22B8887614
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C6FE2F4;
 Thu, 26 Oct 2023 05:51:49 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.2.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 347D93F64C;
 Thu, 26 Oct 2023 05:51:06 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: nd@arm.com, trini@konsulko.com, Emekcan Aras <emekcan.aras@arm.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: [PATCH 3/3] corstone1000: enable PSCI reset
Date: Thu, 26 Oct 2023 13:50:51 +0100
Message-Id: <20231026125051.321493-4-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026125051.321493-1-abdellatif.elkhlifi@arm.com>
References: <20231026125051.321493-1-abdellatif.elkhlifi@arm.com>
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

From: Emekcan Aras <emekcan.aras@arm.com>

enable PSCI reset used for the system reset

Even though Corstone-1000 does not implement the entire PSCI APIs,
it relies on PSCI reset interface for the system reset.

Signed-off-by: Emekcan Aras <emekcan.aras@arm.com>
Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
---
 configs/corstone1000_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index f25da79ec8..f8c48972cc 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -1330,7 +1330,7 @@ CONFIG_PL01X_SERIAL=y
 #
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_RESET=y
-# CONFIG_SYSRESET_PSCI is not set
+CONFIG_SYSRESET_PSCI=y
 # CONFIG_SYSRESET_SYSCON is not set
 # CONFIG_SYSRESET_WATCHDOG is not set
 # CONFIG_SYSRESET_RESETCTL is not set
-- 
2.25.1

