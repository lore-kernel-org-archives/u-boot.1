Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C259C44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00AA560909;
	Thu, 23 Jul 2026 00:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4e-U5J6CzHIY; Thu, 23 Jul 2026 00:52:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A78F608D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767955;
	bh=+h/eV4l1O0zNY+nCghDQPHRo1C+bYYQ1rLY5Fs5zjsM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xzvL//PNFyXd0pW+j56dtpUV77an+llvVXSxDwKrWMKI3ygM1XhslMV2TpZnBsErK
	 SpqvloBN7z3izNz1ObUeqdY31ciBhrwC3lHwhrnLiDtwW72Bju3K81MuM7f929k0GJ
	 amBY62Ycn9Wxfexg4eb5SEDuv3wAxK9AM1GRXhObxDPLdVtw4VIp81z/VGoLRU/MQT
	 e3H1nk1wR03C6jYsKRfGM1wiyf6UUqSMmL+8vcbf5lKeem1YHZObyBaNoG3AOqcPnK
	 I6byWPDBd16mw1am/Mvxqc4oeIp0FE/FlruNjLDpLWsB5qCAlQSfYT/lDy9bZMpr7j
	 P83QsAO9oXfhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A78F608D6;
	Thu, 23 Jul 2026 00:52:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C517842A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABB3160602
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PBn5nu5gbw9S for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:43:23 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=prvs=656eedf95=jamie.gibbons@microchip.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7A5026060D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A5026060D
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A5026060D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F25B38493F; Wed, 22 Jul 2026 17:43:21 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC058494B
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:43:19 +0200 (CEST)
X-CSE-ConnectionGUID: Af3y+6bHT5GqYq/4VLukeQ==
X-CSE-MsgGUID: vbi4otc9QT+t6fy5WFinvg==
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="61010814"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 08:43:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 22 Jul 2026 08:43:16 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 08:43:14 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin
 Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH v2 6/6] mailbox: mpfs: add bounded wait for BUSY to clear
 before sending request
Date: Wed, 22 Jul 2026 16:45:49 +0100
Message-ID: <20260722154602.3373184-7-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
References: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784735000; x=1816271000;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tMATa4hURUEp++Lpubmoz8ER8w5YalhrPiTKv6Y/En0=;
 b=FSt6e5huCJq+lz4XtobVQr3RyVjlb9uwjsjyjLm8yahuw9CjxH1QF3QW
 /T0LNOiC6QUUMyOObT/do0AdwOUK1Yoq5qKT7HGpR4gCqx6I1tzFtSv/k
 u3fKx0gEJlCm3dI+k+VyQ9i5yUrtY25abAtqfm6cyRngwIcr4DThalwMy
 mZ4eugtL9ltr2VSE8mzQw60youJqdeVbBxVH3IRg4M02Wj+DCRwdxCQGS
 TJJcbE5Gy4ZjQy8pV64/ZbST85nazCRmTr+aofEXoP6aiTL2hGbiufFPs
 PQ2YPUSYJnUvpRcMLc6837uonjNN5O9VuY9L5+/tJ8BWNeOSoTrJ4YIK8
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=FSt6e5hu
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=656eedf95=Jamie.Gibbons@microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.b="FSt6e5hu"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The MPFS mailbox driver currently checks the BUSY bit at the start of
mpfs_mbox_send() and immediately returns -EBUSY if the controller is
busy.

On MPFS, BUSY may be transiently asserted during early boot even though
no other U-Boot service is actively executing. In Linux, returning
-EBUSY here is retryable via the mailbox framework and scheduler, but in
U-Boot this results in a hard failure.

Replace the immediate BUSY check with a bounded wait using
regmap_read_poll_timeout(), waiting for the controller to become idle
before issuing a new request. This preserves the intent of the BUSY
check while avoiding spurious early-boot failures in U-Boot’s
synchronous, polled execution model.

The timeout is conservative and based on observed MPFS behaviour, where
BUSY clears within a few milliseconds.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mailbox/mpfs-mbox.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mpfs-mbox.c b/drivers/mailbox/mpfs-mbox.c
index 165d9d89630..8b7a2719330 100644
--- a/drivers/mailbox/mpfs-mbox.c
+++ b/drivers/mailbox/mpfs-mbox.c
@@ -65,8 +65,11 @@ static int mpfs_mbox_send(struct mbox_chan *chan, const void *data)
 
 	u32 *word_buf = (u32 *)msg->cmd_data;
 
-	if (mpfs_mbox_busy(chan))
-		return -EBUSY;
+	ret = regmap_read_poll_timeout(mbox->control_scb, SERVICES_SR_OFFSET,
+				       value, !(value & SERVICE_SR_BUSY_MASK),
+				       1, 20);
+	if (ret)
+		return ret;
 
 	for (idx = 0; idx < (msg->cmd_data_size / BYTES_4); idx++)
 		writel(word_buf[idx], mbox->mbox_base + msg->mbox_offset + idx * BYTES_4);
-- 
2.43.0

