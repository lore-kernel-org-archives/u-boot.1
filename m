Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FD9C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9226D845B0;
	Thu,  7 Aug 2025 17:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZSyiaGs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109E7845B8; Thu,  7 Aug 2025 17:01:10 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10DFF8459D
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-459e1338565so10688985e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754578867; x=1755183667; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mVUrebvzyDFf2NMY7Nt8sh8t+v2yjTLb7ykAb1MVbYg=;
 b=ZSyiaGs5GpGqo3n5MSYEY0kjUNmymfL3+2LJI5nhNz3SfoxlvVgVb7BrH3f7Mpj54d
 XFIiPwfKKfS1CYxIkM3dmi3fwx+sknGot5QsGlkKpNJboPuzdXjyTmmozt+gFUSID04x
 DHJmeOBoiNwdOWVFzdaOnVET1dGdtC03kbNw48HRykSW+auiZ8P0dL95QVRBr/FUC+XX
 4rFOqS6R3UZuP8KdG9SCElDukzmNRAD3JpEoHFiSBoTKyGQbV7WMVYF9nmcyR9ZinBUr
 yTUyo7GMan1E15zmPza5ZgmNEFEHq+7zXmJeghKP6GmoIPRIi6U3BagIvAHuMjQMDeIJ
 SyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754578867; x=1755183667;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVUrebvzyDFf2NMY7Nt8sh8t+v2yjTLb7ykAb1MVbYg=;
 b=asPVDO6jvq7z5dDt5GvStRZcF+W6ulu9fn29oUvQVfi/BYdl9nH1H4zw7rhfkzTMEE
 mifMRVvYra5XHxX5/GsGoFXRp9EAstr/YtmERqpoD0C+QVcPVzHY3FtyZNVXJVlP59lu
 xY6v8b2MslyEVOo6lE2WJtxLvwQqkZfd3hBsIAVv4kBqPKCFRmHB2FMegTUq4vhK7ESW
 vnTRJseUMJZlUudazZYevpZdPLXgdE5b2hYo9adZaYTrj1cZi3nq2xibr17Oazp6ubym
 j1yWe4ptJRa6Ax60jWoMnYb1fYUS3dBqFmnr1X5RKVw8Q1RFJPN/KnuzxQVb2QgBud26
 QFSg==
X-Gm-Message-State: AOJu0YxkBTj93jHT6xaX9VX50/7jv+d1OlBc4x42Y1T7TLrbbI4jlLgj
 tFt+0SlA7+0w0c6YoYctf5LjXlHRxDNxUllRPZNk4LUVHrLadf1LFELN91+VsOLZeQg=
X-Gm-Gg: ASbGncv3ka7ZmnEcgHZYuwIHjgZKIoNRqodwXE8YHzDY6JjKFOEdTkb9O7PNMqMZ0Cw
 B39Tv0l9WCyJxAUeFs7YhO/SCa+/F0H/uuFQj5XlA0+/a/qa0PzBlglAGP64HrYvIIZNxSkB9DU
 gE5UGyOrBWwSe/uXRDMRCNqHPwroDjYNfh766Y9ssC3EwBBUgcD4XmSETOkhizCTYnn6aDEBTsB
 vohIH3LUHBP06LSirQqkAAZrIzxSlgZvOxGLBzo3TbCJGLyOsCThZtmqQ6eYnhoWzCYN6JAXiBx
 Ks75OI3v34ffgYDA62Iyy+Y+G4BbsY0QVmALNtcXxKeJ3FbxBwY5fPTFrT3zIfy0ptQp2KUXqRi
 KNt1bYxKbpAokv6ii0lGC7L2OO5XlBNr5AF8EA6TNSsHI1kRDPv7OC/ZH1bK+iuk6SMbTHW0zLO
 zfbXoPapOB8VtH
X-Google-Smtp-Source: AGHT+IGlKJG+NWx3Hzxv2urJEqPtFUwQwyZetw25AObRkeHmKZfr/8s0kaYZB86K5bcckw0tnV9ybA==
X-Received: by 2002:a05:600c:4706:b0:459:d667:1842 with SMTP id
 5b1f17b1804b1-459e744f6bfmr60897895e9.12.1754578864537; 
 Thu, 07 Aug 2025 08:01:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459ded356b9sm165388415e9.12.2025.08.07.08.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:01:04 -0700 (PDT)
Message-ID: <0877def1-3ba3-4b97-a862-86c6db3f6b6c@linaro.org>
Date: Thu, 7 Aug 2025 16:01:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: Prevent dereference of NULL pointer
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250701-mtd_nand_fixes-v1-1-f31517bdce2e@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250701-mtd_nand_fixes-v1-1-f31517bdce2e@linaro.org>
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

On 01/07/2025 17:12, Andrew Goodbody wrote:
> In nand_wait_ready there is a loop that includes a NULL check for
> chip->dev_ready before it is dereferenced. Use a NULL check once the
> loop is exited as well to cover the case where it exits due to a timeout
> and it is therefore not known if chip->dev_ready is NULL or not.
> 
> This issue found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/mtd/nand/raw/nand_base.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index d3d1b93947b..48e3685d995 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -566,7 +566,7 @@ void nand_wait_ready(struct mtd_info *mtd)
>   				break;
>   	}
>   
> -	if (!chip->dev_ready(mtd))
> +	if (!chip->dev_ready || !chip->dev_ready(mtd))
>   		pr_warn("timeout while waiting for chip to become ready\n");
>   }
>   EXPORT_SYMBOL_GPL(nand_wait_ready);
> 
> ---
> base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
> change-id: 20250701-mtd_nand_fixes-191e5a19932d

Are there any comments about this patch please?

Thanks,
Andrew
