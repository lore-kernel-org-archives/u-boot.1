Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E18CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B0E83981;
	Wed,  8 Oct 2025 09:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nw/jtGxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE072839A7; Wed,  8 Oct 2025 09:21:45 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 434FA83956
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so4041384f8f.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759908103; x=1760512903; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4A5Wk1+xx8834C4MJdSI5fDTe8AO2Ytq3rY3XFupR7Q=;
 b=Nw/jtGxi71Ic1LaFX5oWmosQMJ0YYf6sxoR0dyD4I/7tEP+JTUSvMDVPTfHW1/hZWR
 3zD5OES0yKbncDJCpGmDVcA28fiKepF3TPYmeHjHSUpehWQJhKodBwG0FxXdqifblkaz
 Y3Qsy0DWikY8sAYY2qbYiMr40SItchgSqXzqdXBRSfUoHAAjTjS4U3/EHw1l2RsMyycu
 J1entvURxcUtA33FQ3q2SlN6/Nmb+/PNCzgqG3Eahk5WxJfFGKUrXXNIxi/FFvWTGlbA
 xnKgzb+vRIVlA50roGkl7ud5O5HFhogZcfH9yNCclT2s3OvgNb58VRJ+t5lHfzf5z/hs
 0aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759908103; x=1760512903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4A5Wk1+xx8834C4MJdSI5fDTe8AO2Ytq3rY3XFupR7Q=;
 b=ffjBCJ930PgoCk/PnWFWeP9IVS70IluQ9NhgqdEBe+obNs1DW323V6XhpsU3WLYnHt
 nCdgWvkYQT2HTYDy189RQpwnBSO0rVI8qt/1nR5itVrhyKfnys2fBTcjy4ONf/AJrzhT
 Lr98oqEHIg2wV7MOL0opnym/ztN7papsoeXXAACwkMpnFZcOCW7nakYIYZfRDYfHKan2
 gX+TDAnAedgwNbbVIgCmv8PJEGpjshJI62VAHXjbS6ZEZJZkOnr31ZX6311XL7FGlVx7
 rJpZqcYffmbI+OjCGCpN2ltRCvHTrJ2HrdEANvbB2nv36mTQ138LTXXrIp4GvldXQxZ/
 RGfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcuXSXbmI412L+MmYy+45zfIuzku3scNGNe+bdNQELg6IhIKNJtKCUiA7kQFL4q5CoiAHe0qg=@lists.denx.de
X-Gm-Message-State: AOJu0YwnUA0TbFeXmEHnYIQNV4CykqciMWnzU3a6qihHQ3Qpc9hHqthh
 gdNy5Nue68E5KDVzW4EsVJJkr8Q9At6RH1Tl62KAMoj5FL0dqnoAg835zbwCIAUiSm1AS7NS51y
 wrrx6VRM=
X-Gm-Gg: ASbGnctYeQXN7tZzm86MsY4tbuZgYOgIV+qgRM9CEStiFWY487jTlIARf2547cQorQy
 jxCFl3yIM/jXrwwTVR+34NesNWhK5sdXwxZtMcdpO65UG6ipqsh5NE0dZt805S54BElZS8toaB+
 cqoH28Pmfz7iIZvQx5YkP1b+iAYKtBcPo9hTkYZH9WrRZRWxTHwhAFHpFA6ksPY6lbX3ErDDOsk
 FHmQm7kNSpw7477vVuOb5+etrKpeEyDq18vW1vqtpQlZktpuWh+kduFZOUuVX4unPUZY/5AAsQM
 n6hplWdCr9ldw/3VEiElCYmdIghE8ye62hDtuAYvYVpx1h1nc+DGvYLX1+4I9kFpuvE2sYhwG/x
 LBzvdHClOjwX7Z44lGSl4njBbFn7DT4BMxrNzz98CYZL0mW07O8R+73b5hg==
X-Google-Smtp-Source: AGHT+IFcX27IYpy0N6PAomHtftNBl3RB4SIDo9MIZ0IqcsfwfIPYOoZGzT3wjbZM56rBvEMtZyD+vg==
X-Received: by 2002:a05:6000:1862:b0:3ec:ea73:a94d with SMTP id
 ffacd0b85a97d-4266e7dfc44mr1253890f8f.37.1759908102705; 
 Wed, 08 Oct 2025 00:21:42 -0700 (PDT)
Received: from [192.168.0.26] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01a0sm28342256f8f.48.2025.10.08.00.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 00:21:42 -0700 (PDT)
Message-ID: <4f2bcf39-2b8b-423c-8b36-db9a65573248@linaro.org>
Date: Wed, 8 Oct 2025 10:21:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: sam9x60ek: select PIT as tick-timer
To: Dharma Balasubiramani <dharma.b@microchip.com>, u-boot@lists.denx.de
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>
References: <20251008055636.17462-1-dharma.b@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251008055636.17462-1-dharma.b@microchip.com>
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



On 10/8/25 08:56, Dharma Balasubiramani wrote:
> U-Boot currently enables the UPLL during boot, which triggers a udelay()
> call that depends on the system tick timer. Since no explicit tick source
> is defined in the device tree, boot stalls on this board.
> 
> Define the "tick-timer" property under /chosen and point it to the PIT
> node, ensuring U-Boot uses the PIT as the tick source.
> 
> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> 
>  arch/arm/dts/sam9x60ek.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/dts/sam9x60ek.dts b/arch/arm/dts/sam9x60ek.dts
> index 6521585ee9c..1c09c92ae18 100644
> --- a/arch/arm/dts/sam9x60ek.dts
> +++ b/arch/arm/dts/sam9x60ek.dts
> @@ -17,6 +17,7 @@
>  	chosen {
>  		stdout-path = &dbgu;
>  		i2c0 = &flx0;
> +		tick-timer = &pit;
>  	};
>  
>  	clocks {

This property is not in Linux DT and not documented in Linux.
Please move it to sam9x60ek-u-boot.dtsi

Eugen
