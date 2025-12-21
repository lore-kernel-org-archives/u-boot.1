Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CDDE67496
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 01:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC3A0836A3;
	Sun, 21 Dec 2025 02:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ovJloY2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FEB783759; Sun, 21 Dec 2025 02:59:10 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0CC80325
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 02:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-001-171.46.114.pool.telefonica.de
 [46.114.1.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D88F9409C0; 
 Sun, 21 Dec 2025 01:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766282347;
 bh=TUuUNUX/oJErM/phPLhnvq3XZv1PjGqgtD2KJeXgdZQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ovJloY2S/XzQV7kqzB8K0ac5Pn+yA7ZGxFKENNdiOiTjAftu0vCR5uvJXTJd6yHW7
 vvYTYIsywBfh/hnWkDtbOdw9FPq5VxFmbQjNzHUyKn4KiD/oz7FwtciTkzllbHMwXf
 Ja9UF4X5jOeyx6JhP13s0u9ko/B6jf+X3X8bp2E6eo0AuvqR7AUAEWVl1ls7rIDWNY
 RDG03PtHctW9xm9JH4Hit6qzJNHBs4kvNKPRPkW/c44WBMsjbfMXntNzxJm2iC4ibk
 N4JafKoCn03TDzxpzueC6MenOGC9pVC/8LklJoiTuP1I5Cxtd6Y+FWrju213iGlVA9
 VFq7Vz5zORMPJv74eT0TzkYNYnvwMOlOES4S9S8nKOqlk1eoyc6pxVLufzBtb3JOYW
 baVVV9zLT1inVSu+ukmpeFWNVuRpq/SiKlxHquXSsFkI4w0ZlSjBqP3vYiKyA+msXK
 gp81FAShPmsiw+/pkct0BwTqsL583rzWcsQh7di6qhj2cl+LljZ183WY8I/2svxm80
 bngZSInTqTQLn2SPYr2apgtjekM9LId11p5kY+GvC3UFgdVxlLV1B1GfGMa1QzddBn
 KnxDDNwICTGDksjvjk+fB7cFzEayctoD4yqZf9gxuZ8u2GcJmZkXintGH96SNxiDmA
 gCYWC9NV6JEtLYbuZJq0kqbg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 0/8] trace: improve support
Date: Sun, 21 Dec 2025 02:58:51 +0100
Message-ID: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

In the current state the trace functionality is not usable.
With CONFIG_TRACE=y not even QEMU can boot.

With this series CONFIG_TRACE becomes usable on
qemu-riscv64_smode_defconfig.

It all starts with correcting the handling of recursive calls
to the measuring functions at the entry and exit points.

When a function is entered we record the time and reading the
timer leads to a recursion which should not switch of recording
traces but just be ignored.

The meminfo patches are in the series because the output
of the meminfo command depends on CONFIG_TRACE.

Also the Pythontrace test does not consider that output depends on
configuration.

There are still issues with qemu-x86_64_defconfig when trying to
trace. But I would like to collect early feedback.

Thanks to Patrick Rudolph for pointing to his issues with tracing.

Heinrich Schuchardt (8):
  trace: correct handling of recursive call
  trace: initr_trace must succeed initr_dm
  test: test_trace: remove invalid assert
  trace: increase TRACE_CALL_DEPTH_LIMIT
  cmd/meminfo: display of addresses above 4 GiB
  test: cmd: consider configuration in meminfo test
  test: initf_malloc is only traced with EARLY_TRACE
  test: clean up test_trace.py code

 cmd/meminfo.c               |  8 ++---
 common/board_r.c            |  2 +-
 lib/Kconfig                 |  2 +-
 lib/trace.c                 | 59 +++++++++++++++++--------------------
 test/cmd/meminfo.c          | 20 +++++++++----
 test/py/tests/test_trace.py | 52 +++++++++++++-------------------
 6 files changed, 68 insertions(+), 75 deletions(-)

-- 
2.51.0

