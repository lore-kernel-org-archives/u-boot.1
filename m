Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3E5C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD49588236;
	Sat, 13 Apr 2024 20:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="R8QpuM3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EC248821A; Sat, 13 Apr 2024 20:15:44 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B9D88221
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032125; bh=gYlkv3jBYhLqIkFxtHaH0C++zR5XvNOPIX5Xqi22TBI=;
 b=R8QpuM3Ljb1SOl5q4j4xG+2p6yR5G07sBq8DPmj44PRWoEG4JhRVihoBvXvCCH9mQmGKAUVKB
 an296o7UvBzC3JrLM0eohNTM9/hiHHeEBTxWcUELh4WkWmhdpboSdtBwB1cEXPqFN5LFe/jHc30
 /cD6wpgutt3c2J1OuOEwZjMW7aW5hRtlalrcWxBorfui6X7mzr7AnU8MYazNzTBR9b1n6fS6MZc
 WZol+TNaHVhnw4H7ZHNPi8nXgeEZsq+4cn6NfErwThWj6ky2R+JZ9mPiyfy34OZLGBEFQJV2iVA
 1uASqnCSZS23mTpBbGnbEgbj2xvN53CxVspx3KAN7oDQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 13/23] rockchip: rk3566-pinetab2: Fix reading FIT from SPI
 flash
Date: Sat, 13 Apr 2024 18:13:47 +0000
Message-ID: <20240413181425.1384357-14-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 661acbbb6fbb975d49a654ab
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

