Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0352FC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DCFB82D0C;
	Mon,  7 Apr 2025 12:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UCZLFaNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0472282D39; Mon,  7 Apr 2025 12:02:36 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7CBC82CC9
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so15441705e9.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744020153; x=1744624953; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xjO5lVknVSCFYiovcPPM+akMHiJXqMb9XIf6wtbcr8E=;
 b=UCZLFaNVSWiDxhwlgmRxMArmPOH2DtL7njzcPKChscF4FbAueWKKAOMvwvy3e3dSUL
 qGTh33E4c1zaWgQf9REHtuk66KnZOH21pSJst7tSAaBPJSLv6of3v+ePsbNhtRpF9Avm
 Wc08Rr2EbeYBEZFSJx5cQ/PegCnaMaT4/G48bvYg6RWqOU2Cty1FVGJbgS6H6QfDzbbD
 MW2ViJHOrusg78ITHE5L6qDA7tbPQ0EwoSNPkX9vLreViGP0FWXFs2e7Lo4/8T6hhjCt
 3fa+sAeTjjnAB/EBX9CRQXx4e4WMHTqhB/0euTDmrcsL9UmNFDeuufQT6R3UHu9DXlnf
 nMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744020153; x=1744624953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xjO5lVknVSCFYiovcPPM+akMHiJXqMb9XIf6wtbcr8E=;
 b=RuwDowP7id20P2rKi9rOYEAMLjxZbSfuOvArfwNhmFbUF2YqhhE0CPyZm+w9SiVuJg
 iA7Zww9zdtFoCbXNHeL+CqJPcBLR204Kn67bOFR/KmIFR/5fyumo1jU0u+CXt3AVWBmC
 01/e5quaK6IoI/8TSbOPocbCsfBXGrxYAAmx5Nq4jUOp3oGXsEBw7bjkVE8XDpCzRBES
 XLl2ukmlvQ7e8b4YDZri2dzD4Ep8TgD80oNwzgZa1O4PaCLa4mcoOc8RBfPL7DoOBM7t
 QlAoLnEWirAV38xI4Kb4j4Zg6FA+5aCmslfYPSbgytHX4jujd5Z5qwuiDrlePLd60VCZ
 Zv/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCd/JUy8KOotz9aEMpd7vwRZ5B/Bxdj6JurO1RhswdGvQFUIdMzaE480U19sDNTgqSa8n3QI8=@lists.denx.de
X-Gm-Message-State: AOJu0Yypz8WrExYGnRAXPZ46dw49GqINNeOcWyzf5ic9wZfoAcyYUcTb
 26qVACbPXcjWGkjBltihBgNjKo0L/tFcs0kG1RqecT4E4G6yXI+/wBalcEEYdEk=
X-Gm-Gg: ASbGncvCP+BeXTDjZ1UPXW9f4rzpE8I51pBOdg1lAXxtzpQj91SItCQ8xMAi3xxEMc8
 pWf8mmg/nrJGYzNBmKzGNaMjQoLe98PMsbquStFoMmn4PHRyPrPKO7gsVB23bkD70iz9NAJMp+P
 1QSKQgSKcAXYDxChhCIl4zVZMd0WLMMSvVjrcN12hkgBIGD5NpEDA3e9GQzjILr+up/Yt1Xvmk/
 VO9cwojUVJ2NiuVPIORrgucggsiJ/prf1Vx+AzjjM8ahlARrUPrTdNtuysZLns17sX4Ik0aMK6X
 7j46A0Dv2mMCYGL2VLPXlmRnKxcqPR8e/uKj2jDAaMhEVb4D7l5ztIRbb/4pTCpVy7jeqpKENU+
 7pk4g4oWzZxw=
X-Google-Smtp-Source: AGHT+IGHcg9xbMjw3qZ2PkBqSJ0FoIIWfTgVcjJTDLqBnZipn/CahyNCs5dAIuG692+r6X5jFKh4Qg==
X-Received: by 2002:a05:600c:4e09:b0:43c:eeee:b706 with SMTP id
 5b1f17b1804b1-43ecf9fe6d2mr112752105e9.24.1744020153347; 
 Mon, 07 Apr 2025 03:02:33 -0700 (PDT)
Received: from [192.168.1.47] (212-60-142-46.pool.kielnet.net. [46.142.60.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16313edsm127972675e9.6.2025.04.07.03.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 03:02:32 -0700 (PDT)
Message-ID: <79fe85dc-9f12-4f64-a269-1c2020d015f9@linaro.org>
Date: Mon, 7 Apr 2025 12:02:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] mach-snapdragon: board interface to enforce fdt
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-7-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250407081927.138915-7-jorge.ramirez@oss.qualcomm.com>
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

Hi Jorge,

On 4/7/25 10:19, Jorge Ramirez-Ortiz wrote:
> Some platforms might require the external fdt to boot.

The better way to do this is to use the u-boot-nodtb.bin to build your 
boot image rather than the one which includes the internal FDT. If that 
works I'd prefer it (and it can be mentioned in the build instructions). 
Otherwise it would be good to know what the issue is here.

Kind regards,>
> This change provides a mechanism to the board initializaion code to make
> the requet explicit.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   arch/arm/mach-snapdragon/board.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ef936aab75..1bca9dce20f 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -150,7 +150,13 @@ static void show_psci_version(void)
>   /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
>    * or for supporting quirky devices where it's easier to leave the downstream DT in place
>    * to improve ABL compatibility. Otherwise, we use the DT provided by ABL.
> + *
> + * Alternatively the board can enforce the external fdt.
>    */
> +bool __weak qcom_board_fdt_external(void)
> +{
> +	return false;
> +}
>   int board_fdt_blob_setup(void **fdtp)
>   {
>   	struct fdt_header *fdt;
> @@ -161,6 +167,12 @@ int board_fdt_blob_setup(void **fdtp)
>   	external_valid = fdt && !fdt_check_header(fdt);
>   	internal_valid = !fdt_check_header(*fdtp);
>   
> +	if (qcom_board_fdt_external() && external_valid) {
> +		debug("Using external FDT\n");
> +		*fdtp = fdt;
> +		goto out;
> +	}
> +
>   	/*
>   	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
>   	 * Bail out while we can still print a useful error message.
> @@ -178,6 +190,7 @@ int board_fdt_blob_setup(void **fdtp)
>   		*fdtp = fdt;
>   	}
>   
> +out:
>   	/*
>   	 * Parse the /memory node while we're here,
>   	 * this makes it easy to do other things early.

-- 
Caleb (they/them)

