Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9AEC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 101028852E;
	Sat, 20 Jul 2024 14:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UXGU+YjO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TRc8CnNo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB5A887FA; Sat, 20 Jul 2024 14:43:37 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A92D8855C
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5nL6hQJz9sGV;
 Sat, 20 Jul 2024 14:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRJn7P6GNfjVeIxT1ZEXrPqSz4iMMJM9QOQ7/i3gwH8=;
 b=UXGU+YjOgj1Tz/PwGdiBKLg65ydhtLfQ+qfDoWT09aB1U5iRU4q0gMWjAfXBj55RRqpCGT
 V61utmJiT3jvG4NPqgWXqVxK/FhYTu5Vact4lZko9goxhWH7sVvdvkQj+/UrOlfi+iq373
 QwtXoHOMOLp41MPU7HjotYusFps6cqL54VgD0+EvuXogoKXBlN/KX4ixiu0Ifwspv2JS0F
 MQWXTK8xBbyl9K1HxM3tEcs9zSztr5zqtDj/Wl3kwzLwkybXpzmOJIR10dd1YFInte0XLV
 U6K3bgpnBAaO724VBtz75EJRJj/HBVbMdqf4Mv5Qc0psSLnSzhufXHDY61OzcA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRJn7P6GNfjVeIxT1ZEXrPqSz4iMMJM9QOQ7/i3gwH8=;
 b=TRc8CnNodmEQXz0N8s4bh+7QwqZIU1rL7CG84Mu/A2IszadZb2FaMhtVD5aM1LAbrFJXcc
 gqxVN6ZtJUzAkElNN2y/x9pGHiBXWvwByFv468CD/31CRQJnya6godmFxfW94b0CbdTzQG
 evJjm7hMwAgdaP4kOeS5HvjbmcdoCf2d2vswilxkH4MYQJ+m3wX/9UCqIYkqEORgFkvOAL
 gB4fGZbOES3GR/fbUTXP27aPQM/71mVgQnDg49NUzYpVY1z1fUwGY4m72yx6C5FCEkFmPu
 BmCmtcsVSqleeJhgwwaXAN8x7U5e6Sxqx67y8xccBd1zUiH0r31AXTEr6O9nPw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 03/40] drivers: block: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:28 +0200
Message-ID: <20240720124239.7553-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bbe0b873d8e60aadb48
X-MBO-RS-META: o5zkp7gkok439nyifrfbce3fskz7spdm
X-Rspamd-Queue-Id: 4WR5nL6hQJz9sGV
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
 drivers/block/ide.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/ide.c b/drivers/block/ide.c
index b16623d7a3a..cab5e1bc92b 100644
--- a/drivers/block/ide.c
+++ b/drivers/block/ide.c
@@ -790,7 +790,6 @@ static ulong ide_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			pwrsave = 1;
 	}
 
-
 	while (blkcnt-- > 0) {
 		c = ide_wait(device, IDE_TIME_OUT);
 
-- 
2.43.0

