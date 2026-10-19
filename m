Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31867CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1156406FC;
	Mon, 19 Oct 2026 10:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SWyXqF2_Vh7x; Mon, 19 Oct 2026 10:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 057BE40695
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406075;
	b=DuHkagK7XOPCoMC9PKni8KdvyOgVWZ7gvOqCEDWuVA+LjKI5aW4lHybA84Tf1uCnyAyR
	 rbS8NdkN0qYGFs/J6Vg0g9jYpgfgr5wihJ3oydPfP7GcxAlB1uDpCkXLGrxlbVhdwppKw
	 SBtI/pMvzd1H+oD5elsIP1beLvPOzRV71/zHb90v4AqXawjzT7qFvUP6LL6rj64EwaA9w
	 LuS4+NmaiH4GrqkA8t3v3Wz4NfNEJjlfO5OCmyQmyZYSLTf2YAuAnZhiamuHZRlAXK7dq
	 EV2lMl3SNkTs04Ki2G7xfYEag/8ybVDdk6WtJO56V8F5uK0lr8qS4QCHgAALMrz5YFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GjvgTBP78M3KkyY30+r5CiDHC774+p6XsAPtJvYuCEI=;
	b=cytK+GFbB+t4E6M6sFjoWkvkooTmTyHKREqP9Q3rHm5KegA2K3F+xpTXUFUpEWtW1xmA
	 Ynv3MCeslz55kOAJ5em5M/6lcS5KrXMKI2Bw8ESc9dlVA8OxRV/KrEPTxDA/Z0D5JFuw/
	 wrKFJoFjx1Q/HHHxXh0Qdjuwx2GMugJ1/o/zUV03CDd1Npg1tgcacKOBXOtr2zr2oOR4y
	 XLCRMNIhX90CURpu3ASqNa8MIaSI976RYM0eA+MXbsNbWcOmRIosrflp0PFA7evPjH2rE
	 LKqRimgMr3nOo8d/oA3rz7W0dRKwc9Uv3Z03bD9M6D6IO2zQ+ZaKT3MirGfgFB1Zksg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406075;
	bh=GjvgTBP78M3KkyY30+r5CiDHC774+p6XsAPtJvYuCEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MTc8Y6T2nOavXvlbYEKlTeR0B+EUD3+GaA1b2sGraGqOmJKJ3r11W4+gysvDX58JP
	 nfEziXpzOW6gSfG4ul2AJTlICQ3VahexssYFmnJ+neoPmxw0qMeAd3JJk3ACkgsyrD
	 JVpi/o8MMfxHvjtHCoXeT3gGxIVR9gCeBknKwUhbcBuNetDO2mj+B8NL43Mc9OmDwg
	 PbVcAXULV+06yEtmC9LHphv7u/WDPBT1xx6+iq7a43be8PWY5WfftNQHjXfYNeqEgW
	 EAOkPZK60epIO+hZMUWTHrd318bxYZolM2jn8rz4k9BPKSJau0AlLLmjtPivZvi3d2
	 uIdiMvmtyNp0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 057BE40695;
	Mon, 19 Oct 2026 10:34:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9287FD7E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 811DC400B0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BGtoW_luERq6 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CF60C40080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792406070;
 b=ScluznKX9dZqUAqcyNd9dgcpEkaBVWbUI5YgqnHTxUgnkHri4OSRTpBeGlKRJ7lqL1YP
 tCb3a5KtWx9RJYuLVxpNe/PPxZ9Z0ipQtVBBIUQm9GrsEXbDJXlVUt1LNGUd4cReEtfmo
 vVhYIfbc6d4OO4/zoZ7rTCmBJsgyZv7J8WM0J/spLSe3IHAoXusoAwtco1BEqN6K6RvIr
 mptnNqvRL/97AaRtn8D4DzfoLF7de4yVaCfs2DEx4BdcFZhCSmRrQhH91SG1hPkgoLbAG
 cyl1ExfUm7twtPmsU88zP2dzcgCFktyWD28JocdF2Rpf/tMXaalwWnDoERLrINgIwNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406070;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=GjvgTBP78M3KkyY30+r5CiDHC774+p6XsAPtJvYuCEI=;
 b=D8zbO2aOybWJKJw3e2wM1GNxs8KQbP7skuakm4Wkka54+0Q9Qx187HWrnFAx6zG6tvBk
 MKM8C6DL1wkXPSGeuJpOziTmsr3UWUJrm1D71aDzn20dPnShn23A4xnbdyPhROhnlrbm7
 SjFtCxRoWGOHp59HKEeII3gAYt3jFASLr6da/3wD5/KI67j5iVVXA/j8l9kDWXqRMlb3l
 0uUz+RDnVrQyAKwQfh3YVP60dDLdHz81ByhhhrdSH2XXzRorUWeLNcM5pHNY/+fIZE0IW
 XJsjPa9iIDGIjy3dsGOMW7340rxvOgFnNDjrjKWpY/74r6aPaIdxmjrGDcWONMJcWWQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=Rs7AENBN; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=Rs7AENBN
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF60C40080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:34:28 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1792406066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GjvgTBP78M3KkyY30+r5CiDHC774+p6XsAPtJvYuCEI=;
 b=Rs7AENBN/GrR0RYmW8qG9rCPsqP0HWAzPhXvFnBTW3LwOkVTjS7M3WN3zVMbNb0QC18h/d
 zqqP7naj8172Aiy48Lf8CACPmptQqlra/Iw6qo75RVdbOLxLIOkyCejcJC5fF1MBCpjF+2
 g7Tvn5853rO3LlQhpmghuwnjjzcSuXYeZDC+AM1E5HK5PQuENMrzrQES1dWIYt8f8ZAy3Z
 O69h+kWrUNHjidRJvkowuFJnNYkdn28OukTHDQn39cfGK1MgaEJxYVj3nD2mDZsuB+4u/k
 4AEpvDUWy+kh5DE6wYI+S80XQ1dnGKSLs+rctzCwzbP/RhbFjxjag1WbdwfQVA==
