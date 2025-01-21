Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A0DC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 12:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6FE580757;
	Tue, 21 Jan 2025 13:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FvPW9oDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B5A3805C5; Tue, 21 Jan 2025 13:23:57 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 726F780780
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 13:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d9f06f8cf2so10835018a12.3
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 04:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737462233; x=1738067033; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ok7M4v56XMWC7DDfBARCuSJ++M/eFMlkXX/KKrl1NgE=;
 b=FvPW9oDHCGbRL2Ziqsh9YjtGxMj92eim2yN/HBBUNbC1eSzg6GKtCZbXG43cJwDMan
 h+5sCxzMG7AbJ7Nckaz1o/Wi4a+kuMS5vJJU7nHO+LzdTwWmKGwCeEpzav1aQ5HMg0Y1
 KHxgeXaB4G35ZCHsmHMv5gyAKHdCNTdyqIvtOTYJdKb9hV6cMO4ca+pmxY2vC8RbJslr
 wxY9JnHugYwgfqm0yWZFmmfVBVh98NmU8GF38wgiDpSoWWbEdxp6TUF+4mhDc5lJbD1o
 C1Coe514tLH+rPcWI0nnrT+X9jMmAzvhJjvLvjkikQyH6zNvtTPvuTSL414wbr8DE6fW
 gEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737462233; x=1738067033;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ok7M4v56XMWC7DDfBARCuSJ++M/eFMlkXX/KKrl1NgE=;
 b=ubge+f3ZBQrIBuPfPUdIKaU/bO2DmPyN9YrKMJNUj0qpy4tlQ6MwTT3TXbSV0bcjL6
 NhdlstKrPm+t+ERyVtkWL7PIbOfDXDa3Mk4c5p4vPk6SCFRCzFX8VSb0uYt+t+ez99tv
 B3N6lbfHTr7UXvIgs5Yb5sPvRbgCRWeZeRQDalsFr1GYCkFw0D477i2SLpBPG4e1hDC9
 CgRFmidDoVRD2uBnxF9KG5Po/C4wUGug1YpW8vx83HxB/gT9jlKlrcwlAAJUNmmzOQLd
 yadFNkGxfamP9HD6CoElGxSt5E62ZdkNrMSbvgB8xSk54TT3MoVDSMe+/5+PqUbS39QQ
 Q8iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaYOH8/caNLcQzRlZ0s8dsYCVcfGZm3OgBh2ASz72foPh77LnQBTjussJgSf2uOQArgVDmCE8=@lists.denx.de
X-Gm-Message-State: AOJu0YzujUurFsXb1ed2wZZOOKylX7huBpjQUGNGim/zXnJ3EDyV4bva
 MapXLgG+z7PSJWqGf/JnclUQgIpfsxkZVpa+rwk8pbpUiinzqUBp7vNlccZ2Oxc=
X-Gm-Gg: ASbGnct+QL7qgUiQlxLbxxiH3B3LX+WkAzYUfR2pDld/vHkww7IKJJXLowEZs0g5eX2
 9Nhqg4Q/eRP8/LPLk7EucIliOvIEp1+gsC2xiOWZmoo2Gmw9VDdjW/2vOnw8k1rMMvF+fjAHEQF
 I7Gyundg619bfGpWi2KO2PQ4aBS+hdmo1701LTFvdI69A8O07xjAz3UydyShBTHmkUYiibFm787
 O8RjfRsdk4u6tzSq4hUEHHJTVniyrrxE9j86fAFbOaSmFm6LGwPxVEE5tnF2GYefaXaMZKziUrZ
 QnFvboz/d2xLT7ca5FzhFha8Sb81oVGiHzQIN/S8P2JraOXoXABc
X-Google-Smtp-Source: AGHT+IFkw5FHoTN45G+i1OnAF6uXUg/q2SbWBtezHHpbqP9um/jpQdQ3nx2Udv1H8KaAgfKexnsR/A==
X-Received: by 2002:a17:907:9408:b0:aab:daf9:972 with SMTP id
 a640c23a62f3a-ab38b29cf07mr1494123566b.28.1737462232864; 
 Tue, 21 Jan 2025 04:23:52 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73683c29sm7129172a12.34.2025.01.21.04.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 04:23:52 -0800 (PST)
