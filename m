Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED7ED30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3819891E7;
	Fri, 18 Oct 2024 16:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R1c1/rKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D54168919E; Fri, 18 Oct 2024 16:55:02 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC35D88E90
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D7416A44308;
 Fri, 18 Oct 2024 14:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CBAC4CEC6;
 Fri, 18 Oct 2024 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729263299;
 bh=e+JuOMPkNUWV+v8uaYckWJQSqV+P2eIyUQktEFLICos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R1c1/rKJ2VI4M2L67NKsPmh1SpB7JTsinSIsrVgF/7gyUZLmMdE2NRl/Et27KORIG
 KxDBSl9Av9wrFOqUED1xgqbYXdRPF3qZmHWyWDN1Um0hK6QwlVGVPGMKvKGrn68Uu8
 /P+bYS5JMzodlbwcJwYZxwc6ONXvoaoPXIGqBoMFkK7dvwepCtoBD8l2J+Gk/r2I9r
 TySqIegbsOtVnOQ3bRPmhlab725ZuVkNTo7ynPVMNe1wEa5iv7uqld1YCYh6ueiI1o
 BZ97siy2UhQltuQyFB7rHX0ozoPYskG8PeuPL4XRIgEdNXvPs+fq6s7mcE/O5hAoAU
 FVp2s/YSmTpWg==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Cyril Jean <cyril.jean@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v1 2/3] board: mpfs_icicle: imply new clk driver dependencies
Date: Fri, 18 Oct 2024 15:54:43 +0100
Message-ID: <20241018145444.1660219-3-conor@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018145444.1660219-1-conor@kernel.org>
References: <20241018145444.1660219-1-conor@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

The clock driver for PolarFire SoC now requires syscon and regmap
features, so imply them to preserve implication of the clock driver.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 board/microchip/mpfs_icicle/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/microchip/mpfs_icicle/Kconfig b/board/microchip/mpfs_icicle/Kconfig
index 4309f7528bb..6e8c479e955 100644
--- a/board/microchip/mpfs_icicle/Kconfig
+++ b/board/microchip/mpfs_icicle/Kconfig
@@ -24,6 +24,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply SMP
 	imply CLK_CCF
 	imply CLK_MPFS
+	imply REGMAP
+	imply SYSCON
 	imply SYS_NS16550
 	imply CMD_DHCP
 	imply CMD_EXT2
-- 
2.45.2

