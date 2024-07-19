Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D26C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C365F88C06;
	Fri, 19 Jul 2024 12:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FSxYSipn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lUehhBA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD7B88BE1; Fri, 19 Jul 2024 12:50:43 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D53188BE7
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKW6nq7z9sp5;
 Fri, 19 Jul 2024 12:50:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EuYUw1yquyBDAtNZwGQpTTPZp4j93KTTLlL6a9Ex+R8=;
 b=FSxYSipnbFBNpAJXAk4mMxmYecUM/ICzvYflTT34qaQij9vWsrTu2gxu15OS+Iy7UPDhFB
 SL7KCqDWat8v+weS3nJQ5zM+ZC2Eks/iISoh/Y8nDQUub32BApRl97QSt5txLGStg2607g
 /+7fTsiFoYoq1gy9W4mAh+eHpLD2fVbShKhRk1aK+ttVWjXjpHsZo5YXonU/YYVoIEesER
 8QHaQP1TO7EASll55xtSTw+xUdPQwPVI5W8Z7KeIvkBf47rN1Pgpq8r9/vA/E3rn77ka9y
 2+cne2jWPPlmzfm6pVXhSPNZ5D3M9orKHqLF7lzzSyKu5bLwX7lU+VYHedz8Qg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EuYUw1yquyBDAtNZwGQpTTPZp4j93KTTLlL6a9Ex+R8=;
 b=lUehhBA2DtnSqxVORLcdlER4A55Qc925CJ0kaRs6qFSFZxj/lcy/zY3cEu6jBqtY+qsSzi
 oj8ATk2bTiR5zAYjP1F6tI+XSqRzbUkuz0yFmAPdmpuatFBCqnrR+ZyJs+X3+Kzm6Heffm
 00VY7nSLJf7mk/iDNpy2p0WNlADq5qMuECPGtm7jfngYXJFcUJNjUQQUvXSD46fMQHutbj
 WECzjWD5xmlGJFWyMOodPGUp0DxinoZWGitDW5/J7SnkbpP1J2XcCRlee1NBlM+loKBo2O
 VR+cLfA7kWc3yL0HWMe8YGaQp7KqiZf1LpZiLdsk9qLCEqmwAtRlsFWerozn4g==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 22/37] board: logicpd: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:59 +0200
Message-ID: <20240719104948.323791-22-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5648e49330b81aa6174
X-MBO-RS-META: 9as1gwcbioph77gapejtejzutsk173mm
X-Rspamd-Queue-Id: 4WQRKW6nq7z9sp5
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
 board/logicpd/omap3som/omap3logic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/logicpd/omap3som/omap3logic.h b/board/logicpd/omap3som/omap3logic.h
index ba63aa04c34..55d8f429513 100644
--- a/board/logicpd/omap3som/omap3logic.h
+++ b/board/logicpd/omap3som/omap3logic.h
@@ -19,7 +19,6 @@
 #define NET_LAN92XX_GPMC_CONFIG5	0x00080a0a
 #define NET_LAN92XX_GPMC_CONFIG6	0x03000280
 
-
 const omap3_sysinfo sysinfo = {
 	DDR_DISCRETE,
 	"Logic DM37x/OMAP35x reference board",
-- 
2.43.0

