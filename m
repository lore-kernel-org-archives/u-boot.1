Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C98CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 14:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA6AE84671;
	Sat, 30 May 2026 16:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LKksZdqU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bXd4PXUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465FC84693; Sat, 30 May 2026 16:46:13 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A208405A
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 16:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gSNMQ63lWz9v5G;
 Sat, 30 May 2026 16:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780152370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hFc7fBlkDuaOe30PiMMkzP6v6PogrN7z7V+KN0wLIWQ=;
 b=LKksZdqUWzwfzaPdYMyVkcH0zzI4I5g2YUvgNJeB6QYXdb7ilh+0ewFzDQA97ohSZi5WEs
 jA8vGEq1rIWxZN8F7Fv3oYj4rTN2RVFJF0fBIOHLFrqZPnUT18Z7uS5C3xJq5vLAc+Aixx
 T0JulIokk4I+G5ux+XndqkY8yeZkUY2+JH1k6xDAgJau0Oupoz1m4q0VlVXbOHOiu8+9Ra
 QfCQa5BRJzz3SdgATXVBmfVliur1SFetLptsDRriPVxxPdXi/2vXW+dfKgr1WXNMDY3Iij
 vvZL2ALT/hh4ts2nma/1a9baRIdJFCwcjmyUvPjAnkHoTmwGLV+Ss5OaM4Mt8Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bXd4PXUc;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780152369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hFc7fBlkDuaOe30PiMMkzP6v6PogrN7z7V+KN0wLIWQ=;
 b=bXd4PXUcXVCCq0I1I+fVcZ/vl/bJbx0jD5zb7sna9WOuRuKSau2YzFZMPRM7lDz91v/nXC
 hZtSVhLUEEzGURUwjBUQ06gP0zZ6L1SubHCzkcar1mCMrJ8FKNx0jhfktNqrWK+NodlHpN
 fi5Tny9ydMCxqPwa7CFRppoaPUxKotLFXJMvvAx86zyXyUh8t4xB6tISNIReT8YPGeJ8e4
 HSF2B+YE/Rn8VWD7PzDjd0agw8y8IiCqINhgzOFcAjQDZus5qHXoW5NNKnVTc9qtCWjqHb
 5ipflEZYqHTbpTiZO/YdbndIPBgl1WXx97UB6EAtk3vmyn3ijrw1rwPzG3Mv0A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on
 limited systems
Date: Sat, 30 May 2026 16:45:45 +0200
Message-ID: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pu7cgdm978tzp7inopg7jdano355duhm
X-MBO-RS-ID: 1c6c43d4e44fa1f7717
X-Rspamd-Queue-Id: 4gSNMQ63lWz9v5G
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

Some architectures can not DMA above 4 GiB boundary,
limit available memory to memory below 4 GiB boundary.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 lib/Kconfig |  8 ++++++++
 lib/lmb.c   | 20 +++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 77ebc79e1db..29911068a69 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1295,6 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
 	  memory map. Enable this config in such scenarios which allow
 	  architectures and boards to define their own memory map.
 
+config LMB_LIMIT_DMA_BELOW_4G
+	bool
+	depends on LMB
+	default y if ARCH_BCM283X
+	help
+	  Some architectures can not DMA above 4 GiB boundary,
+	  limit available memory to memory below 4 GiB boundary.
+
 config PHANDLE_CHECK_SEQ
 	bool "Enable phandle check while getting sequence number"
 	help
diff --git a/lib/lmb.c b/lib/lmb.c
index 8f12c6ad8e5..a8a988eedc0 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -611,6 +611,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 static void lmb_add_memory(void)
 {
 	int i;
+	phys_addr_t bank_end;
 	phys_size_t size;
 	u64 ram_top = gd->ram_top;
 	struct bd_info *bd = gd->bd;
@@ -625,8 +626,25 @@ static void lmb_add_memory(void)
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		size = bd->bi_dram[i].size;
 
-		if (size)
+		if (size) {
 			lmb_add(bd->bi_dram[i].start, size);
+			if (IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G))
+				continue;
+
+			bank_end = bd->bi_dram[i].start + size;
+
+			/*
+			 * Reserve memory above ram_top as
+			 * no-overwrite so that it cannot be
+			 * allocated
+			 */
+			if (bd->bi_dram[i].start >= ram_top)
+				lmb_reserve(bd->bi_dram[i].start, size,
+					    LMB_NOOVERWRITE);
+			else if (bank_end > ram_top)
+				lmb_reserve(ram_top, bank_end - ram_top,
+					    LMB_NOOVERWRITE);
+		}
 	}
 }
 
-- 
2.53.0

