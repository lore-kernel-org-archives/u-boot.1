Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A99C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 13:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5906987D82;
	Mon, 18 Mar 2024 14:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XkNFuokS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F258752B; Mon, 18 Mar 2024 14:58:40 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D6D87DBB
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 14:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-789f50b3e40so101270085a.1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710770317; x=1711375117; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LzeD1TWV2ywGltnXe+vJFHc8M5PW63asBLK+MVZiAc8=;
 b=XkNFuokSpekitValuMc4SWq7E8nBKK8TjZtynwyCNrOn/mYBNHjrJvImfFQnjcdHgL
 U1cWZuSMBMINWA32KGHyfwh82IuEvg+qcm2pjETw6EaCoLPAyvXE0LpN+cxpvF6c/hIO
 3IB1n/W90X1Yqb3bDaJK332+d90YnV0ddVNiHmpMbuiO9P59zZ3RhLtx+xIZAzFbym5b
 nqHPrnGzB//mJyTBpONEh9mQdEsrX8tAXjVuZUYNuSKdHd4iCMJCihQMVOPPxisJVfuX
 bpdoHC+VeC1iISKQe1bxN9XJm20KY5+59ziU9r6AmsqRbCP0iIGXavsUtm/pf+/+60Oj
 AEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710770317; x=1711375117;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LzeD1TWV2ywGltnXe+vJFHc8M5PW63asBLK+MVZiAc8=;
 b=i0iBZcXFa7Hw7dSkVUVOoD5Cz5FxbCctQGaQaPf7+RCIwAeIG0v3Y4/VXLBm6kMg43
 1kknfgTJt9XbFLn/YqayuyYB/PgZh0saqMCLQS6s0acSKOhSr6OoMTlEew/dc5dQlRM4
 u2VMMbHt3RIi/sYUVVMO3/2Th54DO3y8TCBqEXd50Flr/dpmBSfrmjG9hiuBP3DB62PP
 Q8WICLOzhKfNfsLM+0iuACj402UAgYKeUE563LaS+T/PcAxIbXtqumCSE2iIWXUkxiag
 u61t2EV0/fre/9pgSz7w6e460AraCe4PPIHbAE51hYo8AvG/RiZM7VjBnQgF7inzHH/J
 W53g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmNIXyh+7Ik0MFBrVplMVNXpTaWZ8UNmeIOOq15xxwRctuicprsIOFg0y4IN8ffexBjpOb3qtXB29RSUafAUdyvNihGg==
X-Gm-Message-State: AOJu0Ywt4zjeAU1LZ3j0t+qtqsVV46udIURN6pw1XCbu2RKVE7KJvCTf
 PgiTwdzD54w4LtR8HvjSMjYRclENSVAQQGB/KC+fqhZ36E84G5J9
X-Google-Smtp-Source: AGHT+IHqj/CjkyFDqnMr+0IYH/+e8ce3fcdW36qXSGSJupun6+47XgVNINvFtVG8FJyHlxKmx3KHfg==
X-Received: by 2002:a05:620a:1672:b0:789:ea35:4465 with SMTP id
 d18-20020a05620a167200b00789ea354465mr10725420qko.31.1710770316873; 
 Mon, 18 Mar 2024 06:58:36 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 rv8-20020a05620a688800b00789d9cd432csm4219062qkn.75.2024.03.18.06.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 06:58:36 -0700 (PDT)
Message-ID: <fd3fff48-a789-c3f1-6b06-1e5efa13deea@gmail.com>
Date: Mon, 18 Mar 2024 09:58:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] cmd: nand: Add support to print the manufacturer,
 model and size
Content-Language: en-US
To: Mihai Sain <mihai.sain@microchip.com>, trini@konsulko.com,
 sjg@chromium.org, u-boot@lists.denx.de, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com
References: <20240318134219.20040-1-mihai.sain@microchip.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240318134219.20040-1-mihai.sain@microchip.com>
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

On 3/18/24 09:42, Mihai Sain wrote:
> Add support to nand info for printing the manufacturer,model and size.
> The manufacturer and model are printed only for ONFI flashes.
> 
> U-Boot> nand info
> 
> Device 0: nand0, sector size 256 KiB
>    Manufacturer  MACRONIX
>    Model         MX30LF4G28AD
>    Device size        512 MiB
>    Page size         4096 b
>    OOB size           256 b
>    Erase size      262144 b
>    ecc strength         8 bits
>    ecc step size      512 b
>    subpagesize       4096 b
>    options       0x00004200
>    bbt options   0x00028000
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> 
> Changes in v2:
> --------------
> * use #ifdef directive for ONFI flashes.
> * use unsigned int for chipsize.
> ---
>   cmd/nand.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/cmd/nand.c b/cmd/nand.c
> index fe834c4ac5..5773246d64 100644
> --- a/cmd/nand.c
> +++ b/cmd/nand.c
> @@ -418,6 +418,11 @@ static void nand_print_and_set_info(int idx)
>   		printf("%dx ", chip->numchips);
>   	printf("%s, sector size %u KiB\n",
>   	       mtd->name, mtd->erasesize >> 10);
> +#ifdef CONFIG_SYS_NAND_ONFI_DETECTION
> +	printf("  Manufacturer  %s \n", chip->onfi_params.manufacturer);
> +	printf("  Model         %s \n", chip->onfi_params.model);
> +#endif
> +	printf("  Device size   %8u MiB\n", (unsigned int)(chip->chipsize >> 20));
>   	printf("  Page size     %8d b\n", mtd->writesize);
>   	printf("  OOB size      %8d b\n", mtd->oobsize);
>   	printf("  Erase size    %8d b\n", mtd->erasesize);

Can you refactor the logic out of the end of nand_detect as a separate
function and use that instead? That will cover more cases (e.g. JEDEC).

--Sean
