Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12760C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 15:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617B4887FE;
	Sat, 20 Jul 2024 17:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sr+sji8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA03E887FF; Sat, 20 Jul 2024 17:36:22 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3DA88747
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 17:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70211abf4cbso1616418a34.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721489779; x=1722094579; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fqKFrMMdyrfN/7FFh/Wrt+ezRHmdFtI75DXYhi+z0kk=;
 b=Sr+sji8efxgc+JNWijBqX+3oxDf9kDdeMyHRDzR9Vxeql2N0rKGPwBg3LIS3RUw4gY
 FdCl4PiCTxGqvRI0iZCu9b6fyz2aszX8x+d83lQ5y31iaAgdWiPxZiznz60WXQEepf4P
 B90vR5ajyXb6xHdJh2Swe+N3HGe0g7CKXv9ycJpm6fnGzZPBR7g9wb0jkJEkeQUiQ/0d
 A3txfnAzOirXcot+8qU41Q+/WHYo/Bje8jRN0Ml5WHMGqdrnC+mIZPXXygELvBk4BCUu
 j2fS9Qlo3vrCOsyknFTY3/A/qTcsEMETrn4JYRSRfiKZd6lASNL9w0G05mNoXXaZHZqm
 9lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721489779; x=1722094579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqKFrMMdyrfN/7FFh/Wrt+ezRHmdFtI75DXYhi+z0kk=;
 b=fQtN8UZO2mjf1YAGZKPi0TROJ8kELM4R6mbvoaecpbFZNCOoJ5OMYIA7J2x7ouKlii
 UMDJUPVd1f+ltQhmxyG9zPFqjxxAoz7ohlbjFVGlSc8aVHiVy9SFTGpxjR1lk9pcRj0B
 jNqI9s/on/iGCAuRYR4nHhF3VO0VC75Du4bNvZGvrShO5g82q2iPmxADVUtYpBLWt+5r
 YBAATn1SVhKaIBslH1iscilO2tKG60eUqNwD8qGJMri5Flza33h9vWCQWFTPOLOzDuml
 APQtAt1Qw4UkXA+qDxSIjfu/0v7IA7lY8vfrFudz3pWl8lSJDMupIEibsjQsyWPOuYHe
 VdHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJMxQbCiF3RsYwovMcZrOCZldxtfVDSMFwD4aIaJ2+gF9YlKhoZYopNLeJGSUH/g+kkAXWvnxrryYYdbvQ0Cv4rNCncw==
X-Gm-Message-State: AOJu0YybVp1tXddbYua4zsE0DGoa6IhvdeBTwkPDEBESXgGksJeq3k/t
 mGmyDmsKnuwfoKitomdmSRoTDjSnP6hR/yqW0mqUCSB+V8n66owsqRvKAw==
X-Google-Smtp-Source: AGHT+IHDnHOwj2EBy0Aw2Eu1NAeR9MPGUGs6MXoFx9PUonW3Sa9dm6F4bEebGX0P/DhlK5txJftLQg==
X-Received: by 2002:a05:6830:6384:b0:703:5c50:82e2 with SMTP id
 46e09a7af769-708fdade986mr3859892a34.16.1721489779321; 
 Sat, 20 Jul 2024 08:36:19 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b8f98f4a9asm11898106d6.75.2024.07.20.08.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 08:36:19 -0700 (PDT)
Message-ID: <f0414737-91f2-8f82-19e1-79c08a9afab2@gmail.com>
Date: Sat, 20 Jul 2024 11:36:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/14] spl: Remove remaining #ifdef in
 spl_parse_image_header()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Tom Rini <trini@konsulko.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-5-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-5-sjg@chromium.org>
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

On 7/20/24 02:16, Simon Glass wrote:
> Define spl_set_header_raw_uboot() always so we can drop the last #ifdef
> in this function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   common/spl/spl.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 02567e766f1..745efdd9b28 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -245,7 +245,6 @@ __weak struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
>   	return map_sysmem(CONFIG_TEXT_BASE + offset, 0);
>   }
>   
> -#ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
>   void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
>   {
>   	ulong u_boot_pos = spl_get_image_pos();
> @@ -273,7 +272,6 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
>   	spl_image->os = IH_OS_U_BOOT;
>   	spl_image->name = "U-Boot";
>   }
> -#endif
>   
>   __weak int spl_parse_board_header(struct spl_image_info *spl_image,
>   				  const struct spl_boot_device *bootdev,
> @@ -357,16 +355,19 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   				    sizeof(*header)))
>   		return 0;
>   
> -#ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
> +	if (IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT)) {
>   		/* Signature not found - assume u-boot.bin */
>   		debug("mkimage signature not found - ih_magic = %x\n",
> -			header->ih_magic);
> +		      header->ih_magic);
>   		spl_set_header_raw_uboot(spl_image);
> -#else
> -		/* RAW image not supported, proceed to other boot methods. */
> +	} else {
> +		/*
> +		 * RAW image not supported, proceed to other boot
> +		 * methods
> +		 */

nit: leave this comment as-is, since it is under 80 columns

>   		debug("Raw boot image support not enabled, proceeding to other boot methods\n");
>   		return -EINVAL;
> -#endif
> +	}
>   
>   	return 0;
>   }

Reviewed-by: Sean Anderson <seanga2@gmail.com>
