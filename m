Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01930C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 152FF8759C;
	Sun,  3 Dec 2023 14:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="G9KwITY0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cFPMey0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E47387618; Sun,  3 Dec 2023 14:17:13 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49AE4875DF
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SjnQF6kNzz9sTR;
 Sun,  3 Dec 2023 14:17:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pYRII/ZOQ4/CL2rBv62gNUAfhcFN9EhvueLl7VKjtEs=;
 b=G9KwITY0NEcArp2imV6IzC8q6l958L1UsMtAU/bFcDSmY0mNlDrscPaOdlwue/D92kV/26
 x2k5Uu7uYOdrW641wk9uEYSt9bJ8JbzC+zpNSocc5zDdNYD1bLksGjqCM7NDv53fV5m98t
 Bi/V0frs6rD6iZZVoPtmOM0Tnp12/sxXDiyuXSja8KmQ4CmUyvSTzP1orpMb8iATltExxK
 jjKMllO6D7BZ3y0NVypqUV/pJ22jnqDqX/7AqFFcqslZb/3nDzonJ/iSqC0IayG03OIxhl
 KWY6mKF1c7Cth6DoDBUsJ5Bq8MsCp/A/aCS92nl3Cd78zaXVtrhffxOA/BbHBw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pYRII/ZOQ4/CL2rBv62gNUAfhcFN9EhvueLl7VKjtEs=;
 b=cFPMey0tI0wIoaBAlqi7JL54olnyMemcXobUzSCjjZdQLNVi01OO2DfQy5TY/OLGL7nWTH
 jaEJg+n9rPB4+4AK4qUAkMcPJTzplb2uh57AvR62nLSJxxmpJkcvz7OhZQsvWq/4JK8HSn
 sm2MI1APeceJ17wEm8P7uGLZEWtUlvi9PGlHc71DGBtsgfJ54kmsRV18XozopAaW+gViyX
 GPjxd8vygbjvdgPgp25gqOM2rfWcKBxROsNOKXEZU/Nsj7iBFRqWcMheM7KNh3mSkMhGZJ
 lHCqVro4E31e+jVAqQ+Dxg+hlbFqmfD33O88AmBNv7LCwPoNbBONYVXYicVjhQ==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 03/12] clk: renesas: Synchronize R-Car R8A77990 E3 clock
 tables with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:15 +0100
Message-ID: <20231203131635.119191-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cfffb356a61cbc2fa9b
X-MBO-RS-META: cirsxmx9864xp8bik1wfkbzm453wkc5k
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

Synchronize R-Car R8A77990 E3 clock tables with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a77990-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a77990-cpg-mssr.c b/drivers/clk/renesas/r8a77990-cpg-mssr.c
index e5710b05933..87b06666c8b 100644
--- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
@@ -224,6 +224,7 @@ static const struct mssr_mod_clk r8a77990_mod_clks[] __initconst = {
 	DEF_MOD("rpc-if",		 917,	R8A77990_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A77990_CLK_S3D2),
 	DEF_MOD("i2c5",			 919,	R8A77990_CLK_S3D2),
+	DEF_MOD("adg",			 922,	R8A77990_CLK_ZA2),
 	DEF_MOD("i2c-dvfs",		 926,	R8A77990_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A77990_CLK_S3D2),
 	DEF_MOD("i2c3",			 928,	R8A77990_CLK_S3D2),
-- 
2.42.0