Message-ID: <aff69483-cb39-4568-846d-6ee7c14640fb@linaro.org>
Date: Tue, 21 Jan 2025 13:23:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mach-snapdragon: pass fdt to qcom_parse_memory
Content-Language: en-US
To: Sam Day <me@samcday.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250120-qcom-parse-memory-updates-v1-0-54a7f0550cff@samcday.com>
 <20250120-qcom-parse-memory-updates-v1-1-54a7f0550cff@samcday.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250120-qcom-parse-memory-updates-v1-1-54a7f0550cff@samcday.com>
Content-Type: text/plain; charset=UTF-8
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



On 20/01/2025 20:43, Sam Day wrote:
> commit fc37a73e6679 ("fdt: Swap the signature for
> board_fdt_blob_setup()") introduced a subtle change to the Snapdragon
> implementation, removing the assignment to gd->fdt_blob partway through
> the function.
> 
> This breaks qcom_parse_memory() which was also called during
> board_fdt_blob_setup().
> 
> The underlying issue here is that qcom_parse_memory is using the of_ api
> to traverse a devicetree, which relies on the fdt_blob in global data.
> 
> Rather than relying on this subtle behaviour, explicitly pass the FDT
> that should be consulted for a /memory node.
> 
> Using the OF API is typically preferable because it's easier to read,
> but using the lower level fdt_ methods instead here doesn't add too much
> complexity, I think.
> 
> Finally, a minor tweak was made to board_fdt_blob_setup to use the
> passed fdt blob pointer instead of gd->fdt_blob, which removes the last
> of the references to global data in this area.
> 
> Fixes: fc37a73e6679 (fdt: Swap the signature for board_fdt_blob_setup())
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Thanks so much for sending this! I'm pretty sure the whole reason we
called qcom_parse_memory() from board_fdt_blob_setup() originally was to
allow for the usecase you add in patch 2, so it's nice to see that
fulfilled :>


> ---
>  arch/arm/mach-snapdragon/board.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index f1319df4314783622bb5f4f2410d1d4fd28a1c83..2ef936aab757c7045729a2dd91944f4f9bff917e 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -88,20 +88,21 @@ int dram_init_banksize(void)
>  	return 0;
>  }
>  
> -static void qcom_parse_memory(void)
> +static void qcom_parse_memory(const void *fdt)
>  {
> -	ofnode node;
> +	int offset;
>  	const fdt64_t *memory;
>  	int memsize;
>  	phys_addr_t ram_end = 0;
>  	int i, j, banks;
>  
> -	node = ofnode_path("/memory");
> -	if (!ofnode_valid(node)) {
> +	offset = fdt_path_offset(fdt, "/memory");
> +	if (offset < 0) {
>  		log_err("No memory node found in device tree!\n");
>  		return;
>  	}
> -	memory = ofnode_read_prop(node, "reg", &memsize);
> +
> +	memory = fdt_getprop(fdt, offset, "reg", &memsize);
>  	if (!memory) {
>  		log_err("No memory configuration was provided by the previous bootloader!\n");
>  		return;
> @@ -158,7 +159,7 @@ int board_fdt_blob_setup(void **fdtp)
>  
>  	fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
>  	external_valid = fdt && !fdt_check_header(fdt);
> -	internal_valid = !fdt_check_header(gd->fdt_blob);
> +	internal_valid = !fdt_check_header(*fdtp);
>  
>  	/*
>  	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
> @@ -181,7 +182,7 @@ int board_fdt_blob_setup(void **fdtp)
>  	 * Parse the /memory node while we're here,
>  	 * this makes it easy to do other things early.
>  	 */
> -	qcom_parse_memory();
> +	qcom_parse_memory(*fdtp);
>  
>  	return ret;
>  }
> 

-- 
// Caleb (they/them)

