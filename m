Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B47CD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B972846A0;
	Sun, 10 May 2026 19:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vCLhT9re";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IvBIZvY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1FD846D0; Sun, 10 May 2026 19:16:14 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC7184694
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gD8dk5MDzz9tYM;
 Sun, 10 May 2026 19:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/SptzhT36R4mGM6CieAfB1atl3ElQ98/LHW9hd5fr1c=;
 b=vCLhT9re5sDkXkP/VhQQ1V1TS0s1MZ+TB6jeZhq0o/bXwoOerIM3/p5DIxLxSbPG+qhX54
 zJYV7xA8MN75emcxlxwZLlVQShn3Yxph8cvfn4biIlKkv86i/734nyDp4bJGXIxES0wOsl
 Uc4X5SBalj24aDTIkWPFPqbf5GDFrVchpBypmPKjiBwQtRFIVJOka4aUV6yVoNHYKYQP5d
 CQkHIHVOJGdSpkv4n4gPPBkpYUWQjeKxwQEDoCqwciBGyjpObemn6AdWxPIoSl/LFPbbYw
 8w84NS7n2UVmve2oX39zmOif9goTh0fPTKjUZCustZE6EQ3wlxEggxIQBl5EdA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/SptzhT36R4mGM6CieAfB1atl3ElQ98/LHW9hd5fr1c=;
 b=IvBIZvY6RdWdJuRdp8kptSFtxMmz/UN5hvgn1tTN1QOjFif8AuN7JnsPLFic5X7wQFK0Ip
 H9v2qNDozPj4vAQDgm375GhJ6mChSwozndSI0eaMTguyHQql+wKyrPs0lkVNg6GGe0PFyr
 MekPfG3boDZnXFJUKfAeWFsgw9JNdw+7OAyjloIqmnBbQWicuqebBnKptBUlRnM6VihIlk
 WhZzy0zU/Oq18J67wnZVuXPPVmnxcnoL6BPnDCShRENTSRfhGkBEiwu1rVPYvUrpq2shPs
 D91cQaMZJ3ptGtuKKZ2Kp7teVsFf5hvDQg5KXmj2/xmF+CKteJufqyW+J9KZ1w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] scsi: sandbox: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:15:52 +0200
Message-ID: <20260510171604.56788-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cf9aqcm6nfu1o7pacnc3zyqrrmquihpy
X-MBO-RS-ID: 28b209241463097d2f8
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/scsi/sandbox_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sandbox_scsi.c b/drivers/scsi/sandbox_scsi.c
index 544a0247083..5f0b01d86d5 100644
--- a/drivers/scsi/sandbox_scsi.c
+++ b/drivers/scsi/sandbox_scsi.c
@@ -128,7 +128,7 @@ static int sandbox_scsi_remove(struct udevice *dev)
 	return 0;
 }
 
-struct scsi_ops sandbox_scsi_ops = {
+static const struct scsi_ops sandbox_scsi_ops = {
 	.exec		= sandbox_scsi_exec,
 	.bus_reset	= sandbox_scsi_bus_reset,
 };
-- 
2.53.0

