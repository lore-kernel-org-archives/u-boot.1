Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B479EC8302D
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B9D182F54;
	Mon, 30 Jun 2025 20:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kmPjztZR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e4k4heAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2288B81FFC; Mon, 30 Jun 2025 20:51:53 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD98782ADA
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 20:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bWFcw31L9z9t8S;
 Mon, 30 Jun 2025 20:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=peEt02U5+mTBoqH28mX8hvyTCKjH6vz9a6EDQk3rjm8=;
 b=kmPjztZRhQDarO6u2egCUZyOEjvob6g6Hel6SKJtosBqd3HGSqQyLjfqBGXtvPD55OSU6j
 b11KycvZRAu8kkqI3ZPBIwgXqFfeY54D/Q9bODLh4j4DHEcJGVpSn1rpdw1D8PcrxebLTZ
 CT9NXvyHZFJ9x+wvuDW6/2Y5bIUTlqpCcf+LMNJ3vC1iEU5eBfjCFh639c+GqHy6pqvzDe
 imZNwjI5qMHDH+oWCMmm3+j2UP5chnVXNZz3DnjOqbOSJKhkyN/UJwb6rcjwxbpAUQTnN9
 K6JXjKDFBZX4UzsZAx2YbipRxxksRd4D//L5cBeGSDnClkULnfOam1Xd4Ii3/Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751309502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=peEt02U5+mTBoqH28mX8hvyTCKjH6vz9a6EDQk3rjm8=;
 b=e4k4heAVxcDFc4oohWqeua82NwTBpbdtzcoYR5e3ndKdJUyy+Q4+8RYZq51RSMJvPTCVC7
 oY+Vp+0jcpB0NJLgY+deK61dioB1FNqvSklBZU6hQWlPFV/qz9zHZOOVuzgJVdXEd2topP
 xhjnotuawkuZ0DAjHNbkFxBDhLw3S7PAYwgbPrAOEhkFu8hz7QYP316EjfQRRJWwWMC7c4
 NVYwvHAznLlpvIO064FolNyYCb1Ay0U508AhniL4VyBhUiFAshVa4cab6vbA/Swf/TpKdc
 5yYF9Thnu64lAyeGhhcAdsT9bA35vguAXbYV+nkUSLd15IeLXYQJ4yhKopt38w==
To: u-boot@lists.denx.de
Cc: damm@opensource.se, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/8] net: sh_eth: Convert cache operations to static functions
Date: Mon, 30 Jun 2025 20:51:12 +0200
Message-ID: <20250630185124.1099147-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
References: <20250630185124.1099147-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: t9gaaoqu7m9nucxmnzyxxnjjetcg5hm3
X-MBO-RS-ID: ac840c8ef9253568566
X-Rspamd-Queue-Id: 4bWFcw31L9z9t8S
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

Turn the current cache operation macros into static functions to improve
compiler coverage checking. This does change the driver behavior slightly,
the driver now expects those cache operation functions to be available on
all architectures on which it is used. This should pose no problem, as the
driver is only used on 32bit and 64bit ARM, which both have those operations.
The CFG_SH_ETHER_ALIGNE_SIZE is converted to SH_ETHER_ALIGN_SIZE and defined
as either 64 on ARM or 16 on SH.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/sh_eth.c | 43 ++++++++++++++++++-------------------------
 drivers/net/sh_eth.h | 19 ++++++++-----------
 2 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 9ccba153f36..d372ece8e46 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -33,31 +33,24 @@
 # error "Please define CFG_SH_ETHER_PHY_ADDR"
 #endif
 
-#if defined(CFG_SH_ETHER_CACHE_WRITEBACK) && \
-	!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
-#define flush_cache_wback(addr, len)    \
-		flush_dcache_range((unsigned long)addr, \
-		(unsigned long)(addr + ALIGN(len, CFG_SH_ETHER_ALIGNE_SIZE)))
-#else
-#define flush_cache_wback(...)
-#endif
+static void flush_cache_wback(void *addr, unsigned long len)
+{
+	flush_dcache_range((unsigned long)addr,
+			   (unsigned long)(addr + ALIGN(len, SH_ETHER_ALIGN_SIZE)));
+}
 
