Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE90606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QmDvWGIL;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o+9klyMn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40D6A80E0E;
	Tue, 20 Oct 2026 08:59:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l6nrP8BKPLrG; Tue, 20 Oct 2026 08:59:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7E30780DCE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792486768;
	b=qS6n1qqx5dIUmcIyip7vmBmQTaDur14aVOKzoah4Sxwv2ongcYcsTX3EraxoLZfoQcki
	 Wg4R8udL5b42VbUmH7f2XRVrn/lu72t/L1grzFjbNyiBzvOR8EV4Rz8Hm4hwXStkP4xbi
	 wR/B+4aiw9K5f0G7mqyaZV1CApex39yamTknMFh9++1zK2gtkQmRGWIs8dZ5hG/KxaqBE
	 80uyEsGLs+LfBI2DI+O7d9GRMFNUUTPGwYJcMDuYE4WjAJsEBZ6nuqJ7l6/Z+/ktwyzY/
	 cPUtYh6MrXPsrh0mXSmKgZkqbZRydTvQz4xOe8JJd6qY+ZFS9XfSuEfDEUfvHvrFGUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792486768;
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
	bh=u/gqbVAUTj2OIzR95LSulRRAnqPwSMIMSD16eaYk84E=;
	b=He0aS4BqtSVYc65Uewqf1DVYcb9+gBzrCGVaBU3qdWAJbI9AVnhwzqRVRpRgHs2Krnxu
	 SxovAB3KV7OLhd/WCXyoqd0/0a/OH0CXLtxqB5RJkiSLVJtKgj+8KqA4Yr40D+H+yC6A0
	 wEr7lptybVuYQkxcU9CMzLOJU9jujqUBEcoaQxu6Edd9U14Nhoh2xxAS3yU4uS61NOUtS
	 AZRyBOml6jIXyXFEgn3QD4ra546YtbzMRT+lHVV9Ky25xUIhElVAnA/UTxCSQT7sDKv39
	 p9YRKFD3BUw7IXgJlMjxgIaFc0m1/u0UxR2w8X15ny7dN8ganmDvfo3n4TkBVWXmwWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792486768;
	bh=u/gqbVAUTj2OIzR95LSulRRAnqPwSMIMSD16eaYk84E=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=QmDvWGIL+InllD5FtXC84MzrEL7BYOo5wTioddtlDRNls2XIpPy3WN5g4r+/lVFjY
	 1E6GXmElM8fNfsOpRTd6Rn7vZH3+uXQsDdsBNjEwh9bOAUrDwZlRhyoeo6XWCXiX0V
	 a2MWoUlVfm9FQhljB/AYKsh/fD4v5nMhb/6oddF2xw03uTextOsCKGRj2Jhe1QZBIh
	 aj2cPqh6oZd05nsl9yJJJKG2zU1L2dXJfDWG51ocH4wkD4GVVn2ZUnDJgdaag7VgaO
	 FM0M0kYeaKsrSdeOw72k065kp6aHJCs2hDRbjZXxZkwLjwRplLVtunk7AMurfcXqzo
	 nG067lZIEK4PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E30780DCE;
	Tue, 20 Oct 2026 08:59:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 280A82A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D47860830
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYHIRKgryVU1 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:59:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07773606F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792486766;
 b=OIZgz3drCyhNTEzkfvexIcn/UnGOscyexF170uPhcRVRR3ILsTBh3QuFPAQdvfF+vdio
 KZkzeFsSs5geeHfl0Eo6pLy8Jjq/+QWhW/pa+qw7dcJdXnoSV4o60UcDxA48hejSObmWH
 wyn/7RMZ75VOYVRMyJe1XnnmtNPrtTtVisFBocEil46j6x6sGk7q3nmDP8q9R0fTSM6iV
 jjwS4HzkzsK/WeHRkAGtDez9yn/3iQzrLKXUHs3psyTogoXmzWyGIqYwHi5ucjKw7LM7z
 ReIP7K96n5gloQsbEpIAwgaNMIRO1/X+qpWNd5GHTEr6j1IMqQlmItamOXv3MoFNJDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792486766;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=u/gqbVAUTj2OIzR95LSulRRAnqPwSMIMSD16eaYk84E=;
 b=LEU368jznEKRWNUqICvLwQZRflP2412Cjtyy+Dzb8KqKCI589EczqyH00hrdn9P5Ojr4
 DxLK3uBVibnlHfL61wN9MxadQFz4nWsyUBo3eUm7zNHXO9mWQBDTR9BHNAuC+INQiucSr
 5bwgTjhUfkrM0y6iEY9HWameLUyGOazjvQJtMLsZkp7YLHjVx9yhrIh0Hk0NQFItipIbP
 qBbFPJ3bU+1WP71leyzhyc71SiGVuFWz4K1Kpy0p7p7LTSk6lI97Ga3PB1G1f44SC0sgV
 K9jK4wD7v8LJltmiz5TDmJV9/TIXQ2aNrnw9KG+rGb1iDnePmT4ONrtOQYlvPh90NXg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=o+9klyMn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=o+9klyMn
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07773606F3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:59:25 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so2283109f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792486763; x=1793091563;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u/gqbVAUTj2OIzR95LSulRRAnqPwSMIMSD16eaYk84E=;
 b=o+9klyMnGLuTpZatoqByBHzVhX1Kr0ujVkkIWxjmR1S02m1YzNsvH/bO5baHsTPMUq
 Rv0/0Uiwg7jOTx5mX4Rbvoe+5JXAquRB6u+HhEoIlR70uU9zwz631OGpMjnUjcLA8YQw
 crTTtCtmYx8OS/zBXAtT4yHjac3IHZfIGvGBdki6Lj5MHUhsjDMlm6Lm0tnFuaxohhnE
 Imw+5E5ufpE9K01QUJiYx1HTDPlE+wFtiqP4w+oH0LdXqmD7HKm7Cx7b4sIyD7TwFfzK
 ZnUYrsK30LLwOPhb7x7hL2KLLI/ifVeGZh7RhpMYPOTKTMfm/vLMKt8ZLHRpkLb4yHFW
 Tf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792486763; x=1793091563;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u/gqbVAUTj2OIzR95LSulRRAnqPwSMIMSD16eaYk84E=;
 b=UrVI1kYNmxorU6ogvfcQPUAA0z7T0vkFzVqx4O05fiTb80QyDk66UhdlbYSW2mefxE
 WUuslC6CC+9hY9ovbrGBVObNAsPJ0pZK2DcHREVFYmfEHgUC2BRlQnERdTUO0N7fM314
 PWM4/jTX4MLOHGkBra57/7J/PLq9a2wC8uttvJ139a8z5LadP5Vi+ycRyqCYiafxbhZr
 gP1JQGSwFXp+JHdB+C3uBbo8cHLTqPWf5EDvBFS7my+QLA5oKi55IrD5J5P3jChJU3md
 y8f9Qwv4N/zoDjuLTd81LZ6ocT8PaPqnCdHzAFac88RBvgv9A4Z7qO8TGXhMWE7GunD5
 PYuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwS+oc3ZhomGQvrWR8B85dZWVjpge1KHBsvaTazVcrwSb1ye0R1ncwdGaXb1pq49XFTyD+A85w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL/eCXYzupLiLXslYMeBMAkDJdfctOx23v0twqPh4vOWv1E+okq
 kC+bp2XBG5fd16nAiPTpxzUQoGc7wDOepth3efvDKg+VjHySQOhuoUaVOKLLRcrY71A=
