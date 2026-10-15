Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850F0CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 14:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23477408FC;
	Thu, 15 Oct 2026 14:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wdyQ1EH9kiv; Thu, 15 Oct 2026 14:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 19CBE408B7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792074640;
	b=oiP0A/iNXHzDfOzRti1HtcFDxduSLXK3E1EagDVqJ08ZxNxuzNFKyBVnVRq/KawAvegj
	 lS+amux8KwlIL97kB/eLhdS6iEuExegoANI6Z4F0Rc/uJmaxsh3LE5S1/t+4JiZvovJgo
	 /mvF1QDf2hmQH8v/rM+NqXa75FcL3ZDfpviBy67/Oy+oEq/pt10xSqvRMfJ7Nz6+uWogI
	 JPWOuAdJ2c1ZrnaCHil5QUWo3vEHAYs0RkZPPav3gtcy6DWHUP85xL23OrWiL6oKSU4/e
	 KMMlXJItQ3G3NwAGZ/NpAHC0jBwMXuZnQDoTQbcDmfVajNmN0mP8XzkX+KWLF+YrUBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792074640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 From:DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GjvgTBP78M3KkyY30+r5CiDHC774+p6XsAPtJvYuCEI=;
	b=K/loII0JH4VkHiPPkcO5LE9vn7SNa3upw5Qq9qnNA5zxAJLYBiMMIlUXq1MVnRWLxuTs
	 3t5HetCX7JpAPsun7ZGsO3DPG8HNcIg6Ncl8w2TpUlc7ikUNykz6ryrDQi1moBeQW/5IS
	 xSyPJcnTBMHDIvRhWg2wJT0Gugn+wvXf/pVpE8DtWA9XX4Z2BYWufogTOgGzSTZw2d/pY
	 1DMegxrtGSm22v8KzAQy+RXSGE5pOV3u/duWPoVY7MJWxB1KejEZ0vsCCRdfy0D9KE58d
	 FHCpRF3wGAAeh6iF4utBxuPKtKsp2iD4iLNlOEY0eeWzFF/v16FrWVZqUN0klkOKX4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792074640;
	bh=GjvgTBP78M3KkyY30+r5CiDHC774+p6XsAPtJvYuCEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z3pX4CqTM88/fgeCLFDKHJPIOfKjTZB/Dk6oicop60QaV+ZVmvYkn9YP3MpzGuNPZ
	 91db3fdmkwKI+1pNAziNeDgAkVbeFzYYDSMGVA7V0hjWcSsBCGiP2HViS3Wd7IL9g3
	 41uKOiltxV2VcdzOce6zY1GmeQb1bHFz9mvOQnlMJ5p+RJ8O+xMMaqeYeeutkUTlPS
	 QhjVLKuNYbRphWTGP5nCqFKbe+ycZ+eSln6VdVt4PxvDBjeP4h2h3otQw5p/vwEPHY
	 /65b4riVzyxkHiXM59NXbh2QN+Ibh0paVSoVrrOu+my0s55iwYlokL5x2p1nZuK3i0
	 FZ/OLOoXK8NYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19CBE408B7;
	Thu, 15 Oct 2026 14:30:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FEFC2AC
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA0D58122B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Nu9AWyk6ekl for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 14:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3ED48810E2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792074638;
 b=O4qOofT9PGSOGBt8mUnh9+Ib0mwgiJP34sB7vy/gNdhRtds/XVINI0SvB962S/B2h3Z+
 JzginAly4OW0wuvW+r3eJ+H27sQdx9TSGYmL7Fd1O5iIX/R0RUT/tLSQXZW7wuIy2O0dE
 de/Gevr4Ew5EMsRyAAFBrwRNuTfzNV67kPhAvNZ1BkOVbiW3Ijxhods26dkazwG400iEH
 NoYbdUfFHI2By0I7Uym5OloA8ovYO8CUX4wmPv/KwoMVhXjEnIJ5bbgKR1SyG5Mx7Fu7s
 wXvtQfogUgOvOfvr7kRsFv4Whab0xeWUxnf+9xMRhJG12xStZ6AOOVNdh09sQXR7mcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792074638;
 h=X-Greylist:Received-SPF:From:DKIM-Signature:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=GjvgTBP78M3KkyY30+r5CiDHC774+p6XsAPtJvYuCEI=;
 b=eqTDl+EkA4UckcWmmzM/Qt6OHWTaVx6W7as+C1+8Op7jrxYSBRg/y2VDh2A9ZTp8DMgG
 ui6fAu/gtcPyphJTvnni3m7TtZRteWh+NKYhrqDJomgKxnMqrPTtBhN1SearxW1zApO3Z
 0sza5gsYweHTSuLA/1yFrtTnE6Iscr1P1SXASmNexIBP6FoxG8oRumF6Qo8/+iKwyUWDr
 igBzJIK8p46KmvH82ZfXG6w/tAZiRuwZy/DTsQ3KhkE3MQzbiwgDNnC+0LpcIYIwcNN5+
 dI2V2Oosew55TdIXHf96p/iyIxXf1NtgjKavX1xmFvbPeDF6tjYZgtzGaP/Wlb8BgYQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b="3hKA07/A"; 
 arc=none smtp.remote-ip=116.203.77.234
X-Greylist: delayed 314 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 15 Oct 2026 14:30:37 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=3hKA07/A
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3ED48810E2
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:30:36 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1792074319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GjvgTBP78M3KkyY30+r5CiDHC774+p6XsAPtJvYuCEI=;
 b=3hKA07/AtM/vH3xsh8pQPF0V8yKeCIPqznO+BOD7WZdKoyndl7LqTqn9FFUQfoIY1YsF3p
 ZwHU5HxmBOGtla52LGriQ3nPWONgnw5nWmM038kmaImgRIzRq/haBK+zK6xReCpboT4xbo
 6Pll+k320025+hVt21eErYRX0KZJEquH5mE1H6h8x45pf0w4TJvTbXJ6n3bNbrPet1jU57
 bAQ6coyvV5KwAsle1B6xKwLy85+LRJ193JCDWL7pl+dAJHPmml/N8cUkYAVOSUNjjxqenN
 nei9SSrbNEcJyWMUbVqwAxVnL3gh2KYtKwwnRGrpWwa6UJECwI87+2cUIbP0zQ==
Date: Thu, 15 Oct 2026 16:24:49 +0200
Subject: [PATCH 3/3] imx: kontron-osm-s-mx8mp: Remove DDR reinit workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-feature-main-imx8m-ddr-reinit-v1-3-994706166ada@kontron.de>
References: <20261015-feature-main-imx8m-ddr-reinit-v1-0-994706166ada@kontron.de>
In-Reply-To: <20261015-feature-main-imx8m-ddr-reinit-v1-0-994706166ada@kontron.de>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=IFHTvWvrCc7t/E015eBOxwbzcpqgUlFX0ogRP4FDBZM=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevCI78mCVXh30dOsoW7xbbky+Ua2DLGML3NTCudolF0i
 oG3g6+jlIVBjItBVkyRRYrf4rWtWayP/LHqKJg5rEwgQxi4OAVgIkn/GRkmFGqut5K//sPjzTvO
 BTNeX2S7cr07yiE70WU58/tgPYdLjAxT/Z7+5XtgsUFpvnv7yVd73zw2t59f0nrp2ZRS35m1vM/
 4AA==
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

