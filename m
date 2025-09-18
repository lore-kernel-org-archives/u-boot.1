Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEF2CA1013
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 16:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09E3883285;
	Thu, 18 Sep 2025 18:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q/lkbT4F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VbtmCWLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E54D82C84; Thu, 18 Sep 2025 18:39:02 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7098319C
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 18:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cSLtq4CCWz9tX6;
 Thu, 18 Sep 2025 18:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758213539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2R9cdhhAGr9kXdQ6/CVjAmsX98yiobUjEaKHVSA1iXI=;
 b=q/lkbT4FKYGJXeQhkQHLz9L1GMsm1WzOUFbDxmU83zUbhDFpg4gIYOwn1Vz0d/K4CEqy0E
 b8DQHX949NPEaOPnqTuvQGQ37Lw9Q75//sCgEhQlW4f2juVQYbSQPgjgFq7cBticBQNsOo
 jOIA8PuYQwT3KR/O9QL1MxAhUKmlGJXLOoAJEcuQhbJO06uSGfQ6Ou4dduSM8ciF3bUjcr
 DwhqcHzhH0lsa8wRdY6DBVLl9D13kJblbCYrmVfEcy/VjbN9aHMSg4/AWQ/YnBwhfiiDh4
 wJKg5YnaTdnFjWiAvOreVHUdWySz3/KDQ4371tbyWRiFnJ4GlZPrusxBvl9o9A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758213537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2R9cdhhAGr9kXdQ6/CVjAmsX98yiobUjEaKHVSA1iXI=;
 b=VbtmCWLecGJp61EBCUpab0p0F/PGjk8zc0uscyf0Ye35GWLVcCOQXPo7PE6SRRfW5CDXKv
 E2abaHMF0ESZgQeGYGNY2OGHhHMZSgPFwEbC05KfYdNlD4ZbnUUE/gQq6g4zKyg+buoG0Z
 fLPTwD6oPPR6GslwWoJLmz9ljRg1rKflc3cnznFuEc3DowtxgWK9f3lxnvKRqC0iGZui2S
 +F4BOBf8U6HoUye9qsvqQRCdYFN+XfTEo+MRLv/uXGQUluiyeC/dJS8ElAOYMtUe7fOpPY
 poO+/dyOzL9TLWUUDQyvOe9/8RZqgpBK39qWrzka1q/Vgf6Bd8eL6XOiCx9zQg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: renesas: r8a779g3: Reset PCIe before next stage on
 Retronix R-Car V4H Sparrow Hawk
Date: Thu, 18 Sep 2025 18:36:01 +0200
Message-ID: <20250918163831.24272-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250918163831.24272-1-marek.vasut+renesas@mailbox.org>
References: <20250918163831.24272-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 57ddf64f5d1ef9109a4
X-MBO-RS-META: 8g3ipayaseci8jejq87tw15cfjzguk4t
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

Fully reset both PCIe controllers before booting the next stage on
Retronix R-Car V4H Sparrow Hawk board. This is necessary especially
in case U-Boot brought up the PCIe controllers, at which point the
next stage might be confused by the state of the PCIe controller.
The reset has to happen this late and not in the PCIe controller
driver, because the SRCR11 bits seem to affect both controllers.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/sparrowhawk/sparrowhawk.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/board/renesas/sparrowhawk/sparrowhawk.c b/board/renesas/sparrowhawk/sparrowhawk.c
index 58de7f25cbd..a4eda852743 100644
--- a/board/renesas/sparrowhawk/sparrowhawk.c
+++ b/board/renesas/sparrowhawk/sparrowhawk.c
@@ -267,3 +267,30 @@ void renesas_dram_init_banksize(void)
 			gd->bd->bi_dram[bank].size = 0x200000000ULL;
 	}
 }
+
+#define SRCR6			0xe6152c18
+#define SRCR11			0xe6152c2c
+#define SRSTCLR6		0xe6152c98
+#define SRSTCLR11		0xe6152cac
+#define SRCR_PCIEC0_PWR_RESET	BIT(24)
+#define SRCR_PCIEC1_PWR_RESET	BIT(25)
+#define SRCR_PCIEC0_APP_RESET	BIT(21)
+#define SRCR_PCIEC1_APP_RESET	BIT(22)
+
+void board_cleanup_before_linux(void)
+{
+	if (!IS_ENABLED(CONFIG_PCI_RCAR_GEN4))
+		return;
+
+	/* Set cold and application reset for both PCIe cores */
+	writel(SRCR_PCIEC0_PWR_RESET | SRCR_PCIEC1_PWR_RESET, SRCR6);
+	readl(SRCR6);
+	writel(SRCR_PCIEC0_APP_RESET | SRCR_PCIEC1_APP_RESET, SRCR11);
+	readl(SRCR11);
+
+	/* Clear cold and application reset for both PCIe cores */
+	writel(SRCR_PCIEC0_PWR_RESET | SRCR_PCIEC1_PWR_RESET, SRSTCLR6);
+	readl(SRSTCLR6);
+	writel(SRCR_PCIEC0_APP_RESET | SRCR_PCIEC1_APP_RESET, SRSTCLR11);
+	readl(SRSTCLR11);
+}
-- 
2.51.0

