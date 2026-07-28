Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195CDC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 17:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 902F3608D1;
	Tue, 28 Jul 2026 17:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MRp-E7TIVP0F; Tue, 28 Jul 2026 17:53:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B96C1608A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785261221;
	bh=BDiKJpbGuRA87P44Hs5CvwKt1FykJd2VgoMD64/Xzw8=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=DzGIlWovYWDPTYk8/FTCeeDuXPD8251hBO46sJi0g2ExgGZK0ebFW008tBh9W56Rz
	 E8fiaANXPek6O4gao881K60jWFgxYIugiZ9Hln16afY8GKP7tjK1aNke+cmpVqZXu6
	 HX6EdXuJkrv330BiGK4L9q7nLjHI0qbZIaL1oOISOY+7kOrX0FtO+ltE8DBLxfjtlw
	 9HB2vPRVDZio6Gxaj1BlB5V7x42yYdiNTTwODm80LuuogDx2LpFFo/W/FEaZcdGMzC
	 0QuUSzGlfHBE8IYlauIR+Tv1JP4WQoTevucl19VjuAxGAvAWAQt64vNTmmx4pdyuCi
	 2/+F9OG1N2BKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B96C1608A8;
	Tue, 28 Jul 2026 17:53:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1443445B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EEECE608A8
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:53:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIHx8ihhwl8J for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:53:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2B02460810
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B02460810
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B02460810
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:53:39 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h8jkT5dH3z8twZ;
 Tue, 28 Jul 2026 19:53:37 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] README: Slightly rephrase env set and env print paragraph
Date: Tue, 28 Jul 2026 19:53:15 +0200
Message-ID: <20260728175333.90971-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ejcuyg38dh45sam461ef17y6rdxag1pz
X-MBO-RS-ID: 0563d14b82e5ffbb748
X-Rspamd-Queue-Id: 4h8jkT5dH3z8twZ
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785261217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BDiKJpbGuRA87P44Hs5CvwKt1FykJd2VgoMD64/Xzw8=;
 b=CsF4dZ5FoY0ut6nu1d5uJkXssDVp5JvvfJ0PjUtjJXmtB+Gg3Zr5B3KgdLRa/87NBCePEV
 +819yIBZTTewtXCzIFrD4/iBY6eDX6LN2sNbZDh6DBJ26I14GAdjUEDP+p15LWSz2XheHS
 AxdRTF4AadRO3zDd9REOx9crlL2gwTEiH/nqpxejMMrQdLHxwrsxIKSeir1J2JqEHQT221
 gyA5Fa63tLCoZU/GGpmyoSnWbjGxJcN4ASRolxoT9DEgv9peIPa0cOxaZBgdZDLhA3Lgbo
 IF/aVWsbbrYa7rmZEuAtJhNAzWE6+HkmUJLjC3Uqwe6W6BnrfLnJ9+S0mDL6Wg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785261216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BDiKJpbGuRA87P44Hs5CvwKt1FykJd2VgoMD64/Xzw8=;
 b=AFhHiGlUBFGCRdi38ZgynVoRjdnxyhPZWc2GLtJCi6BenaBYFwmHlCoyQs83tIucXhBS5N
 djuCLfSjak/e8HdMDLI4xuqfXiIolfpa0dPGnICsCg0Tbi/8SOlmJetdiwIvAmYEqVOhZK
 B8rq6Ur298Jf0B2987GMrU0vZPxMoCzGiaLkOtlSpz5OLOwLjnNkecTL7p1LyH6RfKj7j4
 HB8VpzmjX1oJE/mDvc8QrCYJkRC31hMp/nRo/Y7FSEHZrp9tO3UQzdrSP2X72AJ0t85yab
 5iUq8Zekdtx7krJ2Z9eseXE5RZfQBl2h78UzmLQ/U6+sY86301M8XRNpIZGHlg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=CsF4dZ5F; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=AFhHiGlU
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=AFhHiGlU;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
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

Adjust the paragraph to make it a bit more readable.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index d6dd6c74619..f740188a4bb 100644
--- a/README
+++ b/README
@@ -753,8 +753,8 @@ The following options need to be configured:
 		`${name}'; to execute the contents of a variable
 		directly type `$name' at the command prompt.
 
-		Global environment variables are those you use
-		env set/env print to work with. To run a command stored
+		Global environment variables are those you use "env set"
+		or "env print" to work with. To run a command stored
 		in such a variable, you need to use the run command,
 		and you must not use the '$' sign to access them.
 
-- 
2.53.0

