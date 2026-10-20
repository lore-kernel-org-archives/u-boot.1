Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F4606A331
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n4EOvUj4;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u2Ncgt2j
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 058BD6083C;
	Tue, 20 Oct 2026 08:52:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NdvNFqaOBKy3; Tue, 20 Oct 2026 08:52:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 49AC960846
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792486339;
	b=bwyi7qDDPW8q4v43hIEqviOQOI2c1XwyUhk3hUeh5g1MqEeTQeG5OlhgtAcBqc2K+Qew
	 A8NBrCs3jCBr9eggF7yTQJbcMzz2nkUbZfnf7rr+e/MsrVhrSjrIb0ufJTipmG/cjrvDY
	 Nluo2bIsIPxPMuJuMHD22KKMWQSg8LAMkANMhYxQYfNaP4Uo3DcSuZjtK6XJ7u7plQmIQ
	 ev2mB50Z7Qo9vkqbwanBLVFpBsVPPKQFBq2Aj0XseLhJ4mbUncGO8qKRcA2w/oEl2DycB
	 wjPlV/BF4/7lY1WyLEoazYAg9aWmwewZiCxbEt72FdGyOIKDd7c8B42FLwjFMzFC83g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792486339;
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
	bh=/J8emYWQRZpRKEhy+ommR7YvJMHWvNQ0VaPKi8zBAko=;
	b=PC8JUz8UpCvXc1TjZDffrNsVpZcZGamBMOY7u0gKcenfUDmm7IdoWeusYnVkAdn7kHfk
	 Mpg8rmEgZJ34Un4rXEUlQ8dwac86w6e/0931Fhb9YEIUI+acZIh2QPKoz6/u1P4n4UMZA
	 g8CyxNdX4oNedzVA7LYz9QEEjnQy9NWEEEEr4MLIFGKF8Pe/+UAwZEdUbfWBGuK4tBemy
	 13z1mrz/6jEbz9DbG+YUrVz8VkRDvwzOvc1r7NuUW3zJhvM0Uh/KGEtb9lAk8FzwCowrz
	 HuoEZNl2maOTAPxEumcnW0sZTV79jFZlHyKti7gWr29rDxnUkevK0xrd8RuCufpi9vQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u2Ncgt2j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792486339;
	bh=/J8emYWQRZpRKEhy+ommR7YvJMHWvNQ0VaPKi8zBAko=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=n4EOvUj4wbLmty4pqDKub/TuRo4tdJ88rtad5n9lrf+Px3Cmqh2J2poj8ydQ6ayNY
	 v1+F2ktSNisJEtR+vO45AiuL8SEhEnmaO48UUv2SwcyN7N3cZNu2VD5fbW8YaGa0YF
	 gnjsYGKiw5ywQvyluViv5U33BK/cnr6gLdcOcO7xYX3hjNTxQrj6zVWhXMmO4Z8D5X
	 Jk7V0lVpKmEQJeFVkQQHyDh4oZUPtoaj2wOAo6daQkKsQbvrU8Ca38IuOHsZ6Uo4ae
	 fGOJxuzeHbf707hKLDZOU5B6dMJ3D+z7vUHRNo1QDNlLwPFFCxdrFiwpB6Ffqnogjc
	 mBDE2Min5cG+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49AC960846;
	Tue, 20 Oct 2026 08:52:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DB5A82A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BAC4C60846
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:52:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tGIHch3YtNZG for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:52:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AEC266083C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792486337;
 b=RFWy6x9fe6PR258atHUtRm2MqatkwxW+O865IVC5AJbXf2BI4IJvv0CeaEeY61HmhoG/
 O5FyrwxtMAjch2Yimn/q0EW+tQzBEZ4BoLWpqsD+Wf7CmSnntIoFsQZIJMUJC+U+NbRa7
 zSAZwXtszgMF2m4RC2rNjiZJRP89towCEHxkmAXAVjuiIZDOwINABkOzHtoElelgDPayU
 x17yhNA99qkmtnn2EWVSH5t9Wsm5uB2PFd6DUgRrzk7839udLAmT+w2VuKEYM0gLe1eSM
 E+fuNRfZyeJKjBT90npahEUk4wD51hUyJUEUVmewKzop1xalQFfZoQ1XXDkCl5n9cQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792486337;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=/J8emYWQRZpRKEhy+ommR7YvJMHWvNQ0VaPKi8zBAko=;
 b=UYRVr1bgCKB/Q6CavU2lBaVKNb5kbAL4hdbqfx13bgzCDxKE4ATdsV8DmxjETb+Bu7Pp
 Y+uehVZyRjW5ThBAHHeQGDz7nXGxktzRmZ/3TGleBFJd7WYxC+6PNPumY+qDIBua7gD5Q
 IxEADtbHH4zmY8emfn09roeSADpTCuRTnX8EX0uRCqGdvipdiGvetC3e+FgSXoA23gvXg
 GF7GC2wVBUjvRGVW2SgqVKF6RRpuetIZGWjYKH80d11vG6UH8YpwFi5MlS+7izqp4FOQ/
 zs1jt8Z+Uh6TdD7smAEg8+w5Q1GLWo7Oqxbk3iq+/Iv7N+vMq0SUsNG6mMopGeMbxdA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=u2Ncgt2j; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=u2Ncgt2j
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AEC266083C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:52:16 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so2228301f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792486334; x=1793091134;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/J8emYWQRZpRKEhy+ommR7YvJMHWvNQ0VaPKi8zBAko=;
 b=u2Ncgt2jWMvk6Z1fsrQF+6Cu0yLE68EiNjBoNjT5sBwG3nztV6giXAHX+xNe0j7qtu
 CNnRwHhexczpehtQQ/A4tbjmGvPewHnVMJJ8pnlkWKZhaqggnw98a66rD9hnXHBWgP2z
 PQXSjrzIBaKzlfxrJKQdVs+gb3+5koZLsFp5aX4YqgTpgaMCcjBTimj8iqA6oM4I4r9D
 AYgMGWpr9+t0u0frXhuNh4VN9SZHC9Jki8rXY8zIZWTssl87Isavoga370wBGz4MWXKU
 pf8k2ci48RVVp7rqbhoQXTr4TS2PD8iwVjz+icpnYlYMrqWJJnGE8+gG5+fv2CKlMZm4
 zEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792486334; x=1793091134;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/J8emYWQRZpRKEhy+ommR7YvJMHWvNQ0VaPKi8zBAko=;
 b=Ywk5A+gGlqRDyDJa31FxbYoDy4Se06oF84DWba+x2YN1IV5hAJ1Iu34UMNP/YzJwSJ
 MP3zzgmW3eaDrTEuDqHhShXhY2Y28LyQVpbb8gpUslU6KpzgjvawKawHm5Ivf8n+K3iS
 oiA1YcAZE1buwEtB0dvzsFZx5ACcXUY1JA6ZDGSZjQJ3PVup3KrkZMLx2mG+9AWiBKmu
 6ZO+9PMQGHtF/MwveLR5dyIWO7fm+GUKvEGdvxDIUHW1Pl6SyuhAm2xxmTDNdt8gjcs4
 A+maCNkzDbwBHDtae9y83MbiXGvO7S3Bip5m2nmZbHQ9sayhMiyRaWymKyxEXJjqGQGZ
 3NKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYthX2UOdxzuuuuz+aynbbIcdPJOzEmcXFgbTBEJtOpq2VKNlFPGRAdMwYqYymClt9F2ytE+Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJtOSZSWl5ryoNP3WhdP+lAYmrwKM0Yld30Jo1sDYbH3aPk1S0z
 v+6PDFc7/cL1IGqo65DQdVSpDqQvKCiRvalE/tGbmioSfCFHR8717sw8Z1ozkG/ccKA=
