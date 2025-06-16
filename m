Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D46DC71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 905A780C93;
	Mon, 16 Jun 2025 09:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gm0Uiwws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7076C82B18; Mon, 16 Jun 2025 09:58:43 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 353B48007D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad574992fcaso646396266b.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750060721; x=1750665521; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adqURWmFUz3ql4VX+MSABMbWdkjyDHtGHWKBp48oUo0=;
 b=Gm0UiwwsIGQCwCn8DsMDr4EcLvbrEWy69Ur1rYXuddWnLh2IZWX9lqV0O0e02H8Isw
 0xY0SC3UVOni1SAkIkdpkCSCbXQnZzyffNHmqCxp0FXoEDgTDd75GhSQKhSSkgId/EvU
 zhLOM4hkO4xC5E/9bk294h1+kG/TPNRS+3/YbOD7EszgzYpPH98i/CqbZIHhpxcejkUQ
 Xr1mBO1IX8oeOZms15KtfvQbinLPZyYH4ssMLSIFCsRz0jtRspzNnXh4KS+1flHJKWBp
 freMRO6huXMy84112O2NEoh2g4DNGqe5ce0ZEgeaPcOYhGYhbzJkbdhijHTI7QgfR2Gr
 siVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750060721; x=1750665521;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=adqURWmFUz3ql4VX+MSABMbWdkjyDHtGHWKBp48oUo0=;
 b=jhOjhQijVzUg28yZV3/VKpWwbaRdpGEBFxMRp+FbVwG2NDqjy+h1bzCfywWANoqzfm
 gqypdDj+uy7fgmLWp4F3qN7SmCE5ZzvsCwh/H7wakNvgV34sPL2gd3bbXgqhXkj8cGgL
 zY5UJXNI/7v5lvW00zG464PwIPDsgAI26ePpm3BdwsJ56RS6IVLoY+kJxCtVIqLm9E5S
 NK7g+pXhZ6vrH+wR+VY9DxfAqW9PTmDIHRnslGxK3rPS2meRwC3KtFMilrPYxU/FdgEd
 nt9EeY26zpB9FdiJaDBi4FiWt7b+OWEEj40NPwnEYE8eSJmlQ6DyL4BtvQqF3h5YCJcn
 YePQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqEk7pOBARIMp2HXJWQADv+80H46OZjjic7sImBx0DxTXxnGzDz/2ROg8PcZXLm31SOn5KcGI=@lists.denx.de
X-Gm-Message-State: AOJu0YyxqVN1KMhw7eNbzDDvTmy+6PevaCKppUrXKxxNr3k7Nx2+drXw
 FLSXfI6rgRzh08Co9XHEtbsSwrYAmLSQs4arOsbw6Aj5Yw/keJ19L7OE/ih0ERUqrvQ=
X-Gm-Gg: ASbGncswWy3DzMWyujZZ81aCEirSAlmywfeamIi9348tuEYWf8lr1KMXnHwKC0ABWgN
 GkjQz31/yBoNVXuMLCv2x0fJToOj+zeSoVa/EWunwJzHejy6yAfkqfE29udE14dPHY7OtmVFUqA
 lNlklTI8UKIZci1mY6QfJo2cDuN7pxZDVrz9s3jdHQejIiz84joRLW/hfDGRU8ggU638K+6pT6r
 rYVdK5wTVvt1mRrPSBHdmn9FSW1iEpp28eTERoYxyIhdjpWwpL9K4lwHDXYT2KZrq1eYwsy+2TJ
 qcJG1M2P6KFGwA3LwNBHj1gJlhVxMg6rY7tJMHFx0FhVNoxGwiasErC3fYhRcFzDuoMM7higKW9
 O/zbBzRPUEfmi8Z4tNs2o0CMD
X-Google-Smtp-Source: AGHT+IGunW9n428BcX3By2eFbiGpVH+j06tDu3UIvfc1e2+x8se8R9wopgyZ05TAOhtaXRJSNK7QtQ==
X-Received: by 2002:a17:907:9494:b0:ad5:61fb:265 with SMTP id
 a640c23a62f3a-adfad469e66mr706580566b.47.1750060720597; 
 Mon, 16 Jun 2025 00:58:40 -0700 (PDT)
