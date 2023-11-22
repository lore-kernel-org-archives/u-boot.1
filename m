Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E57C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 12:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9233787266;
	Wed, 22 Nov 2023 13:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=telus.net header.i=@telus.net header.b="NCQmMAY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D85875C0; Wed, 22 Nov 2023 06:52:24 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDBE8725C
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 06:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s_graf@telus.net
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cf52e5e07eso3792945ad.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=telus.net; s=google; t=1700632334; x=1701237134; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIOAvg46s+NysZoGzzDIOHr9euAwexgHqSaHD1scSac=;
 b=NCQmMAY/61uXd5+ulURp3+WYRa9NsE7s88q/oll/VRBkAZgiVilgoAlc1CcuCxbstE
 s2RbULtfGNL5q/i9G0FrtgK1wt5qqfie/HtipHV4brCw6boeckCA/KKd7eW3R8FcAm+J
 voJPqus8tinYG6CgP9RGtDI41riyA3lwo30HQdmoFa54C9Sj8tWzFSpUcCiYAMy06d/N
 oIOv4TzZfetKhzHO6M6OzUsE9STInRJZ2NiJEtACw7ESp4GXJz30lBpiduY4kDLUCZjc
 6XZYmYklVQe2jNIif56nLy4X/s1j+aZBZYpH23Q2mvTo9NdPx9IqFQrKEBpGq3BZ3BdB
 9Qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700632334; x=1701237134;
 h=content-transfer-encoding:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lIOAvg46s+NysZoGzzDIOHr9euAwexgHqSaHD1scSac=;
 b=VeTjeSBwUezj01HukHhqfTh6DOR/WbW4omQhaoe80LjDwu/YycM/ROFtr7Bxk2XVs5
 b3GsLuCOO39UHcU61FIBrdVGKl1cAU1LUtsgbf7wTDFX7fpqgtPGhMv3jnQ5+ZHKSiqO
 ZBbHs48Q/CyvVn/MDu42riODFdw074Fj7pXtW5PbGarblqMtca4Y0JUZSTFNv+I6JPvO
 cx5AQN2FIyBmPzJ/UGzpINkwnFNET/nZSK8nWbxSi4x8/sEDHBknWf1/ezRMu2kds5pv
 ziU+juTG94XE8hk02t+Q7cDk+LsbwDwjqDolMsPbWWDy9dXzkBB7Mvx8b3zkraRKT+Ol
 aN+A==
X-Gm-Message-State: AOJu0YyDaxi7/AldQ1TFglzQGScMIu4IXqn8Q3RuMPcfzqm0lFofazPJ
 D1TuSnIdSXts2JIivwWPB2RxsFhuGECqz5gKONY=
X-Google-Smtp-Source: AGHT+IGfCC2I2582UHvu/N+TOrwuB5ksaB79rkJ0LNndnW57mbSwqEpwvpyYsAbfHJxE14p6gqho0g==
X-Received: by 2002:a17:902:e80c:b0:1bc:1e17:6d70 with SMTP id
 u12-20020a170902e80c00b001bc1e176d70mr2447554plg.24.1700632334509; 
 Tue, 21 Nov 2023 21:52:14 -0800 (PST)
Received: from [192.168.1.3] (d23-16-72-139.bchsia.telus.net. [23.16.72.139])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170903120c00b001c71ec1866fsm8938764plh.258.2023.11.21.21.52.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 21:52:14 -0800 (PST)
Message-ID: <28efed32-ee19-4a89-9c84-defa95c3a963@telus.net>
Date: Tue, 21 Nov 2023 21:52:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
From: Stephen Graf <s_graf@telus.net>
Subject: orangepi zero3
To: u-boot@lists.denx.de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Nov 2023 13:07:05 +0100
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

I have been able to build a working (on my orangepi zero3 1G) u-boot for 
the orangepi zero3 with the following defconfig. Would it be possible to 
add this config to the working boards.  I would test it again with an 
official build. The dtb/dts is in linux and in u-boot.

The H618 processor is software compatible with the H616 and the zero3 
board is very similar to the zero2 with the exception of DDR3 replaced 
with LPDDR4 and the Realtek phy with Motorcomm.

CONFIG_ARM=y
CONFIG_ARCH_SUNXI=y
CONFIG_DEFAULT_DEVICE_TREE="sun50i-h618-orangepi-zero3"
CONFIG_SPL=y
CONFIG_DRAM_SUN50I_H616_DX_ODT=0x07070707
CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
CONFIG_DRAM_SUN50I_H616_ODT_EN=0xaaaaeeee
CONFIG_DRAM_SUN50I_H616_TPR0=0x0
CONFIG_DRAM_SUN50I_H616_TPR6=0x44000000
CONFIG_DRAM_SUN50I_H616_TPR10=0x402f0663
CONFIG_DRAM_SUN50I_H616_TPR11=0x24242323
CONFIG_DRAM_SUN50I_H616_TPR12=0x0e0e0e0e
CONFIG_MACH_SUN50I_H616=y
CONFIG_SUNXI_DRAM_H616_LPDDR4=y
CONFIG_DRAM_CLK=792
CONFIG_R_I2C_ENABLE=y
CONFIG_SPL_SPI_SUNXI=y
# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
CONFIG_SPL_I2C=y
CONFIG_SPL_SYS_I2C_LEGACY=y
CONFIG_SYS_I2C_MVTWSI=y
CONFIG_SYS_I2C_SLAVE=0x7f
CONFIG_SYS_I2C_SPEED=400000
CONFIG_SPI_FLASH_MACRONIX=y
CONFIG_PHY_MOTORCOMM=y
CONFIG_SUN8I_EMAC=y
CONFIG_SPI=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_MUSB_GADGET=y
CONFIG_AXP313_POWER=y
CONFIG_AXP_DCDC3_VOLT=1100
CONFIG_CMD_BOOTZ=y

