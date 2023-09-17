Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE45CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 355B986AC7;
	Sun, 17 Sep 2023 16:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Gn6284ZS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fh+WIAMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4652186AA4; Sun, 17 Sep 2023 16:12:10 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E79186A14
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVHC114Vz9sTr
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49f6ins9uymDmpEiLR3GbP2N4V80BqzeZZYeH7f5hkE=;
 b=Gn6284ZSyLHdcmsYx6AfuolryFk5mYoAEAR4epDRGxbAsk7MKTBPFTWPfHvjSZVo2GZz5M
 Yt6fttBCNYDhAHKW0jHMlK/4QhwMiPLcvfAf90GJqmIkzzyk+lKLh/kYMrGM6kL/CnuL1l
 /mNxWewfvt18sTu47Ls/3ad6XOKl3VhosD4yqMCwJZYzQTd8FqosHN/4znlmDvt1vmddmV
 btyNk6OcqQ7Y/PCdoH5p1ODN/Wsr7omP+owQEgWtaQiYhHu+Y9VoRztEE7jJe0evxOi7+r
 /SJ4cgmzBGra+ywRzvhucxiJhjKMYrPlchgOab8fpNsFCX1iElqFi+f9EE64iw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=49f6ins9uymDmpEiLR3GbP2N4V80BqzeZZYeH7f5hkE=;
 b=fh+WIAMWgx90KDrwRanUkQeJqUAArElJ8OpoRav0jf5QIao9mOcoJkl/e2TKUN05QmgS5S
 H96O1KOlybGyX4wxOTsC+fpqgkPye5m0vk1MMSnFmHlEXHA5GgN8DYG3bT5X3DxFvogDM5
 STzZttAZexYDuirqZTYkkwAHJQ+jtIhMTmiLaxr6IAPdfNGJOQ/ZWNLdI9o9AILKkPgTk/
 LoIX/2cY+mKHz1qD1tJ4ohEuVIZWMwRxycYV1qkp7aMTRxTH5mbXjmmmO6om2bFTiRb7vJ
 U2/4PGBmMRKsj6mM2ie/VQABL0LgLv24Ljdg/M6XZupRoF9Us/rRHO+RnotDMA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 15/20] clk: renesas: Synchronize R8A779F0 S4 clock tables with
 Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:36 +0200
Message-Id: <20230917141141.379884-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5278b633798914e8a25
X-MBO-RS-META: gizjdjx77wpeztcyfmth1etr8inm8fy8
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

Synchronize R-Car R8A779F0 S4 clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779f0-cpg-mssr.c       | 4 ++--
 include/dt-bindings/clock/r8a779f0-cpg-mssr.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
index 7aac28ed496..643e8b8da97 100644
--- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
@@ -47,7 +47,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a779f0_core_clks[] = {
+static const struct cpg_core_clk r8a779f0_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",	CLK_EXTAL),
 	DEF_INPUT("extalr",	CLK_EXTALR),
@@ -123,7 +123,7 @@ static const struct cpg_core_clk r8a779f0_core_clks[] = {
 	DEF_GEN4_MDSEL("r",	R8A779F0_CLK_R, 29, CLK_EXTALR, 1, CLK_OCO, 1),
 };
 
-static const struct mssr_mod_clk r8a779f0_mod_clks[] = {
+static const struct mssr_mod_clk r8a779f0_mod_clks[] __initconst = {
 	DEF_MOD("hscif0",	514,	R8A779F0_CLK_SASYNCPERD1),
 	DEF_MOD("hscif1",	515,	R8A779F0_CLK_SASYNCPERD1),
 	DEF_MOD("hscif2",	516,	R8A779F0_CLK_SASYNCPERD1),
diff --git a/include/dt-bindings/clock/r8a779f0-cpg-mssr.h b/include/dt-bindings/clock/r8a779f0-cpg-mssr.h
index f2ae1c6a82d..c34be562495 100644
--- a/include/dt-bindings/clock/r8a779f0-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a779f0-cpg-mssr.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
-- 
2.40.1

