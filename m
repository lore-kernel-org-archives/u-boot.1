Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4D5CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C16783A48;
	Wed, 19 Nov 2025 00:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WrgAjiVL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ADjX+mqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C953783A5A; Wed, 19 Nov 2025 00:17:39 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E610383A48
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dB0rd4zNcz9t3Y;
 Wed, 19 Nov 2025 00:17:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763507857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yiVi0rh36drxwi21hFZJAr0KONLvnhhDTwyyQWZELSM=;
 b=WrgAjiVLvzbPZzdzk3afwxMIXdWeovIl72fJOe9bNOIVLvGRpO20/d3L5mAHuSm2IFvleP
 BRA+GacIDyzOCua1SbDBn9aL+cJkVnPICJ1YYJpRUbMXTZQyBf6q+g3VDClDT/tGLgTDs5
 nB7l/NwOq4cKNtTjyjkWSp4jBVZimpTBd1ulnUGLvrGvqER5UIodqApT2z1j/hIdmToBOQ
 Tqsx676X6eE1bcHP5VtjzOx7j5a+9ToKL84xJV9xcAp6Q8NlQR6POs0dHIYLKEu75/nP5b
 eqPMpqhSboKLQz6Jw8njJ76PzKcdMkoHkrnR6noT9zaupHuHlqjjoRZiUVZt3A==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763507855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yiVi0rh36drxwi21hFZJAr0KONLvnhhDTwyyQWZELSM=;
 b=ADjX+mqRd1iHfKmgyOc19ehS93MikhO5LMcZwUTNp8acSQE5EPfRVCCUu9kl7EMrJD+XQF
 SRS0bdU30eDLCERchMpp2L3RkxfPOY/+tpNqQxRsd6Yb8d5gyD954ETCOYJbJ19cBDGFBB
 UWTRJnsjPIEM2biTBepgD5F44z4TzW5mcUow3VLPhyV4JgYLjW/f50G0KlOtw9g0S60b+t
 ZKF1peYBZTyWz9cnzyX5r9oFjClIuGFyCPH1SlP5xop3YqoZTov23KmWiKo2HZ5+EhziCC
 06XGBKj6wME4nXHdCs06Yrf8KOwc4YLIoxXGZFKS0PdQz6KvE36exqoLKjAcfw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Add missing build of debug UART init code on DH
 STM32MP1 DHSOM
Date: Wed, 19 Nov 2025 00:17:23 +0100
Message-ID: <20251118231732.577952-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0de87997018ed30639e
X-MBO-RS-META: axxofmqsssdzjpzwdup3xusxz4yrcs5p
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

Commit c37a6684818d ("stm32mp: fix compilation issue with DEBUG_UART")
split the debug UART initialization code into two files, but failed to
update other non-ST boards. This did not lead to noticeable breakage
until debug UART is enabled, which is not the default. Update the
Makefile accordingly to allow debug UART to work.

Fixes: c37a6684818d ("stm32mp: fix compilation issue with DEBUG_UART")
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 board/dhelectronics/dh_stm32mp1/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/dhelectronics/dh_stm32mp1/Makefile b/board/dhelectronics/dh_stm32mp1/Makefile
index 2f4a301d1a0..429e01453bb 100644
--- a/board/dhelectronics/dh_stm32mp1/Makefile
+++ b/board/dhelectronics/dh_stm32mp1/Makefile
@@ -3,6 +3,8 @@
 # Copyright (C) 2018, STMicroelectronics - All Rights Reserved
 #
 
+obj-$(CONFIG_DEBUG_UART_BOARD_INIT) += ../../st/stm32mp1/debug_uart.o
+
 obj-$(CONFIG_PMIC_STPMIC1) += ../../st/common/stpmic1.o
 obj-y += board.o
 
-- 
2.51.0

