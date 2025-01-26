Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABECC0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 23:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DDD780F96;
	Mon, 27 Jan 2025 00:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jhyhnFmT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Cmx9ejts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51EE380F98; Mon, 27 Jan 2025 00:57:53 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1052580F85
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 00:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Yh7ld3tNGz9smP;
 Mon, 27 Jan 2025 00:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737935869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7042rKeVj4uZK3oL4MAvrmTUiHkmy84Zpe/PpeRzBTk=;
 b=jhyhnFmTDho434TLFC9iWyaQHT4cqmLCKKAoqKI76kvYr+CVyjrFRazk5k3CUmMJ9PNWwE
 2jYltHdddnHOsXX2/XgEuJJchJOM4BRf4WqGmPbgcSmrFcjF59iDZ6vP6Nt8y1/IuJaH+P
 f/tYJp1BdnlcldhcWsJ9/7TYt330TKLkO91mH8UTorMsktSZWflpTYrhfKtSlAZZdxbaQU
 uB2hnptCvLcpvv6P0r2i7mMks3mHv+IRrdZOffTN0Mt96HuGWGc4AfCqgoSWJRC0GkJuea
 9/AchtECgx3KNPE7WzQJJEk0XEdT+rE8Jq/blVEH1+tN8mf2EYSHPGSqeMGJ7g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737935867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7042rKeVj4uZK3oL4MAvrmTUiHkmy84Zpe/PpeRzBTk=;
 b=Cmx9ejts7qH6bVmfzrmWAbyFt3RSvOb7GCKSWsrNY9mehfZXEn5xy/enoc4MF0E8M+tq83
 MuOY/m8Fyo2ypsLB4AZ3h9DBHWoHP8dIqqNHMrbVdGwz98x/+27X3HP6oUcPSz0h92r3vA
 /ISuanl9Y19ieOdgpDGgJm88c4bmcb5vfXbkSB8Py0880qAwf62ePRY0c7T5n3dn8gIda9
 T6gjmQZlmF6I70hubPpA+V2zEuXAfWZqMVx64ZVJ0txtjl6TNGBfNf8XBx88YN2pRmiVfW
 5NGcCddDOk7+3HfqHe9zMTX7STw5cB1KdM6N0W3Sg7YfZrCACjVAfHp29bCAZw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Subject: [PATCH] test/cmd/wget.c: Fix loadaddr rewrite
Date: Mon, 27 Jan 2025 00:57:03 +0100
Message-ID: <20250126235728.500853-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kuhqwpaaythyoacp1w8nodo5nw1zx4ti
X-MBO-RS-ID: d03ccae2d78653f1925
X-Rspamd-Queue-Id: 4Yh7ld3tNGz9smP
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

The $loadaddr variable is a hexadecimal value, not a string, it must be
assigned using env_set_hex(). This may break follow up tests, like the
dm_test_cmd_hash_md5 in CI. To avoid any interference with other tests,
set $wgetaddr variable which is specific to this test and use it in the
test.

Fixes: 20f641987f83 ("test/cmd/wget.c: move net_test_wget() to the cmd test suite")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: u-boot@lists.denx.de
---
 test/cmd/wget.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index b020d20ad70..445750660c2 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -217,28 +217,26 @@ static int net_test_wget(struct unit_test_state *uts)
 {
 	char *prev_ethact = env_get("ethact");
 	char *prev_ethrotate = env_get("ethrotate");
-	char *prev_loadaddr = env_get("loadaddr");
 
 	sandbox_eth_set_tx_handler(0, sb_http_handler);
 	sandbox_eth_set_priv(0, uts);
 
 	env_set("ethact", "eth@10002000");
 	env_set("ethrotate", "no");
-	env_set("loadaddr", "0x20000");
-	ut_assertok(run_command("wget ${loadaddr} 1.1.2.2:/index.html", 0));
+	env_set("wgetaddr", "0x20000");
+	ut_assertok(run_command("wget ${wgetaddr} 1.1.2.2:/index.html", 0));
 	ut_assert_nextline_empty();
 	ut_assert_nextline("Packets received 5, Transfer Successful");
 	ut_assert_nextline("Bytes transferred = 29 (1d hex)");
 
 	sandbox_eth_set_tx_handler(0, NULL);
 
-	run_command("md5sum ${loadaddr} ${filesize}", 0);
+	run_command("md5sum ${wgetaddr} ${filesize}", 0);
 	ut_assert_nextline("md5 for 00020000 ... 0002001c ==> 847d5e7320a27462e90bc1ed75eb8cd8");
 	ut_assert_console_end();
 
 	env_set("ethact", prev_ethact);
 	env_set("ethrotate", prev_ethrotate);
-	env_set("loadaddr", prev_loadaddr);
 
 	return 0;
 }
-- 
2.45.2

