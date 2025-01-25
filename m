Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD48DC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 12:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA3680C77;
	Sat, 25 Jan 2025 13:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="H7tsnfCc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PnG/kdft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D9A380C7E; Sat, 25 Jan 2025 13:29:25 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4DF80836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YgDWk1mLGz9snh;
 Sat, 25 Jan 2025 13:29:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737808162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PI8SwhJeIjdIprW1lSq3rJpOQrKtG/iSloESeEUKDnQ=;
 b=H7tsnfCcDfYpFkaVmImqJlSJmOAkXm7gzo3O6o1O1aAxAtqxctkqKCqOKfGG4bUENZzCMA
 PDz39FVXGegxnMzc8cCqx719kVwHQAbWcPXbrZsXKLws4bH5YkJG45Js3x120pFW8mFYnt
 Vc0//EzBOT2MDo3HkIRDuoUw7TgHx4mJ5DfFyBK4XXx/89xWuoa8keKrpfVDiVgHBjTp9t
 WCeowir57sDgEMDbP5v6do5l3lZ9t/c0XxjlTZAGxn3aiH8Ai1V2epCHM7j9z3dJ1Y2I0H
 QcHrowHbs4Lx2jO0mnbYmwoJWvCQdkinPPuqHMapmHtPwPAwRgAztnK+Mtl7mg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737808160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PI8SwhJeIjdIprW1lSq3rJpOQrKtG/iSloESeEUKDnQ=;
 b=PnG/kdftQnBEJs/yjBIlmmnKiImlvY/PEU+CrzJzMSWTZqpIb8IMWfjy0gfyqqZFNFtEF9
 UHn7Kfng33myxN+TTNrU8F7yf1d0LKxh3SIzY4gJ2+1lFZluwcmEpXHi0D68zOLS6msvGr
 7vN+eznSneJBi9OUJjDyH9F1akKkgPr74X8kqDX75aWisSmr9eiERYQUT+6GUptxT9td9F
 Vbuap2OHe3jeCPJ7MTZoxatb3sRoUltMb7Tu4kMKKEjiPhJp4X23g95DAy3+AGJETySFEG
 w7ZWlMpfKyHQ4j3uelLZUqk9J+0FQCA4Nj18cJa/TaS8Z3/whl/a3Fswz4CL7A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: miiphybb: Update debug() print
Date: Sat, 25 Jan 2025 13:28:30 +0100
Message-ID: <20250125122907.49962-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 43z4ct6ehgpwfmos6y7pzose7mpir5f1
X-MBO-RS-ID: 8b386a0c6374a9f6df2
X-Rspamd-Queue-Id: 4YgDWk1mLGz9snh
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

Update the debug() print, use __func__ to always print matching
function name, and also print bus name in case there are multiple
busses.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/phy/miiphybb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 5497b838225..9f5f9b12c9f 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -183,7 +183,7 @@ int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg)
 	bus->set_mdc(bus, 1);
 	bus->delay(bus);
 
-	debug("miiphy_read(0x%x) @ 0x%x = 0x%04x\n", reg, addr, rdreg);
+	debug("%s[%s](0x%x) @ 0x%x = 0x%04x\n", __func__, miidev->name, reg, addr, rdreg);
 
 	return rdreg;
 }
-- 
2.45.2

