Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1BD606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K2MmufY3;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X9q//+k5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B295D810BB;
	Tue, 20 Oct 2026 08:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ftYX95aKQhrd; Tue, 20 Oct 2026 08:53:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D0D07810AA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792486407;
	b=Nl+KMWb9mLA4q8TC/PeLFjDMkuxIFcfyUQpGv+3hCRK/CO9ZQkXR3+Da7O5zHJpU/je6
	 S0B6EQGyMOli3J6Mv2GlgytEfxtdKxwfpcLVEXUFODagV71xYpRzr8edRO5cBK6gcdBWq
	 A4TR9gNKzjsJna7SC8vtQ7hCTYfAy0fJzn3Zh3ccsmwOHjgcXKbyA7Uc7FbQWk6bb0JSh
	 Rr1novahyE82GQVzpMj7Q/X+GRY0O868jv8rQb8ipowix5UTwwQzVgL92kHmlLM07GzMi
	 ReyQ7S+CEw0C3n+W9F7sYbwl8qEd8l5bOEpIPF06AVN6UvvkkzhhppanN7TcKp7K4oA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792486407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=1eBZLDT70LbQFSx+szDq8JQeLywiXsIDEqFOy+UYbnc=;
	b=ZSDCBQvYUhJav1TdO1R18XuVMwpI1wvwmCd3imMZjQKfp0zv0IaE2rsy7RoM0WhsSL2P
	 OOmNJQaTiNhNnm4vjqZ6UvrYC5FPQ0YVE6sXpEF15uKM1KsPkv+/PwqMtqVbXVz2xzzg6
	 sfZjggnFyqKlCwGRAE5jbr8q3G4B3xP/ftgFfG9XBQ3dZzmaSVgasVxQhRSy+F/0YZD24
	 A/ColwjeYhb7x/+QCJes20RMg32t9snCIXuffPnq7olxNIiHaB7+f0GYnk1KeoF9d19+u
	 IlhMxfYCINr48mt8+vsdexL3QcoIWne2iqGie8rhXnkZ2uDqnK2EWGnfrYu613sp6rQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792486407;
	bh=1eBZLDT70LbQFSx+szDq8JQeLywiXsIDEqFOy+UYbnc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=K2MmufY3EIow64oPP6bVSekf5/7Y+8obiWaNFkshrqNJxInFU5zlJXsfJZJkpoaBy
	 8LFe5WbV9fh7rO67+3mrSiF5+C6pe59M0PnUX7aUtGn72e63lb4dGn5SSbXAOpxLgt
	 0qYVCsjWKhs627t/wXnvbjh+k4ktOfi1nBxs4I2NnzUi1nwdnR88FV7CbOCNH0MPMt
	 6AiyLIZPEcZCYyUa/GKb1ey4Fii5Pz1B08wTTN9PbFpHFHw3FIr0IQ/LrvGSRPy3pa
	 C1L33yRiYlP6EbMVYYPpenYIw8MKODNVahY5+mDV9B9ebp6/UqHw2v5zzJX9mzieMI
	 7TvE3gvzBM7kA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0D07810AA;
	Tue, 20 Oct 2026 08:53:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 56998279
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35E4D60846
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:53:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3bvOx0kgZR6b for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:53:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1DA136083C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792486403;
 b=RQXgurEL9aAR9J+3/FPmYgV17e0HEr8uW+cqbzYhbHBzSZrxZ8dLgQWc2so33XwCBW0U
 jxdywLkvcUnijtFd8J25oJGi7fyqEO3ClUMvlkuNYeR1NxgVF2EW80SkaplQd1o/75dxr
 6eUvFpXuOLMBanNmce3viz6ZX+yd/Q85Vhbncck54iEZgmqjWaYFisfAW5pAryxwk0SY0
 bRKK/7VxFQMOILud9Px5jzZYr2Ebr6AXta6zuxmS/kziWM+MKGXNRGwwln+Y5ObgHjHNc
 scA3beFqgxbMlnob6pPu9ieShAWAzL+BFA5R2rrov7+lo53ucxU29Z1tnt5+Pwegxlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792486403;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=1eBZLDT70LbQFSx+szDq8JQeLywiXsIDEqFOy+UYbnc=;
 b=tNBFsNmPaCFpYgOE48R3n6LGH4vrID3dW9ld8H4yELtY7inrWgz3dZr3co8nGXqS8UTq
 hhzU/QQEhhVMql+NvSz5nLvjvpknYU9t8wl1V2FZISm9PHP4pQdOPFeCR/pqs9/X+vMVa
 9ohNgalNK7mQyJZGn3Pa7WbJS3GkcC3kTtPYw/f3bIYfC7mkJGo4LoPL972Uf0o1YRSGX
 jG4K2Ji0v+Y2dl1MVZ5qN38SVIagl6P1U3Ln05amwAYPJ0gY8+wwm08ABXSRLfCqt9toV
 VCl15hted9rP/wgUjCvEd9+CXcGut1VzPRzI54AETEaZwCdX7a57J3QoBU+iCRlqNPA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="X9q//+k5"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=X9q//+k5
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DA136083C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:53:22 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1d484b4a9so38156575e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792486401; x=1793091201;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1eBZLDT70LbQFSx+szDq8JQeLywiXsIDEqFOy+UYbnc=;
 b=X9q//+k5EJ4ReAUHoETFNrwPdF52TQg7gzLKJZvpGcLonCri0bFC042n49SuAo1ipW
 obJfhO3kPzscDCy+g9qVSZ4LjNNVpfFpODfVb8ZePjjYw5zTWel9r94s3WxsCezUE6Cb
 ATF6ASdbOb67WiB20/nf5jQ8GvRzCKeRFYcMWUHns7I2rwyQE2NCbjUGA8ajPirHriHB
 XW1b79gZbTXxjaPgfxaK/ZXH9KgKKq4XKoAwxJ1pM51MBlo+PlwXgms9FFjpKhRWOlN/
 b9u4PNeJRGO+TNOSziahJ1uJEpFmwPinBkbK7qbfsWJxmfbJlPjppiYKsyOw0KAKSWD+
 rGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792486401; x=1793091201;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1eBZLDT70LbQFSx+szDq8JQeLywiXsIDEqFOy+UYbnc=;
 b=dWDUJFI/NKC92RykNnQEp6UlSqt+gXV8OuBSqIdkQXytFS+QUflkjPf+htLIcqvoMT
 Uy0ZsdeYbiNDXo/mw0wZTwheVHsBdCPzK91pdM7O65ZmTKUfUO539FC5T0JDOyBO9VIz
 Kz8Ay954xniqMarV70lSlhPuI8vJ3fJFsvZS65DQszu4D9QnhMH1ypAX7PE2T3h5okpi
 waEafesrws11LvQ3kumdlzDW4ClwBN0+By+3GnQtmcyuovuWW06/Yjt2MSaqTIEYaD6Q
 1kaZL2oVkXwoDUjz51qOJ+mO3O7MP6VhETKcynLiRLgU4NqDiF6iDMzQJJT9/N0hxo5B
 iGEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx79cFk2vdjWw0FgcDEb0FbW8E9adw7DFRM0UWVpL4kVC+tvVDBevqnsy1e1YdAPdjiwHOUn0Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ8L6pqsOnf5COtZuk4lAO2febYoGYHe7QIABlEmniiTC65isGe
 CccdeOCAYqeBfPi4D5byW5aqOY8CL39/WrkdH09xZJdIPRQS0IazmeZEhM+fmVRe78I=
