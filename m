Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E857C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 21:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B30980F6B;
	Tue, 22 Apr 2025 23:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LzLvDnvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B897B80F9C; Tue, 22 Apr 2025 23:23:56 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C1D80F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 23:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5f5bef591d6so9838651a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745357034; x=1745961834; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BEeypp1h39Sf6T1kdMR1EAQjcFDAlyQolX4sEEdY+08=;
 b=LzLvDnvfAH1KxATbbKcYeYfzyhWinRgDcz3MVvLUI34MPZx1FjeyjRrwMLfVyyJNcI
 t98vBrpmBdjvlhh4ygUf131VyWk//iEq7nwvqoPUib8ng4CMcsdH2fxVRV8BtSsyv9fe
 dK4rQrw6+/EuoE7VqrUYQgCqdux/uz2970nrJpMCjpC6ALBA/9ObLNOQT0b5k0UwLwO1
 tHsTPk5MRvBeT4kvOmphpd23Mm2kImcqjwPkR2hEQfaCwWZ1J4WoP6Fmeel7TEdOCbXS
 ioC0cB52rrsAy8UL82Vci1aQbRFeOKg/mHpWzQ0T8lHW+iSKC1LTYfEkqiVR0Nni09Xy
 OYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745357034; x=1745961834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BEeypp1h39Sf6T1kdMR1EAQjcFDAlyQolX4sEEdY+08=;
 b=ne53Xq6F1XqPu75EHhmEigaNWgahdbSjhE4JFP1VRjKDQ8XSvFWm31FNNFQFs4UHay
 kEMNax4o7QibpsTuKt3pRRudDNy4cmH9rLwO8H1Zb2ebRRuueeFxsRHmFQBhgNGCoSot
 C09TFPL/pz3HNupT9Pqdtsm3GIfa8BC2KUTnFdEgDX/pmE7Ak7SDj9XPusf/HvXMzK9H
 yIs4yhv6tLpdPRSl8NOS6uw43jNnRfj9qH6uVJOTwI8tXVkfbWEg4pL1Y/Ki1evWcfHc
 EW/Fzh92jFctEJ0QW/t4NFb+RZb1BDlsHzoEiTVy5D5AxJBC0bbh87PyFbVJTnba29fW
 spBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUme11GKYI21pdXDUmjOnX4Ofa3mOeLLi8S/NI9B0Nzqpbh82FAmYUKcWbdcT7qTV6xYhGGu9c=@lists.denx.de
X-Gm-Message-State: AOJu0YwbIQ+xVHGRjtwIu1FJqqZ59SDB/vilmUHl6F9CTIYciRgycG1G
 Zhakh5KhGTBxAXql8WaiJSCuHL24eHHcGqY7+Rpfpdjnp3E7gGsU
X-Gm-Gg: ASbGnctY2DJw073/Df/GQzW8OW7sIDDU4dg2sSDUfEyvB4lvWNjSntix7T34Ac9qVLU
 CyyEAUTQZHJhw1CfniOUiBmPkTrM9qST38oB1XLeR/FsFsmZybLkIAoiG73f2nglmYlHq/joj4g
 3ambaGgDvMZV9myvGI4dydB4TSbVLFPoNdm1MvOPTd8LrSmF/zfLaP4ZA0+Msymp6avLHAQaqXt
 9Iyf8FOf4YcMLoqhIa7CHTQt8L1mCY993s0DSglOix4DM4F0v+L1bVuoS4uo0S3FUD50d2ikNxq
 HLWbczCX4Bv11mkVuhnIk2i7OWJOfVEEBynWyLzPGORexIpsfciIZDPcTYEl7WfHFVMBlz6IWjL
 V7YoTTIIpv4ZLN0I=
X-Google-Smtp-Source: AGHT+IHbRrjTVzzoPkZAPaIcJLv02tK1xXyPQFiACUIbqJF5WTNC+xqdt+r0vBgZvuQZXdPkBJxGYA==
X-Received: by 2002:a17:907:d1b:b0:ac3:4487:6a99 with SMTP id
 a640c23a62f3a-acb74db7e5emr1573011166b.47.1745357033946; 
 Tue, 22 Apr 2025 14:23:53 -0700 (PDT)
Received: from ?IPV6:2001:9e8:b6:eb10:20f9:129:a444:dc12?
 ([2001:9e8:b6:eb10:20f9:129:a444:dc12])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ec0b706sm696303566b.22.2025.04.22.14.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 14:23:52 -0700 (PDT)
Message-ID: <920d137f-75d4-43c0-ae56-fc3f5213e4ab@gmail.com>
Date: Tue, 22 Apr 2025 23:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] configs: add UNIT_TESTS to big-endian Malta boards
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Paul Burton <paul.burton@mips.com>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250422185510.11561-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20250422185510.11561-1-heinrich.schuchardt@canonical.com>
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



On 4/22/25 20:55, Heinrich Schuchardt wrote:
> We currently only run the unit tests on low-endian boards.
> We should run them on big-endian, too.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   configs/malta64_defconfig | 1 +
>   configs/malta_defconfig   | 1 +
>   2 files changed, 2 insertions(+)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel
