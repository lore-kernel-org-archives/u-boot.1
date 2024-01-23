Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213D4C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 03:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F378798F;
	Tue, 23 Jan 2024 04:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Gx2UT007";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFFC87B4D; Tue, 23 Jan 2024 04:10:32 +0100 (CET)
Received: from mail-m49223.qiye.163.com (mail-m49223.qiye.163.com
 [45.254.49.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6000E8793F
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 04:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Gx2UT007HhTTc8NHCPo7fVcS1Z2YU8vJUZiNiKUw3l/FdFLOkB7dnNM+8pXiaMFS8GUJY1g+NANVjDHORPpnFEjQsiyRIPTD8hz1n4bKciojxiNVu1fP01HJYiBLca/FL7lFv8ytw0Zd4yrPoyrbMO1OQGY0EFpGeiDow7ueeeA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=VPkvfYdpcaPHEcXUtG4rLZ7z9vX7m6TnKc9n5nD6c10=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11874.qiye.163.com (Hmail) with ESMTPA id E6B7A3C0271;
 Tue, 23 Jan 2024 11:10:03 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: YouMin Chen <cym@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] rockchip: sdram: fix LPDDR5 bank info for sys_reg version 3
Date: Tue, 23 Jan 2024 11:10:02 +0800
Message-Id: <20240123031003.758658-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8dSlZIGkxDTEhLSkIdGkxVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8d344bdf632eb0kusne6b7a3c0271
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mjo6Dyo6NjwYPg0IEQs6ORZK
 Cj0KFBlVSlVKTEtOQkxCT0tPQ0hLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0pINwY+
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

(no changes since v1)

 arch/arm/mach-rockchip/sdram.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 99ecbdc3412..0d9a0aef6f5 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -109,7 +109,14 @@ size_t rockchip_sdram_size(phys_addr_t reg)
 		cs0_col = 9 + (sys_reg2 >> SYS_REG_COL_SHIFT(ch) &
 			  SYS_REG_COL_MASK);
 		cs1_col = cs0_col;
-		bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK);
+		if (dram_type == LPDDR5)
+			/* LPDDR5: 0:8bank(bk=3), 1:16bank(bk=4) */
+			bk = 3 + ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) &
+			SYS_REG_BK_MASK);
+		else
+			/* Other: 0:8bank(bk=3), 1:4bank(bk=2) */
+			bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) &
+			SYS_REG_BK_MASK);
 		if (version >= 2) {
 			cs1_col = 9 + (sys_reg3 >> SYS_REG_CS1_COL_SHIFT(ch) &
 				  SYS_REG_CS1_COL_MASK);
-- 
2.25.1

