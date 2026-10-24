Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E987606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OXmOyPsp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l2nxb8fx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC7C960683;
	Sat, 24 Oct 2026 22:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nIvBjeKvn_kN; Sat, 24 Oct 2026 22:36:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B47186069D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881354;
	b=BGp3VVei66O7QrWMoVJsCxEMcVNhj+aR9jSJcMcmM49Umj5TvGCl0G7cNZQ79pYO1Uan
	 ihkjEHcMZIxEEggrFi9KCr1lXuwGGNiESNUhDw9IWLZ8xhkQ1Hf4hAEaIONcOUZmEwuqw
	 NqnpxXbXpTGmarXrtuKvfhbxdhuTPh+taE/oZmhMpnwNPDjoMOTQ090LsKHwk9F8Qjhg+
	 R436AnfisbaQXCMUcsvEfF4QQ89ChTFNQnEb7LJ0HM/UToHmIsWKssSqHRKPmJQD1368p
	 9B/DP5nv4OpOiRh0Z9bQABxGG6lLT72lYaXx5oJSXmp8cEx5NDsLWstP9MZ7QHiMGpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nb1ehsyn7NK3z7/aozvlZrRYC0d6q1coVbHhbGGDHqw=;
	b=FuG3n2FFAM0P68vr+6m4nwA5XqYOloTlCoaznCfYav6tCy2LS45FtAzxQP7A0a8SJZBc
	 sUPULu0uxqjFGD6Euf7Ekdtb6zdAlQfoe4vJd/n2JMRT8kN7OSkiOxZ9/3T2cwW4lSh0k
	 FqnDKZWuZnjbwQi2z/gDzuW55jPl0hAQ5EGT77CDpxlBIE02nBjDuVKiI6U+XnUh0JOaj
	 JHkdRBAOHJ1DrlA1P4U4UsnJepZekDed/qdOWV6UQss3YfrMwvs0kN4KZPrjr8jd+FMBw
	 yqkZTAXbLh5KLde7GkOuQfKpAspqLXLsvhXfw1SseIYJJbLWMnio8jRL6Nabr4OX4lg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l2nxb8fx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881354;
	bh=nb1ehsyn7NK3z7/aozvlZrRYC0d6q1coVbHhbGGDHqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OXmOyPspyT2jchkfCKvOK5eHqCCRIY8HY7Y2hDoR2PN0bOzPVw4NzNQ+kJRFfieJ3
	 E2soAvbX6OWGzTKZBBxMrWUZMiALLKr05MAt2WYhdA+ti8RFgJmkBxpuhNw5uOpKam
	 qj9S7w9G/+UM7P7lSjD5gxi4xbUBhC64/zcMgI8Ww1Ncxs4g5rIbJE3dexksvKs7eP
	 HEnh0mdLIKVHo1pFAkPzva0YxBX/2GU0DmhFo2vLaCCY9vffFVDcpPBLxcQZgN6Bl3
	 lRWdS307yU8Ro8XpiIoJjQyL4WV6UNvVx/bAgp7zj9RZ9chgqzgLup7LjLs0CXWElC
	 tHf18IxHO+6DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B47186069D;
	Sat, 24 Oct 2026 22:35:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5F073C4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E22AA606FD
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KewaeFzGZEfy for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25CD160617
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881335;
 b=QahzXDfVpGsS4L8Ulj2wSa8yoyqjF4Xr+VlZ6I8c1l9L1YBdM63aCpA+L5DCpyi1GsSg
 GNPm1EUAFgi68pC8FbIv+yxC4qL/xDR3k65160WCh1p5oicPpXBPTvQz3EF6/ODhgWYVa
 MUN8QxJj3A9HP5AsKN+fwM3lwZee5VAlWqOica5yqiLRy7EL/NV5lDCKBVPO8tcJ9Xybn
 agfYm7K/J+XExJyEdNVQH2f5/Q2PyLXzLQISx/77GSqufF8VS4G4fnLX2Bdh372R1Wun9
 IqhxKvQww8pv0Fgv91zlSsMiAUoLeS4TD4qeNeZWvcWodl9In9uZp2FTqzW1xIrslJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881335;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=nb1ehsyn7NK3z7/aozvlZrRYC0d6q1coVbHhbGGDHqw=;
 b=n4Q0/AAZ4YjCmHLXdFoGSy9SV/ZMdUDR1wff9VD6v54IaUvHbIgBIyfiFnVDZGjwDu7n
 0LFYOrqWbWqsZUx9luEcRCda1mpFZVJ3EgJcV2+C0x/whOwvzXI8YWdt0V+w3DYLESc4M
 RPBdJitXdFEjHGlHuH58jKhxDy5TfJahzGiuLhBw0UaR9s0tu0bYvKTx99GE5Mwtpt3IE
 5h5SdkHkswyWZmqdb+X5n1YBqzt0wMXS81mAmuCCELWZrNyiKrwrKMAi9yifqn7yW8naw
 1UhL25fUAAzdnmBCn5oAM6+J0NClj44/9dbaU3gzEH1EMYhi0fI3noUmBQtYHNNNxpw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=l2nxb8fx; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=l2nxb8fx
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25CD160617
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:34 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-483a66818edso973844fac.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881334; x=1793486134;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nb1ehsyn7NK3z7/aozvlZrRYC0d6q1coVbHhbGGDHqw=;
 b=l2nxb8fxE7/DyP+b61tQjk+XfCabjNUNWaPUj17JsEJ3tYxf8x+xKbmMEo13zaqu47
 NfCaipc04vvifn7d+TmAlazxhYM9+ReU7WeeW44h2CfWzIzoccbW74lsOPM2r6mNpQhm
 Fb2TmOeAhyhQRu4D/pamfqUk6fPnV1rNsKMX+G9TQtWvMIkaomHBY6spk6fRlKwA1yvJ
 5Y4dfEJIYdJsHfz7ZGiw57rMsyJnLvvrWxIfJGlqfPdFFuY5b8Eqj/cJJy0vonEIChFn
 KPnXaQ9yS/Yz7BFPh95shi9NX61yEX9d3CmLLNU1C6Ivu+GGw7sGH2XaUqk2txY3Z027
 umyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881334; x=1793486134;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nb1ehsyn7NK3z7/aozvlZrRYC0d6q1coVbHhbGGDHqw=;
 b=twPUyH9LZry8LcLj+6iGTyBml3AZzc3quxE3RXRBNURm9ejutT16190bBbRA0Em3kV
 oZUSrm3oRpCVWCL7dYURp3ZZQVKcuQDeyallMM7J9ybpJnbSJ2VZ5Eudwd4mJ0epR6kU
 DEqUzCvm41qW1W5lYcCyWCx2UvvHeIdKtGjffPyOlF3rfL6fzpLEWscrK78BiBU0u4Eg
 WIqe5HHZF77pWHaJCWcBDvu8Fwb9X9jHV5O3MOh7PfcfUckvfM5qelwfblaLSp6AcfNE
 lZ5xyyu9VWUAN6ruJXDopcy67kgA2YQa5tuJX0y792HD3bwVDenCohK0h/IcDVF1opOc
 VlDw==
