Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B74E7D266
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59E8486BB2;
	Tue, 26 Sep 2023 10:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D5786A14; Tue, 26 Sep 2023 10:49:24 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B2B86C10
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp76t1695718149tuaouwd3
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:49:08 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: y/s16VEPkJqg/hwJL/f/Z6UYgnDel3H+mhO7KGo9N/pC8+SAqM7b4vT2k9xVI
 WZI+JiyrRfbLjbeCUfRVJqTczCuLwwzyfNenYpQ6Zhir1lutftCtpxworPRnJP4X7csfksl
 Kg1HAB4wzF4l1LTGbLfBcVWCpLTCJMPc9MtLeNaK24PiC8y8SQ45p2zBJBNeOZIVEbdzFQV
 9zJCl9ebZq0AEmoLeYvLbgheI1bUlNCkVOGMn0QqJOpqEX+jytvoFrkn4VLP3t950D+0g74
 ZVT4cJlKwttZOLQLmstA4VH/9FWbmMU58vdXoFYep1TGNxhLO8QnF5MzbHsW6ci5re8jS0t
 2Xy7NS3wb1RQgghoDoG1PLDaM1CKOpagaGpK5tt
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13276575018525149291
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 05/15] blk: host_dev: Sanity check on the size of host backing
 file
Date: Tue, 26 Sep 2023 16:43:35 +0800
Message-Id: <20230926084346.2237483-6-bmeng@tinylab.org>
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

Since we are emulating a block device, its size should be multiple
of the configured block size.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/block/host_dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/host_dev.c b/drivers/block/host_dev.c
index 0b43f80a86..30c7415793 100644
--- a/drivers/block/host_dev.c
+++ b/drivers/block/host_dev.c
@@ -58,6 +58,11 @@ static int host_sb_attach_file(struct udevice *dev, const char *filename)
 
 	size = os_filesize(fd);
 	desc = dev_get_uclass_plat(blk);
+	if (size % desc->blksz) {
+		printf("The size of host backing file '%s' is not multiple of "
+		       "the device block size\n", filename);
+		goto err_fname;
+	}
 	desc->lba = size / desc->blksz;
 
 	/* write this in last, when nothing can go wrong */
-- 
2.25.1

