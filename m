Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B367C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E5488B55;
	Fri, 19 Jul 2024 12:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hRQ5pz0w";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D0USMg9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 097A188B65; Fri, 19 Jul 2024 12:30:15 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8254887CE
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQQsw4Y6Yz9tXp;
 Fri, 19 Jul 2024 12:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8BLT3SISHGfbNU/xQ1TZqBT/DY6wFIyVn1Ynri1PtXo=;
 b=hRQ5pz0wi2oojR1tsQLf2kCYzPFdbUc8MTnyFlU2WryQVsfglvOuiM+fX0I5UoTvLwxn1Z
 M1E3PEM/HzBm/9pBSRudJrxTqCn+hMFuPFmHwDKqamhVLLAZSIkj95t0JJIPWt1OofptUl
 WWg52h9tjI1+OuBzcTFTpX3TzKY5AX/xjMkaGYKoHWknzwJUFXPCP0iMDqAT6elB91HpH7
 WxVREwES+O/7mFpeGDi/U7Unj2oEkNJuV7rGOt/IhSGCThNgR+K1gYN1Dd/bozGlOYMqr5
 RpC6kibkc1H7Qp0LHdozQC243qkWE1pzUk94PflIxbaYNHLTwScm95BmHGemhw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8BLT3SISHGfbNU/xQ1TZqBT/DY6wFIyVn1Ynri1PtXo=;
 b=D0USMg9ujYAJ7mJnKKr4sv0AiQMG9bhHIT3Ujps9rnILO/69jg9ZMxJvBdqZ2NnnjB18Bx
 +n2ongDiIHB5RnBExK0XoqzA2EjRHRkrCGSZFukYTgfSHniKo5Eznc3KkXm0jd5s2Nzl1Y
 izgWAdruT1Vl2SD7/6EIX65NW0eO7Z2kNDDAClgFLFlw/Ow01m/BeXywPujCFfneVwBtbY
 217yssoKA7vl5Gt4zDZbU/kS4H1QQ1ANu6mPLFQgybUx7kZXonmOiQ93tf/9t6JQHkDCSc
 6w6QrA5/6SxyW6XT9Ypn24jp+J/kwayyfPSsaASGI1sXSxZ2k58B1SnJQpsJNA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 01/37] board: BuS: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:27:55 +0200
Message-ID: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4tch9i8phgyjiam3iph15uc7fgm5nuhg
X-MBO-RS-ID: 6ffe104530896122007
X-Rspamd-Queue-Id: 4WQQsw4Y6Yz9tXp
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
 board/BuS/eb_cpu5282/eb_cpu5282.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/BuS/eb_cpu5282/eb_cpu5282.c b/board/BuS/eb_cpu5282/eb_cpu5282.c
index cf5610861b5..c254da62bf4 100644
--- a/board/BuS/eb_cpu5282/eb_cpu5282.c
+++ b/board/BuS/eb_cpu5282/eb_cpu5282.c
@@ -181,5 +181,4 @@ void __led_set(led_id_t mask, int state)
 
 /*---------------------------------------------------------------------------*/
 
-
 /* EOF EB+MCF-EV123.c */
-- 
2.43.0

