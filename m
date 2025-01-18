Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902A9C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4F180758;
	Sat, 18 Jan 2025 07:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Iocy6sei";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P/PJ4Gfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB6280757; Sat, 18 Jan 2025 07:54:32 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12FA980312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZnQY5YRrz9srq;
 Sat, 18 Jan 2025 07:54:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SENKvXL82SBwrSe5bJvNata+6mYm0NHnZ2laAnBgEHY=;
 b=Iocy6seikLtCAYI9aONb6DoX7TMhJrFVS89ZlR7eILrzmniHUo1RjorI0iUD4QB63v43vx
 dcv+YQY18QW2/o5XiQ4cI05H/GPN9NKTIqE294es3K2OqnEs3JUJiZCPHNGuVPbHO1rnpA
 H1ssFMnO8EeuXo6IErgd/t3wQkshjU3RvC5zxv+AaPqO9rWJF+GocWTKZYKeTl1KnVUS4+
 gIu2aDItXIMCyD/5byp9uBsaf1LcZz3SV0MqcNhp2uQ7WqgAQ3NrUVFzp++uszSz9lwEB8
 dRjbNZJnqJ3FLXMheW09lmIhnD3N1OfklvPvg9s0y4UJCdtLhm/UBLOS2/Bf6w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SENKvXL82SBwrSe5bJvNata+6mYm0NHnZ2laAnBgEHY=;
 b=P/PJ4Gfd7gdkjcg3o6HgiCBvfYj+mQhxpmaXM5kJiabwK8hF5JB4BZKI8YrvWbDJqwFV/2
 aLk2l8xt7funXmz63vsUbtx82AMRKsJVlNnccnTz06jhHI70FeZuAn3rFWrySPzdJBm5mc
 4IYJPi/dEyXEUSQDeAw5+Pnu88AYdh0LV2K76AqGaUPrfphgSv5TU1twCw8HBHTMyMJB7k
 9KtlocuSIF6uMVB4NkBwSvk9TLoWFlytEjvOHRd7U2MUJ7FOyaYkq4fAH5Wh7PsJ8Jr8id
 opul/DMkKZFniQ6KJ84aRbyhEEjHi32PK9qysaLipV6dMc2/Wc53bJPsfB6Xrg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/17] net: miiphybb: Introduce
 bb_miiphy_free()/bb_miiphy_free() wrappers
Date: Sat, 18 Jan 2025 07:53:06 +0100
Message-ID: <20250118065402.172253-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bd41a37a9a516ae8d16
X-MBO-RS-META: ijyme1c5x9cpqn1nhfr8ibetq7sxtwwj
X-Rspamd-Queue-Id: 4YZnQY5YRrz9srq
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

Introduce bb_miiphy_free()/bb_miiphy_free() wrappers to allocate and free
struct bb_miiphy_bus. Make struct bb_miiphy_bus wrap struct mii_dev, which
will become useful later in bb_miiphy_bus accessors, which would be able
to access struct bb_miiphy_bus using container_of, even if the PHY stack
only passes in the inner struct mii_dev .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
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
 drivers/net/phy/miiphybb.c | 19 +++++++++++++++++++
 include/miiphy.h           |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 5497b838225..9733ebf6f09 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -14,6 +14,7 @@
 
 #include <ioports.h>
 #include <ppc_asm.tmpl>
+#include <malloc.h>
 #include <miiphy.h>
 #include <asm/global_data.h>
 
@@ -41,6 +42,24 @@ static inline struct bb_miiphy_bus *bb_miiphy_getbus(const char *devname)
 	return NULL;
 }
 
+struct bb_miiphy_bus *bb_miiphy_alloc(void)
+{
+	struct bb_miiphy_bus *bus;
+
+	bus = malloc(sizeof(*bus));
+	if (!bus)
+		return bus;
+
+	mdio_init(&bus->mii);
+
+	return bus;
+}
+
+void bb_miiphy_free(struct bb_miiphy_bus *bus)
+{
+	free(bus);
+}
+
 /*****************************************************************************
  *
  * Utility to send the preamble, address, and register (common to read
diff --git a/include/miiphy.h b/include/miiphy.h
index f385f3f47e7..962ace13079 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -74,6 +74,7 @@ struct bb_miiphy_bus {
 	int (*set_mdc)(struct bb_miiphy_bus *bus, int v);
 	int (*delay)(struct bb_miiphy_bus *bus);
 	void *priv;
+	struct mii_dev mii;
 };
 
 extern struct bb_miiphy_bus bb_miiphy_buses[];
@@ -87,6 +88,8 @@ extern int bb_miiphy_buses_num;
  * Return: 0 if OK
  */
 int bb_miiphy_init(void);
+struct bb_miiphy_bus *bb_miiphy_alloc(void);
+void bb_miiphy_free(struct bb_miiphy_bus *bus);
 
 int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg);
 int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
-- 
2.45.2

