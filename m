Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56958C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528DF88C05;
	Fri, 19 Jul 2024 12:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UGdM2mRJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K/zD/VWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0EE288C0B; Fri, 19 Jul 2024 12:50:45 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2521E88BFC
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQRKb6FbCz9sPv;
 Fri, 19 Jul 2024 12:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwSxnjhZAqVd5lJ11dHVgdp+UP66yMzM8s+2KvlaB2E=;
 b=UGdM2mRJKQPtIjifU4v/kusJ+aIT6Ujy+0aoCCTuaIvq8TGr/gJur4Cy3DUeAuSRT1PiOn
 EG1SppYwR5mS8VPbHOuIyp36GRlP3jIZi1u7zD7Jv6iKK/X7eylLvlw64PFEsiOjOqbLjM
 gSHzcd/PZ/auiTbz1rti5AR/3me/vAgpUVB+0u4XKzxskDYCCtxoysKZMoKW8QTkLhDKY0
 kcAySETa/xYrVEUmzdicagzdXjiPH2qbYYLPouY4KPpwiF1xHZSdKwGkOVMypn+LskgDIA
 tCpBX9iZAt8bJ+5SNuFyU+pfkJcpLTCKVSle48oi90lzX+GAomIQdLAvVz8ZUg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwSxnjhZAqVd5lJ11dHVgdp+UP66yMzM8s+2KvlaB2E=;
 b=K/zD/VWbBSHRreDtPKPJqSE/vdNfj3kJ9Nn8+F/dcwSgcgvdsKOGAuUV+XEz+Vv6r95gAo
 G22+n8CU6wqPgawB23pY0m7qK1lWmOSK0XH/w9bIx5aKiPVCRdWkhwCRyEAwquJz0tWTOK
 i4Isq/HoHziZROy1Ur6JZLiP4V/5fakGNnfnPIAWmeOSjS5f/Atw5+1OvwsI6zqD69zqww
 LomkW0pTaLzK4syoLIqKlFidxBUm9sHtCFEJHsmkHDCEd1pAUcWQ+h99Y3rhvt66xWUmBe
 +crYAAvSV4oVAnxN2Tib71NKplCbW8nTMBdPMF+CxnDSa1rQW/GSPSKFv/zEMg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 26/37] board: siemens: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:03 +0200
Message-ID: <20240719104948.323791-26-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6yw4zpi67qtjooc14jxxwatksdqkgz9i
X-MBO-RS-ID: 39d41613235bbdedd55
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
 board/siemens/common/board_am335x.c | 1 -
 board/siemens/pxm2/pmic.h           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/siemens/common/board_am335x.c b/board/siemens/common/board_am335x.c
index 445af9ddbf6..2a727606bc3 100644
--- a/board/siemens/common/board_am335x.c
+++ b/board/siemens/common/board_am335x.c
@@ -22,7 +22,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-
 #ifdef CONFIG_SPL_BUILD
 void set_uart_mux_conf(void)
 {
diff --git a/board/siemens/pxm2/pmic.h b/board/siemens/pxm2/pmic.h
index f4ce7f16b29..6990fd7ce87 100644
--- a/board/siemens/pxm2/pmic.h
+++ b/board/siemens/pxm2/pmic.h
@@ -50,7 +50,6 @@
 #define PMIC_REG_ST_OFF_1		(0x2)
 #define PMIC_REG_ST_ON_LOW_POW		(0x3)
 
-
 /* VDD2 & VDD1 voltage selection register. (VDD2_OP_REG & VDD1_OP_REG) */
 #define PMIC_OP_REG_SEL				(0x7F)
 
-- 
2.43.0

