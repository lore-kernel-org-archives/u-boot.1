Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB914C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 10:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04E787083;
	Sun, 12 Nov 2023 11:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QmXTq7ie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2ED86EF1; Sun, 12 Nov 2023 11:27:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6000186EE0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 11:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=face=GZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1699784860; bh=aTUOMLo9rmbcZ42/7wxwRLPG8YyN6GXvOW9rE+VyEyg=;
 b=QmXTq7ieK8NC/5ft1zRwlz2mrzql42pp+/kdLq8m+pQG2cSPIs2n9QceWGCUeSJZc9PRNKzPW
 +C2RiLli18k9F0Er4kYtK8emqPq8xdsXC+4LFjhW/CdAbfDSz7n0M3eBOlvTFFCMmkBlhcD5Je0
 6OJ8vTavu4Y0zRphhhnSyEaol7QdxGCevIlkb2+9FYd4VvgKtasYDuCc5LbuJ1ah5IaIHCoXg8h
 tpo7YTL1DdHIfGpNYY/Ja70Elg4JxIy9Tz0cpcL0dpTYuIMcBwBpEiPNwGolbBA8IAYfnY/p1Kh
 zW2oIUoCth3djUajsbyVaGTBMP91cpCuMvfXw0pXGoDQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: John Clark <inindev@gmail.com>, Slawomir Stepien <sst@poczta.fm>,
 u-boot@lists.denx.de
Subject: [PATCH 1/4] rockchip: rk3588: Fix boot from SPI flash
Date: Sun, 12 Nov 2023 10:26:57 +0000
Message-ID: <20231112102705.1180714-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112102705.1180714-1-jonas@kwiboo.se>
References: <20231112102705.1180714-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6550a89c120265b21fb31b94
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

The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI
NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value 6.

At the time the reason for this new bootsource id value 6 was unknown.

We now know that the BootRom on RK3588 use different bootsource id
values depending on the iomux used by the flash spi controller, and not
by the type of spi nor or spi nand flash used.

Add the following defines and use them for RK3588 boot_devices.

- BROM_BOOTSOURCE_FSPI_M0 = 3
- BROM_BOOTSOURCE_FSPI_M1 = 4
- BROM_BOOTSOURCE_FSPI_M2 = 6

Fixes: fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI NOR flash")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/bootrom.h | 4 +++-
 arch/arm/mach-rockchip/rk3588/rk3588.c       | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
index 7dab18fbc3fb..f78337397d63 100644
--- a/arch/arm/include/asm/arch-rockchip/bootrom.h
+++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
@@ -47,8 +47,10 @@ enum {
 	BROM_BOOTSOURCE_EMMC = 2,
 	BROM_BOOTSOURCE_SPINOR = 3,
 	BROM_BOOTSOURCE_SPINAND = 4,
+	BROM_BOOTSOURCE_FSPI_M0 = 3,
+	BROM_BOOTSOURCE_FSPI_M1 = 4,
+	BROM_BOOTSOURCE_FSPI_M2 = 6,
 	BROM_BOOTSOURCE_SD = 5,
-	BROM_BOOTSOURCE_SPINOR_RK3588 = 6,
 	BROM_BOOTSOURCE_USB = 10,
 	BROM_LAST_BOOTSOURCE = BROM_BOOTSOURCE_USB
 };
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index b1f535fad505..322164e9b307 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -39,9 +39,10 @@ DECLARE_GLOBAL_DATA_PTR;
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe2e0000",
-	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
+	[BROM_BOOTSOURCE_FSPI_M0] = "/spi@fe2b0000/flash@0",
+	[BROM_BOOTSOURCE_FSPI_M1] = "/spi@fe2b0000/flash@0",
+	[BROM_BOOTSOURCE_FSPI_M2] = "/spi@fe2b0000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
-	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
 };
 
 static struct mm_region rk3588_mem_map[] = {
-- 
2.42.0

