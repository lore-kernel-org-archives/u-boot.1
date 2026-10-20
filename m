Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C48606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bqWQdO6a;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mD0nEgTV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9053160854;
	Tue, 20 Oct 2026 08:57:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Q2fEeQWafcz; Tue, 20 Oct 2026 08:57:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95FDD6083C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792486621;
	b=WktntZd8HOD/sDSLLu9FO8f8eg8ChE4SoU7xpahbcUqhRLXgL1HpYPQzZWXLoKTa2vnu
	 VA31o3mwSeSt3Jy4JOv0mPuAsZBsSzcHzISt76/v4qrG61QFxtR/RpSwU2o5qym1xXPuE
	 V1KLTy+r33Q7BPIFQQcQ5me84A4HydW+KPjuj/wX2dJGo/E0i5yhXaRf1PkIFru/OSfo+
	 vydS85y8Gn10RjqdFfkjgu3HpvWorHZ2NSBDN0DSuUIwjiIQbbCNBwOWgDuQoEr1K7zd7
	 dsHcJDQfpR2qgbcjvjVxjAsXINj8FZYa4lf4QinruYjz9I04d20gEkTqbn+wgLz5CSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792486621;
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
	bh=p7ASprC4lngBq9CCoLWZci5w8Xo/eEEtGPujgTQZtvQ=;
	b=O0P8KtdPeHW02peHsIfhqXXO1NSL/VYwMbUiVLEhYUfX6qthQYRob3NcKPtVExwk1dxF
	 7kL8ekKTP/uVoPqrtmbZla4AgbPjQyx+k0ekfpyzDOYcQHDyzoeLP/JNBmH5ZPYVWVgQS
	 s+uw67yoDZ6qM1AiKsbHxrTAHKMZgw8sA0TgMO+Y6g2CQM4VYPgTWltiCmMFd17ABxYUt
	 HSy6Ws+VdkJzKm3lq7bsMATDh3uva+2CTt2a8a3yguC2pBja6RrtBY5IyLCUoVG9/rrc7
	 0/42I3igscfeMT8RR7vb1oWcB1n8zHWjfaLMsfvb+MyXAth6NyPMh9lw1xv28SjrusA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792486621;
	bh=p7ASprC4lngBq9CCoLWZci5w8Xo/eEEtGPujgTQZtvQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=bqWQdO6aDALn2Z1HN1EJ5iQv4pnZG1Lw7IuepZKT5tlscpGVHoxsbjjteLa5kmRNw
	 4ezS81f6TwpKLxYLThfIuVReRHd8ZafKlDp1xrzeoqAnaVqMDgY27Je9vHCApkjFt7
	 GBMLPwEriS3C2dFgdUk1X26qPYkHK1Vmu15fCiNGeuoup0d9mavIdAxdMLur27MVDK
	 CMBgp/Q80WUq968Kff/HdaXQqcge1zMmPQfGa2jpnArPsrdQqexIozbovVgtlOAv0i
	 y6DvqHxg00HmdEibk4o9xr8Xxe3qW2aLwuno14jAB/66ObtNnMOeBUxxaadTIbo7AV
	 uSCRIbeD3yz+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95FDD6083C;
	Tue, 20 Oct 2026 08:57:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C38F279
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF36740328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NCw5VENVlca8 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A532B4016F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792486619;
 b=Ga2fZ0gQEiv0K4vmpwxblfTNQ/+F4Rz4uTZzCZaPf4sphhENZL6QozeOtZHTZUs0t6xH
 zJs/8+lQhBp/z7xcwwWodg3MLmb0B/3rcRdilbNUTmznezidz7IqtK+9qgCt8tNysCNSQ
 JvWx4ENLWwKNRNU9Ey+hQ2yFHeU871F2hU0DbqnEwwopUT2NvtI9u7uyEvkzVUI7hPsSF
 CggqlBhUAELqGSwRGfegq75dPJuYBzE6BPtER4j4hRUYKKvd6UQXjOrXxYrJOFJ4qpOPL
 +I/rn3gpYbH1O7fxZQmZHIUR036kg+HmJML0W1AcxGgFqnKBNqAuJxGLQOrLpbMg7Tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792486619;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=p7ASprC4lngBq9CCoLWZci5w8Xo/eEEtGPujgTQZtvQ=;
 b=aunYOu4CMWPoSydT7PghFmuUH3Q10/RjzB244e6CAG41f6XsPltF8TegxzyD86FQgYNN
 /fCNent+ZnSgwWQELTDAQuDKp7WJjUPL9JlfhbwzX+uxWk8qJT6M9BbNsUpOJ1RiffnH6
 cmTQOam+QddqA+lb6XyhnDKOyBRibDcLX89t7fWLavm2Pu9Ym9uU675eGOEYtu7PMm28f
 wJBbVE1ZcAC05nfjT6SRAa8DfnaSCbM1cFNCZGI3VxObb0+3UsHZVRcRdsOe7TOXiKdt+
 zhRYo5mAbc9CpvPRaNSzwfZuOc5MGGQnq2G9AkXyi41bfMGDa7MCIsNxbntxvCDhxZQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mD0nEgTV; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=mD0nEgTV
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A532B4016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:56:58 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so36685395e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792486616; x=1793091416;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p7ASprC4lngBq9CCoLWZci5w8Xo/eEEtGPujgTQZtvQ=;
 b=mD0nEgTVZRnXKRaQVNhBmvIEqsQVDhX6m04/LtcxLqCX8uZOogetj8RmwKQRZQ8LoZ
 dblp0a0WlC5kYjXWAcD55GOYmxWkAO0Nm+xLKZABtZITx7ztHfTfF7/2IIsd84NoQIGL
 RVS49d1jMg0jzL55gSt7ViY0WSIR8cc0jzjju0aGKLJ3dgp0OKXIx2WyOZoBc5jGIBAA
 couSvLfF25ZjDBfQSss1l8bbpEtYkJTxLuGDdphxLTgKl+wPcTlLGWXmohVz4iaKRC+L
 478RuiCFAauOgK/uS9GypFLYyFj4MGncOHOXoa2Rm09f0+ZrvbJ+pNgJABC8VJZRTUzP
 i53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792486616; x=1793091416;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p7ASprC4lngBq9CCoLWZci5w8Xo/eEEtGPujgTQZtvQ=;
 b=x9pvFrlc3wZ4EaEM1vtxggYbsDExJZvcpmrN1ypAkHF+3dDXBN06uW3YgNfnbrTV4G
 ICBjVd/Zm3fjM08PIf0KCTMYnN7SUP4LqIxId4B9hi7Kah1rrOOMDUyZEbb8pC3TCklL
 4sFy5FpYQA1Vl15dRib9v/26+1gMEmuzNVGf5FtbL7foK1Gm2MjM6n4b4TJoVp4ukMv+
 eCP6MsO7z3DpZeUVVX6YHUrZMcrhhXHvq7Tt2NGIgwXTQJwspPsQeD5NRuoWTvIDyZee
 9IgQ2dvIUZDYPLQQs1YGjgbCx+O+iNyh2eyky+In4rz6lIN3UAqcqUTl1oK1ZhX9O6zK
 CJow==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8mh7gKTJiOxJ+YEG5OQMhOmcKxlQex2H88UZleuULK9d0VHe+7pHzQDLkCDbSvgHnKHxFUMQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI+LtsrtJ8CbWJ4wl9VGCs5Cw9Lgp6S/IaF652uXqmIdCz1kDTd
 rSrj2ifGDrLno7/pSko+Q9oBocY7L4//wYedR44vORBP795H9yyF/4LSHlKP1Qn02/w=
