Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586ACC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD3784A4A;
	Wed,  8 Jul 2026 22:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RT2yuktq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F621843B6; Wed,  8 Jul 2026 22:37:24 +0200 (CEST)
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32848843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783543036; x=1783802236;
 bh=CaKv56Zgvj22Om+WfVkY7LQAdwM2Q5sfr711tQZIpZQ=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=RT2yuktqxW6UhJ0WYdMtbV4apWY3ZrIGoXdLu29XRA2rXw7z08Y62lvZHhC15TRap
 9vUjS1/C5sDLDYMyT5yPlvaz0mcWEuEWuI5Mn6s1yp+Awn7pgv7Si+RlP3grezuKN8
 nKMFMoEmmDvXXGh5ABAGH6O9RGDFbYu1pTcMaI7l8ab+eP1OJldZKg3t58Ywkx6bNR
 rmu2JFOe6h0vjOxUGxUT8qf3ieElg1/UWlUEple+DsVSp2qgw+aPlFQ9YSatqyQj+L
 9c9cJh3DxaIY/EYj38Wj/htbj80K0i1XaD064b0sQ+NgKfJRBkS7urqZKlWHUWHYFX
 L6TXYUYJwfk5Q==
X-Pm-Submission-Id: 4gwVJW3Kp4z1DDpQ
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 00/10] some string cleanup,
 and a tweak of the "config" command
Date: Wed,  8 Jul 2026 22:37:01 +0200
Message-ID: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This started by me wanting something like what patch 8 does. That
wasn't too hard, except we had no strcasestr(), and also our regex
engine (which I didn't really want to pull into the mix anyway)
doesn't have a flag that requests case-insensitive matching. So I
wanted to add strcasestr(), but then I stumbled on a bunch of stuff
that should be cleaned up in str-land.

v2: Include Simon's R-b in the first 8 patches, incorporating most of
the minor comments. Patches 9 and 10 are new in v2.

Rasmus Villemoes (10):
  sh: clean up asm/string.h
  string: correct prototype of strchrnul()
  string: correct documentation for strstr and strnstr
  string: remove unused strswab() function
  string: remove more pointless __HAVE_ARCH_STR*
  string: add strcasestr()
  test: string: add test of new strcasestr() function
  cmd: config: allow simple filtering of output
  doc: document 'config' command
  test: add test of 'config' command

 arch/sh/include/asm/string.h | 51 --------------------------
 cmd/config.c                 | 26 ++++++++++++--
 doc/usage/cmd/config.rst     | 40 +++++++++++++++++++++
 include/linux/string.h       | 13 ++-----
 lib/string.c                 | 70 ++++++++++++++++--------------------
 test/cmd/Makefile            |  1 +
 test/cmd/config.c            | 28 +++++++++++++++
 test/lib/string.c            | 24 +++++++++++--
 8 files changed, 146 insertions(+), 107 deletions(-)
 create mode 100644 doc/usage/cmd/config.rst
 create mode 100644 test/cmd/config.c

-- 
2.55.0