Date: Mon, 19 Oct 2026 12:31:09 +0200
Subject: [PATCH v2 3/3] imx: kontron-osm-s-mx8mp: Remove DDR reinit workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-feature-main-imx8m-ddr-reinit-v2-3-be22a99c6fdb@kontron.de>
References: <20261019-feature-main-imx8m-ddr-reinit-v2-0-be22a99c6fdb@kontron.de>
In-Reply-To: <20261019-feature-main-imx8m-ddr-reinit-v2-0-be22a99c6fdb@kontron.de>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=IFHTvWvrCc7t/E015eBOxwbzcpqgUlFX0ogRP4FDBZM=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevqJ8NpAg8uT0tLldJMOcHud+3V/B0BQp+Ki1euuKNl+
 Hqn0hS/jlIWBjEuBlkxRRYpfovXtmaxPvLHqqNg5rAygQxh4OIUgIl8/MnwP65I3uzExcApOy/H
 rFx54am904HG9RuvyHG4e5vs4yyN+sfI8OvypaJbE48GxBa5Mx8QuhmyS0TdycTuZMGE0/4OIho
 ybAA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The OSM-S i.MX8MP probes its DDR size by initializing the 8GB
configuration first and repeating ddr_init() with the 4GB configuration
if the 8GB can not be addressed. Accessing the DRAM after the second
ddr_init() used to freeze the SoC, which was worked around by an
additional short size check before the second init.

The actual cause was that ddr_init() did not return the DDRMIX to its
power-on state before repeating the initialization. Now that this is
fixed, the workaround is not needed anymore. Remove it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/osm-s-mx8mp/spl.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/board/kontron/osm-s-mx8mp/spl.c b/board/kontron/osm-s-mx8mp/spl.c
index 20fd960243b..04a43192cb5 100644
--- a/board/kontron/osm-s-mx8mp/spl.c
+++ b/board/kontron/osm-s-mx8mp/spl.c
@@ -68,20 +68,6 @@ static void spl_dram_init(void)
 		size = 8;
 	// assume 4GB if ddr_init() succeeds but 8GB can not be addressed
 	else if (!ret) {
-		/*
-		 * For some strange, unknown reason freezes are occurring if we run
-		 * check_ram_available() after the second call to ddr_init(). This
-		 * doesn't seem to be an issue with caching as it also happens with
-		 * caches disable. The workaround that does the trick is accessing the
-		 * DDR areas once more before calling ddr_init() and
-		 * check_ram_available() again. This can be done by rerunning the size
-		 * check on the first few bytes of the DDR.
-		 * On the other hand this breaks the 1GB DDR init, but we can skip this
-		 * as the 1GB is single rank and the training fails. We can detect that
-		 * by checking the return code of ddr_init().
-		 */
-		check_ram_available(256);
-
 		/*
 		 * Overwrite some values to comply with the 4GB DDR.
 		 */

-- 
2.55.0

