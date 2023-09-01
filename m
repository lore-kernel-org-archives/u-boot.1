Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D95CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCAD86852;
	Fri,  1 Sep 2023 11:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561823;
	bh=17pR2ASGUkCn3HlADWTXI9Z9HwbIDet9GNYYXciX1mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=csG+U6hdAcCXw5NslMQc8+TGluIMLrtidqKK8zMAH5euzEJDvI7c8K+5jyD5KuwuG
	 RkboSC5g/vDq0x4VauFXxyOaN2vmna2cZwjZLm/JUlp5z436iDQLlm9xEO8qUP+5K+
	 S6UoZXk4FV59wld7pgzGlc6QOwGJ6ozcXingBhNgl7LcPdf/fuS89g0X6hBtywL36F
	 d1DdZ2jmHM8LbA9DELF3g0BOQYwaPYFeOSFjjDK/VaA6TqUmFZ3ovLSg9xkgP73Ofp
	 ZfDqAjKg/zEPa0dT26SJHGFishBw8Lg3CvxJJd1mqsOFb8tAU5h5oyrqgyVM6WpnO3
	 CWKzgjLixdgng==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 36A2A8689A;
 Fri,  1 Sep 2023 11:50:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561821;
 bh=17pR2ASGUkCn3HlADWTXI9Z9HwbIDet9GNYYXciX1mA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ERyWsmt6jtMF19JvtuYaCua0YwrhERUweq5RGyhV012cYDQTyBnPnpvoPmSXvC5mf
 sTngqyvHRpDbgdLRSqlgkNKePxZduefnyxSaYPXnmkUI9Ce/CyWPyyH/jwzWiqNqNR
 WCvhX77aeqBfauhxN7Tk/Ff8J/Fj7bbWphZh8/dR1pGrfCG4RX2AOGCusNbOFUJQTi
 mApRW+mXls77D++TbBYvn9nwkdmFppRo6vHjUhTyCDxvWczI4TwpoPI1wjIMi5CMhI
 7rRw0RlMfy27w/lpmhMIeNn415DIhkW0Z2XTcRL2CJ7HJCi5RxjzYZxioZzrgkrVf0
 mkXYUhmNzRQhw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH v2 05/17] cmd: rockusb: Use plain udevice for UDC controller
 interaction
Date: Fri,  1 Sep 2023 11:49:51 +0200
Message-Id: <20230901095003.352930-5-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230901095003.352930-1-marex@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Convert to plain udevice interaction with UDC controller
device, avoid the use of UDC uclass dev_array .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eddie Cai <eddie.cai.linux@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: kernel@puri.sm
---
V2: No change
---
 cmd/rockusb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmd/rockusb.c b/cmd/rockusb.c
index f181ec61119..07088564a10 100644
--- a/cmd/rockusb.c
+++ b/cmd/rockusb.c
@@ -15,6 +15,7 @@ static int do_rockusb(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	int controller_index, dev_index;
 	char *usb_controller;
+	struct udevice *udc;
 	char *devtype;
 	char *devnum;
 	int ret;
@@ -34,7 +35,7 @@ static int do_rockusb(struct cmd_tbl *cmdtp, int flag, int argc,
 	dev_index = simple_strtoul(devnum, NULL, 0);
 	rockusb_dev_init(devtype, dev_index);
 
-	ret = usb_gadget_initialize(controller_index);
+	ret = udc_device_get_by_index(controller_index, &udc);
 	if (ret) {
 		printf("USB init failed: %d\n", ret);
 		return CMD_RET_FAILURE;
@@ -56,14 +57,14 @@ static int do_rockusb(struct cmd_tbl *cmdtp, int flag, int argc,
 			break;
 		if (ctrlc())
 			break;
-		usb_gadget_handle_interrupts(controller_index);
+		dm_usb_gadget_handle_interrupts(udc);
 	}
 	ret = CMD_RET_SUCCESS;
 
 exit:
 	g_dnl_unregister();
 	g_dnl_clear_detach();
-	usb_gadget_release(controller_index);
+	udc_device_put(udc);
 
 	return ret;
 }
-- 
2.40.1

