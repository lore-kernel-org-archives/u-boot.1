Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A699C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E79CE80E31;
	Thu, 10 Sep 2026 14:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSVjpvZGjl7a; Thu, 10 Sep 2026 14:06:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 268DE81007
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049188;
	b=msGGsZvzmu8syjT0pcTBfFrbBf4HGkkFpa3ICFuBJd/zh0Ub5xl9TNbYFmUg/vnMBpgf
	 Ehy94JEXSz4+3/Ijc96pqvMY/tSAZW0Li2QFRt2wQl5q8nM11JD9vyjNa6ODIhDD7oKex
	 +DgtwSvBHvDYeS2xwJ2V38iGqMOP8xE7beXc0P/s34adTNXYwnktzmDBsonLJTvOygQTQ
	 7Sz1Ahbv4WWkC6BeIizuh0A3Khq0R5IbtmwSuVajCRlcc/DJ2/9LQvWrz/evjYA8MK4HK
	 CFU8uPP6cCsBLd8DqhnZS+SWwbJxe2smkWrkwGFnjo0COAlMYYkd8JrAA7Tt+XRKDtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789049188;
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
	bh=jGoMU+1qnIVIB1yfUUqQNP6GRKbZsieKJk/qc5M7A+A=;
	b=pT4MMcgXLsFltTyaXfUXqJodm48UQ1Er4/HCWTlRav+s17V4Apln9yd2wC0lHtf2KtNL
	 j25ethCvG86a9348y19bv40UBA56eEoGKXJSU6fu2gA5VFuEimAol4FzG+bkGfTbvKgCr
	 eQwE2w72MZGwpojh+SvK/3VXGgZTScIJhPvnmoCsBfnlaDIyFcipnD5S/PXt9dggsyebp
	 Cc5oOR7cJ77cyHA8VVh4WvCnt7xCOJFVayt6S9MoRo6ZwPpzfEvPQLqFWdMmV2QM8of0A
	 XDRHiupdDm9t9aZ/PaN4azvRY5jT7Rl0OxStb3CEgCt86Uk+ffekjy34kS0RYJQDwWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789049188;
	bh=jGoMU+1qnIVIB1yfUUqQNP6GRKbZsieKJk/qc5M7A+A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=rMYswVgW9fU7jNluySLyAjhaouqMDZhYwnYlejfnhqOL2etU3kyvmRji0wZQLmBIt
	 8A8ZhBg8/kEubod7afjie/OR1ydiSZemdtOp1OEc9d/7vMGel8RtS7ZutCimZt5A0K
	 xJGLvu8cdZFtxB8nlvcrc9PWT6cJnnnjtf3d+CpUjTG/IF0nRno9pdRT5D1W8+9ws8
	 w74Q5yDp3TJ9P2wKBDB3WXnyMJ0u2dihw9PempAjLGNNax7UYl054ooK2bQO7T8EaJ
	 x2TM3dlr2PZEe7Kiw0pgolSu11BGxHWNEMxFe77QsPZ9RsbeMigyUsxOTHj8PS+aE4
	 9QV4ogynMvrow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 268DE81007;
	Thu, 10 Sep 2026 14:06:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 560F1E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C0DC400E9
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYmF5Hkrd8gb for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:06:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0D5D940024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789049185;
 b=Ylcsq/dONqUICNP7xLHXb4FVgJVlF8mRaeeyLWjdHvZ7bK0HVWYD2BCBCWnsOnzfi/ws
 mdQWkZPFXXUEvLa9av+k7MAjkKa8mr6iUpjBnheD38zx4oc8F58ybQS3QmiP68q5MCsX2
 K+b2Uv20FZHX3Ys1V+3My6u4TDDcnafohBgLSeOh9d8g6ACPS4LgedY0BGWefrLO07hJD
 WIKhdBpuNXQ0MWDO1VDmPitibRvfj7ru9CJ/c5wbiXsJ6fuqdMxu4ougRQ4yh7txUruqW
 ii5O8G8KRGpcyFn43sQqywLHy0P75Vcz9LUjpvrFKvsvH/mWEpshsbDoT68OykOf6KA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789049185;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=jGoMU+1qnIVIB1yfUUqQNP6GRKbZsieKJk/qc5M7A+A=;
 b=lCbJXHllcdzATHaoFIks30U6XAz6NFhG9GC/4ojh4Ld8Y8zzR64taJjbAsXwVAAKK7no
 JVqiqa/lBsWNTC4DsFXGU+sJezrg1/gdU98gg/Hl1gPw9MV8dzOWU+S93szXTJTbRAGf4
 FJRDOEtxEvwqdHxx/zNMBnynmz33CHTySfJQMNmvuXgk+AxFmwUs83iySSP4fi3mwa7JP
 jDTOWAEbyhVXtsGXTC2LZrCrSZ2J0GUvIk+axCiQlNbRSBTPLKYmW3YzTkWgJOrU6bM/9
 OTs8V4tPRsyShHTJcek9HT2isNiS2GVl5BkDWuc+8jnrfXYc+oH6kSYEXY7YIYBiNXA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=K8jGkq8N; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=K8jGkq8N
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D5D940024
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:06:24 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso60320345e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789049182; x=1789653982;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jGoMU+1qnIVIB1yfUUqQNP6GRKbZsieKJk/qc5M7A+A=;
 b=K8jGkq8N67XjxbndPOXPZgyIp+3hsUvvH1T/3po0ShwteU9Y/dmJl3e4CLVS+WLw6h
 7TOZ/rbyLw22EZyE6NCpSKgj4AcqiamJaI+8024pbUSzSZzejTQHjoiygxTUOROwLBs3
 4lgeiySfxcemVaVBsG45k0k6FyGdlCxzbw1fP/IbQw+05KVVHFvvYVnuCPRdbVT4BBsU
 RYqPLdfl6T0LqFg9uzU7KOVWl2pMX3hm8kvaRSBjs8NeKMu1Vew31i5MctVyubWRejAT
 KdqTFIgogtpc55aqfoIynp/EzFCV7RYnHDS1pkOWH9aFi+uQdMfSRUL3ADvHFVN+LLHd
 1pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789049182; x=1789653982;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jGoMU+1qnIVIB1yfUUqQNP6GRKbZsieKJk/qc5M7A+A=;
 b=SPLQSQr94J7LBGlplL5f1CYp8s/t2D6pt2tN+HOlvDlsZEsLsWlyTBhDkK26ZdQHR+
 ng7/3mqEpTkCy2VcycYkd7cklJmOqPOwZucfHbysGkcnIrIyanBARvndAd5VfmFEoAdq
 +RyH0GWg8Az6u747Z1hxz66Lmee0ORMk6+RLw24W7jmyvE3i/Mkr+8jO+aw4iS+FEUBk
 R2k1KHhvO+QAeLJ9KVHteY8xrgDol1JUV9culsj5fT72PvolNIqogfWh6wxvO/NamO5/
 es06alndwvaqxnyR+0CmNwMOdqu1ppVyz/gE6nYB2KdKqOq6hRRnAcBOCXPvwguDCRPj
 sv+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8RPgpgQ79nuCo5TTYfd8xnNg16i1NvRA/7mi/LLxbimn2vf5imxbfPrOSDag3tuirG4Xj5Fg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kjVnjoYqylnW7V01fzI63O8hCYX5UGbEbckzR5Sh6TDdBkGUj5
 ewVWcR3T0UMlPw5o8jHViVtSEjv4Hx/4XqytP4rR7YHqw2J09Yq7ISOka0HMUycriC0=
