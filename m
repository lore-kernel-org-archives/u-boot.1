Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381BAE6748D
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 02:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F24108397D;
	Sun, 21 Dec 2025 02:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nKsOdlRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E451B80325; Sun, 21 Dec 2025 02:59:15 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0849D8388D
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 02:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-001-171.46.114.pool.telefonica.de
 [46.114.1.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D4689409D7; 
 Sun, 21 Dec 2025 01:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766282353;
 bh=9gRJgXqMFAgBBv3FrfQp54D03gF4KSHbuTX+DJAx7pw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nKsOdlRKc+T9Y+GMz4LefZmbkZgIbjJWXAkoXUrFDbyVx7ASWmF0RwRlbaBISP9Cx
 oj2yz/9haxNem7NTgB8PnfV9gIiut+ZHUTXJpGJCT6jA1eLvV5hmmu+kLbGP0bWnQT
 uuaXAlheGH8v/j3g3KU7craNiyiwX7DG/5htWU7l7/y1iVJSk6fbbVCuKW2dzRGXjx
 X8VRNgPxq/L5oso6YQgwPPrO4VcYVxJgwpxRV3vvqeAkfNvFzrWRf4Uwjt/8IFdACC
 W6lmgWdVjPpxWSqf3MST541k+cg53fxD/zSKAn0bIHJQjzXpQq0JIvvxSFvl8cr8VV
 VoGJYkx3K8opNUX2M/j99vxjszG5oNx6bhxrJb31qh2TWSRIz9Ic2qq9L9Ehe6ltMg
 GsDqvvBN19QOFAsrs7vRXyFz/ncptqNybUPapPG9vCFkIb071bUSHYeM54xHQqYk1L
 AB5F7PAqE30q+6AOzM2DDGoDsmT6iNfemFoD+w+DbNE048Clr1jezRjo5ZxwYm/NYj
 oDZxwQ5r9iR9Xmt7p3pdNfjGENNLx4wU4c+wgnRVljM1XHKk+qAjyLBnMRmUfVZD3Q
 DlrK0erqMg8QhDcSwRSuHIxPgGaW73+vxNW6uA8QyLWnroNNItazRwLSF41orkl9uV
 fjU3I1PIe7/rPzN0MkxDqMhs=
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
Subject: [RFC 6/8] test: cmd: consider configuration in meminfo test
Date: Sun, 21 Dec 2025 02:58:57 +0100
Message-ID: <20251221015859.738112-7-heinrich.schuchardt@canonical.com>
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

The output of the meminfo command depends on several Kconfig variables.
These need to be taken into account to provide valid test results.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/meminfo.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
index 9224b9589f3..d91fa6fcead 100644
--- a/test/cmd/meminfo.c
+++ b/test/cmd/meminfo.c
@@ -15,24 +15,34 @@ static int cmd_test_meminfo(struct unit_test_state *uts)
 {
 	ut_assertok(run_command("meminfo", 0));
 	ut_assert_nextlinen("DRAM:  ");
+
+	if (!IS_ENABLED(CMD_MEMINFO_MAP))
+		return 0;
+
 	ut_assert_nextline_empty();
 
 	ut_assert_nextline("Region                Base          Size           End           Gap");
 	ut_assert_nextlinen("-");
 
 	/* For now we don't worry about checking the values */
-	ut_assert_nextlinen("video");
+	if (IS_ENABLED(CONFIG_VIDEO))
+		ut_assert_nextlinen("video");
+	if (IS_ENABLED(CONFIG_TRACE))
+		ut_assert_nextlinen("trace");
 	ut_assert_nextlinen("code");
 	ut_assert_nextlinen("malloc");
 	ut_assert_nextlinen("board_info");
 	ut_assert_nextlinen("global_data");
 	ut_assert_nextlinen("devicetree");
-	ut_assert_nextlinen("bootstage");
-	ut_assert_nextlinen("bloblist");
+	if (IS_ENABLED(CONFIG_BOOTSTAGE))
+		ut_assert_nextlinen("bootstage");
+	if (IS_ENABLED(CONFIG_BLOBLIST))
+		ut_assert_nextlinen("bloblist");
 	ut_assert_nextlinen("stack");
 
 	/* we expect at least one lmb line, but don't know how many */
-	ut_assert_nextlinen("lmb");
+	if (IS_ENABLED(CONFIG_LMB))
+		ut_assert_nextlinen("lmb");
 	ut_assert_skip_to_linen("free");
 
 	ut_assert_console_end();
-- 
2.51.0

