Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B70CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1466484A12;
	Thu, 25 Jun 2026 14:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="p8EUTD4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B161847C8; Thu, 25 Jun 2026 14:20:15 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904D884704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=629d8e15b=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782390012; x=1813926012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ldod3p1Ey7hS3wCljhmPCK/rb06TNa0DBuzoatbmIZw=;
 b=p8EUTD4/h5+6T1kmBuVLXQh7Ve0C04d7VjTdFJnCCUiL+8LF6nPrrA/1
 28RQ2gAvVlNd068B0BYAI4QZiRh9W7B5OXe5NG/Q4bDxi0zXpbjUvXiHf
 goTEhz6rTQdtpT7q/VI01JOjJuqA6upMVLIY49r9cX70M/w+Gv6cgpUcv
 edz3agoOWtmskcGCDV//zJiT0yY+eKbBxv0hZ1G6NACq5oPt+26BVQrgL
 ocdPH58c/p776TF7rNmhbVkIkVlsPiKLfbvRQbJTAsxoRnmkpRc9CuD61
 10J7h5dbAv+V2caH5RktW7pTNTpCN6kBMqG9xXaTO0oV+IHBzYW35mzMm A==;
X-CSE-ConnectionGUID: Fk/Se69eSWS0D+Ou8yyZ6w==
X-CSE-MsgGUID: haLFfdM4T2i9rv1fKheiuQ==
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="68857399"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 05:20:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Thu, 25 Jun 2026 05:20:11 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 25 Jun 2026 05:20:08 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, <jamie.gibbons@microchip.com>
Subject: [PATCH 6/8] mailbox: mpfs-mbox: replace unbounded BUSY polling with
 bounded waits
Date: Thu, 25 Jun 2026 13:23:23 +0100
Message-ID: <20260625122325.834568-7-jamie.gibbons@microchip.com>
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

The MPFS mailbox driver used unbounded polling loops and treated the
BUSY bit as a fatal condition in several paths. On MPFS, BUSY may be
transiently reasserted even after response data is written, which is
observable in U-Boot’s synchronous, polled execution model.

Replace the unbounded loops with a bounded
regmap_read_poll_timeout()-based helper that waits for the controller to
become idle.

This preserves existing behaviour while preventing infinite stalls.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 drivers/mailbox/mpfs-mbox.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mpfs-mbox.c b/drivers/mailbox/mpfs-mbox.c
index b1ce377525e..165d9d89630 100644
--- a/drivers/mailbox/mpfs-mbox.c
+++ b/drivers/mailbox/mpfs-mbox.c
@@ -18,6 +18,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/iopoll.h>
 #include <log.h>
 #include <mailbox-uclass.h>
 #include <mpfs-mailbox.h>
@@ -60,6 +61,7 @@ static int mpfs_mbox_send(struct mbox_chan *chan, const void *data)
 	u32 mailbox_val, cmd_shifted, value;
 	u8 *byte_buf;
 	u8 idx, byte_idx, byte_offset;
+	int ret;
 
 	u32 *word_buf = (u32 *)msg->cmd_data;
 
@@ -86,13 +88,19 @@ static int mpfs_mbox_send(struct mbox_chan *chan, const void *data)
 
 	regmap_write(mbox->control_scb, SERVICES_CR_OFFSET, cmd_shifted);
 
-	do {
-		regmap_read(mbox->control_scb, SERVICES_CR_OFFSET, &value);
-	} while (SERVICE_CR_REQ_MASK == (value & SERVICE_CR_REQ_MASK));
+	ret = regmap_read_poll_timeout(mbox->control_scb, SERVICES_CR_OFFSET,
+				       value, !(value & SERVICE_CR_REQ_MASK),
+				       1, /* poll every 1 µs */
+				       20); /* timeout 20 ms */
+	if (ret)
+		return ret;
 
-	do {
-		regmap_read(mbox->control_scb, SERVICES_SR_OFFSET, &value);
-	} while (SERVICE_SR_BUSY_MASK == (value & SERVICE_SR_BUSY_MASK));
+	ret = regmap_read_poll_timeout(mbox->control_scb, SERVICES_SR_OFFSET,
+				       value, !(value & SERVICE_SR_BUSY_MASK),
+				       1,
+				       20);
+	if (ret)
+		return ret;
 
 	msg->response->resp_status = (value >> SERVICE_SR_STATUS_SHIFT);
 	if (msg->response->resp_status)
-- 
2.43.0

