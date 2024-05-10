Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49D1C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 15:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66033884AA;
	Fri, 10 May 2024 17:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BTn2T7qH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8237E88844; Fri, 10 May 2024 17:10:23 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AFF487F84
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 17:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2b33953a163so585195a91.2
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715353820; x=1715958620; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YsKPlJuma7DyhsoW23Cx9/plGxpyXwBHoNTF6PX7js=;
 b=BTn2T7qHx2vrN1VqQDmCCzKulzCCRnaC3yMMn4tXgzbfZgfk7BqX6l/wP65jI+lDcO
 0f89++2CRU4KZXtlQXJXr597SifnL2HhIW/KZdcAoOvzTwzS3P6zx7Xgl05tvlX+MK4i
 UcsL6SVNSfoSBqiJfnZW9cFWOdfHpExXOgwuzbtRp2pvVLmZYU3WJZfjDHaUYlDqXIrs
 4A4NzjsmpNLDJUZGY46kJvtN0OnWCZSNy0C/4CEtZxnZ6NrzCgAYH1Dz0LHkzkgd3w9X
 faPTFCyziUUnrJ8e/i1sXw6ldXkLv52kydH0fxI+GmetQ6LORGZbaLNaSZ/o0tT/Wspm
 wa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715353820; x=1715958620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YsKPlJuma7DyhsoW23Cx9/plGxpyXwBHoNTF6PX7js=;
 b=rOMm/oNNyKXnBJ2s98Y38ntZFnu6kzL61rTCIHfNE4wpra32UNwbH/Co2zSTP/6im8
 HK5b5Bkwl+TXjkuEINAHCOl7IX/Breve0hBvfwOoXbxxLVr36S9fFWWVBdC1jLX9tm51
 9SaQ3PINimmPsqHtDlBlYtazNDua9JRsenYi5N63UNz6Z8TD9Ydyi46HPtRJ0t8SoJG/
 HRj0P/IHiKCFN9Xohiyec7ZBbTwmdYy48zKpudiMVxWtGPBkac5LzK9mKahVZw51iYKe
 gntWeAwomeQSs4OplsahRuYiWCaxK6gW+YihgDfw80VtgHCjcq2EUxGf0BvbXxnUnd1L
 QlfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhFkrsFV9a4AaQtfmEy/wtBaDPwRGu3eMjkn87QwrKN80051c64wOzx3Uqmzcv4M+sP0q1/Cu/Sa+Wpo4HcHuzlbaJnA==
X-Gm-Message-State: AOJu0YznybawHz31z+IxFVnJHxz0TD4uBEUrKJuzuQZ14u6A/LYLhNDU
 2xCnt4aa/eJzKn0sHYkInB1hUWtnwpCnbwKNSSPzjk+wHv+/7j6aW+DYiimVm3J4bbGMdMAX1Xb
 dcnnOu6GpQrQ8NC6Cg8itF85d6NBOH6Au
X-Google-Smtp-Source: AGHT+IG98WUgxnkWRfeBVf4H/2i1XvScqzGdfMFyatnF3mmwLF8n9fnmebwG0z985FuapkX+zMequ0NSlU+dw1Kj6oI=
X-Received: by 2002:a17:90a:8c7:b0:2b6:20a0:441e with SMTP id
 98e67ed59e1d1-2b6cd1f1b31mr2707937a91.4.1715353819736; Fri, 10 May 2024
 08:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5AnweEsKk_LXVLRmC5=6L2x-Oo+rdngsAs_hcrSHFH91Q@mail.gmail.com>
 <CAOf5uw=2tob+MQfgGTfhXQqJK8vBjOPNPSD1CFkR70yXyEgAZg@mail.gmail.com>
In-Reply-To: <CAOf5uw=2tob+MQfgGTfhXQqJK8vBjOPNPSD1CFkR70yXyEgAZg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 10 May 2024 12:10:07 -0300
Message-ID: <CAOMZO5Bb9C+9-gj22LnVLGgQbh259h7iuff5jinD3LEDpAnkhQ@mail.gmail.com>
Subject: Re: imx8mp: Flashing U-Boot into eMMC hardware partition via UUU
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Frank Li <frank.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, Tim Harvey <tharvey@gateworks.com>, 
 Adam Ford <aford173@gmail.com>, Heiko Schocher <hs@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Michael,

On Fri, May 10, 2024 at 11:28=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> You can just change as you want. We have this file in buildroot, uuu
> can run command on the device
> using FB command. Example how call it

Thanks for sharing the example.

I adapted the UUU script like this:

SDPS: boot -f flash.bin
FB: ucmd setenv fastboot_buffer ${loadaddr}
FB: ucmd mmc dev 2 1
FB: download -f flash.bin
FB: ucmd setexpr blkcnt $filesize + 0x1ff
FB: ucmd setexpr blkcnt $blkcnt / 0x200
FB: ucmd mmc write $loadaddr 0 $blkcnt
FB: reboot
FB: done

Did the following changes based on imx8mn_bsh_smm_s2pro:

index 024b46ef8bc2..0b6026c34309 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -3,6 +3,8 @@
  * Copyright 2019 NXP
  */

+#include <common.h>
+#include <asm/arch/sys_proto.h>
 #include <env.h>

 int board_init(void)
@@ -17,5 +19,11 @@ int board_late_init(void)
        env_set("board_rev", "iMX8MP");
 #endif

+       if (is_usb_boot()) {
+               printf("***** Entering in USB download mode\n");
+               env_set("bootcmd", "fastboot usb 0");
+               env_set("bootdelay", "0");
+       }
+
        return 0;
 }
diff --git a/include/configs/imx8mp_evk.h b/include/configs/imx8mp_evk.h
index 1759318fdd35..148b36bd3169 100644
--- a/include/configs/imx8mp_evk.h
+++ b/include/configs/imx8mp_evk.h
@@ -25,8 +25,17 @@

 #include <config_distro_bootcmd.h>

+#define EMMCARGS \
+       "fastboot_partition_alias_all=3D" \
+               __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) ".0:0\0" \
+       "fastboot_partition_alias_bootloader=3D" \
+               __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) ".1:0\0" \
+       "emmc_dev=3D" __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) "\0" \
+       "emmc_ack=3D1\0" \
+
 /* Initial environment variables */
 #define CFG_EXTRA_ENV_SETTINGS         \
+       EMMCARGS \
        BOOTENV \
        "scriptaddr=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
        "kernel_addr_r=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \

and now UUU correctly flashes the eMMC hardware partition.

Thanks a lot,

Fabio Estevam
