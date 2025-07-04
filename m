Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DD3C8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D600801BE;
	Fri,  4 Jul 2025 14:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJtf2re7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4EBE803DF; Fri,  4 Jul 2025 14:22:24 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F57800D7
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-55511c3e203so859911e87.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751631742; x=1752236542; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CB/LV+JzMA3Hd53Ss977iXAtbInBgtRbAp2VCEebd5o=;
 b=NJtf2re7md+d5Ifp32ZXdGX5M5PakpObP7mnkJ5vfTm72qHWEDcRYyYOBk/hGTzh8I
 /rz/rPDMqzAOE5iP8BAGP4mKA0hjn+v4ZWJM3x1d2EgszDJyFLpDAGnOVNNSapEy26C5
 Jml26VIoGu+XQ0r+p5Zz1rOEZizMQ3n5+gIt96zexzGAThP6QZdTFG/ZBosZ+j340q/w
 jAFBXJxWcCFrPS3rmJuKnKMt+GCtgSPsWuv6xqFhqvP9smun8/0j6vx52hnv77dh/sj7
 aI+VnEdtLUNoRml7TcH8NixR6acL1sLrBcaTIdAPUQA007ZlHWSpIMAJHCkwv01LaEdN
 6Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751631742; x=1752236542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CB/LV+JzMA3Hd53Ss977iXAtbInBgtRbAp2VCEebd5o=;
 b=tyKLwA+ilAn5LxW728BbuTuAhA6x9CN97kMybhuXsBYCk7+sz+LuO7pTSJJvmq5LSq
 fvM1Zz0v0a6zWCtOsiXpUkzmmLJVna/2YXARWjI5Va6gcpTyMJl1iwJt9AswHCIKJ/y6
 FSqT9L/WWXeazYC2NCIw6erWfySpxSMPFu3LwZ/LQ9+9nPMDaxHSU3ASdvU0oFTNh39B
 FfsyZDwJFPQQWAbVfaHC/uNrMLaKLuOlap6F9MvBJTuGnySh9C0XP2kHVnzSY4VZ/Pj6
 y4c+mVB2OA/Up9E6sQKrxFAXjSXO/HzciQ7u04uxUsoLisf0xwWP7JkWh3wD04pige/w
 IgRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAguRTkmuLr584/pyhEfx7V88fBF82LZd60E7VSQyEb/dGa00CvVWoROgC22Xq97OI3Bv7v2E=@lists.denx.de
X-Gm-Message-State: AOJu0YwxbW5WjXeVm1WuJvYz3sTG9MdRwKMXBwzDMPvL3CoBYpaWn+Ct
 DJI1h14RyauSKhK7qskLYvz574pMhimEcUyBUm8ToIUK9h2yGQMYR5/MxI5NiI3dM7X9q8YB616
 hBAuyIGMMH0e50JTH1kId8drR5rURO3I=
X-Gm-Gg: ASbGncsJVQgObfRAZPAyi2OWmKkMAYKgej10LmCe035VhYDUAMHDcGbaM3AvbI7KHIo
 xuiHUPK8s+bBhC74JLhDxR1Y+gx0lwLVLKjnpcHykfcaHv0JuaiHfgqJuvduE/sAXyB4p7pCkeU
 Q6FZbuGnUxjBT7z68kIAlxUmusJgTPMC+/kvikxwArobYKZyIjHVLl4UT3TWxG/DosvIWwIwdJQ
 g==
X-Google-Smtp-Source: AGHT+IFrXapC2cpUqX54//NOVCGq46egrO8D6U6MbRVJIsqKkjK7udp8yAOj8lR1HFWRu4GzTw3IJmiCQHWudCLRKeE=
X-Received: by 2002:a05:6512:3c84:b0:553:297b:3d4e with SMTP id
 2adb3069b0e04-556de363d36mr716466e87.52.1751631741875; Fri, 04 Jul 2025
 05:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <CAOMZO5Dhs2GRgvjDCBbwsxxZadsVCrpXaWm4qToYfpak+CAKuw@mail.gmail.com>
 <CAOMZO5Bjxx5tjj75Bo8A4WJWBnV3Q8h1UHK45_xZgOavig0C9w@mail.gmail.com>
 <0b7fcdb0-0d18-41ef-8607-cf060ce3d058@linaro.org>
 <CAOMZO5CXyVyoDEUhFbtaHxi=QDp2uqn1U5ccBq6W8uoEipeVxA@mail.gmail.com>
 <96cd2cac-2ba2-40fe-b54e-21a37e69c19b@linaro.org>
In-Reply-To: <96cd2cac-2ba2-40fe-b54e-21a37e69c19b@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 4 Jul 2025 09:22:09 -0300
X-Gm-Features: Ac12FXzZf2mDrFDVUpbWaakwfOPlbEmpFAtbYtquuMOKwwKjfF6xLPl2EB9Fa0Y
Message-ID: <CAOMZO5B7Mhx1GTJXWp-22_NXNOKRJWDUx4aChG3DDo9Vtg=KAw@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Static initcalls
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Otavio Salvador <otavio@ossystems.com.br>, 
 dl-uboot-imx <uboot-imx@nxp.com>
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

On Fri, Jul 4, 2025 at 9:02=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:

> OK. Then I suggest adding a debug traces to the INITCALL() macro to see
> how far the init goes.

I added some debug traces inside the INITCALL() macro, but when it
hangs in SPL, no output is seen.

There's something very fragile: depending on what is removed from the
defconfig, the board can boot or not.

For example, by removing the following lines, the board boots:

--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -73,11 +73,6 @@ CONFIG_SYS_MMC_ENV_DEV=3D1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
 CONFIG_ARP_TIMEOUT=3D200
 CONFIG_BOUNCE_BUFFER=3Dy
-CONFIG_USB_FUNCTION_FASTBOOT=3Dy
-CONFIG_FASTBOOT_BUF_ADDR=3D0x12000000
-CONFIG_FASTBOOT_BUF_SIZE=3D0x10000000
-CONFIG_FASTBOOT_FLASH=3Dy
-CONFIG_FASTBOOT_FLASH_MMC_DEV=3D2
 CONFIG_DM_I2C=3Dy
 CONFIG_SYS_I2C_MXC=3Dy
 CONFIG_SUPPORT_EMMC_BOOT=3Dy
@@ -111,8 +106,6 @@ CONFIG_SYSRESET_WATCHDOG=3Dy
 CONFIG_IMX_THERMAL=3Dy
 CONFIG_USB=3Dy
 CONFIG_SPL_USB_HOST=3Dy
-CONFIG_USB_HOST_ETHER=3Dy
-CONFIG_USB_ETHER_ASIX=3Dy
 CONFIG_USB_GADGET=3Dy
 CONFIG_SPL_USB_GADGET=3Dy
 CONFIG_USB_GADGET_MANUFACTURER=3D"FSL"
