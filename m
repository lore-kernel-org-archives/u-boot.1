Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DB2C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A3B88CAB;
	Sat, 20 Jul 2024 14:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xw3yLwmh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KiyT1Cqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6B4883BB; Sat, 20 Jul 2024 14:44:07 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48AA488C82
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5nx0vLZz9sqr;
 Sat, 20 Jul 2024 14:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bD8wFTHg+UL8C5B/axGSrmwd75vAJpN5KLgL2Xcp7j0=;
 b=xw3yLwmh5llETGwziOIcG92d/Q9ttXWpG+JdKlzVAeS6u8KrRDrxvCtreUQG6cqC2m5seN
 dnd3dUWUe4MsSDqPqQg2ERymIFYxMGnvtwQe32JGQh3ebA/QsUhEns3z8vISp5n/AiCksU
 l0bwyWpm9i+XnI8an9s2YuwMhXjX79DQNLxq8sqlJkOklFPNr9KTYVQl6D6EmiBkpCcPtz
 Y42fRe1e11PgkRdO3RjGUA7eeq8/NiKoSOgr43S2T9LM5dMyy/IyBohXksK6+nQuqWJRSZ
 30yGTXs+8Oq6LJWGQ3szE3dnU7x628K7vr0Ro4GFpSTFWe0WLZZjsbjUhTDGCA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bD8wFTHg+UL8C5B/axGSrmwd75vAJpN5KLgL2Xcp7j0=;
 b=KiyT1CqeMdNoKHRzFfdhspASRdf0f4KWQ7JL/fJ64R4y6XyCwBPGkofn1TrvPIgyBiCEoL
 eyatyGrxJgH16/Fh8cMvfeF32Nn6MmNe+r4cYqBh5KvFufCxAVjcyXDUjfLINNjOLp6RJy
 5I162ajAUuETboqevCjG7+7kPuQkEc840cBjga2AAGQydYnsdiPkr6DxbQCoznA9wtljqb
 rHO4wLzrA5ivyP+yfwv7+83mjylUbbcscTOaYOEjCauGDyBHUYsxb62eaTW9WyouwWfaaU
 JLEb9w/42K/xDEi4zWqfl4p0DYwEhyaMmlP+WcF9bnxvkL6bB1uB5zvbjMZ4dA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 35/40] drivers: thermal: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:41:00 +0200
Message-ID: <20240720124239.7553-35-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5894b8b8912c8610fad
X-MBO-RS-META: 5tuqrikrnaafkgpue5toxg9jue7g5ek7
X-Rspamd-Queue-Id: 4WR5nx0vLZz9sqr
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
 drivers/thermal/thermal-uclass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/thermal-uclass.c b/drivers/thermal/thermal-uclass.c
index f0fe912e313..c61e6c3ee0e 100644
--- a/drivers/thermal/thermal-uclass.c
+++ b/drivers/thermal/thermal-uclass.c
@@ -13,7 +13,6 @@
 #include <asm/io.h>
 #include <linux/list.h>
 
-
 int thermal_get_temp(struct udevice *dev, int *temp)
 {
 	const struct dm_thermal_ops *ops = device_get_ops(dev);
-- 
2.43.0

