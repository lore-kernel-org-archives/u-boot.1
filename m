Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72B3C2D0CD
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 03:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6515480AE0;
	Fri, 16 May 2025 05:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="QD33Rfsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F5382935; Fri, 16 May 2025 05:06:41 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A55806D8
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 05:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E0BDE260CF;
 Fri, 16 May 2025 05:06:39 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vFMbaEdtojR; Fri, 16 May 2025 05:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747364798; bh=7vQ+NbdTzHP4v0sz3fwNhHGDUZlNLsvbdRxicCKNSj4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QD33Rfsi4SJ9hmoie0qXUIhSA3nAj/1l9Iu2E9DclWMrfnOWh2kapBfv4XEKW9Rd0
 vW1odlHHFL0Tlfu3Ko4CUS7c09cf9QsTF4AHukCVbJO4ZJUpBKNx5y/G/FEgmXG6HV
 Jmtrdbaco27ScKlyjaa5ZKE3mjt+skx3zurFRkwO9XNLg79NccFSWsaezljtXN3qxZ
 TqWOj4jbdlNnd6kStAQR4aKI+BUmH89HBHlYRy1z0oOMW1JziUU2Ib3emd+mkrO00D
 4s5AKDpMhY7ZRK/0giIqqBjby6rrXeBvqMwFH1iDLFYtG+OiRGwUK9exp6uHy8BFp5
 kLFXFCgnEOZwA==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Yao Zi <ziyao@disroot.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 3/4] riscv: cpu: th1520: Select clock driver
Date: Fri, 16 May 2025 03:05:24 +0000
Message-ID: <20250516030525.31361-4-ziyao@disroot.org>
In-Reply-To: <20250516030525.31361-1-ziyao@disroot.org>
References: <20250516030525.31361-1-ziyao@disroot.org>
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

The clock driver is essential for TH1520 SoCs to operate. Select the
driver in SoC Kconfig entry.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/th1520/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/cpu/th1520/Kconfig b/arch/riscv/cpu/th1520/Kconfig
index a916d364e6c..4d44191bd22 100644
--- a/arch/riscv/cpu/th1520/Kconfig
+++ b/arch/riscv/cpu/th1520/Kconfig
@@ -10,6 +10,7 @@ config THEAD_TH1520
 	select SUPPORT_SPL
 	select BINMAN if SPL
 	select SYS_CACHE_THEAD_CMO
+	select CLK_THEAD
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-- 
2.49.0

