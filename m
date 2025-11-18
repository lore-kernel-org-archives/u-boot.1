Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042AFCEE350
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 20:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 792F383966;
	Tue, 18 Nov 2025 21:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fvK+UjRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD0BE8398D; Tue, 18 Nov 2025 21:17:48 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B24A83956
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 21:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5809340A19; 
 Tue, 18 Nov 2025 20:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763497063;
 bh=mzW5Q1I0R8ETeZ2mchhQgysg+3DfpEMXDBW0Q8RgOj8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=fvK+UjRRz8sZNimCpT4BLvwwCf7QU8VqXXX5OmtkIm84ALRChbOUA3PtNhzVCSZzt
 tm8IqSHqcssy6byDFZo6kTQjmnlCr95EzFfQrdEAc5ebPtjAvnKLceJF2aH7tfbKoe
 CLPKx+RAd9KCazkbAeyaAwt1G8AHkjmnWPK2kyraU4cn4NRe7XGqxSA5v0NZYlPP1w
 NNrpFzVMAvcF403BoKW85xHyQn9wb+PTw+33oIeIE4lae0KnKMJ3KKY7hxQ7Njf0jb
 tB7Df0M/KO4iXIMDgZY3zIpL4wZQ9v/D4NiSYCoJtOb0pUjzuSrC8AX8oIUJnigAZ7
 X7vbCXHNo11JY3W89HTf8LrxCIvNj2vQDnOPzObZ1mC+FFAkb0Mqf11+bz67YZgp9L
 XeY3360LfoRzHzINvy00E4LUTYoKbo0HzIZCKJ/oKZpTk/HLF5GjHJBWxLaO9Y8Pzi
 J3z6wJUUt8KRhAXWxF3RTAHlz+4s6Jb3/SQG+2e98BpBxMp4K3gtPX9PJsA/6D2FN6
 61kHUjlge6U+OHLSw1h0XO6fN1NDc0A5Xp7XpHayq00/znP8Foie732YfA06ED1Z0a
 FTQIJL49qA/NDub/7xnVVvhDa+E2vfN0e32eoQyyLjamobIqsNl6cd1jTMGH4AyOzO
 9lpKa/tYLqM2ehG9vYyAxlrs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/4] doc: make writing DM test subsection of writing C test
Date: Tue, 18 Nov 2025 21:17:30 +0100
Message-ID: <20251118201733.67297-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
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

A driver model test is just a special case of a C test.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/tests_writing.rst | 55 ++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 062194659b5..b6972489d4c 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -206,8 +206,36 @@ some common test tasks.
 
 (there are also UEFI C tests in lib/efi_selftest/ not considered here.)
 
+Add a C test to an existing suite
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Use this when you are adding to or modifying an existing feature outside driver
+model. An example is bloblist.
+
+Add a new function in the same file as the rest of the suite and register it
+with the suite. For example, to add a new mem_search test::
+
+   /* Test 'ms' command with 32-bit values */
+   static int mem_test_ms_new_thing(struct unit_test_state *uts)
+   {
+         /* test code here */
+
+         return 0;
+   }
+   MEM_TEST(mem_test_ms_new_thing, UTF_CONSOLE);
+
+Note that the MEM_TEST() macros is defined at the top of the file.
+
+Example commit: 9fe064646d2 ("bloblist: Support relocating to a larger space") [1]
+
+[1] https://gitlab.denx.de/u-boot/u-boot/-/commit/9fe064646d2
+
+
 Add a new driver model test
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+'''''''''''''''''''''''''''
+
+``dm`` is the test suite that contains C tests for U-boot
+:doc:`Driver Model <driver-model/index>`.
 
 Use this when adding a test for a new or existing uclass, adding new operations
 or features to a uclass, adding new ofnode or dev_read_() functions, or anything
@@ -249,31 +277,6 @@ Example commit: c48cb7ebfb4 ("sandbox: add ADC unit tests") [1]
 [1] https://gitlab.denx.de/u-boot/u-boot/-/commit/c48cb7ebfb4
 
 
-Add a C test to an existing suite
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Use this when you are adding to or modifying an existing feature outside driver
-model. An example is bloblist.
-
-Add a new function in the same file as the rest of the suite and register it
-with the suite. For example, to add a new mem_search test::
-
-   /* Test 'ms' command with 32-bit values */
-   static int mem_test_ms_new_thing(struct unit_test_state *uts)
-   {
-         /* test code here */
-
-         return 0;
-   }
-   MEM_TEST(mem_test_ms_new_thing, UTF_CONSOLE);
-
-Note that the MEM_TEST() macros is defined at the top of the file.
-
-Example commit: 9fe064646d2 ("bloblist: Support relocating to a larger space") [1]
-
-[1] https://gitlab.denx.de/u-boot/u-boot/-/commit/9fe064646d2
-
-
 Add a new test suite
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.51.0

