Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7E2C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 13:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ECDC830E4;
	Mon,  7 Jul 2025 15:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="BYx6DoBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0B083156; Mon,  7 Jul 2025 15:06:26 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AACA18305C
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 15:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail2; t=1751893583; x=1752152783;
 bh=jTyWvZ+L4PMK0YuBh7uy0dKKtbXxMScZlwhJ8wYl5C4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=BYx6DoBgfyyOSYRWwKBB3Us4CfZXkoqZ+8NwMOCA0Xmo9iGK/laQFfIbwurOoEdZa
 gTCZNG4kALBQzexzfvAfEP4cXgZeFcpdGdo9/6wrvDDnTaCCVPuY1SDRo8G1pJfeIO
 RKevTObkYB8qEn27bULOyWJnIvQuFhX/NtXngU/UhWIx2/1nkUD3AFXfruCeou1nkg
 c75zQMZ3joYO59pUJGywiKNgXMB9HOPZzd7N4LD/+18RlfoplswZS8lVfGsKCZVdaS
 hYAkA1K+iP/Fow/Wm5qIzABoKLoq4Aj9JXtdGFxx1rh+io/VfIqCZfziIhXy89Wv8W
 mcNhgINLRHhOA==
Date: Mon, 07 Jul 2025 13:06:16 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>, Tom Rini <trini@konsulko.com>,
 Michael Walle <michael@walle.cc>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/4] pinctrl-uclass: update comment to reflect code
Message-ID: <20250707150438.3016690-2-philip@philipmolloy.com>
In-Reply-To: <20250707150438.3016690-1-philip@philipmolloy.com>
References: <20250707150438.3016690-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 58f9017f053901ac71bf3bedf542ba05c3c664d3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Philip Molloy <philip.molloy@analog.com>

The logic was updated without modifying the comment above it

Fixes: 72b8c6d1ebf ("pinctrl: don't fall back to pinctrl_select_state_simpl=
e()")

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---
 drivers/pinctrl/pinctrl-uclass.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-uclass.c b/drivers/pinctrl/pinctrl-ucl=
ass.c
index d9c76898a96..58e070bfe1e 100644
--- a/drivers/pinctrl/pinctrl-uclass.c
+++ b/drivers/pinctrl/pinctrl-uclass.c
@@ -317,8 +317,7 @@ int pinctrl_select_state(struct udevice *dev, const cha=
r *statename)
 =09if (!dev_has_ofnode(dev))
 =09=09return 0;
 =09/*
-=09 * Try full-implemented pinctrl first.
-=09 * If it fails or is not implemented, try simple one.
+=09 * If full-implemented pinctrl is not implemented, try simple one.
 =09 */
 =09if (CONFIG_IS_ENABLED(PINCTRL_FULL))
 =09=09return pinctrl_select_state_full(dev, statename);
--=20
2.50.0


