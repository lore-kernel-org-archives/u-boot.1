Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D4AC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B6DF80A35;
	Sun,  9 Feb 2025 13:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TmiI/r+3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O0a/w3Ln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F27980C91; Sun,  9 Feb 2025 13:05:01 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0924D80C72
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YrRGf5XPnz9tCw;
 Sun,  9 Feb 2025 13:04:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyFaBJCW109i+j3CYpRsaWUphUpaaieyWs6ygX1vEg4=;
 b=TmiI/r+3ZgPAK+8GmYHTlrn04YRwVEKkgFxlclod4FXtdgcFMyegJ0f6lgGdLZLrBqcuRX
 6tQp3oyEwuonfhUUI5dyCHuobU2hcIjfDa4BBcChTTr0kFarRT7KataN2wQ/1dkTZ7ByPn
 1caVWMYYhz1zUqGFFe8nbxMR6vS4TSC3W4s7iRGxuti0MDyXvQvG2ojVSgZzDBQYQfUqpc
 7OoeSYx/s2Hm5JfIb2tQo0eEUhaNnI23bHY4j8lBjJxOHxHparWmDnOSWfHL/rqF6Fd3px
 1TQGpxH+fflsNUTp8HmCBZiIPtxhpRXcA8qbLhjwvHtKvMJZLPwo9VDaQEx3fQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyFaBJCW109i+j3CYpRsaWUphUpaaieyWs6ygX1vEg4=;
 b=O0a/w3LnK7YhWPKi3NiHUk6gH/TrmZOkMv1ldSRgZ6Tn0F4X9K++ZC/9Yk7drBBnR4n/Yq
 TSssUHJfCUjpPNVphqoBGRRQZjzUA00Iss0/18LbK6uDqIWXlJ0zPpuooyLazUXg236hhx
 mYkZ+MpOL1m4DXoGd0rufAfkTfIcCqPPIdqYFPsi/q7GPWVcRe1hhFFwMyMDALTkYgpUwQ
 TwQiV5m3HItMngEHrnLuSrs0KMaGGY5AvnSC6PqTTm6sOGFatD9Sj6pbsdDOxtcg4P3zBN
 MMMDQ9jb/fyH1fdvb/4j2cli2YeLJQr2wcMW/A9/6fx3/g48MzlvTrIIvzY9rQ==
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
Subject: [PATCH v2 10/24] net: miiphybb: Drop .init callback
Date: Sun,  9 Feb 2025 13:01:36 +0100
Message-ID: <20250209120403.5321-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: engtek3obyset1imjyxjewb1rucx69hj
X-MBO-RS-ID: d7c0b2d3a72ec65bdfc
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

The .init callback is not called by any function, drop it.

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
V2: Reorder this earlier in the series
---
 include/miiphy.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/miiphy.h b/include/miiphy.h
index 2485cb880ab..0464f5dc219 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -65,7 +65,6 @@ void mdio_list_devices(void);
 
 struct bb_miiphy_bus {
 	char name[MDIO_NAME_LEN];
-	int (*init)(struct bb_miiphy_bus *bus);
 	int (*mdio_active)(struct bb_miiphy_bus *bus);
 	int (*mdio_tristate)(struct bb_miiphy_bus *bus);
 	int (*set_mdio)(struct bb_miiphy_bus *bus, int v);
-- 
2.47.2

