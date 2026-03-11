Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F3F1125863
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 18:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30C8084035;
	Wed, 11 Mar 2026 19:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LHWyJJHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4B8484144; Wed, 11 Mar 2026 19:10:37 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1517F84013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 19:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso1795505e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773252635; x=1773857435; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q4NJ4UYpMmp2TWfS0c5pfqULHdvE6faxFoIAFkKwaU0=;
 b=LHWyJJHVilZnRxP/VGndaJFSdIqw3sXnONTdGTvuDwZV/vEWqFHGlGpZAn2+ViPNcU
 gY7VMBcmhtJuXT40tYxLn+Tn8nzf3A+ZNWFYsT5Nkxomt+ngpSl6qPfZidCq9Gzd1NyR
 fqdx2w56F8SpaNMCkfVVpQQZXrmWQ7WevgAy3KGncAXAr+5uBcOXxQcY2TutRmU3+wvw
 dgP5s5oqxRi3AADVOcRx8ICz2xpruBlT49kXxfyBKsixjl6pZaJzPBcl8tTMlSfIHwJk
 Ft1paQRQdSnJ2oHu4ZR3hkvgoM9nryAhgdrnvU4ath2LQA6C3Ynz719exfq2bFB3bghB
 9CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773252635; x=1773857435;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q4NJ4UYpMmp2TWfS0c5pfqULHdvE6faxFoIAFkKwaU0=;
 b=dtLJO2fC5PIU49HcNrUPQ1y9rITmQYbF8cHXEmjVlES27IpiSpmITcdg4a2fk24a5f
 zl1Nfs+h7u4WO5G3CQEP4zr9TadKfNqvg6u3NyBtLROOMg+JoAQ5/AZ61yIjE4+awgst
 lT1Fg9WzX3Ac9mE5giVQlKx7yZO48sLu9H25tcf3SDej/9pmEbk/Lw5CD7cFMPdkchPh
 Yh4bmWs2gYTDvW4XtxVSY9bskUtzUe9ARRoAwakjnTggT7jOUTcz5jeEYy43xzVU2CEF
 Ndsnohq/2xzgG+qTeoSg0KpR2FlC5xas5dNc0hWktH/8x8L6Bg5xJxsjUtzyDcsdmn+W
 5SbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjkgm3vTg06muccZM9PlndFIeVrAa6gnZZNbm77zrEqWYzSc+69o656ont86YXHvndMCWTSmo=@lists.denx.de
X-Gm-Message-State: AOJu0YwvT7sRnTqmC0W0vh26q8SBETiErXAzlBRma+SosUkly2hztGuz
 HUk4oh3WTyFCFT7MDyQa1H58mBkuscQyfwjOCRpRW24alNJ21XtqJ6kb
X-Gm-Gg: ATEYQzx1TcS8rv1h0TPqGM1kF0JY1j8GMc8navRRhFrgRExElnlsEl/SIVrSdFhy/o8
 njO618YMoByCiBIGxyaaU1SJ8fLnWdRYnNQSjBJAqBx4sRY47ZWOEaFsLGcxoC1BY+kHbQVukM5
 OwMonQjZ9zgmHZ7cmJaETqcL2THjkRfmn4B51N01jd+esuraiKm/CDOEDlm+1Zs4svx9wI1nJuu
 mmjIx6BwXH2H2tGDY08dDB6uaQAInGWWNY0vGNTnxGs/cU1HOJ6L4WQQ8PgSqv/r5w1abtZESPo
 1fZZuHlCxvsQwHdkITuk9tgwoblX99Y5KjSRscREX2Gif5jcta/GDZ0vOJ/06THgFpUS9RG1iYb
 w21DHl4epYoxi5dBbMg1VN75Tn9eRAc1qIal8M9VUlDvCV58iNHoHi26xnwzPBO4Pn+bAR6v5db
 j0lWAFELtcr0uZmDN1cAmaop2PxadoiCZXXCzTZCPLxvm1Jpl7FeumK9u7CgzXZZv9KdraPdu90
 yDJQj+7cI//6A==
X-Received: by 2002:a05:600c:3114:b0:485:4526:ee06 with SMTP id
 5b1f17b1804b1-4854b0bb7dbmr59155705e9.11.1773252635446; 
 Wed, 11 Mar 2026 11:10:35 -0700 (PDT)
Received: from ?IPV6:2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c?
 ([2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b66dedfsm70377545e9.12.2026.03.11.11.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 11:10:34 -0700 (PDT)
Message-ID: <859c8a06-fbe5-4a4f-a7fe-c75ad17fd3bc@gmail.com>
Date: Wed, 11 Mar 2026 19:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] mips: loongson: lowlevel initialize
To: sgdfkk@163.com, duhuanpeng@139.com, u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
 <20260311084129.12809-3-sgdfkk@163.com>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Content-Language: en-US
In-Reply-To: <20260311084129.12809-3-sgdfkk@163.com>
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



On 3/11/26 09:41, sgdfkk@163.com wrote:
> From: Du Huanpeng <u74147@gmail.com>
> 
> - pll
> - spi controller
> - sdram
> 
> Signed-off-by: Du Huanpeng <u74147@gmail.com>
> ---
>   .../mach-loongson/ls1c300/lowlevel_init.S     | 134 ++++++++++++++++++
>   arch/mips/mach-loongson/ls1c300/sdram.S       |  95 +++++++++++++
>   2 files changed, 229 insertions(+)
>   create mode 100644 arch/mips/mach-loongson/ls1c300/lowlevel_init.S
>   create mode 100644 arch/mips/mach-loongson/ls1c300/sdram.S
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel

