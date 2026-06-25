Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788D2CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5591584A4B;
	Thu, 25 Jun 2026 14:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="o7a5/S9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DBAB848F0; Thu, 25 Jun 2026 14:20:19 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9987D846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=629d8e15b=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782390017; x=1813926017;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nagx4IYWhirJx4pc4YqwU0WfQVHvtNyyYMBMZRUTNVo=;
 b=o7a5/S9x0IEM1CZsq6Nv17qpQ18YlwHkAy9QO1sHwsNgeIvatfrjW04R
 YL0Z66ZFS6qZVYXSS0i74gK8HEQtGh1IPHLiMX2Z/U9ZpdoEC4ZNjeDbp
 09f3loG0kYnb3GVgGANkYiIEnOi8Ea/kRFev2DKp0Ssja+YSDrizLqQZR
 RA3KBF/pnsuu5fAmBWiIvNtivitnaMrHJPZuSRMZ/TtnttxOadVKsV4up
 JkLBLh3CMjMqdWwmYQ5ibwBE6lEkk2HztJTJPYZcxvN7ARtcBkM7K86JO
 yd6hGpqLFc8DBvhT62vP09eDUN31cuBa8/eaf6YuwHHX8AL07x4IbvRqa A==;
X-CSE-ConnectionGUID: WR1oC7OASlGMjaBTVrC/6w==
X-CSE-MsgGUID: GILKlbMuR+a46bZsKfE1yw==
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="291054918"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Jun 2026 05:20:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 25 Jun 2026 05:20:14 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 25 Jun 2026 05:20:11 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, <jamie.gibbons@microchip.com>
Subject: [PATCH 7/8] mailbox: mpfs: add bounded wait for BUSY to clear before
 sending request
Date: Thu, 25 Jun 2026 13:23:24 +0100
Message-ID: <20260625122325.834568-8-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625122325.834568-1-jamie.gibbons@microchip.com>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

