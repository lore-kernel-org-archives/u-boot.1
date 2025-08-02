Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79649C87FD2
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 22:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E338F83C91;
	Sun,  3 Aug 2025 00:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="I2C9rADy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80C483C91; Sun,  3 Aug 2025 00:08:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC9183C72
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 00:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7e69=2P=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754172476; bh=iwhpemcsDGBzvaImDzPQbZp6I1Ye9YuYB7cBvmeOmrM=;
 b=I2C9rADyM9NNsx4G/rV4RHRzCGuCcBBtZ6tl3CGtO3VUP49+d/R9A5bSS7ii7XLaN+7+3ftyj
 oC4CltPJwyz6+MIKZIp0gThwLn16HZUwEN3ONBsj5EGOGZEckz7rB2gt9SNwpgrBlhsv8S8SgJC
 OHd/lKnCD5XnAebtf76AxxJ3sxzxFd9Nqiwm+EBxi8kYPLiyKDrIdm6XepR/KO5/EVMHCKtbVuo
 ArnqvRYaIw6FRPfgKn3bQxGOeXrCXNqj1sJuml1YDPQSJFWVi1J6pxOC1U/1iyGLFRulI74lnWC
 lepHe8ECKWWtPRZT9W7bSA5/z2+GNOKvFYxRezfdAWvw==
X-Forward-Email-ID: 688e8c39056e3a070faf3572
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Arnaud Patard <arnaud.patard@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 1/4] rockchip: Move TEXT_BASE to 8 MiB offset from start of
 DRAM
Date: Sat,  2 Aug 2025 22:07:22 +0000
Message-ID: <20250802220738.3018910-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802220738.3018910-1-jonas@kwiboo.se>
References: <20250802220738.3018910-1-jonas@kwiboo.se>
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

Drop SoC specific TEXT_BASE and use a common TEXT_BASE for all SoCs.

Move the common TEXT_BASE to 8 MiB offset from start of DRAM to help
support RAM boot from maskrom introduced in next patch.

RAM boot from maskrom mode will expect the FIT payload to be located at
2 MiB offset from start or DRAM.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Arnaud Patard <arnaud.patard@collabora.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v3: Collect r-b tag
v2: Collect t-b tag
---
 arch/arm/mach-rockchip/Kconfig        | 6 +++---
 arch/arm/mach-rockchip/rk3308/Kconfig | 3 ---
 arch/arm/mach-rockchip/rk3568/Kconfig | 3 ---
 arch/arm/mach-rockchip/rk3588/Kconfig | 3 ---
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 342933ca5099..c9ce30760292 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -768,9 +768,9 @@ config TPL_SYS_MALLOC_F_LEN
 	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config TEXT_BASE
-	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
-	default 0x40200000 if SPL_TEXT_BASE = 0x40000000
-	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
+	default 0x60800000 if SPL_TEXT_BASE = 0x60000000
+	default 0x40800000 if SPL_TEXT_BASE = 0x40000000
+	default 0x00800000 if SPL_TEXT_BASE = 0x00000000
 
 config SPL_TEXT_BASE
 	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
index 06572d545f6e..b8d25c525424 100644
--- a/arch/arm/mach-rockchip/rk3308/Kconfig
+++ b/arch/arm/mach-rockchip/rk3308/Kconfig
@@ -17,9 +17,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3308"
 
-config TEXT_BASE
-	default 0x00600000
-
 source "board/rockchip/evb_rk3308/Kconfig"
 source "board/firefly/firefly-rk3308/Kconfig"
 
diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index 01b53a47ddbe..2730220a18e8 100644
--- a/arch/arm/mach-rockchip/rk3568/Kconfig
+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
@@ -70,9 +70,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3568"
 
-config TEXT_BASE
-	default 0x00a00000
-
 source "board/rockchip/evb_rk3568/Kconfig"
 source "board/anbernic/rgxx3_rk3566/Kconfig"
 source "board/hardkernel/odroid_m1/Kconfig"
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 4e7942ada875..dfc19c4fc8fa 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -400,9 +400,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3588"
 
-config TEXT_BASE
-	default 0x00a00000
-
 source "board/armsom/sige7-rk3588/Kconfig"
 source "board/coolpi/genbook_cm5_rk3588/Kconfig"
 source "board/edgeble/neural-compute-module-6/Kconfig"
-- 
2.50.1