X-Gm-Gg: AYBFou39LJEOxu21SA5Gu3eQkAYlwWHkLgyfucP56tEDsf83f9zEinPqqNhKtFNWAVT
 LtU7y2iupp5DFLy2A96UJq868COqw2cUG/wWRHUodXvkOwUUvay1rIDqvOSXf9Y6vMbPBNixLnv
 Jq5bLMafxz0CEt2Rc4c++CYx5aqPXc+1WW9SADAni5JnZMBYAuhfNATRBMdKsrP/5L//GOihPOg
 TfSvX0PatJNhaIeF0icNlIXfKE88cae8qT/3t8D+iXBD3pwIRlxncSFDR2A+W/4nJSXoCFWirJp
 vs8g2BzYNpoSYeN0GHP/lmRNucDQbps3Fxg2F6pdEeCy+FnS5KCxqAvzJD98wE5mMiswKqoqYcU
 nb5CQ1HtJPbttgVRVQj0UFtkZgn48KxAfrTmzbGeOeapx0K9FIMgCUNV0f6HTTQWh1YbUTvByzv
 NRk+Hd+qd2xxEEwaC2a6lwIsNnpUtxj7kBxsZH0e6qCgBROUjMFLJVWhmxmcaSSTuN6xIVxUJMF
 Nr9EzCGjturAtou6aMEiND3UAIT1EDYk0F1o04oZKbzWYmj90jzGg==
X-Received: by 2002:a5d:4742:0:b0:48d:db43:9187 with SMTP id
 ffacd0b85a97d-48e07bbc7a7mr13585822f8f.16.1792486763380; 
 Tue, 20 Oct 2026 01:59:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d818c59sm4930878f8f.30.2026.10.20.01.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 01:59:22 -0700 (PDT)
Message-ID: <1d53d7f0-233c-428a-a00d-fd157d45bb70@linaro.org>
Date: Tue, 20 Oct 2026 10:59:22 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] gpio: qcom_spmi_gpio: add qcom,pm8150l-gpio
To: petr.hodina@protonmail.com, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>, David Heidelberg <david@ixit.cz>
References: <20261016-b4-pm8150l-gpio-v1-1-be7cfbe7e3b7@protonmail.com>
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
In-Reply-To: <20261016-b4-pm8150l-gpio-v1-1-be7cfbe7e3b7@protonmail.com>
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

On 10/16/26 23:22, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> PM8150L has the same GPIO block as the other PMICs of the family.
> 
> The Pixel 4a 5G (bramble) wires its Volume Up key to one of its pins.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
> The Pixel 4a 5G wires its Volume Up key to a PM8150L GPIO.
> 
> Without the compatible the PMIC GPIO block is not bound
> so the key cannot be read in U-Boot.
> ---
>   drivers/gpio/qcom_spmi_gpio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index ae75a4e151d..f4b614ee1a6 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -748,6 +748,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
>   	{ .compatible = "qcom,pm660l-gpio" },
>   	{ .compatible = "qcom,pm7325-gpio" },
>   	{ .compatible = "qcom,pm7550-gpio" },
> +	{ .compatible = "qcom,pm8150l-gpio" },
>   	{ .compatible = "qcom,pm8550-gpio" },
>   	{ .compatible = "qcom,pm8550b-gpio" },
>   	{ .compatible = "qcom,pm8550ve-gpio" },
> 
> ---
> base-commit: 71433ebf2aed1be5fbd2b1d497eae670ab9b9962
> change-id: 20261016-b4-pm8150l-gpio-58c2c0f8d73a
> 
> Best regards,
> --
> Petr Hodina <petr.hodina@protonmail.com>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
