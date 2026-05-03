Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02014CD3423
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 05:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD24D845E9;
	Mon,  4 May 2026 07:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="ocWBfyTa";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="E872bkCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0216484255; Sun,  3 May 2026 21:35:34 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E0783EF9
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 21:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aelin@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1777836926; bh=DEtEsjw/zQHAdedoDZEfjNk
 qiZrqdwkVEZViis0sP5Y=; b=ocWBfyTaxNgEwfh5Lc3nc315sBR7lFWn3lnX9iGv0cIDQ9Xx1o
 urCYA89sNeUrkkfYH+72dwFcHHTBlphOuzgcqyo6GPDbnFBaw8wk6d8il1cRclceIqCkfC9Kged
 syMq9Lc/afrvFjUV+hWtWHHVmIGFC7JKjUHiqGdoMqpHJ3AC+8e6FA3kGHbJ2dQHN/NQLNLgr/p
 /IMZHEp6FmSRN49sqp4yHGUW4Val5WX6lZZ5IAPCeQApTcBTuze5mitO3myZubYDPSHgVuvbZwK
 RrWnoMT+zEdyM8zJCFT0x4Zofa5+LLyiwy9e3RokP6aWjUqACiqlh81cHlQfV7AStMA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1777836926; bh=DEtEsjw/zQHAdedoDZEfjNk
 qiZrqdwkVEZViis0sP5Y=; b=E872bkCf7i2M9MSwUoKwyk0o1FO1UXZGaomCYwT4sxq2A1DJVc
 b6vpz9qnc50YoGGOsVsCTL+nkBcgu+/O35Cg==;
From: Aelin Reidel <aelin@mainlining.org>
Date: Sun, 03 May 2026 21:34:53 +0200
Subject: [PATCH] video: simplefb: Parse memory region from memory-region
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-simplefb-memory-region-prop-v1-1-21828b8cf13a@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrDswjSjqVUoX1v6xA8aECYhFv
 LvB5bd476AMU2QaqoMMm2aNa8HzUdH0G9cZrN9icuJaaaTmrCEt8B8OCNH+bJhLwsliYu9kFDR
 d3041lUMyeN3v++t9nhcqxNL8bQAAAA==
X-Change-ID: 20260503-simplefb-memory-region-prop-f20a0e5896c3
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Aelin Reidel <aelin@mainlining.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777836926; l=1323;
 i=aelin@mainlining.org; s=20260503; h=from:subject:message-id;
 bh=zLnqRuahFlVVBpWBWsHLGdCOUZ7TFBM/fecTU8riVXg=;
 b=tFOUswYGik51Uvyj8SZQGLzFIq2psjju9HX7W0BOOpOlHzJ58K7IdP3XgsjwImwp5q5s+V1+a
 Fp8ij9LMB+7DfMk7zOkhokE6zBGpZz1hfgRuPU8xcT08uxio+LFBmxy
X-Developer-Key: i=aelin@mainlining.org; a=ed25519;
 pk=JdivYHq/vT1Z1DpBeadmJbY/Fi5Ab9P/C35KYCOezfA=
X-Mailman-Approved-At: Mon, 04 May 2026 07:09:21 +0200
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

Linux' simplefb driver allows setting the memory-region property to a
phandle to a node that describes the memory to be used for the
framebuffer. If it is present, it will override the "reg" property.

This adds support for parsing the property and prefers it if present.

Signed-off-by: Aelin Reidel <aelin@mainlining.org>
---
 drivers/video/simplefb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 8d0772d4e51..ca1fc4ee661 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -20,8 +20,14 @@ static int simple_video_probe(struct udevice *dev)
 	fdt_addr_t base;
 	fdt_size_t size;
 	u32 width, height, stride, rot;
+	struct ofnode_phandle_args args;
+
+	ret = dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0, &args);
+	if (ret)
+		base = dev_read_addr_size(dev, &size);
+	else
+		base = ofnode_get_addr_size(args.node, "reg", &size);
 
-	base = dev_read_addr_size(dev, &size);
 	if (base == FDT_ADDR_T_NONE) {
 		debug("%s: Failed to decode memory region\n", __func__);
 		return -EINVAL;

---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
change-id: 20260503-simplefb-memory-region-prop-f20a0e5896c3

Best regards,
-- 
Aelin Reidel <aelin@mainlining.org>

