Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AEDC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08FC688BC1;
	Fri, 19 Jul 2024 12:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bbckHBQF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KwLsDcYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2878B88B9D; Fri, 19 Jul 2024 12:30:27 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5705388B9E
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQQt91JNnz9stK;
 Fri, 19 Jul 2024 12:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYruK1VFnf3jLypX6RnU4S5ap1fcobevNtd6Q7nD3PA=;
 b=bbckHBQFkcP9KIV6E1mkxtovipVsmnDyTnAmWkRACDKcbrV52C4zDDkejqO80fI42BnmO3
 Ox6RRzV1J0AwYaNV4KKcXS3A8L7CcOBQXh+sxLalMEalBCaxBc2dQsiQ/1QGyyoaqBLxm3
 8cweYPnes06DCgLzqwwAeiRN6FWNlvo6gI8O48ALf+YOlifPbITdJIDpOBaHIaAlpqfkkV
 B3KsVnPcxx1KW4dWK2SmRdViLyXQyi6go93jpXB9a2KUovhH+3vQ10S2kdbeen9/E0h7Z0
 HMZP+27lpPJUUZ+eox4sDnoqvg+22FRfrcSY8nGb1wmsP4D93zlUOolbBWnXvA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYruK1VFnf3jLypX6RnU4S5ap1fcobevNtd6Q7nD3PA=;
 b=KwLsDcYGvR5A6Ufi9ogFwUeBjB0jnWsDW15m64xEpX3w96jyaDTBnTShk7UPwM4EvhN2n8
 En385RuzzsOLK5MIDFn4N8+2aFHyho23JwJjHmnSjfy8qAoYQkxQ8NEq/0BRKnmogGOqpV
 Smx2ho9pJjFLoiJEwsHJIYMk4owdC673/wMPo4dqgURJxG8FFMpT0m2ZThMacQ89GbcCMh
 L68/Y1IFdxDPXION31bnTZdNwWdPg4fjN10IeoRgmNfskyA2RVzKK3gpn6kltB/0PhJs3c
 2gfQ5SR/jGa54o5SKdQ74eFHeRIlTOY4S2wPGggkC7nfXYskJdBRrfetC9plZQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 12/37] board: dhelectronics: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:28:06 +0200
Message-ID: <20240719102934.322997-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 50ba9ed3093c173808c
X-MBO-RS-META: fweob7ig34ysdztqh853qi8uix1k8g3j
X-Rspamd-Queue-Id: 4WQQt91JNnz9stK
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/dhelectronics/dh_imx6/dh_imx6_spl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/dhelectronics/dh_imx6/dh_imx6_spl.c b/board/dhelectronics/dh_imx6/dh_imx6_spl.c
index 3a5495ea18e..a50763e1926 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6_spl.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6_spl.c
@@ -541,7 +541,6 @@ static int spl_dram_perform_cal(struct mx6_ddr_sysinfo const *sysinfo)
 	return ret;
 }
 
-
 /* DRAM */
 static void dhcom_spl_dram_init(void)
 {
-- 
2.43.0

