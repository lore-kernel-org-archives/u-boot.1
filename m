Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63245E7D263
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0DA86B95;
	Tue, 26 Sep 2023 10:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7DB86BB2; Tue, 26 Sep 2023 10:48:14 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC1686A14
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp65t1695718085ts7r3jbz
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:48:04 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: eSZ1CZgv+JC47OGWs9+wNWhTzFhoZ/3dQaDu6gJqZQk4/fgz1TtZpCZpMSBEa
 TpqRFEXzGOM5WKmq7SmXCBUbs+dLE9iQqVWLq8hpjJW4CBmAKngidOxloBUs2mffbB2Z1ja
 /7Hd0Zb3+hkbPKcaWJRXjNlR/CD1h4gNXQq4mnYsCsQ8W1nXy05IxIXYU8pCx5y2/f5zLAs
 Sl3re1wzEFeEYc4hJFkArhTG2qTWNOsvlDjPxYrN7bNDf6OIXLMe/fbO/vmsCuXIuJVCh0g
 7JakvD9dU2TnMDzpKMyMpioDpnJh+i2vGpJo2NtSE9rE5y75GfRw4nebeG827hHtoKLnEhk
 cq+wbjzPEXmONhGEiYzOMB8hEtodSVk3VK6B2Gb
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3845401212366877387
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 04/15] blk: host_dev: Make host_sb_detach_file() and
 host_sb_ops static
Date: Tue, 26 Sep 2023 16:43:34 +0800
Message-Id: <20230926084346.2237483-5-bmeng@tinylab.org>
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

They are only used in drivers/block/host_dev.c.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/block/host_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/host_dev.c b/drivers/block/host_dev.c
index 31c7814054..0b43f80a86 100644
--- a/drivers/block/host_dev.c
+++ b/drivers/block/host_dev.c
@@ -73,7 +73,7 @@ err_fname:
 	return ret;
 }
 
-int host_sb_detach_file(struct udevice *dev)
+static int host_sb_detach_file(struct udevice *dev)
 {
 	struct host_sb_plat *plat = dev_get_plat(dev);
 	int ret;
@@ -123,7 +123,7 @@ static int host_sb_bind(struct udevice *dev)
 	return 0;
 }
 
-struct host_ops host_sb_ops = {
+static struct host_ops host_sb_ops = {
 	.attach_file	= host_sb_attach_file,
 	.detach_file	= host_sb_detach_file,
 };
-- 
2.25.1

