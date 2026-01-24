Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8C4D715C9
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 05:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666C683B03;
	Sat, 24 Jan 2026 06:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BgHBT7+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C18C83B32; Sat, 24 Jan 2026 06:40:54 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 771CB839DF
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 06:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1DC0610D50D; Sat, 24 Jan 2026 06:40:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769233250; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Y5tVkVqWU25h4DSt0LpsdjWILC/XTkqeb2dsUMJqgJg=;
 b=BgHBT7+Cr4RyXJaR4Cr5TmaaQuwK61sEVDfCKq7rly3GyG4Ws9+e2HpqIfdJwT3IUaqmgP
 f8yU6ssW5fv+Xymzr5y08KS4f2kDL2U2/os1j6yf0MUJZMBuPsqgIY3+qmM/8o17xlwNfz
 UtC9BhuL5MCL2Vjs0vQ4W9v4WuZFtw8p54NnTLAi4mRHgLeEg2R3h83cmVZBfADZyyGH+A
 HOHOW1ZKJ4Pk1Y0Aal0d8eYDchv3QHVoxXGDBipw5GwpX1JZrAVhSE3P4p3hd1DLYU/g8y
 wPjB0Cgsg51rbiEW1ORcTPi0YUXaKKOdSJdm3yuLNkaIujghiRSJWmJ6EoWB4w==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] env: add w flags for net config in explicit write mode
Date: Sat, 24 Jan 2026 06:40:40 +0100
Message-Id: <20260124054040.7597-1-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Adrian Freihofer <adrian.freihofer@siemens.com>

In explicit write access mode (CONFIG_ENV_WRITEABLE_LIST) the
environment variables listed in NET_FLAGS and NET6_FLAGS are
probably intended to be writeable. Therefore add the 'w' flag
to these variables.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 include/env_flags.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Azure build (patch is in a bunch of siemens patches sending
now to mainline):
https://dev.azure.com/hs0298/hs/_build/results?buildId=202&view=results

diff --git a/include/env_flags.h b/include/env_flags.h
index 0c48874690f..fc65dcaba21 100644
--- a/include/env_flags.h
+++ b/include/env_flags.h
@@ -56,6 +56,16 @@ enum env_flags_varaccess {
 #define ETHADDR_FLAGS "eth" ETHADDR_WILDCARD "addr:mo,"
 #endif
 #endif
+#ifdef CONFIG_ENV_WRITEABLE_LIST
+#define NET_FLAGS \
+	"ipaddr:iw," \
+	"gatewayip:iw," \
+	"netmask:iw," \
+	"serverip:iw," \
+	"nvlan:dw," \
+	"vlan:dw," \
+	"dnsip:iw,"
+#else
 #define NET_FLAGS \
 	"ipaddr:i," \
 	"gatewayip:i," \
@@ -64,16 +74,24 @@ enum env_flags_varaccess {
 	"nvlan:d," \
 	"vlan:d," \
 	"dnsip:i,"
+#endif
 #else
 #define ETHADDR_FLAGS
 #define NET_FLAGS
 #endif
 
 #ifdef CONFIG_IPV6
+#ifdef CONFIG_ENV_WRITEABLE_LIST
+#define NET6_FLAGS \
+	"ip6addr:sw," \
+	"serverip6:sw," \
+	"gatewayip6:sw,"
+#else
 #define NET6_FLAGS \
 	"ip6addr:s," \
 	"serverip6:s," \
 	"gatewayip6:s,"
+#endif
 #else
 #define NET6_FLAGS
 #endif
-- 
2.20.1

base-commit: 6b2d05748cf3cd6ba417a96c00602b0122e10af6
