Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B20E67496
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 01:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B867D838BB;
	Sun, 21 Dec 2025 02:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cx4mQA0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E5C18388D; Sun, 21 Dec 2025 02:59:12 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A341836AC
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
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C6551409D3; 
 Sun, 21 Dec 2025 01:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766282349;
 bh=jKCm/Tfr5Ah2rv+oqUFNQvnvcRfAUsD99RD7s2aXkrc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cx4mQA0VOte/td2Yz2SQ4eHbHoJrIQfteDkbVjKaC2QtajJyvTu5Tgw7dMmfNYAIJ
 8KD7klt+BRjgsyoF7RD1la/ZY1OtPCfrNZgvdOe+LFLaX/+d60yFpMD09OvLeS0RLC
 9cB5x/7gexekcl5ROsPDuWQZuAYhoYo+++1sE4sZRyiN90V8TXcPBO2Cxobogx+L4m
 8ziNBByQd6FKXBNqIi0NFYs+4oM1xk426fbTmcfoPlPaf6955/SQQniNHIxEvAJvOS
 ZxOB74n/D9z8RYBu5+HR756zPzpc8TGeUmODcUCsEBop14TJyNVR2kSdGEpV8MmQav
 RjfkyPwdZ1TRbVc6L1NMcFALZdt3G52vnNeFyg8o9Bb8//iwFkFKsZ4HOajBiNxhZ0
 N0DMuXWW8a3lbxvY8ErdCEM8hCqk6qhPiQn+Pz0Og3nQpMRr6w+/GgUa9QDJI41GES
 ZQSXIc5r7G1fhyo5I+N9fcglvSR21tK0vdxEZPzzaSgZYuu1SSpRff0uGDkpenSrBz
 Zz1pcNPpV84cnBHjeJKJzNV9nkf9k8xqlriX2ayd3IuWx4JAELNgzN5P0n+3ZjMFHS
 dQQtIicloNAiXGSIXG1Ytt+KBuRj+fjRvYuZSBuWpP5jrv7hLIjeJ7Rfr2NHFSVxrb
 izZqty5ztqOQTEC8RUmoMcIs=
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
Subject: [RFC 2/8] trace: initr_trace must succeed initr_dm
Date: Sun, 21 Dec 2025 02:58:53 +0100
Message-ID: <20251221015859.738112-3-heinrich.schuchardt@canonical.com>
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

qemu-riscv64_smode_defconfig with function tracing enables ends in an
endless loop in notify_dynamic. When iterating over state->spy_head,
list_for_each_entry_safe() does not discover the end of the list.

The reason is that the address of state->spy_head has been relocated but
state->spy_head.next and state>spy_head.prev still point to the unrelocated
address. Therefore list_for_entry_safe() does not discover the end of the
list.

We cannot start tracing before initr_reloc().

When placing INITCALL(initr_trace) directly after INITCALL(initr_reloc) the
timer driver panics with

    Could not initialize timer (err -11).

Tracing uses the timer driver to add timestamps. The driver model needs
to be initialized to use the timer driver.

INITCALL(initr_trace) needs to be placed after INITCALL(initr_dm) in
initcall_run_r() to let the timer driver work properly.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/board_r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_r.c b/common/board_r.c
index 76f9fc090fb..2b8f5a423a6 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -604,7 +604,6 @@ static void initcall_run_r(void)
 	 * Please do not add logic to this function (variables, if (), etc.).
 	 * For simplicity it should remain an ordered list of function calls.
 	 */
-	INITCALL(initr_trace);
 	INITCALL(initr_reloc);
 	INITCALL(event_init);
 	/* TODO: could x86/PPC have this also perhaps? */
@@ -635,6 +634,7 @@ static void initcall_run_r(void)
 #if CONFIG_IS_ENABLED(DM)
 	INITCALL(initr_dm);
 #endif
+	INITCALL(initr_trace);
 #if CONFIG_IS_ENABLED(ADDR_MAP)
 	INITCALL(init_addr_map);
 #endif
-- 
2.51.0

