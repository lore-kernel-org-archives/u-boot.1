Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED88C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AB1288B93;
	Fri, 19 Jul 2024 12:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QGWPK7Jz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rUIsvyns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3547C88B86; Fri, 19 Jul 2024 12:30:19 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6059E887CE
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WQQt11Xjyz9skw;
 Fri, 19 Jul 2024 12:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1q5MceQJx7LXD1S7ouGvCHzt954GN4KJntaZ7BwkcXo=;
 b=QGWPK7JzvxWw9TPfd6jgln+7Vtbu00U4Fbvln3PyVCTuQIy2RZLE8jLhm1NqIMRVKI2TAE
 63BemwOIwdxGl4wcmRKjktNl5KvSURajPIGZ6qR0UE94MakxM21MBHTN3GJsk9Oew3pZ7J
 r/62ry9rx7VgvaraNwZlcmu3dqtWaQuSeOC4D7yxPOTpmdMFcd3vuj2seAXQerEj8ODBXW
 ss+caIsbUL3Unsfr8h7B77RnK3NnspHgQoYyFtKIjXpBVSd1sM1EgiAY1sGDD5Y9ycNb9M
 WUIV/g9OzWRnrInsa8Sf3c8yaARYNCp+rC06s4YJAViCLKbappfBd7tWUn1SEw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1q5MceQJx7LXD1S7ouGvCHzt954GN4KJntaZ7BwkcXo=;
 b=rUIsvynsp3L3XI7kk1D0FxjuANfLbpag1zPxy+9GOmkp1jYPnWqOIRMWEVzWLro82XSnVd
 BR/b7FJePl5PGmrIDogJpugAexdG0auToaVp+6rwwMgKXb8b7IOYXkRbGvygqr3hBTfnEm
 jSvvGFd3QX2alX+5fiEL4Ha2DGBSqK6n8fCAlvATLaIifPZ7y5jk0Fh2CoJLJnzjsRZiBo
 kKVs0K/22MQWBFO9Bnp8A7RS8E2bgDgeUIQ4YOn5spVdwywuTaltcCZbDyOVCmEocPtpvk
 VKf4GX1yqR2zEJ9v1wONOPFD1sbuhzfRjF5vKBRwEt90RfzbfLtywbE+/cXecw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 05/37] board: armltd: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:27:59 +0200
Message-ID: <20240719102934.322997-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5480c7c30d5eeab8f78
X-MBO-RS-META: iqxa75yxdoybpx16tyt7cnr6o1co4y7b
X-Rspamd-Queue-Id: 4WQQt11Xjyz9skw
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
 board/armltd/vexpress64/pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/armltd/vexpress64/pcie.c b/board/armltd/vexpress64/pcie.c
index 1045c905f73..301d95e44fa 100644
--- a/board/armltd/vexpress64/pcie.c
+++ b/board/armltd/vexpress64/pcie.c
@@ -109,7 +109,6 @@ static void xr3pci_setup_atr(void)
 			     XR3_PCI_MEMSPACE64_SIZE,
 			     XR3PCI_ATR_TRSLID_AXIMEMORY);
 
-
 	/* setup CPU to PCIe address translation table */
 	base = XR3_CONFIG_BASE + XR3PCI_ATR_AXI4_SLV0;
 
-- 
2.43.0

