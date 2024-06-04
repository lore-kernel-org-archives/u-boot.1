Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCF1C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 13:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2558388528;
	Tue,  4 Jun 2024 15:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717507131;
	bh=3sCxcGCLHWAhNppPT34fsEBSg6fNAuh16MnBYl9+5/0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0UOIr5vVUn5vESIxPoIjNwLDK6GjROvMNhJAuBgqsc+l1py4gCsHizsu2JPqQvw92
	 r45PBturogwf3yN6N+fCHVATXOe8/z8/98UaVudVI6vOYMKKKU//GKjzxSSAoFJ9RH
	 RnPvmLTNWL5Bnn5S4mER+bj9g3pbM5DGW7889HTag4OCsqfKczJ1J51Au86HkckDA2
	 pLai0Wo3Fp+sIYpL7o5PkMUAMxvv/i02d+SlHPOgtZisX+euXjoanYjMr17R0KjADM
	 QfgAthfrCCLGAgOO9J7/4Ep9Lte7aj3GJfZ56NBXo3049RBuo2kb6+pBChbJGE0J9P
	 ddgliP34Y0Nvg==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 80CB388456;
 Tue,  4 Jun 2024 12:20:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717496406;
 bh=3sCxcGCLHWAhNppPT34fsEBSg6fNAuh16MnBYl9+5/0=;
 h=From:To:Cc:Subject:Date:From;
 b=N1m9d8yEzqklhRImU899cfYPJiTL6+KVA8IsJhHJ72jdHatBOpu1tn5qYWLQG+jpZ
 ccCymhUA938xp9PxK9FZzz0iLAO0CBf2d/CmGU57GDqX7XaaSHvGLsFD7f2ryYaf6d
 zdT1ejsiYylei9xjCQUmbCQz1LZkXp51IFvcsg+a9g01hPil9q1EwUeeELFYuVXw97
 X9ezui46SnYQoDNemOnLXrbbpJelTQyawUxojmrZ/lczJTxQe37e6dQgZci6ZXywbC
 tYE/Ccejr+68rqxtgAsZWrzrF+70tNmZjnns7M5h+8/ACoGK6Xh3DGd5uc6MHX1O4e
 45TLev+9cNP6A==
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
Subject: [PATCH v2 1/1] usb: Assimilate usb_get_descriptor() to linux
Date: Tue,  4 Jun 2024 12:18:11 +0200
Message-Id: <20240604101811.76112-1-pro@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Jun 2024 15:18:43 +0200
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

For instance, for the "Alcor Micro Corp. Flash Drive" (VID 0x058f, PID
0x6387), the following behavior occurs from time to time:

=> usb start
starting USB...
Bus xhci_pci: Register 10000840 NbrPorts 16
Starting the controller
USB XHCI 1.20
scanning bus xhci_pci for devices... usb_new_device: Cannot read configuration, skipping device 058f:6387

Signed-off-by: Philip Oberfichtner <pro@denx.de>

[1] From a38297e3fb012 (Linux 6.9), see
    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/usb/core/message.c?h=v6.9#n781
---

Notes:
    Changes in V2: Adapt commit message to
    	- state kernel version
    	- state which exact USB device is being fixed
    	- include error log

 common/usb.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/common/usb.c b/common/usb.c
index 99e6b857c7..661ec0a9c4 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -215,8 +215,9 @@ int usb_int_msg(struct usb_device *dev, unsigned long pipe,
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
@@ -258,11 +259,14 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe,
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
@@ -563,10 +567,29 @@ int usb_clear_halt(struct usb_device *dev, int pipe)
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

