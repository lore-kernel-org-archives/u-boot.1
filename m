Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672B2CA9ECA
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5AE760616;
	Sat, 10 Oct 2026 22:32:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bWVMbjEUhzW1; Sat, 10 Oct 2026 22:32:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0ED4660678
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671534;
	b=szXMeJMMQEhQiBIKQTXaqIIpwBNPkDGg/r+0/dp8ZpJQXllcWHiWMQD3feAb0fPRjr12
	 lvMBtx6wteyOBv4qmGDeBt/gTVmXZYbLPgkJJ+NFzQOtRp9TxryZeMpCzN2Va5E31VHJE
	 pEsBQo+MWqxCqCjV61saNguYLYitZMt7eRQ2Qyw0lDSR7AZ++3GK8SFzKk8RRGlKnHK0m
	 omGZxK9okuNb2PwVqK9ABgrgsxdq0iR4Ht0zrmHJxk2dsiSYUf2XWIzq9tzDRWDyXrbGq
	 +U7bslUeDd9soWe0ynZvXx8HDZDwJ8y5YGB1O5fUOUiCY7zkeNDaK4apYvaxLa0djyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=o+uyYw45AKo9f04ihBXJf+IC5x4Z3TVM8SvUHo6cf3M=;
	b=KQNn8EODtAR5YkOZh0snMvFoSKxMJCK97N2JzsxmDLntScjSaVUdj8SjJJZmAehKMjeT
	 qdzuPZJTEUYQKs1xZoB4xsKH06U3HXu36p8y0nSkj0P0zaZ+Cd7fXOiPpdecHi1X0foL4
	 8SF6XW/eqimNLC+OccLZjNnJ5KE/LlYzN2RP8E0XSzHuhr3M4FtZ+/WhQrmVx49YW+H4y
	 Qj3XaCoaVlHPoldPhh+q/g8O0G/r0gpipWMUcmqtpqVT6my5JgnOGMGzet+I2gEhmN4R0
	 4jj6ysewTVmuEhrM4/g/xyTmHqrASQbfZJ96bDImoXtOhBfjEJVtEi8x2YTuYfzuuYA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671534;
	bh=o+uyYw45AKo9f04ihBXJf+IC5x4Z3TVM8SvUHo6cf3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=VZPmm3KMzf1m7OpQEpx6Z4v6FH8o3KG6DcwVT0aEhItmkZsalmX0vv8IKx/oX2T2U
	 pBATcME5H7r1GwW5zoX0i1dlsViFL2xiBTZj7u0UHRJ4qaEm1Mq0uW8tEgHgmY/+9x
	 WjedYrMEAX+1zbaZWPUMa+Z8RJlW62GoXt5Fklx+sDsjxUaaVXLWllRelVhYW7B3GO
	 du7Lo4FKEZUJX3/MapQC4Io3cf+OPLLuGaDii5LzPIvdDsBLTZjsqwsx3SZFTnXu5w
	 9pkN8MCCTIUAulxOpuUCf6UCF0nIJLgdSq6r7eB7lSaJBqLemwrrU+3vchlbw/Nvpf
	 TqwOi4kq9TbzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0ED4660678;
	Sat, 10 Oct 2026 22:32:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 43F57356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3579A81021
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ttH-h93-ozPF for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 87F3E80E31
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666488;
 b=s/Z6X+dgwl+c3/5H9Zf84+GXd5z9VtdIoLJHjbmyPaDOLRzUauw98i6/pjWdQqK3oUUV
 Sj5WoZZgxPz8Qv1NGLYAk0mbURePgkM9ApjBfMKZ0j1z4KjrYrRG7WNUZCdNSBFeO97hQ
 0sSN2cwmSnUw+soDHGi5F/hJ+L8KUXl9n3ERnsxDTQBv8IEER+OXrr7InpDUjp7V5bPoG
 UhBy5cG8bUwEkk5hrCisyKNdrkwZOKuJq6Cvl73NFH8eMnDjkmJsi44hZGwrDkexPPngh
 JkvYQvJpfduIhkWbQmkeVfK5ZRP3INF24ecDnW2NPdIuXfGIrK/bV+X1UZo69sihdXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666488;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=o+uyYw45AKo9f04ihBXJf+IC5x4Z3TVM8SvUHo6cf3M=;
 b=KpnjYKsIO6rkVfV0hrqfdRTrk96A5rtog8cPktYyKeMewNAKFXxTN3g9EufkjwunNxzS
 kvliGkq9VhbCLafL4EH2CGSKPeWzB10d+PFzK7A2Cv+moNOuSfLFpBRjbwjLl+DaxtBpU
 YyvG+faawPcs5V20+w0pILGfW/bQrTP4Kj/9Y0E7lhhJL2uVFtH6Tn+kA+ysbBNGXfTHX
 pJUjOvAJP3nsmD+OnNFjUAAdIgO4TVk+bEytuNFjzbJaGjlH3oCw+Haz4v4e0kcw0zoNp
 i0tkbcXqi70vzUBjZQ/ZZx+yjdBRtdLoBmTEfzSzyR0p5fLxs39B5I/7FL7eOkulCdw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Lw2cRssW; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Lw2cRssW
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87F3E80E31
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B06F43ACC;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BBE1C2BCFC;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=i97Sy6Wh+NctkQk+pdgAz2r2V4AJDcF+UVCxP/BjKvw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Lw2cRssWi504KK59v/BngRk9NOfS2pzf/x9Nt8oZjCWlAsmGcsl3ylPLISmvQ7fBI
 h87hUwwUT1E6cjR2JN6upr0tkcTOn+34xOsFmgc2P8FCLj6E/aeEYs3oW5rZDiFN1l
 qh9b1WYCpTMG62RfeoOgieQdanHEBdssN0RIXKcMunRTWP6Ogdzp7i4UFJobxR9Dqm
 YX05KwF/JqAiY1EK/8adJcfAVxIW69ZEt5gM9tl4tW28qYqmrUyhIGUKjfBtwgJFwy
 AKMvQdtbv9p6MlFgN6O6uBuGltduUIpLzqzfGyUhUuOfIgQlyp82Y3VwCUpMocpRcd
 XZ5iJJWVsEwfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 58CABCA6017;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:55 +0200
