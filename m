Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380D9E67496
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 01:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 125AA83923;
	Sun, 21 Dec 2025 02:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I2gqnAt5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4ECB8388D; Sun, 21 Dec 2025 02:59:12 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39CA8334F
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 02:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-001-171.46.114.pool.telefonica.de
 [46.114.1.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B62D9409D4; 
 Sun, 21 Dec 2025 01:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766282350;
 bh=tlqvXbS/1KhZ+Pih0LaZNRgwNL3roak6KWL/T3Er5Io=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=I2gqnAt5IxQ52KSleVscambqakCkPNd4CmD9Yejh8/aYuPnLMrIyctCNqXqq6wx0l
 VKRZ5T4QiUz2O5gvuSmS2y3AOK/CenCocQzKtITIg7EeeobqE5p0wEcjW9eXaeRBkg
 iM+0Xg/K3wnxpEBjD2w/h/vvTgk9dm4CIrcD11qwvbv3pqbFQ6TnECgUbCfPhtO4ez
 QBFFT2rz5p1FhnV5ERlr7qjP18LYMR5YcEWpDgXhmKSeU5wGjRMY/vU8UWUbhVX0WA
 W+SKRrRK5yCSbWRkyzFJp07pZm2+paqE7awAORW/0eYaK+tgnRbrABi2c8efhg2VpH
 EbazNZnVYbE2TystLLRKRrXr+PuTD+I+B7Q/Mxe4wCqgBbm4tX1VbcOcGINRNSX85r
 up6t01WZb3pJmuydww+RXLPFi0gdT2M3z9Wpg7cllumc9USdTb/xFeQBgwwHLkrHvq
 cGB0RJwBNY34ktB43TXYHSGwRjgacjDZ9cmHBbcOdFEs4jHyD2U2GOS7oU1GpzR49t
 Zlk/bPfpjR10fupVKtUxMbuGXSffibUzwrnsHe1W/2WTP/MitKzF6CTLSF6QR15b/n
 cClVLbcvaHGjYyyV3U5V1U1vrLblIWU08Ta3bMR4YmpJdbzCJfd/2FNEhMA3gnT7mt
 82dZ8KjDMYgQkp9K8Pt1TtDE=
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
Subject: [RFC 3/8] test: test_trace: remove invalid assert
Date: Sun, 21 Dec 2025 02:58:54 +0100
Message-ID: <20251221015859.738112-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
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

If a function is traced before relocation depends on the
CONFIG_EARLY_TRACE.

Timer initialization is not expected to be traced after relocation anymore.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_trace.py | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index fcdcbe2c6db..52d6ec6e5d2 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -271,18 +271,6 @@ def check_flamegraph(ubman, fname, proftool, map_fname, trace_fg):
         ubman, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
                'dump-flamegraph'])
 
-    # We expect dm_timer_init() to be called twice: once before relocation and
-    # once after
-    look1 = 'initf_dm;dm_timer_init 1'
-    look2 = 'board_init_r;initcall_run_r;initr_dm_devices;dm_timer_init 1'
-    found = 0
-    with open(trace_fg, 'r') as fd:
-        for line in fd:
-            line = line.strip()
-            if line == look1 or line == look2:
-                found += 1
-    assert found == 2
-
     # Generate the timing graph
     utils.run_and_log(
         ubman, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
-- 
2.51.0

