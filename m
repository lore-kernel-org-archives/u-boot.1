Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4B7C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 13:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0535483164;
	Mon,  7 Jul 2025 15:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="e154BHb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959B683192; Mon,  7 Jul 2025 15:06:36 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0018483156
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 15:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail2; t=1751893593; x=1752152793;
 bh=1oA20qeMWABNnUtQo2uIBT91GqDzRAGkCkwaUBqf8BI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=e154BHb2PomIPvSAZVQ4rb1WCIUah0MqyKyYsLiJXuDy/gjnf1xuo3S5E5z7VsGXA
 VWQdsXAf6C1zMdhLdrSWSuubCfc5u8RrI/AUpZrWK5kOMCIgUShaetNgEVjvFakTDQ
 rpUjQzERWa/sZBcCw/ESfF05YyWZ8yNoByhPfv+IDRGN4A/Pmrm3mlydEDrO60buHS
 /9dI8LW0bEx8TQFDjzGhzVzw3UYQgZFgKudwPu5vLv1lOh1p8Z5TTQZLZKdvT5568M
 T+njkwDJgesd8h9GDKhY+HSUVXdVLsRTq49oiSWWMR8yEFxXclc8MB81zDUwHmtxYn
 Tf7Sr9XO8x4Zw==
Date: Mon, 07 Jul 2025 13:06:26 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/4] serial-uclass: fix typo in comment
Message-ID: <20250707150438.3016690-3-philip@philipmolloy.com>
In-Reply-To: <20250707150438.3016690-1-philip@philipmolloy.com>
References: <20250707150438.3016690-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: cbdf2d0ab3d61fde68417b8e252d1344cd3c60da
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

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---
 drivers/serial/serial-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.=
c
index a08678dde4e..32108c381a4 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -109,7 +109,7 @@ static void serial_find_console_or_panic(void)
 =09=09 * from 1!).
 =09=09 *
 =09=09 * Failing that, get the device with sequence number 0, or in
-=09=09 * extremis just the first working serial device we can find.
+=09=09 * extremes just the first working serial device we can find.
 =09=09 * But we insist on having a console (even if it is silent).
 =09=09 */
 #ifdef CONFIG_CONS_INDEX
--=20
2.50.0


