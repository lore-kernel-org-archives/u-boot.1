Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18347CCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 19:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4E983AE4;
	Fri, 31 Oct 2025 20:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jZpk70gF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D63483AE6; Fri, 31 Oct 2025 20:59:37 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E4C83AE7
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 20:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BB4F340965; 
 Fri, 31 Oct 2025 19:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761940775;
 bh=+U0EFAPdoDDAhYW8U3u8cTn0dtYhOaWZLcHVU9LsBmg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=jZpk70gFg5vJkXZ57dMcmEJq7HrrBPhyLfA6pFyTHCEWQgCoG+NzeimnVm3REVAPy
 N7TWXnQr3c+9GknW2tp4VbbFYQgfpLlUHkA/24GatOEPKE5PnThpOjLSjfAwxlnYS6
 1OjjYlrsBWwFhiXndS5TzFxqzUflv7YZfv7FBVbXi6AipQgCTeOL1OPIVxKKXO/jJC
 kiuzSpHO/WRVUenwODdZHwbFqwQfdfnwSqD6pv9JvHpxSdckZ93gfH1QUJhsq0wlzc
 ahqOCleVYwKBdJV3cnDpwFMhe4/kqhvOUwWPiivtyAYD/URCQnnBxzvA2TD8wtV6+4
 DqhOfzElw/IL9b+JSaAth2iRtZylJLid8EwBUyNS74WEH/kQzbAXS0fjJWVgPpVc/D
 ribJ9h6dh8/jWo7yF9UgyL+DNT+3F5inABL41rvOlhk/fAVj7YOh12dAIS4YqPHo85
 fQ+sMW/z5lFjpXZ630t9+sbLe0hBMawK68kUTXihUN2bDXXtN07cjqe4gT2Q/Tlzrm
 3fhcsN5mySlrCFUDPYUn1PbyRx/xOVwLIcpbaFIHTos2K3ehNLFMUZdWi28mipDpPs
 q00EVCfZ9TpAoCGsmq5Pve82fSqVKkmuyYj8Sa7IdMPFrukU9kxa6DEl6tLVTTWAbp
 bYHwimxqgJwHlE/lFYg/Iwbg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] qfw/acpi: do not zero out XSDT address
Date: Fri, 31 Oct 2025 20:59:29 +0100
Message-ID: <20251031195931.622513-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
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

On RISC-V QEMU provides an XSDT table. The RSDP table points to it.
We must not zero out this pointer because otherwise no ACPI table can be
found.

Fixes: 15ca25e31ed5 ("x86: emulation: Support BLOBLIST_TABLES properly")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/misc/qfw_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
index c6c052ac6c3..721f42ecbc3 100644
--- a/drivers/misc/qfw_acpi.c
+++ b/drivers/misc/qfw_acpi.c
@@ -265,7 +265,6 @@ out:
 	struct acpi_rsdp *rsdp = ctx->rsdp;
 
 	rsdp->length = sizeof(*rsdp);
-	rsdp->xsdt_address = 0;
 	rsdp->ext_checksum = table_compute_checksum((u8 *)rsdp, sizeof(*rsdp));
 
 	gd_set_acpi_start(acpi_get_rsdp_addr());
-- 
2.51.0