X-Gm-Gg: AYBFou3GFL2sCKDEVajnMcn9FSm1vkYFEydV7gOpRoMMm2SiMSo85mhd5dEdlgo3ubc
 vD5lMV0ywr0n7/BMALA45AUtzyEE4J/WCu8AeXDiZbDLWqmANbBlkBlzWKHGHxxD8akhaOLK4bY
 qLOLo1xa4/Q5NL7lbJZK7R3lmy8pqpSUUAxkgI3CFGL8w5KyVpFaP5y0DFlAjQQLuwg1W35vKXl
 JIwKloA5urQ4L9QkN00jv5uDdSs9yizMDzuZpbvTsCrI9xIJVWVkLlK0vx7XWaqQNdhYXt0do22
 6cFR0aXgbOHiD1P7HuYRJH5E7X9srpZG16HR93Z2kMPDyuDiu+DB6OLWGiHpeEvEYUjbEB81rL1
 G1zCslcgVBZsFLZmkWP/UuSHviP6x+2VEE3uS7GAlpZ2RpThKMbYrC8z9vHb1C/j8RNpXy7tCTc
 pYd3U6ilSOWQwK2rRFdYH8IngIvEws5s+c5FjI7jptHg8HTsDsEeYxgzTF5tNc7TolhHs+Yr24m
 Wa2oG5RCwsFFmDYz75NzVui5egyXjjkgmbprtxxirRZyCiNDRyk0eA=
