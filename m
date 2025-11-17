Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B2BCEBF61
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 10:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C22583B8F;
	Mon, 17 Nov 2025 11:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NwXRjNMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0B9D83B2C; Mon, 17 Nov 2025 11:33:29 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E414983B72
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 11:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C6770601DF;
 Mon, 17 Nov 2025 10:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949B5C4CEFB;
 Mon, 17 Nov 2025 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763375606;
 bh=Abd04EuXaDCXFdJ68KrLw9fSnfVmClS+4vsXXUkX558=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NwXRjNMoPNMXFUlCEFxsR3NXKDwkcZ9pCj9Jj2/xhFOgKNcgbPQGRZhOjT/TUWCKO
 6aVrNxT00OVL7ItrY3apqihMNmacnnwp0SlCkC3thqeheI3WgH3OV5UziNJMFhJQ24
 8LLbh8TdkL+xvcU47kg+i2sG8YNhnUUJn2t302KGJNxijQX41XrUKI569o2wmty7XK
 wIUUkPgheQAE+zHrITAZxpo6OnFpnaA+kFa9lpPzU21KYI3oia+3Sk9CXfoXEftj31
 t21cMvOkAEFy5Apk3i1Y6keMATrz+UpMNhW/C4+3/VPG2R4fgmw2qIGGIDiDv/YZdG
 F6EN0j8h9Yoxg==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 1/3] drivers: rtc: convert tristate to bool
Date: Mon, 17 Nov 2025 11:32:50 +0100
Message-ID: <20251117103315.2212686-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117103315.2212686-1-mwalle@kernel.org>
References: <20251117103315.2212686-1-mwalle@kernel.org>
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

As u-boot doesn't have any loadable modules, tristate doesn't make
sense. Convert it to bool.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index ed903999f06..202daa7bcd6 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -162,7 +162,7 @@ config RTC_MAX313XX
 	  - CLKOUT generation
 
 config RTC_PCF8563
-	tristate "Philips PCF8563"
+	bool "Philips PCF8563"
 	help
 	  If you say yes here you get support for the Philips PCF8563 RTC
 	  and compatible chips.
-- 
2.47.3

