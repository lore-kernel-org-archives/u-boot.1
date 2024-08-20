Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AC1C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 14:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E6B688A46;
	Tue, 20 Aug 2024 16:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GVLu+E3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E300488A5F; Tue, 20 Aug 2024 16:29:28 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F6FB885FA
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 16:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7ab5fc975dso552345966b.1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724164166; x=1724768966; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F4KySPy2vHPaENgvDataLaVdYqYium2Ibbv/iK0dbNQ=;
 b=GVLu+E3o528D9aXIkKZ+dbvdFB4UrtuMTGUQaJWKlK9fP3q3le97tGjnyllHLUBgHb
 eOzmQewj0JoeObSvGinpW1gWoS+c5pn0QXM1UJImEAQ50luF0ok8aK8J7m15QCMNsdu5
 inNXuPjHt+HU1BJaVexAQSai3wxrx3TY+30NW71F32kssaoR6T5Wn0bi3kdf8pTh03IN
 t6ZlbI4CLYoi18Yhw2iCPatK7RYQD02V+WG9PSdyysyO+bwvg/NwpoUqvkovcGFe4bz5
 c7eUaYTsX5/dPsVffj/ccENGDXbalPtP1mgiDUz5zNPoAKxIeRmmkTQ1IK99Dma9Mazf
 ZqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164166; x=1724768966;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F4KySPy2vHPaENgvDataLaVdYqYium2Ibbv/iK0dbNQ=;
 b=kZ41ku8tA2YVW73wgrE40R/Pf6UVb7qKl8LpfkifOSCyw9NB+B0y+/shwS+vBbP7Zr
 lGgebV4HrsKUdhOZrMycRQMoAlWft6diCU/JQ/K0QpKV+xIjgsG6FMDLrAGHc9BM9CTJ
 GBVg+Tq0Hhehz14118VLrH6uAL0xGE8ejd6+MUZMy3jvGGhE0Kqsi4832V6SMHduGpds
 KmM04jiiIeaFPrUQjSxZ6nBNLjeUy8A9gsTOYOfdaBEC8wU4XKw9VLdIjlwF6qZOkDe+
 o4qiHYiuf3kBZFy8cmARxJtEsdwkeDzkxxsSi30a/IskZrlTrOITiwBrRHqEQFWehvo6
 ybhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQdLY9wRT9433JQzRMRrxN+GESKZlM6xLbEMYlwYS+6r4ZHE3UJPfN/dl1PN6qdA9BLVQe65c=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8n2e467tb7IiOOXNz2snyl8fIWWNVKfzi8AVmqlymjNRyvQaP
 qriXd90DXN6RSdU8jsNTLV84tTEoFS8TTbstM+AkAOjKJaqC2T47U2/drMkx2nWWhXuWc92hyed
 uels=
X-Google-Smtp-Source: AGHT+IGFtJwu5Bwkq6jH5AdDiTRTBWM/nomqJNxAXj8Wa6GciD5NH8I8eVHKjRqQ3JgBW+UKWiDehQ==
X-Received: by 2002:a17:907:e69e:b0:a7a:a2e3:3737 with SMTP id
 a640c23a62f3a-a8392931307mr1026840866b.28.1724164165543; 
 Tue, 20 Aug 2024 07:29:25 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::676e? ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383935909sm766356066b.112.2024.08.20.07.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 07:29:24 -0700 (PDT)
Message-ID: <311e1dd1-a887-461f-b984-bfc1807c63e6@linaro.org>
Date: Tue, 20 Aug 2024 16:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: u-boot on raspberry pi with secure boot
To: Jonas Kvinge <jonaski@opensuse.org>, u-boot@lists.denx.de
References: <b24ba149599b9e0261676110894d14a0f69eb6a2.camel@opensuse.org>
Content-Language: en-US
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <b24ba149599b9e0261676110894d14a0f69eb6a2.camel@opensuse.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Jonas,

On 19/08/2024 15:11, Jonas Kvinge wrote:
> Hi,
> 
> I have a custom installation of openSUSE Tumbleweed which uses u-boot
> and Grub.
> To use secure boot on the RPI, one creates a boot.img containing the
> kernel and other files which is signed, and the eeprom is locked to
> only allow booting with this signature.
> (https://github.com/raspberrypi/usbboot/blob/master/secure-boot-recovery/README.md
> ).
> Since I'm using u-boot, I'm creating a boot.img containing u-boot.bin
> instead of the linux kernel and ramdisk.
> But then nothing is locking down which kernel can boot, since that's
> controller by UEFI and Grub. u-boot starts Grub from the UEFI
> partition, and Grub starts the kernel from a separate /boot partition.
> And I see no way to change this
> I use a 3 partition setup where the partitions are 1. FAT UEFI
> partition, 2. Linux ext4 /boot partition, 3. Encrypted LUKS ext4 root
> partition.
> I've been looking into
> https://trac.gateworks.com/wiki/secure_boot#SecuringtheKernelFDTramdiskviaFITimages
> But is that possible to do with my current setup? Can I include grub
> and the kernel/initrd in the boot.img and make u-boot use that instead
> of from the UEFI partition?

I don't know the details of how this is implemented, but the way to 
solve this is by doing EFI secureboot in U-Boot. The trick is to embed 
the securebook public key hash into U-Boot, there it will be validated 
by the bootrom stage and can be trusted to validate the signed kernel EFI.

The kernel would then need to be booted as a "UKI" (refer to the uapi 
group uki docs), this embeds the kernel, ramdisk, and DTB into a single 
EFI image which can be signed and verified.

Hopefully this points you in the right direction.

Kind regards,
> 
> Jonas
> 

-- 
// Caleb (they/them)
