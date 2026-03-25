Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A27CF54AD6
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 01:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA8783A91;
	Wed, 25 Mar 2026 02:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Eh3dlYKq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VtSY8TF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31FC81E18; Wed, 25 Mar 2026 02:07:25 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D5F83AAB
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 02:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fgTK70Qjrz9tph;
 Wed, 25 Mar 2026 02:07:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774400843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q05gV8bsYjUqUbfOV1sBUo2iRiziepteLNcB916lEJw=;
 b=Eh3dlYKqDffgK7r0Om8vtUZJf0+aBvbpocESYJoauUMYm9++LKCL1TSJnYvKZyimhAT2BK
 Ic4yh+H1ErPCdW6/7rqJWeD+A8GjbX9ocZC3QqhGxrRzOUFqQK29oJKFSLINC0xyNoHAsP
 aME5LvCZ95VesbuIrU/f7cohQJiNO6yoO3186F7ejjPD/72bdHH8HBCfhU/TVmL7OdOkAD
 a7Y5YtN15ZGUXY0RBR+tyGZ3O14WF3re5SD8auq4LF/goeKcuzs5e15A/4+rqvdFj8QTZ3
 wWwcACw+gp5zZjYs+MNndHEgVGP0KbdXl3yLu+7u+i8N5vgZKBQSoq1H0EMNhQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774400841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q05gV8bsYjUqUbfOV1sBUo2iRiziepteLNcB916lEJw=;
 b=VtSY8TF5nDiAbDq55wusgPdX6AC/YFhbpVdrd95P6gS/Uosq3woWHrYpTu0Mp1y6povnTf
 724okG4Shtk0DQ/ih4wbdiDckO9G6lAMlWriQ4DyCBf+zzmDyM4JV3+yxXp5bESAB8P+ai
 ittFJao3H6Ov3OflOKZ/gkqjqz/pnlPoILSrc8tRghFzlMCDhkYhLwMf+yb6IOFF7+AqY6
 DT08ifU9HOoulBgulLginfy/wvuVrZyRbFPZV9P34SW1luDTL+cJJI05P7pwOI/s1vH3Bv
 f+7e1qGWgcKp2FYLx1iRwxDPA/Lw9WRznlp72cruxG2c+yoyTWkpHW2W1r147g==
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
Subject: [PATCH] net: bootp: Drop unused code
Date: Wed, 25 Mar 2026 02:07:12 +0100
Message-ID: <20260325010716.280005-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 02a4957fcaffa7c59d6
X-MBO-RS-META: 37mk7b6r8zmyq5ntn6yxeqqhhieioqd8
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

This code is surely unused and there are not even commented out
references to the function name. Drop the code.

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
 net/bootp.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/net/bootp.c b/net/bootp.c
index 1d905a01a47..8976936b184 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -87,23 +87,6 @@ static u8 dhcp_option_overload;
 #define OVERLOAD_SNAME 2
 static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 			unsigned src, unsigned len);
-
-/* For Debug */
-#if 0
-static char *dhcpmsg2str(int type)
-{
-	switch (type) {
-	case 1:	 return "DHCPDISCOVER"; break;
-	case 2:	 return "DHCPOFFER";	break;
-	case 3:	 return "DHCPREQUEST";	break;
-	case 4:	 return "DHCPDECLINE";	break;
-	case 5:	 return "DHCPACK";	break;
-	case 6:	 return "DHCPNACK";	break;
-	case 7:	 return "DHCPRELEASE";	break;
-	default: return "UNKNOWN/INVALID MSG TYPE"; break;
-	}
-}
-#endif
 #endif
 
 static void bootp_add_id(ulong id)
-- 
2.53.0

