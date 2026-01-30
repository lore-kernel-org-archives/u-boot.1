Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC789D73EBA
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 04:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65EE7841DD;
	Fri, 30 Jan 2026 05:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="KNegQfVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59342841DF; Fri, 30 Jan 2026 05:04:49 +0100 (CET)
Received: from cascadia.aikidev.net (cascadia.aikidev.net [173.255.214.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E478418A
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 05:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vagrant@aikidev.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=debian.org;
 s=1.vagrant.user; t=1769745884;
 bh=GTMHU1RkZMzHq3O/z/Xzz6Up8NFiVAAEbpNPfVOh7ic=;
 h=From:To:Cc:Subject:Date:From;
 b=KNegQfVJCWnGxJkVosfSDQezq5hPXpMC/jH+PVau6OKbmGxdoF+oKkdqV+4miE2Zw
 xQWaqZFXepFUIqXGIIvQ676LYWFTUYu0iL0BS46m44FW6IueEUxLrMgpN/udwTqu29
 tz5Tsip6i2ouEleueP+IfTcYcCkPxJWkbtrn5PMxFOxwPp+eJ5fHirHBHoHeNUINOl
 mOjF07bhnfbO5EKSoY8bOiu0mh5LF/QeI3vhmeDI9rtsTOUzioXLmkmU45kKkuHlZ5
 5nbp8KBac/4VX3sBA3KiSF19VHlth5ICkqw8UJlnv5RcMrianfxlJSYdH5cd/5bqaP
 B5rB16O1vDxxw==
Received: from localhost (unknown [IPv6:2600:3c01:e000:21:7:77:0:50])
 by cascadia.aikidev.net (Postfix) with UTF8SMTPSA id 22C62117;
 Thu, 29 Jan 2026 20:04:44 -0800 (PST)
From: vagrant@debian.org
To: u-boot@lists.denx.de
Cc: vagrant@debian.org, Tom Rini <trini@konsulko.com>,
 Green Wan <green.wan@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH 1/2] env: Provide another work-around for unquoting fdtfile
Date: Thu, 29 Jan 2026 20:04:23 -0800
Message-ID: <20260130040424.472735-1-vagrant@debian.org>
X-Mailer: git-send-email 2.47.3
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

From: Vagrant Cascadian <vagrant@debian.org>

Some boards use CONFIG_DEFAULT_FDT_FILE to specify the value of
fdtfile, althugh the quotes get embedded in the value.

Provide DEFAULT_FDT_FILE with the quotes stripped.

This is a similar work-around to the one provided in commit
d085e692c98d0d7b57cc577ed9befda159cd4a40 for
CONFIG_DEFAULT_DEVICE_TREE.

Signed-off-by: Vagrant Cascadian <vagrant@debian.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 435a4bf372d..75d407a24f5 100644
--- a/Makefile
+++ b/Makefile
@@ -2138,6 +2138,7 @@ quiet_cmd_gen_envp = ENVP    $@
 			-D__ASSEMBLY__ \
 			-D__UBOOT_CONFIG__ \
 			-DDEFAULT_DEVICE_TREE=$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)) \
+			-DDEFAULT_FDT_FILE=$(subst ",,$(CONFIG_DEFAULT_FDT_FILE)) \
 			-I . -I include -I $(srctree)/include \
 			-include linux/kconfig.h -include include/config.h \
 			-I$(srctree)/arch/$(ARCH)/include \
-- 
2.47.3

