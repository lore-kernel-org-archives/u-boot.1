Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B01DC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 07:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB3187C10;
	Wed, 24 Jan 2024 08:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OBRsviUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE22687BF0; Wed, 24 Jan 2024 08:55:08 +0100 (CET)
Received: from mail-m12828.netease.com (mail-m12828.netease.com
 [103.209.128.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCF387C09
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 08:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=OBRsviUkLaWXh/1Cqk0lV0quUM8OmDI2fDz+F9y2k1uFv3qZDxNQB5CXWuUUVHyRUBqoJdyHFTWXpnfyX0NhIYoa57W29D/JTssWk8TZtAaEdbJkzeVMIGY9bG4QkIG4Jmb19FrdpcMf4sikTfbR59ipA5EoAUMUkiO7aAsmUsY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=89u11Ky7ks2FMRZDZEPJk4B+v6MdY55Z+9pA0CnOEHM=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 0178D400455;
 Wed, 24 Jan 2024 15:54:52 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Andre Przywara <andre.przywara@arm.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] spl: Make SPL_STACK available for ROCKCHIP_RK3036 without
 spl framework
Date: Wed, 24 Jan 2024 15:54:50 +0800
Message-Id: <20240124075451.818448-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtPTlYYSkMdTxkeSxhPSEtVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d3a76fd8f2eb3kusn0178d400455
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6ERw6FjwhDAFPAhM0DR4c
 KC0wCTxVSlVKTEtNS0NJQ0JITE9KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSk1DNwY+
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

rk3036 soc has limit internal sram, and not able to support spl
framework.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 common/spl/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index e7b84fc1fa6..9deee0fdbea 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -372,7 +372,8 @@ config SPL_SHARES_INIT_SP_ADDR
 
 config SPL_STACK
 	hex "Initial stack pointer location"
-	depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && SPL_FRAMEWORK
+	depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && \
+		SPL_FRAMEWORK || ROCKCHIP_RK3036
 	depends on !SPL_SHARES_INIT_SP_ADDR
 	default 0x946bb8 if ARCH_MX7
 	default 0x93ffb8 if ARCH_MX6 && MX6_OCRAM_256KB
-- 
2.25.1

