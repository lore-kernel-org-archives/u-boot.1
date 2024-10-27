Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DE6D13569
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 15:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B400289068;
	Sun, 27 Oct 2024 16:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=khoahoang.com header.i=admin@khoahoang.com header.b="gwZ824O3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE6CF88F01; Sun, 27 Oct 2024 06:13:49 +0100 (CET)
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com
 [136.143.188.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD94688CEA
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 06:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=admin@khoahoang.com
ARC-Seal: i=1; a=rsa-sha256; t=1730005988; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=htel0PhYiD11V0gF0dmtSTwWxZMC/0jz0gt+B7xHwPh3pZ630BULUIoqSIhxhpQXXJupGP2qaz6p5lHtmxR8LhwDiZLopqQBnrv4IvwwXRbUtGWD6MU4RMHESp03oxjwpdUBCJUJM9SCcpeHk4R9wy2oHkIy4lCWZvGShoHJ9Y8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730005988;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lp+tieZOtyHwn6A9w8RRGCdba9AWk54JJD8+x2K5o/o=; 
 b=MRJ4QN/1XLgZ5uvDYBD+KOL1CbWtpa19Dnu6dsfi5Wd1qGI15kZ/YK6s9HEkC/zFyGI5XXuRzX/GWm6T79niGw8jEWnofL14wrWlH9t1xwuh6vmXo2iZ68ufl3S+D0COO/yL6LADgjc5v0pH1HXtCBR+rqlS/YP5rH0bzhqkSmE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=khoahoang.com;
 spf=pass  smtp.mailfrom=admin@khoahoang.com;
 dmarc=pass header.from=<admin@khoahoang.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730005988; 
 s=zoho; d=khoahoang.com; i=admin@khoahoang.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
 bh=lp+tieZOtyHwn6A9w8RRGCdba9AWk54JJD8+x2K5o/o=;
 b=gwZ824O3zHm2w3aX9CDhP/wcUVWAHKo3J85NY8yzJUZ0/p3wfe3nv9g5oOIrbAG/
 iOO0hQtg3XgiX2aDs7FIIOoeCwntniCW+p7QC1OKa0QKln5MYjQCf5ilQ9lm4aPzLRN
 OBVi7Jlo0sFvrwWufvlVaNcxV/Tpne4+iZAT5Jeo=
Received: by mx.zohomail.com with SMTPS id 1730005986123162.40895580493827;
 Sat, 26 Oct 2024 22:13:06 -0700 (PDT)
From: Khoa Hoang <admin@khoahoang.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Khoa Hoang <admin@khoahoang.com>
Subject: [PATCH 2/2] eth: asix88179: Fix drop of large fragmented packets
Date: Sat, 26 Oct 2024 22:12:50 -0700
Message-Id: <20241027051250.35627-3-admin@khoahoang.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20241027051250.35627-1-admin@khoahoang.com>
References: <20241027051250.35627-1-admin@khoahoang.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Oct 2024 16:06:22 +0100
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

When receiving large fragmented packets, the ASIX 88179A can drop
packets due to an insufficient URB buffer size. This change adjusts
the URB buffer size to match the configuration used in the Linux
kernel, resolving packet drop issues observed when performing TFTP
with a 16KB block size.

Signed-off-by: Khoa Hoang <admin@khoahoang.com>
---
 drivers/usb/eth/asix88179.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index a856aa2d..647a85a5 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -192,10 +192,10 @@
 static const struct {
 	unsigned char ctrl, timer_l, timer_h, size, ifg;
 } AX88179_BULKIN_SIZE[] =	{
-	{7, 0x4f, 0,	0x02, 0xff},
-	{7, 0x20, 3,	0x03, 0xff},
-	{7, 0xae, 7,	0x04, 0xff},
-	{7, 0xcc, 0x4c, 0x04, 8},
+	{7, 0x4f, 0,	0x12, 0xff},
+	{7, 0x20, 3,	0x16, 0xff},
+	{7, 0xae, 7,	0x18, 0xff},
+	{7, 0xcc, 0x4c, 0x18, 8},
 };
 
 /* driver private */
@@ -311,7 +311,7 @@ static int asix_basic_reset(struct ueth_data *dev,
 	memcpy(tmp, &AX88179_BULKIN_SIZE[0], 5);
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
 
-	dev_priv->rx_urb_size = 128 * 20;
+	dev_priv->rx_urb_size = 1024 * 20;
 
 	/* Water Level configuration */
 	*tmp = 0x34;
-- 

