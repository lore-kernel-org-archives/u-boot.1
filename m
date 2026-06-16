Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C734DCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 23:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02CAE849A9;
	Wed, 17 Jun 2026 01:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="e9WsqLJv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UxOlALye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 479EE849A3; Wed, 17 Jun 2026 01:20:21 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B05849A9
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 01:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gg2yp5d5sz9tHp;
 Wed, 17 Jun 2026 01:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENlhBt3QjqsKo+uYmH7s+NaIlKEcnkkz1avmrReT9Rk=;
 b=e9WsqLJvSp6Yyrmq7weRZ7qYC9J7FmuL1W6gJg8twVFG7TZlqCauzKXgD1yiP1J8fhBkmQ
 FrsmKILSOpvXWydwUtgo07EUFma2lVM9jmAPpKtoPemHfNsi9y+G4POIRXDoWrqoH5sXbq
 sfK8YT9+LBuWKMC/7hrjYa88KQmE/68nSFhUJDNinGbSEbir52+l42+dL0aNTHAsp5KmhY
 6M2h9d1msj3EBWuiO7zbyY98GR5PFaTAESwzT6AUdNPLyueG0eYaGz7yE0QxRztW8Hug6n
 X5E8agZG6ThQeH5MGYgGvimRJPPvhQwqJH8/lYJOJ58Q9D+XRDqx5qAEwV4QNA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=UxOlALye;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781652017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENlhBt3QjqsKo+uYmH7s+NaIlKEcnkkz1avmrReT9Rk=;
 b=UxOlALyeD6woj42k9YY4h55BoRyU2lv2hg1CIUuIkAB0XEIKkb1VHXoKtPnl8HoYiUnGaU
 iarZPV9U6wQX/fuuu1RwbfwT2jJYgE/q6+Yo46ZRK5ooqMflbJ8D08o+D4R9Z6vD/1FaNG
 3Rq9DIklsk5/IbFxb3tqfjI3vDbazl6YHnkSgszcO9naKwYaW1JfS4MSumqU4r10ih5iAL
 /ziQUmF68qsPc8JcE2qRGW5moijJUZmn0v/UVjrMPeZG4T3l276fdJi3+OgEjZbXSF6Y62
 QrtC7OXWY1QIgiDV+du8T/vIuOoy2BZhQpa7iM0ligrvtvLYx44KvZ6Hw4NKuw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/11] doc: board: renesas: Update Renesas generic build
 section
Date: Wed, 17 Jun 2026 01:18:51 +0200
Message-ID: <20260616231933.44392-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
References: <20260616231933.44392-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 81dc6803a75b07c2bb1
X-MBO-RS-META: ptmxsjq4db9nbtpcmc4g1j16t6ptibnj
X-Rspamd-Queue-Id: 4gg2yp5d5sz9tHp
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

Update the Build section and note that it is only applicable
in case the table above does not contain any board specific
instructions. Include information that the Architecture column
now contains toolchain setup instruction links.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/renesas.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index ef04a4478e1..41272c6e32a 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -264,11 +264,18 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - :doc:`arm <build-env-aarch32>`
      - rzn1_snarc_defconfig
 
-Build
------
+Generic build procedure
+-----------------------
 
-Locate the appropriate defconfig in the table above. Then apply standard build
-procedure::
+This procedure applies only unless the ``Board`` column in
+the table above does not contain a link to board specific
+details.
+
+Locate the appropriate defconfig in the table above.
+Follow toolchain setup procedure in ``Architecture`` column.
+Finally, apply standard build procedure:
+
+.. code-block:: console
 
     make <board_defconfig>
     make
-- 
2.53.0

