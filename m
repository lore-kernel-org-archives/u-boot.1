Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C72C54E68
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 21:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E278087F04;
	Tue, 19 Mar 2024 22:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wetterwald.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wetterwald-eu.20230601.gappssmtp.com header.i=@wetterwald-eu.20230601.gappssmtp.com header.b="3EI0o1nz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 461A687F3F; Tue, 19 Mar 2024 22:59:22 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22A8188063
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=wetterwald.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin@wetterwald.eu
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4146af3ebc8so759115e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wetterwald-eu.20230601.gappssmtp.com; s=20230601; t=1710885559; x=1711490359;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kL4KqabnSyLRUpLjEGp0c21AHzGQWh2ENm8h0kXjxS4=;
 b=3EI0o1nzoLC5gIjK4aERBVNz/LNIge/zr9Cu63Mq9lKcfMe3TZFR1yY3GAahxSzNkg
 9SMGdIhyLB4LI1SGV7e6A3Y/b0DGq7pI/s6MYvi1pYHInLb/BmmjrxMAlNTRWAImX4bN
 T69R4PQRCD8/6Q9yyUPts1rbjcAKwMPJQFTg1+EMKaAD1Fzu/cdhQ4ZMnGIT6jd24Yih
 OQHm7gsNcB+I/AxspuZLDeJST/nQxVGTtbhyqJdsyy0F4zBrXBlGi7vtrJmcFEG9ZBUC
 gnXlRb1orRjRkX63IzvsF1qZEk0fv8C+siv8Gzi4O98yawkS4dtCtbUgxV3BzUEghTjp
 onLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710885559; x=1711490359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kL4KqabnSyLRUpLjEGp0c21AHzGQWh2ENm8h0kXjxS4=;
 b=gyEf/jAGJuJuWFrYf1x1kyluNqY6MvTHDQdFVP5s8UUlaiwtJ2t2qkN15rE2jD7cnz
 v96YmbGYIT04DbAf/H/OOEFdP347XWVuBI2NDrKsipp9J3wqjMSAWR0E8UnPs7AVX9wN
 2Wo0NALO4K3aAlKu5tmvkBwDDYi3+cvkZM8P+auPm/WsoAVwyE37Zdiwuxf3kBDAoHUG
 mYvYhQZ1/8SImGL+71KL8kZTOU9ZzzLRExhT1achwG3xqDJo2oImVKDYbqVRi1vSt7w+
 ve6avvHQefvPK/x6R1xla7ee2mLXt1ookHMWXGq6Ne7rNfQlggBJrvcR5KqljBOUFOyB
 hOrg==
X-Gm-Message-State: AOJu0YwmFH4yHvt8unyGQogPaCzumIbZAlei+unxwcqEDXSxVuA2Z0Ee
 ZFBU5DwoKtWT4xoJnh3ye93zqlL0UJ4z7pw9a5lP6RP0JeKluzBP+MwUAt6RJVynuUVcVabI3Y9
 rFLQ=
X-Google-Smtp-Source: AGHT+IEvAn1U05cL7Zpv82qW65+tW0EW46CsCg0UJa2ElQEG8zlNLSThscqmOoJ5QueiM7i1YfknmQ==
X-Received: by 2002:a05:600c:35c9:b0:414:6a02:ebfa with SMTP id
 r9-20020a05600c35c900b004146a02ebfamr362589wmq.20.1710885559445; 
 Tue, 19 Mar 2024 14:59:19 -0700 (PDT)
Received: from Halley.. ([2a01:e0a:432:9c10:34e:6981:9a11:7ba2])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a0560001a4400b0033e756ed840sm13191201wry.47.2024.03.19.14.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 14:59:19 -0700 (PDT)
From: Martin Wetterwald <martin@wetterwald.eu>
To: u-boot@lists.denx.de
Cc: Martin Wetterwald <martin@wetterwald.eu>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Antoine Mazeas <antoine@karthanis.net>
Subject: [PATCH v2] rpi: Copy eth MAC address from fw DT to loaded DT
Date: Tue, 19 Mar 2024 22:58:36 +0100
Message-ID: <20240319215836.48178-1-martin@wetterwald.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317183029.7450-1-martin@wetterwald.eu>
References: <20240317183029.7450-1-martin@wetterwald.eu>
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

Raspberry Pi B models before model 4 don't have an EEPROM nor an OTP to
store the permanent factory MAC address of the NIC.
So the firmware that runs initially computes the factory MAC address of
the board and patches the DTB to give that information to the next
stage.
The MAC is put in the standard property `local-mac-address` which is
inserted in the `ethernet0` node of the firmware-provided FDT.

Here is the algo used by Linux to determine the MAC address (applies for
all models with smsc95xx). It stops as soon as we find a valid MAC.
1) Look at the FDT (mac-address, local-mac-address, address)
2) Try to fetch MAC from EEPROM (always fails on those Raspberry Pis)
[ 3) Check module parameter smsc95xx.macaddr ]
4) Generate a random MAC if we didn't find anything

Note that step 3) only applies in the Raspberry Pi fork of the Linux
kernel. The upstream kernel doesn't have that step, as that module
variable doesn't exist.

When CONFIG_MISC_INIT_R=y, U-Boot requests directly the MAC from the
running firmware in the GPU through the Raspberry Pi Mailbox. It then
stores it in ${usbethaddr} environment variable.
In U-Boot, the MAC is then often given to Linux like this:

> setenv bootargs [...] smsc95xx.macaddr="${usbethaddr}" [...]

This works in the Raspberry Pi fork of the kernel, because that module
parameter exists. But it doesn't work in the upstream kernel.
With the upstream kernel: if we make U-Boot forward the firmware-patched
FDT directly to the kernel, the MAC will be correct, because
`local-mac-addr` will be present. But if we configure U-Boot to give a
fresh FDT to the kernel, the MAC will be randomly generated because the
`local-mac-addr` property set by the firmware was not copied by U-Boot
to the loaded FDT.

This patch extends commit 6d0642494993 ("rpi: Copy properties from
firmware dtb to the loaded dtb") by making U-Boot copy the
`local-mac-address` property from the firmware FDT to the loaded FDT.
It makes it then possible to use the upstream kernel and to give it a
fresh FDT (not the firmware-provided one) without having the kernel
generate a random MAC address.

Note that this is only possible if CONFIG_OF_BOARD_SETUP=y and
ft_board_setup() is called.

Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Antoine Mazeas <antoine@karthanis.net>
Signed-off-by: Martin Wetterwald <martin@wetterwald.eu>
---

Changes in v2:
- Clarify the commit message by pointing out that smsc95xx.macaddr
  module param only exists in the Raspberry Pi fork of the Linux kernel
  and not upstream
- Make the intent of the patch clearer in the commit message (booting
  upstream kernel + fresh FDT without having a random-generated MAC)

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

