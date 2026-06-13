Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBF0CD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 17:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB3B583FEC;
	Sat, 13 Jun 2026 19:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="UBpSfHdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B418466E; Sat, 13 Jun 2026 19:24:55 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA89A801A9
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 19:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
 bh=5wz0f6ZBZ1QwANNKYKfZGJa+fxNC7G7iP4e6u06z6Zs=; b=UBpSfHdVa7sbehU/0KVEhG5KjC
 5bOfvlikXLbwFdIMk29XuriIU+cF7V7X7o0YHOrxz3bSwMx/u3U3Tg0vp0LAjtYpMdsqWWy2VK1Oy
 Xu30FTl41zBmoLMcfgDG0mmXVJyxIKT3yW6INfyT0qdAYQZ0Sg8Izlw1sPbl3wtGerfCb2sKvvzHT
 MX9KE/mshWa1/HSSgrod98GGmfry3s2q3PnacJdE5Kv98og49BaolG6dTSIHRLY5q7cUQyCM0fRvf
 Xe9Ns9ITy86SCbBjcDHVAH0QQXzqug900PJ01NtaC+V7votQAPy9FBqPmRMKq9MiSDM59rlXGy36l
 4kLlyHGA==;
From: Heiko Stuebner <heiko@sntech.de>
To: trini@konsulko.com
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, kever.yang@rock-chips.com,
 heiko@sntech.de, jonas@kwiboo.se
Subject: [PATCH] lmb: Add the Rockchip architecture as requiring DMA below 4G
Date: Sat, 13 Jun 2026 19:24:44 +0200
Message-ID: <20260613172444.4023442-1-heiko@sntech.de>
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

Loading EFI parts like a Debian-Installer on Rockchip SoCs creates
interesting results, in that on some boards the Grub bootloader can't
find any partitions on a USB-Stick, or loading a kernel from Grub spews
    EHCI fail timeout STS_IAA set
messages before failing and on others the loading something like efivars
from an eMMC creates read errors and making the MMC vanish from U-Boot.

This only affected boards with at least 4GB of RAM.

These boards have at least 256MB of memory placed above the actual 4GB
address space (due to the iomem being in between) and while kernel,
initramfs, dt are generally loaded to predefined addresses, additional
EFI parts (efivars, etc) are likely just loaded "somewhere" and it seems
this always landed in that higher up memory part.

Also in the Linux-kernel peripherals like EMMC, USB, etc already run
with a 32bit dma-mask set.

So far, I've seen this on RK3568 and RK3588, but as the same peripherals
are used on most Rockchip SoCs, it makes sense to limit this on all.

So add ARCH_ROCKCHIP to the default-y list of LMB_LIMIT_DMA_BELOW_RAM_TOP.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 lib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index cf13ac1bdad..9e0f0ad7d06 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1298,7 +1298,7 @@ config SPL_LMB_ARCH_MEM_MAP
 config LMB_LIMIT_DMA_BELOW_RAM_TOP
 	bool
 	depends on LMB
-	default y if ARCH_BCM283X
+	default y if ARCH_BCM283X || ARCH_ROCKCHIP
 	help
 	  Some architectures can not DMA above ram_top boundary,
 	  which is after 4 GiB or 32-bit boundary too. Limit the
-- 
2.47.3

