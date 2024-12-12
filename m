Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79829E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908A38022E;
	Fri, 13 Dec 2024 00:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="n2L4Msh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 048328022E; Fri, 13 Dec 2024 00:58:23 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E1D58022B
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047895; bh=EkAixVurhvb0r9VKMuPWimQBRkpvKoul/St10ke9z7M=;
 b=n2L4Msh3ib5FFCrSvDDSdijZcyKZXyb57pdIj7fEvOA7KCBXBgvYvmzC3Ef7XYspeeyxhG7Bu
 qFzvL/LAfqrraVKlpdtvN/gZg/9+lEKtQQ1oILLwcS7DkvZvHV5OdTYQkfgWGNpZAWQvHGSwp8u
 VaWIzwkrEHmClfilXsdnttEQ3diNfmUPCaj5YNcHygg4NiBhpnjqbE0EgWhDCvUEsF1BXqQ9H+o
 RyYTu7G0srOHMrMxhpmir3C6Hi+zlO0mIIeYL7CfyesZS3zk9sHEm+L3FgP9VaLQVnpuaiyhhGs
 rN9oQBIOaHV0p3RX7BJlNOM7oLcrRlzc4q+4GgwjHUBg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 07/12] rockchip: rk3399: Drop common Kconfig options already
 implied
Date: Thu, 12 Dec 2024 23:57:14 +0000
Message-ID: <20241212235735.164272-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212235735.164272-1-jonas@kwiboo.se>
References: <20241212235735.164272-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b7893a511ed8f0b3fe2e6
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

The last two RK3399 boards, chromebook bob and kevin, have now migraded
to use common bss and stack addresses.

Cleanup and remove Kconfig options no longer needed in rk3399/Kconfig
when all boards now use common bss and stack addresses.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3399/Kconfig | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index 04a84e2f6a04..500cfcd87afd 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -146,15 +146,6 @@ config SYS_SOC
 config ROCKCHIP_COMMON_STACK_ADDR
 	default y
 
-config SYS_MALLOC_F_LEN
-	default 0x4000 if !SPL_SHARES_INIT_SP_ADDR
-
-config SPL_LIBCOMMON_SUPPORT
-	default y
-
-config SPL_LIBGENERIC_SUPPORT
-	default y
-
 config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
 
@@ -164,9 +155,6 @@ config TPL_STACK
 config TPL_TEXT_BASE
         default 0xff8c2000
 
-config SPL_STACK_R_ADDR
-	default 0x04000000 if !SPL_SHARES_INIT_SP_ADDR
-
 if BOOTCOUNT_LIMIT
 
 config BOOTCOUNT_BOOTLIMIT
-- 
2.47.1