X-Gm-Gg: AYBFou1h5kZ7mqw+NZJYiHczWRRCFjOyjB0KtlNEDQuo2+l+zgjyNu7zsokMEKLycxF
 w7jftnkKdWQDaCkcrnakI/xvDNDwFyNpqZESlMW1LMhfy0Jy9gvGbyUzYGl+XuZNFWyXOzzLf0g
 qOmU5nMmXl0ltDOMsckWs4OUiPb6lePQNg+pcVVzNUXW/U38z7sDr688VpvXdx05Nni0W3O1Pf2
 nnu2DIqm6M7wGnr5+p6AmjmoL5EApyaCBC9TsnEWgB2BOy2/OYX/FVLZ9SuHSPbeK3V7qOsvsSZ
 cvEecngg4MEN0WNbv38hLWilBdQYUyrKQduEOUxVxpA+eVRDVDYdh/6r84b7BpUmj+Z+/MhrJGa
 gf8IMeM6UIUu+A6EH1ERw9qPNbDtfP33oe8A+HQJy/yO0ofG3kgB2v1QLTe4UWbPi9wp+GDYYvu
 HQ/iSX6Hyv7gU1q2wudggNVLkY8SCd19FOqXY6hte++Upjip8zMCw56OV3B7mAWwkKWSJWqUygi
 QiLGqFlfW2n+aw5qAVhy5cTMKRPwidu3VLIHPAt1XaWXoWuf2CAH8E=
