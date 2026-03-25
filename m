Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDCEFEC0F4
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 01:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A95CA8352B;
	Wed, 25 Mar 2026 02:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ju3/8nO0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EMtBdkdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A3E838BB; Wed, 25 Mar 2026 02:07:11 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A3A81E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 02:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fgTJq3Fwsz9tVj;
 Wed, 25 Mar 2026 02:07:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774400827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6VlmxMafgPnAlJXV99HrWERbJ+ngFD9DRtiiZdyybhI=;
 b=Ju3/8nO0EL8PPE8Ise1b3e7C/PKxBt9p7B3IWPWoPpkxulwZ4U4XEWSar14MWVP7xxH+So
 7rROoNkgrvPBfTzHLyi/5eWi5R86wJN25qSwoDTf+vP0NEAIVfxYduLym3Dzl6zHHm/216
 2S+rJ3PPCGnEAygmerCsAubj/aYh4BP6j+TqIIdq5+51LbUyadIUKCvuY5clzGxZS9ZLTs
 u5zVawYORxKdaXJHHwFerR47TX/zF3MyPck8QAT51VrkYUBhwdBzYqh5w8lZLxKT/aRrgP
 RuUx52W9U7Pgpi0lYFgOp2Y6Rmv1XH+meB9wmuJznAIhLVTtVJUAY+m59PtZUQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EMtBdkdP;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774400825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6VlmxMafgPnAlJXV99HrWERbJ+ngFD9DRtiiZdyybhI=;
 b=EMtBdkdPTXHIcoOZzzo+3NCjiNddAb5hWGsRsH+JekH7pJC10D58SVBUk6aXUC7dO7EPSg
 Y/2YmQ12sLUNhVlQMgDsIgZdOjBe2p/fPgde1lsVj4mdkbXolvY7tGJCgFuqOUAL8770mv
 WcMLyXA+ZGBTS+gE4obETAIXquV8d+D5yIcQZlazw0xeI6qONI59WwE0ngzJZS2+WswLH/
 icxPlDlNGahlcCIeoYVwhEmlGF20wRCNRgjEAfVOeRBP/vkpnumuB8Efw2iZHO5M4Kgjpv
 f4XJz0DUInPJmE9Qr2xn/4L8Ds/J9Chd1qA3wmzaN6/8EuZ/jyhCqEHCLZ8ngA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: dhcp: Select CMD_BOOTP
Date: Wed, 25 Mar 2026 02:06:47 +0100
Message-ID: <20260325010659.279966-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9f4fb7e5b4c7d10bf8f
X-MBO-RS-META: ysuc61w6n3i8dr86x4kh4xfufq8foom6
X-Rspamd-Queue-Id: 4fgTJq3Fwsz9tVj
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

The DHCP command depends on bootp_reset() function, which is implemented
only if CMD_BOOTP is enabled. Select CMD_BOOTP to satisfy the dependency.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 322ebe600c5..317ff8e9987 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2186,6 +2186,7 @@ endif  # if NET
 config CMD_DHCP
 	bool "dhcp"
 	select PROT_DHCP_LWIP if NET_LWIP
+	select CMD_BOOTP
 	help
 	  Boot image via network using DHCP/TFTP protocol
 
-- 
2.53.0

