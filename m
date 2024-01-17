Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DB3C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 16:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88A3A87889;
	Wed, 17 Jan 2024 17:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TPRp7+Uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE358798F; Wed, 17 Jan 2024 17:42:00 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2D1B8753C
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 17:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7cc7bae27b5so4040821241.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705509717; x=1706114517; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sMS+qndjwO3GkEgbUuAL5ORYSYyl6U76aRTsVBa0f64=;
 b=TPRp7+UyZPG9jXhl+sn8+RzeGplWw1Np/l73Kpj6srf1IKl4Yy4CXWVdbr2bKRdMvb
 RCt2FB6npD8z/mUUCFrjdcSFvC8acv724PULHZxBoedHviyhBOZLN9+4tC4cSUEdfzhU
 P4uBI0i1OxPWhG8BIv+w0YcsJ87n8BFomgOSDwsXM4kL91a8734gqk7DNEhA8NUTvsEY
 Yea3ex4+Wvfu/A1ie0GgDCDkz1jSYJklyaADIy57iNOPb4L+LoayVpmcLMksJr/EE7UF
 xS/W/AwbFwC89YaMH15bfl/AVr68n/My6JVO+BMFyk3I4ukyNp1D52UWnHhp6N6cSoGy
 3z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705509717; x=1706114517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sMS+qndjwO3GkEgbUuAL5ORYSYyl6U76aRTsVBa0f64=;
 b=XgsQaYx35oTstnKD2MSMDo3CbjqHblFCMjr9fxOAH7oEDw5NHYidA8NyssJ2v5q6PE
 r5/KrsO4Fg5GqQCvKhrYC5s2jPN+Fe/t/wbQn55fsswOM4BOhZgBP3lAZquKddEdYaNe
 Zg4aAulK0VMSnuMXs6ao2kGtgCSNjBq3NOhQa082EikElpsIli7RMCRr00uEIfmkAtdw
 G3l2DJB9X7ahwIUdd2lpI+3dGNZJz1kePJ0MN809zagdEXseqPr+TzPoZbG8gL6HSPEe
 M9OAxK9nYO7FG2EK9oAqsb1cFg7XHHpEdgxPOAWV1BN5568DS7HTXC1GeH+RZ4JRaK5j
 0sWQ==
X-Gm-Message-State: AOJu0Yz+27fSOuUL59TlUlc7HmRZOK2gxH+mNY7GLrGVOJk6h4uQL5i1
 +KGnahSq+f+pUcGmZ4Tk8+g=
X-Google-Smtp-Source: AGHT+IE9Vm9K6tTtfyLapTDo4g2TsxmjTCBDW2cZ8/EZwLFs773tfqeIywo/E7otZ/F+rK4mWxnnzQ==
X-Received: by 2002:a67:eacb:0:b0:467:48c8:840d with SMTP id
 s11-20020a67eacb000000b0046748c8840dmr5311374vso.38.1705509717413; 
 Wed, 17 Jan 2024 08:41:57 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 ne1-20020a056214424100b006815bb6f6fesm2877306qvb.97.2024.01.17.08.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 08:41:57 -0800 (PST)
Message-ID: <d08e3874-b6d3-7b8a-20e8-5f75d9c80dd8@gmail.com>
Date: Wed, 17 Jan 2024 11:41:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mtd: nand: Print warning for unsupported ecc modes
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 michal.simek@amd.com, git@xilinx.com,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20240117040822.1031992-1-venkatesh.abbarapu@amd.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240117040822.1031992-1-venkatesh.abbarapu@amd.com>
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

On 1/16/24 23:08, Venkatesh Yadav Abbarapu wrote:
> Currently only hw ecc is supported in U-Boot. If any other ecc mode is
> given in DT, it simply ignores and switches to hw ecc. So better print
> what is being done.

This is not true? Sandbox for example uses soft ECC (hamming and BCH).

--Sean

> Revert this patch once soft ecc support is fixed in future.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/mtd/nand/raw/nand_base.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index c40a0f23d7..200f7f8ba0 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4463,6 +4463,9 @@ static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip, ofnode nod
>   
>   	str = ofnode_read_string(node, "nand-ecc-mode");
>   	if (str) {
> +		if (strcmp(str, "hw"))
> +			printf("%s ecc is not supported, switching to hw ecc\n", str);
> +
>   		if (!strcmp(str, "none"))
>   			ecc_mode = NAND_ECC_NONE;
>   		else if (!strcmp(str, "soft"))
