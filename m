Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93832C88E46
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DBDF8108F;
	Thu, 10 Sep 2026 14:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INRmeBivbcqs; Thu, 10 Sep 2026 14:04:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 202578107F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049083;
	b=OJyYqcMOwvKUJQz/XZxdTOkzzbqGasCjSkmgShXjFjj4aKabrEMEa5Lh+zJepVYawlk0
	 6izgVN69Fov9O1pp9EYyasGGDUOBKVYKk6F1BlI1vtD+wg3cKWOg4aJCBWM1df9Dl3IpH
	 bzkCqDpNWXuoM7/G5EhvwUeDsm5RYSvGZ7S9hmgZz7GNuWp0h07dpWYOOWCzsRBwLvaNU
	 MvIhxHURMVF1SDA07EV5GXVVgzpozZWk7ZgQnu4AFMoVahAG4AaZq2JAiRWYiu1Vxyfsd
	 01Y8dXPGajTIl6UP1a1XFzlSWK+8fPT7x6AQKgvoZSTJVanm4qeHJtQkYUQj4po5m7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789049083;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X0IoAfjKsiCDT4cgwlZ5bolaPEwGjA0V2cO5MiZChIg=;
	b=BqiNSbfW3icutF1V8NWfwpOklbBzi4iTLJPpsQ7jikCNUP9EE03HVZ0zuMeveq12+7RE
	 J1JvQtgh/1HGb2i3iM82TdOd4ZJ2mdkYS0vYD4eN+sSTDZQBLn/RGn6qEwJE7xdJcMFIt
	 vmi/PXk4paUU1QuzWz91qHt6EC2dmOuqWgr+I6lZp6pk7801KGzFbSiuoxTlEkHEz1Fzj
	 c7Cb0IcnTtNxFPZhbpadqK25qgMLah88ftwLR3mnZ+LhrEbssDie1o1ZaCzh+dtYq5fEs
	 yYl+0RYS+p9X2odlH4h5Bss1kSKZoBSJuLkyZE1jXfAZ3bmUdXV6muFSEre6ZurtUVw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789049083;
	bh=X0IoAfjKsiCDT4cgwlZ5bolaPEwGjA0V2cO5MiZChIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yyol8ozE9MrVtFM3XEE4S3XWUWgt8HI1euh7tzA4NhvR1bqAt3njiEF/AUies/25V
	 O++IPD52/zOlqkn0izPetGJ+t2GdPnpHlWTt5pfEjfTSbnRZaAMjAQHkoHSpo3MWKG
	 MWS/kI9x+Y0XkBOoREOM4A4K3+m5FEsnUfli+sCk+5B7uPzzJo0CoYq2+K6zH4zuC4
	 aFdKMKyD7js0WklKP6nONumivgZ17yis7r8xu3n1MbOxIqCxynu3hAsy0CgYvGjuci
	 zG3Kpu0Fdjj1szW4H/ahgpsKj3/FLFOICAsTEP1F4+Cd7tc3onTvLKamqQ4BrTl24B
	 3QsDh20VRlq7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 202578107F;
	Thu, 10 Sep 2026 14:04:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EF8029B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E899B40623
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nAnwNe8jKeLa for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:04:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E1B90403FB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789049079;
 b=ZMY43p9sF9ub08dLweHHI7PHo6SWl9CbfnSDTfRp0t2GlH3DXZwMvxNG3kJ33C9IGkkW
 f/r64a02cd3063KV5RmrxDgdGYqKg6P1yzi38p4OzHD8RsF7fTxBQtrOUio1B0QND6bgB
 D9hwJMfBOnvyfs9DxB2kQs/RqlTsC4BvUbvnH2h/qjjHOUVeIiTeVctem6HcMHSML918H
 ZJQQcET+IBKweX+exJvasFblZFHDeiybfRAFQATRh4hTVEvl4h/cjwzmpTymPixIqIEb9
 1qHQPoCnXf5Knh+h3MnsiZDjUr9wGegeE66YF1LCDhX6YMySwA3zIyLiINoLZflKz8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789049079;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=X0IoAfjKsiCDT4cgwlZ5bolaPEwGjA0V2cO5MiZChIg=;
 b=b4h4TnjeForoLgMSzf2nrxnC3IoR65e1QV8L350d9zyg4Pv0CwPTe2u9vh4v1YpD84Rg
 Givw5y3QHirzWdXbvMF9ECNSs+xuK+x4OXEMv6v9cy+EKSQN8YcpsIxLx/ekZfmqnjtuP
 8sUT4d/p6u20LGf47DwNL19NPNpXeONhbPV+2qL8gEhnXmzFuNZMYZWF9PgTvncYgUpyM
 MqoNUIPNuWhU6IkZDIPwXDlBe1zattiK8Xmpki7WuJburz6GeFoyy+zCq2g9swIrKbrTs
 7RDolv4L0l1IsqYTCBwyXsdSkHbBTEeyY5gFT3xtEfxUecFs4DKZm3Bnl/Fl3KVJe/g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AEs88aZN; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AEs88aZN
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1B90403FB
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:38 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso18653295e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789049076; x=1789653876;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X0IoAfjKsiCDT4cgwlZ5bolaPEwGjA0V2cO5MiZChIg=;
 b=AEs88aZNcDjse1eiM/JTgb56r9+Hczz9crC1DcIv2hA5Y9cPGE0STNMR3Azb3q23n4
 Lj4vVgXAXH8PNDg1RaJOF2RJ5/xowVB+HvPTjcYRZkQid1IUWpddeS8zAReOlKgM6paH
 0gK+Vg0tYi25wwY4+us6P4ejhJ89l6BGofs47jCiuar1SZnYdS+UgzbTbMVuYn/u59DL
 B5npby+6DWaaDttWxrMk7aFCuUmml+A7DuDBmPGfwmSSFgM+8KhYkov34SFc94lbH/+S
 kssphKQREphhpE3o2YKJt3UqC8Cj81h+Lf3bTjrLcuYdqYImliiCryD4RDZEDV29fb7h
 1pjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789049076; x=1789653876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X0IoAfjKsiCDT4cgwlZ5bolaPEwGjA0V2cO5MiZChIg=;
 b=VD3NxEVk+ewC/whoq4/Z/w5KfizdMSl4KIctyedDWEaBtqbmNcDiinoF37jzNgeilJ
 UC12b2o9OpLtEUokJaXdtsV6gyNOZi2iTn459q12LYLMX3tvY47dWuoM6U90V8CHyxb4
 /HrzQQSdV8mXqg/TQ7+pLaMC2anRjHcMtuh9rg6oc4eULi49q7ktZXX0zUMzc6z/F4N2
 9aSNE2sr2OVX2yvP5dQxZXq7IlWRu93xGgs2xCgLqgqOoZgii1uwhuCP0PQE055jwKZ3
 0a4Fgv9eDzovUkuaOP9SB4jv6m0ItUJB+UhUTwuAIpahp0Fxjy4/bIe0ZIrUtn+daAEB
 7g8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGcdZ+lgJHOsKUGHi3qq+Jz80D0GgGOvKJGcMJD7ZiBwKfeKF5QRCyh+eoSxnPtBx4t4OtPVI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mSoQOagVXEdUSiWlYOZRUylh3LqDQCFZ2o4rjYxHfOYISnmNLG
 gc84RB5CUDVFJbeiTnvt5wOx6bqkPlfkoK6W4SPaXbhONdt4/TSW4e+9EChaSi4JIuVX9/kzYae
 6efI49ks=
