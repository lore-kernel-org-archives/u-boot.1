Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70007C83F09
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 03:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA6CE8363C;
	Thu, 10 Jul 2025 05:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="I59msmrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E6183666; Thu, 10 Jul 2025 05:42:27 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED6A835CD
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 05:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9C81922F39;
 Thu, 10 Jul 2025 05:42:25 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UsWvG3kL2O7i; Thu, 10 Jul 2025 05:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752118945; bh=XYzEie1ULcxjlgF+Bz/eHGGmte2cgH8neUKkfSxaDcc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I59msmrClgh7/XJSnNILTAxD1aEiM8cRZsXOupaJj4bWLWtgWGJqM3uHe3kfggg/B
 3Y3nVHYYDkfbJX2lkZnDpFiNmulKG6weaOaj5H7Ljm4TyNgvHnxEPlGnGr3pTImEAu
 FvG784wuaiKWS37txe9a536Vl0Nkv2J9vnFuWBZzG+xmDZacLJnZCJamSa7FPhNq9g
 o1CkoUfwIfA+30IYfnUVybWyaLNKV+pBxkhbmftJkFHKhuRSruK5Vxrg21b6dnreKk
 HnyDqT+/MmQx6WlwMztIQWOoisjFXmhAhaZWGBV21lI9XsnX4q2qX+x0+YHRT1LI3G
 YbJofaC2RDeAQ==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/5] riscv: cpu: th1520: Limit upper RAM boundary to 4 GiB
Date: Thu, 10 Jul 2025 03:41:58 +0000
Message-ID: <20250710034201.39901-3-ziyao@disroot.org>
In-Reply-To: <20250710034201.39901-1-ziyao@disroot.org>
References: <20250710034201.39901-1-ziyao@disroot.org>
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

TH1520 SoC ships DMA peripherals that could only reach the first 32-bit
range of memory, for example, the GMAC controllers. Let's limit the
usable top of RAM below 4GiB to ensure DMA allocations are accessible to
all peripherals.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/th1520/dram.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/cpu/th1520/dram.c b/arch/riscv/cpu/th1520/dram.c
index 91007c0a3d3..8a0ca26785e 100644
--- a/arch/riscv/cpu/th1520/dram.c
+++ b/arch/riscv/cpu/th1520/dram.c
@@ -19,3 +19,19 @@ int dram_init_banksize(void)
 {
 	return fdtdec_setup_memory_banksize();
 }
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	/*
+	 * Ensure that we run from first 4GB so that all
+	 * addresses used by U-Boot are 32bit addresses.
+	 *
+	 * This in-turn ensures that 32bit DMA capable
+	 * devices work fine because DMA mapping APIs will
+	 * provide 32bit DMA addresses only.
+	 */
+	if (gd->ram_top > SZ_4G)
+		return SZ_4G;
+
+	return gd->ram_top;
+}
-- 
2.50.0

