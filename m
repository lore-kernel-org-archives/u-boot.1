Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678FA606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rJGR/1jc;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GEeyQ8lp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 015814076E;
	Wed,  4 Nov 2026 09:52:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yLkSkPmBlmhk; Wed,  4 Nov 2026 09:52:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4003B40652
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785933;
	b=ffpmeVlQ+ppbuH6zieSvJ059SlJucT0pezZ/KhfCTugTN9mzRli2RzpnW4ktKi6baS7D
	 9Vw3/ABOLA5iwPkmgT5LB+fm7s4GvLIS1p+/pfrKouxGhNDvJOv/g2eWJE+j71Myw3mLG
	 rlSy02Pa6CmdfvA/pDvfQzpL5eFWn+mfAIf89wMgEElblKOEnaCIhOYCg5swXGimLpA6Q
	 xe7vLeLreoo6VjOmNv2z0bMQFiaVQL644Low8fNL423iMJAlrIHK67y5bn0A0MjAT/AUQ
	 QKgLjv8JLjsYKYC8KovSBU6PMF2834vSizbwtCfpr4FsbgSnI4svrl/uYEB4B9XLUkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785933;
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
	bh=C9kLggdgPM3TdpjNPlcA8yyNQFMbS51f2xVt3TJPiYY=;
	b=d3CTjS5r3L03vzamIkDWjzYjGhOcOjRIshljuo8oE85bFCAJHeoMe9uUVVyIdp/i0TEE
	 nW1QMgy4FZHKC+l+MqhCgoO8mohgpv/FSrmqT06xpdk3soAPhx+XDwgfllymb+SFPQhfk
	 iOz2RNjUmq7qrNljlj0+463Tk8Co3bUFcz7J7ViOG1ZKsdePvio/mJXN2NycZ1FEl24RU
	 F3zyZu6vTkK2daNSnzzEdi2wae88vrsLKDmYv+r9TEf2KreH+niqEGOTxcro4anj2kRZO
	 WGQzAUGgps7gSb0l2fUwg5QvhwupxyA6pWPdw7GPFk0CECnMk1vAMNq0qF+U6pVY2qQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785933;
	bh=C9kLggdgPM3TdpjNPlcA8yyNQFMbS51f2xVt3TJPiYY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=rJGR/1jc7atpGBHGjVQvpqb2m9f6EVGxwKyGh5HKPSsPlP50s+CDYCElXcbgylTvG
	 YsUPTUa/TY0pyDkEh2Vd/NIXcvPMBMqpeitWEQgx/WMPPe919jYjEfWAqEnDlcw2yB
	 Q+0OyZlsU+/I8crvDLc/SLCURlsgq6UtAYcAvzHOcnkmxu9Kos3nEJ2OEukZPsotPj
	 lVmaKwmeNhgZxjJSpstaH6IlcPAAtaqsefHIwyfIJ+50GMDZCN21vhmgIz+ptg+Qfy
	 qu/ZEwva+5EeshSE0AKcNr4lzhgRMqxSwA5lZ0sldFiL8fSgIOlTKz0Uxy+FEIAxVI
	 YWZWSwlSAOfkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4003B40652;
	Wed,  4 Nov 2026 09:52:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D29F435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0DEBA4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:52:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AJvB7-hU76mS for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:52:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E67DD400FF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785931;
 b=KYePHnka4TDUXzIEIwzGKeUqORQcox+C8wHXzK22vzPp1iz1CUfFz7a+cJf2Db+xulkp
 i1QhHcsKJzTcowBoL3NB81EigTv6fRXXSS0fz6rJj9oymlouI860tABvalFqcTUUbhUBY
 RNFFVFG9W3HQFi/4pY1PcF7Ldcp1+vpD9x1txf7qpr2k8pwNSH/DUc+Tt4e8iGjDfcoON
 wjqTAUUEut1cae0BaFrb0kJkWmBnGX2tDMh+XafmA83whiJuX8ANv8Zyg455sL6I9nqZ7
 y0Y67cUfssGN2Fou/+DAK7zuH2FHeflntzwv4upBegY7NEq7pjiLdxdcAHTuW7HNn0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785931;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=C9kLggdgPM3TdpjNPlcA8yyNQFMbS51f2xVt3TJPiYY=;
 b=Z2TGjwJf++6KpfFQ8Hf37t6tSo3yKA0ij/+WwYxzfh5NZ5zn9Ju/IGnlz6uzsx1EWShB
 pyfom81p7Moc24DYSKDiJ5KZjZxV6rtZQnklY/AiX1U4s0yGfIIj2hHOSDvxLSQVl51qF
 0OOMIIgdbkT0ud1kIzdoZuptfiKstdwQeKfDC+c0YhaiyDXyLwEROpHJGqwErVnYkNsMJ
 0HdhRQidxGOrhRLeN3XwY0ozIHcdLd5O1t2XQLdPu70bZx76SFlMdKK987rSnWt6o1BKY
 B/UYHdeIi5ALsMzfLgU3ro/7GRRJSmwXtjZ0N6fCNhVIgMy+ASkVG1N9x6xHisYmRvQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GEeyQ8lp; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GEeyQ8lp
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E67DD400FF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:52:09 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so3010765e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793785928; x=1794390728;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C9kLggdgPM3TdpjNPlcA8yyNQFMbS51f2xVt3TJPiYY=;
 b=GEeyQ8lp01Q/Pe+XWb9NDRedyPP5mKsS1r/4ERglxZR7J0VPeuvcjoX3ivyy2F4TVT
 elup4j5vpRkfeH9y3NcTGBLSrRmzqFr/qm4MKXrKW/V2zEjBqXjeVBv8f8JNQ+Xlp6vB
 WXsy7pj4PoP7FgxzHH/rqjntthP7KBlj8F+sAzKnzyQpxGcr+r8RhbcJRg2t3iXN5nKz
 0ue1X0nlhyBSAPuXVo9L+tbHgM+K827gYpYlpL3EnDumf0l4fjXn0tbJyR4RKRi/nsHn
 p7yfNVonDosPkTkFSk8gsJ+Z6bcy2FIaG2KikgKJUSoE0dcT8tvZHp6dPpZIsPVCfwBj
 uwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785928; x=1794390728;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C9kLggdgPM3TdpjNPlcA8yyNQFMbS51f2xVt3TJPiYY=;
 b=uejuQfkJ81R6QgQA2oobZ0KtkTXP3ZY1Yri+2oYr6OvYCMM3TWqM9dAIsKRYStd9SJ
 TgKW0CP41HCfiTR8zaiHtQ2RCyvdOMVOO7KGnWy5zImeHyZrLbIypUsXvxYdmiv84HMB
 pEZi7tiNbB1ZOOiaaP6o0KVeZIhgImFGSbejxnzeTf/xooKsYIhfBQpAmKwNN/gSDHHn
 wF3+iOHDO+eOb/uIWAW1enA6aiX+y8y/eG/F5bNEFMDe2PmipasuR+AlbDk4Yb/WTXkk
 k/CDF451XT0UvVdFoUPevoV/Rmq5eDNi4W1dGIPK0dZlDW7UqcHxDuin2lCRV645e1Nm
 ny7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaZYO+r42XbjX2oN8bF67a8gCxoaP5Ade+B5n3DatnBwqiQtNod/VevHWzxYRU+Y+BsbCEkXk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+2TP3mtWtoYyJj6QDabRG50xNNLypxv/nGDWkrdQKjrpAsGbbp
 6OdX5Xu6qPx1chOpxvm8U3sENhcy7fdf2Pjpqk/4LmdsSe8YsEBANM6HmuluYwY0nf4=
X-Gm-Gg: AYBFou0H2YdMXQSASRpWyGHwPEtGzMFXS2txFuQifOEZ24qtqGHk/Y4u2Eu/4VSGt6d
 kDfWkPjuTGBUcvutdSO0pvum0RRktoqJbnDMaUepR6DvBWzLNSepIPbFjRnwYDyyTxab43PO50F
 OJO7qEAsorLqjcjLUg4WzLr6nFGwUqbLyCPDl0m4VvyP3ZfOHX4roi1ZmRtKof0ifOJm9Gz/dj2
 y8SH7twJ4g/XFUnRvUn0X4RbTkvT4BWoEGGQ8vC8EhAWLriFPUyi08jLYzI+2nXkYYIOKURaWye
 nm8CB54wITbwOcermIvDn21uVhhvXF+V9teJOhcKvrJ5sIbAEo2JOYI8yKLhhzC4FSllYmM83R9
 tchszmZYUpPKpuPLCW7CLCRP8C4jR0I6I6yIHvUuzH2+UJIN/kzoxBUIsHBYfxoV8o+/rYet+sE
 feIOCPNVlxlHtmWoCpNYI1PrMaP+JHPgJyT6h+VPOn0ah+YO3d7rv9iJP9y5LoQ8znqwd6fTETK
 0NtmqS4JerW1m10eqVFBRKfVCKhBRfoF91VVXufELr6TuBzJt7TdO1q/B2UZMWlItI+FRZNiaYp
 y1Psz0lSNpSjuDdQKMOXeq08uriFtxCi7ZHzqIFxGFljGYKVWlMILc4qos/IeW2CEnsLCRy0h2I
 6LIgOS50=
X-Received: by 2002:a05:600c:c4a7:b0:4a1:efba:511 with SMTP id
 5b1f17b1804b1-4ac18f52aafmr344020185e9.35.1793785927838; 
 Wed, 04 Nov 2026 01:52:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70?
 ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43a48adb7sm43982215e9.1.2026.11.04.01.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 01:52:07 -0800 (PST)
Message-ID: <eb3a8a3b-0618-4327-807c-0208710465d9@linaro.org>
Date: Wed, 4 Nov 2026 10:52:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] gpio: qcom_spmi: Add pmm8654au GPIO subtype support
To: Deepak G <deepak.g10@oss.qualcomm.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Petr Hodina <petr.hodina@protonmail.com>,
 Deepak G <gde@qti.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20261104-gpio-qcom_spmi-v1-1-2e430ec0843d@oss.qualcomm.com>
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
In-Reply-To: <20261104-gpio-qcom_spmi-v1-1-2e430ec0843d@oss.qualcomm.com>
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

On 11/4/26 10:50, Deepak G wrote:
> Add the LV_VIN2_CLK (0x14) and MV_VIN3_CLK (0x15) GPIO subtypes,
> which are handled the same as the existing LV_VIN2 and MV_VIN3
> subtypes, and register the "qcom,pmm8654au-gpio" compatible string
> so the pmm8654au PMIC's GPIO controller is probed correctly.
> 
> Taken from linux commit: bfdccbe92e6d ("pinctrl: qcom: spmi-gpio: add support for {LV_VIN2, MV_VIN3}_CLK subtypes")
> 
> Signed-off-by: Deepak G <deepak.g10@oss.qualcomm.com>
> ---
>   drivers/gpio/qcom_spmi_gpio.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index d06b9a4b513..8cb9aa0a205 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -42,6 +42,8 @@
>   #define PMIC_GPIO_SUBTYPE_GPIO_MV		0x11
>   #define PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2		0x12
>   #define PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3		0x13
> +#define PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2_CLK	0x14
> +#define PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3_CLK	0x15
>   
>   #define PMIC_MPP_REG_RT_STS			0x10
>   #define PMIC_MPP_REG_RT_STS_VAL_MASK		0x1
> @@ -398,11 +400,13 @@ static int spmi_pmic_gpio_populate(struct qcom_spmi_pmic_gpio_data *plat,
>   		pad->lv_mv_type = true;
>   		break;
>   	case PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2:
> +	case PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2_CLK:
>   		pad->num_sources = 2;
>   		pad->have_buffer = true;
>   		pad->lv_mv_type = true;
>   		break;
>   	case PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3:
> +	case PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3_CLK:
>   		pad->num_sources = 3;
>   		pad->have_buffer = true;
>   		pad->lv_mv_type = true;
> @@ -757,6 +761,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
>   	{ .compatible = "qcom,pm8350c-gpio" },
>   	{ .compatible = "qcom,pmk8350-gpio" },
>   	{ .compatible = "qcom,pmk8550-gpio" },
> +	{ .compatible = "qcom,pmm8654au-gpio" },
>   	{ .compatible = "qcom,pmr735d-gpio" },
>   	{ }
>   };
> 
> ---
> base-commit: b8668aa4114e445d020fcb68a223b7f0af74c1a9
> change-id: 20261103-gpio-qcom_spmi-99ed8334ea98
> 
> Best regards,
> --
> Deepak G <deepak.g10@oss.qualcomm.com>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
