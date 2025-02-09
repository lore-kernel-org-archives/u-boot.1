Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499A3C0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B28280834;
	Sun,  9 Feb 2025 13:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qc8VejD4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WTBytAYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3495280D28; Sun,  9 Feb 2025 13:05:08 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1949480A29
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YrRGn62NKz9t1w;
 Sun,  9 Feb 2025 13:05:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rONil022XX+l+kSQIv68Z3iKUVo2O2kPwAup9sNf2aM=;
 b=qc8VejD4D8L6o/AwvWXlcNc3vUu3cnwecvW2B3XJAOyX8CmELnfxLCLXA90oXOjDDsnDaT
 ZbcTd1ML2OEZLI8N4BpszvvTjARkB0A1WdWp3jrSkBmLZlJwcNF0npC+Zy3B1xNz35NKLn
 2+qN76jT/IUWCnejhtHL9er5qgLUxgQMJ58zzfjWTsrjOSE+FYJ8w6r1XaIlOuiMgeZNvu
 oDSjsyiEtNgeEyOCxHEVD9Yx2J+AMicTG4UQwd9GwWCqhM6Mobm1qxLr3wtQfCA7bnyfSf
 MaDwVRw4wpDuUiUzOdH6bqx+BEhVtWNx8W/N1CMQOs3qcoW5dTN2ct8a0xU6kg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rONil022XX+l+kSQIv68Z3iKUVo2O2kPwAup9sNf2aM=;
 b=WTBytAYt8OqeYVcV3pZXYlbOLCaFZcTBMr5jL/JQ+otRmKIp8oyZoHQUoPpe7S32RF7GP6
 +w2YKNbdM27eF8wFI911ws7GGuB6ITbnSwrydYEBKvPB4dkCVZbyKUySH9pDYV8skNcsxb
 2AZ7PBqDmow2XgVdmq6A6eivnVfWCl58d16PWQ96pWelENSnN/hDVkmQLAvFSmWWMbawyh
 t7ip0q6GqjlF26kpP4U4RNiQYj3m0UzPdkzlnSCDOn0cw8AB2blpMywpvukdgrZZTYbbhB
 kpeF/CZynOt3J+C7dHbNBxjMAbnrHtLCmZPxhj5C7JBUjrExnOeBccvNgiHoFQ==
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
Subject: [PATCH v2 13/24] miiphy: Introduce mdio_init()
Date: Sun,  9 Feb 2025 13:01:39 +0100
Message-ID: <20250209120403.5321-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0a40aad41d2e1969812
X-MBO-RS-META: bp8exrh5bydo15zcudhto6k9h1dp98th
X-Rspamd-Queue-Id: 4YrRGn62NKz9t1w
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

Introduce mdio_init() split off from mdio_alloc(), which is used
to initialize already allocated struct mii_dev.

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
---
 common/miiphyutil.c | 13 +++++++++----
 include/miiphy.h    |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/common/miiphyutil.c b/common/miiphyutil.c
index 9b8744e5d8b..2a034d3a77c 100644
--- a/common/miiphyutil.c
+++ b/common/miiphyutil.c
@@ -65,6 +65,14 @@ void miiphy_init(void)
 	current_mii = NULL;
 }
 
+void mdio_init(struct mii_dev *bus)
+{
+	memset(bus, 0, sizeof(*bus));
+
+	/* initialize mii_dev struct fields */
+	INIT_LIST_HEAD(&bus->link);
+}
+
 struct mii_dev *mdio_alloc(void)
 {
 	struct mii_dev *bus;
@@ -73,10 +81,7 @@ struct mii_dev *mdio_alloc(void)
 	if (!bus)
 		return bus;
 
-	memset(bus, 0, sizeof(*bus));
-
-	/* initalize mii_dev struct fields */
-	INIT_LIST_HEAD(&bus->link);
+	mdio_init(bus);
 
 	return bus;
 }
diff --git a/include/miiphy.h b/include/miiphy.h
index 0464f5dc219..40eb14669b8 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -44,6 +44,7 @@ struct phy_device *mdio_phydev_for_ethname(const char *devname);
 
 void miiphy_listdev(void);
 
+void mdio_init(struct mii_dev *bus);
 struct mii_dev *mdio_alloc(void);
 void mdio_free(struct mii_dev *bus);
 int mdio_register(struct mii_dev *bus);
-- 
2.47.2