Received: from localhost (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-608b4a94ce7sm5570185a12.58.2025.06.16.00.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 00:58:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Jun 2025 10:58:38 +0300
Message-Id: <DANSQZCQZFP8.2F1XGDRJBHZIB@linaro.org>
To: "Jerome Forissier" <jerome.forissier@linaro.org>, "U-Boot mailing list"
 <u-boot@lists.denx.de>
Cc: "Mikko Rapeli" <mikko.rapeli@linaro.org>, "Andre Przywara"
 <andre.przywara@arm.com>, "Bin Meng" <bmeng.cn@gmail.com>, "Marek Vasut"
 <marex@denx.de>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [RFC PATCH v1] usb: xhci: fix crash with arm64 QEMU and KVM
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.20.0
References: <20250610121803.3111973-1-jerome.forissier@linaro.org>
In-Reply-To: <20250610121803.3111973-1-jerome.forissier@linaro.org>
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

Hi Jerome,

On Tue Jun 10, 2025 at 3:17 PM EEST, Jerome Forissier wrote:
> Add a xhci_flush_cache() call to xhci_start() to fix the following
> issue when running arm64 QEMU with KVM support (on a arm64 host):
>
>  $ make qemu_arm64_defconfig
>  $ sed -i 's/CONFIG_BLOBLIST=3Dy/# CONFIG_BLOBLIST is not set/' .config
>  $ make -j$(nproc)
>  $ qemu-system-aarch64 -machine virt -cpu host -enable-kvm -nographic \
>                        -bios u-boot.bin \
>                        -device qemu-xhci -device usb-kbd
>  U-Boot 2025.07-rc4 (Jun 10 2025 - 12:00:15 +0000)
>  [...]
>  Register 8001040 NbrPorts 8
>  Starting the controller
>  "Synchronous Abort" handler, esr 0x96000010, far 0x10100040
>  elr: 000000000005b1c8 lr : 000000000005b1ac (reloc)
>  elr: 00000000476fc1c8 lr : 00000000476fc1ac
>  x0 : 0000000010100040 x1 : 0000000000000001
>  x2 : 0000000000000000 x3 : 0000000000003e80
>  x4 : 0000000000000000 x5 : 00000000477a5694
>  x6 : 0000000000000038 x7 : 000000004666f360
>  x8 : 0000000000000000 x9 : 00000000ffffffd8
>  x10: 000000000000000d x11: 0000000000000006
>  x12: 0000000046560a78 x13: 0000000046560dd0
>  x14: 00000000ffffffff x15: 000000004666eed2
>  x16: 00000000476ee2f0 x17: 0000000000000000
>  x18: 0000000046660dd0 x19: 000000004666f480
>  x20: 0000000000000000 x21: 0000000010100040
>  x22: 0000000010100000 x23: 0000000000000000
>  x24: 0000000000000000 x25: 0000000000000000
>  x26: 0000000000000000 x27: 0000000000000000
>  x28: 0000000000000000 x29: 000000004666f360
>
>  Code: d5033fbf aa1503e0 5287d003 52800002 (b8004401)
>  Resetting CPU ...
>
> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
> This is sent as an RFC because I am really not sure what is happening
> here. Is this the proper thing to do? xhci_flush_cache() or
> xhci_inval_cache()? Where exactly? Which size?
>
>  drivers/usb/host/xhci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 3ee1f67190f..7c5a898cf3d 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -159,6 +159,7 @@ static int xhci_start(struct xhci_hcor *hcor)
>  	int ret;
>
>  	puts("Starting the controller\n");
> +	xhci_flush_cache((uintptr_t)&hcor, sizeof(hcor));


So this is kind of random. It's not the cache flush it self that is needed.
We just have to make sure that code which causes a hypervisor exception doe=
s
not use instructions that modify both registers.
I've posted [0] that fixes this

[0] https://lore.kernel.org/u-boot/20250616075035.1144220-1-ilias.apalodima=
s@linaro.org/T/#u

Cheers
/Ilias
>  	temp =3D xhci_readl(&hcor->or_usbcmd);
>  	temp |=3D (CMD_RUN);
>  	xhci_writel(&hcor->or_usbcmd, temp);