X-Received: by 2002:a05:6000:240d:b0:48e:eb5:4976 with SMTP id
 ffacd0b85a97d-48e0eb54a52mr16258360f8f.53.1792486334143; 
 Tue, 20 Oct 2026 01:52:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d80fc6csm4522259f8f.14.2026.10.20.01.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 01:52:13 -0700 (PDT)
Message-ID: <d3dc333f-ce13-4c5c-a9d6-c7a800ed1b32@linaro.org>
Date: Tue, 20 Oct 2026 10:52:12 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 4/9] ufs: qcom: add SPL_UFS_QCOM Kconfig and SPL build
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
 <20261019-spl_ufs-v4-4-61432d0b258c@oss.qualcomm.com>
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
In-Reply-To: <20261019-spl_ufs-v4-4-61432d0b258c@oss.qualcomm.com>
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

On 10/19/26 12:48, Balaji Selvanathan wrote:
> Add a new SPL_UFS_QCOM Kconfig option to allow the Qualcomm UFS
> host controller driver to be built for SPL on Snapdragon platforms.
> 
> Switch the ufs-qcom.o Makefile rule to use the $(PHASE_) prefix
> macro so that the correct config symbol (UFS_QCOM/SPL_UFS_QCOM) is
> selected automatically depending on whether SPL or U-Boot proper is
> being compiled.
> 
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - Keep only the ufs-qcom.o $(PHASE_) switch here; the ufs-uclass.o
>    switch moved to the first commit in the series
> - Drop the stray trailing blank line in drivers/ufs/Makefile
> 
> Changes in v3:
> - No changes in v3
> ---
>   drivers/ufs/Kconfig  | 8 ++++++++
>   drivers/ufs/Makefile | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 8174a7acc5e..1d21dde250b 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -55,6 +55,14 @@ config UFS_QCOM
>   	  This selects the platform driver for the UFS host
>   	  controller present on Qualcomm Snapdragon SoCs.
>   
> +config SPL_UFS_QCOM
> +	bool "Qualcomm Host Controller driver for UFS in SPL"
> +	depends on SPL_UFS && ARCH_SNAPDRAGON
> +	help
> +	  This selects the platform driver for the UFS host controller
> +	  present on Qualcomm Snapdragon SoCs for use in SPL. Enable this
> +	  to use UFS as a boot device in SPL on Qualcomm platforms.
> +
>   config UFS_RENESAS
>   	bool "Renesas R-Car S4 UFS Controller support"
>   	depends on UFS
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index 7c1db11be7b..3b927fc49a3 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -8,7 +8,7 @@ obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
>   obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
>   obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
>   obj-$(CONFIG_UFS_PCI) += ufs-pci.o
> -obj-$(CONFIG_UFS_QCOM) += ufs-qcom.o
> +obj-$(CONFIG_$(PHASE_)UFS_QCOM) += ufs-qcom.o
>   obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
>   obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
>   obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
