Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464B1C02197
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C55D5800B3;
	Tue,  4 Feb 2025 18:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z+SW41lR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4987D80540; Tue,  4 Feb 2025 18:22:19 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 405C780040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1C899A42A61;
 Tue,  4 Feb 2025 17:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEF6C4CEDF;
 Tue,  4 Feb 2025 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738689734;
 bh=+Ia/iPMWjmbPl6f2n+eAd+r8dqHBXk4hMIFELQLZUvs=;
 h=From:To:Cc:Subject:Date:From;
 b=Z+SW41lRRWIZnMD3W90ev1avZssFtcD3Z+OY+mkbaSfwufVpHBrVCtMAxJ2xJQ12D
 Dc3/vBx7zQk1zVkD6gGZvgJcG0RceMmFupym9QAOyt/rB7RKOl2qm8LQRBbHv7Mcx7
 IK9RsbbwD0WNbY7TZfY6enRIPs7jtsGQJEWd90Zq7wzJ25x0eKDYV7I5G8RiTBXCA4
 qRCy7/WPZyFt/Qkgky3EcvMv6YgHZ4DJ9qzvExtU8rFARwusP5pOW5GOtNon9B2GGc
 EeKW9GAsEq7EvaAeUmEu+KaL5713/hRmCaJ3d+iLKh3yVKNXmERf4i2rHt3R61EuGf
 gSmsLVbj4345A==
Received: by wens.tw (Postfix, from userid 1000)
 id 8E5345FB49; Wed,  5 Feb 2025 01:22:10 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] rockchip: Enable OF_LIBFDT_OVERLAY by default
Date: Wed,  5 Feb 2025 01:21:51 +0800
Message-Id: <20250204172151.3361714-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Chen-Yu Tsai <wens@csie.org>

Device tree overlays are immensely useful.

Enable it by default by implying it from ARCH_ROCKCHIP.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f504d7d07601..2797030d3501 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2061,6 +2061,7 @@ config ARCH_ROCKCHIP
 	imply DEBUG_UART_BOARD_INIT
 	imply BOOTSTD_DEFAULTS
 	imply FAT_WRITE
+	imply OF_LIBFDT_OVERLAY
 	imply SARADC_ROCKCHIP
 	imply SPL_SYSRESET
 	imply SPL_SYS_MALLOC_SIMPLE
-- 
2.39.5

