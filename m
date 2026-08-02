Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A78C55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 22:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30DAE4061D;
	Sun,  2 Aug 2026 22:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txF71FfZPUXg; Sun,  2 Aug 2026 22:09:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0654E405F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785708554;
	bh=cMQXb4yHpgffo575YyTfAcAYnGHPJvUnUVSTWoQ9gN8=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=klUzL0McuF5AJQoR0pqSnjiyfjbFc/guaEZyhFGJXmjqez5Ekdka8nzEIOrcYKDRd
	 c34bhEV16JlbB75VD3/YQPZIJtIGeByNTXWuwrvhZriAMJdMb4pgKEV1FSxFCrAZaQ
	 Dkh+l6oZwpCq+JoRvkBIkEoL/oHVye0Ky6XLFPm5hfSPdaKGTLgg8mikjivdQt9lmb
	 drfQKVqL3qijIpk1udhM/XCgDHPCphx39LwAsNH1Qs8GA9M6n9o++gld0JBxur0wJ1
	 aF+wcydzATLGZmsh3A3ZLEQShgs0ElZ3ZproRIyN0CTIgEgrNOTKx0qzg25YDd7rwn
	 wirMBw8ZSGAvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0654E405F5;
	Sun,  2 Aug 2026 22:09:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BE8F3B9
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 22:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51B87606BA
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 22:09:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l1y7RoIFa9DA for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 22:09:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9715B606B9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9715B606B9
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9715B606B9
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 22:09:10 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hCv910KpNzMlLv;
 Mon, 03 Aug 2026 00:09:09 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: scsi: Drop duplicate leading scsi prefix
Date: Mon,  3 Aug 2026 00:08:38 +0200
Message-ID: <20260802220904.168737-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hekbsjdt5t5kny7aqg1na7ua3xii1ggi
X-MBO-RS-ID: f45f42010ea858a2e82
X-Rspamd-Queue-Id: 4hCv910KpNzMlLv
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785708549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cMQXb4yHpgffo575YyTfAcAYnGHPJvUnUVSTWoQ9gN8=;
 b=hTo1xvJVQRVVCiAN5jXPx4GZLt/HTWA6iQhOU0KquB1kpSI6QVnnLQlB6cjLnOCIbdARu/
 Ei0u58rx4N7IwjWJq3aioeiKC0cfqhedOQLIaGrMmhsZRmM/xr2kW7FEZglo/sSDK/IJQz
 WHs4djzxrCnDr7/rI8hqWE37xejS2zg+UhEpGSSK2O/l+Sx0x3WqKeE0ARpOdvclCfoRmi
 8JX2Tg6rQe+XnKuJVuBEePn1JTF5H7xuPdECQALRcPL3dbRzZu63jecCCxHUmzA/FHqWNT
 R7DJW1HFCB3U+MXxDNE/slihF07a8cZ7r9TyquzX8BH4itGJTWfb2kE7llbw0Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785708547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cMQXb4yHpgffo575YyTfAcAYnGHPJvUnUVSTWoQ9gN8=;
 b=GfCr/kz9COHOK4bhg2ExsxyUvZZJlem1xd7KpTR9yM3uNcM/rWgv/jzc7rkXI4rD4pVqw6
 5iA45sKNLDxEodQzufhAykdTT+dx2LVgpWuQGcdQ1rfpxmU5sCC2LOfMYS5ShTkcnN0U1L
 RPbtZSQNrJrfEXeB7b9+c2nALf4bICUzvLuI2nto46w/t6XnjkC4gakIuoM21uICSyGBwe
 F1D01O0RQd+OVfes5RzZBFLrAi7aAGVBineOt9R8yx2le30R1uNX9EE7tC2UL6YfFOGqfo
 uzCXkRvE7uQbJvu6o52sGVKlJGnjqptKihQm8BlyrTrz4A6okFriZAH6emQFDQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=hTo1xvJV; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=GfCr/kz9
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="GfCr/kz9";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The SCSI command currently prints the following duplicate prefix:

"
=> scsi
scsi - SCSI sub-system

Usage:
scsi scsi info  - show available SCSI devices
^^^^^^^^^
scsi scan  - (re-)scan SCSI bus
"

Drop one copy of the scsi prefix.

Fixes: 460c322f13ec ("(re)enabled scsi commands do_scsi() and do_scsiboot() Patch by Denis Peter, 06 Dec 2004")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 cmd/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/scsi.c b/cmd/scsi.c
index ad7d8a4b664..5e732c1e50a 100644
--- a/cmd/scsi.c
+++ b/cmd/scsi.c
@@ -45,7 +45,7 @@ static int do_scsi(struct cmd_tbl *cmdtp, int flag, int argc,
 U_BOOT_CMD(
 	scsi, 5, 1, do_scsi,
 	"SCSI sub-system",
-	"scsi info  - show available SCSI devices\n"
+	"info  - show available SCSI devices\n"
 	"scsi scan  - (re-)scan SCSI bus\n"
 	"scsi device [dev] - show or set current device\n"
 	"scsi part [dev] - print partition table of one or all SCSI devices\n"
-- 
2.53.0

