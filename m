Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCF0CD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A7AA87F8E;
	Sun, 31 Mar 2024 22:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lzivjuBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D7A87FE3; Sun, 31 Mar 2024 22:30:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF88E882AA
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917005; bh=CdOXD66CnN/25gA27nIBkj/fbEsFHlFk76nskFEXvVY=;
 b=lzivjuBk3GzI19W8/Cm1G3fF1cVL8JlQUkynpdF5DlhA44WyIqAQGtahfx/A3E7wKlLupZnDh
 7YBPH3Mwi4uv/TKQVNb1BAoKMdvkRQiTtJw2LO9daTvfFb6M1UuGyMDtx0MwaZDEKSgBaO2fCrz
 cgNZ+5Y8OxxvR1QGaWeyDdDIT/CRLoXkEHKQOqOvP/DpL2mZxbquHLS+xRXs4AaowmPqtq3pRdT
 By91Qb5PZtEG4vS4xwlzlBSVjn9iaAr7z+p0I8UiL0y7mdY1/ElhChVTPWm0523aCGsAYdunt1i
 mk1pRHNQViMkKwjMl3UPbdzKdqz8KOOI132pWcCZKhkQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 08/31] rockchip: rk3399: Remove use of xPL_MISC_DRIVERS options
Date: Sun, 31 Mar 2024 20:28:14 +0000
Message-ID: <20240331202921.262323-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7cb8fc6b45ed44f72de
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
---
 arch/arm/mach-rockchip/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 8dca9d2853b4..bc03d69a7f5c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -250,7 +250,6 @@ config ROCKCHIP_RK3399
 	select TPL_NEEDS_SEPARATE_STACK if TPL
 	select SPL_SEPARATE_BSS
 	select SPL_SERIAL
-	select SPL_DRIVERS_MISC
 	select CLK
 	select FIT
 	select PINCTRL
@@ -282,7 +281,6 @@ config ROCKCHIP_RK3399
 	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
 	imply TPL_CLK
 	imply TPL_DM
-	imply TPL_DRIVERS_MISC
 	imply TPL_LIBCOMMON_SUPPORT
 	imply TPL_LIBGENERIC_SUPPORT
 	imply TPL_OF_CONTROL
-- 
2.43.2