X-Gm-Gg: AYBFou2wkKYMROU/CPSUQ74Tt4Q4b0TwuiwPBmiiEZed50OR2N3pscYrqMztPuiTBxW
 Kem2FWpP5c//Mu0RjRj6zPycx/Ytqqbm+lCKknyJVO8k1SElrmnKBakdU/U/kAInVE/mel3WTf6
 HCzShGaZhL6AM3WCRImpFA2jQODVhblHME1rdXvo7FJXDNpPSSOfBJiB97BJiHN5naKZ11ir7UP
 1br5ilZ+1mbJQWx4hWTyPvJwqSz7A5jtROmn45Fd3VIZtbljB5xA389+PuijhxXmeQnz56Zt4l8
 DTHHJQ3Y62/9Iii5LFNjPrMRKbWa6FFTPhSI+GIdqI3lXWH6etvjxLOI7nhyrpyCzE159yD6nn6
 cV76ER/kT85IyfRXc4fQULpJdXypiogZREHw+QcQZyHJugLIffEZVr9C7LwgHDVFobHxHV/twFZ
 l8233jHXH8uelyz1804Kj4af0HnpKCiAHMwout0GxQvyB24FlrcKGbwSEtv7V8QzZcHdsBtJ7Rg
 SEt4c6vLnCGTEO2PNRWMry1UnerRiQ6dDLFbEZuOEqWNLuTldablMR4saEpWtfkhA==
