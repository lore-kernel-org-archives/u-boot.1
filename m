Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68781C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB2580BB1;
	Sun,  9 Feb 2025 13:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Vvxe0gJo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ph7RtXgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7972380BB1; Sun,  9 Feb 2025 13:05:10 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6211C80D28
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YrRGr0rdsz9tCd;
 Sun,  9 Feb 2025 13:05:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TjWMPQu6Q/XBqueB6lDKfzEEnk6ub5KvfLji6DMCIY=;
 b=Vvxe0gJo0N1BdXFOzKxzwVS5KxWkZF9Hud73YEs4pCSoTsMF6MRLw33cjjXMUbVn6zek/n
 z0RTx+a/NMYJKWfRUy2Ogle96dB5YANtuCN8KYnHma6nS6e2So2oifj+7LgsihBFoPUIl+
 Z6e1tjvpBnOHv/krQ973oX7UPNjSBHRvyvO+e/vHVcmF5AiaBkG+qTqRvH8CTdexrBTYEo
 Zj44zUFNa6p+MujDrDYSj1YENW3doIZm3UYFlu9iqmYiWx81uxE1n1n29hYUTHetK8pCxW
 K6DMsx4o0ptd3dNZ8ZwNFFQWVy4TvOI9PiwXVMCOstziYV83G+72AHkoJ/HZRQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TjWMPQu6Q/XBqueB6lDKfzEEnk6ub5KvfLji6DMCIY=;
 b=ph7RtXgfja6rS0HKpw+Ca/nXpCiqM+fB6XE7L6HNDKk/rIRYCKVOPHajzh9cUaySNI9E/W
 HfYT3qTDHB0OZJvtiar8/4H09XAjVZn3Re6Ma31zqTLyGbJ4Xt+qPNIxjrk5Jl2OTWPvgE
 NAMXdvgw/fUhRo7HZkx2apPy3K7Ynm+Z7ELMgbhotJwD8psYxcDxKGylofxcRFABePYeWT
 vN4IyGPalnNDAMAc4DeT/Ku+IRgBWx9MeWOWi6lQRUY9GrEBXL8UhVGtZZvoK2YHtFu+Sr
 aguordF9N4zSI7+ha3dS1q4NhsZKD2T5mTGihvhKBO01KMgYUoHY7G8C/0/yvQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/24] net: miiphybb: Introduce
 bb_miiphy_alloc()/bb_miiphy_free() wrappers
Date: Sun,  9 Feb 2025 13:01:40 +0100
Message-ID: <20250209120403.5321-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: z5cotqm51pjg365xjfmk1hnx58rgwztj
X-MBO-RS-ID: 233b6bda4fdc4251606
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

Introduce bb_miiphy_alloc()/bb_miiphy_free() wrappers to allocate and free
struct bb_miiphy_bus. Make struct bb_miiphy_bus wrap struct mii_dev, which
will become useful later in bb_miiphy_bus accessors, which would be able
to access struct bb_miiphy_bus using container_of, even if the PHY stack
only passes in the inner struct mii_dev .

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
V2: Update commit message, fix duplicate _free()
---
 drivers/net/phy/miiphybb.c | 19 +++++++++++++++++++
 include/miiphy.h           |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 75d9537b355..66d98d6cc26 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -14,6 +14,7 @@
 
 #include <ioports.h>
 #include <ppc_asm.tmpl>
+#include <malloc.h>
 #include <miiphy.h>
 #include <asm/global_data.h>
 
@@ -30,6 +31,24 @@ static inline struct bb_miiphy_bus *bb_miiphy_getbus(const char *devname)
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
index 40eb14669b8..42300ee5386 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -73,11 +73,15 @@ struct bb_miiphy_bus {
 	int (*set_mdc)(struct bb_miiphy_bus *bus, int v);
 	int (*delay)(struct bb_miiphy_bus *bus);
 	void *priv;
+	struct mii_dev mii;
 };
 
 extern struct bb_miiphy_bus bb_miiphy_buses[];
 extern int bb_miiphy_buses_num;
 
+struct bb_miiphy_bus *bb_miiphy_alloc(void);
+void bb_miiphy_free(struct bb_miiphy_bus *bus);
+
 int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg);
 int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
 		    u16 value);
-- 
2.47.2

