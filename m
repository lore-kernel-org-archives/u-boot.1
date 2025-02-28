Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F34C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 08:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E8C808B6;
	Fri, 28 Feb 2025 09:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MSpSwElk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF00680FAA; Fri, 28 Feb 2025 09:00:40 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A68BE807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 09:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=blemouzy.ml@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4399ee18a57so11608615e9.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 00:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740729638; x=1741334438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJ9/44u3IneecLKX0xyZAiBceM2U7BBKx4BLauDR2vs=;
 b=MSpSwElkg/Pl/BrO7LBdt3z0USrkt1jWDIe8rIr/ARhnghvdGwYVWOLTs4lSOuNjiO
 GNmI5JXheydTgpnm2vhFuA+Hs5kifTNDnSfs4Mu78pS2Y6rWU6zylL6vE+xMW/ccqAX7
 A2E+XehkGTQkmRPmXlE+VsL9GlJHk6VjYg2dS74Xsa8+3PgMORFgvo83/9tHMMo0E4qL
 NOJLVHVWudFIGXKR3UQB1JwkL6NOf3ICxRF9wqjT4AwEbZHr9495vSj4f1cbYioMDwFX
 27My62/HssSFVu0+XDt3GoVHwFJqsAIAAJtAOUUeo603Tslzoidt+pG4aRstHviP4R9R
 2UPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740729638; x=1741334438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJ9/44u3IneecLKX0xyZAiBceM2U7BBKx4BLauDR2vs=;
 b=HhuJ6+5Auvq5BtLdYknspogfT2GdlIDhRPjCRzOPfiTXvu92i7falrrn3TNEUDeYnx
 6NrS5/tRFsCVxcmba5+O+ZZArZihuqeQKhWWqMXcT9j0u5lA7e8ts/T1DsUZyaGfyJow
 2BkaPzovE+xYSydR9JgeU598oVSa0X/A2bVPmLi78oGlPKfPftfiuhXIjzvACrIyt+zA
 uM3HmNYKhtNHsXfgxslLEQxn6o4zEjP0DgA2E/JZmAq0vyyM7NdqYEyUYS9fWu+9qkKI
 JqA15UYqFT4nCe6Tlh5hhvzHMYtwEx4qLfyrbODITocUaFquNtYDt1Ty+TkQBcDuS+sP
 HKUw==
X-Gm-Message-State: AOJu0Yzeio4hih1i20cSmYQYIfXHB9cGzws9QMRQrWiKmo8wD3uW8U4M
 ZgIgBxbizoYeoaLhxnSDmWSScXuGLPjcHs590ZdAqJLFx2vrODe2
X-Gm-Gg: ASbGnctStnGlv06IxiosdFwdbvjX5NN0OysZUp8O86kBhxQ7/G8rkUQrnJtp2VZ2Dr3
 cnfbXytSvejF5sC6sN3icr50wnpUDKJwGl6QDax/jrPkCkq3oJJQixChI1GehvnsqVBuIzo7lic
 sUAwsxuBBbYiUqCAyEj8w50H+xyEm0qEmTcUvGAR0gKCHpbl/wX403e30Bzb5BSlrJfKpIicpdd
 Ic2ntI2l0uviYjLuTiJDwtWO3cc3sxoW6+cWwE7bN5f5KEM3RQj3qBxO2My6AdXqQsEh730PuXI
 HdvwAY2zkGjmphONayITcZFMkKI=
X-Google-Smtp-Source: AGHT+IGOsAaAvwmDA1M1WQGBgVGzE7xZS6znOnP66xeSua5XYmK+5kKqYmBTkP2Hs6MovCi9BA94PQ==
X-Received: by 2002:a05:600c:4fc2:b0:439:873a:1114 with SMTP id
 5b1f17b1804b1-43ba624af40mr17102515e9.6.1740729637607; 
 Fri, 28 Feb 2025 00:00:37 -0800 (PST)
