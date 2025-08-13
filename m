Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6460CCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 21:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A269C836C8;
	Wed, 13 Aug 2025 23:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="H1ldjwpy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xqKa8nRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B36B836CE; Wed, 13 Aug 2025 23:26:28 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5708782A53
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 23:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c2Lz51651z9tDX;
 Wed, 13 Aug 2025 23:26:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755120385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2dOS+dxHoDWDgiuYuMpQsZLaNxr76w5pHGq+wTF7HFw=;
 b=H1ldjwpyj3QGg3M3tvBBr7vDz4O+YYWvVQUXjS2wgj15i985nMM66f5WoUEK932qyrytIW
 0azBHFa6QeNzPzUnDUpPLiRESo3GTDeUDpjB89ldgw7fuzhkPNMekAgxwIgYs2sjxkB2bF
 6onXfxJ8EE6baVQWQJlBJ0glrvZTv7CbvSv1B4xpQmghhR+xnDTEwyjqXUUgMefotoqOxx
 Ro55QF2UW9nMqso3l+cvr47u5oaUjv1kNhPLsvMqCkil0IYasJXQG3xnL2DYasAJ/oLBjn
 TfOG9pi1EQxsBKWpNtEk6kd9igwd3ocbdyoJ0a5p3M3cUSU6y5/2VSAZ7ttEuA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xqKa8nRE;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755120383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2dOS+dxHoDWDgiuYuMpQsZLaNxr76w5pHGq+wTF7HFw=;
 b=xqKa8nREltq0/Dqt7R8TjSZvs+A7mlGs1IFHeG5q3tUnUlVgqEQRcS4AzFqQvqhL+kFYtm
 5CtOdlingoDusVfnssBsODSfrHP9AG6Qn+NiZIG0+2UtMzbN0np8xRIsQa2YTpcGpLIPIa
 NVrMsCrld3N9UsC4Ouci0eMlyIZgK5r2NqLnxj/aWyQZGfL8YhYP6MBsGtpwQkfP6gdSI0
 7AYg9ZhIQol5o408gDj/i5f59nXToNsQehqbG0gl8bQGi2Qpq8XLM+vBZyNGgWyUXEr1CS
 /umaRWaykAKnGy86nXTZ544/dALs/E6UIZwYjKme7Zi7WFVIcnbx4YbiI05EnQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4] arm64: dts: renesas: r8a779g3: Describe generic SPI NOR
 support on Retronix R-Car V4H Sparrow Hawk board
Date: Wed, 13 Aug 2025 23:25:56 +0200
Message-ID: <20250813212611.112803-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hcwg59t5eusgskfbqaknsyxr79pnp47q
X-MBO-RS-ID: d84f972fc3306281e20
X-Rspamd-Queue-Id: 4c2Lz51651z9tDX
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

Retronix R-Car V4H Sparrow Hawk EVTA1 is populated with Spansion S25FS512S,
EVTB1 is populated with Winbond W77Q51NW. Describe the SPI NOR using generic
"jedec,spi-nor" compatible, because both flashes can be auto-detected based
on their built-in IDs.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Update commit message, s@spi-flash@jedec,spi-nor@
V3: Use capital F in the comment, s@fS@FS@
V4: Move DT change to arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
    until the same fix lands in mainline Linux
---
 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
index c9f302799f1..3210360ebe2 100644
--- a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
@@ -44,6 +44,11 @@
 
 &rpc {
 	flash@0 {
+		/*
+		 * EVTA1 is populated with Spansion S25FS512S
+		 * EVTB1 is populated with Winbond W77Q51NW
+		 */
+		compatible = "jedec,spi-nor";
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
-- 
2.47.2

