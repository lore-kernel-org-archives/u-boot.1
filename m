Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282E8C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 09:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D9682CC9;
	Wed, 18 Jun 2025 11:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Q9JS+0Ti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C1882CD5; Wed, 18 Jun 2025 11:56:20 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F56182C8D
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0186A260D3;
 Wed, 18 Jun 2025 11:56:18 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LoZEbL-N01Qk; Wed, 18 Jun 2025 11:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1750240577; bh=cIqCt3J+9EDtZNXvaR35DV66A3MJoe+NYGKguNnIcQM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q9JS+0TiDEQYb2SHih86p6VZ9GAryz93MelKyuSZiCD5f73v2cRPNgLb8vgWdQ0p+
 h/R4ZuxEiFEIgUoKo7caefIo7KnKaQrlaJLKW7iHpqgZ8K9Iy2rnTyQd9R4kUj4coi
 ss+Do4YH5ue+CjUMIYtnhwR3t4ddJmT8ID1j8LPfATZnFVFuqYXwLi28K++LCprroS
 wYghgQOr7GKyt9+UwbVPT2jiWdmq7hJa4xdVkqk/IrtpqGgXbxFU09GIDbHNff5Eiq
 HAX/igCj5UyL3tffFprdYW4/s24P5icYQCf0CUWT7jpJzcl0H1gcVbw9gWNY43a81I
 CaBf7z9DuPVkw==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 3/3] riscv: cpu: th1520: Enable pinctrl by default
Date: Wed, 18 Jun 2025 09:54:57 +0000
Message-ID: <20250618095457.45926-4-ziyao@disroot.org>
In-Reply-To: <20250618095457.45926-1-ziyao@disroot.org>
References: <20250618095457.45926-1-ziyao@disroot.org>
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

Select PINCTRL_TH1520 in CPU Kconfig entry and update defconfig for
existing TH1520-based boards to ensure PINCTRL is enabled.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/th1520/Kconfig  | 1 +
 configs/th1520_lpi4a_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/cpu/th1520/Kconfig b/arch/riscv/cpu/th1520/Kconfig
index 4d44191bd22..c73462c04b8 100644
--- a/arch/riscv/cpu/th1520/Kconfig
+++ b/arch/riscv/cpu/th1520/Kconfig
@@ -11,6 +11,7 @@ config THEAD_TH1520
 	select BINMAN if SPL
 	select SYS_CACHE_THEAD_CMO
 	select CLK_THEAD
+	select PINCTRL_TH1520
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index 5734005199b..025250e56af 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -105,3 +105,4 @@ CONFIG_ZLIB_UNCOMPRESS=y
 CONFIG_BZIP2=y
 CONFIG_ZSTD=y
 CONFIG_LIB_RATIONAL=y
+CONFIG_PINCTRL=y
-- 
2.49.0