X-Received: by 2002:a05:600c:348f:b0:4a1:e774:370c with SMTP id
 5b1f17b1804b1-4a1e7743940mr119954735e9.30.1792486400536; 
 Tue, 20 Oct 2026 01:53:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f99ffbabsm2722905e9.1.2026.10.20.01.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 01:53:20 -0700 (PDT)
Message-ID: <138fe2d0-fe32-4a32-b9c7-3dfd7129164d@linaro.org>
Date: Tue, 20 Oct 2026 10:53:17 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 6/9] spl: ufs: add Kconfig choice for U-Boot location
 method
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
 <20261019-spl_ufs-v4-6-61432d0b258c@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20261019-spl_ufs-v4-6-61432d0b258c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 12:49, Balaji Selvanathan wrote:
> Replace the single SPL_UFS_RAW_U_BOOT_SECTOR config with a Kconfig
> choice that lets the user select how U-Boot is located on the UFS
> LUN: by absolute sector offset or by partition.
> 
> The sector-based path (SPL_UFS_RAW_U_BOOT_USE_SECTOR) retains the
> existing SPL_UFS_RAW_U_BOOT_SECTOR option with an explicit default
> of 0x0.
> 
> The partition-based path (SPL_UFS_RAW_U_BOOT_USE_PARTITION) adds
> SPL_UFS_RAW_U_BOOT_PARTITION_NAME and
> SPL_UFS_RAW_U_BOOT_PARTITION_NUM, allowing U-Boot to be loaded by
> partition name (tried first) or partition number as a fallback.
> SPL_LIBDISK_SUPPORT is automatically selected when this path is
> chosen.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - No changes
> 
> Changes in v3:
> - No changes
> 
> Changes in v2:
> - Introduce SPL_UFS_RAW_U_BOOT_USE_SECTOR to clearly select between
>    sector based or partition based lookup
> ---
>   common/spl/Kconfig | 46 +++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index c837f831212..a32c5fd11e6 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1660,13 +1660,53 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
>   	  SCSI device number, which might differ from the UFS LUN if you have
>   	  multiple SCSI devices attached and recognized by the SPL.
>   
> -config SPL_UFS_RAW_U_BOOT_SECTOR
> -	hex "Address on the UFS to load U-Boot from"
> +choice
> +	prompt "Method for locating U-Boot on UFS"
>   	depends on SPL_UFS
> +	default SPL_UFS_RAW_U_BOOT_USE_SECTOR
> +
> +config SPL_UFS_RAW_U_BOOT_USE_SECTOR
> +	bool "UFS raw mode: by sector"
> +	help
> +	  Use absolute sector number for specifying U-Boot location on UFS LUN.
> +	  When selected, SPL_UFS_RAW_U_BOOT_SECTOR specifies the sector offset.
> +
> +config SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +	bool "UFS raw mode: by partition"
> +	select SPL_LIBDISK_SUPPORT
> +	help
> +	  Use a partition for loading U-Boot when using UFS in raw mode.
> +	  You can specify either a partition name or partition number.
> +
> +endchoice
> +
> +config SPL_UFS_RAW_U_BOOT_SECTOR
> +	hex "Sector offset to load U-Boot from in UFS raw mode"
> +	depends on SPL_UFS_RAW_U_BOOT_USE_SECTOR
>   	default 0x800 if ARCH_ROCKCHIP
> +	default 0x0
>   	help
> -	  Address on the block device to load U-Boot from.
> +	  Absolute sector offset on the UFS LUN to load U-Boot from.
>   	  Units: UFS sectors (1 sector = 4096 bytes).
> +	  Note: Setting this to 0x0 will load from the start of the LUN.
> +
> +config SPL_UFS_RAW_U_BOOT_PARTITION_NAME
> +	string "Partition name to load U-Boot from"
> +	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +	help
> +	  Name of the partition to load U-Boot from in UFS raw mode.
> +	  This is tried before partition number lookup.
> +	  Leave empty to skip name-based lookup.
> +	  Example: "boot", "uefi", "dtb_a"
> +
> +config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
> +	int "Partition number to load U-Boot from"
> +	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +	default 1
> +	help
> +	  Partition number to load U-Boot from when using UFS raw mode
> +	  with partition support. This is used if partition name is not
> +	  specified or not found.
>   
>   config SPL_WATCHDOG
>   	bool "Support watchdog drivers"
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