X-Gm-Message-State: AFq9FYLW3P2ISCfMlfhNlFfvR8dBy81mU8wIRxNnxD8OXWhT82oDPzhi
 a0HEPFI6eXoHtFRacwAPLdQsphd+r1Jo4iE+BrdeujZXhv7YBvmnCkCy
X-Gm-Gg: AYBFou1qI+QA5ie0LsJwB/jy+ByidFoTLaYuzUoI/1S0c974ew6Sag8ryML9ImpVoXu
 zAgUF+PLCAbIWO/PeONCHIsEcYgLvnQp+lAQvs+HCwV3w2CaWaF6Y2OuafbZCIp7H4iPNg0Hocz
 +n032EdpYXOSLsN36RpcO64pW30ietjvaBEIRJfnWx/SZZuGZ0EktNRaXe5fO5kiPWgjif2QauI
 N957FlmKkVlcFAvoJYD5zm27idncZLIqkz3fSf3XQjbhnyIKyO2Of5OhGV/bTL6RyAlD05yVb/V
 8zZj6CXSTh1sQqE8Oodtby7SJldg2e5hB/8sT5veKrUZha3TmEaoMn4xYsYWDBJVTjArrg2IaTK
 9BJgtfyBHIkwBOPsKXPR6T6cZcb6wqc38CTsYNDkt9DLuukSA4dLeoyJN6ofmap6s07UvWQDDNT
 ttNyFQEHCeMo4iH4RuO05N0x/oKTQp3cFNaMP2usLGVhzrwjSr1m6m13ZotipDqmO30j1GnUref
 LLL2cWlCM9KWGqFX3NlXBSa8dkRB3lzam99txyTFLDkRTQtobZqGyC6aNYp31gbkIPHBGRi5y9n
 dmratmzxsVm36XoSAt5offNhZwLYZObvoh8/PMlsfvVKla4qGJeyemOCBWgpPsvGHE45Dc++++5
 ctWpdjmwx+aR8zZM5ERAXfgHDOhuHIJ/EBNcoUxIri3E0T4taPhntpyCv7WDU38mLv4CDj+Lenw
 GA/og=
