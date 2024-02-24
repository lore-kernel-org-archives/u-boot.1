Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D790FC48BF6
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 22:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E13D787CFF;
	Sat, 24 Feb 2024 23:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pMOhTX3l";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bd7/hv0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7181087CEC; Sat, 24 Feb 2024 23:33:00 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579F4871C7
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 23:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Tj1qG0Pczz9slp;
 Sat, 24 Feb 2024 23:32:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708813978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aE7FgM4VxulR5Njm9qd9pVpZz9cGGj1BYch/km/bQf4=;
 b=pMOhTX3l/u86LHJHOvI1l59PzcNxLs2pgzaDVDcm+E2VQujuvMcwRRacKdtA4Px755xeKu
 bcPEICSpquWr1J3JYdwQaEngODPM41lsf7XSyWip+M+ZsmIojU44qupkTQz02cQqkoAFZ7
 qAsHn1JOsg62b27P3ef1VsGba/FSGUCnIgTg55ur71rPbjNK6h98/vIhC/xMwVsMR/wH77
 QfMDunhNqKQp6WSJWSumtdlRfkr1WvnqjbwFDXtmvMc/hUpp8uwOAiwS85Y3fLUpksEcz1
 Y7KyeON9nVZ3ByMgUTdG4WV0fAUICCz6F1WFAELbPm9nUOM0oFo9fftsi0MZkQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708813976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aE7FgM4VxulR5Njm9qd9pVpZz9cGGj1BYch/km/bQf4=;
 b=bd7/hv0ZNXaPnYV9pQX+adQozVdV1B3Nc7cyt/qGZdVMBQK1oxco51goQtcSUJ7i2TGdjt
 0XvIlOz/+TfUk7iYECkiysl7poThTF9hRcThxgt8enq0wJ39twnmfiZvhsdD3CHPPe81zB
 rt/kkVOhEhMnWjaEJ9qH6vZEQSVfs6d2IoCbm0I9V8mknuliGDHLgLgg0SohuksGcn6LJ/
 uI9O9B35Mnihqr7K84W7cDHI4gp0FlpfbLVA3/JRvbps/7OmdCeelgWtCxC1PO2Q4rwGzX
 a7G1DsWsFoigNAvOY+LCb8Zq46v9N3DR2GZu2YsFz5s1WQFppVblMrYTtVRpww==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 1/3] mmc: Convert hs400_tuning flag from u8 to bool
Date: Sat, 24 Feb 2024 23:32:09 +0100
Message-ID: <20240224223235.287889-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fnrb1nt4xy71n1wzmoqa356eiif9jz4h
X-MBO-RS-ID: a2f48e80b415775252e
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
V2: Use bool var:1;
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
index 2b9a6aa8ee0..afca123b386 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -736,7 +736,7 @@ struct mmc {
 				  * accessing the boot partitions
 				  */
 	u32 quirks;
-	u8 hs400_tuning;
+	bool hs400_tuning:1;
 
 	enum bus_mode user_speed_mode; /* input speed mode from user */
 };
-- 
2.43.0

