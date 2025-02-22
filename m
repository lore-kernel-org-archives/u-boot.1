Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AE8C021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABDB7810E6;
	Sat, 22 Feb 2025 21:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZhyyZqfO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FuwN2Zvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9EA81101; Sat, 22 Feb 2025 21:36:41 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E50800C2
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z0f131csfz9sdJ;
 Sat, 22 Feb 2025 21:36:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfCBYqTtVIH82DxzwrdG3tUn9O/vMZdO8/7WYIX74tg=;
 b=ZhyyZqfOQRn0LA7NdTh2PMmjGTQ3Y0HpqIgzPF7Py78VfjRqgjo+uMT+Mq/04VEs5K0DBt
 rbBAhTTIk4Y70iU56ioYgpJ3q/LORbYXQ2LANSB6VCalsmPIzM6aX8CcGZ6h4Dr87SbZJc
 LW5qazN4iQmZdLSocKIY40UhWt3gclEeco/A8LAyiCSRmCtrffMIRGm0qwLzH6yBP+JDtp
 0RIqB8omjbzcbfCCFKnQjt0bns2syT55stpfDVjpzoctRQRvWPAkZssv4SviSn/dI9kSXu
 6nKpvugrd7U0b3noWY/vD5ix8Z+19CBxtcj2FEvkPlgen8bYOToRv2iGQWC6Uw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfCBYqTtVIH82DxzwrdG3tUn9O/vMZdO8/7WYIX74tg=;
 b=FuwN2ZviHzgDsth4hPTfqb/Xhs8rjC27n7z2mR5o1aCmv3fHrkHrBBlVuO86vStMlP3kVG
 EhPkNzznnzsf3+0T9Q2GGyPnz0JEYFEvXfMXtcFb5kyamUAlSjCu7v3K8UHA/DHRYHslAT
 faWJvJuIThtRc4w8Zq3Ey+GDetrNLeUm0ESWNod8XamrXZSNIHHEpGykaHhEPwfQ1eS0nx
 +g7ua2Rf65MCXrApnEGRCCurwYiRg++sN0hBiDMRGEymX8rR6izvYFTMSCc91Lrc6pPUDL
 0hiSoAIHkPTzB4L6CdKYzdmgRn2wVyRwJKvIHCnBjKAZ8vr4mxJbJ+atiBmaiw==
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
Subject: [PATCH v3 20/23] arm: mvebu: a38x: Drop use of
 miiphy_get_dev_by_name()
Date: Sat, 22 Feb 2025 21:33:30 +0100
Message-ID: <20250222203511.195437-21-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7c19cabd1d4d4ad5b3f
X-MBO-RS-META: 4ps1a45b95n44sqqfqphxiqqotxzhfw6
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

