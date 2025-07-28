Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBF2C87FC9
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 13:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1D0A82F14;
	Mon, 28 Jul 2025 15:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="vnAwD2Vs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D600482F8E; Mon, 28 Jul 2025 15:04:11 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E55CF82D88
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 15:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail3; t=1753707848; x=1753967048;
 bh=Xi1GUh178JCdLHIfWQpS30WriJSQAV5AoggcYxoxpsA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=vnAwD2VsQxbjaBfn5pFtjsQ5J9isu3Z2GPtLSd7ti9KFWmNmXlYKtT48akRNOTBO0
 hoHoyjxs24i0UJXM8ryC42b9JUpW/VQusdsJGyDZyr8cEERPx/8hk8ylKtcL7N+TZ+
 CXe+qBHDA99LzQL1QtF299KgEBtoK5YCj23cJk6IFU5W9Zlu5uDmHQW4Xm8BUXBSW5
 KO2Bf7mVU1TYqQ2q9xkPfu5OxHYxRvk4DsHihCnsNFGrzicsDgZ9/WUfPLd+0ZmXcy
 caF0SbGKp947aO0NlK08UA8CY132q0Pc6chK35ZMu4Gu567/yUTnoX384ZyJNtB0zL
 tfbgLslhBjzNA==
Date: Mon, 28 Jul 2025 13:04:03 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 1/1] Makefile: Remove expansion of undefined variable
Message-ID: <20250728150333.1716886-2-philip@philipmolloy.com>
In-Reply-To: <20250728150333.1716886-1-philip@philipmolloy.com>
References: <20250728150333.1716886-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 45271710a02a89fc5b5664ffa052bd0cb68a864b
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

The U-Boot environment was previously stored in the boot loader stream
using ldr, but it has been replaced by the default environment built
into the U-Boot executable or an environment on external storage

Fixes: ea3310e8aafa ("Blackfin: Remove")

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---
 Makefile             | 1 -
 scripts/Makefile.xpl | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1a5c77d7caf..e57594aa755 100644
--- a/Makefile
+++ b/Makefile
@@ -1370,7 +1370,6 @@ u-boot-nodtb.bin: u-boot FORCE
 =09$(BOARD_SIZE_CHECK)
=20
 u-boot.ldr:=09u-boot
-=09=09$(CREATE_LDR_ENV)
 =09=09$(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
 =09=09$(BOARD_SIZE_CHECK)
=20
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 43f27874f9f..408d5cde7a6 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -390,7 +390,6 @@ $(obj)/$(BOARD)-spl.bin: $(obj)/u-boot-spl.bin
 endif
=20
 $(obj)/u-boot-spl.ldr: $(obj)/u-boot-spl
-=09$(CREATE_LDR_ENV)
 =09$(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
 =09$(BOARD_SIZE_CHECK)
=20
--=20
2.50.1


