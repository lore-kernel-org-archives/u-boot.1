Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E88C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 08:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364A687FA1;
	Tue, 20 Feb 2024 09:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jWwlFhtr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EjeXeyIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 101D987F9D; Tue, 20 Feb 2024 09:38:25 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 172C187F97
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TfCTr4pZDz9sbq;
 Tue, 20 Feb 2024 09:38:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uOrN7NYyPNHyDKdvpNPUYN24u+LNi33ZFHywkMEvYfw=;
 b=jWwlFhtraqXwCDbi5lbfbvD/eY21qoZyw15j6De4r1QfYIRXEq2iVs/cGFgKoMZ/C+olP/
 esdwfWiw5OuDsq3mu6+hFPH2CawvlW8oYJ/t0WAv9gVrgWWr8WeqVF91GExWhDtb0aldHm
 Rn+WMKL5VXHXsWsGK0RQWknhbPImRmblkRiDyOWXqXj5E7DvKfC0pEiql+F2ysTjwt027Q
 oEwRrGM3NkbX/RhnRbAPWpEm8XwDSqRPPnzLISJ4gczCDCzrUlHFX9nVlleOOo/tPfwYu4
 GpumqhNRPbofr5ljF5R4/Mh+eiZ4cQ9qEETVF7LZmw/Oi5aVeEdFne6RbzoEgQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uOrN7NYyPNHyDKdvpNPUYN24u+LNi33ZFHywkMEvYfw=;
 b=EjeXeyIKwvyc32Uv8m5aJ6M4fbsjnqZIgBPXpsflUqdiXjbF9OJ8xdwizmobGjOkNj9ul0
 aCcJIb23xRc7uIlxEQPBzt9MOyTnlYJ5mGAfunGM3retWvrK4qE/qEStm02wyT+4ty+RPw
 idpgUPnEA5FQVv6GC1JYFJ53q3uZ801S3xvpcXIQJvQ/WZkYTrYdXZBsKdxMEEpjgTeBqk
 DQGDW1bQ7oqyDK3DjGOIfxcUtANtrBEpdWCmI6IxaJuPqETAUARUNBeBxYbRJnayZBktxC
 THduQKSJogpSi5z826ViMQdoEp2iSzO03OPTY9/i5fr74wR5M+2CLwOBzva97A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/3] mmc: Convert hs400_tuning flag from u8 to bool
Date: Tue, 20 Feb 2024 09:37:47 +0100
Message-ID: <20240220083755.34449-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2dd5cc67e4ad7425bd2
X-MBO-RS-META: ex6wrschjz3cynd35nddnt5kiq91ddhy
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

This hs400_tuning is a flag, make it bool. No functional change.
This will be useful in the following patch, which adds another
more generic flag, where the compiler can better use the space
now reserved for the u8 to store more flags in it.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/mmc.c | 4 ++--
 include/mmc.h     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 83f9ae8bb7d..07d87c993a6 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2027,9 +2027,9 @@ static int mmc_select_hs400(struct mmc *mmc)
 	mmc_set_clock(mmc, mmc->tran_speed, false);
 
 	/* execute tuning if needed */
-	mmc->hs400_tuning = 1;
+	mmc->hs400_tuning = true;
 	err = mmc_execute_tuning(mmc, MMC_CMD_SEND_TUNING_BLOCK_HS200);
-	mmc->hs400_tuning = 0;
+	mmc->hs400_tuning = false;
 	if (err) {
 		debug("tuning failed\n");
 		return err;
diff --git a/include/mmc.h b/include/mmc.h
index 2b9a6aa8ee0..92cffc6a19a 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -736,7 +736,7 @@ struct mmc {
 				  * accessing the boot partitions
 				  */
 	u32 quirks;
-	u8 hs400_tuning;
+	bool hs400_tuning;
 
 	enum bus_mode user_speed_mode; /* input speed mode from user */
 };
-- 
2.43.0

