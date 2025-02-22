Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264A9C021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C65810DC;
	Sat, 22 Feb 2025 21:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UQHuDnt8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rTt459Kd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306B0800C2; Sat, 22 Feb 2025 21:36:44 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22CCA80FA4
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Z0f1560klz9sp5;
 Sat, 22 Feb 2025 21:36:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78nk2kBPwRRSq++LXdShgKSd41Jnn5hpc3jiwsJqSc8=;
 b=UQHuDnt8ZhF79ScOjAKB8ebR6HtTqvmAO4Kzedn5cF7LSKo2jPXJ6b6/8KLVfThLFJ8i5Y
 wZh25xF3+L3RGlma3e5CSNpy1RBsURiIq31ZnQeY+oee5qUnFHjbIIBQ+5HpB00oeIKPUl
 n8lrQuDorMRmF1Myzsk9JetwLmR/T5ShZX/7WUV46E9S7089hwysHQtUce916PBOaRYWSa
 uahMXD8EEDNlX5/AFnMRaWJ9Xk83BfxjenWumlMS7mLr4uKu3ntc+lbQwUeMwwO9jjfv3D
 TeH9KBmBF/KXuM7TIPntDR1j96ecv0ioHeBx1x31L6Nd6UD3g0KzCoyZhCdlQw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78nk2kBPwRRSq++LXdShgKSd41Jnn5hpc3jiwsJqSc8=;
 b=rTt459KdVfe3zSyB9L4XPuy8G7VdoukA7XBm2vkKNJxNXwX8TBpSjKByPJjg840TNDNeDP
 qjPCtflHJKtWyweVceAScxo5I+rsua45Cr5A4tW3FMW6iBeCphv6y147ylUanDanNjudF+
 qO4LxdCmDSaheQyYhEd84h2lhkFTcLlwkz5TcK1PuYlwQuFw3X5Uf/ZiUKf7p8PeDIM77W
 n46AKt2yPNZOt457LXXVBNiEY7UqnHM8OyYQAwJ6wH/NeNSBQ1c6gVmUnLKXmBHUAY15tS
 izUisIB1ItNLKm0+qFj7KXqJWrw+K8EDQ+vXULx/T/Iu91YoV8yHVmH7dymRXg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 21/23] net: ravb: Drop use of miiphy_get_dev_by_name()
Date: Sat, 22 Feb 2025 21:33:31 +0100
Message-ID: <20250222203511.195437-22-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c25853f4463a2971a09
X-MBO-RS-META: 9e6ksrdii1rzmf9rgynkahkhee7d7qpx
X-Rspamd-Queue-Id: 4Z0f1560klz9sp5
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

Instead of doing another lookup, trivially access the struct mii_dev
embedded in struct bb_miiphy_bus . No functional change.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
V3: Add RB from Paul
---
 drivers/net/ravb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 86787183488..b790de98b48 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -591,7 +591,7 @@ static int ravb_probe(struct udevice *dev)
 	if (ret < 0)
 		goto err_mdio_register;
 
-	eth->bus = miiphy_get_dev_by_name(dev->name);
+	eth->bus = &bb_miiphy->mii;
 
 	/* Bring up PHY */
 	ret = clk_enable_bulk(&eth->clks);
-- 
2.47.2

