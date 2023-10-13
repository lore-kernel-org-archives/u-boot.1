Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E614CDB474
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 03:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E251086E87;
	Fri, 13 Oct 2023 04:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sl2OTnMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3ED86ED5; Fri, 13 Oct 2023 04:15:06 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E73C386EDA
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 03:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-419c8911049so10325531cf.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 18:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697162011; x=1697766811; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lXtfqnx/qcDDDoDNCvMLJ7+sp881mh5ZigerZyEbKtM=;
 b=Sl2OTnMq3XwLU7Xxurp4ZQTmnl29U+zTiv+zbHwwOn0pKrt3yQzH8rcnPNqFnC8llz
 qDMNrfI4C//+4CfpOufY6fVm680rMJg6g3hruchql7FgOFOcyoMHGgXEgcUOtSFjG2RM
 MoyqcV3NM0Z62pgWyhZx8WhTyIGeWwDJkuU+dhzYPxpnTzK+jj68Hu2BYiDbe8BqJNvo
 Msgf9jlaLhnfbqNWdgtkGC1RlxA+6kqoV+4WrX9F+F0PCMGrEtCoRUbkgWlCfL8B0yCY
 sAneJnwXCBt843V5Wjdz6McRYUvJQBG4u5jWfa7LYQzHWBh4UW/3igRoj6mue0W3uEmE
 Fn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697162011; x=1697766811;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lXtfqnx/qcDDDoDNCvMLJ7+sp881mh5ZigerZyEbKtM=;
 b=LIg7R9vSNwrTxZjVYedhLrTVTwCn5Fm0Y91y7QW1a+mr+6Vb7Sj1pMrBze4cZ6qyAz
 g4dCIzxyDSP2mjthfRikb57IcyQ7BOEryxhgOW3eGixzokNmUEsbFjFgJnWNRLWvayBs
 J0NwJNn4LxrmtRawxLiZZmJ4kXfNdXztcdMHqBByR/MwQWVpl8rhKp6qXPaI0FDLNVTY
 RIMuSextEFQTSjrxxC2+9WQyVfUe5mgpX1UeXjZvtjmuQ4WvHxjX/6Jm7syP2hPFjkrG
 ihSTc1a8xzMY4RaQ02M1kFlAgtUuJO+rF3aOXWt1wqxaCFCtN5mIe3B0Zl7+s49eGvsO
 4ODA==
X-Gm-Message-State: AOJu0YxuNJDZ9gFkuJ6/0KKfOa+cS5AzzCeNEM1Ug+y6mJv0HYHy1jbw
 1eLL6WByvApdrxMGvB6mKRQjuudYZtZpOw==
X-Google-Smtp-Source: AGHT+IEg3Slxr3MOVUAFufN4HzrLtuy6QH0QbuDE5YQghja7BL3/EUsCTcrblUgbfvAm3N6oJuQMEw==
X-Received: by 2002:a81:5285:0:b0:5a7:d412:af32 with SMTP id
 g127-20020a815285000000b005a7d412af32mr9430765ywb.10.1697161164006; 
 Thu, 12 Oct 2023 18:39:24 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 w10-20020a0cc24a000000b0065b229ecb8dsm271787qvh.3.2023.10.12.18.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 18:39:23 -0700 (PDT)
Message-ID: <3f66c0fc-712d-6c91-47b1-cc01aabbe1e0@gmail.com>
Date: Thu, 12 Oct 2023 21:39:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/26] arm: imx: Check header before calling
 spl_load_imx_container
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 uboot-imx@nxp.com, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-8-seanga2@gmail.com>
 <20231012164007.GP3119521@bill-the-cat>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231012164007.GP3119521@bill-the-cat>
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

On 10/12/23 12:40, Tom Rini wrote:
> On Wed, Oct 11, 2023 at 09:56:07PM -0400, Sean Anderson wrote:
>> Make sure we have an IMX header before calling spl_load_imx_container,
>> since if we don't it will fail with -ENOENT. This allows us to fall back to
>> legacy/raw images if they are also enabled.
>>
>> To avoid too much bloat, Legacy/Raw images are disabled for the four
>> configs which only boot from raw MMC.
>>
>> Future work could include merging imx_container.h with imx8image.h, since
>> they appear to define mostly the same structures.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> 
> So, since you mention bloat, this sounds like it's making functional
> changes here, but that's not intentional, yes?  Or to ask another way,
> is deneb disabling features here, to save space now that it can, or
> because they're growing "a bunch" and this reduces the growth?
> 

This is a functional change, one which likely should have been in place from
the start, but a functional change nonetheless. Previously, all non-IMX8 images
(except FITs without FIT_FULL) would be optimized out if the only image load
method supported IMX8 images. With this change, support for these image types
now has an effect.

There are seven boards with SPL_LOAD_IMX_CONTAINER enabled:

imx93_11x11_evk_ld imx8qm_mek imx8qxp_mek giedi imx93_11x11_evk imx8ulp_evk deneb

All of these boards also have SPL_RAW_IMAGE_SUPPORT and SPL_LEGACY_IMAGE_FORMAT
enabled as well. However, none have FIT support enabled. Of the six load methods
affected by this patch, only SPL_MMC and SPL_BOOTROM_SUPPORT are enabled with
SPL_LOAD_IMX_CONTAINER. spl_romapi_load_image_seekable does not support legacy
or raw images, so there is no growth. However, mmc_load_image_raw_sector does
support loading legacy/raw images. Since these images could not have been booted
before, I have disabled support for legacy/raw images on these four boards. This
reduces bloat from around 800 bytes to around 200.

--Sean
