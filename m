Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7492D0D7BB
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 15:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C6189291;
	Fri, 11 Oct 2024 17:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oRWNClQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA4D389384; Fri, 11 Oct 2024 17:39:59 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65AD389085
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4311e470fdaso7211525e9.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728661197; x=1729265997;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ifhtpX2FWKYeMFuayx4+KN353bIWxGH8SpX81vEVpOw=;
 b=oRWNClQN+BK3jXm4/eW8u8NYd5qTMj6G32WrfDzNDPil36UNJwHz7U3O0EBfHEyC+q
 mdftkxvlaxW8+qKZwHqZ8blW85ITe4lo6sEaLoyuZGwLX1zXxE113s8acEV6mbfiS1xQ
 /tgNoDBq+9JxE5X6Gpa8abX7M1Dbfb7hWC3Vr+vMvOQS7vve1P7hvKJMHcFm8fwqKiZi
 +Mf6UCleX9Lf7mlC8LmNY74a7qTSDVp6uBpgAmtG4w5IbHGRMkzQIhMrtQ/BHGLSOhel
 UdO3rxFUE6dfdtuW+zuVghGsaZAT/+jeWahkvYvGLv/rKeDAGCiaUwUFXKvRUdEwn5g6
 +eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728661197; x=1729265997;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ifhtpX2FWKYeMFuayx4+KN353bIWxGH8SpX81vEVpOw=;
 b=Ov0NGJNCDvLwc6sHSTyulrZ/w5xs56MIbtINhmTp4tObB52HWp0eoxsC8K9ETZBF3A
 yEVvtGUg8bm9nwdjdVO4ah+l/eIQpVg5GYINoMqo3eh6U8NNvka1JbqFnl2nto+bGn9n
 D6Y4QeMCq01jS1juG29WPtqzM8qMXB8XIGNRXY44GHTFoEssVeMSEyGcV7opGDGohulu
 BAQDkmd98UKAFx006wmYaUw3+SuKNWInNG+77Sll6jtY7ek344ni4ZYvr6grrGd4K0U9
 bACkZdlWuNNp9lXDbdOVsk0tmLkwVgp95NeiyKpaoeMG1lr4/NTY+8sU2+Ty26d3yPkW
 +GiQ==
X-Gm-Message-State: AOJu0Yy5iJjVT5/W4LaBZPx8Fq/rQNsclekoNChTRtYXPloVr40a02OT
 ErJSWcMj1y4M1f9O6X6jHZ8vFjJX+5gchrdhYwA5Cn5hLUCQd313xJZCNkbxbQk=
X-Google-Smtp-Source: AGHT+IHR1GMwR2So/8n3IBFQYE1qisOvhOxV/oTe7+bCvv1bpXZptRf+ArV4Q8u8poQOlV28cfSRwg==
X-Received: by 2002:a5d:5105:0:b0:37c:cbd4:ec9 with SMTP id
 ffacd0b85a97d-37d5519997fmr2277452f8f.5.1728661196671; 
 Fri, 11 Oct 2024 08:39:56 -0700 (PDT)
Received: from localhost ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b917df3sm4199704f8f.111.2024.10.11.08.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:39:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Judith Mendez <jm@ti.com>, Joe Hershberger <joe.hershberger@ni.com>, Tom
 Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH] TI: include: env: ti_common: move fdtoverlay_addr_r to
 fix ramdisk size
In-Reply-To: <20241011000322.538287-1-jm@ti.com>
References: <20241011000322.538287-1-jm@ti.com>
Date: Fri, 11 Oct 2024 17:39:53 +0200
Message-ID: <87zfnafy2e.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Judith,

Thank you for sending this patch.

On jeu., oct. 10, 2024 at 19:03, Judith Mendez <jm@ti.com> wrote:

> From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> When booting Android with adtbo_idx set, we observe the
> following crash:

In upstream/master, this is no such thing as adtbo_idx.

This is only present in TI's U-Boot fork, via commit [1]

[1] https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04&id=1c6cf852b8b8f869d2c5e39eb071ec3025bf739a

>
>    ** Booting bootflow 'mmc@fa10000.bootdev.whole' with android
>    ## Booting Android Image at 0x82000000 ...
>    Kernel load addr 0x92000000 size 20195 KiB
>    Kernel extra command line: console=ttyS2,115200 cma=768M 8250.
> 	nr_uarts=10 printk.devkmsg=on init=/init quiet firmware_class.
> 	path=/vendor/firmware mem_sleep_default=deep bootconfig
>    RAM disk load addr 0x88080000 size 16901 KiB
>    "Synchronous Abort" handler, esr 0x96000005, far 0x155b104c8
>    elr: 0000000080808560 lr : 0000000080808558 (reloc)
>    elr: 00000000ffebf560 lr : 00000000ffebf558
>    x0 : 00000000fff99000 x1 : 00000000fff9553c
>    x2 : 000000000000000a x3 : 0000000002800000
>    x4 : 0000000002800000 x5 : 0000000000000020
>
> This happens because the memory at fdtoverlay_addr_r is bogus.
> In fact:
>
> => printenv fdtoverlay_addr_r
> fdtoverlay_addr_r=0x89000000
>
> And the ramdisk address range is:
> [0x88080000; 0x88080000 + 16901 KiB]
>
> Which is equal to:
> [0x88080000; 0x89101400]
>
> So, if we represent the addresses:
> fdtaddr             0x88000000
> ramdisk             0x88080000
> fdtoverlay_addr_r   0x89000000
> ramisk (end)        0x89101400
>
> We see that fdtoverlay_addr_r in fact has been overridden by
> the Android ramdisk.
>
> The maximum ramdisk size is 0x1080000 (15,5 MiB) and a compressed
> Android vendor ramdisk is 15MiB:
> $ file vendor_ramdisk.img
> vendor_ramdisk.img: LZ4 compressed data (v0.1-v0.9)
> $ du -sh vendor_ramdisk.img
> 15M     vendor_ramdisk.img
>
> When it gets decompressed, it uses 16.5MiB, exceeding the
> maximum ramdisk size.
>
> Increase the maximum ramdisk size to 20.5MiB by moving
> fdtoverlay_addr_r higher up in the address space to fix the crash.

I do think that reserving more room between the fdtoverlay_addr_r and
the ramdisk address is probably a good idea for Linux as well, but I
think that the commit message might need a rewrite ?

>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  include/env/ti/ti_common.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> index 7029d12bf20..a15af79d9c3 100644
> --- a/include/env/ti/ti_common.env
> +++ b/include/env/ti/ti_common.env
> @@ -3,7 +3,7 @@ kernel_addr_r=0x82000000
>  fdtaddr=0x88000000
>  dtboaddr=0x89000000
>  fdt_addr_r=0x88000000
> -fdtoverlay_addr_r=0x89000000
> +fdtoverlay_addr_r=0x89500000
>  rdaddr=0x88080000
>  ramdisk_addr_r=0x88080000
>  scriptaddr=0x80000000
>
> base-commit: a404065479be2c1fe1167c3c91367e8194a69d1b
> -- 
> 2.46.2
