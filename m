Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1427AC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 06:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC7582CA4;
	Mon,  7 Apr 2025 08:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RnHAHzj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4D682CB9; Mon,  7 Apr 2025 08:44:35 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED9182C55
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 08:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-108-136.46.114.pool.telefonica.de
 [46.114.108.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B9C0640393; 
 Mon,  7 Apr 2025 06:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744008271;
 bh=6PxElFdR2LkS7NOCgJYl0gFxTQ8UyF7RDmjJD6CH5Dg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RnHAHzj/h4uFZgyeDko6aO1KJ8AgWYDULwqIVazx3fMer4zPc8Jz3rl2ajuWJpLVI
 E1YzpSOA536N2x3vBcCMI/DZw/WfnoTcYieNPFV4cfcQKBB0lDye+VhktlbtR22eJZ
 ZZ/jTVvLyt7pcSEzUTOEl+oKjCqW76cyFRPIa8oHYhwZgIo6yoDsmUFYOYKSx4vuJ+
 10pY2xwGyNOgJULLAjK8n0IpiSWT1vy05yRtyScKi1yW+XCdvTp+l7cxrz4bru/Xqs
 WBwLN4arqf9Qeu7nMc7keezjaR5MNUEaewex2pbaRDAQyJqQ1NDNzMr870BJ3Svvtk
 yR17aiDH6fNew==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] acpi: select CONFIG_BLOBLIST
Date: Mon,  7 Apr 2025 08:44:23 +0200
Message-ID: <20250407064424.71541-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407064424.71541-1-heinrich.schuchardt@canonical.com>
References: <20250407064424.71541-1-heinrich.schuchardt@canonical.com>
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

Since commit 53d5a221632e ("emulation: Use bloblist to hold tables")
`make qemu-riscv64_smode_defconfig acpi.config && make` fails with

    qfw_acpi.c:146:(.text.evt_write_acpi_tables+0xc):
    undefined reference to `bloblist_add'

Build with bloblist support.

Fixes: 53d5a221632e ("emulation: Use bloblist to hold tables")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 1a683dea670..a348fccebdd 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -317,6 +317,7 @@ config SPL_ACPI
 config GENERATE_ACPI_TABLE
 	bool "Generate an ACPI (Advanced Configuration and Power Interface) table"
 	depends on ACPI
+	select BLOBLIST
 	select QFW if QEMU
 	help
 	  The Advanced Configuration and Power Interface (ACPI) specification
-- 
2.48.1

