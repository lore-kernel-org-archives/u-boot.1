Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E275E7D267
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB89386CBC;
	Tue, 26 Sep 2023 10:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F7E886A14; Tue, 26 Sep 2023 10:53:37 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF9386CBC
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp73t1695718405tc5ojz9f
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:53:23 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: 7jw2iSiCazous9I7hHCilrXU3qswQTh7bCn436Iac2UHlHbrlXxfe0sV+ckK4
 DcIZper3+SZTXLBl3vEgCE+E8Ina+cw9sIY5xHQjnadZesO+HPDh2CcYPf/4L2E8dIMDDVA
 bNWmRQdFrjUyg+GPhwFcLJLDl9a3kKqJVci/TeECaPnnpcj7s3kRtEaAHgJUCJLlZZVhThN
 ExzwQb1Q30/uzyNrq0InRl40vs1sgAroxXct3jo+ZipevocEroWi+nx9Uq+jyiqWeIj4ebs
 bC6dUX5sYKuKYVAnR1dxwlBz7+nztRrtlaGHzPOZj1cscpdlVxdhve/ME8O9dVe/hz9pwxY
 rsXWvyWKjAwJ06LJkVVMei1WKaif/5MY81oBbN+
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14645110168689018168
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 09/15] blk: blkmap: Support mapping to device of any block size
Date: Tue, 26 Sep 2023 16:43:39 +0800
Message-Id: <20230926084346.2237483-10-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

At present if a device to map has a block size other than 512,
the blkmap map process just fails. There is no reason why we
can't just use the block size of the mapped device.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/block/blkmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index f6acfa8927..149a4cac3e 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -171,11 +171,11 @@ int blkmap_map_linear(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 
 	bd = dev_get_uclass_plat(bm->blk);
 	lbd = dev_get_uclass_plat(lblk);
-	if (lbd->blksz != bd->blksz)
-		/* We could support block size translation, but we
-		 * don't yet.
-		 */
-		return -EINVAL;
+	if (lbd->blksz != bd->blksz) {
+		/* update to match the mapped device */
+		bd->blksz = lbd->blksz;
+		bd->log2blksz = LOG2(bd->blksz);
+	}
 
 	linear = malloc(sizeof(*linear));
 	if (!linear)
-- 
2.25.1

