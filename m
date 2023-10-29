Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D503BC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 14:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE3E8874E1;
	Sun, 29 Oct 2023 15:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IWYjWVcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 113AB8750C; Sun, 29 Oct 2023 15:15:29 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044EA87139
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 15:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-778711ee748so296293385a.2
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698588925; x=1699193725; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OZRWmoPColjJxSQjAT50eDZX1daVYuFKJw05DGcWnlw=;
 b=IWYjWVcw6f4rnhtX046/Q+4rlnZPNbx+o3g/psX6LNz5ZXqG4pbh0npT1alhy1D7Ew
 GkUKA1M2YpsF9ODTCn9Szd6TgFvl3W7MwqgEYZUlRj1c2LJSnG5p+o1X0yTu4WUK+bic
 ZoSjgJOTHN6FICMs9Kxm63x8Tzpaa3Sup1+U417ZszbdKqpsuF/4he+FOgVVHCQ0a5+G
 zfJ0oIQVr09kFz1tKrmPIVkKjHPXfYOPFC79ZbhrBoQnANg9qUi+bblapc1/Ct2Ta5C0
 iodDmqOyJkfqLpJKtEnpephC2pbHrzu6ZmSR2U2v5l3qSP8F0hWp9cWY1SGT71iuhtCi
 ozpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698588925; x=1699193725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OZRWmoPColjJxSQjAT50eDZX1daVYuFKJw05DGcWnlw=;
 b=IH27AsqQ81P0pk2bIrMkavKbvxDageXiPSKHHM8EHK12+XFfLkNbTcLJpCU5EQ9T1q
 ucrVJuN/1vWusYwadoTZRYgNjTcT1cqGxnL8Uq9XaRI7qvdy70Gmn8eI5Twg3ys07MoW
 QqZsZlH5XBB64xzw0d1GMr3x5LWSWt2mJP0jOgUGHDnqBLynhT5yDzyF5SPxi/4lBV4Q
 oiVrTXVOwKU6fWeTZyrfWUlyeqRCrUJgdEg/CGqhVU0yNN4H462KpHLzckEoTHVX7pxX
 ookfcs1eD51FL33I0hZTWpQP4zJeX4vhyd/Q/cRlI4V5Aqps+bTxOw2uwy+nRoQ/X29I
 86JA==
X-Gm-Message-State: AOJu0YxDt50Wq2IlibeEpaBqb4uIJNJS1yKRuC0Y5kAgj/agK+iof5Yz
 l1m7z19pCsZlpIa2cnsq2QA0T9K6serXCg==
X-Google-Smtp-Source: AGHT+IEPUVOmamDLgiNVtvepEnWWf/QuKLfSxMCjY8HWAPZsfDzBT1emNS/yDRunGw0+teWAJe9O2A==
X-Received: by 2002:a05:622a:170f:b0:41e:1fea:8a49 with SMTP id
 h15-20020a05622a170f00b0041e1fea8a49mr9141724qtk.65.1698588925057; 
 Sun, 29 Oct 2023 07:15:25 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 hf12-20020a05622a608c00b004108fe9697asm2524784qtb.61.2023.10.29.07.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 07:15:24 -0700 (PDT)
Message-ID: <20a22ee2-2060-3e6a-61ea-963786f4e4f1@gmail.com>
Date: Sun, 29 Oct 2023 10:15:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/15] spl: nand: Fix NULL-pointer dereference
Content-Language: en-US
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Weijie Gao <weijie.gao@mediatek.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <20231029034845.1169614-2-seanga2@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231029034845.1169614-2-seanga2@gmail.com>
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

On 10/28/23 23:48, Sean Anderson wrote:
> spl_nand_fit_read unconditionally accesses load->priv. Ensure it is set.
> 
> Fixes: 00e180cc513 ("spl: nand: support loading i.MX container format file")
> Fixes: 4620e8aabc1 ("spl: nand: support loading legacy image with payload compressed")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
>   common/spl/spl_nand.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
> index 07916bedbb9..a19236d9e6d 100644
> --- a/common/spl/spl_nand.c
> +++ b/common/spl/spl_nand.c
> @@ -105,7 +105,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
>   		struct spl_load_info load;
>   
>   		load.dev = NULL;
> -		load.priv = NULL;
> +		load.priv = &offset;
>   		load.filename = NULL;
>   		load.bl_len = bl_len;
>   		load.read = spl_nand_fit_read;
> @@ -116,7 +116,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
>   
>   		debug("Found legacy image\n");
>   		load.dev = NULL;
> -		load.priv = NULL;
> +		load.priv = &offset;
>   		load.filename = NULL;
>   		load.bl_len = 1;
>   		load.read = spl_nand_legacy_read;

Actually, since spl_nand_legacy_read doesn't reference priv, this second hunk is
unnecessary. Actually, spl_nand_legacy_read and spl_load_legacy_img are technically buggy
since size/offset are supposed to be in units of bl_len. However, this basically just
results in extra multiplies and divides, so I don't think it's desirable. I actually have
a patch to convert everything to bytes (keeping alignment), so "fixing" this is not
necessary for the moment.

--Sean
