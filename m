Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955E1C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 13:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D2F80ECC;
	Sun, 16 Mar 2025 14:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wYslSJyv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FmJ8Wni/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 063EC80F4C; Sun, 16 Mar 2025 14:51:04 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B374680C93
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 14:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZFzys45Qqz9tGG;
 Sun, 16 Mar 2025 14:51:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q59R31oKI38J2Ai+tMvsUUt2UFXoqEb6R+F4Zzezwv0=;
 b=wYslSJyvlZUwoUuF5FgBfQaQRme5HzakWbLoLztnma/IcnyUOsDVglhZOMl2ykPHkVH0Og
 D7Ic3CY2mli2zd4GwTzlE0wNvzxGHwwiU4AOZeVolLBwuYhsWHVeJVcgWapPgCvJuoeMPy
 27gJaSbpLGR7sdoieJUSxTl0E1b/FFbV8B5iN70F4DJdaqbXhdwsapXmJx8BelDtknLaxy
 qajVIHJN4BYWgc+KYVRjNQpTzdu9mg3XFxV2ne4LQZi8gzTGLM2CPyzWHSrroOebb6/AoM
 Sf9MS6/nqwmJI0I15f9p7Drj66SYAGoRffXL5YNQEbeROeSBGpYpzqXy/DqMSQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q59R31oKI38J2Ai+tMvsUUt2UFXoqEb6R+F4Zzezwv0=;
 b=FmJ8Wni/T9tOqh1dZB2GF0O8o9CRpuLQ3GmjYlupfroAFLZpa9V7Du8hGcuB161vZGQZsR
 rnylZWrbpm70/eRmkjGLyKNtxnsaE+OJRSwzxoD/G71wKmEf9r3F1nsVu97px4AxjrB1v9
 RLYfjrtiTPHHvhLFStregL4c2IoBlLU5gW6IFW057r3E/4IUT9Nz0wPTAcixYqq7wiXeY4
 MMtlLcjeZ2ZbK7C0Qzo3a1J8Zc4HXqg12RQeyvLgXyMwCtU/XxR0l6XjRVb+T8ZY9XGHn8
 1X7rNzJ3V0XU/W52AUgGU8F3u8TYLBn110PH64pwNZJCK7F4IYQ7/p2BW2rLKg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: renesas: Drop stale common Makefile description
Date: Sun, 16 Mar 2025 14:50:41 +0100
Message-ID: <20250316135046.7843-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j3nk7ixjerk6qnf48ojf5i3i7dnruxom
X-MBO-RS-ID: 3c343d4b69c58f54f66
X-Rspamd-Queue-Id: 4ZFzys45Qqz9tGG
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

Remove stale Makefile description, this used to be valid for the
original Makefile from which the common Makefile was made generic,
but is no longer applicable to the common Makefile.

Fixes: c7d2d7f90a91 ("ARM: renesas: Simplify board Makefiles")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/common/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
index 347be5cc93c..5e51b691178 100644
--- a/board/renesas/common/Makefile
+++ b/board/renesas/common/Makefile
@@ -1,6 +1,4 @@
 #
-# board/renesas/whitehawk/Makefile
-#
 # Copyright (C) 2024 Marek Vasut <marek.vasut+renesas@mailbox.org>
 #
 # SPDX-License-Identifier: GPL-2.0+
-- 
2.47.2

