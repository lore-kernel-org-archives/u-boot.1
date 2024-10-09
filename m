Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBB9CEE359
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 22:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD6788CAE;
	Thu, 10 Oct 2024 00:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N+hmxpKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4BBF88D13; Thu, 10 Oct 2024 00:10:17 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B9388AE8
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 00:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fac9eaeafcso2661461fa.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 15:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728511815; x=1729116615; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SqkVFJ8PUS4R/bLHf9ZJAJ6wpSMwcyj5H6IHD+gGt8Q=;
 b=N+hmxpKZ18UnEOxWZw+xr/bcrlX3DvvXKakHX6Hup2rVYW1VEo7zuahJ+/x5QjicvP
 Hs88m4ekfou42UTRxFiAPMDLRxD7hvQzTx0TSILJ+Uip/d0r1ssrBIWqkf0pOOCNJGrt
 P6MkXEgxIh/4p9CDM3EzhW2uye+tmKsKBqJkbaB/DAU/4n/8kg3OoOp+xbvI9IARyQyG
 9EcB0EY2wj33Sq65t3WLXLuXNACifQIHU079OYUmR+ToHeySHi5ClfgxXYc1SMoPs6QT
 bdHXa/Me6EqdX9CkNa7vCYNFMzREPvfj8LkQenCudLzqMrPX38SK/EuzmqA33tApMr9s
 Ut1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728511815; x=1729116615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SqkVFJ8PUS4R/bLHf9ZJAJ6wpSMwcyj5H6IHD+gGt8Q=;
 b=f5BYHSZLmmntyYNdFDioMuFS0wdQrOFdNIAvNZJZB9C5v9aSUopaeIE0WcXCTQ871x
 2f08HOdVQwFbnbCBfKHMBw3LyOJmGtv90Mg21IkGXAXLlSwH0j2jSTnsuWlRH2w4k8H/
 zU23waMwH6TpXOknyvu3oPMiqxfPV8ubBRBVf9wPDI65IsPpDkVVFu3s0WYyeSKPirNS
 zRSNg76DAz1VOHKId/r2esGu1X+qZEaTys24jN3F3KSP8K6mVMv4HZi/zmiGydqWGs8s
 m4jYXBvue4WzjSQWFPoJhj76LmVA4w5e6l3CLRRAAV4RIEJUUU+x7ZxVWnxoI6Dj+MUp
 b39A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXumSFngyC9HiTIZTgxu0mQxoC6+8AEzlaiZpdZyGiN225ZI2j0RL7NlZEkFiJeLNaeo8i+eo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7vVLrclQcXXB33yA4J6yNm3nDrhtDO7Pg95G7mVaWjkQRpea0
 dBiURZ86ATa066m5bpnVFG2SYatAbWGfmIdUfpM3duOASSUHdE8EsRzH1MlSmfRSh7JkegWoRmj
 lSfpUpTbVY4TGpIm2iC7zIeHf+gk=
X-Google-Smtp-Source: AGHT+IHvztpuAQ81j/ulDWPBX/ILXaT9O6G/WEGYfNTnUbJSaliHcDECH3jIHaU1omyg9TKG6URdlcR82nmx2yZvRJE=
X-Received: by 2002:a05:651c:2208:b0:2fa:c4d4:ec44 with SMTP id
 38308e7fff4ca-2fb187ac4a8mr25215641fa.28.1728511814584; Wed, 09 Oct 2024
 15:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241009145703.1970034-1-p-mantena@ti.com>
In-Reply-To: <20241009145703.1970034-1-p-mantena@ti.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 9 Oct 2024 23:10:03 +0100
Message-ID: <CALeDE9O9STcttgbMe9NgLzaLJM97FVmXE5Ncb_Nc+W9d+tROAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Cleanup dma device in spl and move dma channel[0]
To: Prasanth Babu Mantena <p-mantena@ti.com>
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 u-boot@lists.denx.de, vigneshr@ti.com, u-kumar1@ti.com, n-francis@ti.com, 
 vaishnav.a@ti.com, s-k6@ti.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Prasanth,

> The channel allocation and deallocation for dma copy was happening on every
> dma transfer. This is a overhead for transactions like NAND, which does
> page reads recursively for complete data.
>
> So, moving the dma allocation to probe and implement corresponding
> remove function and cleanup dma device while exiting from spl.
>
> Enable SPL_DM_DEVICE_REMOVE, for device removal capability in SPL.
>
> v2 <==> v1
> ==========
> 1> Improve subject of commit.
> 2> Add warning on dma device not found.
> 3> Do channel allocation only for udma and bcdma. Passthrough for all other types.
>
> Prasanth Babu Mantena (2):
>   mach-k3: common.c: Remove dma device in spl exit
>   configs: k3: Enable device removal in SPL
>
> Santhosh Kumar K (2):
>   dma: ti: k3-udma: Move udma_probe() below all APIs
>   dma: ti: k3-udma: Move DMA channel[0] allocation to probe and add
>     udma_remove()
>
>  arch/arm/mach-k3/common.c        |  25 ++-
>  configs/am62ax_evm_a53_defconfig |   1 +
>  configs/am62ax_evm_r5_defconfig  |   1 +
>  configs/am62x_evm_a53_defconfig  |   1 +
>  configs/am62x_evm_r5_defconfig   |   1 +
>  configs/j7200_evm_a72_defconfig  |   1 +
>  configs/j7200_evm_r5_defconfig   |   1 +
>  configs/j721e_evm_a72_defconfig  |   1 +
>  configs/j721e_evm_r5_defconfig   |   1 +
>  configs/j721s2_evm_a72_defconfig |   1 +
>  configs/j721s2_evm_r5_defconfig  |   1 +
>  configs/j784s4_evm_a72_defconfig |   1 +
>  configs/j784s4_evm_r5_defconfig  |   1 +

Is there any reason why devices like j721e_beagleboneai64 and
m62x_beagleplay and other TI devices aren't changed as part of this
change?

Peter
