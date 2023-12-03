Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6E1C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB379876A9;
	Sun,  3 Dec 2023 14:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JLsCua37";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JJE4tJQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD1B87618; Sun,  3 Dec 2023 14:17:14 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0414186F6F
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SjnQG3g5Fz9sc8;
 Sun,  3 Dec 2023 14:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQd/KNPvs1BUoMD+Gyu301ZZfw3Eil831hEEW2LMSqU=;
 b=JLsCua37JD/GfLHMTGKX+Jnt2xqlc1EXPlZP9fu2YPxPgk6TvW/REI1ImKBhkBvWTzXj2y
 C25q4BDFJwpwDRc4DP+zWT0XD/fCvGbPXe56n+HzRXVpoSagsvwHynQjmIFSO6J5gx94e0
 uMc5jDOej/R36644RKZn1J8hrhmFYdZqGF7ZTxoLBWSCywnteA6uCY0sp9dE2fQLPECS15
 XayGvg7SEYht4oXXFCFzd1fh+3Qe+6zKjp8sYCRRWHBvkLbxIOjlhCBl6W53vDMqXttH3x
 FPe1djVjptWYlzg+LOJHhRZRRqP/qYSpipftm8glnDsJez+Z/pSfW+chSAAMcg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQd/KNPvs1BUoMD+Gyu301ZZfw3Eil831hEEW2LMSqU=;
 b=JJE4tJQ0AKG1kRM3CL0hMd7K9b3S4sM23OZs+BIapsbWAGMHb1Fwl9tADy6cZjZ42YcWeQ
 hZbuibEjrD2ZlNeXKor5NjX5KK7SYIINs/s5MyjZSZcFH5n7bSvfwokFrdoSu0flVabVdV
 lq0+EIWHUAQraQyHrQSVRGF1efLPek+BK+ZyDuNJl/4hBokA9A68FVeqR3NYj29BWMAmnY
 q8t6demSVberltMpTFSe9Zgl+FFnCM6FYI0Svqmnz9rmyKCLGmJ7dmpxT25l3FcDBOPlaw
 D8xhG93wwvibOB31G8TcdGjyPpoZzLJUGeLvEpcfoQjaONZPulUJF/poWqhTfg==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 04/12] clk: renesas: Synchronize R-Car R8A77995 D3 clock
 tables with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:16 +0100
Message-ID: <20231203131635.119191-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 82615673b6f3556dfdf
X-MBO-RS-META: s1hx7p4i619ah3sy79kgp7acqn1zsntu
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

Synchronize R-Car R8A77995 D3 clock tables with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index 0ef1c1d8143..dd2c9483292 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -181,6 +181,7 @@ static const struct mssr_mod_clk r8a77995_mod_clks[] __initconst = {
 	DEF_MOD("can-if1",		 915,	R8A77995_CLK_S3D4),
 	DEF_MOD("can-if0",		 916,	R8A77995_CLK_S3D4),
 	DEF_MOD("rpc-if",		 917,	R8A77995_CLK_RPCD2),
+	DEF_MOD("adg",			 922,	R8A77995_CLK_ZA2),
 	DEF_MOD("i2c3",			 928,	R8A77995_CLK_S3D2),
 	DEF_MOD("i2c2",			 929,	R8A77995_CLK_S3D2),
 	DEF_MOD("i2c1",			 930,	R8A77995_CLK_S3D2),
-- 
2.42.0

