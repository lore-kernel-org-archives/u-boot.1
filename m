Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABB7C44536
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 455D040A3B;
	Thu, 23 Jul 2026 00:52:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ldKRLZBF1PjS; Thu, 23 Jul 2026 00:52:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6509940A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767952;
	bh=YE0VtKOEz4qtJ0gyIPsEO7Wi2Lyn1ByfjgEUetBCbLA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e0taOyA+WPAWDxV71a7iokz3F9bgEz9/9wgbq5GQ1zCdXdR2NOJF5FVlgRjTdVAnI
	 D3OAl7gu/B+sjQadOtBBk32fK8qJ/QlKJQylJ9G8eijk7e4LWpWrr2DTZ2nxaWQpwj
	 qvz1abVfLiL1EKksTqMpWPk2xKjjdzVdmsHLrJwmuIc6v7z6EYDn2sECx66mlnARrv
	 AVWhMAjpM6Z39+U5DMvZCUmw/qMJPohXBnA1LhDSHVJ0sT0ZNVMXv6VsJE5tGomO9v
	 NBAxgIHiFP6eYtMc57FkbwJQ6Yd3XhZd4TLQ3K0YiidUFWJZi++0TjWRBhbDIlK9P6
	 KGFaf084Ag/gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6509940A47;
	Thu, 23 Jul 2026 00:52:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28488390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E9E84077F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TuJeCMIv83DM for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:43:20 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=prvs=656eedf95=jamie.gibbons@microchip.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 231EE40783
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 231EE40783
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 231EE40783
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:43:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8754D8495B; Wed, 22 Jul 2026 17:43:18 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E31A8493F
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:43:15 +0200 (CEST)
X-CSE-ConnectionGUID: WGEmU6OJQCa4d0JgQcyGkQ==
X-CSE-MsgGUID: sDF3xB+BSOGacDABSini9g==
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="61326546"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Jul 2026 08:43:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Jul 2026 08:43:13 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 08:43:11 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin
 Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH v2 5/6] mailbox: mpfs-mbox: replace unbounded BUSY polling
 with bounded waits
Date: Wed, 22 Jul 2026 16:45:48 +0100
Message-ID: <20260722154602.3373184-6-jamie.gibbons@microchip.com>
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
 t=1784734996; x=1816270996;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bz1TmnprPjCf4YoZ/+hfgVjAOhGX+1umITvYUwIx8GU=;
 b=UuUPfEJsZ977YiCTgjbm9jpdf4yuUyUNE+Jk5pciePK4bNqJ/Q1m+dj5
 xz58f7xL/RfpZNUIlD77BVvl8RoJvLeLrXYFn6/ZHFjnfOMpj03WpiBkH
 w6WXYZljAuu7LReGchIw55ZcBklvDT0p7I1zc3/knGM09gaCECVKAIyyy
 +UC6bnIdbbAGBuzhPXYtjPXz0sB9oIcKcStSmP8JC/nTKTLONuWdLr1DZ
 J3HUcijnuyyxcRRnZhTaP0yeIN0xbSBOsc0QgjTcHChD+jtAjdKtlckoK
 eh7cwbS/C36jsGR1aynZaswa/0HzVXBrKV93VQj3kjp/52z7QmeQ3PTlF
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=UuUPfEJs
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=656eedf95=Jamie.Gibbons@microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.b="UuUPfEJs"; 
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

The MPFS mailbox driver used unbounded polling loops and treated the
BUSY bit as a fatal condition in several paths. On MPFS, BUSY may be
transiently reasserted even after response data is written, which is
observable in U-Boot’s synchronous, polled execution model.

Replace the unbounded loops with a bounded
regmap_read_poll_timeout()-based helper that waits for the controller to
become idle.

This preserves existing behaviour while preventing infinite stalls
and avoiding spurious failures during early boot.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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

