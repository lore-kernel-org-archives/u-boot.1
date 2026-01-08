Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2CED232D1
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 02:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4B98415E;
	Fri,  9 Jan 2026 03:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hLR1Thdc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58122841FF; Fri,  9 Jan 2026 00:58:47 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2BF84158
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 00:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c78d30649aso2605716a34.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 15:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767916723; x=1768521523;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ftFkuDxJu62/HGNutpsAK+A89P52XDJIt7zgk7UPW1U=;
 b=hLR1ThdcB/xwy6+bJQvgEN1Va5l992ddMxv/NyrQ7kghyggYv0BHi01V1Eu9T+LBV1
 pKZcpRs8/VndLXdUfJJxi4doKrBwtKDeZqc0oUptCtuBocaC/dZOBrWlQYotO2FZarmE
 IdfbE1YCjFo5UV2D4vZ+QmUI6XECLtR2JpLrIu+wXjbioZzxf4Y2tPS0zS9w8B7W+5PV
 wHZDQl8qansvEq5yznh+GKkxn+glAYIBjv2dJuKcHcGh6LHnfhO6rb3Kl5gCvQEnU0Wv
 /ilcQ8KnYcv7zu40aFU9EjQTK4WQ1D5t/4xKA0szCEL8DlLzu1At4WVngQj44naQY618
 eq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767916723; x=1768521523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ftFkuDxJu62/HGNutpsAK+A89P52XDJIt7zgk7UPW1U=;
 b=sdaG97IY8HhmnWAtNCApslFtUAIS+AoqcBjAaLSsDvcf+C2CdneelSLINnVzY0RIr7
 2ZvvkvJxiB1/c2IAYknfjoRVXaS01X4xFZ7jRWt1YFc8BXhQZn65dpgPF5/W1YSTqda8
 9yXHTIYBbuqPDLURoDKNcfWcdqW3OFzQaiMs+DiGWqRn1Vxh4ShqXTX3r7eRG/WbF5ue
 rNJw4EGMlBOsSlYLFEZRR/IHQllQ2JlBlaxGFPV/M+lknZ+W9gyO5Q0ldzY8X/PrmqSo
 dqyOKDhNgtKhPjbsshNO9982q7zG61Xgaj12tbmRWZS9HVAvJoRH/PrRsVarK7MM/OGq
 4C8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQYf7+VR1FxtIm8Aim6NJRhII3AROgO/l7oRdp56wpxlSQ5Q3KrTM5cL4IBJLEARHfLYVgIOA=@lists.denx.de
X-Gm-Message-State: AOJu0YwVCU6oIEBFLIcMXgVxIWDEhSS8kTQ2bFNAXqQDQQf+UGaJIEu0
 0ufl+r9A7JCeIuX5E29qcL7fbOjhe6svdBartOudl6Vah9qELkPls6Sr6/YLI4GH3zE=
X-Gm-Gg: AY/fxX6ltPppaBDmXfsNEP5Vz9GmXuddJ6D1AE644wyXPSsiv83o1unQYMVjIC7bMMF
 c3ezYkfXYQyyPBB6H2a8xpTd4cgXIasMZceWhNdt3m5VZQqAVp/rX15g5UxBL9GdCrzjuEsFX5Z
 BCHEq8dcAdDWVcevBIAjEz37wBfd5XXQ+pOQ1Ae9l14g0aweXk5TWZLg6fX6+4zVCuSs2558HU6
 4sry/o51aJAxUndb4oYSaZkeuJqLvLrlYpwRDP0q5iWh7CJ2LRDMspnF4fSoux4Fx/YC+8Cv/gg
 BrT8LD17IJ1OVt/Gk5A7Vu/+GQWod8NCYDnEK7FpWPXmjQCBGmTrnGsl/DU3Re+GiWaVu++/h3e
 lWBULgGwRS5F1jO6RjK6dafCIxb/nM1TWafOcCNXozUlcPOO1hy9sGuQ3t1n782LQjWeA1tNpII
 10beiuZ5fi7uI1kIvJyaWke3o6dvo2mccrJ4zforoZt+t2Xz6X+7i5NbBDU78r
X-Google-Smtp-Source: AGHT+IF//LTyL9fhz0QfhDj8e2lozNqdVBTsCyXMJELisaj7d3EJB+O1abvPV3SpGe/psVPUqFce1A==
X-Received: by 2002:a05:6830:230e:b0:7c7:595d:abbd with SMTP id
 46e09a7af769-7ce5091eaebmr4242662a34.15.1767916723633; 
 Thu, 08 Jan 2026 15:58:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c69c:7b5c:ce9b:24be?
 ([2600:8803:e7e4:500:c69c:7b5c:ce9b:24be])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce47801d4dsm6357878a34.5.2026.01.08.15.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 15:58:43 -0800 (PST)
Message-ID: <24133fec-ca54-4d83-b243-6923c1999260@baylibre.com>
Date: Thu, 8 Jan 2026 17:58:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Do not return signed value from clk_get_rate()
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Lukasz Majewski <lukma@denx.de>, Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marex@denx.de>, Michael Trimarchi
 <michael@amarulasolutions.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
References: <cb4ee3c0a81dda3cbad24ca4b6f69f8a20b29f53.1765971445.git.michal.simek@amd.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cb4ee3c0a81dda3cbad24ca4b6f69f8a20b29f53.1765971445.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 Jan 2026 03:29:45 +0100
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

On 12/17/25 5:37 AM, Michal Simek wrote:
> As it is visible clk_get_rate() is returning ulong:
> ulong clk_get_rate(struct clk *clk);
> 
> Also struct clk_ops is defining it as
> ulong (*get_rate)(struct clk *clk);
> 
> That's why return 0 rate when ops->get_rate is not implemented which is
> the same value as is return when clock is not valid.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Another alternative is obviously also return only long and fix all
> get_rate calls.

I noticed this oddness too recently while working on some clock
drivers. I suspect most people don't realize that clk get rate
functions can return an error because the type is unsigned and
they don't read the documentation. The driver I was working on
had a number of bugs due to this.

Changing the type to signed seems sensible. But I do wonder if there
are some GHz clock rates > INT_MAX on 32-bit platforms. Changing the
type could be problematic in that case.

If that is the case, the next best thing could be something
similar to IS_ERR() and PTR_ERR() for checking the return value
of clk rate functions, e.g RATE_IS_ERR() and RATE_ERR().

> ---
>  drivers/clk/clk-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 4420651f765c..bca818530d4c 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -490,7 +490,7 @@ ulong clk_get_rate(struct clk *clk)
>  	ops = clk_dev_ops(clk->dev);
>  
>  	if (!ops->get_rate)
> -		return -ENOSYS;

There are a number of places checking rates for this return value
so I think changing it could unintentionally break things.

> +		return 0;
>  
>  	return ops->get_rate(clk);
>  }