X-Received: by 2002:a05:600c:4503:b0:4a0:a34:6e7d with SMTP id
 5b1f17b1804b1-4a1d7614e56mr234427885e9.18.1792486615796; 
 Tue, 20 Oct 2026 01:56:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cf04ffe9sm243052965e9.0.2026.10.20.01.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 01:56:55 -0700 (PDT)
Message-ID: <e9095e7f-61ed-4fd4-a116-844b3c563170@linaro.org>
Date: Tue, 20 Oct 2026 10:56:54 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 9/9] spl: ufs: add partition-based U-Boot loading
 support
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
 <20261019-spl_ufs-v4-9-61432d0b258c@oss.qualcomm.com>
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
In-Reply-To: <20261019-spl_ufs-v4-9-61432d0b258c@oss.qualcomm.com>
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
> Refactor spl_ufs.c to support loading U-Boot either from a raw
> sector offset or from a named/numbered partition, controlled by
> the Kconfig choice introduced in the previous commit.
> 
> The monolithic spl_ufs_load_image() is split into helper functions:
> ufs_load_image_raw_sector() handles sector-based loading, and
> ufs_load_image_raw_partition() resolves the target sector by looking
> up a partition name first, falling back to partition number. A new
> exported spl_ufs_load() function drives the boot-mode switch and
> can be reused by other callers. A weak spl_ufs_boot_mode() hook
> allows board code to override the default raw boot mode.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - No changes
> 
> Changes in v3:
> - Renamed h_spl_load_read to spl_ufs_load_read
> - Simplified partition selection logic in ufs_load_image_raw_partition
> 
> Changes in v2:
> - Refactored the codes in common/spl/spl_ufs.c to use helper functions
>    to make the codes readable and clear
> ---
>   common/spl/spl_ufs.c | 153 ++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 134 insertions(+), 19 deletions(-)
> 
> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> index cef1843f40f..dc871d0f22f 100644
> --- a/common/spl/spl_ufs.c
> +++ b/common/spl/spl_ufs.c
> @@ -3,15 +3,19 @@
>    * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
>    */
>   
> +#include <dm.h>
> +#include <log.h>
>   #include <spl.h>
>   #include <spl_load.h>
>   #include <scsi.h>
> -#include <errno.h>
> -#include <image.h>
> +#include <part.h>
> +#include <blk.h>
>   #include <linux/compiler.h>
> -#include <log.h>
> +#include <errno.h>
>   
> -static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size, void *buf)
> +/* Block read callback for spl_load framework */
> +static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off,
> +			       ulong size, void *buf)
>   {
>   	struct blk_desc *bd = load->priv;
>   	lbaint_t sector = off >> bd->log2blksz;
> @@ -20,30 +24,141 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
>   	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
>   }
>   
> -static int spl_ufs_load_image(struct spl_image_info *spl_image,
> -			      struct spl_boot_device *bootdev)
> +/* Load image from raw sector */
> +static int ufs_load_image_raw_sector(struct spl_image_info *spl_image,
> +				     struct spl_boot_device *bootdev,
> +				     struct blk_desc *bd,
> +				     unsigned long sector)
>   {
> -	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
> -	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
>   	struct spl_load_info load;
> +	int ret;
> +
> +	debug("spl: ufs: loading from sector 0x%lx\n", sector);
> +
> +	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
> +	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
> +
> +	if (ret) {
> +		printf("%s: ufs block read error\n", __func__);
> +		log_debug("(error=%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Find and load from partition */
> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION
> +static int ufs_load_image_raw_partition(struct spl_image_info *spl_image,
> +					struct spl_boot_device *bootdev,
> +					struct blk_desc *bd)
> +{
> +	struct disk_partition part_info;
> +	int ret = -ENOENT;
> +
> +	/* Try partition name first if configured */
> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME
> +	if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME) > 0) {
> +		debug("spl: ufs: trying partition name '%s'\n",
> +		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME);
> +		ret = part_get_info_by_name(bd,
> +					    CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
> +					    &part_info);
> +		if (ret >= 0)
> +			debug("spl: ufs: found partition '%s' at 0x%lx\n",
> +			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
> +			      (ulong)part_info.start);
> +		else
> +			debug("spl: ufs: partition name not found: %d\n", ret);
> +	}
> +#endif
> +
> +	/* Fall back to partition number if name lookup failed */
> +	if (ret < 0 && IS_ENABLED(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM)) {
> +		debug("spl: ufs: trying partition number %d\n",
> +		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM);
> +		ret = part_get_info(bd, CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
> +				    &part_info);
> +		if (ret >= 0)
> +			debug("spl: ufs: found partition %d at 0x%lx\n",
> +			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
> +			      (ulong)part_info.start);
> +		else
> +			debug("spl: ufs: partition number not found: %d\n", ret);
> +	}
> +
> +	if (ret >= 0)
> +		return ufs_load_image_raw_sector(spl_image, bootdev, bd,
> +						 part_info.start);
> +
> +	puts("spl: ufs: partition error\n");
> +	return ret;
> +}
> +#endif /* CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION */
> +
> +u32 __weak spl_ufs_boot_mode(const u32 boot_device)
> +{
> +	return UFS_MODE_RAW;
> +}
> +
> +int spl_ufs_load(struct spl_image_info *spl_image,
> +		 struct spl_boot_device *bootdev,
> +		 const char *filename)
> +{
> +	u32 boot_mode;
> +	int ret = 0;
> +	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
>   	struct blk_desc *bd;
> -	int err;
>   
> -	/* try to recognize storage devices immediately */
> -	scsi_scan(false);
> +	log_debug("spl: ufs: devnum=%d\n", devnum);
> +
> +	ret = scsi_scan(false);
> +	if (ret) {
> +		printf("spl: ufs: scsi scan failed: %d\n", ret);
> +		return ret;
> +	}
> +
>   	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
> -	if (!bd)
> +	if (!bd) {
> +		printf("spl: ufs: could not get device %d\n", devnum);
>   		return -ENODEV;
> +	}
>   
> -	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
> -	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
> -	if (err) {
> -		puts("spl_ufs_load_image: ufs block read error\n");
> -		log_debug("(error=%d)\n", err);
> -		return err;
> +	boot_mode = spl_ufs_boot_mode(bootdev->boot_device);
> +	ret = -EINVAL;
> +
> +	switch (boot_mode) {
> +	case UFS_MODE_RAW:
> +		debug("spl: ufs: boot mode: raw\n");
> +
> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_USE_SECTOR
> +		ret = ufs_load_image_raw_sector(spl_image, bootdev, bd,
> +						CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
> +		if (!ret)
> +			return 0;
> +#elif defined(CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION)
> +		ret = ufs_load_image_raw_partition(spl_image, bootdev, bd);
> +		if (!ret)
> +			return 0;
> +#endif
> +		break;
> +	default:
> +		puts("spl: ufs: wrong boot mode\n");

What's the point of introducing the boot_mode logic with UFS_MODE_FS and not
implementing it ?

Just drop spl_ufs_boot_mode, the defines and just stick with the UFS_MODE_RAW
by default and add support for that in a separate patches when needed by
an implementation.

Neil

>   	}
>   
> -	return 0;
> +	return ret;
> +}
> +
> +/* SPL load image entry point */
> +static int spl_ufs_load_image(struct spl_image_info *spl_image,
> +			      struct spl_boot_device *bootdev)
> +{
> +	return spl_ufs_load(spl_image, bootdev,
> +#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> +			    CONFIG_SPL_FS_LOAD_PAYLOAD_NAME);
> +#else
> +			    NULL);
> +#endif
>   }
>   
>   SPL_LOAD_IMAGE_METHOD("UFS", 0, BOOT_DEVICE_UFS, spl_ufs_load_image);
> 

