Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854F3C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 10:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D1587EDC;
	Mon, 22 Jul 2024 12:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="qQMJcFCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D82F87E50; Mon, 22 Jul 2024 12:10:05 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86EDD87EFA
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 12:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a77bf336171so664683666b.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 03:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1721643003; x=1722247803;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gwby0DLx207A3u/XK1S0AmzJBsrVAaYH6t9rwQAzl1k=;
 b=qQMJcFCw0t9Lk41gpP7H30SCM3KiUBnaLwfv+/AX+JKtQ8eEeLPG+OCLfOqzMH3Nr+
 +e4hWT8YgbKHd50aLPh5L0BYBzTnfeL9hZ30PH1iXUjtC3GftGOysAobL/VBTHt1bUPG
 k1nZ+CL0ykSTQunYxo/ev4NK77xBGTNhXNSZ6jxb9kfqeaQfXWZZy6q3zmdHCnqHgPJU
 tnB92k3C30tjPshYSsKuSDQebNEnDNtsH+Hi8OQq5YkSUj8yZZm4XSj3x/0EgbtbVqdf
 E2+QQ13xN2EBWLtSpl2zq9sqz9vGHNHUi+0FiEm2oMSo8V/DTMcj9fhdnPOpmkb+9z6l
 mHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721643003; x=1722247803;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gwby0DLx207A3u/XK1S0AmzJBsrVAaYH6t9rwQAzl1k=;
 b=NrAZl5aoa1SNL/O/1xzzpXyJ8m/FKDVugnvPEBawshyWMt4SHottWDSkeQ/2Myk5dY
 yeOIcIedtsF3+ZJnQKscJDBXOXmM8BXOM2YG6QgUVarNv0wIm3TiAfin4cj61DzhGYUp
 cLwP2WkTVmHeYDx24ni5kaW7zFsCw72lEw0xy2AQB/VAlUwsAu3g5zLpsTL1j49LnpVi
 JoWxVyZ6ohCyPbybOAxbG121jZ2f6cCL59jP8hjzKJsySRMsPI9bTdugFpqiS1y7Qa7D
 iQBP5aGzCTiV/WtBvxT6TMO+MT/xp1LMO+cH6o2B+kqzoZey0C4FPB2BTikLOB96i0Fb
 p7pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlG1m16p3VPAKSZTDXt5e8M6l94jI7uVAQ3C0VBBI196usGEt7ffwc2azCVg0bkdVekpGVpfkSr6Nl+wp+DtbctOfzqA==
X-Gm-Message-State: AOJu0Ywr+R2giSArHsnJTtaSvEvhdd/2ER6PnJP717FPCoBNYOd8kvfL
 p/L0Pv3uG1pD6w7Yt9XfqT6HpPv2MvR7onfIm3MI47fleNUDIBzer6RuS3D8Lg==
X-Google-Smtp-Source: AGHT+IEv0O1XDS1Zm2Y24+orwH3tQjWdVrM9HeYEwH6lfghYIFT2ZEQrEsytym+pGD3kTNo7D36x5Q==
X-Received: by 2002:a17:906:d555:b0:a77:ba4d:a4ea with SMTP id
 a640c23a62f3a-a7a41c921e1mr663623566b.23.1721643002925; 
 Mon, 22 Jul 2024 03:10:02 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c91caabsm412641366b.143.2024.07.22.03.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 03:10:02 -0700 (PDT)
Message-ID: <d81aa73b-9d23-4cd6-b078-2090b5d27bb5@monstr.eu>
Date: Mon, 22 Jul 2024 12:10:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/40] drivers: fpga: Remove duplicate newlines
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
 <20240720124239.7553-12-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20240720124239.7553-12-marek.vasut+renesas@mailbox.org>
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



