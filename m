Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C8BC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 13:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9F9582B53;
	Sun, 25 May 2025 15:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JiLeHUvk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nPvI/y1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1CC082B6B; Sun, 25 May 2025 15:43:28 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F90B82B37
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 15:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4b50Tn5fjvz9slL;
 Sun, 25 May 2025 15:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1748180605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0nVpcQxWDYtB3cro5lEzQg5wKONnFENXPoAtjuUJpLU=;
 b=JiLeHUvkx0FmWgjFaj9UYotT66ZNolxl3DZeo/m6NDxgK67kdqCdLpUlhH8GUPGMKzJ1iS
 BnpANT2ldc9CaNFhp6vo8N+l5qASbM8aeAHRg1a0xUZt9NrksuauqMxMKATv4tV4VaE1L+
 g/V+ufFJ4etAgbkmILSq6oUatnRz8EE7EwNLrA0Zabkp5ii4n4mg4I6c3WgbrQb6dF3KLm
 CW/h6dwz+h4BlC/pI5TlRbSnS7sGPrrEuWqjvJGpxjgrEj0xxGFX4+i4rt3UoiLnz8JwFH
 D05DpXPYcgvfVe44HqmTSo2fFNqn1ztqVqSEe67BUyfKopzXgoExbhG6ZKa3+w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1748180603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0nVpcQxWDYtB3cro5lEzQg5wKONnFENXPoAtjuUJpLU=;
 b=nPvI/y1y6KJTBNcP02izsZ1Y9J00q4M93stBCuX8bUzPuNABYYbMyMqD+3oeqo+EcL4MKW
 kH6pEBBF3riMeXWyriPji96cG5regyoEHxlc22FfgsIfQMlsN8yWfiaTQfXWlFHZ4CuS0I
 JBvQ7bElv9j2MY9xwJwRMmhx32BBB9cappkzqTAnANviS1RPnl4DlcWze+/B1ey53JHdNj
 rd46XVZ1FYdsUIRQKci85sevYFxbEVu5K1beBcGXU1ywqkAjsMaVibPPFTcdQ67b8edDNI
 +9q2eD3ZE4K0/IIO7Sbl1MBIP1tjADgVt0Q316YAzGxZ88o/gTzXJbVikI0c1g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Paul Barker <paul@pbarker.dev>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: rzg2l: Update MAINTAINERS file
Date: Sun, 25 May 2025 15:42:51 +0200
Message-ID: <20250525134301.35091-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f3f00368f8135c73444
X-MBO-RS-META: qg6gq3be5jsizbpr3ayxq3woy9r45dsc
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

Un-orphan the RZ/G2L , keep the RZ/G2L maintained.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul@pbarker.dev>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/rzg2l/MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/renesas/rzg2l/MAINTAINERS b/board/renesas/rzg2l/MAINTAINERS
index b3547e39e77..b5375daad6e 100644
--- a/board/renesas/rzg2l/MAINTAINERS
+++ b/board/renesas/rzg2l/MAINTAINERS
@@ -1,6 +1,7 @@
 RENESAS RZG2L BOARD FAMILY
+M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 R:	Paul Barker <paul@pbarker.dev>
-S:	Orphan
+S:	Maintained
 N:	rz-smarc
 N:	rzg2l
 N:	r9a07g044
-- 
2.47.2

