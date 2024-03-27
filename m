Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1548C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC86F88166;
	Wed, 27 Mar 2024 17:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B1Tu7SdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D016D880FE; Wed, 27 Mar 2024 17:24:21 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E8A8811C
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 79216615B7;
 Wed, 27 Mar 2024 16:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57956C43399;
 Wed, 27 Mar 2024 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711556658;
 bh=OKnMr0tZ+KyvLTI4BZbNRZlaxNDoxc3Xi9NqBFN76y4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B1Tu7SdEthuMlsY4fFHQ0jBcaRYlOnw8L/VBKDI5GHjXD8PQgOGdGMkiQxj5Y1+QV
 W5ONVBv1TUIk2J3cZlozP9VNKWyhYdrLttnStd+Xez9jDMtqgXZ5/EBjK8qnLYVApl
 wUNX7PLtVs/9puZn1q7tSZGLENYN+aZgjkjR6wmDBuD5wP9oB9zlRsGetnztoV0pnx
 6n5SuPp7hXDd+ZQGKTi/Fo9Kv9qpj8Ec63zUuV4IRQeG52+0OqG1Re/wwizbjS34Qg
 jwEZIa98PG1YI5MRH9gb9KVPFjaSV67W+kNfknyGE5pSlhjznvW/0BlLQhz7OsgEBt
 V4U8T0NjKHccA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v3 15/18] arm: mvebu: turris_omnia: Enable
 poweroff command via sysreset in defconfig
Date: Wed, 27 Mar 2024 17:23:52 +0100
Message-ID: <20240327162355.24584-16-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327162355.24584-1-kabel@kernel.org>
References: <20240327162355.24584-1-kabel@kernel.org>
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

