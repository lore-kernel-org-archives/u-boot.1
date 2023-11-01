Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77126C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E53F4870FF;
	Wed,  1 Nov 2023 18:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nckupwXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB1DA86E24; Wed,  1 Nov 2023 18:11:38 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A982186FB2
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77063481352so92183785a.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698858693; x=1699463493; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=46h/KhN/7RdInOJ3BBu0welC5pqJf6vbaHJ5AuuWfxc=;
 b=nckupwXVMFqEoc6niyd7x9iZfbzMpsgCh9I/AAmypwWqBED1DOzpBGTEtrwTrf/g8s
 KiRpQFax7ocDYPIy9wUSQuWUrK2I8Ru4ysxSeBymMPLkgNvY/s/A9kKhV/DCheSVYTxB
 +I8UVS954AYB6PxADckik6Pbs90GMMhGPIFx8L8ruOBroLIW7cGWD1MVbeNDrwfZ1/ho
 yQjPrmuoz7ZEGgedf6pSxRMe9IQD1weZEHFp2DoHJbWNRPe8F+gIJzlQC0rBuLxo7WUI
 d+I7rtNa0oxr/H52b0GRbC/2wFD3yFxNwFrL0ETaiSTP/Q5OPT7qb8pekLK4fWn+OOjf
 4hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698858693; x=1699463493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46h/KhN/7RdInOJ3BBu0welC5pqJf6vbaHJ5AuuWfxc=;
 b=HfSbqS0+WE2uJNrKlnhv4wHMg+b7lnlkvtYxxo8auh+amCgRhg3EAT89KOfBc4RLe6
 NOxpYwUgEKl5IOppte+QuwJzbCAe+ypyCJlAgE8zlPZo0N0tIm9vfjwj8E+sp4QnjBcu
 Zy970OPd4pc6xx7rUAU2iYzryYPfqfwayUmoNYs5+0/EtTxQSrlLgmMtKnbqQqiDcbEz
 7osNnnYh4iC0c4di5MsP7dAllh1qYIlOyTuso1AGDoHdYUhDEsaDVwSrTMyyhJyD/5gE
 JeIf3xBYrHZ8tBZbc9VM2J+XO3ECJQn0bGzH2UfW4iKGhjZQDCyrokfZkQZm4T7a/vaV
 P5Hw==
X-Gm-Message-State: AOJu0Yx6xaProsWQw84j+daSV3fqISwW7Ta1LBRG51OEe1ZV5Dwzwdv8
 jvG4n4nFBm/yFgwoNUPzLH8=
X-Google-Smtp-Source: AGHT+IEcwjX/wTuzVtFvF9fyx6gqKP6h8lXShoRRIbfXGmfv9FK3wjgzUwWau5AEn1kE3m2qRG5YpA==
X-Received: by 2002:a05:620a:1488:b0:778:8ebc:129e with SMTP id
 w8-20020a05620a148800b007788ebc129emr8351667qkj.15.1698858693336; 
 Wed, 01 Nov 2023 10:11:33 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 a14-20020a05620a02ee00b0076f21383b6csm1582561qko.112.2023.11.01.10.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 10:11:33 -0700 (PDT)
Message-ID: <df88e98f-99de-abca-de7c-6d755c6283ff@gmail.com>
Date: Wed, 1 Nov 2023 13:11:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/8] clk: Add dump operation to clk_ops
Content-Language: en-US
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
 <20231017165649.1492-6-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231017165649.1492-6-ivprusov@sberdevices.ru>
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

On 10/17/23 12:56, Igor Prusov wrote:
> This adds dump function to struct clk_ops which should replace
> soc_clk_dump. It allows clock drivers to provide custom dump
> implementation without overriding generic CCF dump function.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   include/clk-uclass.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/clk-uclass.h b/include/clk-uclass.h
> index a22f1a5d84..30621e4823 100644
> --- a/include/clk-uclass.h
> +++ b/include/clk-uclass.h
> @@ -39,6 +39,9 @@ struct clk_ops {
>   	int (*set_parent)(struct clk *clk, struct clk *parent);
>   	int (*enable)(struct clk *clk);
>   	int (*disable)(struct clk *clk);
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	int (*dump)(struct udevice *dev);
> +#endif
>   };
>   
>   #if 0 /* For documentation only */

Please add documentation.

--Sean
