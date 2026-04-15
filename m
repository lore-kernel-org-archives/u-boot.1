Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB3AF433CD
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 21:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB3A384119;
	Wed, 15 Apr 2026 23:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LbRZi/mx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WZYF5VAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE52C8412A; Wed, 15 Apr 2026 23:58:45 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC56A83B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 23:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fww5H0tR1z9tft;
 Wed, 15 Apr 2026 23:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776290323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FK9e/lOcINgPd93IBVKdxnrY2BoMrzL+cSzaWwJHHMI=;
 b=LbRZi/mxdwMTimp+PZTA4jBSa7L3u7S+YG/eowu8ZYZVzv86FJuf+htrSidJnYHKrw56j7
 yPWM677anlYj9f5n9uIrEuHNwSzx701IVA9nTfUTMTNhL9bHzpkCZ6ilJIoGHL1EfETJf6
 QXyG0SFmoDdyytNmQvPxQ3SmWhBtC1ORKwYbFxQT0WymL7SLaphjMt5QkLGCsHS4Ofaam/
 I1wfpFmwc2QMPKp5NrTTFi0yVosDmLJdmPsiHaL7OprWvKg1c7HYhl0mNYHFADqpzzijH3
 d7CyOeoqi1xWAeXV4dezQ+kLDs9Cb8kGVG4d9xAjEO7l2h0cPkWo61hhKRo/Qg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=WZYF5VAq;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776290321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FK9e/lOcINgPd93IBVKdxnrY2BoMrzL+cSzaWwJHHMI=;
 b=WZYF5VAqK78K+XZZGy+Z0kZUDfNlsgtOdsKbzzZfaQTT6SOg+49+nq238aAsG/xXIshh9n
 ENlyPF5TFF5Xjnf5XP4fUzajaaYbXELknpea6dNyfSEcaqllnZDc0muPhHp6TW/iHsLo5s
 /g92yzX2lGciuU/FZ9VSA8QuVqyEKyrf+KRKXP+FeUwuyTy1MWq8CO7hh300nysWUhzog2
 P29myHNa5lUpkxPWPAp14fGVS2Bc9DTowpKJBsinKISokPiufNyH8ES7aKG6NHog2jc6py
 FC7K7GwW7YBmVbcEn4eEPvlwaDc8j0BVUdrAY8ZKnQnHg6dsaIlrHJJTNp4aVg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] ufs: rcar-gen5: Update line reset configuration
Date: Wed, 15 Apr 2026 23:58:08 +0200
Message-ID: <20260415215837.448867-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9cd5725c573c8752888
X-MBO-RS-META: mzisbg51p4q15uttwn768rd7syymsk7h
X-Rspamd-Queue-Id: 4fww5H0tR1z9tft
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

Synchronize line reset configuration with SDK 4.28 parameters.
These values are programmed into the PHY.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/ufs/ufs-renesas-rcar-gen5.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/ufs-renesas-rcar-gen5.c b/drivers/ufs/ufs-renesas-rcar-gen5.c
index a21ae3f390e..a9473cd60b1 100644
--- a/drivers/ufs/ufs-renesas-rcar-gen5.c
+++ b/drivers/ufs/ufs-renesas-rcar-gen5.c
@@ -92,14 +92,14 @@ static int ufs_renesas_pre_init(struct ufs_hba *hba)
 	ufs_dme_command(hba, 0x00000002, 0x81010000, 0x00000000, 0x00000005);
 	ufs_dme_command(hba, 0x00000002, 0x81150000, 0x00000000, 0x00000001);
 	ufs_dme_command(hba, 0x00000002, 0x81180000, 0x00000000, 0x00000001);
-	ufs_dme_command(hba, 0x00000002, 0x80090000, 0x00000000, 0x00000000);
-	ufs_dme_command(hba, 0x00000002, 0x800a0000, 0x00000000, 0x000000c8);
-	ufs_dme_command(hba, 0x00000002, 0x80090001, 0x00000000, 0x00000000);
-	ufs_dme_command(hba, 0x00000002, 0x800a0001, 0x00000000, 0x000000c8);
-	ufs_dme_command(hba, 0x00000002, 0x800a0004, 0x00000000, 0x00000000);
-	ufs_dme_command(hba, 0x00000002, 0x800b0004, 0x00000000, 0x00000064);
-	ufs_dme_command(hba, 0x00000002, 0x800a0005, 0x00000000, 0x00000000);
-	ufs_dme_command(hba, 0x00000002, 0x800b0005, 0x00000000, 0x00000064);
+	ufs_dme_command(hba, 0x00000002, 0x80090000, 0x00000000, 0x0000000c);
+	ufs_dme_command(hba, 0x00000002, 0x800a0000, 0x00000000, 0x00000080);
+	ufs_dme_command(hba, 0x00000002, 0x80090001, 0x00000000, 0x0000000c);
+	ufs_dme_command(hba, 0x00000002, 0x800a0001, 0x00000000, 0x00000080);
+	ufs_dme_command(hba, 0x00000002, 0x800a0004, 0x00000000, 0x00000003);
+	ufs_dme_command(hba, 0x00000002, 0x800b0004, 0x00000000, 0x000000ea);
+	ufs_dme_command(hba, 0x00000002, 0x800a0005, 0x00000000, 0x00000003);
+	ufs_dme_command(hba, 0x00000002, 0x800b0005, 0x00000000, 0x000000ea);
 	ufs_dme_command(hba, 0x00000002, 0xd0850000, 0x00000000, 0x00000001);
 
 	writew(0x0001, priv->phy_base + 0x20000);
-- 
2.53.0

