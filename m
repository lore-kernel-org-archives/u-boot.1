Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51170C0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF7880EFB;
	Sun,  9 Feb 2025 13:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nzCvuRX9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NBjG5n39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA21B80EEF; Sun,  9 Feb 2025 13:05:26 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF963807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YrRH84MNRz9sdF;
 Sun,  9 Feb 2025 13:05:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7dq4YiiXbfkkH1XsImjsi+OO/W2iBcSAzIebQmPkW0=;
 b=nzCvuRX90p1h8LPpAgR2YKAy4shpn2lvNHR6d+EhBEs9pKjCj60EPY+eccrIOqU2rAgYfC
 etCS4xCwFmIXUSO0BIlnws0ULnsl3sfg3YCfe5f3v6R5VcPoFrLwIpmRdXMqojunoUZlwI
 C7KeYhNtWsVzga7Lr0OIb8F/nqWZtrUjrsOpMCyYVrHj6h5TGmOlJZRTBl8bnx7HwYDFn+
 XU3+Kd02xnh5r0s2ZK2JdzQ+9e6i8T6AcXHyxuAlVoyyY/xgBCnM30+DoDWj54AGbM0gAO
 0HM1UiAZChUsdFupeg6Os6ICqJYwOFhMdWerELgSFP+zJHn3KUvSruXqrAOuyA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7dq4YiiXbfkkH1XsImjsi+OO/W2iBcSAzIebQmPkW0=;
 b=NBjG5n39mqeFV2WQ4yiAY0E2NVhvqgbdPkPaDhFe1WJhwYB4uJli2VUR0cAoUwmdaUiXxx
 OoZezKBimQRSMeq45NEXuCiMEpFJQH4PuycfhJiaSnV50BeD7t6MLqWek6df2/jBdoHb7k
 VWzGZzKiQxM9y0JavGazy4Q7g2t+SY2IJWdxgKIWhNqkI+uhBVC/xJhWV4MY5uRY0HyErt
 mdlDAc5W8qoMIJvnep95QnGsrslT+O/YT5sHHo3vtladsl2RGsgPVio0bxEqV4hoLiP0/S
 uS0OcegAncyJYjuQ++3eIvJtA46xjW0ZAt4vrPbJmyg2oMBhNhlnvn9cqoEmgw==
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
Subject: [PATCH v2 21/24] arm: mvebu: a38x: Drop use of
 miiphy_get_dev_by_name()
Date: Sun,  9 Feb 2025 13:01:47 +0100
Message-ID: <20250209120403.5321-21-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 87u4gdhaddi3kk5b83soof78giw4tjgq
X-MBO-RS-ID: 10da61bc92b995044c2
X-Rspamd-Queue-Id: 4YrRH84MNRz9sdF
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
---
 board/gdsys/a38x/ihs_phys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 128b1395243..71c9398c77a 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -245,7 +245,7 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 	retval = mdio_register(mdiodev);
 	if (retval < 0)
 		return retval;
-	*bus = miiphy_get_dev_by_name(mdiodev->name);
+	*bus = &bb_miiphy->mii;
 
 	return mii_mdio_init(bb_miiphy);
 }
-- 
2.47.2

