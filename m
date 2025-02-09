Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFADC0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F325780EBB;
	Sun,  9 Feb 2025 13:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N3sF0338";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IQ7s8zKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454EA807D7; Sun,  9 Feb 2025 13:05:29 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B3A280EEF
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YrRHC04wMz9sQb;
 Sun,  9 Feb 2025 13:05:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cC3dGjBfo8OmnOsdGv4eNuGt5QHCQJNg37Mp5oVNBa4=;
 b=N3sF0338PSK3bsLsW0Ve6bnfJZ7WDT4nQEo5NruRRRw/XeuyV0q5pfx4BeH1XVXjTK7niP
 fWua0IVmUI80fyVsy91mH7AwALfynCRUzKhNwZSR1QjPo+k7VTN0q71T8OlB4woFCMGPBP
 I5BsZ8Ciu79cRqJQkhc6epkbuyGfd0r8DWebRxynqsAOBK4vXM2nplHvbUfafGdZoO82yH
 EV58/SUDqWkwdfVBtOqg1Z845kD9rqtJ9ZD8EiPifugdB8a2rIYp3cBNCahrOvemiHutbg
 wzVSdwqXQ5qP2dq4SOPEDIAbrlMylMGUcg+OR4wJwVMjfBiQCXKk6w8t96kZyw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cC3dGjBfo8OmnOsdGv4eNuGt5QHCQJNg37Mp5oVNBa4=;
 b=IQ7s8zKPZrUyHjz2o4A3CXBa/IkZ7ez8BYQk0EL6x27qUpSJs+dJdJceSDtUXm73239M8h
 8nCLlFza4B46vhiogvoMEeVmfDv76XVT4/xztkQO8uWfESO39Bg7xuceai+FSJTInyaEga
 2kheLyILZTHRiRkqoLXSYmKm70LQY+7uewgF7h0UUn1Lr5y16EGpdP+8TqSQw+mLvhg+0h
 5xJ//uWejTLqyusLmJMwf1jP7eiUTWMJSdHR01jKU2tUua347/qTTaKcw6sHvxIWGQIm68
 wKwm9IPPa+t94cNCo1SJd9lKWkUsoXBQ/U+tZIAyMG8VoBL5VptwiilkN0OXZg==
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
Subject: [PATCH v2 22/24] net: ravb: Drop use of miiphy_get_dev_by_name()
Date: Sun,  9 Feb 2025 13:01:48 +0100
Message-ID: <20250209120403.5321-22-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5647af7bf8a3f715686
X-MBO-RS-META: ug7eouxgq59dntr1d8by6ma5buobwnxx
X-Rspamd-Queue-Id: 4YrRHC04wMz9sQb
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
 drivers/net/ravb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 86787183488..b790de98b48 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -591,7 +591,7 @@ static int ravb_probe(struct udevice *dev)
 	if (ret < 0)
 		goto err_mdio_register;
 
-	eth->bus = miiphy_get_dev_by_name(dev->name);
+	eth->bus = &bb_miiphy->mii;
 
 	/* Bring up PHY */
 	ret = clk_enable_bulk(&eth->clks);
-- 
2.47.2

