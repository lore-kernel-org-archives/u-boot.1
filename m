Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF925C021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A9E80FD1;
	Thu, 20 Feb 2025 22:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="srz4+I4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 048B9806FE; Thu, 20 Feb 2025 19:25:43 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888C180077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 19:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220f4dd756eso25782895ad.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740075939; x=1740680739; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dnH+UG5IBd7eS2mOxJOAE0SDu2ASuXMrdq70JCP7mOU=;
 b=srz4+I4+60rXfy4iODctE1g44ITwnxAazsniy50W2kg6YEz6ckQI7Gakc3dhapgBEH
 SqF6z7NOIMUCpOJ9bl1P72TPMSvUvr24LTVYmPsTvbozZJhNo34pcCTSKVMt3RUww3iS
 pkYZpY/ur+l9VtAdtZdgkGbTHc6fiKvBCSeUxnsL06D2dCi3Y5J0aDjiKu2M8MUeBBgF
 aiQwopjqI0cpd/CX5oRpJwAXYYeQ54TObGm6OWqtqj6RfQUzuNP/8bl9y9xWaywqo14R
 PY/Kx4fbMsw9u+YOadvadH3Fc3UJ1bCgwkJxfCSMNm6FOz7kCpJivqCK2HBXLDXT3Ulc
 gb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740075939; x=1740680739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dnH+UG5IBd7eS2mOxJOAE0SDu2ASuXMrdq70JCP7mOU=;
 b=QV2R0TK0az2X5mjaILrUSfZTuo/RgZZ6f5GF0M/e0n6GbY010wdxDkuWFDVh+acD83
 xalvs9gdgv0j9LG9lo6/wMLyvrVhOPrOoKFyDEmmW1WKqDIzOa5Xj6W7VkmVvLqmPIuo
 qQp0oLbs+4T5PBSH5UA5TEbEDTXweBC//HrUEUnMwuF1dLfboiRawOmeWCPEhhWWWrHb
 Txs8v1RPZeHWid2v/BeIF99EMyvTBi+tR5UI5Qq6vyJjAnQQbUqUd9b6+dl4tTj+eZU3
 D1VMaEo1Glu4/GoOMVdPj9773gW0N8d98rTvneDNOYSz+YugQTd82x18IhBFV9ZkJyfi
 Pk4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHSsZSm29jTTEsjUNgSIq/98QmD3Cwz6T88ICbOkzIRB2XYWRZ7A1FaMVJZLMjAeBBt7Phlzw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzdlu/AlXwPGhFjtgaLrsClFXbuWo7tSMLxvu2VlvyhNiqKY6II
 hm6nRE5ih4EdOvDH/x1O7wLukYLV/GG8uU3sUq0ZBJ+TDNUjDWlghPE4YiZCjTI=
X-Gm-Gg: ASbGncsDsQdHtv0K7DBr6cQrjc2rChCjvmzQcS/1HklkkNo+wkJJBTYyfi0XoZ9N51y
 1OM88SWbCSFOD8+U3tKUdr6oi9Es41s8iqLXN5dqdqLzIcZU/TbxYOZc985U40MaWmsYh8RQtUS
 i2JTe1NgyVzBU/BWRrn0/fswL3AiVM/c5gWA+ffj59vejS977Sea3ojX/jgMRAW5oR8L4M51ilH
 P2B6Ctn1SQlNWRXKpLeeYye8oyni5jjM9lzksHpOjS0clC4pen8nqrLhzhvwq+Mmz+GmlRTd3RO
 TcVSlJ5Vn/upIrDnDMZ1L8jQqNuwILJLcjCoF20bBfKSxNPcOapx+oo=
X-Google-Smtp-Source: AGHT+IGqYvLJVmT0YgKjGjNYpdcg07wg471PAwWCyKN7s+4mE/kZQGC8yxS3MBvXfxS0Z4G57A7kRw==
X-Received: by 2002:a05:6a00:4185:b0:734:9cc:a6e4 with SMTP id
 d2e1a72fcca58-73409cca8dfmr10573651b3a.21.1740075939025; 
 Thu, 20 Feb 2025 10:25:39 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732532ce7f1sm12193133b3a.73.2025.02.20.10.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:25:38 -0800 (PST)
Message-ID: <55b034db-c5bc-4333-98f0-d413992b4eae@linaro.org>
Date: Thu, 20 Feb 2025 10:25:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: mmu_change_region_attr() add an option not
 to break PTEs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 mark.kettenis@xs4all.nl
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Tom Rini
 <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>, Sam Edwards <CFSworks@gmail.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
 <20250220135506.151894-5-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220135506.151894-5-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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

On 2/20/25 05:54, Ilias Apalodimas wrote:
> The ARM ARM on section 8.17.1 describes the cases where
> break-before-make is required when changing live page tables.
> Since we can use this function to tweak block and page permssions,
> where BBM is not required add an extra argument to the function.
> 
> While at it add a function description.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   arch/arm/cpu/armv8/cache_v8.c           |  6 +++++-
>   arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 +++++-----
>   arch/arm/include/asm/system.h           | 11 ++++++++++-
>   arch/arm/mach-snapdragon/board.c        |  2 +-
>   4 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index c4b3da4a8da7..670379e17b7a 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -972,11 +972,14 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>    * The procecess is break-before-make. The target region will be marked as
>    * invalid during the process of changing.
>    */
> -void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> +void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs, bool bbm)
>   {
>   	int level;
>   	u64 r, size, start;
>   
> +	if (!bbm)
> +		goto skip_break;
> +
>   	start = addr;
>   	size = siz;
>   	/*
> @@ -1001,6 +1004,7 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
>   			   gd->arch.tlb_addr + gd->arch.tlb_size);
>   	__asm_invalidate_tlb_all();
>   
> +skip_break:
>   	/*
>   	 * Loop through the address range until we find a page granule that fits
>   	 * our alignment constraints, then set it to the new cache attributes

Because the 'bbm' argument is always constant in the callers,
better to split the function.  Perhaps

   mmu_change_region_attr
   mmu_change_region_attr_nobreak


r~
