Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48273C27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 21:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 515D086501;
	Wed, 22 Nov 2023 22:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3WFjJqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFADC874BF; Wed, 22 Nov 2023 20:43:33 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC515869F7
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 20:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephen.graf@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-28014fed9efso182192a91.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 11:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700682210; x=1701287010; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihJ+rN/d6goyihJIaTxH+JGovLkjB48ooO09IS9XXY0=;
 b=T3WFjJqxwxI5J8jjCt7tRMUXc5x9EodTjbmiiIuqZvnmyDuMQCf8luQvTHbwZxJZsF
 mTRnlQq0CdtQ3NKEY0LL2NkRQc6JaZEZ/ktFE0dzlr3D9vfhK2P563pNxb6LwHFvU0e2
 8eZu7N+s5JyO98Dw+/5WRfKp9q8cgMDynfKfhUzs2Wqil9nqWwjQax1Db0W0ila1skMU
 HcdJ2ug2gpqPCV22dHhurXz24e16x5hVnOGY9MFI8zW595enVMFYJijYC6EQFOFqWMCH
 P1sHOM72WUr8Gwb/wgFnlwAUZCY5vYGht1urI2IBuji30mNo/90x3U+4o8qSlrv2/KhB
 j53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700682210; x=1701287010;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ihJ+rN/d6goyihJIaTxH+JGovLkjB48ooO09IS9XXY0=;
 b=H8rV/cWDuqFBJojuwLGG1IWnJXlsgNEEm8b/oK0rF8s3DWQMoVG2xvDcwrn16TLHc4
 3Gb0ym8GKFFZURzism4zeIRNu7xwCqGIq++KJZI7uHHzVervbaLYeLLzL3BOCq0WZnqj
 qDuQSQ95WL12kgZwvHaGnc4scIODTTnbfawr2uCXr1qDPBhAWaMJ3GaL5vxCi8e+1QHR
 NU80cH7eWzRDi1uTQQ9/GA1vCDjsUEoMrb9xxC3xNOtCvDC53W2HaqK2Iedrq6yIUBN9
 C0DZ22gLOKTYe/MOstWl+fsTY7OZawT8Tce6VoGYLSPadzSSuti8nebCWE400FMbd+oB
 a0Cw==
X-Gm-Message-State: AOJu0YyCo13QjlXZD6zPTbb6KhjW8ypvglhniZZatqY3yxClybe5u8PH
 C1kVnVlUC0S2bLC7GqSpCdQJ8+0GC4M=
X-Google-Smtp-Source: AGHT+IEaBai7APoN23TPTHxB5tjKJRuo7pw5tWP/yy4fe6AAeq5fIw8oI9nUgn2NOgCvWHfJvYyTkw==
X-Received: by 2002:a17:90b:1d92:b0:280:48d4:1eb3 with SMTP id
 pf18-20020a17090b1d9200b0028048d41eb3mr3694350pjb.8.1700682209998; 
 Wed, 22 Nov 2023 11:43:29 -0800 (PST)
Received: from [192.168.1.3] (d23-16-72-139.bchsia.telus.net. [23.16.72.139])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a17090276c900b001c5f7e06256sm50021plt.152.2023.11.22.11.43.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 11:43:29 -0800 (PST)
Message-ID: <535b9d87-242f-402f-9d8e-febdf1fc0709@gmail.com>
Date: Wed, 22 Nov 2023 11:43:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To: u-boot@lists.denx.de
From: Stephen Graf <stephen.graf@gmail.com>
Subject: add orangepi zero3 to u-boot
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Nov 2023 22:22:42 +0100
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

I have been able to build a working (tested on my orangepi zero3 1G) 
u-boot for the orangepi zero3 with the following defconfig. Would it be 
possible to add this config to the working boards.  I would test it 
again with an official build. The dtb/dts is in linux 6.6 and in u-boot.

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

