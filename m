Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDEFC54E60
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 02:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EFC87EEC;
	Mon, 18 Mar 2024 03:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wetterwald.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wetterwald-eu.20230601.gappssmtp.com header.i=@wetterwald-eu.20230601.gappssmtp.com header.b="CW6mF4X4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388C087EE3; Sun, 17 Mar 2024 19:31:53 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2634387CF1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 19:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=wetterwald.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin@wetterwald.eu
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33ed4d8e9edso1319913f8f.2
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wetterwald-eu.20230601.gappssmtp.com; s=20230601; t=1710700310; x=1711305110;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v9RSxM7wesQV3ERURqLsb2kKLT80v8bzZYqOdZnEQOY=;
 b=CW6mF4X421Ewo6uy3pGv7EeMoXSL5PciwvkkbAUWT+7nvTh+4NCtfA0izzL1WTbkGo
 KwOzvUHYxykXAEkhxiGl6oBghSR2eFRfx/3x5ltR62SqteSoUQD4Wl22wHyN5Euv6TaW
 rLpF5XMMbI9kmENNRYiQ6jHFXUhpqL/H71Ll5F6NHI9mPFqcosCEriKtIumEjJ/uKNYD
 lVb0O7Dul0VlHuKBLrO28xBvl+BG2K9+1MRgJ3mVDTqVpal7VcGBKEPa80kx6lw5O7Om
 aSEHQR5c79FNmvbsxTsqkv2A9puX3wpAB5q0JS/Bg2I5lJ/XSmM3oHI1rGWG1ZwMwINo
 g4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710700310; x=1711305110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v9RSxM7wesQV3ERURqLsb2kKLT80v8bzZYqOdZnEQOY=;
 b=pUkCdVhvXl5PN9nM7rjDxd57emeXRXqgVwubmzZKCG7jgkVhaCS0SGiiLTKtjN+4iH
 a/jhr7hDbrng2hqV/uBFkOCI7jH/2LN/GCzjysdId/ocnFLO3NMmzSh+gZ5LBhY7zCFd
 hJnp0Durd1lPkN7xib5VL/nS3IwZCp1xoQIOt8loFQEJQL4dSirKn4XJJ4eMVEVn2/R/
 ixf8RiyATTimJtshjTwXBfiImnDpWEAmn/HN7ScVeyY6mYaxSR8BX6DUUdCqLYvsGpbr
 5OHE5Pr7UXuVyjfeCxwqJ/WEbD3w30oAsMB1oh4nyomOxsFdpf1rFpK/Z8EcFyH7m7pX
 Mq1Q==
X-Gm-Message-State: AOJu0YyLPrVidouUkNOwPdUQtCu4DHox0+e/Vy+SKOheG+evXjxNciPE
 YGr2E5IohWOfDqRmzR+X2zofO8Fpye8qlGhJlBETT8xfkxwU73dMNFSuQynrNKGBSnavrUoiLSk
 CEX0=
X-Google-Smtp-Source: AGHT+IGMwkSREfvDHViOqqteH+/22PFlLl7/mxDysH3sB3dFbs2xNl/l3aFaf3M/56qgrAyLq324rw==
X-Received: by 2002:adf:eb11:0:b0:33e:bb74:ac0c with SMTP id
 s17-20020adfeb11000000b0033ebb74ac0cmr7310772wrn.6.1710700310148; 
 Sun, 17 Mar 2024 11:31:50 -0700 (PDT)
Received: from Halley.. ([2a01:e0a:432:9c10:a725:7118:6631:f6f4])
 by smtp.gmail.com with ESMTPSA id
 i18-20020adffc12000000b0033e786abf84sm8016409wrr.54.2024.03.17.11.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 11:31:49 -0700 (PDT)
From: Martin Wetterwald <martin@wetterwald.eu>
To: u-boot@lists.denx.de
Cc: Martin Wetterwald <martin@wetterwald.eu>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Antoine Mazeas <antoine@karthanis.net>
Subject: [PATCH] rpi: Copy eth MAC address from fw DT to loaded DT
Date: Sun, 17 Mar 2024 19:30:29 +0100
Message-ID: <20240317183029.7450-1-martin@wetterwald.eu>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Mar 2024 03:36:20 +0100
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

Raspberry Pi B models before model 4 don't have an EEPROM nor an OTP to
store the permanent factory MAC address of the NIC.
So the firmware that runs initially computes the factory MAC address of
the board and patches the DTB to give that information to the next
stage.
The MAC is put in the standard property `local-mac-address` which is
inserted in the `ethernet0` node of the firmware provided FDT.
If the next stage is Linux, Linux uses this MAC if no other MAC was
provided by another mechanism.
There is also another way to give the MAC to the Linux kernel: using the
boot param `smsc95xx.macaddr`.

When CONFIG_MISC_INIT_R=y, U-Boot requests directly the MAC from the
running firmware in the GPU through the Raspberry Pi Mailbox. It then
stores it in ${usbethaddr} environment variable.
In U-Boot, the MAC is then often given to Linux like this:

> setenv bootargs [...] smsc95xx.macaddr="${usbethaddr}" [...]

It works because the smsc95xx driver in Linux will take this MAC if the
parameter was specified. If there is no MAC information provided, Linux
will generate a random MAC address at each boot.

This patch extends commit 6d0642494993 ("rpi: Copy properties from
firmware dtb to the loaded dtb") by making U-Boot copy the
`local-mac-address` property from the firmware FDT to the loaded FDT.
It makes it then possible not to specify the kernel boot param
`smsc95xx.macaddr` at all anymore, and still have Linux pick up the
correct factory MAC address, without generating a random one at each
boot.
This is meaningful in a setup where the user configures U-Boot to give a
fresh FDT (not the firmware provided one) to the Linux kernel, but still
wants the most important firmware provided modifications to be copied
(CONFIG_OF_BOARD_SETUP=y) through ft_board_setup() call.

Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Antoine Mazeas <antoine@karthanis.net>
Signed-off-by: Martin Wetterwald <martin@wetterwald.eu>
---
 board/raspberrypi/rpi/rpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 2851ebc985..b36a893047 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -566,6 +566,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 
 	/* address of the PHY device as provided by the firmware  */
 	copy_property(fdt, fw_fdt, "ethernet0/mdio@e14/ethernet-phy@1", "reg");
+
+	/* MAC address of the NIC as provided by the firmware */
+	copy_property(fdt, fw_fdt, "ethernet0", "local-mac-address");
 }
 
 int ft_board_setup(void *blob, struct bd_info *bd)
-- 
2.44.0

