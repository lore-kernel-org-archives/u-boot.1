Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE0EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E6B88380;
	Mon, 22 Apr 2024 08:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ztlE2S8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFB38839C; Mon, 22 Apr 2024 08:30:52 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF4388380
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767439; bh=l8gWcmDBIslwhOtCX/n7Jon2a+hb8GQS5rkbWJrsGDk=;
 b=ztlE2S8vep9FgnFxkgjTNgqyudzhI1pUEH0XeJGbQTXse4/7iKeUA0gYBS7zYAP+fQU5C6Vdg
 jVUKPNucAUZAIlOJO4yKtCV4HKKk0ZjhSA9wwEnwAbCV8+1GktRN4hXZ2e4Ugo3VW+RSo2cRx7C
 rGiBZ4WMKLcrVt1JHXY46fWBANTOyRagTOf57mDUgF1JUoVGpsZktla5v1ovdeoJ0nxDhIRF8sl
 tvFZztqMgd7LT8VNj/0VkqIo3EhXVl4OsgcI7kL53CHEITMtTyKUovP6XgWiVKrNjp9kUPUO2DO
 9v9jHQvuKg6cREfGOgDf/MK2M2Sm9U5IZI04uCywrZUg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 16/28] rockchip: rk3566-pinetab2: Fix reading FIT from SPI
 flash
Date: Mon, 22 Apr 2024 06:28:53 +0000
Message-ID: <20240422062936.681359-17-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6626040e34ba165ad44743bd
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

The SF_DEFAULT_SPEED Kconfig option got lost during merge and this
prevent reading FIT from SPI flash.

Restore the SF_DEFAULT_SPEED option to fix this.

Fixes: 8a94c376f6cb ("rockchip: Use common bss and stack addresses on RK356x")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: No change
v2: No change
---
 configs/pinetab2-rk3566_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index edeb1d89b993..525a002a21b8 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -4,6 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="rk3566-pinetab2-v2.0"
 CONFIG_ROCKCHIP_RK3568=y
-- 
2.43.2

