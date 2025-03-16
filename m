Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFB9C282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 13:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 187DB811DF;
	Sun, 16 Mar 2025 14:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y7Ce5mMD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n9LbpBya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8385E811B2; Sun, 16 Mar 2025 14:54:47 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E0D80C93
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 14:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZG03927qQz9sT6;
 Sun, 16 Mar 2025 14:54:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YEhNzInUy5weojTMl28wBwmSgxBYNR2SoJEOjJzxt1w=;
 b=Y7Ce5mMDE9gBWI+Wuuu4JjGvTu/PfbKqljynfbSuAVbZVd5LpTG6DnTzEzJcfPeNT9Vgzh
 R5uFYezhdbC5drubt0KuvNOQr0hsUvszh0wSDT2z5h39R4ycT0leFr4YZo2qLw81AZKJe7
 +SZRlIRov8vbuaEkzj+HrKfQKOjhfUSEwOr3UnyfU7wDhazoHBxvIU9kElE6Xts+6ucauk
 5PVam8Yynqe0w1RRy4sLwTe6QHbZvpMrcCcJcvAXBxWW8yD805NdR0qBh5Iuvko/k42CF0
 sAh8GEy+3YzAZk5xmGPxpsSO+CnJgZ8bCeR4ZF55+esOhOZdRxQzkoN/UmLRDQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YEhNzInUy5weojTMl28wBwmSgxBYNR2SoJEOjJzxt1w=;
 b=n9LbpByag54N6mrETl3v7FC6/p0BwOuTfPaX6pZeWEsaRX6tns1TW6s9gnBulgcndhM6Xq
 pOG0CSOU0WSOxHSZgoR3/2IqPZgIt94lUKbmCNQD6e5bG9xY0wLyUEGpU2YbH0zyQszKWv
 DXHeyKGS3N6MN5siwZf5hIBGKzfjWcM+1WG9xTYFmYEdOOj7HY89hknCssKB+lFsgARHR0
 SatzUp9V1ttwmDxy3eJIWxj8GYcJ2KCD8V+SZju5S1qJC2vs/t65OrFnCo+zWWW8fgxyDB
 5LqqPohV8VAeR5R+3bhhBBgKk+R4ObVwd5eqob+Gm4XKzHyi+/PAM/eLyoc5MA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/7] arm64: dts: renesas: Make OTP available in SPL on
 R8A779G0 V4H
Date: Sun, 16 Mar 2025 14:51:38 +0100
Message-ID: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e0d41877e87a2b8b358
X-MBO-RS-META: b35k3rot8q4kwona57kzoa9bqe4bbtnn
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

The DBSC5 DRAM controller driver needs access to OTP fuses to discern
Renesas R-Car V4H-3, V4H-5 and V4H-7 SoC variants based on OTP fuse
programming. Make OTP block DT node available in U-Boot SPL DT so the
DBSC5 driver can determine its base address and read out the OTP fuses.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779g0-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/r8a779g0-u-boot.dtsi b/arch/arm/dts/r8a779g0-u-boot.dtsi
index 10051c9dbfe..cc9d99b0f34 100644
--- a/arch/arm/dts/r8a779g0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-u-boot.dtsi
@@ -147,6 +147,10 @@
 	bootph-all;
 };
 
+&otp {
+	bootph-all;
+};
+
 &pfc {
 	bootph-all;
 };
-- 
2.47.2

