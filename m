Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE019C02192
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D02880A37;
	Wed, 29 Jan 2025 18:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nkHGnmUc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BV7tnanJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FA580017; Wed, 29 Jan 2025 18:05:52 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B6CC80C8A
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YjpSs74H0z9sdB;
 Wed, 29 Jan 2025 18:05:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QaFiWguPUV3/ScU4En/HP/dvZirZd1e3Ml0edrjxNZ0=;
 b=nkHGnmUcfbhQOEyj1iRnTz6f6dApUXtq7yyfSqfBh9now0QDREmYRADcFxIVGlAQDM/Fgg
 BKCiXVlsgq5hBWpdOgu7ZSsVDf5kdhk01JeUORxZJ7xesk0EiWgFNxt++z0XiKmZNw+IL2
 tQ6IHHva1c6bHwnLqp1wHSqQolUSfRewnwaNDvN0ymIt/31PeTT1ZhMRNgSGaUCBhItTAe
 7fSvrnb5UuHohWTLILLTkVnwu7W75qS+k8u/vhJWfmf8838Q6r3sFbxvdSqYGxxcTXknxL
 /FsRVsvMmIPLhc0oy2FIdqhI3I0bmBC5/psPPmWYat4g2tvjHBTaGmyFjsskFA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QaFiWguPUV3/ScU4En/HP/dvZirZd1e3Ml0edrjxNZ0=;
 b=BV7tnanJ6Cn11BHAI+E3lDn0R+9rQOj5NyZhsbdJMRBzDhlT848FNtPw77yDc44tq54H7L
 IRZOJVhVOnJux9k0p23WEgZZsqaATk7tTJTKPpgSVCKdlNH6TrKLoulR6U/rCCBIP6NeBB
 iztyltfC2TWckos5iCnoX0ql5uqwLWPDnaEccg9r6xYkVYRy032hLTl8OZwzGmUDHqKZvn
 9SzwX0STo5SKYt1CwbSLSE4q713pu+6rSEo/I6duuc6KzSGnOxcf92BNRy9ZuGJxJL85D6
 gDv0ftUhWNl/FZ1ut7/Ob5Tn5HlsoylV29EWxOaw9EA0dAkujjRpQOZY8/zvxQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Adam Ford <aford173@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 8/9] arm64: renesas: Deduplicate board_early_init_f()
Date: Wed, 29 Jan 2025 18:04:33 +0100
Message-ID: <20250129170514.82118-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
References: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 65wod68f196oyzma7a6npf8uc3yc3bwk
X-MBO-RS-ID: 17e37659578f024b726
X-Rspamd-Queue-Id: 4YjpSs74H0z9sdB
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

Introduce common weak board_early_init_f() in rcar64-common.c
which is the default implementation in case there is no other
board specific board_early_init_f(). Remove board_early_init_f()
from Salvator-X, ULCB and Draak boards where this function is
empty.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
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
V2: No change
V3: - Add RB from Quentin
---
 board/renesas/common/rcar64-common.c  | 5 +++++
 board/renesas/draak/draak.c           | 5 -----
 board/renesas/salvator-x/salvator-x.c | 5 -----
 board/renesas/ulcb/ulcb.c             | 5 -----
 4 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/board/renesas/common/rcar64-common.c b/board/renesas/common/rcar64-common.c
index 74ec0a46e6f..69229ea3cb0 100644
--- a/board/renesas/common/rcar64-common.c
+++ b/board/renesas/common/rcar64-common.c
@@ -65,3 +65,8 @@ int __weak board_init(void)
 {
 	return 0;
 }
+
+int __weak board_early_init_f(void)
+{
+	return 0;
+}
diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
index 85213497ce4..564cf439aa6 100644
--- a/board/renesas/draak/draak.c
+++ b/board/renesas/draak/draak.c
@@ -10,11 +10,6 @@
 #include <asm/arch/rcar-mstp.h>
 #include <asm/arch/renesas.h>
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 #define HSUSB_MSTP704		BIT(4)	/* HSUSB */
 
 /* HSUSB block registers */
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index 60f8b94e54a..6d33d005b4c 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -12,11 +12,6 @@
 #include <asm/arch/renesas.h>
 #include <init.h>
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 #define HSUSB_MSTP704		BIT(4)	/* HSUSB */
 
 /* HSUSB block registers */
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index 3f6db0ec3fa..d02e5d0bfc5 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -13,11 +13,6 @@
 
 #define HSUSB_MSTP704		BIT(4)	/* HSUSB */
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 /* HSUSB block registers */
 #define HSUSB_REG_LPSTS			0xE6590102
 #define HSUSB_REG_LPSTS_SUSPM_NORMAL	BIT(14)
-- 
2.45.2

