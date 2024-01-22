Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C743C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 07:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F7387708;
	Mon, 22 Jan 2024 08:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="E7nLxxHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D2A877F4; Mon, 22 Jan 2024 08:47:14 +0100 (CET)
Received: from mail-m12739.qiye.163.com (mail-m12739.qiye.163.com
 [115.236.127.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 840EF876F4
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 08:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=E7nLxxHfulF5OCGIZ9t1Xamnai4HtiNgmQoBBhPcaVqaaL5R8wOHhosYgUjIGjEMQEe7ZO5VuM/W8KFw6FJ+W3nhKfjvRmFTqVYfKqRKWqpu3aAtodh5iVSPoY96tLWxFOryCh5D7FNZQ5zLFdtgdK4/JMBKhvWwsgW0dGC2IC0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=wcYFzRUB8C2X6OWxit4uz23oGMdHgwsb/lqe6fmJiZg=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m12771.qiye.163.com (Hmail) with ESMTPA id 8B1E6B4052B;
 Mon, 22 Jan 2024 15:47:02 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: YouMin Chen <cym@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] rockchip: sdram: fix LPDDR5 bank info for sys_reg version 3
Date: Mon, 22 Jan 2024 15:46:34 +0800
Message-Id: <20240122074633.654726-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5DSlZPGRgeTENOQ0wfS0NVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8d302317e1b247kuuu8b1e6b4052b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006MDo5DDwdIg8JA0sLESIc
 IQkwCU1VSlVKTEtOQktCTUlISEJLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSU9LNwY+
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

From: YouMin Chen <cym@rock-chips.com>

This patch add support for additional bank info used by LPDDR5.

Signed-off-by: YouMin Chen <cym@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm/mach-rockchip/sdram.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 99ecbdc3412..d65c48bf515 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -110,6 +110,13 @@ size_t rockchip_sdram_size(phys_addr_t reg)
 			  SYS_REG_COL_MASK);
 		cs1_col = cs0_col;
 		bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK);
+		/*
+		 * SYS_REG_BK(Version 3):
+		 * 1) Except LPDDR5 0:8bank(bk=3), 1:4bank(bk=2)
+		 * 2) LPDDR5 0:8bank(bk=3), 1:16bank(bk=4)
+		 */
+		if (version == 3 && dram_type == LPDDR5 && bk == 2)
+			bk = 4;
 		if (version >= 2) {
 			cs1_col = 9 + (sys_reg3 >> SYS_REG_CS1_COL_SHIFT(ch) &
 				  SYS_REG_CS1_COL_MASK);
-- 
2.25.1

