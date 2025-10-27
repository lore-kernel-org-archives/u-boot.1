Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBB5CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2CC783826;
	Mon, 27 Oct 2025 18:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hv3L0xOd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QyZ+IyqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63168836F0; Mon, 27 Oct 2025 18:23:14 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B1E8384E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cwL1r1lJgz9t26;
 Mon, 27 Oct 2025 18:23:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761585792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nSfqDp1m1vilVgB2hbJRo92W6N14uONF0CBl1Zexv24=;
 b=hv3L0xOdkVmnrBYbJjtyTGsYGsRFpGMBRfy6J9/CUyk1mi9SWXAUehAV8zRsESQpx4D0+w
 /xToX5Q7oLz1z0caxHVoB9+YHLfUEmm8nHPHjUraYgi7qlq5kyByCBT46R8lZUvEiIg6eM
 oPL7kCvieC62FD0OpWaganAHP6P6GQJDF53NXHiGER/QZUFCYeyUQ+DJe/jcgNt4VeoSaa
 FjiLmm8HxrmSzr6D6r+KRJpN+DGjme1utApuZ2uAPBICqb8FJUpuZXMOQRt6YEP3TOU8ct
 s0AyZR2JYLKfJgJOqOa8yvlR6zTPBe+XoGfBFxZXDzz4c6rIGdOrTHWStLEJkQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761585790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nSfqDp1m1vilVgB2hbJRo92W6N14uONF0CBl1Zexv24=;
 b=QyZ+IyqVAWdmwlCH3pK5Zy8iFAq1qslRJ3glojqjpgdyGj8Bvtrppdy/kSPG00Tynewr2A
 fDhUSPixySTH3F2bcFYTlp0bQIkTTdJCzjijvQBxG/3a/LviuyWZIoF6b+YVeBD5RHODJB
 5hfwBq4Q5Yc+sSp1vNsuwkADrpxWYRPbhdaCdOre19e1WAXVK2pSV8rYiY8oLwbfUcvwG1
 Utx3Wr7Eg8V0jU7jw0kN8/PuLny9MIcV3KlxmqSmOB3MpOPnofsM9sVkvzCFANTIscgPXa
 XRcV6ZHndhtawP/5rkJzwHpb9LNEgmh6OQ5Y5y+My5m4BqYAYoqHNT16r75hGg==
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Extend stub PSCI implementation to R-Car Gen5
Date: Mon, 27 Oct 2025 18:22:55 +0100
Message-ID: <20251027172306.30524-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f88547dc8c10f9ea8e2
X-MBO-RS-META: g6bciaaph97a9p571kuo64ok87ifx6om
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

From: Hai Pham <hai.pham.ud@renesas.com>

Extend the stub PSCI implementation with support for R-Car Gen5.
R-Car Gen5 uses different register to perform reset, therefore
add a compile-time conditional. This is __secure code, therefore
the runtime SoC detection parts are not available to it, hence
the compile time conditional.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Tweak commit message
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/psci-rcar64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-renesas/psci-rcar64.c b/arch/arm/mach-renesas/psci-rcar64.c
index 459dd55ff45..22c2ee045cc 100644
--- a/arch/arm/mach-renesas/psci-rcar64.c
+++ b/arch/arm/mach-renesas/psci-rcar64.c
@@ -32,7 +32,12 @@ u32 __secure psci_version(void)
 
 void __secure __noreturn psci_system_reset(void)
 {
+#if defined(CONFIG_RCAR_GEN5)
+	writel(RST_KCPROT_DIS, RST_RESKCPROT0);
+	writel(0x1, RST_SWSRES1A);
+#else
 	writel(RST_SPRES, RST_SRESCR0);
+#endif
 
 	while (1)
 		;
-- 
2.51.0

