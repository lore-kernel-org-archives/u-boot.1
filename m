Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFF3C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97393807CD;
	Sat, 18 Jan 2025 07:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GRadxAvo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rkj50HsL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8A52807F3; Sat, 18 Jan 2025 07:54:59 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 603A5807CD
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZnR51Z2Gz9sqH;
 Sat, 18 Jan 2025 07:54:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNzX9PG1la3/k3aCxHr7PdxgOOlr5Z5Bthr4eZL7CFU=;
 b=GRadxAvogvQpmA4ekyqEXWM4yFwHxly/87ibXaEHGvVmCd7DWctfoxrKWiRWf8djq96KgQ
 gxkhiioHG4GQCxD76V3cdBUz6CBeZeAcCQqZ1pYrFZK9Bk4nvVYfMU/W7oBsjYCVVSzTJi
 QCh6WLUIvQsI4wBNBBokut8qJxNKAra7keJFYYoPtfVAFEeAI1I2NEr+eDy6sVDN8+wuPh
 mGgY0SxDK44Cp8s5GvpZCntGanQvE81gH1CbS0UsKB/pqtvd+JePLRaGnQS7OwcqrVY1eE
 2MPX1fccL1BLNYwcPYOvCYJrj4dN5K/UxkheEeA+CzK7uCtb2wI8NGBDcWiIxA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNzX9PG1la3/k3aCxHr7PdxgOOlr5Z5Bthr4eZL7CFU=;
 b=rkj50HsLN5xiSPN7Sz68MZ/50hK4W7r0EEgoEV5s+HEGqUdZm8Q2IvLLa9Rf0H3R1QbK1N
 UurL6OvHkoJpBoN6rs8ezi1oZMXblCWxVyiLalPRgH2vfbwUUUhR0Y3ytSZRuhY8Tdqxwx
 sn/6yHYTSrh6Y6V+ODTaVOrPCmdij1/StqtbgbxR+JhPBfY7LWWoCFjI2qVW0CBkaeRa8Q
 CwDhRmcvS6BTEkcOlsVQQw3+f5zd/uBKgJHUJlZSVmfzUfVt7eAjMUHiDJKHOZycBBcJb5
 h6iibGY87jvO4qEXbtw0XZ6YBGocRRziDFyZnUGH5Z+tFL2FU3yhvbYeeLCeFw==
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
Subject: [PATCH 15/17] net: sh_eth: Drop use of miiphy_get_dev_by_name()
Date: Sat, 18 Jan 2025 07:53:19 +0100
Message-ID: <20250118065402.172253-15-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cadd2d8c23c79d85f26
X-MBO-RS-META: cw8hi6xicwfyx7x8kxqhrnrsxg9jzsj7
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
 drivers/net/sh_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index ccfb31d40fd..824a4a7e004 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -754,7 +754,7 @@ static int sh_ether_probe(struct udevice *udev)
 	if (ret < 0)
 		goto err_mdio_register;
 
-	priv->bus = miiphy_get_dev_by_name(udev->name);
+	priv->bus = &bb_miiphy->mii;
 
 	eth->port = CFG_SH_ETHER_USE_PORT;
 	eth->port_info[eth->port].phy_addr = CFG_SH_ETHER_PHY_ADDR;
-- 
2.45.2

