Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DDA606A31F
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Vh/VTY+R;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSkwRA70
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B58A7811C5;
	Fri, 23 Oct 2026 07:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SyEewLZb8JOq; Fri, 23 Oct 2026 07:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 080E280F44
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792741669;
	b=F6+vAdKG/mZlcmbBqzaC1Gim9F8TN+D1l5iA2zYRWzWt1ME6AvvgXilyUP6lkh2Ls8tM
	 LFyRfWOPciwMqZKKZrpDreUL73CHskFonRRXlOg1925SIp3FwVARERySrFtwxhR1hLhnW
	 764ENm6gbt3fs1V+EkGeVZlUybZrD5TPWmLynNSpTr5KtsKya+qtL0pc7X/kgqzfuz+mg
	 7C+7R5A7GGw2e38yYIx9DrW90FSutF10pSBPaHyh9/LhUtMtzSnVXKBNfz6K3/4njsr8u
	 AD47a6m88mLDTIAq+CQX/HSwpFLQJq5J2rDJhSNr28pKTlY4otTT71iWGH/GCRLOCMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792741669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MFLuV1pEYM3sJyKG+ltOl3Xa33SkpJI7ZoIMwpWrZhA=;
	b=AYusZmwiJFhbro1pA8tCkFiW5DO0/BxsMfSx8ffl9uT8Oh7e2esmAf+zpo3RaK/L4rTY
	 wpU43pqAKFeI/v9ivBdLTQIHNms6py1HEEQ9ouMYjZg1dh98a37utxfYTcHYPu2BT4/5A
	 uAgS3OaHYEjV9G2JPvKaclOQbfnZtOqVa7Zp03jnA2QkKtmdRXo4RUvlYV2IcZu79QWTq
	 FNrk5si+9tQp6/XPUX/wE6WVrdlBhfoHkxxfJPHDCUZNxKuOkmtw5kfCj4npLYiKrTNbB
	 aA8KhK+MFiUmrzqAeM1y0ZYEf7Y9m6jf2pAx1ttjH2YOZjbHdzmmt1YK/PaBHreMAXg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792741669;
	bh=MFLuV1pEYM3sJyKG+ltOl3Xa33SkpJI7ZoIMwpWrZhA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vh/VTY+R8Dpl51jK753p7sCrWja8FQMEXPn7MJz+fSNGbhVVnLTiSwkoQYj4sSqQR
	 XJui70zl98Wn6XNKrBdrC2y6ilzYlFpROpaG2cpNcdfHwNUdt2I2Xd4tlaUrYUD7bk
	 3LOTbr+fOBOkUpQJRGp9hNpGO4dxPJEiJIXOySZCzYLX9EO3/Qup5qsjSUOWxgZ5n3
	 ccz4RoiliI3OeOItBDj5OkmkkqAnZjtMIfD88LoPo51k1YDh4HEPk1oRZMTC91oiNX
	 yFN0xTVrzEHSzGQkdBjaP1uZSLBRHFEi2tN6zC6TRbyN0/1Z0L2ZcKUtTSMQJasYKT
	 IFz4e6DwyX5/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 080E280F44;
	Fri, 23 Oct 2026 07:47:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E37E49D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03ADB40846
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BrI1EwBag2az for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 07:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D5EE740840
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792741666;
 b=ouE/bkhSMx2Xc9Lx+2lUIX9LMCRqvZWG1r8FamdzchlfK9zRgKkbtPY92g4BxBqZH3r4
 yMUtpVsW1rjjzaSJoWFxdMvS2EBkYhnAZNREE0GAV5KVRZtpWcjYzdWe36T3bYMMgfrCk
 uJGLoN5lTeVva0dc/zw7KuCqfBx9ZpLdTAMTEdYfv8+ajGSrE8DaTbnBPH1onzYIj9FLq
 CauoS4w7i1DvyvLAz7wirOAlQ2OEppgBFCsPLIuikHMHkTFLUHv18sSKceK1be7ekB3On
 B+CDDKENPAUmQGS869Duw83pLcNcnr6sqdOJ9c2hEvGkLftOga2MAqcsZHOZ0FE2vjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792741666;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned:X-Virus-Status;
 bh=MFLuV1pEYM3sJyKG+ltOl3Xa33SkpJI7ZoIMwpWrZhA=;
 b=FYsS4HTVaCqR800ib5bxlBwPOhzrQRRqm7o8AssFRYTAwzOz8lLxqqrcfqBcH48xeRXv
 szmrjlIpELsChPKrnhvDwqTJ1A3NNJCpRiaL27iFZtCmQi6O3LDcqZxJGOtHbGZaNC38k
 I0BMPM0DeyhpV5jhxOH0mtWZabmjBlgebe8HwdheCMJBYL3FMtjysxODMe9UtL7ErZRlW
 Wmz74dUTmzSkqnZIhcwxaO+WCWTlv8BBQQi0rEdqZYgEDoCKBNTuieWFEGZq7ChWRYvBP
 PSrneOuf7KHwl7eSO/w1hm4V7LVtAmv6aa3oohUBtFa6RHaWad+zEIPQmbstc46yH1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 spf=fail smtp.mailfrom=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gSkwRA70; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mwalle@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gSkwRA70
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D5EE740840
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:47:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FE98404D; Fri, 23 Oct 2026 09:47:41 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 274438056B
 for <u-boot@lists.denx.de>; Fri, 23 Oct 2026 09:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B9C5600E2;
 Fri, 23 Oct 2026 07:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3611F01825;
 Fri, 23 Oct 2026 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792741652;
 bh=MFLuV1pEYM3sJyKG+ltOl3Xa33SkpJI7ZoIMwpWrZhA=;
 h=From:To:Cc:Subject:Date;
 b=gSkwRA70KlzrC3USVNwsQfKeKlEXd1myybg3Vx512X+NSFkYdoDlKDFi4eU5VsBaE
 8cRhiGZhmtvL0RX9+1hMe0qa34qvMhzP3ptMf8rb6VwX6Fcgb0oehhhySkhySLHyee
 QzMEb4iO21wa2Sw5Kq1EmVTglBwe6FZjtwwQ4Tw90VoVlX+y2SFnIVncrFJzXlLKOv
 8VrIwdzzCCOVef1B9DiJLsRLizrJsaYAKT04StGVUHxM+4Z6BVk7cN28x40dW9/t4U
 Eqhl4TbYQ9ZvOzYw6ju/aozH6PVoW7h3ZLNnaPrKkyhdOgZO8qXIl6yyexa28887s3
 /fLUYcIQXAtaw==
