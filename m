Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9422DC5B552
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 09:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A0A283257;
	Fri, 30 May 2025 11:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="CiyzOVEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 899DF8324C; Fri, 30 May 2025 11:49:18 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B129083236
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 80A1025F6D;
 Fri, 30 May 2025 11:49:16 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EmaYCFDSwNM2; Fri, 30 May 2025 11:49:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1748598555; bh=14VT/e/2+ei/4jwjzW4O+9205cjYlTfUNAi1Is3r5zo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CiyzOVEJL8+pigtWBpsazNbPizsS9zegJON3hKMEiTv1lTFlrtvAeoRYYDjuCKJpt
 uR50NT6nHnsLalONes6hyhlaYPPtKHtjkSp4PVc5Ygg1/UnvnIqjHJ3vtsF+qmutGg
 B3E/nD1cpQF2EPeCvFSFyDQqKQGkesl62bSV43wopXAmyOK9/1yvMIcFM+FLLjv/B+
 1bc07Qwj17Y3ZNLtOl1y+zyGC18XIj2evQT+89ViEDYS2zwtBQVqwPmjrrpUb+SfiK
 LVqD+FXvBWhc/2ebbNXdJVth2Kd9vPGSvmKOmfF4EmnXw6wl7JfeWn9MwgdrVZViox
 NVTqPkVnnrnxg==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/5] riscv: cpu: th1520: Support cache enabling/disabling in M
 mode only
Date: Fri, 30 May 2025 09:48:48 +0000
Message-ID: <20250530094851.57198-3-ziyao@disroot.org>
In-Reply-To: <20250530094851.57198-1-ziyao@disroot.org>
References: <20250530094851.57198-1-ziyao@disroot.org>
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

These operations rely on a customized M-mode CSR, MHCR, which isn't
available when running in S mode.

Let's fallback to the generic weak stub when running in S mode to avoid
illegal accesses.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/th1520/cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/cpu/th1520/cache.c b/arch/riscv/cpu/th1520/cache.c
index 08aa1f789fd..b2fec229363 100644
--- a/arch/riscv/cpu/th1520/cache.c
+++ b/arch/riscv/cpu/th1520/cache.c
@@ -11,6 +11,7 @@
 #define  CSR_MHCR_IE		BIT(0)
 #define  CSR_MHCR_DE		BIT(1)
 
+#if CONFIG_IS_ENABLED(RISCV_MMODE)
 void icache_enable(void)
 {
 	csr_write(CSR_MHCR, csr_read(CSR_MHCR) | CSR_MHCR_IE);
@@ -30,3 +31,4 @@ int dcache_status(void)
 {
 	return (csr_read(CSR_MHCR) & CSR_MHCR_DE) != 0;
 }
+#endif /* CONFIG_IS_ENABLED(RISCV_MMODE) */
-- 
2.49.0

