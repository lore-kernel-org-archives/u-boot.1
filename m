Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFD6CDDE5B
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 10:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1FA89266;
	Wed, 23 Oct 2024 12:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jiqnR35n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8126F892DC; Wed, 23 Oct 2024 12:18:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 783F58926F
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 12:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D17A05C5C66;
 Wed, 23 Oct 2024 10:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F00C4CEE5;
 Wed, 23 Oct 2024 10:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729678691;
 bh=e+JuOMPkNUWV+v8uaYckWJQSqV+P2eIyUQktEFLICos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jiqnR35nw0W2gaImPro1NCewYprTNqCeM/t0wIKwzcaLfCPTvyXNyE+DPVJ3vnKQE
 4ZcbpldTkCgpLiTPhaphKYa+yLoT1Y2mQxsYaPUqOLZYCzveUsDViiLI9HiYAeWbRx
 a1N1QbLlfjxXd4j8GaDhh2QJSMtiCx7LrEhfk5cXmbVWneMk1aqORUTOSi5gIlkyvY
 e3wGV6uWOIWq6lurG3SQuqoQdpO17H12z6Uql7UivBnzVX50dyOl2oqdFK0DWly2b9
 mm28EmvdM2kwj/g7rx8R29iFweNtaLTnHQbDvkWMCN7lm0vvK0dDpH/S7TZMfnoHKC
 1n/03GK+QotIQ==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Cyril Jean <cyril.jean@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 2/3] board: mpfs_icicle: imply new clk driver dependencies
Date: Wed, 23 Oct 2024 11:17:53 +0100
Message-ID: <20241023101754.4021948-3-conor@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023101754.4021948-1-conor@kernel.org>
References: <20241023101754.4021948-1-conor@kernel.org>
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

