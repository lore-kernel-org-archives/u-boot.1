Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B89CC4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F09F88059;
	Sat, 13 Apr 2024 20:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FqcyzY2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63B9288096; Sat, 13 Apr 2024 20:15:24 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66FE880A3
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032095; bh=sKhlyGnmdKnWaN//FdAEvxTZFcg5tXE9DGcS7/y4HmM=;
 b=FqcyzY2lB1sl4Zy/arHKRbnYiQumEPtD4rgykgeiLewcP/DJlMqYa+dI/Bs4HQN3uo0OYImXp
 5sUwvuyKwS2Q6JqKZftEbNPOXPavBs1A5LzlrV5JFnGwf4/I9OqdBsxdocZ5q2NgSCya605IPOq
 T/cOcfHhwr/OcHn9QpaQiG7AWdNFo5Ywt0Ij6JEr50WKVrJfPlmxAlBV15BOHFJE3k/ztose2IN
 NgQ6jGXz+H5yFCb3kn/uEaXHrazCv2LMVPNOaZMs6vabDnYkIugOh4Vz9BFJ+0sutp4QEL0PZRj
 eNTvBFBtum0hCtRerAEiyKddQjPQH0p2QlFYZHvrsrtA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Chris Morgan <macromorgan@hotmail.com>, Tom Rini <trini@konsulko.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 05/23] rockchip: rk3566-anbernic-rgxx3: Remove
 SPL_ROCKCHIP_BACK_TO_BROM option
Date: Sat, 13 Apr 2024 18:13:39 +0000
Message-ID: <20240413181425.1384357-6-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 661acb9d6fbb975d49a65411
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

SPL_ROCKCHIP_BACK_TO_BROM should normally only be enabled when BROM
should load U-Boot binary. SPL on Anbernic RGxx3 devices load TF-A and
U-Boot proper from FIT images and does never jump back to BROM from SPL.

Remove the superfluous Kconfig option from defconfig to align with other
RK356x boards.

This patch have no intended change in boot behavior.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 configs/anbernic-rgxx3-rk3566_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index c8c9238f96fc..24b050c59b53 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -6,9 +6,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="rk3566-anbernic-rgxx3"
 CONFIG_ROCKCHIP_RK3568=y
-CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
-CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_ANBERNIC_RGXX3_RK3566=y
 CONFIG_DEBUG_UART_BASE=0xFE660000
-- 
2.43.2

