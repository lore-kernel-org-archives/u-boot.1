Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC821C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066058076E;
	Sat, 18 Jan 2025 05:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IbbKxhm/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hLq7yb4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 879EF807A7; Sat, 18 Jan 2025 05:02:26 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7200F807BC
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YZjc00mwRz9slV;
 Sat, 18 Jan 2025 05:02:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65Inq5Kqp3S8TAFPj3fxluBuctyIE3CgtQq6f5cKIwQ=;
 b=IbbKxhm/L8sNJe0qRR0rM3R/+4m/jNdB74TMe6TZoErAUJTriKrSLqo90xxEUzNPoz6NZ6
 ScwWVDagc2NmDL62XuHKD8ySp5X4+a5vRtvmINKUjMJYjiln1kcr0U6Wu2grusZIwhD84M
 /af+mQ9rLmOqyn1RjTjXaszvjtXCmLtajVBMvxHecb4Gy40P27ZjkRM9s9qVtubMBiBV+K
 RXup7lcl7SNFAltDgsJXfrRMxHIWGeQrO6cW6tDgXdUm4IZcKLQI2NGk06zgf7jYtC+V9y
 Ioqr+jXQjdFdP1HiLhC2VmvNIhk4m81l6/jk/C4aXYMFDKPKBe9qoyYeNkc0Zw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65Inq5Kqp3S8TAFPj3fxluBuctyIE3CgtQq6f5cKIwQ=;
 b=hLq7yb4qHx2YtpUmMrV1mqV3cPDN8FRtZjiw0iBSX0S24xaulqb5Xy6rgUZhZiLnhrMATT
 m/75fjkwlQOeXGhClQJtBPRallEhBpNzkcbKrnmHYyxT+E4hFKqoPIzguh2CMvBvf/iYgR
 tqDzgWFr6AMLpF4a8KQytZ7TrweJ3hmz98UKHB7EvAgx4VoKvXQSYVHNA7uercvzouhin0
 8xV2s7nyybfHGdGNqXZLZJN+MmRwkJB/b0OJ4EtOXzUKKi+jp6RLHIeijUdw5SKIoQa6qZ
 vqGrIFmFtYo9TbX4Pt+TMe6dKblfBxVjkay9P6bhvtnVOf31Hu/aeB66W/mHZw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Williams <awilliams@marvell.com>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/8] video: Handle return value from cyclic_register()
Date: Sat, 18 Jan 2025 05:01:01 +0100
Message-ID: <20250118040130.74921-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y7xhoru97n9pscgpzdrrqa9oinoetmf8
X-MBO-RS-ID: 36ae5bc9c48245149e9
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

Handle the error code returned by cyclic_register() and propagate it.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aaron Williams <awilliams@marvell.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/video/video-uclass.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index a5b3e898066..94b2c3c3b91 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -653,12 +653,12 @@ static int video_post_probe(struct udevice *dev)
 	    !uc_priv->cyc_active) {
 		uint ms = CONFIG_IF_ENABLED_INT(CYCLIC, VIDEO_SYNC_CYCLIC_MS);
 
-		cyclic_register(&uc_priv->cyc, video_idle, ms * 1000,
-				"video_init");
+		ret = cyclic_register(&uc_priv->cyc, video_idle, ms * 1000,
+				      "video_init");
 		uc_priv->cyc_active = true;
 	}
 
-	return 0;
+	return ret;
 };
 
 /* Post-relocation, allocate memory for the frame buffer */
-- 
2.45.2

