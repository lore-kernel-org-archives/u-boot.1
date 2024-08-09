Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9D0C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02CC88A44;
	Fri,  9 Aug 2024 02:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AGTvtKbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C5A88AE8; Fri,  9 Aug 2024 02:04:43 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E84888E7
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a61386so1981618a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161881; x=1723766681; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U58EGZunqgA0foa3naB+z4p7ro+B+/DD0qWtqz3fFVw=;
 b=AGTvtKbwdwKD/0ENQW7hmo+89+Df721VzYHz6FovyafdBxIJAga4bNtXUdtIVrMZtM
 hPkTyJKQ0nkkYP3OPSIpc7dDmBsBOCDJSFASrKngRfDwxQ+dtFW/G8X86X96mniW/yL6
 XQX7Ln2lNlxvulf0qsTPGLvqRyTP9A21NatIXsaVD3QHQuCUhvw0tFBhlCWLONcWGqwb
 fVyuUSFb+HXwjkK+2TGMTYmxVYaBxmNak6lNQ1tHPO6mAiqDcxCvJYChQu3vUSCcC0eY
 ziOfVBr61yEAsRaT6Xgy+ertfiRo3sF/0ySioYIhOJ0k1ncOl+m6SvtFZLM/XWMcV0tE
 8zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161881; x=1723766681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U58EGZunqgA0foa3naB+z4p7ro+B+/DD0qWtqz3fFVw=;
 b=R7knIAnji0mA60tflsK4yOJ6mqLDbqIh6byTlZa4FHk9j5DPvXpS1rgimBZSEZQrrb
 5Lp3okFkuIJHoSndSwNXPr2WuoYH/cadfIfhbAXRASmJDiZU3XjRxOeYDbyhbaU9aK++
 YaWNh3EBVPEhxkiRB5eYPHJ+lpgGFnac6u1Zc5PmJw1N49UOLPi49XKyn+hIopYvp4qs
 biF42njuvp9L5bGmcamWEv9VVYwnkwT8oifexi8heN/BJnwVE1LUJTBzRiepfT0nU7be
 9RdajgvMJh11mh9sJ8CLpIhUh1Bv09QJQGXfgqsFqU/TRH9HS0IPKTIoAfctwSdRh702
 9BHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcSuJipfAB/iDv+WOnexBX/DOtVDQeCshsfBitdPV7lSPmMcKhoAX6k/CHIyoMd1Yd5LCmc2D/C+ffTw0wU+XapxyBFw==
X-Gm-Message-State: AOJu0Yyr20tY9J3fLnfbWrBGtmPLwhljMaauIFSFsdRF4SQi0nEONBRB
 ZTSzBY/M47oFT7olGRU5H/l0yDXjXuYoUYtQAv3kLkybcWxyQJ9PN96ZlFqOn6s=
X-Google-Smtp-Source: AGHT+IHu8RlRyBeaD7z2m2ydecgig6gs4dDM/YzjUGO4a9u1oIMuvha1vbu0fxHp40SsBjOMCYdSJg==
X-Received: by 2002:a05:6402:2695:b0:5b9:9af5:c50e with SMTP id
 4fb4d7f45d1cf-5bbb21f3b44mr2542792a12.1.1723161881142; 
 Thu, 08 Aug 2024 17:04:41 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2c1dbe4sm1058742a12.27.2024.08.08.17.04.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 17:04:40 -0700 (PDT)
Message-ID: <30be704e-7368-4c47-aa33-103d5d3734cb@linaro.org>
Date: Fri, 9 Aug 2024 02:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] mach-snapdragon: use 1MiB for get_page_table_size()
To: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
 <20240809-b4-snapdragon-improvements-v1-3-7c353f3e8f74@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-3-7c353f3e8f74@linaro.org>
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



On 09/08/2024 01:59, Caleb Connolly wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> With 14+ entries in the memory map, we need quite a bit more space for
> the page tables.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Forgot my SoB
> ---
>   arch/arm/mach-snapdragon/board.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 8947cf913dff..0e8234a62b28 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -416,9 +416,9 @@ static void build_mem_map(void)
>   }
>   
>   u64 get_page_table_size(void)
>   {
> -	return SZ_64K;
> +	return SZ_1M;
>   }
>   
>   static int fdt_cmp_res(const void *v1, const void *v2)
>   {
> 

-- 
// Caleb (they/them)
