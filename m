Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6A2C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 01:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B62B0876D7;
	Wed, 29 Nov 2023 02:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OoSibzHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC0B868FC; Wed, 29 Nov 2023 02:07:52 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F7D8759E
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 02:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5d21b9a5808so6486127b3.2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 17:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701220067; x=1701824867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NC2f3xkI7kkHdZU/XNX7vMMWSooY3/NfdKSY2BNvfc=;
 b=OoSibzHtxW3GIM1a2zq92xI3FZ4xKxONQgwP2P127GRHaJW7V/kE7zYX1Eew48fmMY
 CnTfCfjHGPiQLwm3p5ENi+/vJ4wAN5Brf8UmJgAB59H5XX+xSVbUqzQmbGUuVSi5HCcN
 j9iX12BsGVU/JwHLlZILMHoB+nQoeGG3iStgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701220067; x=1701824867;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NC2f3xkI7kkHdZU/XNX7vMMWSooY3/NfdKSY2BNvfc=;
 b=F4J4pcm+552IDXZmN0CG7fHPfyop6Fj+X/iSaY7lEn3Ka1TZHXkR+VUUkkEzrQidvN
 9ryaiyazjMJR90jB9pd1WQyt6dsbyZ38C1uwNvnzSTUTKb6F81ga4xAu0BTxw3S+Zfer
 jxlJXNP5ewd3p8mANU0LjqeVPqJa0rUguvGOkwdaLqr3bOMqiMa5fl0VL5E8nnmnNNyr
 zNNziRl3zFca18ek+dhDhdwrIG91z7BLV599IF+50lx3V26tCCIHm7fpBY/er+OWwd/S
 Bkt5mJpwC/UWbehbeInjJLWhdfwhYopSwG88aQjJWJepyITR84m0PEY+e4XhzI2um8PV
 98sA==
X-Gm-Message-State: AOJu0YyS98HqKCU3uQQXAdABSDdPderSZcEs7kblAIgJdTheETYhz3BP
 ldDaYRSatskNcDHIp/JdHZJiCA==
X-Google-Smtp-Source: AGHT+IHuXfs9a89cLuoIfWXPSZ0LR8F1j+FQR7GQVgiGl2rpAKsBvntNRpoXkCnDR9LqvxiYNg+rrg==
X-Received: by 2002:a05:690c:3383:b0:5d0:57a6:5f21 with SMTP id
 fl3-20020a05690c338300b005d057a65f21mr9507403ywb.2.1701220067721; 
 Tue, 28 Nov 2023 17:07:47 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a81df08000000b0059ae483b89dsm4187338ywn.50.2023.11.28.17.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 17:07:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Igor Prusov <ivprusov@salutedevices.com>
Cc: prusovigor@gmail.com, Simon Glass <sjg@chromium.org>, 
 kernel@sberdevices.ru, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Dahl <ada@thorsis.com>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Andy Fleming <afleming@gmail.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Chanho Park <chanho61.park@samsung.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>, Rick Chen <rick@andestech.com>, 
 Scott McNutt <smcnutt@psyent.com>, Stefan Roese <sr@denx.de>, 
 Thomas Chou <thomas@wytron.com.tw>, Wolfgang Denk <wd@denx.de>, 
 u-boot-amlogic@groups.io
In-Reply-To: <20231114110257.2488-1-ivprusov@salutedevices.com>
References: <20231114110257.2488-1-ivprusov@salutedevices.com>
Subject: Re: [PATCH 00/13] Import "string" I/O functions from Linux
Message-Id: <170122006592.601086.5973028773184530437.b4-ty@konsulko.com>
Date: Tue, 28 Nov 2023 20:07:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Mailman-Approved-At: Wed, 29 Nov 2023 02:11:39 +0100
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

On Tue, 14 Nov 2023 14:02:44 +0300, Igor Prusov wrote:

> This series imports generic versions of ioread_rep/iowrite_rep and
> reads/writes from Linux. Some cleanup is done to make sure that all
> platforms have proper defines for implemented functions and there are no
> redefinitions.
> 
> 
> Igor Prusov (13):
>   sandbox: move asm-generic include to the end of file
>   x86: Add defines for ins/outs functions
>   mips: io.h: Add const to reads functions params
>   mips: io.h: Add defines for read/write/in/out functions
>   riscv: io.h: Add defines for reads/writes functions
>   riscv: io.h: Fix signatures of reads/writes functions
>   nios2: io.h: Add defines for ins/outs functions
>   powerpc: io.h: Add defines for __raw_{read,write} functions
>   xtensa: io.h: Add defines for ins/outs functions
>   asm-generic: Import functions from Linux
>   spi: meson_spifc_a1: Switch to io{read,write}32_rep()
>   treewide: Include linux/io.h instead of asm-generic/io.h
>   musb-new: Remove implementation of io.h functions
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


