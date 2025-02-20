Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7D5C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729E480F9C;
	Thu, 20 Feb 2025 22:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FC3lsEel";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE4380F5F; Thu, 20 Feb 2025 22:58:56 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 822098006D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 22:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bb8a=VM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1740088733; bh=ggC2sHfR03gMafAOogFzkTIEHwpV392dNlLfG5n5ozM=;
 b=FC3lsEelm+F4Y/PtbePTIlQS2hA54ucwp1mx/BXgWpK3Dc1vI7yAybVw5w44P1Ey6+1ftauaW
 ce0gi3KH0Rli6ojL9nEEpW0y/lPHFI4t7GswG4p+XBddwHnzWtgQ82RbqEmjf6kS+2ClXVcUMde
 hHb/WCvJE87YyZj4/EX4QO7AW+pl5mKo8G6TJW7NQ1BqnJGXtSp+BEgxlnZ2GOY2QZRP5HnHK4a
 KVua9+NFhIhfhS/qXZ9n1nBwtjuI9k5MHadgWJpDMonOOpyolzn4DSU78Q6v+4ePuVWE73H4wHs
 JF/IM9T1RnCHsWfuCZNqlDwJPG8u491fUtlgnG+tgv4w==
X-Forward-Email-ID: 67b7a59a63718a8557eae114
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.56
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/6] rockchip: Make ROCKCHIP_COMMON_STACK_ADDR depend on TPL
Date: Thu, 20 Feb 2025 21:56:56 +0000
Message-ID: <20250220215709.407413-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220215709.407413-1-jonas@kwiboo.se>
References: <20250220215709.407413-1-jonas@kwiboo.se>
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

The stack-pointer addresses used with ROCKCHIP_COMMON_STACK_ADDR expect
that DRAM is initialized by TPL or ROCKCHIP_EXTERNAL_TPL, that SPL has
access to full DRAM and SPL is loaded to/executed from start of DRAM.

Add depends on to ensure use of the ROCKCHIP_COMMON_STACK_ADDR symbol
does not cause problem for any board not using TPL and back-to-BROM
loading of SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index bb5d009a1c34..a44fdddd46ab 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -605,6 +605,7 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 config ROCKCHIP_COMMON_STACK_ADDR
 	bool
 	depends on SPL_SHARES_INIT_SP_ADDR
+	depends on TPL || ROCKCHIP_EXTERNAL_TPL
 	select HAS_CUSTOM_SYS_INIT_SP_ADDR
 	imply SPL_LIBCOMMON_SUPPORT if SPL
 	imply SPL_LIBGENERIC_SUPPORT if SPL
-- 
2.48.1

