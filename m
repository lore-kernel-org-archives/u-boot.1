Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4E4C02192
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4ED80077;
	Wed, 29 Jan 2025 18:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jwRwBcPk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TuzbLhgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0F780BA9; Wed, 29 Jan 2025 18:05:41 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84E9C80BA5
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YjpSg1tKKz9sdB;
 Wed, 29 Jan 2025 18:05:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFqHMdWikPuCxotxZdJQH4qlRJohZAHN5J2wuK+5N68=;
 b=jwRwBcPkg3PJjn80pJwnG/w/HVwQwdjbI1JR7yKqGLTfXDKdhXRMzTNFX6XcS+beeEuWzg
 JmOCV0VvqhRTrba6KTa5N5VXY83FUmiKxdY9PIaMl/qdWQIVLdPahrX0vEpYOfn9GjAVu8
 LR+jhUHUTw2cHUYLdikxpONhJ+y5tXjSw3df50gALvPhIr6HEnSKntBDecC790X2zNIeUU
 WsmJme3u9G/i0Wznqc9CJuVO01LPJcpr//OBDzJwlrWjsk3027b3FNkxxAPZYec2dDZXPW
 YPqdd9TA6IyOZOj/SGuZPUtBVFvaFqIKjxx23d3CM5VDp2uer8Sa9Lgtk3h9YQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFqHMdWikPuCxotxZdJQH4qlRJohZAHN5J2wuK+5N68=;
 b=TuzbLhgGaRpFyVdOfMpW+pDnOLmg4XxE+0r8vUobnhJVExEaFJ4tv331SzoW/fvPIEIX/M
 bqtdEcr/LBxBygHsmWEl9ylLQppwXvRxFNAH9oVmRlfghTL2Ke3foHxrSnFCZPAWsdSK18
 ARXJpqyqRAxuCMpTcCYE7UA5em4SWukKv02Tk9kW2PDEo6DPam9xfZuo0nLQ7AtzAgij3s
 J0pVWAyYuDFO/qkgZ+2Nama+oTNLKjpGb+MD3JEJwKbu9ut9aGoxPKXOkwxdF/Empif0eg
 5gv4/JeGfpKXFi8XHcsJiWwBq3A69R7Rd1a7MarrDr6zvhZVuAusHLyk5ZRp4A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/9] ARM: renesas: Drop R8A779A0 V3U Falcon SPL Makefile
 entry
Date: Wed, 29 Jan 2025 18:04:27 +0100
Message-ID: <20250129170514.82118-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
References: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1b7eddc4c27b9c49818
X-MBO-RS-META: b7g6k14a7gsomi1ncspecwjnd6hhp3mc
X-Rspamd-Queue-Id: 4YjpSg1tKKz9sdB
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

The SPL on R-Car V3U Falcon is never built, remove the Makefile entry.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V3: - New patch
---
 board/renesas/falcon/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/renesas/falcon/Makefile b/board/renesas/falcon/Makefile
index 949953f6981..430a842081a 100644
--- a/board/renesas/falcon/Makefile
+++ b/board/renesas/falcon/Makefile
@@ -6,8 +6,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-ifdef CONFIG_XPL_BUILD
-obj-y	:= ../common/gen3-spl.o
-else
+ifndef CONFIG_XPL_BUILD
 obj-y	:= ../common/gen4-common.o ../common/common.o
 endif
-- 
2.45.2