X-Received: by 2002:a05:6870:9a14:b0:475:e066:7714 with SMTP id
 586e51a60fabf-4a83f47c04bmr1952508fac.27.1792881333813; 
 Sat, 24 Oct 2026 15:35:33 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:58 -0600
Subject: [PATCH v2 11/16] cmd: bootvx: use stack-independent TFTP downloads
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-11-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The TFTP path is compiled out with lwIP even though a common
download-only helper is now available. It also parses the word tftp as
a hexadecimal address, leaving the local boot address at zero after
the transfer.

Use tftpb_run() with loadaddr and keep automatic boot disabled during
the download. Reject failed and empty transfers, then use the actual
image load address for the VxWorks handoff. Reject tftp explicitly when
the download command is not configured.

Exercise successful, failed and empty downloads in sandbox, stopping
before the architecture-specific handoff by leaving bootaddr unset.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/elf.c      | 29 +++++++++++++++--------------
 test/dm/tftp.c | 25 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/cmd/elf.c b/cmd/elf.c
index 53ec193aaa6..a3cc051991b 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -130,23 +130,23 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	 * Check the loadaddr variable.
 	 * If we don't know where the image is then we're done.
 	 */
-	if (argc < 2)
-		addr = image_load_addr;
-	else
-		addr = hextoul(argv[1], NULL);
-
-#if defined(CONFIG_CMD_NET) && !defined(CONFIG_NET_LWIP)
-	/*
-	 * Check to see if we need to tftp the image ourselves
-	 * before starting
-	 */
+	addr = image_load_addr;
 	if ((argc == 2) && (strcmp(argv[1], "tftp") == 0)) {
-		if (net_loop(TFTPGET) <= 0)
+#if defined(CONFIG_CMD_TFTPBOOT)
+		/* VxWorks, not bootm(), owns the downloaded image. */
+		addr = env_get_hex("loadaddr", image_load_addr);
+		if (tftpb_run(addr, NULL) || !net_boot_file_size)
 			return 1;
+		addr = image_load_addr;
 		printf("Automatic boot of VxWorks image at address 0x%08lx ...\n",
-			addr);
-	}
+				addr);
+#else
+		puts("TFTP support is disabled\n");
+		return CMD_RET_FAILURE;
 #endif
+	} else if (argc == 2) {
+		addr = hextoul(argv[1], NULL);
+	}
 
 	/*
 	 * This should equate to
@@ -333,6 +333,7 @@ U_BOOT_CMD(
 U_BOOT_CMD(
 	bootvx, 2, 0, do_bootvx,
 	"Boot vxWorks from an ELF image",
-	" [address] - load address of vxWorks ELF image."
+	" [address] - load address of vxWorks ELF image.\n"
+	"bootvx tftp - download the image using TFTP before booting"
 );
 #endif
diff --git a/test/dm/tftp.c b/test/dm/tftp.c
index b70aa6f4722..45612e066e5 100644
--- a/test/dm/tftp.c
+++ b/test/dm/tftp.c
@@ -503,6 +503,31 @@ static int tftp_test_download(struct unit_test_state *uts,
 	ut_assertok(env_set("tftptimeout", NULL));
 #endif
 
+#if IS_ENABLED(CONFIG_CMD_ELF_BOOTVX)
+	/* Stop before the VxWorks handoff by deliberately omitting bootaddr. */
+	ut_assertok(env_set("bootaddr", NULL));
+	ut_assertok(env_set("loadaddr", "2000000"));
+	ut_assertok(env_set("bootfile", "update.bin"));
+	*net_boot_file_name = '\0';
+	ut_assertok(env_set("autostart", "yes"));
+	for (i = 0; i < 3; i++) {
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->fail = i == 1;
+		ctx->empty = i == 2;
+		image_load_addr = TFTP_TEST_ADDR + 4096;
+		net_boot_file_size = 1234;
+		ut_asserteq(CMD_RET_FAILURE, run_command("bootvx tftp", 0));
+		ut_asserteq(1, ctx->requests);
+		ut_assert(!ctx->autostart);
+		ut_asserteq_str("yes", env_get("autostart"));
+		ut_asserteq(i ? 0 : sizeof(tftp_test_data), net_boot_file_size);
+		if (!i) {
+			ut_asserteq(TFTP_TEST_ADDR, image_load_addr);
+			ut_asserteq_mem(tftp_test_data, buffer, sizeof(tftp_test_data));
+		}
+	}
+#endif
+
 	for (i = 0; i < ARRAY_SIZE(autostart); i++) {
 		timeout = i & 1 ? NULL : "7000";
 		retries = i & 1 ? NULL : "09";

-- 
2.53.0