-#if defined(CFG_SH_ETHER_CACHE_INVALIDATE) && defined(CONFIG_ARM)
-#define invalidate_cache(addr, len)		\
-	{	\
-		unsigned long line_size = CFG_SH_ETHER_ALIGNE_SIZE;	\
-		unsigned long start, end;	\
-		\
-		start = (unsigned long)addr;	\
-		end = start + len;		\
-		start &= ~(line_size - 1);	\
-		end = ((end + line_size - 1) & ~(line_size - 1));	\
-		\
-		invalidate_dcache_range(start, end);	\
-	}
-#else
-#define invalidate_cache(...)
-#endif
+static void invalidate_cache(void *addr, unsigned long len)
+{
+	unsigned long line_size = SH_ETHER_ALIGN_SIZE;
+	unsigned long start, end;
+
+	start = (unsigned long)addr;
+	end = start + len;
+	start &= ~(line_size - 1);
+	end = (end + line_size - 1) & ~(line_size - 1);
+
+	invalidate_dcache_range(start, end);
+}
 
 #define TIMEOUT_CNT 1000
 
@@ -133,7 +126,7 @@ static int sh_eth_recv_start(struct sh_eth_info *port_info)
 
 static void sh_eth_recv_finish(struct sh_eth_info *port_info)
 {
-	invalidate_cache(ADDR_TO_P2(port_info->rx_desc_cur->rd2), MAX_BUF_SIZE);
+	invalidate_cache((void *)ADDR_TO_P2((uintptr_t)port_info->rx_desc_cur->rd2), MAX_BUF_SIZE);
 
 	/* Make current descriptor available again */
 	if (port_info->rx_desc_cur->rd0 & RD_RDLE)
diff --git a/drivers/net/sh_eth.h b/drivers/net/sh_eth.h
index 6b7f8ae5154..006f12a37b9 100644
--- a/drivers/net/sh_eth.h
+++ b/drivers/net/sh_eth.h
@@ -19,20 +19,17 @@
 
 /* The ethernet controller needs to use physical addresses */
 #define ADDR_TO_PHY(addr)	((uintptr_t)(addr) & ~0xe0000000)
+#define SH_ETHER_ALIGN_SIZE	16
 #elif defined(CONFIG_ARM)
 #ifndef inl
 #define inl	readl
 #define outl	writel
+#define SH_ETHER_ALIGN_SIZE	64
 #endif
 #define ADDR_TO_PHY(addr)	((uintptr_t)(addr))
 #define ADDR_TO_P2(addr)	(addr)
 #endif /* defined(CONFIG_SH) */
 
-/* base padding size is 16 */
-#ifndef CFG_SH_ETHER_ALIGNE_SIZE
-#define CFG_SH_ETHER_ALIGNE_SIZE 16
-#endif
-
 /* Buffers must be big enough to hold the largest ethernet frame. Also, rx
    buffers must be a multiple of 32 bytes */
 #define MAX_BUF_SIZE	(48 * 32)
@@ -44,7 +41,7 @@
 
 /* The size of the tx descriptor is determined by how much padding is used.
    4, 20, or 52 bytes of padding can be used */
-#define TX_DESC_PADDING	(CFG_SH_ETHER_ALIGNE_SIZE - 12)
+#define TX_DESC_PADDING	(SH_ETHER_ALIGN_SIZE - 12)
 
 /* Tx descriptor. We always use 3 bytes of padding */
 struct tx_desc_s {
@@ -59,9 +56,9 @@ struct tx_desc_s {
 
 /* The size of the rx descriptor is determined by how much padding is used.
    4, 20, or 52 bytes of padding can be used */
-#define RX_DESC_PADDING	(CFG_SH_ETHER_ALIGNE_SIZE - 12)
+#define RX_DESC_PADDING	(SH_ETHER_ALIGN_SIZE - 12)
 /* aligned cache line size */
-#define RX_BUF_ALIGNE_SIZE	(CFG_SH_ETHER_ALIGNE_SIZE > 32 ? 64 : 32)
+#define RX_BUF_ALIGNE_SIZE	(SH_ETHER_ALIGN_SIZE > 32 ? 64 : 32)
 
 /* Rx descriptor. We always use 4 bytes of padding */
 struct rx_desc_s {
@@ -380,11 +377,11 @@ enum DMAC_M_BIT {
 #endif
 };
 
-#if CFG_SH_ETHER_ALIGNE_SIZE == 64
+#if SH_ETHER_ALIGN_SIZE == 64
 # define EMDR_DESC EDMR_DL1
-#elif CFG_SH_ETHER_ALIGNE_SIZE == 32
+#elif SH_ETHER_ALIGN_SIZE == 32
 # define EMDR_DESC EDMR_DL0
-#elif CFG_SH_ETHER_ALIGNE_SIZE == 16 /* Default */
+#elif SH_ETHER_ALIGN_SIZE == 16 /* Default */
 # define EMDR_DESC 0
 #endif
 
-- 
2.47.2

