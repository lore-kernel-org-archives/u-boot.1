Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC16DC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CB4F84BE0;
	Wed,  1 Jul 2026 19:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SsThjFDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA0E84C18; Wed,  1 Jul 2026 19:15:44 +0200 (CEST)
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B553184BC8
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1782926141; x=1783185341;
 bh=kGEN4Gc6+q16umfBYFCUyh0yCSEhedknI+NFvcH9XQA=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=SsThjFDIsYHrZ1LXIf2jDvB5GKUTZGaV4xBVeRE5AkOL/X/Ws2/n+8HmniXK2TmvB
 cUXbgaKpt0+7CX379vf9XERkj1MAOx4TjF3r1F5ImsEzkTCZ7b8pmHPjg80lPjdgNF
 Re/DxgNZrbFsxDx3JR3VrZEeR9Ywh8qpMPYjU+Y2ojm1SP6ARZjR5JsLYHqeMfQEh9
 i/witYMzVIROKWjLIsKWNgRSGPzvEjRhJMmTLxSbjNyGjJsrgoXA2+Lv+p3QscLPa6
 Ucxd+2WCROv9w+NxNygmYiZnIUp7YZPMB+B5elfBRxFcD+1Vlra+tyug/YtFH3OhTj
 lRfbi8nWjl+nw==
X-Pm-Submission-Id: 4gr698643mz2ScsC
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 0/8] some string cleanup, and a tweak of the "config" command
Date: Wed,  1 Jul 2026 19:15:27 +0200
Message-ID: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
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

This started by me wanting something like what the last patch
does. That wasn't too hard, except we had no strcasestr(), and also
our regex engine (which I didn't really want to pull into the mix
anyway) doesn't have a flag that requests case-insensitive
matching. So I wanted to add strcasestr(), but then I stumbled on a
bunch of stuff that should be cleaned up in str-land.

The first five patches are logically independent of each other. The
last three do depend on each other, and the last patch also depends on
patch 2.

Rasmus Villemoes (8):
  sh: clean up asm/string.h
  string: correct prototype of strchrnul()
  string: correct documentation for strstr and strnstr
  string: remove unused strswab() function
  string: remove more pointless __HAVE_ARCH_STR*
  string: add strcasestr()
  test: string: add test of new strcasestr() function
  cmd: config: allow simple filtering of output

 arch/sh/include/asm/string.h | 51 --------------------------
 cmd/config.c                 | 25 +++++++++++--
 include/linux/string.h       | 13 ++-----
 lib/string.c                 | 70 ++++++++++++++++--------------------
 test/lib/string.c            | 24 +++++++++++--
 5 files changed, 76 insertions(+), 107 deletions(-)

-- 
2.54.0

