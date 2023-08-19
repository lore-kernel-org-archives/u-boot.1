Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE27EE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7660387068;
	Sat, 19 Aug 2023 16:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455084;
	bh=Ijap/iB61Dz8xUKj2EgQVECLKnRmIw+YAknbIt5+OMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=reasUA7YBYSc/yzfuvANMCLLurR3Woo74emoNOBjNVRyOxYOm/523dtkPhr0+Hso2
	 Q0tuB17gLtJH1T2TZ1kSXivvEnmawD4x6TGZNS4vQXuOUZm0ua9Im3SrEPlim1LptH
	 DV0Cal1frWKB6PEHoXGEfVGmWVXW7YnRq9mZW3kvy9XyUw8QFGHKS/WnF6QXzy7S1J
	 areBM/ZzJ4kfhJa/2vBdV3vr261FVrlXPhIeJFUfNolrvMl06IDxZaeDr6LVqbDrvN
	 owYZzLA9QllohoxORUZTRpUWSmkPmXPmBD33cboZA8vcHSrppDyxKoDLQxvJTKJGDf
	 22Sx/cjPkm5OQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CCC3C86FCA;
 Sat, 19 Aug 2023 16:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455082;
 bh=Ijap/iB61Dz8xUKj2EgQVECLKnRmIw+YAknbIt5+OMo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Uo6u+foPko7U0LUdcoslHWLQkgr0i1b+SKKpe0b8mj4jaPV08Je2tzBUxy5IPUg6a
 Vnk0o/jEsf6GikvtpbOz0vQQnu/AGkIytUjXn4kmAPy2jP9Tsik3gPWupEtnuAblSc
 IgEssTk+EjjtkxT2Hu7N2cYiqOg6lw2v/krNGtO+VJjuUiPK1/RUWM3XAznBz4slRk
 l6tYn7Yp6jC9k5zoLgL32Vx/QuhsiJl+Z/L+kYx31tm+I5C3+H/ebl6sxW46gyMAKc
 aDBjUW5AiY8tJZCfa3LTT9M88cIdndyXlBr1CNptCk3CBhUerSeUp69lurW3PdkHfb
 qZXecK5pgvV+g==
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
Subject: [PATCH 09/17] dfu: Detach the controller on error
Date: Sat, 19 Aug 2023 16:23:59 +0200
Message-Id: <20230819142407.49632-9-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230819142407.49632-1-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
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