X-Gm-Gg: AYBFou3JDqFyc6kFWykj6isA/OCrLWHQQN0lF7qrR6Q6CjR5GSylQ3HAHQE1yOB+T4v
 UDvHVBapjPQ0j0ces3g1VmtVT+eUuC2JuEP4dAZiAqc9MKmcf9WE0otgh66B5i1hfW597KtmoFl
 CDrhOWHZcSNtuXNfq2vSaM5DVE8RcnuTD3glLYtsDAV8EIo1T3Kwn2DV6DzohW9ybtJfMruI/E9
 x+e26Td/jxPd/banoX6MQ99Ura//w+e1nUqlz/hTGHmeb5nXyaSexsyccOJoSzYz7i04nBFKO54
 P9ccPUv1+VE+BLYw6xEDvEapk1glRWHp/PXtMb0OlzXHcbYFQV7zHHmfWnmtooNe9d+4bOGU4Uk
 TJoj8LRaWYum7h1cnJq5n0vRBbONmJ0nj8QI/vKJNdY0KoOVzmnwvdO3oLgwgTUgjIMC/RFe4x+
 gx2r+LX5y0qlt6ezajUyGCFYtb4Z484bMqpVzW6fiWlRQmJKXMpTNwd/Zcg1nb
X-Received: by 2002:a05:600c:45d5:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49d258f1d5cmr144248015e9.7.1789049076585; 
 Thu, 10 Sep 2026 07:04:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20db6e76sm147660745e9.3.2026.09.10.07.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:04:36 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 10 Sep 2026 16:04:23 +0200
Subject: [PATCH 2/3] configs: sei610: drop Android support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-remove_sei_android-v1-2-b7bcbcef3834@baylibre.com>
References: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
In-Reply-To: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Android is no longer supported on SEI610. Remove its Android
configuration and use meson64.h for generic board support.

Drop "fastboot oem format" as well, since it depends on the removed
Android partition layout.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 board/amlogic/sei610/MAINTAINERS |  1 -
 configs/sei610_defconfig         | 10 ----------
 include/configs/sei610.h         | 30 ------------------------------
 3 files changed, 41 deletions(-)

diff --git a/board/amlogic/sei610/MAINTAINERS b/board/amlogic/sei610/MAINTAINERS
index 799ad687f09..6d0159f204b 100644
--- a/board/amlogic/sei610/MAINTAINERS
+++ b/board/amlogic/sei610/MAINTAINERS
@@ -4,5 +4,4 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/sei610/
 F:	configs/sei610_defconfig
-F:	include/configs/sei610.h
 F:	doc/board/amlogic/sei610.rst
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 7f6488dfba0..91ebc3282e1 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="sei610"
-CONFIG_SYS_CONFIG_NAME="sei610"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_SYS_MALLOC_LEN=0x8000000
@@ -25,18 +24,12 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="run load_logo"
 # CONFIG_CONSOLE_MUX is not set
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_AVB_VERIFY=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
-CONFIG_CMD_ADTIMG=y
-CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
-CONFIG_CMD_BCB=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -47,7 +40,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_BMP=y
 CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -58,7 +50,6 @@ CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=2
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 # CONFIG_INPUT is not set
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_MDIO=y
@@ -99,4 +90,3 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
-CONFIG_LIBAVB=y
diff --git a/include/configs/sei610.h b/include/configs/sei610.h
deleted file mode 100644
index 783eece271d..00000000000
--- a/include/configs/sei610.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Configuration for the SEI610
- *
- * Copyright (C) 2019 Baylibre, SAS
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
-#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
-
-#define PARTS_DEFAULT \
-	"uuid_disk=${uuid_gpt_disk};" \
-	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
-	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
-	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
-	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
-	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
-	"name=super,size=2304M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=12274M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-
-#include <configs/meson64_android.h>
-
-#endif /* __CONFIG_H */

-- 
2.34.1