On 7/20/24 14:40, Marek Vasut wrote:
> Drop all duplicate newlines. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
>   drivers/fpga/ACEX1K.c   | 1 -
>   drivers/fpga/fpga.c     | 1 -
>   drivers/fpga/ivm_core.c | 1 -
>   drivers/fpga/lattice.c  | 1 -
>   drivers/fpga/spartan2.c | 2 --
>   drivers/fpga/spartan3.c | 2 --
>   6 files changed, 8 deletions(-)
> 
> diff --git a/drivers/fpga/ACEX1K.c b/drivers/fpga/ACEX1K.c
> index cb7877a8afe..3de9011ac06 100644
> --- a/drivers/fpga/ACEX1K.c
> +++ b/drivers/fpga/ACEX1K.c
> @@ -79,7 +79,6 @@ int ACEX1K_info( Altera_desc *desc )
>   	return FPGA_SUCCESS;
>   }
>   
> -
>   /* ------------------------------------------------------------------------- */
>   /* ACEX1K Passive Serial Generic Implementation                                  */
>   
> diff --git a/drivers/fpga/fpga.c b/drivers/fpga/fpga.c
> index 38ba6c21ea2..1f6782537de 100644
> --- a/drivers/fpga/fpga.c
> +++ b/drivers/fpga/fpga.c
> @@ -30,7 +30,6 @@ static void fpga_no_sup(char *fn, char *msg)
>   		printf("No FPGA support!\n");
>   }
>   
> -
>   /* fpga_get_desc
>    *	map a device number to a descriptor
>    */
> diff --git a/drivers/fpga/ivm_core.c b/drivers/fpga/ivm_core.c
> index b9cecdd8720..3c9a01e5110 100644
> --- a/drivers/fpga/ivm_core.c
> +++ b/drivers/fpga/ivm_core.c
> @@ -580,7 +580,6 @@ void ispVMFreeMem(void)
>   	}
>   }
>   
> -
>   /*
>    *
>    * ispVMDataSize
> diff --git a/drivers/fpga/lattice.c b/drivers/fpga/lattice.c
> index 036580cad70..3f481e38565 100644
> --- a/drivers/fpga/lattice.c
> +++ b/drivers/fpga/lattice.c
> @@ -35,7 +35,6 @@ extern unsigned short g_usIntelDataIndex;
>   extern unsigned short g_usIntelBufferSize;
>   extern char *const g_szSupportedVersions[];
>   
> -
>   /*
>    * ispVMDelay
>    *
> diff --git a/drivers/fpga/spartan2.c b/drivers/fpga/spartan2.c
> index 9cd6cb7f0fb..906649ea181 100644
> --- a/drivers/fpga/spartan2.c
> +++ b/drivers/fpga/spartan2.c
> @@ -85,7 +85,6 @@ static int spartan2_info(xilinx_desc *desc)
>   	return FPGA_SUCCESS;
>   }
>   
> -
>   /* ------------------------------------------------------------------------- */
>   /* Spartan-II Slave Parallel Generic Implementation */
>   
> @@ -285,7 +284,6 @@ static int spartan2_sp_dump(xilinx_desc *desc, const void *buf, size_t bsize)
>   	return ret_val;
>   }
>   
> -
>   /* ------------------------------------------------------------------------- */
>   
>   static int spartan2_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
> diff --git a/drivers/fpga/spartan3.c b/drivers/fpga/spartan3.c
> index b4d87d47d93..98405589134 100644
> --- a/drivers/fpga/spartan3.c
> +++ b/drivers/fpga/spartan3.c
> @@ -91,7 +91,6 @@ static int spartan3_info(xilinx_desc *desc)
>   	return FPGA_SUCCESS;
>   }
>   
> -
>   /* ------------------------------------------------------------------------- */
>   /* Spartan-II Slave Parallel Generic Implementation */
>   
> @@ -293,7 +292,6 @@ static int spartan3_sp_dump(xilinx_desc *desc, const void *buf, size_t bsize)
>   	return ret_val;
>   }
>   
> -
>   /* ------------------------------------------------------------------------- */
>   
>   static int spartan3_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