From: Michael Walle <mwalle@kernel.org>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 York Sun <york.sun@nxp.com>, Pankit Garg <pankit.garg@nxp.com>,
 Rajesh Bhagat <rajesh.bhagat@nxp.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] net: fm: fix the FMan firmware load offset
Date: Fri, 23 Oct 2026 09:45:10 +0200
Message-ID: <20261023074718.2979002-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When booting from QSPI with TF-A, the FMan firmware is read with
spi_flash_read(). This only expects an offset into the flash, but
instead a pointer (CFG_SYS_FSL_QSPI_BASE + offset) into the memory was
passed.

I'm not sure why this went unnoticed for so long. Maybe the offset is
stripped with 3-byte addressing or a 4-byte flash just ignores the upper
byte if CONFIG_FSL_QSPI_AHB_FULL_MAP is not set.

Also the non-TFA boot version has the correct offset in
spi_flash_read().

Anyway, with CONFIG_FSL_QSPI_AHB_FULL_MAP (only set by default on iMX
SoCs which doesn't have fm) set, on a LS1043A I get on a LS1043A:

  Fman1: Data at 00000000f9d46630 is not a firmware

because the firmware is read from 2xCFG_SYS_FSL_QSPI_BASE + offset.

To fix it, pass only the flash offset.

Fixes: 382c53f94631 ("net: fm: add TFABOOT support")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/fm/fm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/fm/fm.c b/drivers/net/fm/fm.c
index 146f3f1fbd3..a2754c1f841 100644
--- a/drivers/net/fm/fm.c
+++ b/drivers/net/fm/fm.c
@@ -400,9 +400,7 @@ int fm_init_common(int index, struct ccsr_fman *reg, const char *firmware_name)
 		if (!ucode_flash) {
 			printf("SF: probe for ucode failed\n");
 		} else {
-			ret = spi_flash_read(ucode_flash,
-					     CONFIG_SYS_FMAN_FW_ADDR +
-					     CFG_SYS_FSL_QSPI_BASE,
+			ret = spi_flash_read(ucode_flash, CONFIG_SYS_FMAN_FW_ADDR,
 					     CONFIG_SYS_QE_FMAN_FW_LENGTH,
 					     addr);
 			if (ret)
-- 
2.47.3

