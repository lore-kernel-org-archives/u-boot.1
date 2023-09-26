Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88398E7D268
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E357586C10;
	Tue, 26 Sep 2023 10:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 386BB86D55; Tue, 26 Sep 2023 10:51:30 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6D9E86A14
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp69t1695718277tqmarv2u
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:51:15 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: CR3LFp2JE4lexoh8Hm0IIKb+8xWMGuZQR/zrpj+nqTdn4DxtA3VsX6bvtIftL
 lS3Rtp7uyLqlAu4OtlfETnzdNHfU1nxgMi5YqktMyt28DbIapkuEevGJuARZHT5e27BYW/z
 Ox0GJFb0kYZkWbRDlmo9GGckhQEBGd/+3SZXvv12xAcRKo8Dggd+pJeX+QNTElORBZeCmb4
 fb+4XeClqqrEkmgaz6BNV4BZ26ePgvd+BGzL/ICkNyHTrP2dGi66T9AgNoW0WAh0+yfz2gx
 u6iP0aTzLhJK+lO4kjymPswaFcQDFd3eKrPkmidSETgGqJ66V9sHYoPX9rENKjIp4AvMX9m
 cdflyHKn7eAuxqn5G3MprdqVV6bA61820QKuLri
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5866926699007388632
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 07/15] blk: blkmap: Make bind/unbind routines static
Date: Tue, 26 Sep 2023 16:43:37 +0800
Message-Id: <20230926084346.2237483-8-bmeng@tinylab.org>
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

These 2 are only used in drivers/block/blkmap.c.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/block/blkmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index 409aa46de2..f6acfa8927 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -383,7 +383,7 @@ U_BOOT_DRIVER(blkmap_blk) = {
 	.ops		= &blkmap_blk_ops,
 };
 
-int blkmap_dev_bind(struct udevice *dev)
+static int blkmap_dev_bind(struct udevice *dev)
 {
 	struct blkmap *bm = dev_get_plat(dev);
 	struct blk_desc *bd;
@@ -410,7 +410,7 @@ int blkmap_dev_bind(struct udevice *dev)
 	return 0;
 }
 
-int blkmap_dev_unbind(struct udevice *dev)
+static int blkmap_dev_unbind(struct udevice *dev)
 {
 	struct blkmap *bm = dev_get_plat(dev);
 	struct blkmap_slice *bms, *tmp;
-- 
2.25.1

