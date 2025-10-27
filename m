Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB92CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C928C838AB;
	Mon, 27 Oct 2025 17:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t4ZrmNPr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="av2KQBHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A878A83930; Mon, 27 Oct 2025 17:46:59 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B91D1838AB
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwKD03vVlz9ssB;
 Mon, 27 Oct 2025 17:46:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+JcMvQuV0JxDc9q+zIungfIEsUdmnU/h18JM97AUfY=;
 b=t4ZrmNPrrNoeOURC8jnEZS1b9gjkOAkPwFkTUPNUQ53PswwReuMHNRYhV8Z3GWgUPxxCJI
 xYsW8mUP/tGht995+Zsv/tG8++wfS+HkRXPQxQbCBNpiJEfN06KAY3MviEfolmchH1QedT
 FW/6aSrMwu0SQ/YszGdFOfTop0M2L14nv5yX5u1u2NJeDwc06jK2HSS0ipnc89yqjOK2XP
 NM/CdFl3mhnGBtqTD3WD2IXamD6cAS+hZSsmSxQ0dWcKvW9fhNLq+lDlkPEl9lx1D8+2cl
 mxdRozJqxcdCJ4jHKUccwTt6C6eGJX5tK4eOYkLjuVMR2xyYP5rOlMaCJ6QTKg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+JcMvQuV0JxDc9q+zIungfIEsUdmnU/h18JM97AUfY=;
 b=av2KQBHYfa8FsX/kqCrzWQO45srPyUJMPbTOeg/4ToyFT2XfeTLoNipr/zhh7hqkHfuz70
 B8IMqD4Y3MpGd0z+uJCQw/BUeKt6CLAF+lLQXVFhBQw3C9sZktLERaikFVJUdtxfR/XBOG
 epoA6jBHZu3Ib1zepFZJKwumOrUAWYZobZv8DXzL8EkiRl1hGGLh6YHmTiIhCN59IDjSBE
 zzEW2U+GK9nLL9bUwYcbKK7pcwC0TDO8W3dJpYmfXW3GUgz+6av3SmxesZWJTSXrssRPZg
 S0qJOkGKNCpBIahfsdaEQy8vel4SFmpXeNCT39N5iaOujzzL3aWkgbB/hRi5FQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/12] net: rswitch: Drop unused macros
Date: Mon, 27 Oct 2025 17:45:32 +0100
Message-ID: <20251027164643.12443-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3c627b5197f14cfd0b1
X-MBO-RS-META: wrtrunp4p1od6adybtkgnradmcphtiqi
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

Remove macros which are not used in the driver. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 5f8e95d4d64..3f9052e0a89 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -27,9 +27,6 @@
 #define RSWITCH_SLEEP_US	1000
 #define RSWITCH_TIMEOUT_US	1000000
 
-#define RSWITCH_NUM_HW		5
-
-#define ETHA_TO_GWCA(i)		((i) % 2)
 #define GWCA_TO_HW_INDEX(i)	((i) + 3)
 #define HW_INDEX_TO_GWCA(i)	((i) - 3)
 
@@ -207,11 +204,6 @@ struct rswitch_gwca {
 	int			num_chain;
 };
 
-/* Setting value */
-#define LINK_SPEED_100		100
-#define LINK_SPEED_1000		1000
-#define LINK_SPEED_2500		2500
-
 /* Decriptor */
 #define RSWITCH_NUM_BASE_DESC		2
 #define RSWITCH_TX_CHAIN_INDEX		0
-- 
2.51.0

