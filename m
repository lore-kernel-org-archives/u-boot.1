Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A3EC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F8988868;
	Sat, 13 Jul 2024 15:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WHFPW5Ut";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jIGlNURX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878CC887E3; Sat, 13 Jul 2024 15:21:22 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20B888855
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpy82P8Bz9sTd;
 Sat, 13 Jul 2024 15:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJkhoHQVFfc03jBM7zbecF703jq91UXrYe9IaLc2/p8=;
 b=WHFPW5UtMF4fdrC3fXXcCsOLt5kcJSXG8zevECvbXW5zr8sC+piIxsdSczAyJ0tYX2Bnw6
 6nRPnwDsKBLywhQ889LR9U3XcdOGeMgVE+GiXT04qjUrt6oL/S1OuCWBFjhmEOTQNPssKA
 NfVngRKg/GyMweaTmGE+FRYI83zntoUt9IzyYf88nL6dKdtx/ixb9id2BzzWV7EfEHJiF8
 wsHTzLQeM1HeX9gBsNochStnOSkB4W4PbJb8NbHn8kgrvhGgn3YKHtCkW0rw05IA/Dh3eu
 c6FV6jE63NM56GnCVxgVxAVDEjltIHu0hWNu5cm8UdrqmgvkCAN9Il2V/++sYw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJkhoHQVFfc03jBM7zbecF703jq91UXrYe9IaLc2/p8=;
 b=jIGlNURXLGrOq8ffbbHeNkB/Mhst0BMDatPvK7ywnIehgc1VSedhYHoxEiEvWC11h+qMsB
 L7+qKhM46P1UCdiofAn5POTfSGnPXZmSH2L7s0xxvAm4BEMFi+Qigp+Hu3cv3/l/JMvc/8
 bG35s3ck/gU7ZtER6+YMWZV/5sLEXfAOHlJuweIi1/1ZIxEVLyVSc68OIKa4uHC9f51FSd
 jIbGJD3oIoQeenrP+XORGIm3fk5nm7PZgBtzBTQNHT7CSEwQdtHA7u5aUFGDA0W67bde/i
 rhYZCNXyq+3AtHyPQEj43igjJhmlsnlf4iXWTBd0Xn9sgTvwqQC7sEM/Q+RFsw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/45] arm: include: tegra: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:04 +0200
Message-ID: <20240713132021.57650-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 917739ce4ea3b1b97fa
X-MBO-RS-META: 3cwgyyzh8su454uruq7w9jn8a7kt3ff5
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/arch-tegra/bpmp_abi.h | 3 ---
 arch/arm/include/asm/arch-tegra/clock.h    | 1 -
 arch/arm/include/asm/arch-tegra/warmboot.h | 1 -
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra/bpmp_abi.h b/arch/arm/include/asm/arch-tegra/bpmp_abi.h
index 373da526ed6..924361bab8d 100644
--- a/arch/arm/include/asm/arch-tegra/bpmp_abi.h
+++ b/arch/arm/include/asm/arch-tegra/bpmp_abi.h
@@ -29,7 +29,6 @@
  * @file
  */
 
-
 /**
  * @defgroup MRQ MRQ Messages
  * @brief Messages sent to/from BPMP via IPC
@@ -167,7 +166,6 @@ struct mrq_response {
  * @}
  */
 
-
 /**
  * @ingroup MRQ_Codes
  * @def MRQ_PING
@@ -616,7 +614,6 @@ struct mrq_debugfs_response {
 #define DEBUGFS_S_IWUSR	(1 << 7)
 /** @} */
 
-
 /**
  * @ingroup MRQ_Codes
  * @def MRQ_RESET
diff --git a/arch/arm/include/asm/arch-tegra/clock.h b/arch/arm/include/asm/arch-tegra/clock.h
index 61ef81e7fe4..2957b97e6a5 100644
--- a/arch/arm/include/asm/arch-tegra/clock.h
+++ b/arch/arm/include/asm/arch-tegra/clock.h
@@ -130,7 +130,6 @@ void reset_periph(enum periph_id periph_id, int us_delay);
  */
 void reset_set_enable(enum periph_id periph_id, int enable);
 
-
 /* CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET/CLR_0 */
 enum crc_reset_id {
 	/* Things we can hold in reset for each CPU */
diff --git a/arch/arm/include/asm/arch-tegra/warmboot.h b/arch/arm/include/asm/arch-tegra/warmboot.h
index bfde4c30ac0..9a53456370f 100644
--- a/arch/arm/include/asm/arch-tegra/warmboot.h
+++ b/arch/arm/include/asm/arch-tegra/warmboot.h
@@ -117,7 +117,6 @@ union scratch3_reg {
 	u32 word;
 };
 
-
 /**
  * Save warmboot memory settings for a later resume
  *
-- 
2.43.0

