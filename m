Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6B7C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D739188C6B;
	Sat, 20 Jul 2024 14:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="czNPfL+s";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="m7xrW7EI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D01B388C68; Sat, 20 Jul 2024 14:43:49 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A7988675
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5nb2npHz9sRn;
 Sat, 20 Jul 2024 14:43:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brv93ChCpZicPMvsInXbiQVd+EcJ/B1IGfAsxGIYklo=;
 b=czNPfL+sAop3dGm2MEpHPTmDB9bzin5irKAbG6N8jTkmMLqs1znF1xUqveNteQq//Gnfv+
 H/9Z4s6TwwAg8E9WMAlWs+LrnECkdIgXKMLXccDuOEkFSFXmZgHf1OxOwMivO96KH+/Jae
 1giFMOIdtgx4YFPTqYZ02znkOrDcfS9wpfkYiHIswqLjZFATmr/rnAFz+yGBfPTw2JKQKg
 9DQkIZl8EBcsKUP2gFpcXcJK6UZWj48jvblovPf9ikHZsQ5FNQ1M4ApYuuOz9DwNARCW9v
 KRJFKmPcfZpOcbmlb6XH8xN2KuScaP8OKThoL4L51od/dZOYGuhEE19gyTL3yg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brv93ChCpZicPMvsInXbiQVd+EcJ/B1IGfAsxGIYklo=;
 b=m7xrW7EIysZ+8WUGoOwGxsX9ZlJBZihzFDlnV1GqWi4SHAhqT4og3/cjUIAlC5bNkVZ8f0
 mEu3WiaxtAxvcRMuLXiHMsdAdLEX3zRLlezdsM0hwUjZhWxoHJ2R13Zi+TpKjiEoj1vxIg
 jtGNOl98/pV4mvNr5SGOhHs92qugP4OSiJbA6bbLUCSbsm3LXOIc3g3N02tFa7yQhgVqiz
 OEtI9c7R6pRP/ZJP8IJwgtBNULbueLErS1oovGEFxtj74pn6ao3FjJhHSvVe4Fbtkir3YI
 wknY0jtFn865IO9ciEme8acZC55jwF8FqpM6pkhqaR6o+eOZ94qF/JqL/rQYAQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 16/40] drivers: led: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:41 +0200
Message-ID: <20240720124239.7553-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 27bbf1af3d6e625ba34
X-MBO-RS-META: 4gjmxr3e4xtxbszzeganujpkscbrx5x9
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
 drivers/led/led_lp5562.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/led/led_lp5562.c b/drivers/led/led_lp5562.c
index 0c5f9bc4300..a5776d3174f 100644
--- a/drivers/led/led_lp5562.c
+++ b/drivers/led/led_lp5562.c
@@ -122,7 +122,6 @@ static int lp5562_led_reg_update(struct udevice *dev, int regnum,
 	else
 		ret = dm_i2c_reg_clrset(dev, regnum, mask, value);
 
-
 	/*
 	 * Data sheet says "Delay between consecutive I2C writes to
 	 * ENABLE register (00h) need to be longer than 488 us
@@ -521,7 +520,6 @@ U_BOOT_DRIVER(lp5562_led) = {
 	.ops = &lp5562_led_ops,
 };
 
-
 static int lp5562_led_wrap_probe(struct udevice *dev)
 {
 	struct lp5562_led_wrap_priv *priv = dev_get_priv(dev);
-- 
2.43.0

