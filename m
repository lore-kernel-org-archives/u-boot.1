Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEF2E77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3C6806E6;
	Sun, 12 Jan 2025 23:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CMY1tFRi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t8+IAJz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A88D80628; Sun, 12 Jan 2025 23:36:05 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE768058A
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YWVbk4QQVz9sbW;
 Sun, 12 Jan 2025 23:36:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iI7/ij/w4BbnZe4BiGLpTRfnHHj7GI/2ShsyarQMsLQ=;
 b=CMY1tFRiUgLSlWVNfarYR8AIYqaNs6o23vpQwi2cOMzvvCraIomxyE2bzpoehJ6ZL5MYvx
 JZmVFZToj2724/wJ8+DepEiNHnsVqWeXDaKXZvvXDdGoRDeDL4KWqG4TDLZcgf9XiITuNl
 +x1Sn6xGUOdmmXvTC4c210p4IXoYWJAcGogu7Xl2E9OTW1qcV7zUenzDItb/3nHoweV3j8
 Pg/HhuDSUVXD1RCEAAu7+BbDQyg+DUYr+BpNvKRJT4bkSXqfl6jSqO5ZP20fsNLoxXvpHn
 c8iOnrzC6B4wA3rm8GAvff/1iWi8hyeYMDqYiVPbPDEmM3en51pQ4WSfLK3Fhw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iI7/ij/w4BbnZe4BiGLpTRfnHHj7GI/2ShsyarQMsLQ=;
 b=t8+IAJz+T9HF37UW5jpcoUfXBOGblpSBQQ9oTp7/TltgS2csbeuZrvK2n63B9exss86lrT
 YYyLgcpq5+K3Ed4lyvmdO9aN2yIKn4rYsH07DAa6rbbZSGFshEf1nISPANaQotiYfQIBxk
 32gCY/OuAc5zO07JWmV3+xVFU6iFCpZn55s0zBywACOf+v2ghBYhmdShXramb1RgKebwHd
 zeB5WZdRb8Cj9ahZ48AQapziNPNoIUn0dCGgqX3164gVdDfnvEo6cYLxlMX+Ajdj18Tk6e
 x+x7IHNVXLIMwAE/ADOtF8WglUHqbYH3mOZ2hkxbxX/cXfg4U3hNvRXECj/bYw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/8] arm64: renesas: Deduplicate board_early_init_f()
Date: Sun, 12 Jan 2025 23:34:26 +0100
Message-ID: <20250112223528.179828-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
References: <20250112223528.179828-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8457680fa6a40f113fe
X-MBO-RS-META: ecmck1yoo3kcfygfmzwi46rhnwshckxp
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
index a8c40ff1f07..6caa63d553f 100644
--- a/board/renesas/draak/draak.c
+++ b/board/renesas/draak/draak.c
@@ -12,11 +12,6 @@
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
index abb17c3fdc5..9bfcf0d66ad 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -14,11 +14,6 @@
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
index a441ff0e0d8..bd06db23b16 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -15,11 +15,6 @@
 
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