Received: from localhost ([2a01:e0a:10a:44e0:93c5:f3b0:4ae5:83bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7a27abd6sm46761075e9.26.2025.02.28.00.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 00:00:37 -0800 (PST)
Date: Fri, 28 Feb 2025 09:00:28 +0100
From: Benjamin Lemouzy <blemouzy.ml@gmail.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, gaurav.jain@nxp.com, trini@konsulko.com, Benjamin
 Lemouzy <blemouzy@centralp.fr>
Subject: Re: [PATCH] crypto: fsl_hash: fix flush dcache alignment in
 caam_hash()
Message-ID: <20250228090028.6fd81ea9@gmail.com>
In-Reply-To: <20250228041756.GB30605@nxa18884-linux>
References: <20250221070501.19472-1-blemouzy@centralp.fr>
 <20250228041756.GB30605@nxa18884-linux>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Peng,

On Fri, 28 Feb 2025 12:17:56 +0800
Peng Fan <peng.fan@oss.nxp.com> wrote:

> Hi Benjamin,
> 
> On Fri, Feb 21, 2025 at 08:05:01AM +0100, blemouzy.ml@gmail.com wrote:
> >From: Benjamin Lemouzy <blemouzy@centralp.fr>
> >
> >Loading a FIT kernel image with hash hardware acceleration enabled
> >(CONFIG_SHA_HW_ACCEL=y) displays the following CACHE warning:  
> 
> Sorry for my lazyness, the following patch should be able to solve
> your issue. I will prepare a PR soon.
> https://patchwork.ozlabs.org/project/uboot/patch/1bd862e53b50825f6030bf9f212127c776fff881.camel@googlemail.com/

I just tested the suggested patch and it's not working:

	## Loading kernel from FIT Image at 16000000 ...
	   Using 'conf-imx6q-xxx.dtb' configuration
	   Trying 'kernel-1' kernel subimage
		 Description:  Linux kernel
		 Type:         Kernel Image
		 Compression:  uncompressed
		 Data Start:   0x16000128
		 Data Size:    7600544 Bytes = 7.2 MiB
		 Architecture: ARM
		 OS:           Linux
		 Load Address: 0x10008000
		 Entry Point:  0x10008000
		 Hash algo:    sha256
		 Hash value:   a664f6c4d4ac97e2d867b8ee4f38cf934a48f99c65f19f824162b7ca077cb0d9
	   Verifying Hash Integrity ... sha256+ OK
	## Loading ramdisk from FIT Image at 16000000 ...
	   Using 'conf-imx6q-xxx.dtb' configuration
	   Trying 'ramdisk-1' ramdisk subimage
		 Description:  ctp-image-base-initramfs
		 Type:         RAMDisk Image
		 Compression:  uncompressed
		 Data Start:   0x1676d6d4
		 Data Size:    12635898 Bytes = 12.1 MiB
		 Architecture: ARM
		 OS:           Linux
		 Load Address: 0x13000000
		 Entry Point:  unavailable
		 Hash algo:    sha256
		 Hash value:   e1fe9087261f33679b95cd82b387317fa31b58f6365406fad1df1f27d46923e9
	   Verifying Hash Integrity ... sha256CAAM was not setup properly or it is faulty
	 error!
	Bad hash value for 'hash-1' hash node in 'ramdisk-1' image node
	Bad Data Hash
	Ramdisk image is corrupt or invalid

Benjamin

> Thanks,
> Peng
> >
> >    [...]
> >    Trying 'kernel-1' kernel subimage
> >    [...]
> >    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
> >range [16000128, 1673fae8]
> >    [...]
> >    Trying 'ramdisk-1' ramdisk subimage
> >    [...]
> >    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
> >range [1676d6d4, 1737a5d4]
> >    [...]
> >    Trying 'fdt-imx6q-xxx.dtb' fdt subimage
> >    [...]
> >    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
> >range [1673fbdc, 1674b0dc]
> >    [...]
> >
> >This patch fixes it.
> >
> >Tested on:
> >- i.MX 6 custom board
> >- LS1021A custom board
> >
> >Signed-off-by: Benjamin Lemouzy <blemouzy@centralp.fr>
> >---
> > drivers/crypto/fsl/fsl_hash.c | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/crypto/fsl/fsl_hash.c
> >b/drivers/crypto/fsl/fsl_hash.c index 79b32e2627..b721c86609 100644
> >--- a/drivers/crypto/fsl/fsl_hash.c
> >+++ b/drivers/crypto/fsl/fsl_hash.c
> >@@ -183,6 +183,7 @@ int caam_hash(const unsigned char *pbuf,
> >unsigned int buf_len,
> > {
> > 	int ret = 0;
> > 	uint32_t *desc;
> >+	unsigned long pbuf_aligned;
> > 	unsigned int size;
> > 
> > 	desc = malloc_cache_aligned(sizeof(int) *
> > MAX_CAAM_DESCSIZE);
> >@@ -191,8 +192,9 @@ int caam_hash(const unsigned char *pbuf,
> >unsigned int buf_len,
> > 		return -ENOMEM;
> > 	}
> > 
> >-	size = ALIGN(buf_len, ARCH_DMA_MINALIGN);
> >-	flush_dcache_range((unsigned long)pbuf, (unsigned long)pbuf
> >+ size);
> >+	pbuf_aligned = ALIGN_DOWN((unsigned long)pbuf,
> >ARCH_DMA_MINALIGN);
> >+	size = ALIGN(buf_len + ((unsigned long)pbuf -
> >pbuf_aligned), ARCH_DMA_MINALIGN);
> >+	flush_dcache_range(pbuf_aligned, pbuf_aligned + size);
> > 
> > 	inline_cnstr_jobdesc_hash(desc, pbuf, buf_len, pout,
> > 				  driver_hash[algo].alg_type,
> >-- 
> >2.43.0
> >  

