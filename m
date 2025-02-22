Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C53BC021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E9C80FA4;
	Sat, 22 Feb 2025 21:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WURMqMgs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="T3vp/f2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C40380540; Sat, 22 Feb 2025 21:36:46 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C651800C2
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z0f180Q7gz9snt;
 Sat, 22 Feb 2025 21:36:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ln9RzDbPbVNhgZtsiQHjPHA8IfLw+VkpOID0AqP3KY=;
 b=WURMqMgsuu44IYwp3tsrNd2EPM6TmOl8Puu97vyalOQvex7E2KKT/ycz7EFlXFRjgriiWz
 kVLecdXOzgsUp32Rw8QcRJIU38r8Q+Z9Djy83oXGgaNDWmSqGgiRSjbA9nkzsTnTQXJSrK
 4iN6fyxLkyjaB2dpzvSRG7Nz2Y46c/NzJPsUyfD3nUg1ivtn7ksIGT9tWxEvbsJf5TRfbY
 iZU7gngwVCRV/dCYV53IBNm/eQ1KWlpJRo8HywOQKOA0qCgPOfLq3XcncHHAU+Kf/Cvfzr
 NKSfVdBHKtp9WPcHrC4SGkaqlHrsHD7fvqPo0To1RqWfrBvqgCRuOn8n1OeoTQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ln9RzDbPbVNhgZtsiQHjPHA8IfLw+VkpOID0AqP3KY=;
 b=T3vp/f2jhviOloxdCvyD2YtSOIh2VdyDWt3IsEIek3uw25P0YuxlvJpjEdUfhlhpSkft4d
 mXsidjVoWnvwmn5mNRg49ID9QmUFZslyItRrCASGuDmX/Xau9pfQaayo1SIKK4ou7OnzTr
 9bTeGwB/lBk7WTLqV6CExAo/4wncp/PFQaxKvq+kLqsKv/nozTkJJh7v1fQV4aOC5TaK2a
 yr+8HeBBv5yFZSdD1fN+SGW+eC1NquAKMIC9bK0vMcXIhxbyhY9KsSDt5FJi4GJva61whd
 r4eCUAu4h/Qf+UJHYiP5dFeLfz3zKLCdxjcSNF6Y1kXyNXOrDQoo2DfhcTKLiQ==
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
Subject: [PATCH v3 22/23] net: sh_eth: Drop use of miiphy_get_dev_by_name()
Date: Sat, 22 Feb 2025 21:33:32 +0100
Message-ID: <20250222203511.195437-23-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9282dd59a02cad7cf51
X-MBO-RS-META: wsyceuho8n6kppox8g8ppauebxopu96z
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
V3: No change
---
 drivers/net/sh_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 49065ebe717..b1e35aaf291 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -753,7 +753,7 @@ static int sh_ether_probe(struct udevice *udev)
 	if (ret < 0)
 		goto err_mdio_register;
 
-	priv->bus = miiphy_get_dev_by_name(udev->name);
+	priv->bus = &bb_miiphy->mii;
 
 	eth->port = CFG_SH_ETHER_USE_PORT;
 	eth->port_info[eth->port].phy_addr = CFG_SH_ETHER_PHY_ADDR;
-- 
2.47.2

