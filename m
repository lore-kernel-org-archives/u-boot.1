Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF42BC54E67
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C1F87F69;
	Sat, 23 Mar 2024 19:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G/C0Adjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B0E48809A; Sat, 23 Mar 2024 19:07:44 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0517587FC0
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4BD9460B30;
 Sat, 23 Mar 2024 18:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9B0C433C7;
 Sat, 23 Mar 2024 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217255;
 bh=OKnMr0tZ+KyvLTI4BZbNRZlaxNDoxc3Xi9NqBFN76y4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G/C0Adjq6Rs6MU/RL5nQ2mHNR/nZK8at9tpu1udxmU+6Ly2ZMWnRySZEa05sTDp3s
 PsLIU3v95WuRAvIucFeUX5rhTqHLGKzq/MZYU8B4mfIHTC7oO5Qh8m5E4xnDHn5sGg
 ni6PUsNfSKEZ4HqHyRT+e0Es1dN7TqBeeqJtinwW8mB/+MNsOjvpkkcXJ8uV16iFYB
 3mfCte4mZzHmJKT2H/2l979oxhpCObFjEVpb4iGtKFaq4x5jGadRrFWaupVvl1Ssmx
 8ElT4Pv7tneSIWs0h+3+TSfdIqDQwAejcwFEuCBz7tAmqWYL6RUl5mX22SOJRDHV8y
 yJlivTCQdUgEw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 15/18] arm: mvebu: turris_omnia: Enable
 poweroff command via sysreset in defconfig
Date: Sat, 23 Mar 2024 19:07:08 +0100
Message-ID: <20240323180711.5498-16-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323180711.5498-1-kabel@kernel.org>
References: <20240323180711.5498-1-kabel@kernel.org>
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

Enable support for the poweroff command via sysreset for Turris Omnia.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 configs/turris_omnia_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 9d5171c6a8..0df0f3c90b 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -114,6 +115,7 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
 CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.43.2

