Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7200FE77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF23480079;
	Sun, 12 Jan 2025 23:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LK4wNp0z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t22/nr+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22EFB800D2; Sun, 12 Jan 2025 23:48:36 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F9A80027
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YWVt94C4Xz9sS4;
 Sun, 12 Jan 2025 23:48:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736722113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dPLO6Are+/DBJZaaibA3tC2Rf/hUF2OsCtzgsrUqLs0=;
 b=LK4wNp0zkUO3i+Ep7mVNRhQChBOrhCcbhpGdBMaAPQxosQoFqn7gKKpGl0M95IEqNYkhQ6
 sH2EXeDG6ZvwpMu0NmgCiOGVvo0pBxZRFRUz2UXx/N0ArT1j5lkncnc4Qkz7bvt+RV9ZhA
 n0xKXbQsFwJxYLxibjz7UOqL4zY1+vEa6Gsa7VLnlH01lCWJ96T95eaixHIhDeD0lmcMvV
 yVbWD+nTYch0gUQRO0DOhY+bijR2ASfygG8SZBWexbtZzGkz38IF8QoF5LkrExOw7+K4qV
 H/TjawNswBUgp8vYtFNpFnAfL8g6gVLiTf69UpI6SFX9p8LCLakn7RRC2QPKXQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736722111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dPLO6Are+/DBJZaaibA3tC2Rf/hUF2OsCtzgsrUqLs0=;
 b=t22/nr+JF1EX1cmGWDyWvGFYikoxlDjd2awCbLLmTuOrwJFXYK5yup4RSHxBy9p1JrqTeI
 +pIGeRybLhjo4D+pqTrrI2zSkdXw9h+aer7NOANfqfiwY+M2uejLNLcLnzIrXf/XHS85x8
 FMWCMN8VbcyoykZ4vFiQyGFMgdhjZ+BOI7G9yz3tl6ucRV0wxU0F17wnt8qbqFbdHJBxAD
 TJtj7Wsu3ChpnJ1QhC9d9Zrm7rsc0uEBu0CYuxGvITNyxmCt0cKhybmINyPUdmEIAPYP7X
 fJsCVti6oFCcoXBgNs7fDPAl8Uj7jhgefieu8PyIgdvHcRtgJ04wkHnPR7Mbfg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Rewrite u-boot-elf.srec base address if PIE
 for R-Car Gen3
Date: Sun, 12 Jan 2025 23:47:45 +0100
Message-ID: <20250112224814.200121-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6hgzhtsm3asayhd49eo6dbpfakzmox5d
X-MBO-RS-ID: 03f8ae30cc93b69823a
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

The flash_writer tool and previous recovery tools require the SREC load
address to be 0x5000_0000 . The PIE U-Boot build sets the address to 0x0
instead, so override the address back to make u-boot-elf.srec compatible
with the recovery tools.

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index 0500eb6e0a7..c7318950f33 100644
--- a/Makefile
+++ b/Makefile
@@ -1286,6 +1286,15 @@ u-boot.hex u-boot.srec: u-boot FORCE
 
 OBJCOPYFLAGS_u-boot-elf.srec := $(OBJCOPYFLAGS_u-boot.srec)
 
+ifeq ($(CONFIG_POSITION_INDEPENDENT)$(CONFIG_RCAR_GEN3),yy)
+# The flash_writer tool and previous recovery tools
+# require the SREC load address to be 0x5000_0000 .
+# The PIE U-Boot build sets the address to 0x0, so
+# override the address back to make u-boot-elf.srec
+# compatible with the recovery tools.
+OBJCOPYFLAGS_u-boot-elf.srec += --change-addresses=0x50000000
+endif
+
 u-boot-elf.srec: u-boot.elf FORCE
 	$(call if_changed,objcopy)
 
-- 
2.45.2

