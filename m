Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F4BC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 16:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 223E2880FC;
	Mon, 15 Apr 2024 18:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dpCU/b/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18CDF87A0E; Mon, 15 Apr 2024 18:30:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C1C88005
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 18:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C4CFC60ECF;
 Mon, 15 Apr 2024 16:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00E6C2BD10;
 Mon, 15 Apr 2024 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713198654;
 bh=DzIhS9tZ79Ole4nbK9ZDRQO+e4V6UdAuCZiDBe0+GCI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dpCU/b/Z6zAkI1nW4iKF6clHIGYWFyKREu9iDytrttEa1hw+AIDq5Ry6YEHTAY2MD
 FlYx6aMdKqWA8B8kcaf3hN1keIS0GFioC9sjSXRhYaitmheJjlX0BLPtY3+rLBtkAv
 wOq7d9lH+dV/zW6l1o+sGL9jOJ6KbgLtlRZXtr7wwkqTLQoBnTQ553gegLPnmQeH/H
 1txe3ZzGIUvBWRNLf6nc1itgt/MKkButmbzxyNxcy1X+sGnkt/wmQWkaDE8a11ZZmg
 CPstxKalSi5Gc6EAR4eDKycupKOKPb5e9tRpJIm1wRrc0/lhT0XyrERq91MyaZWpav
 wFGGXlXPDBFwg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu 05/10] arm: mvebu: turris_omnia: Enable immutable
 debug settings in DDR3 training by default
Date: Mon, 15 Apr 2024 18:30:38 +0200
Message-ID: <20240415163043.7482-6-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415163043.7482-1-kabel@kernel.org>
References: <20240415163043.7482-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Save 10 KiB in Turris Omnia's SPL binary by enabling immutable debug
settings for DDR3 training code.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 configs/turris_omnia_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index f2b39115fe..02edd335c1 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -10,6 +10,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
 CONFIG_TARGET_TURRIS_OMNIA=y
+CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS=y
 CONFIG_DDR_RESET_ON_TRAINING_FAILURE=y
 CONFIG_MVEBU_EFUSE_VHV_GPIO="mcu_56"
 CONFIG_MVEBU_EFUSE_VHV_GPIO_ACTIVE_LOW=y
-- 
2.43.2

