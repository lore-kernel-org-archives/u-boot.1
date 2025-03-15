Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E041BC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 19:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D5BB809A4;
	Sat, 15 Mar 2025 20:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sSbyBgaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C3180F9A; Sat, 15 Mar 2025 20:01:34 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 422F8807B1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 20:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so2789726f8f.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742065291; x=1742670091; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BiorSvMYuRZsMgDCOC/26u5gcMj6gxOwotCLVQEmqn0=;
 b=sSbyBgaVskto7zjKjK2Ei1XmQt8wtLmf0s4159INo9odmG0uDWtFmPT/1oXNumcgzv
 e/TW9hhj9YPdqbv1DBCtpFByUztjDxsA6dFRq7LZFHRC9ZrxaRNaa036Bp/IU4vZSOWm
 lONm4AOrGOuxOt9u0c3Mo9R4PRznJY1kya+6m6zUiMpFgHwa/VktYU883aj05WpVhOmV
 RBp9WFeB89KJgrvs8TCdAQoUslJkAPYTCjGDx6EI0E80Abm388B+SEjWjD5ifhYBi1Z2
 /iuLqWIhYsklXrl57F24QBRAyJRbFFp+gF1r7zueYrmUGH+OGqxpQNwDhJwByFSgLkb0
 lTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742065291; x=1742670091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BiorSvMYuRZsMgDCOC/26u5gcMj6gxOwotCLVQEmqn0=;
 b=t4g0rN4QHlRgDA3rvv36bt1YPFC38+FilyqTVXoPNSRsHUDB8yW7M/ya1wbWFecMGM
 9bmaMpDOR5FResHHIRHTaacmkcUhXKmpiplmqIcqtsjQpPEbi/y3nFbydzzAtVwfHhL1
 kCKtkqOl0Kow2LrkN+O4q6ifv2zrkhzAPJhrenCPZa7d6U2p47ahbbq1qYNBRT6InNK9
 q/+G+D4hqn5rukStBfpNK6AO9FP8UMKebUBihzt4o/ckCk8qsk0RTu2s0QB6fqjQ4mFr
 PRfZ+4PFJDuj4dTLepmUhgb86YQxVLe1UVmh6ZOIof3Pufd/gaN+CaPRR9hZr1ylScQx
 YB7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg13PCNdobd2LuvE7k0JQjV1Eb6vQu84HtkvYT1RJsn0Xpqb2t12pY9SuIhiKJxPmwx+lZNmk=@lists.denx.de
X-Gm-Message-State: AOJu0YwkijKggmRkw752eFn8ryxqxRekoLnlKJwr4oDyz0TCfsrTckz2
 k5GZKLdIMFCCV/D3ENuBNcLM163lBazZ+bJZehvHsqi03G3IwY20yOyvdtgAH50=
X-Gm-Gg: ASbGncscc0cagayqB4WllUm7XCvndz1fK9VBNH8w6wVtXMi3R6SHVvmurCN4ghJOma8
 OtVs/LqhIJB0A9HnQ6vLzqCyq1nIBL6zoFdNkuLfeueuPJHxBateQBT5ygGfbvBgnuk2jO0x/zQ
 8/cg+fN6gvTsJHI3LTXhPDTVW5msvcCLNkGtdDMV09FGwRX40hjRSRvXqcKWX/nEBUhfsEECrwS
 Kc1NGJOcdW1F9rBBRcYW3q0kR79Q5M1cLAzlEF7zZiDbU2uSpWCMtx8/piAdCqA3wyxPIm4djM7
 az+GEMLNsZPLR9tFn+2F9W7xub9RRcQsGySlCZDRPxcEEr97ZWYIzn3dxveKW37JZSi5KaBLwYD
 0k8YRa8a/YycVkAIlGxzVE9MmdA==
X-Google-Smtp-Source: AGHT+IF9DL4f2dAU3OYJjoO7LSzSRgQD0W+CWYCJi9oru/yYBVStK2BfAzijrOvykxYKI4kufoIkNw==
X-Received: by 2002:a05:6000:2c7:b0:390:e535:8758 with SMTP id
 ffacd0b85a97d-3971cd57c70mr9296988f8f.9.1742065290708; 
 Sat, 15 Mar 2025 12:01:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:b200:8793:a229:149a?
 ([2a0a:ef40:1d11:ab01:b200:8793:a229:149a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6b2bsm9598780f8f.26.2025.03.15.12.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Mar 2025 12:01:29 -0700 (PDT)
Message-ID: <c437fdb1-81b5-455a-8c22-85424346a345@linaro.org>
Date: Sat, 15 Mar 2025 19:01:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: change the return code on lmb_alloc_addr()
To: Tom Rini <trini@konsulko.com>, Ben Schneider <ben@bens.haus>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 ardb@kernel.org, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Nam Cao <namcao@linutronix.de>,
 Baruch Siach <baruch@tkos.co.il>, Sam Protsenko
 <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 u-boot@lists.denx.de
References: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
 <at3MKdVWObOe2t0ulEO_390BtudxQ52-_iW2VGgpz0spI-UhNxRfC9TCtcUduXUIHSuBPt7vTR3iC4bOhT1IZTyI9hKIrHhBt8-82P4PIqM=@bens.haus>
 <CAC_iWjKGxqF8L=3r1-EuDN=Jmb0rPV+-54+g7x79m8dm-4o=yg@mail.gmail.com>
 <OX9trAy3JSNd8o9Ho8NejmCIh32WQR9El_tPJG0UAcHsn_TB3VsPbNFz2l5E0hXPExObST2VM91xgLD5Ak1AvY3xRgQQEHz1LZCwadhyOYI=@bens.haus>
 <20250314234608.GG2640854@bill-the-cat>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250314234608.GG2640854@bill-the-cat>
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



On 3/14/25 23:46, Tom Rini wrote:
> On Fri, Mar 14, 2025 at 11:26:59PM +0000, Ben Schneider wrote:
>>> Thanks Ben.
>>
>> Happy to help. In case the context is useful, I wound up here
>> because I use U-Boot to load systemd-boot which then, in turn, loads
>> the kernel. Unlike GRUB, systemd-boot does not provide decompression
>> and recommends using EFI_ZBOOT[0].
>>
>> Perhaps it is uncommon to: a) have the first good memory entry
>> start at zero, b) use systemd-boot instead of GRUB, c) use the
>> compressed kernel on aarch64, d) all of the above? :)
>>
>> Thanks for everyone's help!
>>
>> Ben
>>
>> [0] https://github.com/systemd/systemd/issues/23788
> 
> Oh interesting, so now we're at 3 years in to having some form of now we
> can decompress a kernel image again.

I've been using ZBOOT w/ U-Boot for ~2 years now on ARM64. Can recommend :D
> 

-- 
Caleb (they/them)

