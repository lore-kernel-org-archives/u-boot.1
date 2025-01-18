Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1DEC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 11:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B5B380756;
	Sat, 18 Jan 2025 12:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NcQY78y7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Fl+9xgoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E208C80312; Sat, 18 Jan 2025 12:17:06 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CBCF80763
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZvFT5fWbz9sTd;
 Sat, 18 Jan 2025 12:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIKwxULt38kRMhWgoA5uYWiXPmO9HQpY6kLGFrwGbDw=;
 b=NcQY78y7QnKKXheCn/PXAfaykZEBY83TAk7M1/VxS9nh9PA3t5zsx2nVrEMIAApIlSWZdn
 vZOJ/YqXT3OhduPezoWbUcTfmX/5Xv4D0fkDMBf0SCt73Pwg2Q6PaCAHXXChwUYWLXCFdI
 RhkIDdzC2vMqDkrgCid+saD9cVHos7Iu/gGQi9YdpW2+qMvwQ2CilSu91spZAWio0HpwkU
 AImmGpHikM419bG/I93Ft1Iww5Vn66cWvoJo4+CQo8fDHrUHchTJYDLzn1Dj6DUw8OEU4R
 GwgNWeYGuqUItAXuQcwUopZDecwcIaF4Iknz8FQQcIZF7i1RsA8L1rV5Y2SelA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIKwxULt38kRMhWgoA5uYWiXPmO9HQpY6kLGFrwGbDw=;
 b=Fl+9xgoAMrrHxkrQmDmFZFfPRAXGcobyjSPksuuPsdXnAPFdpEg50CRgBYx/M5UpE9Ggaf
 sYv/3wlHKvCY/V+PS2W2jPUEbxx4wHmGwOnO/kTEayyNt47Y5+xHGk+R1m2Ynr5eOG7/v8
 eKje+7EGHGvXB0d09q9cdfjf4BEOpfSBfVww/AWNBtCfa+z20XbvFs5TRayS3RMGwa24m/
 /nXN6iTxrsas75/T/OhSZn4uDPpgwz1swNw8TOqP7nBpITTKPqvA3aQgjkXL7EmkEshOMw
 uBJbQ3dy8vFDcW44kNONm+4d66xwU/eNERdsH41W8HmN6Y+OsGR885WkATrtwg==
To: u-boot@lists.denx.de
Cc: quentin.schulz@cherry.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/8] arm64: renesas: Deduplicate board_early_init_f()
Date: Sat, 18 Jan 2025 12:15:30 +0100
Message-ID: <20250118111621.362188-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6j7esxb4ipctwk515ocrjqmij3dww1fk
X-MBO-RS-ID: d33c742925313eb997a
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
V2: No change
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

