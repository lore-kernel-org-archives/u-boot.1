Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D65EC25B77
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B0E8850F;
	Fri, 17 May 2024 14:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715950251;
	bh=ZqPofwONkBNpGKn7XJpT436YApiV7ob0gXGuiZqEESM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D/Lk7w5nH5OTaPoOgHpfryggD08tdGRHnpnRfmoJkc8TFRgEutkEJB/2b5sHc+Vb+
	 HsiaPd2ICF5/2enaWFKdiQ4WBIXR4N064P709mT9KjTPeP/dpWxRb8+18jkqJSm/e1
	 rvYjb359d2sMEp2o2OJtpapooOw0J99GT6OmwA/HnZc7VP1b1GHyyqt//SqL+loTLh
	 pkXb4l21uoCcqS8iBGNSPzBlswL39KfsaIr64baTE0loaY9O8e54S17W51n+R63KZh
	 eitoHQS33cuOLeAV/YMerEQsT6i9NSuX7PBOlrZKEjORYz9cBl0Jtrt7OODMQ0DH18
	 HOS44rwdXzMjA==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 01FCE882D9;
 Fri, 17 May 2024 11:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715937522;
 bh=ZqPofwONkBNpGKn7XJpT436YApiV7ob0gXGuiZqEESM=;
 h=From:To:Cc:Subject:Date:From;
 b=Xn36bWALSnZ3Ip5Y2PRqANgYS630VB+wvm/r28BH6sEyqA1IsdKBBR45kBhAnD1XM
 RAXDjpWu6v4TtKl4xky39Hb75b8STTCTLT2WYsf8yUvQ2WCuQG6wPxyeKYxyuAnrvQ
 4FOXxNqTzCTop5NcbKLL7i9YEnI92ed0azH+wUHUwS+7RncdI/Y8npD42vdz6Wt/lY
 sgldX14Ov2L9lN4HP4A5UL0k4vbrOFNfTtHys2iH7IRdCOe/iGPjbMzhNckO9NjTBF
 Fzi1WCslsTiyewVvRIrCN3LRBSjHVmBUe+vUDN/TE+6qgAU3rcO14u2i2+YbVFt7lI
 xOZ5m1bhm1Xnw==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: marex@denx.de, trini@konsulko.com, patrice.chotard@foss.st.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, michal.simek@amd.com, bmeng.cn@gmail.com,
 ryder.lee@mediatek.com, weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 GSS_MTK_Uboot_upstream@mediatek.com, iwamatsu@nigauri.org, lukma@denx.de,
 mkorpershoek@baylibre.com, eddie.cai.linux@gmail.com, neal@gompa.dev,
 pro@denx.de, j@jannau.net, sjg@chromium.org, teik.heng.chong@intel.com,
 jonas@kwiboo.se, nm@ti.com, seanga2@gmail.com, festevam@gmail.com,
 tharvey@gateworks.com, othacehe@gnu.org, fabrice.gasnier@foss.st.com,
 xdrudis@tinet.cat, marcan@marcan.st, richard.habeeb@gmail.com,
 artur@conclusive.pl, simon@holesch.de, clamor95@gmail.com, ion@agorria.com,
 miquel.raynal@bootlin.com
Subject: [PATCH 1/1] usb: Assimilate usb_get_descriptor() to linux
Date: Fri, 17 May 2024 11:18:20 +0200
Message-Id: <20240517091820.3992-1-pro@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 May 2024 14:50:41 +0200
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

Before this commit, usb_get_descriptor() failed for some flakey USB
devices. We hereby adopt the more robust linux implementation [1].

Signed-off-by: Philip Oberfichtner <pro@denx.de>

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/usb/core/message.c?h=v6.9#n781
---
 common/usb.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/common/usb.c b/common/usb.c
index 84b10f5c7d..f5b21c883f 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -214,8 +214,9 @@ int usb_int_msg(struct usb_device *dev, unsigned long pipe,
  * clear keyboards LEDs). For data transfers, (storage transfers) we don't
  * allow control messages with 0 timeout, by previousely resetting the flag
  * asynch_allowed (usb_disable_asynch(1)).
- * returns the transferred length if OK or -1 if error. The transferred length
- * and the current status are stored in the dev->act_len and dev->status.
+ * returns the transferred length if OK, otherwise a negative error code. The
+ * transferred length and the current status are stored in the dev->act_len and
+ * dev->status.
  */
 int usb_control_msg(struct usb_device *dev, unsigned int pipe,
 			unsigned char request, unsigned char requesttype,
@@ -257,11 +258,14 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe,
 			break;
 		mdelay(1);
 	}
+
+	if (timeout == 0)
+		return -ETIMEDOUT;
+
 	if (dev->status)
 		return -1;
 
 	return dev->act_len;
-
 }
 
 /*-------------------------------------------------------------------
@@ -562,10 +566,29 @@ int usb_clear_halt(struct usb_device *dev, int pipe)
 static int usb_get_descriptor(struct usb_device *dev, unsigned char type,
 			unsigned char index, void *buf, int size)
 {
-	return usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-			       USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
-			       (type << 8) + index, 0, buf, size,
-			       USB_CNTL_TIMEOUT);
+	int i;
+	int result;
+
+	if (size <= 0)		/* No point in asking for no data */
+		return -EINVAL;
+
+	memset(buf, 0, size);	/* Make sure we parse really received data */
+
+	for (i = 0; i < 3; ++i) {
+		/* retry on length 0 or error; some devices are flakey */
+		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
+					 USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
+					 (type << 8) + index, 0, buf, size,
+					 USB_CNTL_TIMEOUT);
+		if (result <= 0 && result != -ETIMEDOUT)
+			continue;
+		if (result > 1 && ((u8 *)buf)[1] != type) {
+			result = -ENODATA;
+			continue;
+		}
+		break;
+	}
+	return result;
 }
 
 /**********************************************************************
-- 
2.39.2

