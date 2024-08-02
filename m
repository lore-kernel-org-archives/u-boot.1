Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74949C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 23:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1E888B22;
	Sat,  3 Aug 2024 01:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OjBbrXYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B599F88C39; Sat,  3 Aug 2024 01:49:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C61C889B4
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 01:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722642537;
 bh=iU41DZ42FNYa47tTT0LDEkQLp64ndZ4LLbSMrD5dfZE=;
 b=OjBbrXYz+PKHpp2t1kMTXnF5AXuBKauyfQyHZbswPuW/WbcjG+OvducYB/50CtECOypuuIi9m
 qXI4U43KZyKp2jtyGdHVMf5Q1tpRsoT+RJIIMQn4pJML7J32ZDiy//idTAfJa8zTSAmjhXJ5q9C
 uFJ4bhOa8xlVtYtfLCOgud6cWWUro6j+qV0j947stbwQDgSn/Ef3G0DFyxgq955+gta6jvz6HVC
 mZczBmvnZk5dQ7Sd3gO7r+xJGXpWfpWfDdLsNd8Fsfk7mkIKU/iEePkhDrUAXaZZUYqA8Hxu32L
 83ZE2033QRzd0l0TVh7Zl/JyyTqwJAHiPEbCJf4iJvOQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tianling Shen
 <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Tom Rini
 <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3568-nanopi-r5: Disable SPL_DM_WARN Kconfig option
Date: Fri,  2 Aug 2024 23:48:44 +0000
Message-ID: <20240802234846.2654274-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66ad706616ac7a56c917bbc3
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

With the commit 6afdb1585112 ("dm: core: migrate debug() messages to use
dm_warn") use of DM_WARN/SPL_DM_WARN print a lot of debug messages.

Disable the SPL_DM_WARN Kconfig option to remove verbose logging and
restore normal serial console output during boot.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/nanopi-r5c-rk3568_defconfig | 1 -
 configs/nanopi-r5s-rk3568_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
index 4a6c320faf5c..8e30093ed9dc 100644
--- a/configs/nanopi-r5c-rk3568_defconfig
+++ b/configs/nanopi-r5c-rk3568_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SPL_DM_WARN=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index 7ab12e619acf..e1865b2e1714 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_SPL_DM_WARN=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
-- 
2.45.2

