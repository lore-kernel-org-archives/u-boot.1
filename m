Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D37C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 15:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86BB879FC;
	Fri, 23 Feb 2024 16:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ckaWD9gn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9460879DB; Fri, 23 Feb 2024 16:03:13 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2868087A23
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 16:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-787a8430006so51520185a.3
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 07:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708700580; x=1709305380; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N5vxj9nT0r92e8GjPdJno308Oo3GEByNrSguREl3094=;
 b=ckaWD9gn6XHsVNs6CFArDbHcqp6e3ANgkFKuK+yQAyUSuCx5r90bZTZi7lha427PfZ
 Uqi/tPRnK2my1keXyjgOf/03y0VIMMBle2Om19jjrI4U6vVXUbrCI4YySeF7ak5icU6u
 jDmT24DE56Rv0nZc9Mr9MEGfpuS4CqDs8BaEZYTiBlk2qXuJDLC5xuVq5QepFlz0swjD
 L/HRXDM5CHfh/tTiL28XmYoKemho3HM0BZD5KJobLvXzrPZCcpTPfwQQMiKU7RisEpBv
 cbciTkzmO0XJ5tC+DcJY8eR/DkW8Oy7yFllGrgDIe/LvZWsCC/Csu1q1zuMXkLF7+Huf
 kJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708700580; x=1709305380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N5vxj9nT0r92e8GjPdJno308Oo3GEByNrSguREl3094=;
 b=uYUY+KqSW20DUGIrE0dIzBzuhSRdvwOADU68GiWz6EJFdwJVbjWpdc0Lreyh/jNQRY
 eF75pirGmsBi7Zpo1QMI5L0dClvq2ZI0rNzKpJQCl5dDLzfa9yJZjRWyZWwN6Y6hzDfD
 C8eevly4sarWdsKKgWGZyQdqeDN69QQ/+NRbSMpepY81+eBunA4FDV9I0BDU2xMzCM8J
 36oxAy8pYLgcQpDxK79XUPDkkONBvvV7U0gipO7+gARzB13/SnbGZIkdwjqJX9QXVYz+
 RBpkPvS6waDdKDhu5ebo/Wp1qMeHIqYBFR0F8cJyvOxlIjyFuqUYD70d7Zd2rOHbLoLl
 77pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpSJtPOZyRcQHZ5/oooiz2cgtmd5pQIJ6UBJIDMj5D9f9aHXi2DWCnIP6FEHu97icTv3rodzcauDDsx24IjwDuuHx8+g==
X-Gm-Message-State: AOJu0YwFRpKiXlDLBmxTxGU4aPkAjg3UDFNHd4TEkL1i3nc/xY7HsSKS
 T3gRYNgh/kunBYOIM5pGmFM6A8CRWP2QjD0IQEh20W/hTJTfOKoB
X-Google-Smtp-Source: AGHT+IF+mp/TJQYJ9aWhkGeV6ikb3aJPvBjGsSxp63vIavgn3so39xSPE0GkggbdHlR1BXbmRsyNQQ==
X-Received: by 2002:ae9:e507:0:b0:785:d64e:7165 with SMTP id
 w7-20020ae9e507000000b00785d64e7165mr29932qkf.27.1708700579671; 
 Fri, 23 Feb 2024 07:02:59 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 z4-20020ae9c104000000b007874e64c879sm6275718qki.116.2024.02.23.07.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 07:02:59 -0800 (PST)
Message-ID: <6ac4ff14-67a0-75e5-5763-d671d3cadcb9@gmail.com>
Date: Fri, 23 Feb 2024 10:02:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: Revise help text for clk_get_parent_rate()
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
References: <20240223120120.1605788-1-ada@thorsis.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240223120120.1605788-1-ada@thorsis.com>
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

On 2/23/24 07:01, Alexander Dahl wrote:
> The function returns the rate of the parent clock, the previous text
> made no sense at all.
> 
> Fixes: 4aa78300a025 ("dm: clk: Define clk_get_parent_rate() for clk operations")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>   include/clk.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/clk.h b/include/clk.h
> index af23e4f3475..045e923a529 100644
> --- a/include/clk.h
> +++ b/include/clk.h
> @@ -444,7 +444,7 @@ ulong clk_get_rate(struct clk *clk);
>   struct clk *clk_get_parent(struct clk *clk);
>   
>   /**
> - * clk_get_parent_rate() - Get parent of current clock rate.
> + * clk_get_parent_rate() - Get rate of current clock's parent.
>    * @clk:	A clock struct that was previously successfully requested by
>    *		clk_request/get_by_*().
>    *
> 
> base-commit: 7bb761c42d75b2ebacc7190a76cc5385cbba1045

Reviewed-by: Sean Anderson <seanga2@gmail.com>
