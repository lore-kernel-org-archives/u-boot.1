Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CACA606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IDNYBljF;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DwMCBgh3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B683812E5;
	Fri, 27 Nov 2026 17:54:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZOr5A9gwdG9z; Fri, 27 Nov 2026 17:54:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8CD2F812E6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795802092;
	b=kwVbp4DKxG57c5EPEcHme7tSWMYog7NbbTnqntaUwnktZ5e2zCaNRt23r1Ntl00nXAQW
	 iUQAnfIcH45LeYiJB1oG5zh7dlFfR4My0pWfDn+1imY/FOgfmvmsY2f421tfxbswwV3UI
	 JZvudzee5XrFp3Kh6Yw+ZCAdUC1ydMu3LBCgWT7uFH38sPU6Gc+UYiG5UzmLVjuuD079m
	 snGkNWIK++1/dGSy5ZcZfFu/sTFdBE4ZEt/X+U1QObsY2Uu7m2FOVESQsQrIbjfTDePl7
	 2fVv5jI8GZU91bgLbLKyBFlnIu76iTwntqJHkx7oFYogj8r05ZCNPOFXuo96M1Phn0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795802092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BiUbVdmZbJowUsw/aolY09kG3OQ2N8mG1dlCtPB0MW0=;
	b=T4EJvFCUoiP+BxUp0/XD/D6dVFkjW9oVPXIA+hrkeGYPhCRlOZlMut4tpaSQ4n3qQT7R
	 T1X0oXIxOdWY93/gpT8U0H1JVL3F2rvmOteoYc9Z+vt87ar3dfeu7OiVZh05oKdWD2+bu
	 p0+MbJ+YOlwa1krMet88bCYGtrhendWLIU1WQvSdVlGYOr07gWv9Ve/n+QrGeCVDvqUnE
	 1rWUpJOhU1pBB/L8X4ZZjREErhODis+QpkABTL08gluv7BgIJt+jSnGNS1Ml+NqGsScV4
	 lhgaOvT+xdsHslyRTFj5rjlrT/3uleMwQYrtPlYf7VwtkpvACPIW5IHaD+ZdkkAvDTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DwMCBgh3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795802092;
	bh=BiUbVdmZbJowUsw/aolY09kG3OQ2N8mG1dlCtPB0MW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IDNYBljFLgV+sT1MYPG07XdU6tDMuZwJ3gQeeR74s5zya3Ta6EZ/LoSbJtAIiFll7
	 xch5i0KJpwYWKP2pCl7fp7b0aUWjDytyMStFF0Gz2sCQgY8tM1JIKGAlSrL6FOyUge
	 Ij/p/JWfdaZ2GZ2oyQJcan2A+vjfPNY9vg4qkAu8leYQcqDey8KMZuNm2InXLPO6tj
	 h2hR983N7tT1c9C8/Pznj2OwoBmwigGb7n8sBlu4JafmFJaTuVqGwXmpfvqwGu/Ox8
	 SeFByhYAl2gbrz+Y1keYrPQ7os4HRU1nQIeTfGyz6RdiO3VsSOjy3QDn7u/v26mN4a
	 Sf4NZZut6YBtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CD2F812E6;
	Fri, 27 Nov 2026 17:54:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7932226D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 767C4812E6
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cViauBOha1zc for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 17:54:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7188F812E5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DwMCBgh3
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7188F812E5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:54:48 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so4902475f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 09:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795802087; x=1796406887;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BiUbVdmZbJowUsw/aolY09kG3OQ2N8mG1dlCtPB0MW0=;
 b=DwMCBgh3FP0JZQhoaAQ6ptnaxwpUh8ZG22v5v/Y+1KeDqHMGGDjHI+81XjrZaU3aVd
 aeLyzj4yTG+xGNqALKPLl7dFX/T78OeBnwsDqd9TFaD/JclMbxh1MSvrBJpCIzissiyF
 gAj/+U0KCvvPhGuneLHPqymSZiEyX9y5QWaxF9YVbkIpOMGPXKwALFxuob5yBUS1aOd8
 xDrVKHhrYEje4ltT1KHEDJPuJuZWdH9QHyMm7Ael4z+1nVlINYC17O9qsDKRxxR0oxrZ
 3dswT06lk4tZVhgAKzw2BWPmGeOSkKf3Xqcok1TGiEJjiEFzsoqvNG2Z6fbVvN9OejlF
 sx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795802087; x=1796406887;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BiUbVdmZbJowUsw/aolY09kG3OQ2N8mG1dlCtPB0MW0=;
 b=MswRhCMKL98qgpyN79Jm+KCLJbjOeIy1yJZ5cgey5uwnXsQEWoaWIWbzc8sV3+ISlf
 qLKKLCNzEOi9DQtQUwC7N0Knk41bFv6Etr8xKD0hyr2+494BGwfHDiIU1SGWeso470LY
 oieuFekUsZ5eFqkL6nPaOo6uhakwWFtqUQoplYbKijNrMDxeB2M+DZzHpo7vtzkMYU5n
 U7h4MtVG7dclrtC9ttYxm9jITBqYm+OqoVpnWFIUNI77OcBlebRwU+srWjnnopkv+Bl8
 ckmG0uGD0PPD10X93+/G6KpwSBErlbjThBNEbyKR3NdhRdLgEYYa7tCXlja0A69yVr6h
 4EPA==
X-Gm-Message-State: APuU4Z8R1hgKsMMwuynlplgX81bfefS/PXAQDQSh3Wdo1xTEk20v0p7I
 /BArC+qB6LRfwp+J3E69dZUi6HLDo/MJpatEiw4Bgdd04kZ+OouZk2zdzdvdK+er4SZ8aZ4pBqa
 HxmpyrHs=
X-Gm-Gg: AZFdTZed+rRKb66lwZyFUdvf7YvqwJ8nRRREZmFMxDRoHsiprDPlx0Euzlwkp5pCHn2
 coNLEwSgXEqsjbD6pa10mn8wN1IGw+EPReU0A5wib2mGZKHYWZkGBlCgpQxpBp5nxl8D4B7zhXU
 Ltf0f8Mm8gFdCjw8M5LtZ2s1JZ1vHVDW6BWcpmmybJiPzo12Z3rCrIH5jC+ZEQQ9Tv/d7h3IMRz
 BswVA+epH6NOuHsgUE+2TW9qSnS7cch9dukQ5Kb4WYfMSAwSVD4TOc1fjI09i+anREuUky1VmTy
 aIt7FwTjCLcmYGHAPN2WQwCthifbvfK5tXnYx8oXeOkXKwpnUyM6srjOISRIdoaeJMCbUmDAx/r
 HziomkLKz+mzkZx8q7t8N/SjETMVd/wXjwFAeZS9IoBzpGuRsfyU62pPMONWhlNZ02xXdcQq3Xq
 NqqZ7F1P5uJ02zcQNODHtx8EFx3qjJE4ET6khESJOJKr6vPRyyl1tWQGRoKmeC40hqDnyyOb02v
 ak6N65GApbmyr07URC+HXLVArHGWbh1CCL7eg8Jjs8X+C3J23gOZDWHcCo+JxJM1cF9m5wWjVZs
 nox9RCIfRD78XAn0OSOB3ncVtwYXu9HRF3wtkkZ5
X-Received: by 2002:a05:6000:613:b0:498:88f:14c8 with SMTP id
 ffacd0b85a97d-4abb0f3bc7emr54806833f8f.9.1795802086931; 
 Fri, 27 Nov 2026 09:54:46 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:16ae:8ed1:cf83:edae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf6804sm47806474f8f.10.2026.11.27.09.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 09:54:46 -0800 (PST)
Date: Fri, 27 Nov 2026 18:54:42 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH] configs: stemmy: Enable ext filesystem writes
Message-ID: <awnD4nTwKFBigGnn@linaro.org>
References: <20261127-ux500-ext4-write-v1-1-0ca250dbe845@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127-ux500-ext4-write-v1-1-0ca250dbe845@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 11:09:46AM +0100, Linus Walleij wrote:
> Stemmy can read the ext2 boot partition cretaed by e.g. Nura
> build, but has no ext filesystem write support enabled.
> This is needed for EFI variable storage.
> 
> The EFI variable store fails to create or update ubootefi.var:
> 
>   ** File not found ubootefi.var **
>   No EFI variables loaded
>   ** Unable to write file ubootefi.var **
>   Failed to persist EFI variables
> 
> Enable EXT4_WRITE that will write EXT2 and EXT4 alike.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

I don't think a EXT2 partition is compliant with the EFI specification,
so we should probably change the Nura device ports to create FAT boot
partitions, there is an option for this in the deviceinfo file:
deviceinfo_boot_filesystem="fat32"

I don't think this change hurts though so fwiw:

Acked-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Thanks,
Stephan

> ---
>  configs/stemmy_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
> index 982eeab391c0..f5519c7ab05e 100644
> --- a/configs/stemmy_defconfig
> +++ b/configs/stemmy_defconfig
> @@ -42,3 +42,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x685d
>  CONFIG_VIDEO=y
>  CONFIG_SYS_WHITE_ON_BLACK=y
>  CONFIG_VIDEO_MCDE_SIMPLE=y
> +CONFIG_EXT4_WRITE=y
> 
> ---
> base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
> change-id: 20261126-ux500-ext4-write-4a654d54b861
> 
> Best regards,
> --  
> Linus Walleij <linusw@kernel.org>
> 
