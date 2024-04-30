Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308FBC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE7888A3E;
	Tue, 30 Apr 2024 17:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pCCZpvSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D6A88A3E; Tue, 30 Apr 2024 17:32:44 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C953588A41
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491116; bh=O9sNjbMNE8MxaKV2l+8PSRjdtFbvEwzTH5IV5YVIYkU=;
 b=pCCZpvSH1rILXlBFyXP8adZ+0FeMokIqgWt0pQHe3NrIpE6pA+0fiau04mE+hdHJT58sMyqCI
 oSTOc2+24+yhwnwM4ywNEsvCZJlIZkqho2boIva6YzucXYg9lY09w3CjXp9DJhfNtRi+sm0wl0w
 7m874n5dSsWg9FqJ2XecvPcfKOmNtX+PnGFsqCaZjf3OeDltHQlvX0Q/EJkIYkuXBN4Y/eM6IeU
 gs+SK3HYZx4y7bb2ypRSE7uPdZRahEkUNMFb3UaVodr8JMW/TpkzIjZUNSoD2CHCurbxrMV7nL+
 N45VrBGKIMTx6jKzzmn0igWiXBcbWvkORImiROvpZApQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 10/18] rockchip: rk3399: Remove use of xPL_MISC_DRIVERS
 options
Date: Tue, 30 Apr 2024 15:30:17 +0000
Message-ID: <20240430153053.308788-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310ee1d99e42224315b891
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

The TPL and/or SPL control FDT on RK3399 boards does not contain any
node with a compatible that is supported by driver/misc/ drivers.

Remove use of xPL_MISC_DRIVERS options to stop including e.g an unused
efuse driver in TPL and/or SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tags
---
 arch/arm/mach-rockchip/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index bfde9bf8dd16..7d6374b73586 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -251,7 +251,6 @@ config ROCKCHIP_RK3399
 	select TPL_NEEDS_SEPARATE_STACK if TPL
 	select SPL_SEPARATE_BSS
 	select SPL_SERIAL
-	select SPL_DRIVERS_MISC
 	select CLK
 	select FIT
 	select PINCTRL
@@ -283,7 +282,6 @@ config ROCKCHIP_RK3399
 	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
 	imply TPL_CLK
 	imply TPL_DM
-	imply TPL_DRIVERS_MISC
 	imply TPL_LIBCOMMON_SUPPORT
 	imply TPL_LIBGENERIC_SUPPORT
 	imply TPL_OF_CONTROL
-- 
2.43.2

