Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FDDCA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC79F8698D;
	Fri,  1 Sep 2023 11:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561825;
	bh=Z3J4yA4ONl5RTViLELhs05LgTp19WokGxkIwi54DfN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p2kfhRyRsUbVjtAv04q43YJkuX8KQX0keUl4+9/ht1GTdYvfgVgOm/e6xiz4uYwrR
	 NbH4oQG3Zm5V12X1UK+JxDnjmYwzqQhV0JD/hte8e00JbnhePbzcCsUcnMIrYyUluy
	 y9M1QT1kSZxUqshIA+tE6900BhaBcsxzq5fsIsbkYhGyjIvhON60LQch7MyPjGCF2I
	 A8SZpbjPEHPzLUcnqu7n/LkTyfq+9YeYks7yH8oIryRoRrzwxu4AAcUJ3GqWwTkgZ/
	 0FMKkZNIYDnq5pLhcjvD4wU6PPS/9z96+aZ6GyHBR6npD2LWdOVKdXUHaP93b3UwdE
	 IffFkXGbe+7Aw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AF8F2868B1;
 Fri,  1 Sep 2023 11:50:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561824;
 bh=Z3J4yA4ONl5RTViLELhs05LgTp19WokGxkIwi54DfN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lq3hMksDHYxab4v/rNqNFgEifUr3FljMKFRoOmwFXv0WqzUzg/tchj9KMPlsanLl7
 v69DlRCV+qRJkFMyhO3EfFZsCr6JUlGF0kBI/LgXJamuLZxuUgbNjQP4oEsFszggpG
 Hzq6+ErGN6xE8iYmtArMNd0fIlX/XYdYyZ8ff7JFLiwc1utTFpwJzwfgEGQjo6LCv0
 Z8WSzN0TQwlnpIU6dpnu9A0ghfHSYyzERQ3cJjEaApe/2mHOmdJ/TEX3wKgNuo0S5A
 3KnSOEfL2Y5bcx9u7wkrsWBy7Eb2y7Gd9Yp7ggnDu012gcJycfvZeaWTCHC/ZrrtpK
 9p2oNBA2WCi8Q==
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
Subject: [PATCH v2 09/17] dfu: Detach the controller on error
Date: Fri,  1 Sep 2023 11:49:55 +0200
Message-Id: <20230901095003.352930-9-marex@denx.de>
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

In case anything errors out during the DFU registration, detach
the controller instead of bailing out right away. This way, the
controller can be reattached on next attempt.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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
V2: Add RB from Mattijs
---
 common/dfu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/dfu.c b/common/dfu.c
index 96190889ab7..32fba84da16 100644
--- a/common/dfu.c
+++ b/common/dfu.c
@@ -34,7 +34,8 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl_gadget)
 	ret = g_dnl_register(usb_dnl_gadget);
 	if (ret) {
 		pr_err("g_dnl_register failed");
-		return CMD_RET_FAILURE;
+		ret = CMD_RET_FAILURE;
+		goto err_detach;
 	}
 
 #ifdef CONFIG_DFU_TIMEOUT
@@ -106,6 +107,7 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl_gadget)
 	}
 exit:
 	g_dnl_unregister();
+err_detach:
 	usb_gadget_release(usbctrl_index);
 
 	if (dfu_reset)
-- 
2.40.1

