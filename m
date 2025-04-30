Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA588C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 07:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF92829E7;
	Wed, 30 Apr 2025 09:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WDfy4abW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A7582AFD; Wed, 30 Apr 2025 09:34:14 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6640C8216C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 09:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-108-068.46.114.pool.telefonica.de
 [46.114.108.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 31D953FA6F; 
 Wed, 30 Apr 2025 07:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745998450;
 bh=ecscS4XiXjPZ/dpsyu4wfBvhOR72oiUIwhi6v7vammI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=WDfy4abWmxqtzrSAug9k7m8A0ZTtROuhqpO2OuqteXnGEK5Gh1zIkeIKnf+JLPJIy
 qAmP0NKOjNqS2f5M/3XsfaXfAxdhChueN4ew093ktF+ihVnBRcOlBJyIyFzbwCsrko
 oBUU9RgJ7KUYIxJKHYgLYdJmsAqef3mMXgfzMfx0jxVhVetn5vt4500g2PEHxInF3D
 vf2EON8A3wD0uXvmt78TXzH3iAAxmDZZMOkUc34lOIeCLc51+2JG1LNiydZsaCMwJQ
 B4fx4xDQBVVGW1XVXN1+5Xx5G1HqSajjy+ulT2TeZ8U+7zdqXJ60+E03gkVyquDvD1
 hxTrVO4XaGaOg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: let BOOTSTAGE_RECORD_COUNT default to 50
Date: Wed, 30 Apr 2025 09:34:05 +0200
Message-ID: <20250430073405.14396-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

BOOTSTAGE_RECORD_COUNT=30 is too small to record booting a FIT image
with EFI kernel, initrd, dtb as seen on the StarFive VisionFive 2
board.

Increase the default for BOOTSTAGE_RECORD_COUNT to 50.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index fb37d912bc9..2456856a572 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1170,7 +1170,7 @@ config BOOTSTAGE_REPORT
 config BOOTSTAGE_RECORD_COUNT
 	int "Number of boot stage records to store"
 	depends on BOOTSTAGE
-	default 30
+	default 50
 	help
 	  This is the size of the bootstage record list and is the maximum
 	  number of bootstage records that can be recorded.
-- 
2.48.1

