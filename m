Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDA1C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 23:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0BDF816A4;
	Fri, 28 Feb 2025 00:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Xv9ClaX6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="otYUN3Yh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04A06816AB; Fri, 28 Feb 2025 00:43:54 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F9481426
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 00:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z3nwl0w4cz9srG;
 Fri, 28 Feb 2025 00:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740699831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OEkrpA1ffCM3ufoznzndbzx7FjWZLp+unhCTVh+ZiBQ=;
 b=Xv9ClaX6VRxxAiYKSmQC42oEDTWGEEEtdKeulPBAG6Amr/s8G/R2+VsXPJ3Ztyku2QcYnQ
 KrC/8CcWDS9ViV1o6UUZ0I1wISre89klxtArVayIeKZ+K57f3jcuxcxiKbF3qOYYag9zsg
 FbCcNVnEDeiePR9jMzU1eu2SfQpAUQ65Lelt2FU1ozgAIztHwYpnZKdfiwRIHiQBNtDNh0
 f9Dhf+7Q+yF99oHXvgsukPbnomaUIPkRNuHmMMTUn9ajKZosTRbpDY9/ki3xqpRELzul9i
 Zb6jRe0Prk3nvFkziI+RoA35N2sNQtHf1cWlFyC3LrHmU7Ceh6FTinUjxcGdCQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740699829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OEkrpA1ffCM3ufoznzndbzx7FjWZLp+unhCTVh+ZiBQ=;
 b=otYUN3YhXE4UXZTiHAjG/yS3jKMj565lfJUN9nVSJWnWLlTrENdqxVX6vnD2iFOKDgDcp4
 s1uTTwOQkT7viqQPkAGlZLUYunQpDishKBaPBMSKO5VXTUpMf54bW7RyMwApVFT2mK4MGk
 bpYoH7n+QSBC8Bj+FymoByWQHiXnrGnREFiGjjNFcqBotKUL3GXX90yDIZETwUsRtRL8ep
 Ku+7RVHZTHcAAp9SofC+fmWS0YxRQxBaJ6ww9gLYGCTeYate3j9GtUQs4D1ocawYWnKtAj
 9QDSRnqr1lkBH7i/lMWE9gQryUckNtSmtKmK3zsAfT0r2/osAbsCjNZxiHCk0g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] pinctrl: renesas: Fix RZN1 symbol name
Date: Fri, 28 Feb 2025 00:43:16 +0100
Message-ID: <20250227234335.157217-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5qr5ibw684tyomz7pyddmioranz47cp1
X-MBO-RS-ID: 7b20f991d57dd5f1af2
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

The RZN1 symbol name is CONFIG_RZN1, there is no CONFIG_ARCH_RZN1.
Fix the symbol name so the pinctrl driver for RZN1 gets build.

Fixes: e4aea57fa773 ("pinctrl: renesas: add R906G032 driver")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 634047a91f4..0d5798b0634 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_ARCH_MTMIPS) += mtmips/
 obj-$(CONFIG_ARCH_NPCM)         += nuvoton/
 obj-$(CONFIG_PINCTRL_QCOM) += qcom/
 obj-$(CONFIG_ARCH_RENESAS) += renesas/
-obj-$(CONFIG_ARCH_RZN1) += renesas/
+obj-$(CONFIG_RZN1) += renesas/
 obj-$(CONFIG_PINCTRL_SANDBOX)	+= pinctrl-sandbox.o
 obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
 obj-$(CONFIG_$(XPL_)PINCTRL_TEGRA)	+= tegra/
-- 
2.47.2

