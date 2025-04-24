Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E29C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 14:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019478056A;
	Thu, 24 Apr 2025 16:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CknV5KEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778DA806FC; Thu, 24 Apr 2025 16:20:42 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E3580194
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 16:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-acb415dd8faso169849866b.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745504439; x=1746109239; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wBOGxPJhuaPLyKRed9+uyrPhIjo2Fn4PezJgQX3a+Uo=;
 b=CknV5KEuROyGgbWty3jUx3y0DGfHOQdT8HLFlgEKt30VU7uR9+MebqNw1oSySk8qL4
 GQPNXuCIwD3i3I2PiCwMs6NSBgWtgGlhJlQKOy5qEt4ZFD5fx1oWexAAYNDZ4lLmTtg/
 jt+jJAVdystNEEr5ULmG0YspEVtiTNTgIQh4VtZn0clF4vPmFLznShLtqPm9ADnFgv1f
 6QXJ4NnbuMaUeqIL7AVk8/SGS6IPBnk4Nl+vltBB511zaJ6I6VtfwHqhbRVvuErLi+kG
 ZIIbfHPRXfWA9x9GCFvWSQvZDuwf8WqSZVt6xvHAsjCG7f89GSsmn9GeITvmt/w05wVm
 d8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745504439; x=1746109239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wBOGxPJhuaPLyKRed9+uyrPhIjo2Fn4PezJgQX3a+Uo=;
 b=DRYiWfuU+y49X+kG41pdEOqq6KmDxiHYJJ8ePMKCaOWk2t8nwqycsH5DxNzFh+qzvM
 APWcn6SomJX/OGMeTism22oJ9AuSF3l9w4HjDGYZ3GNffUf4CGnNFa0p+dLyQFKEm9Xj
 OtWCV41ltsBHMOROWAWR0ymrMR/SV5vRdKonx4r0axf6b8l36AN9DVGmaqEUhbz3ADVJ
 05kour+5HkMcSnoBd+5/GhOdz5cGrvSlW+bomqOb0aO06NlxIqvKA9uxRGW+EbxUYjUQ
 V0VMd0n+6pxxQnOlhoJ4ktoP+Yi9J5KApDCPaVQ8SnV0QcznNzkntvVEApdQ81uxP2Q9
 HZZg==
X-Gm-Message-State: AOJu0Yzle6uBKGJAVpBnUc8dkD5RkLpwdsC3xa/XQHNkOJJrs0EApXec
 85eVzFovxcpJnO1NepznSocC+fs8r3FmZy+ORsUYCMs01x7e6LKM
X-Gm-Gg: ASbGncvhzz6DAwfNqikbd9qh04Dz2A/V+2KBPzrt+WQKwaytvFdMHG0uPbcbWbYsEW1
 eNytpiFVFIznqLX+OeV8n2U+Pr99WB/odfT26fEAKO9jH7GWHy++Yvo+A4ah8nqkIJSxa3pp+LL
 osmVyEs2ol/20cgn8iicJvRakc8FvMv/I9i+Dwdsg7jKjdekbKADslVynXxhnGix2Wu5KlwmbcU
 7D/o93BADlotsv7WxoyYSVSrYOGl1ymtQNVNsc+a+n8BCVH0HXij3tK4s1HFxsopXnhmbzsp7Vc
 7135J4LCtDGdGoHdiKKjrE8Cu9uj0IJ6P7f8lY2RE34E1slTS4lK9LUcNnAp5kQi5XgZVE5EuQ6
 tz6aoEmHxFrgRD10l1Q==
X-Google-Smtp-Source: AGHT+IEsrVmOraVETlkvKYF/Im1o/REfu2T38/MocL8i7BBhOi6MvTG7TbI+CGv7qg87jMxV0RG2Ew==
X-Received: by 2002:a17:907:9801:b0:aca:d6fd:39a with SMTP id
 a640c23a62f3a-ace5744ffcemr260066966b.51.1745504439113; 
 Thu, 24 Apr 2025 07:20:39 -0700 (PDT)
Received: from ?IPV6:2001:9e8:aa:4410:e859:fe35:73a7:e4f5?
 ([2001:9e8:aa:4410:e859:fe35:73a7:e4f5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace59830f08sm114072666b.26.2025.04.24.07.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 07:20:38 -0700 (PDT)
Message-ID: <961001a1-c951-4b1b-ba77-9b1ae2e0030b@gmail.com>
Date: Thu, 24 Apr 2025 16:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: octeon: remove unused middle expression
To: Bryan Brattlof <bb@ti.com>, Aaron Williams <awilliams@marvell.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250409-octeon-middle-expressions-v1-1-fd6248e6975d@ti.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20250409-octeon-middle-expressions-v1-1-fd6248e6975d@ti.com>
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



On 4/9/25 19:26, Bryan Brattlof wrote:
> !A || (A && B) is equivalent to !A || B
> 
> Drop the unused middle expression to simplify the statement.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   arch/mips/mach-octeon/cvmx-helper-board.c | 3 +--
>   arch/mips/mach-octeon/cvmx-helper.c       | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel
