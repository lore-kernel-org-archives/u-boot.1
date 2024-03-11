Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1E2C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B5D87E13;
	Mon, 11 Mar 2024 14:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLvjOH0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A968787E64; Mon, 11 Mar 2024 13:34:06 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F3B87D0A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mokhtaaar1996@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4132cbe26a9so2803625e9.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710160444; x=1710765244; darn=lists.denx.de;
 h=subject:from:to:content-language:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hNOEvul3FmGlwQQtNAVtVezXp3wdD48eEdtQecEI8uU=;
 b=mLvjOH0ne5Tkdnl8jddPtBUFA6jzhvkyLBb9VANuRn3pDSI8ip+S7HmK3HKE8lpZLt
 Fu5vCg0blBlq/bvD6ZFokIDcU4Oa0s04DFMT0O2HgsR0dEY3ZUNzsGQGY7bpWxZYXlRi
 6nvnCwo80Ddtfx3Lp2d466h3vTQW1CfzzE5Ur10D1vq0aIHRS1SrXcfG/X+vVV6+fZgj
 hJVyQjdRu+MOKsTKiH1lzCvPAooQjv2p2PlWpkkQVOMr/+Xj/Jz+3OsInEKOK/5K4I+8
 0O/uKZO00+5IrKiWharbFL3XIMb/8erqCHNclM+c4T+ugzLIVFBcalP5999jBmB7xvDY
 WNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710160444; x=1710765244;
 h=subject:from:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hNOEvul3FmGlwQQtNAVtVezXp3wdD48eEdtQecEI8uU=;
 b=UcXACUqY26+yg6LtQekBcjpC5h/ZWkLzRXGHMbj0sUFg/L78RcgxetaQSVptKy1RCa
 FTrci8GwSHC60ck5TO/qI47m6qzCBKHW3obbLMyHEAXVbdGFtzXjqSC3rC2/yydM03n3
 2h1ySE0J9XLQzvvb+PWYckcSF+27xddI2xEImGSXCgDrIzyT3PoejPqrWIzT1hvu0CYI
 M1J5vENWN3CdzOTKcEK9cuyZmxV6/GnEzHbq10K6vqmOyv7PBWmrjezFsTx90Gqt2R2K
 OUHMq8nir9p1Q3U7m0qX1mVFCwPUSmQNvDnjpKYG+RCdydtwWUSrlrnRy2WAVzUrxLuo
 SRIw==
X-Gm-Message-State: AOJu0YyD3a/Ef3BKOvJab2XPJRLF4Od3xZaiiBA9PLBhmHu0ATH2AW9t
 H1AbgHRZzPdhphvJa6e+7KrGx1flMc2gdYKEihetR8XWvjQfKrpetqqB+OazSw==
X-Google-Smtp-Source: AGHT+IHXgu9gmKBkRxwCkIi1o+4Uw1N5aSgC/OghHnbXsazlOg5kYwxD7lUdDdZ0FoE1PN0i8QpJng==
X-Received: by 2002:a05:600c:1d95:b0:413:2fb3:190e with SMTP id
 p21-20020a05600c1d9500b004132fb3190emr421663wms.5.1710160443403; 
 Mon, 11 Mar 2024 05:34:03 -0700 (PDT)
Received: from [192.168.3.101] ([41.224.59.78])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b00412b4dca795sm8992786wmo.7.2024.03.11.05.34.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 05:34:03 -0700 (PDT)
Message-ID: <4e511ee6-6e9f-4a19-99b0-a6aec0e1c36a@gmail.com>
Date: Mon, 11 Mar 2024 13:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: Ahmed Mokhtar <mokhtaaar1996@gmail.com>
Subject: Issue with Enabling CONFIG_NETCONSOLE in Boot-loader
X-Mailman-Approved-At: Mon, 11 Mar 2024 14:06:01 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello Team,

I hope this email finds you well. I'm currently facing an issue with 
enabling the CONFIG_Netconsole flag under the bootloader. Despite 
CONFIG_NETCONSOLE being already enabled in the build system, I'm 
encountering difficulties in getting it to work.

Here's what I've tried so far:

 1. Enabled CONFIG_NETCONSOLE in the build system.
 2. Set the environment variables as follows:
      * |setenv nc 'setenv stdout nc;setenv stdin nc'|
      * |setenv ncip 192.168.1.1|
 3. Saved the environment using |saveenv|.
 4. Executed |run ncc|.

However, I encountered the following errors:

|## Error inserting "stdout" variable, errno=22 ## Error inserting 
"stdin" variable, errno=22 |

Upon checking the environment variables using |printenv|, I see that the 
|stdout|, |stdin|, and |stderr| variables are set to |serial@ff812000|. 
Here's the relevant part of the environment:

|tderr=serial@ff812000 stdin=serial@ff812000 stdout=serial@ff812000 |

I'm seeking your assistance in resolving this issue. Any guidance or 
solutions would be greatly appreciated.

Thank you for your attention to this matter.

Best regards, Ahmed


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

=> setenv nc 'setenv stdout nc;setenv stdin nc'
=> setenv ncip 192.168.1.1
=> saveenv
Saving Environment to NVRAM... OK
=> run ncc
## Error inserting "stdout" variable, errno=22
## Error inserting "stdin" variable, errno=22


=> printenv
arch=arm
baudrate=115200
board=v14
board_name=v14

bootcmd=secure_boot
bootcount=1
bootdelay=2
bootlimit=3
cpu=armv8
env_boot_magic=8192

fdtcontroladdr=6fcdffa0
initrd_high=0xffffffffffffffff
loadaddr=0x1000000
ncc=setenv stdout ncc;setenv stdin ncc
nccip=192.168.1.1
nummacaddrs=10
rootfs_opts=root= rdinit=/sbin/init
silent=yes
soc=bcm4912
stderr=serial@ff812000
stdin=serial@ff812000
stdout=serial@ff812000
u-boot-mode=nominal
uboot-prestage-version=U-Boot TPL 2019.07 (Feb 16 2023 - 15:59:27 +0800)
vendor=arcadyan

Environment size: 597/16380 bytes







=> version
U-Boot 2022.07 (Jun 15 2023 - 20:18:39 +0000)

aarch64-buildroot-linux-gnu-gcc.br_real (Buildroot 
bcm9xxx-linux-4.19-gcc-10.3-glibc-2.32_v1.0.0) 10.3.0
GNU ld (GNU Binutils) 2.36.1

