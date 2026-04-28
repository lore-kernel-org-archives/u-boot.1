Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779FFFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2773C84605;
	Tue, 28 Apr 2026 17:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="Sfz3M2c/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CF88460E; Tue, 28 Apr 2026 17:55:58 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 354CF845CE
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g4lQg4n1xzGL8;
 Tue, 28 Apr 2026 17:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777391755;
 bh=yGLHFYVVI/ci2d53+5V8GC3iDdL2yJnX+IXWBfgxe34=;
 h=From:Date:Subject:To:Cc:From;
 b=Sfz3M2c/dVOaYzUV5hMKcQ2ICfWscrOJ+NOcorfBwCzcnmvAkCdNlxOYRnTqcXRU0
 LOByMEP0ulsgbMNXiKuXqmyOamIv8DxHK5ycZQUk7o1YXQfbLlfJLV/zOoIZ2NItOI
 w9sSTLWnSp7srHZyP5RY+g2/YzAxLGmjuEEVGzCdL2YoSw7la0ek2AH/2gA0FYKuHd
 Rh+RH7dpzXFF2EIT6ghUxN1JGM3MTbUqSJVsBZ33IGQbKj5U80+/MYGLMagPskrKZG
 yn8FUzocV2PLEl7p3rE7SA6oZzvajya26OOM1ftYm2uN4W9YM5Wm32PkwUv5pXBvae
 cwLGw29TKI7+A==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g4lQf2FKTzPRH; Tue, 28 Apr 2026 17:55:54 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 28 Apr 2026 17:55:42 +0200
Subject: [PATCH] test: wget: validate URI for lwIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-wget-test-lwip-v1-1-f611cea0c5ee@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBBG4VeRWTugQSX2VYoLjb92SrGSiRcQ3
 920Lr/FOQcpvEDpkRzksYrKd4rI04Tcq51GsPTRZDJTZYWxvI0IHKCBP5vMXCO3rS1dZ4aaYjR
 7DLL/h8/mti7dGy78LnSeF6qnxG9yAAAA
X-Change-ID: 20260428-wget-test-lwip-9e18a85cb2f9
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
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

We've had wget support in lwIP for almost a year now, so let's do *some*
checks in the form of validating URIs.

The other test in test/cmd/wget.c currently requires structures only
defined for CONFIG_NET_LEGACY so it's left out for now until someone
ports the test to lwIP.

This was tested with:

./test/py/test.py --bd sandbox64_lwip --build -k net_test_wget

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 test/cmd/Makefile | 2 --
 test/cmd/wget.c   | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 5f2815b1bb6..28bb8a82ca4 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -39,9 +39,7 @@ obj-$(CONFIG_CMD_PWM) += pwm.o
 obj-$(CONFIG_CMD_READ) += rw.o
 obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
 obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
-ifdef CONFIG_NET_LEGACY
 obj-$(CONFIG_CMD_WGET) += wget.o
-endif
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
 endif
 obj-$(CONFIG_CMD_SPAWN) += spawn.o
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index 1005392b952..15c2a854e09 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -23,6 +23,7 @@
 #include <test/test.h>
 #include <test/ut.h>
 
+#if CONFIG_IS_ENABLED(NET_LEGACY)
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define LEN_B_TO_DW(x) ((x) >> 2)
 #define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
@@ -241,6 +242,7 @@ static int net_test_wget(struct unit_test_state *uts)
 	return 0;
 }
 CMD_TEST(net_test_wget, UTF_CONSOLE);
+#endif
 
 static int net_test_wget_uri_validate(struct unit_test_state *uts)
 {

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-wget-test-lwip-9e18a85cb2f9

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

