Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2072FCA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490F186907;
	Fri,  1 Sep 2023 11:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561823;
	bh=q0GRJqjX8VsOrYiS4ongZI6pq++jkucg+dubqq+tLCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MoTOeToJZKON53NcySXKk6MiWR1TzJHkCiCciQzvT4d/Ewf9fBJysDl3Yud7tS1yT
	 k0V76JUA/Iy56FaOwgw8foqP0Ovb3g+EPJlKGFAo3tJjTILGrxBesdx+BUrrKbuiyL
	 fI5SJLDhWSdCOeMSqFubtjshdKtLhw47BLyLWyYbJbw5yQ3uv0wcNn/shohGHru0Ps
	 YQ9/jlM+j6z7sF8V89SGR50HvO5AX3wzVg0pR9boNMVl0TOpnwIFUAWACqlJziaTHW
	 rpRqGsWbzoHTVgwH+CMOSUFxMIQXEqoF4h5JL/cxLPw5Pl3PZPso16CvZWuN1en5Bt
	 6TSc9G1DD8KZw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9176486886;
 Fri,  1 Sep 2023 11:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561821;
 bh=q0GRJqjX8VsOrYiS4ongZI6pq++jkucg+dubqq+tLCY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f9QsjBnTXo434TsKuOaIdyYMlLiIRJi4sSh1mdnkNueRmVG5n14o8B29FpYZV5o4f
 5bJYP+aYSlh275sHmzs83avCYliXcB1mFn2NnD4l5KYin1i87vPfq3Os8bTOeZvqFS
 OqRX9COmvh+tjPmY4s3HV97u+wYY2lxN++xbLsIYt19mplfChuUwJtsNJy3mpni0IZ
 7QFKYA2hzOg0xjASeH1Muzf6QYcfod9G1GP1BWayhLYDQrqF5x59TZKOb3W6iuRp2Q
 yAUa8LEee3q3ShxomoJTCPron/D6JBA6heUJPqj8k4WlHV5xLoQqqNl++/eg+m7JzO
 vs+oZ/ZoGnWDw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH v2 04/17] cmd: fastboot: Use plain udevice for UDC controller
 interaction
Date: Fri,  1 Sep 2023 11:49:50 +0200
Message-Id: <20230901095003.352930-4-marex@denx.de>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on khadas vim3
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
V2: Add RB, TB from Mattijs
---
 cmd/fastboot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmd/fastboot.c b/cmd/fastboot.c
index 3d5ff951eb6..17fb0a0aa7b 100644
--- a/cmd/fastboot.c
+++ b/cmd/fastboot.c
@@ -61,6 +61,7 @@ static int do_fastboot_usb(int argc, char *const argv[],
 {
 	int controller_index;
 	char *usb_controller;
+	struct udevice *udc;
 	char *endp;
 	int ret;
 
@@ -79,7 +80,7 @@ static int do_fastboot_usb(int argc, char *const argv[],
 		return CMD_RET_FAILURE;
 	}
 
-	ret = usb_gadget_initialize(controller_index);
+	ret = udc_device_get_by_index(controller_index, &udc);
 	if (ret) {
 		pr_err("USB init failed: %d\n", ret);
 		return CMD_RET_FAILURE;
@@ -103,13 +104,13 @@ static int do_fastboot_usb(int argc, char *const argv[],
 		if (ctrlc())
 			break;
 		schedule();
-		usb_gadget_handle_interrupts(controller_index);
+		dm_usb_gadget_handle_interrupts(udc);
 	}
 
 	ret = CMD_RET_SUCCESS;
 
 exit:
-	usb_gadget_release(controller_index);
+	udc_device_put(udc);
 	g_dnl_unregister();
 	g_dnl_clear_detach();
 
-- 
2.40.1