Subject: [PATCH 07/11] cmd: phonemenu: show Android boot reason in the header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-7-bfa23de6eb0b@protonmail.com>
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
In-Reply-To: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>, 
 David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=2309;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=3uGxjR5xccjqyRoM2E5zcEMqUdby+oWh6OvZX/sGuOU=;
 b=KZxKVZtByrpT25GLtvj/VU0dl9MUOwaFjsd0DRQ0Uy/h71x0+v9wKPP5e77XqfJNX+rAEw2dE
 QuiBeLl672NDLXZlYYaV3XAmdwHMBFcyi7Daquwj39CZf+ncycfFhBz
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 22:32:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Show in the boot menu header the boot reason read from the Android
Bootloader Control Block. Each field on the header line is
independently optional (NULL on error/absent hardware) and simply
skipped.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 cmd/phonemenu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/cmd/phonemenu.c b/cmd/phonemenu.c
index 7478661d049..8f29d8d704b 100644
--- a/cmd/phonemenu.c
+++ b/cmd/phonemenu.c
@@ -2,6 +2,7 @@
 
 #include <android_ab.h>
 #include <ansi.h>
+#include <bcb.h>
 #include <blk.h>
 #include <cli.h>
 #include <command.h>
@@ -471,17 +472,53 @@ static const char *pm_slot(void)
 	return slot == 0 ? "_a" : "_b";
 }
 
+/*
+ * Boot reason from the Android Bootloader Control Block on the "storage"
+ * device's misc partition. Maps the raw "command" field to short labels:
+ *   ""                     -> "normal"
+ *   "boot-recovery"        -> "recovery"
+ *   "bootonce-bootloader"  -> "fastboot"
+ *   "boot-fastboot"        -> "fastbootd"
+ *   anything else          -> the raw command
+ */
+static const char *pm_reason(void)
+{
+	static char buf[32];
+	char cmd[32];
+
+	if (bcb_find_partition_and_load(env_get("storage") ?: "scsi", 0, "misc"))
+		return "normal";
+	if (bcb_get(BCB_FIELD_COMMAND, cmd, sizeof(cmd)))
+		return "normal";
+
+	if (!cmd[0])
+		return "normal";
+	if (!strncmp(cmd, "boot-recovery", sizeof(cmd)))
+		return "recovery";
+	if (!strncmp(cmd, "bootonce-bootloader", sizeof(cmd)))
+		return "fastboot";
+	if (!strncmp(cmd, "boot-fastboot", sizeof(cmd)))
+		return "fastbootd";
+
+	strlcpy(buf, cmd, sizeof(buf));
+	return buf;
+}
+
 static int do_phonemenu(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
 	static char slot_line[96];
 	const char *slot = pm_slot();
+	const char *reason = pm_reason();
 	const char *sub = (argc > 1) ? argv[1] : "main";
 	int n = 0;
 
 	if (slot)
 		n += snprintf(slot_line + n, sizeof(slot_line) - n,
 			      "slot %s", slot);
+	if (reason)
+		n += snprintf(slot_line + n, sizeof(slot_line) - n,
+			      "%s%s", n ? "  -  " : "", reason);
 
 	if (!strcmp(sub, "advanced"))
 		return pm_run(pm_advanced, ARRAY_SIZE(pm_advanced),

-- 
2.55.0


