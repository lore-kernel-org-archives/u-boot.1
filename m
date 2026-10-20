Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27B606A328
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nvfOjLtP;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WKWOuBmm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 174B7810A2;
	Tue, 20 Oct 2026 08:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6FX-yrVF36u; Tue, 20 Oct 2026 08:51:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4EA5A8109E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792486317;
	b=J1vc24kGLaz/IP2SFFJ7OCYSzs0yTrPH9MUpxYsp0CgqpxapIAeeJm1eoNY9cyGc5Qn7
	 u1WldUiLbL+kw0UhNgQ7NWkFM+oP8tDOLQ9rZRMe06h5bxMnMYF5JLMO2PfgfzCkuCjly
	 sCrsersuZx3HQnbMDmbDTPcFZ/wD8hhQTzH+k/HT2vDPsbdfjfETO94J8EUilFKsLR71W
	 +kE4iVHaNkAaouc/6TuXSQsnf2w9Qx8csz6pdtaTN7caIqF0OgMab8MPcvYz8/PrL6q6c
	 WBIlaXV7HMTaZjNZ/MYAZyeWnb7uJhECGzAkk+HXSj61iVUypjzwNpwcztMzrypFXkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792486317;
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
	bh=wm4FEHQknN7DevCwMhJ0uZq8QtWycZwIzpmIJIFvPOc=;
	b=NnNYuHfJwKv+UuVUVW67/epmI78Mepu2zcPrh1P3oHeEFgcB0cBUl4t7MNgYXOwYL3Km
	 vUPv9ZgbrNZnwLVQa57/gNc7Pd9LwLgfQmyOtsc/6Ui3nWr8NNSjTu4xOfBdSPiOxFodB
	 h0sMmpYAIqBMS++e1/+wTVpLlozDAszuVCX1RhtrGm55f16Q7iilRQv7VcQYlzCN6gacu
	 dgx9Mm49Eqt8HaNbySYORzn3bgZqz6PvfdpP0upr2aKQyiQ1Q1koYp7tDifWYA8daecNl
	 aoK/jGnqZYMsm0RGXhT8+uJrA6UnWSGSDcGNGoG2id5gnj9c12s+v/rsHJaISTmjj/A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792486317;
	bh=wm4FEHQknN7DevCwMhJ0uZq8QtWycZwIzpmIJIFvPOc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=nvfOjLtPYFxLOAKxt5EPyTu5QR/7GO/Ox95/57qkSZmSSLsKJhLAUobLe7Uq0ym/5
	 bEbhaJc4QMA1A86mDXq47KVj3HjMwlhhowx3WKdkjRZ4bYli7qaZOnNiif2Er0c6Xv
	 Ku8BKrZqp0oujQu1V+A7U/x/M431xLRAMWn9o7SMu7LaC2ItAXxitCGOsNv8MPbNfp
	 KrtrAyrufOqUUHajdhT/MtD0n4rVYglU/g/UKeR4YqRGyGXAc69hQDJhgO83uXLrmc
	 7QYDJ9vZeFErrlOfcTtdNmJHPr16yrkkfhZcV+s1i9fHu2KmILB67dgHqrDJb/gSr0
	 Hz258V4QJPJpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EA5A8109E;
	Tue, 20 Oct 2026 08:51:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 02B661DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFCE84081F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8XJAlxxYHd5p for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 83E0D40818
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792486314;
 b=Kan5WFSVOMGYQCc+WIDt6PYuXlwF8Nw0td+mwUFoNcCmN4kkqcqracGCMxpB2TJrCPDW
 Q52oasBbMsppYv7aEsp9x6SdkWHdViBCc1PwchzTZeTbCh9SQs6lJFoZh65qO7Nj1u7fi
 LOud7WLpoLiWFRMvgbUX/GFuhBtj9YI4cpG6C3pn27rLo76Fw0gUUD1yMIRuSKGp5Urjs
 g9WYeM4Q07Foacb/dh75GZm612107kZJuJlyc4NF4zY3XRUIsI2/IZWO+TZ4PeJjiis7c
 rUnQotUh2APWp64fxxE+bbOO6dHr9D6W9luB3DQAsrM5UQKrxPLqA+Rihx6GIwqEiWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792486314;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=wm4FEHQknN7DevCwMhJ0uZq8QtWycZwIzpmIJIFvPOc=;
 b=fLSvTKLYdZn2CyTCjVNUbZzRr2A//hrNT1BxDTma70U728c3bWgXW85B3ppQjKauWtYl
 4kXF3ZSXsaNCo5KeeVOsP+4xC7UPD7dRML5heQPaEBx7iCmiA410/p1QBhy0cT9kWyjNN
 ZZ657TNSUVfkwq4M/NbXKpbSIW+0mJ1fdWst+KvT49rU+YSGYm8w0m6QsE5YSQdH2nIFE
 bprMse2rJ0nZ6Wqq3qM94IaM+TzGZ7ilANXLE3nRpB/4AOAoXe+SbxrJ/WUss26KH8wH3
 NTBafcFBGFvZ5a/nC9QOxQmcdaT/CE9NDfovRIMF7Fzyras7zRSKd2E7JQ1ddh9RWyA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WKWOuBmm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WKWOuBmm
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83E0D40818
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:51:52 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so36623995e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792486311; x=1793091111;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wm4FEHQknN7DevCwMhJ0uZq8QtWycZwIzpmIJIFvPOc=;
 b=WKWOuBmmYHHDRw7qv2HmXVGiwqdapuwam/Bs22K9+VhXOvncghBvrixa87h2O6Fd3D
 +Kfp7m++nLP0q4o42IoLTOFIFNlK+P8xZjXg7e0hk2/m0QNbo4NeL4jgIG9F7jfOI9Mu
 PWoBa6h4LZZjlCAyw4ErSpYV/UXLTmF43vM2Z8IynAGUKX4AOvtydi25ppuhnWBH1O+4
 DqQQFhOo4MdLxVy40MB+J2SQ/79HX0m9scDKuxLTFG4P3NeeuBRWCordwdZmvMoViP2u
 o2PQOxdgKcLvXMN5pw4X6PUuV+ttjLn3o0QIGaTdfizqTaPUO7EQo+VWNxZd14CoXoML
 kSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792486311; x=1793091111;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wm4FEHQknN7DevCwMhJ0uZq8QtWycZwIzpmIJIFvPOc=;
 b=K1wb+WhMZGkQAmIQHiKOWRN7zhbMR1FJLQJu5ndjjPGP/tT5evxFeQH97UoxfQ84OR
 4b66v6fRuR5Vp478kq5XrCuwKEURAk+kTn8jlHliDrUJox0EuvFHnECo54QFyqZPIa7N
 ASJCe/D2e4HJyZven5rhcq7yxj05otXHatf/F4qTNB11cLp1E6OPtHdrqN837UExIcnd
 P2CLzI6R1qEhIqXZWi4sa81Eu5y4qLL0RiAjchTmE26n9e8qcqTlR8cLqtjlPHMr2dn5
 lLhhUI07v1gOTnI8KTRdkLBwL3jxuO/xCuqpRD3xKufitZwYRMMR0SgnDuVZtX5UpqfQ
 xSOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1kWWQSzVUlAEXt65BsQlI26cyBEg1AWCMpMaNmOLwUyr8kpKFVbkM0JYEOflN/xSDtBxY01M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKgaVOO3vnJ+aULyWVWxF/wOXo6uyQ0epaH+REokXLvpwhxaaFW
 oYrxXFsD7K6NlarXq3adrTIRjwkcIuZju9L58xjWeuyzLfI95fOrRxTehXIvgHWP0mI=
X-Gm-Gg: AYBFou3wrEZbTy6JSmjE1q9S5POz4b2bd2aDnqRQ0vlYhXcTdhQMEYuH0gBDh93f9J1
 voHaIdWp1BfczasBwg2nq3sm2UA0k6YC1n6oZEmdQTef7VpFnRZWB390Sto+a8nkmssznWjTDy/
 TFyfTzmKKmq91AQPAV7MU7Zu+RVJHDigC6WpXbOq24b9iNr1bog4lxlU1gZvBNjubLDhLQ51B5U
 5+H3POcC2N9aHvrl+SqVtnVoIdFbDIW2kUaqIQW4tEGR7PP0ppp40jTPMP8R4kEMHHtumD5gyqK
 SVQh86x4aLmZ/2bPKohJ/hqLQLR9dMePDPju7qSNDJRT/1GUId/qe0vn3TJ6/1jsD6pZpb/SHqY
 YQid7d7GT82VLSU54TSsMdaZd+N2XRNqC6L9eHKXxrIaTPtLJ9L+dtbR4YL+DpDiJecB/hFx88A
 Egop9n9Pft5IUebmh3bvuFnAMbl1I4BvVui8Hv89d48MLLWlQ9LCu1nASwvSEvdSyTBPF5r4AwC
 /YLuXipjRHgvoJYVI7oGW0rxoaYEHPGWBl+AX04ETuQRofO5eUiuBY=
X-Received: by 2002:a05:600c:4f82:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4a1df523fa5mr182949585e9.27.1792486309172; 
 Tue, 20 Oct 2026 01:51:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f6631abfsm38749245e9.1.2026.10.20.01.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 01:51:48 -0700 (PDT)
Message-ID: <efa985c6-ce18-4d29-8000-b306b68e3253@linaro.org>
Date: Tue, 20 Oct 2026 10:51:47 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/9] configs: rename SPL_UFS_SUPPORT to SPL_UFS
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
 <20261019-spl_ufs-v4-3-61432d0b258c@oss.qualcomm.com>
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
In-Reply-To: <20261019-spl_ufs-v4-3-61432d0b258c@oss.qualcomm.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 12:48, Balaji Selvanathan wrote:
> Update all board defconfigs to use the renamed SPL_UFS config
> symbol instead of SPL_UFS_SUPPORT.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - No changes
> 
> Changes in v3:
> - Added newly in v3
> ---
>   configs/nanopi-m5-rk3576_defconfig | 2 +-
>   configs/rock-4d-rk3576_defconfig   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/nanopi-m5-rk3576_defconfig b/configs/nanopi-m5-rk3576_defconfig
> index 88b6d0f9e86..edb71b87a7b 100644
> --- a/configs/nanopi-m5-rk3576_defconfig
> +++ b/configs/nanopi-m5-rk3576_defconfig
> @@ -23,7 +23,7 @@ CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_DM_RESET=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> -CONFIG_SPL_UFS_SUPPORT=y
> +CONFIG_SPL_UFS=y
>   CONFIG_CMD_MEMINFO=y
>   CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_ADC=y
> diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
> index 93faf09962c..96527c3faa0 100644
> --- a/configs/rock-4d-rk3576_defconfig
> +++ b/configs/rock-4d-rk3576_defconfig
> @@ -23,7 +23,7 @@ CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_DM_RESET=y
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> -CONFIG_SPL_UFS_SUPPORT=y
> +CONFIG_SPL_UFS=y
>   CONFIG_CMD_MEMINFO=y
>   CONFIG_CMD_MEMINFO_MAP=y
>   CONFIG_CMD_ADC=y
> 

I think the 3 first patches should be squashed as one once we agree on the changes,

Neil
