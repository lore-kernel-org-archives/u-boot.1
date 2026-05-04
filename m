Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426D1CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07FA1846E6;
	Mon,  4 May 2026 15:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="dOGh4qgJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F022F846CF; Mon,  4 May 2026 15:21:04 +0200 (CEST)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD0C846A4
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8MjB5wCWzhfl;
 Mon,  4 May 2026 15:21:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900862;
 bh=6UGl0eYwtzFE/I0viZo9Qi2uODyKB5HwSGA9wIT0YSw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dOGh4qgJ/eGLuz0vtTwC71Jsvk+1wDsZZVlGRZr/L1civjHT70kLA2wMGJbe78+ga
 HsBrrQg8SFovWLHFc79P6bdhHHY4yJ5rRbXFugY5sWDpQxFqy/fXmdISq9ZJqPFv/N
 kDBr8HoDPMFq3xYgyeM1QgvuDvPFk+5+ID8IGXMeByyhsmkydDj650wQo+xOXhf0dY
 OurVAlEaRCIG1XnHGdGTw2rNd4gfqbNnDvKqOWMKSYKHdH49FBJBdb5xGml58SjafM
 vpgt1DTPeQLWOsSBAU8s992ol5PUeSj4NAalaElwNmfaYSkUV/wjq4NVA2+6CJanji
 d7o//oyn0Ssog==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mj93tqTzClw; Mon,  4 May 2026 15:21:01 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:45 +0200
Subject: [PATCH RFC next 18/18] buildman: set W flag to e to be consistent
 with CONFIG_WERROR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-18-b19301d1948a@cherry.de>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Buildman currently only enables Werror for KBUILD_CFLAGS (via KCFLAGS)
and KBUILD_HOSTCFLAGS (via HOSTCFLAGS) but nothing else.

scripts/Makefile.extrawarn now supports --fatal-warnings for the linker
and assembler, which are enabled whenever CONFIG_WERROR is set.

Let's make buildman set this variable to enable even more checks.
KBUILD_CFLAGS and KBUILD_HOSTCFLAGS are kept in case buildman is run on
a git-range where W=e is not available, it's better than nothing.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/buildman/builderthread.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 371708c8a98..19db265c47a 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -233,6 +233,7 @@ class BuilderThread(threading.Thread):
         if self.builder.warnings_as_errors:
             args.append('KCFLAGS=-Werror')
             args.append('HOSTCFLAGS=-Werror')
+            args.append('W=e')
         if self.builder.allow_missing:
             args.append('BINMAN_ALLOW_MISSING=1')
         if self.builder.no_lto:

-- 
2.54.0

