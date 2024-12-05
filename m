Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A701BE7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 20:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDE128922D;
	Thu,  5 Dec 2024 21:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HS3dKWFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C028952B; Thu,  5 Dec 2024 21:30:41 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECBE8903C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 21:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-009.46.114.pool.telefonica.de
 [46.114.111.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 72E643F0C6; 
 Thu,  5 Dec 2024 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733430637;
 bh=lOBKkI2XpLjPRAHzP3J7VBxx0ZxezjicccKE4v8tOfA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HS3dKWFfczYv0dae1o+Zm3PtkqcpCoAL+uz81lh8B+2IcHp1txFauqy1kfj/Bo/Xd
 BO3g3VMgukmxBNe1Til4iLUYXi4fs5/PFLsDUdXYOHqBwIIJ7kbmskzMY6VZZkKOmM
 aTME4HRgevGcMpu6BvvVD2+FxNM9c4/Rhudsl+0YPVHkdJ0Lhgu1eXnSH/Jv0Wr2mh
 V1UQ9/G3HqfOQXHr7mGOwqS8vyBwp/+l7ymYbdS/L3BERcWnxrd3lIIDu7IF7ELgBs
 N4WOROO3oGHlNMCif1EAtPe3K/4bXTkyHV2at06c21q16ikFNK4i3L4UP7Hd+MbaLj
 VmXsJVCx0fDKg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] rtc: CONFIGS_RTC_PL031 must depend on CONFIGS_DM_RTC
Date: Thu,  5 Dec 2024 21:30:33 +0100
Message-ID: <20241205203033.42915-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Building qemu_arm64_defconfig with CONFIGS_DM_RTC=n and CONFIGS_RTC_PL031=y
leads to a build failure.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 7fc53a6d61e..9c2d1398247 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -203,6 +203,7 @@ config RTC_RX8025
 
 config RTC_PL031
 	bool "Enable ARM AMBA PL031 RTC driver"
+	depends on DM_RTC
 	help
 	  The ARM PrimeCell Real Time Clock (PL031) is an optional SoC
 	  peripheral based on the Advanced Microcontroller Bus Architecture
-- 
2.45.2

