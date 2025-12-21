Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316A6E67495
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 02:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589BF8389A;
	Sun, 21 Dec 2025 02:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tLQ3Z4cy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C13380325; Sun, 21 Dec 2025 02:59:17 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30F6E83935
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 02:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-001-171.46.114.pool.telefonica.de
 [46.114.1.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D4054409D8; 
 Sun, 21 Dec 2025 01:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766282354;
 bh=C+U+L5/E6IIg6VaIrdAHfhqaC2FdMWazFTZ+civiAwU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=tLQ3Z4cyPDKJtgRotI1t8NShEjtOHePKRC91FZ4oE7EmAqv9D/b3xzMG3ncXUzEvm
 QHyGSsH+KWtRuezPmt3QRgOmEi3jdSw8p0Oj14DNWgXD4CsaG293zVYC+EiMN4Vnl1
 86wnCnsXtvqJwW1+ndrcnopPYZCX7/jId47OtpJ+ALnJV8qm0pjaFqY8pkJ2pUaNzl
 MoBp3WACvkg0ULhzcB8fqkFs+q4cFy4RXMa0nxgLDBsua/2RgwPTe2wg68P6N1oD+q
 nHrKKfXj+uyPCzKmqTXdZvQhHQI7OxnzsViTLSu0T4a0jCiIgE1rsSGiKVAto9GHtd
 bq+mW9cv/MhilXi4X8YdACeYLQAhwNl7oKGnfYTVav2THLtWULl28SSVI5iujwTP+U
 iSfwDLC1QKWHm8DeImBxG/lQ1IxEBLomHa7v/8Q1L41GHxnL6S9z/FbhvS6T38Wxgz
 wYb9MxXUWnsza+akiIGABqomzWBTXMKNzIleKwDo0yoyQdKYRYFr4srEKpMEngvKGE
 6RL8h9T1XXY8XYqMWYZJoypyBwZ4ao3H0FLvWVcrVlnLxVJw9iz0u0RzFXsLkWCOCx
 w0olflYue6g8tGb7MsA36XgLDd1+yO6YjogyDOg0oDeBOKvIdcR2Stow+iy5zbh31p
 jjn/GHGlfXX/0gvNdHc1mlR8=
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
Subject: [RFC 7/8] test: initf_malloc is only traced with EARLY_TRACE
Date: Sun, 21 Dec 2025 02:58:58 +0100
Message-ID: <20251221015859.738112-8-heinrich.schuchardt@canonical.com>
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

Only if early tracing is enable the function initf_malloc can be traced.

Add a configuration check.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_trace.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index 7f897e4c366..bbe6dd7de41 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -159,7 +159,8 @@ def check_function(ubman, fname, proftool, map_fname, trace_dat):
             base = timestamp
 
     # Check for some expected functions
-    assert 'initf_malloc' in vals.keys()
+    if ubman.config.buildconfig.get('config_trace_early'):
+        assert 'initf_malloc' in vals.keys()
     assert 'initr_watchdog' in vals.keys()
     assert 'initr_dm' in vals.keys()
 
-- 
2.51.0

