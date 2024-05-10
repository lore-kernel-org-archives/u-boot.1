Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81862C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 09:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E581388294;
	Fri, 10 May 2024 11:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QuZSqsDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6511088296; Fri, 10 May 2024 11:32:17 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B2588287
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 11:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9D1993F364
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715333533;
 bh=xyJdFLq9zQ/YL8ZlvgK59d5i54DQdJwz0p3tkZAHB88=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=QuZSqsDkP2BU/GFfM+TzzNXav/0qtfe88nB7cSpwa3tWFfVClznlEGkepIttA8Arq
 lq+oZiVSMiiAE6tMKK1AKM2mUcERZXQYRPZuyKc/e2e7yVIv2YKQRRr/tlFK+9j8ow
 Z1AbRA3Vn8gp6qlb1NjfTfa+pWFCs+iY4NJdNMB27uzCBMp2M5T69f9GgWSRB0CUcJ
 3tdMvRAkWh9bddqQYEjaiVMLWfeOrVUh7zTQT9w3Ys0dhgf6V57Kj+gTkWPiJnsjle
 1VksLZhK71rLP7FKis3yent4uIgQqn8Q3Ac6dYVRe/zgP487XGfBAI6arBJ6fuqRFp
 25Gce3T6GeRMg==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41ffb6bc28fso1462945e9.2
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 02:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715333532; x=1715938332;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xyJdFLq9zQ/YL8ZlvgK59d5i54DQdJwz0p3tkZAHB88=;
 b=gopW9fbKTtbhDlXUr00ovFGnFdZAGcrZ9NebLUaOZJjf7nbZPFKb0ThjCd0vvTQyvb
 gESNw1Gs0Vo9/00zRzgD0ylZQhL5+88BmyouzzADzUw7xZ2j4E6AAPtidcZ/PU7uGzo4
 FeZ+7E+NTVW6xow3II7QepCBZLcYF8+UVMSgVv7MzIZIHPYaiBEOTMMulKA/32hUa4oA
 zANxo8fXe6SCizw87b1O2V74B4nnx8+EP5p54ZpRiaqccOO0YgibmezL/jlKE2IKgha3
 cb8ugVr4uaY52S/YMAd6XC6HX3Blobu+HOYQyC0edfVvVpX8I8ll54UxKzUOMCWcJy5x
 8aog==
X-Gm-Message-State: AOJu0YwuFOt2UWwXZ2w8OJG4MmOFuUttD7EzExxdpVD+EpWw3b4CeBQT
 D6Y22E0vdfaR9RK4w0z36FEUYUc/rHglIWvlAzxfeq4nLvG7FMu/nldQSDM5SKj+Hs1CeDBNXsC
 vvM2ViCai6EMcCEDHb3zmTxsuHxUFrYVoPmEaJZgtg3QDHuKA6gm88BuX82gBUUQ2ANo=
X-Received: by 2002:adf:ef4c:0:b0:349:bccc:a1e7 with SMTP id
 ffacd0b85a97d-3504a6310c6mr2214355f8f.19.1715333532459; 
 Fri, 10 May 2024 02:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsCXCVg8aWhl1Ymv9jkEpvAHDPeJYmDu7B837DogNhSnAMTUBUZv0MNwayEuQ8E2cl1hkQPQ==
X-Received: by 2002:adf:ef4c:0:b0:349:bccc:a1e7 with SMTP id
 ffacd0b85a97d-3504a6310c6mr2214336f8f.19.1715333531990; 
 Fri, 10 May 2024 02:32:11 -0700 (PDT)
Received: from [10.55.2.71] ([149.11.192.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a7884sm4051882f8f.57.2024.05.10.02.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 02:32:11 -0700 (PDT)
Message-ID: <d36435ea-74ac-49b8-9d16-9494e8ed2cb1@canonical.com>
Date: Fri, 10 May 2024 11:32:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/sphinx: Bump Jinja2 to 3.1.4
To: Tom Rini <trini@konsulko.com>
References: <20240506212230.2948754-1-trini@konsulko.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240506212230.2948754-1-trini@konsulko.com>
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

On 5/6/24 23:22, Tom Rini wrote:
> While we unlikely to have an issue with CVE-2024-22195, it is simple
> enough to bump our version of Jinja2 to receive the fix, do so.
> 
> Reported-by: GitHub dependabot
> Signed-off-by: Tom Rini <trini@konsulko.com>

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Hello tom,

My review queue is rather empty. Do you want to pick up this patch directly?

Best regards

Heinrich

> ---
>   doc/sphinx/requirements.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
> index 5b4df36804b5..426f41e1a028 100644
> --- a/doc/sphinx/requirements.txt
> +++ b/doc/sphinx/requirements.txt
> @@ -5,7 +5,7 @@ charset-normalizer==3.3.2
>   docutils==0.20.1
>   idna==3.7
>   imagesize==1.4.1
> -Jinja2==3.1.3
> +Jinja2==3.1.4
>   MarkupSafe==2.1.3
>   packaging==23.2
>   Pygments==2.17.2

