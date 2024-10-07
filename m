Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08952CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55949889E1;
	Mon,  7 Oct 2024 14:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gxTu6a9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62AF688AB9; Mon,  7 Oct 2024 14:55:37 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E483888EB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 14:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso342504366b.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728305734; x=1728910534; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0CWjfEmiMjr4hGWCwpXaOZ5W+3OVvSW12Xrsx5zTI0=;
 b=gxTu6a9wxOS3WBvmE9imjqhh2bdcxdY7/whvByEqLmDy4Qw2GspB/wQbMf7nQrgNS6
 T2p2G3KLeEU9olbkZgLYgkHl69SkorqqK2FQHRIqmC1bmSJYMY58UZfpE8OvTOeurfVL
 1UlGiE4rtsMwWsWKQ0rSk8q+ksM07spybwj1+r5BpVBxCUaup4RdnGUwebOSsBwjdGdj
 lj9YKkY2g9lv7TC5KZPndtdjWgI0AlNNBiIlIPj1FwWHhQZ9VNjrdrq4kEL21A1oXFjK
 1GOFwM7eVeuFXmLU13Z3YGYId61LKLlPBfZ4NAGOJC6g2jWgXPD+vSnWZMgCo7x+J3zY
 I/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728305734; x=1728910534;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G0CWjfEmiMjr4hGWCwpXaOZ5W+3OVvSW12Xrsx5zTI0=;
 b=E97fFjFIpX3olszIOV1SM9GdPYqRbQ3KukDXviE1GvwCQfcdGXyurh5TqU77m+z1fk
 yYdlE3wZsaKLMf4kH5X7az8KAFeVhUcHnfvGDcS2rfNnNqSft2JNdoeMMffOtJoIji+8
 xaxvhSGKdw2QYfDLtHZI8AP2qz80fHqjFAADFPdSa8Y7ZjF8NyiKmfEARhOg/pC9CzSr
 wkjIt51OajlD3Tt+K5MdtJP3O0uzkukvFD/m/0+aiJ3UBk7kAiyYAVhmZPdfCHoFVAqi
 MVNyf6qV5SA9W9iP0hVTK8SXjmHc/0G3AqQlG3tt+Eg8I9xqpbAzGXj32MviX+kVGLpk
 erFA==
X-Gm-Message-State: AOJu0YxC1gQftNiPIH6i/YyfTYxb/PzqS6lMhlMMR8VwdZSqrMQtL4rW
 FcA+P0JL7BVOtKLPCrh1NFwPIvXybcyH6TzeNnZohuC+rZd8InhvSbby2MEZFnUWwBU2sCWzcag
 MRRjNBQ==
X-Google-Smtp-Source: AGHT+IEsCWbe6Nk7Oyo42HTmt7CpJGnAKIJaDtuOtV+N+qWUfI/wTPQ3nCUrINahLaaqusho8ron7A==
X-Received: by 2002:a17:907:d02:b0:a99:5629:b3d7 with SMTP id
 a640c23a62f3a-a995629b772mr355386466b.20.1728305734262; 
 Mon, 07 Oct 2024 05:55:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6f4b:a50f:5140:7b75?
 ([2a01:e0a:3cb:7bb0:6f4b:a50f:5140:7b75])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a994db478bcsm200065866b.140.2024.10.07.05.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 05:55:33 -0700 (PDT)
Message-ID: <4f24827f-22d9-49d3-995c-6e2c3ed6859e@linaro.org>
Date: Mon, 7 Oct 2024 14:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linker_lists: set LINKER_LIST_ALIGN to 8 if 64BIT
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241007094206.2928071-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241007094206.2928071-1-jerome.forissier@linaro.org>
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



On 10/7/24 11:42, Jerome Forissier wrote:
> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
> exception may occur. In fact all 64BIT architectures should default
> to 8; that's what this patch does.
> Fixes an issue found on malta64 with QEMU:
> 
>  Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
>  31                      if (!strcmp(name, entry->name))
>  [...]
>  ld      a1,0(s0)
> 
>  (gdb) p/x &entry->name
>  0xffffffffbe04b0d4
>  (gdb) p/x $s0
>  0xffffffffbe04b0d4
> 
>  $ grep __u_boot_list /tmp/malta64/u-boot.objdump
>  4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8f1f4667012..72bf4029251 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
>  config LINKER_LIST_ALIGN
>  	int
>  	default 32 if SANDBOX
> -	default 8 if ARM64 || X86
> +	default 8 if 64BIT
>  	default 4
>  	help
>  	  Force the each linker list to be aligned to this boundary. This

Superseded by https://patchwork.ozlabs.org/project/uboot/patch/20241007094206.2928071-1-jerome.forissier@linaro.org/

Thanks,
-- 
Jerome
