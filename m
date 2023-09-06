Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AC5EE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE77686A1C;
	Wed,  6 Sep 2023 23:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Mk2NMylq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WeL0iXuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21746868BC; Wed,  6 Sep 2023 23:30:51 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB31E869B1
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RgwXR5yPKz9tQX;
 Wed,  6 Sep 2023 23:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5EYREd7sbDi0kGvCCa4y4+M2gykrNeAwymNWBLPvWc=;
 b=Mk2NMylqRz3vf/RmGmrt2fyxSg+kkFmBofZeQ3ynmqEUiyeXNwhm6Ock9BiMzCQ7hiQVfK
 Fhh+gIvdMEKiwutYq/lI5/7rtLfVQLzWzvWhQ/IcTLB1MobAt7uJCWE+Zh9RX8hpb/WzJk
 fN2CQ/9X49E6z6mg02lUXFtSsnmsdnY3nIFd8PqzI/To0MSPx3/I2oj+D2apYl0RAHnASM
 7ygH1my8hQOKBXNZ79mFKtFBknbkvLFS3IFoZUNiaHVgZPBJ3aseWliMqDo1Tie/T8S3Tn
 4DI9U6tfG3m5c/Jlyteb68uxnN9TmeD/TcEu9GNzAJyrWRGDqrl9rCHi4JD37A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5EYREd7sbDi0kGvCCa4y4+M2gykrNeAwymNWBLPvWc=;
 b=WeL0iXuL9nNqCtZfoWAQsrYdML1Sk90HOXBxkOOXki93qmK+N5lektvSg00CrBej77zvVA
 XXOFEWSGvlbwTNVNkPWZLGzkwevL7Q0RClbfbTUqU1mL5NGHkkOGgPLqAe/ok56JZuzcBp
 16hBt9E9nfX28cIVxDrJw5dO/5gSAAXRfLRz4150wEofKo/Ktb/J/okbf5Diza6mf3kpP5
 tCOsNdC+kvXMICCs/+QomhPT8ci9aE083sfcLtjgzY5dx77pG9kFbkh9yvJFT6IOXeNgwj
 pJFHBURTYb90yplW2rjWgwUXI/VNvjL2CrUmkOTJO3kuw6ADpKDIHlBOeWQhwg==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 12/35] cmd: i2c: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:52 +0200
Message-Id: <20230906213015.203437-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3566981aa4557ab7bd6
X-MBO-RS-META: sjrbz4xcmqigo99spj8pqoqap7mc4djq
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 cmd/i2c.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/cmd/i2c.c b/cmd/i2c.c
index dd803ee2271..f0a5fa2e741 100644
--- a/cmd/i2c.c
+++ b/cmd/i2c.c
@@ -1939,16 +1939,6 @@ static struct cmd_tbl cmd_i2c_sub[] = {
 	U_BOOT_CMD_MKENT(speed, 1, 1, do_i2c_bus_speed, "", ""),
 };
 
-static __maybe_unused void i2c_reloc(void)
-{
-	static int relocated;
-
-	if (!relocated) {
-		fixup_cmdtable(cmd_i2c_sub, ARRAY_SIZE(cmd_i2c_sub));
-		relocated = 1;
-	};
-}
-
 /**
  * do_i2c() - Handle the "i2c" command-line command
  * @cmdtp:	Command data struct pointer
@@ -1963,10 +1953,6 @@ static int do_i2c(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct cmd_tbl *c;
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-	i2c_reloc();
-#endif
-
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-- 
2.40.1

