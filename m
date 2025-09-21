Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FB0CAC59A
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 22:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5815083390;
	Mon, 22 Sep 2025 00:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="K/1R04uc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OEcb+ap+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5E3833D0; Mon, 22 Sep 2025 00:36:02 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B34983211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 00:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cVLgM1bnBz9srT;
 Mon, 22 Sep 2025 00:35:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758494159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TsDzlAruR+k4gL0K9zGH7X42GpfqpEOOkzd1J4o3h80=;
 b=K/1R04ucP9R/Ruh+qgmtzicbI8SZ3E0sKF8H8i4+Agvysjw6+dawH1HhICbXMuGYfSGbnH
 lksJ1+H5KluLGnDKK7Fs+7xbct6MqibfNGNxiON76+QPEYSli65RMulU/t1kTcqm6CklaX
 r7KRDhmIzSLBvhG9GlIM+M+E+p1kX+RQcuTV20Cdp2KiTeiShpcNSnd3Nq/4I5SdJc1rCs
 Am30BrdY2i2Y14NDz7trNnu3ZMG+jZuHyjSmjnP+LcBffb2GQZRrmayh0joAqynVyRkgba
 85jBC3gSnRneJOb4+iy59fB8L+tLRzV6z5pP5zhAbZrJnAjZmhXkVLdokDfbYQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=OEcb+ap+;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758494157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TsDzlAruR+k4gL0K9zGH7X42GpfqpEOOkzd1J4o3h80=;
 b=OEcb+ap+xpq1VMND/Pgpep87Sk2ob5onuJtfdipjWSSJKjR5X5ysIfgx3xp3+R8TiO80/5
 8Xh3wwyElXkVzoDLQ+xsuJErfIkG7uTBa/dNDed96DcBd8oPbY5cXGKEqU1HgavkMvH+V0
 eg5nooChIyY9O079byupPuI2aqLOlKL4nCbl5Zht5t7N5p62mwF2QYENmHtPSDfhZVdF4n
 +0J8+ksPHFuhfFU9IDH5dnjn7vgv5WV5LQZfAtKp1QBs+q/jJj96hBd0QwK8vSL0BSXScD
 Z9N3CM2RhFGgZ+fAajMTjN0NbeUW2qvxXL/a+g/1ftMmUrGq6aPjk0g5SU+2kw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] misc: fs_loader: Use buffer pointer in
 request_firmware_into_buf_via_script()
Date: Mon, 22 Sep 2025 00:35:18 +0200
Message-ID: <20250921223537.108188-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6ej75ugp5s57asum7pkp74b7nwkaxtw1
X-MBO-RS-ID: 9a16e14b1696d16d04c
X-Rspamd-Queue-Id: 4cVLgM1bnBz9srT
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

Use plain buffer pointer in request_firmware_into_buf_via_script()
instead of a pointer to pointer. The later is not necessary as the
request_firmware_into_buf_via_script() does not modify the buffer
pointer. Update the mediatek driver to match.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de
---
 drivers/misc/fs_loader.c             | 4 ++--
 drivers/net/phy/mediatek/mtk-2p5ge.c | 6 +++---
 include/fs_loader.h                  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 32aff35835b..d641647e040 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -228,7 +228,7 @@ int request_firmware_into_buf(struct udevice *dev,
 	return ret;
 }
 
-int request_firmware_into_buf_via_script(void **buf, size_t max_size,
+int request_firmware_into_buf_via_script(void *buf, size_t max_size,
 					 const char *script_name,
 					 size_t *retsize)
 {
@@ -270,7 +270,7 @@ int request_firmware_into_buf_via_script(void **buf, size_t max_size,
 	if (retsize)
 		*retsize = size;
 
-	memcpy(*buf, (void *)addr, size);
+	memcpy(buf, (void *)addr, size);
 
 	return 0;
 }
diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c b/drivers/net/phy/mediatek/mtk-2p5ge.c
index ab5007389a9..0e704bdb04d 100644
--- a/drivers/net/phy/mediatek/mtk-2p5ge.c
+++ b/drivers/net/phy/mediatek/mtk-2p5ge.c
@@ -249,7 +249,7 @@ int __weak mt7987_i2p5ge_get_fw(void **fw, size_t *fwsize,
 		return -ENOMEM;
 
 	ret = request_firmware_into_buf_via_script(
-		&pmb, MT7987_2P5GE_PMB_FW_SIZE,
+		pmb, MT7987_2P5GE_PMB_FW_SIZE,
 		"mt7987_i2p5ge_load_pmb_firmware", fwsize);
 	if (ret) {
 		free(pmb);
@@ -263,7 +263,7 @@ int __weak mt7987_i2p5ge_get_fw(void **fw, size_t *fwsize,
 	}
 
 	ret = request_firmware_into_buf_via_script(
-		&dsp, MT7987_2P5GE_DSPBITTB_SIZE,
+		dsp, MT7987_2P5GE_DSPBITTB_SIZE,
 		"mt7987_i2p5ge_load_dspbit_firmware", dspfwsize);
 	if (ret) {
 		free(pmb);
@@ -476,7 +476,7 @@ int __weak mt7988_i2p5ge_get_fw(void **fw, size_t *size)
 		return -ENOMEM;
 
 	ret = request_firmware_into_buf_via_script(
-		&pmb, MT7988_2P5GE_PMB_FW_SIZE,
+		pmb, MT7988_2P5GE_PMB_FW_SIZE,
 		"mt7988_i2p5ge_load_pmb_firmware", size);
 	if (ret) {
 		free(pmb);
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 1cf6d6dd05f..3afd9e62b4a 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -87,7 +87,7 @@ int get_fs_loader(struct udevice **dev);
  *   env set fw_addr ${loadaddr} && env set fw_size ${filesize}
  * Return: 0 on success, negative value on error.
  */
-int request_firmware_into_buf_via_script(void **buf, size_t max_size,
+int request_firmware_into_buf_via_script(void *buf, size_t max_size,
 					 const char *script_name,
 					 size_t *retsize);
 #endif
-- 
2.51.0

