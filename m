Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D39EB28F1
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 08:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C74158382A;
	Fri,  6 Feb 2026 09:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jIsyRaJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B94683AA9; Fri,  6 Feb 2026 09:59:05 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C05836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 09:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EC9B33F784
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 08:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770368342;
 bh=hprd8HNwqjlTabxHn88RBzKQ6JZl7HU7M7VnNkkTfBo=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:From:
 In-Reply-To:Content-Type;
 b=jIsyRaJ/QQSrrmD6kly2IIO8IS49gdcVOaVjtZqvp3P0Qq41RSKv91fiJFCsc23yL
 LNLmzcXU7uFfO+NyWxA923a6wD3WVmkYGQoFIAJr4Rr0mJfi8qtBCLpVrfIQFUysyA
 fupj2ij4/cUu9gwZ8xD1yBRo3CLZ9vRJTfr6IHjisLBxdPBYALSTnh1QI4VjEpYE+B
 kOeNH05hW+6+2si+5f/HqUcj74q4aDeFrcafujRmSdHHZrmSLO/TOeqtoH4U/8QYh0
 n5RRv5bvu/ZHzOEtATygK2X7z+8rYa+hFcLxrrkHVsSYFzjBIntTPYr5yxN1UvCQLn
 SPUWSiCtE4P1di97QrZGrEviEmAZOdhFG+1enmYEZGEUjLAPwX7hdJJhiySkvZtC9R
 XkClTmZMrcIhVJMLdoE2WHP49kcT/eTalHeXkvp+AJ9QKN6sdYgO/MwUYEC63MLYu/
 g8NuhtuRYXXuhHa/M4WfNHDgBjaAWb/loMkg94BeDbTcvHXlLyMUkGr2GqaPJQDTTs
 ZwqCNUJ2j2LfgYMn/t8k3gmygsW8qT90aZNRp6fVV3yYFUZmXx/F82YJ3cGczUr4FL
 +/Es9/eZhAwhOVGzOITVq7HYfS8byeF0ULdrLYQRhsXwZVxzcE9PV7onnHh0y3wuwL
 cbDXqX6O8gkHQCPTaGkBxERg=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48079ae1001so3907715e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 00:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770368342; x=1770973142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hprd8HNwqjlTabxHn88RBzKQ6JZl7HU7M7VnNkkTfBo=;
 b=VBVj1U3j7rziGay5+vDt7BOnG2rcGsVmsAsWolb9igH5Oerp2CUtGb+QGN7cgHpLrU
 ASjmPmxumR+A5E+1PTgv7+fVpuVUjxYuMAD/rgb+npY5jLUhxcbvMyn7tRYk490oGk3Q
 XYmB0kXwYA5AHjQIsIV2UD7rFjBpdJC9Jil01TEjwG7yXBa1t3utWgbTiX2qoMaeJpHJ
 jjLgm0md3wWjb9kHzejW3k+jwUMfdPbbXCNSe6kZdDygqIj4LDDe7tTeVQxItiFJ4Zal
 RZaGvZDJskLfYkcY1xr8eQil3ryXhfuxbuPEz1OZ8lNamvYFK8E5Hysj+YS6nq6eICQG
 BFiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4CAjitHW1cwmC3yqRwHtCIMc2IpHKEI9Y+KBLByMupMbSmc2mktW/kVADL1RO61+EoxaK2lc=@lists.denx.de
X-Gm-Message-State: AOJu0YznibZ3r8lVclIiHvEHdd2pFKDguj486kXpkovodFw+q3ebL8bt
 EojVPNNVmWGwjWUQrWjvZ+LiLdHgVO6dqudwPuKlLUf1RRf7KTw8n6eUUcyviFQcJCmwkQh/ezP
 taqbFy7w7ck0wF+qzQEh0K561J8p66/vkxD8MleHh/sGEYfE2vOuNehNuDe7fsUp+jVCtd/o=
X-Gm-Gg: AZuq6aK/ToEjYvBRWCjW1BuEUXRO/Sx5L/yJsgfUCwEjm7WJiVQA1sjXORDuS0RLPFl
 Mu5Si4BlKxcJhsDOaK9b1EXl01NEbiH4JRtSfesrwC9/O1g6MSxVeO3chXbkYApT2UdTnMuX0OX
 FLPKF5tAWO4+0Fv0QjPKNPY92aBHtgmokiYnzdD+88salpcPgkfeh2LRAerOTLkTLMcZPSsW3eH
 CHaCXuSKG29jHb3OToi6ebdqrdTgFl7zAmYKIsqUYRhUjD8Jho9qpBM2aRruXlKZWARewcUVI9m
 Ty2M+TA2FFaB5tLM1olVBJ861zSthgsz8JIgMp+pr+ME5PtjQaH+OiVnxkMWMbpc7ROQrIbSjOV
 ki8o4LGaWhuReLDNpGxbG13V9T/g0ORUiEnjRFUfiralix+FYDB6xTLNcB378er9orze4ojCOXZ
 97vcKTG+4=
X-Received: by 2002:a05:600c:8116:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-4832021c74cmr29236365e9.26.1770368342457; 
 Fri, 06 Feb 2026 00:59:02 -0800 (PST)
X-Received: by 2002:a05:600c:8116:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-4832021c74cmr29236135e9.26.1770368342044; 
 Fri, 06 Feb 2026 00:59:02 -0800 (PST)
Received: from [192.168.103.128]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483207286bcsm37316905e9.12.2026.02.06.00.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 00:59:01 -0800 (PST)
Message-ID: <7d65b844-f11a-48b8-bb1f-383483cf3cd0@canonical.com>
Date: Fri, 6 Feb 2026 09:59:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Remove pip from requirements.txt
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260203151303.1418027-1-trini@konsulko.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260203151303.1418027-1-trini@konsulko.com>
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

On 2/3/26 16:13, Tom Rini wrote:
> Our documentation does not require the pip package to build, so it
> should not be listed in our requirements.txt file here.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>

Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> I noticed this because GitHub dependabot filed an issue on pip, but we
> don't need it. We've diverged a lot from the kernel in terms of how we
> handle docs (And this is fine), but I think our requirements.txt file
> needs a closer look.
> ---
>   doc/sphinx/requirements.txt | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
> index e313e4f09468..c616c75fefc1 100644
> --- a/doc/sphinx/requirements.txt
> +++ b/doc/sphinx/requirements.txt
> @@ -8,7 +8,6 @@ imagesize==1.4.1
>   Jinja2==3.1.4
>   MarkupSafe==3.0.2
>   packaging==24.1
> -pip==24.2
>   Pygments==2.18.0
>   requests==2.32.4
>   six==1.16.0

