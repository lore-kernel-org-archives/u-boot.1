Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0788D3C906
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D855892CD;
	Sat, 19 Oct 2024 13:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ThlrZdVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14DBA892C8; Sat, 19 Oct 2024 13:00:13 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D5D892C0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-156.46.114.pool.telefonica.de
 [46.114.105.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D04803F19B; 
 Sat, 19 Oct 2024 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729335603;
 bh=qCgGIOqVX2nmaNTEqh7Y1Z7fMzqnTREPNuposFLjUC4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ThlrZdVhf3jpa9C7/27Ur08eLUVfhXBrHuMJn+Ko/sKPW2eSztrpBuDNQu2YgJYNY
 zHH4bvnkNV0gD+eUMbHEajGCQYQHYSL8NYKQdAQyitAMyV0IWjuTqMwgTbTVYg5G2M
 gn+jsjO1BY53vUcydp+Lu+oNcAC8dTfkUEs1JqzK8RCrmKIMROcK7Htw4bT//R1k6H
 QE0rhwpFE7zshWJkomqI7iMPefaIF6KhjzkTEjjz6d5mohcSYH9qSH41atl2ZWdhHi
 k+qcfLbOK1dUb4y5mOFFTIi6UCeg4nWZjEuQcB3KRhkXOxnuy0meDnDvxVQjFC7uBv
 vPcKyVA3Z7rRQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: fix CONFIG_EFI_HTTP dependencies
Date: Sat, 19 Oct 2024 12:59:57 +0200
Message-ID: <20241019105957.54751-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

CONFIG_CMD_DNS and CONFIG_CMD_WGET depend on CONFIG_CMD_NET.
CONFIG_CMD_NET depends on CONFIG_NET or CONFIG_NET_LWIP.

We shall only enable CONFIG_EFI_HTTP if there is network support.
We have to select CONFIG_CMD_NET.

Fixes: d7d07a8b508b ("efi_loader: support boot from URI device path")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 69b2c9360d8..066f0ca0da7 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -545,6 +545,8 @@ config EFI_BOOTMGR
 
 config EFI_HTTP_BOOT
 	bool "EFI HTTP Boot support"
+	depends on NET || NET_LWIP
+	select CMD_NET
 	select CMD_DNS
 	select CMD_WGET
 	select BLKMAP
-- 
2.45.2