X-Gm-Gg: AYBFou0q4g9hwN9PJN7Ih6PsVffI7m4nLPUXng0SwhoY7sZrFqp/DtmlY3o4thbuGvc
 xILAAalZoSIHdIRujx8D+CiMxQPBApJd57wYM9XWrTowSlNgaNLNb8YZIWFbRvcHXdFjNiVEEvY
 D30cWLEWwzuv3jf3hkr8t726MDUrWetwh3WIAn3CoZRudcKwwpLzBc4evnTKcVunYkE29Od7JS1
 NvuSyESPxg53Be769/hoI2u93WNf2qNsLv8FTCw0Ngl1Y1+o3scwoPKO6ts6DkhsYYSBw8iVWvs
 H9kaheNieXg4EfXZ+uOmcvE3u5jO89C38bS0zl/hSMN3x1EOsw6K23mMB3krhr4F/49uB0ONks1
 U/bjlVmrcZKkbk86CTSyoKaFvxoAdiGC2v07tmZmbiOS/RpGq7hpeD6q18qkgpKmJ+lwMM+5U8d
 TXq/20qqHrK7Ck0kCbVEqQJZ6Q4MT1HKVyV1sgoDxnVddDgDeyv5VlPagueGQHvhvUVFPL+1KFa
 JiM2UtS+LlbFioF5gbKn3TQPhAaB4yD4gnkmT7HfrNDI2xJYL8YHg==
X-Received: by 2002:a05:600d:849b:20b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49cf825d8c0mr305721045e9.9.1789049182127; 
 Thu, 10 Sep 2026 07:06:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2?
 ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c39086sm68083635e9.10.2026.09.10.07.06.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 07:06:21 -0700 (PDT)
Message-ID: <56c6372a-667f-481d-b36b-970fc89d600c@linaro.org>
Date: Thu, 10 Sep 2026 16:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/3] configs: sei510/sei610: drop Android support
To: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
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
In-Reply-To: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/10/26 16:04, Guillaume La Roque wrote:
> Remove Android support from SEI510 and SEI610 while retaining generic
> board support. Both boards switch to meson64.h, leaving the shared
> meson64_android.h header unused, so remove it too.
> 
> Fastboot remains enabled, but "oem format" is removed along with the
> Android partition layout.
> 
> Build-tested sei510, sei610 and the four Khadas VIM3/VIM3L Android
> defconfigs. Both SEI defconfigs are unchanged by savedefconfig.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Guillaume La Roque (3):
>        configs: sei510: drop Android support
>        configs: sei610: drop Android support
>        configs: remove unused meson64_android.h
> 
>   MAINTAINERS                       |   1 -
>   board/amlogic/sei510/MAINTAINERS  |   1 -
>   board/amlogic/sei610/MAINTAINERS  |   1 -
>   configs/sei510_defconfig          |  10 --
>   configs/sei610_defconfig          |  10 --
>   include/configs/meson64_android.h | 279 --------------------------------------
>   include/configs/sei510.h          |  30 ----
>   include/configs/sei610.h          |  30 ----
>   8 files changed, 362 deletions(-)
> ---
> base-commit: d4152edb50356338af994d1c0483f65b717b4c15
> change-id: 20260909-remove_sei_android-44993a3f3353
> 
> Best regards,
> --
> Guillaume La Roque <glaroque@baylibre.com>
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
