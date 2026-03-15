Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94043F30283
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A4E284459;
	Mon, 16 Mar 2026 00:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XHaj/AKn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t+XlFTDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB028445D; Mon, 16 Mar 2026 00:53:01 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE0E84435
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fYw5R2R6xz9tc2;
 Mon, 16 Mar 2026 00:52:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6HnxC59l1Z846Z8o4/txcmm1/JIgOjp4d433iLsyjXU=;
 b=XHaj/AKnhSP5z+PPMnqQoSDTSDQkolm1RuxBu+vwoEpYuybBDqSnd2XQTtC7yvYsBxiOEE
 oFq0JpAOWqIf/VN2jV2+Sf/Y+1jwgu5qgGN8tsCF798xK8yreYxG62QHRb80Omkvs6QaDR
 KBGkD+Nqxh2ICKdnTnuLlP4XJ5vNtZARN5UsSZD/lRcpnkp8pF51piBtX9v62C53AoBW6c
 KF9Wwlmb7vxWOWQt2WFxZTmEDIYKtNUNJCMJXTBonquLBg/3iUj1gMHJHLuNUeN3sAaQmB
 EnQwF4ykKhVPfLbYR0mHvzgfabs3KoFedHkLE9ikR0JJEZkO9+m74lEKZN0a1Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6HnxC59l1Z846Z8o4/txcmm1/JIgOjp4d433iLsyjXU=;
 b=t+XlFTDeVwIEDeY7yNoImlaK5D8TNcpxGujH7SW+VBbvhC3UF2NJwiI2e9gcbRJKDKbJxZ
 OGiEfO5yqBD8DvqcBBf5DplBb6TbnXPgzZJiVK1wxKXMDJFfChx7q5tCARFI/eFBc/uriN
 b5qZiVVIU1f5lDhjSsvod1e3e1p7VCcdoL/fGCGe1RiozMitcHc0r9fcpi+IEP9y18wxw/
 OXb1euOgnKFtcAItvzUEXhvNNdFQoghmMHJ89rqeRP0jiqSHMCc2o3LzUB+kfGvE73aKFa
 QshFhMClN5PHEW/Z0ggq+wpDb0ks6PxOIznKO/y2rs2ufEO4YaJp8Ggchqvb1g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Separate 64bit only code
Date: Mon, 16 Mar 2026 00:52:33 +0100
Message-ID: <20260315235255.304585-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xeeytbzohjrtm3o4abtwk9rsnrsonmq8
X-MBO-RS-ID: 0f04683245842ae54b1
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

Conditionally compile code that is only compatible with 64bit ARMv8
on 64bit R-Car Gen3/4/5 SoCs. Protect such code with CONFIG_ARM64.
This split is implemented in preparation for build of Cortex-M33
version of R-Car Gen5 U-Boot for its RSIPM core.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Makefile | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-renesas/Makefile b/arch/arm/mach-renesas/Makefile
index c0454fffa48..652a392ba6f 100644
--- a/arch/arm/mach-renesas/Makefile
+++ b/arch/arm/mach-renesas/Makefile
@@ -9,10 +9,15 @@ obj-y += emac.o
 obj-$(CONFIG_DISPLAY_BOARDINFO) += board.o
 obj-$(CONFIG_TMU_TIMER) += ../../sh/lib/time.o
 obj-$(CONFIG_RCAR_GEN2) += lowlevel_init_ca15.o cpu_info-rcar.o
+obj-$(CONFIG_RCAR_GEN3) += cpu_info-rcar.o
+obj-$(CONFIG_RCAR_GEN4) += cpu_info-rcar.o
+obj-$(CONFIG_RCAR_GEN5) += cpu_info-rcar.o
+ifneq ($(CONFIG_ARM64),)
 obj-$(CONFIG_RCAR_64) += lowlevel_init_gen3.o
-obj-$(CONFIG_RCAR_GEN3) += cpu_info-rcar.o memmap-gen3.o
-obj-$(CONFIG_RCAR_GEN4) += cpu_info-rcar.o memmap-gen3.o
-obj-$(CONFIG_RCAR_GEN5) += cpu_info-rcar.o memmap-gen3.o
+obj-$(CONFIG_RCAR_GEN3) += memmap-gen3.o
+obj-$(CONFIG_RCAR_GEN4) += memmap-gen3.o
+obj-$(CONFIG_RCAR_GEN5) += memmap-gen3.o
+endif
 obj-$(CONFIG_RZ_G2) += cpu_info-rzg.o
 obj-$(CONFIG_RZG2L) += cpu_info-rzg2l.o memmap-rzg2l.o
 
-- 
2.51.0

