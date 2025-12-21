Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF2AE67496
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 01:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6357883885;
	Sun, 21 Dec 2025 02:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MJJ3Wp0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55040838E6; Sun, 21 Dec 2025 02:59:14 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E31D83885
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 02:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-001-171.46.114.pool.telefonica.de
 [46.114.1.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C98ED409D5; 
 Sun, 21 Dec 2025 01:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766282351;
 bh=pLbXvrZHGtaiQ0y+87XQvnh8m2M1Mq1cdx+RrCVvP18=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MJJ3Wp0rrslEBBXX1yn++CAcWQpz+tihNyqFk3sF9HD+sBQ7HZP807O8DwaBafXTH
 yB8rnAAW0DnjN1sdCjdcRakJUCfBqgirfEUMEU4qRJZhl+KJq3tsva8chFLq+a103q
 bQxQ+DwD309IgnB1174w74YN9V2Vf6JgfsahdYaY5QQdF6hY6sR8jAm/Klgz23T3Qe
 PWOkLFkBDXR3eWpORLrbnsmHum5BTQap/D8Awl4GGsJr1nDbgEeMWCdGmwJubRkWIf
 9qx49OIyLdvmqTghl2/ClCqiGJQPkJA2zb/G+lf64qRNxUURU1K+yNBCUdbw3ZsUC9
 JxXblOcLo/QsunTw9bV+OIRbv44AcifFpFSc5VlbgSOGOJcMnAlkLN8hMLdpQWxi6q
 JQjcRJPk+oRNzYmw9ysQexwXmNSByEWt+lyw8Fkwe3oHWBglZMqnUJMTuhhoVXnLkU
 Q/KWjh7Mrc9foYbEo6XvfJSpWXr7ZqXiI5Q9Vi+7gRigvFaXBNMvOw164rMz7zK/mw
 b0aLnF0KUdQ/VrVS80VmA39WuNad+YzxTr24nJRobcqwAa25j6DwmH3TvTyTbUEVEM
 B9nvJyQKt2hhw2UnaNL+EmVwZ0L4E23LMTsHNvdYlkob9pj+m2jtH3c/N8VSNiAPIM
 50M6VOx5Xijx4TzVlzb6Q9t4=
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
Subject: [RFC 4/8] trace: increase TRACE_CALL_DEPTH_LIMIT
Date: Sun, 21 Dec 2025 02:58:55 +0100
Message-ID: <20251221015859.738112-5-heinrich.schuchardt@canonical.com>
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

test/py/tests/test_trace.py expects a recorded call depth in excess of 30.
bootefi hello has a call depth of 42.
efi_selftest_block_device.c reaches 56.

Let's increase the default for TRACE_CALL_DEPTH_LIMIT to 100.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/Kconfig                 | 2 +-
 test/py/tests/test_trace.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index fe0b878a206..3f175fde7b1 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -415,7 +415,7 @@ config TRACE_BUFFER_SIZE
 config TRACE_CALL_DEPTH_LIMIT
 	int "Trace call depth limit"
 	depends on TRACE
-	default 15
+	default 100
 	help
 	  Sets the maximum call depth up to which function calls are recorded.
 
diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index 52d6ec6e5d2..7f897e4c366 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -49,7 +49,7 @@ def collect_trace(ubman):
     assert int(vals['maximum observed call depth']) > 30
     assert (vals['call depth limit'] ==
             ubman.config.buildconfig.get('config_trace_call_depth_limit'))
-    assert int(vals['calls not traced due to depth']) > 100000
+    # 'calls not traced due to depth' depends on configuration. Don't check it.
 
     out = ubman.run_command('bootstage report')
     # Accumulated time:
-- 
2.51.0

