Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818FEC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7673787EDA;
	Mon, 12 Feb 2024 14:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="F5bf8GdM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+GGPiKYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D934887BED; Mon, 12 Feb 2024 10:35:16 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11EE3876F3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 10:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t-8ch@linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1707730514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yfgJ3AvdTVpBv2UjjbXdbrt9vtJ7ZVnBtQbvXGcqlW0=;
 b=F5bf8GdMwmk7jqfcci6lRZaDpN9445ouzpZ/FjOR4Hutsn2LflT4BQmw7H6fOwpbIQw5Nd
 GFhVkN3+AVIUdS0JKk+aujp3rzAJxjjOABHF1Y51nrNGTLYsGKiL20L393AhgmUhEXhxiK
 kdoYn/Ykievk2i4SaRm60Sqxr/msUjYAFIa5kyiz6BpyDhJQhlRZHrC0UnqHHcPG7wojzN
 7oYXowpVeUGZ6JXm+UwSw9jMoJbhQaZZomhL24oTgpTSoYMO76UKU/gqB9WRVfArmM891t
 8xo4Kty4u2609f0i4puP8wKq9/r4SelG0WKwbWfb/oZ3XpaJt9Q2DLEPKjnqqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1707730514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yfgJ3AvdTVpBv2UjjbXdbrt9vtJ7ZVnBtQbvXGcqlW0=;
 b=+GGPiKYbnYmk3mJCT11ZnqW/V5JOro2Z7cEO90OrIqj+s1JdCstUAel9rpXifNqRv5Ucg3
 80uNxkbo4IoryrAA==
Date: Mon, 12 Feb 2024 10:35:12 +0100
Subject: [PATCH] bootdev: drop unnecessary assert on bootflow->bdev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-bootdev-assert-v1-1-0249ca369bad@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAE/myWUC/x3MQQqAIBBA0avIrBPUJKmrRAvLsWajoRKBePek5
 V+8XyFjIsywsAoJH8oUQw85MDguG07k5HqDEkoLJWa+x1gcPtzmLguX0kjtp9EZ5aCjO6Gn9x+
 uW2sf2T6cHWAAAAA=
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Benedikt Spranger <b.spranger@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707730514; l=847;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HoYtk2EvixlKs/sES30qiQ6+JUCf2mUAaLAQldjospo=;
 b=hy91FU0ErBly+kfoF2qaIFSJNX1YYR0BC26xc4RG/kFwrLJ5aZo/r6p+F1LNY1v8wrzYtIgwW
 PJgUFS0qFw7DtvxF9ch0pFS+8ziOVPBvsMQJ9qW2WnJMa989o8UwQ+d
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Mailman-Approved-At: Mon, 12 Feb 2024 14:19:09 +0100
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

Not all flows have a device and the function already contains logic to
handle this case.

Fixes: eccb25cd5922 ("bootstd: Allow the bootdev to be optional in bootflows")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 boot/bootdev-uclass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 35afb93c0e73..0fa6dad8b11b 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -39,7 +39,6 @@ int bootdev_add_bootflow(struct bootflow *bflow)
 	struct bootflow *new;
 	int ret;
 
-	assert(bflow->dev);
 	ret = bootstd_get_priv(&std);
 	if (ret)
 		return ret;

---
base-commit: e8f2404e093daf6cc3ac2b3233e3c6770d13e371
change-id: 20240209-bootdev-assert-11714f63d72d

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

