Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89B4C61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 23:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EB87407E2;
	Tue,  1 Sep 2026 23:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m3VfPKqoQ1yn; Tue,  1 Sep 2026 23:58:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788307137;
	bh=aPFuAJaclgj0fem6qFc4zlWEGMvCkCkVIGCsyrMhQUk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aINz3OhmWcE3V0mqF7pbZ/0zAV9WeztZI8CO/5gyhVAs4FJBz2iaiBg5Nfm3JyGzW
	 rdYoYmSHa6AHv6NgPfayF5RzGVU3CAMZRCjexGLLT5oQUiJ9c5LbrTCRqPS+USsNUD
	 sFCB14Zl+r2WJh05sjml8PaePe6jCR5Tb3uz0qRQb0G+4wMgQ8WYh8a8QH7/oc6aow
	 J2CMe3Lp9r1Zb0AEKbLVG2E9S2sDQRiaeKjSCPaDyDNG6DgbfLAGEUVFqDoOgwCRbW
	 l1IGdYDyHODdLFr0It26U+QSkpjnuNHQOei/WLpFjUroQiIumpfPcpDsTEJ+6l/Ac2
	 +PFgDQl2maOoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA0EA40756;
	Tue,  1 Sep 2026 23:58:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 81B32363
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 23:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A7CB80DEA
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 23:58:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5sgF3cK5mYOR for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 23:58:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=BC6wUW5p; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=kOLnKIA6
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 477B180DE4
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 23:58:53 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hZN9l5PkYzMlHD;
 Wed, 02 Sep 2026 01:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788307131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aPFuAJaclgj0fem6qFc4zlWEGMvCkCkVIGCsyrMhQUk=;
 b=BC6wUW5pZEo7JaLvtFiYe25OQJk8sD59ueMMe4riA9u+ooXTtCuiwbRqNtsg3/hNQEOkLO
 VjwezX5Fd6CR/G1r3toJllvByA+1vXoG+BUOVBPTKg7mxorwRvE8MGeRp8gnV9W74WnLjW
 FdxSAhG1k2zEbN2cCDy17pYeI9gTFYT3qaVW1BQg/HSBFJ1WIFaCpgNlr/uY85fOSb1ioG
 jlA3I7Yp3JUFw9gJvUJDr9Y4siWrKje9hZvkLOt7Xn7pQxDg/IS/l2TBfrnQ/w4OmYohtD
 5cezDDhK/Ytt44z9KSXxg6SnWkYk4SPU8s53CcBRPSbxtfYnaYwrZW7Pof9tBQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=kOLnKIA6;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788307130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aPFuAJaclgj0fem6qFc4zlWEGMvCkCkVIGCsyrMhQUk=;
 b=kOLnKIA63yKx7m2WrJSGmp0hxIgPgjd5t4I5IY6BVOp1Q92hYefzm7EMhRVJLzGfA+sG0k
 R3ChcvNa7gyU8I62WQLtr+4VHjrH/9bpn9Yhmn8dbEPKlUQIKOMllqeulY4KZnMDA5ChE4
 wKLHJHkWO2Znm4Rc4HY0r7NP5eJ1S0Z5y97ZRE134sCuZfL2SR4c0DZZ8oZAEe1nq+sTf0
 vuij+6sHSdcYMokitgfX0wKSmD+xbAT8ZjcCT2YQlgbQT2jzN9+FyjZzgKPafRXtHcWzB0
 9OJE6yGg5l/TY1UI0udsp+O41nQPiObA0QMoviScIj8iUWbtc/MHZycIbJeXDg==
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: renesas: Drop SYS_ARCH_TIMER on R-Car R8A78000 X5H
 Cortex-M33 RSIP
Date: Wed,  2 Sep 2026 01:58:20 +0200
Message-ID: <20260901235848.350269-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3fogpjo5zihfa7whkrfzeqbgtkip4hgd
X-MBO-RS-ID: fb4bd40b78850685d3c
X-Rspamd-Queue-Id: 4hZN9l5PkYzMlHD
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

The CONFIG_SYS_ARCH_TIMER is explicitly disabled in the defconfig
a couple of lines after this removed line, and that is the correct
configuration, because the RSIP port uses TMU timer. Remove this
incorrect CONFIG_SYS_ARCH_TIMER=y configuration.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/r8a78000_ironhide_cm33_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
index 618712385ad..3f09a7c2556 100644
--- a/configs/r8a78000_ironhide_cm33_defconfig
+++ b/configs/r8a78000_ironhide_cm33_defconfig
@@ -63,7 +63,6 @@ CONFIG_SERIAL_PROBE_ALL=y
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_SIMPLE_BUS_CORRECT_RANGE=y
 CONFIG_SKIP_RELOCATE=y
-CONFIG_SYS_ARCH_TIMER=y
 CONFIG_SYS_BARGSIZE=2048
 CONFIG_SYS_BOOT_GET_CMDLINE=y
 CONFIG_SYS_CLK_FREQ=16666666
-- 
2.53.0

