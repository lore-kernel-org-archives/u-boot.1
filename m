Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D6DCA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A09E7608AB;
	Fri,  9 Oct 2026 09:21:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Epeh499SKLQX; Fri,  9 Oct 2026 09:21:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C68E5606F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791537701;
	b=SoshsDkReed4sVJtIRq7uFxQXBnIJAOOuFTQSg+4VxKrTTiNeE8XyECOcGXzY1AyeQwf
	 Ewe7vTGprRVPPCfoBAhmKCQJw6RrBKWL2KlRIQCI0P6+IxUtadHL4RgWL8FmW2mmsxqE6
	 R/KKqr51jmLlRzZk3Tr4x5fcMECX31p8cG/AyGFHTSYa9mZi1lDBmZjGMXOdvNH8Azyqf
	 58R/i0K6TOcRlXCFB+TVe4o/+nwlYe8cYladwvnsyIwZ/wM31psmeouvgj8vJre6uiGjj
	 /iqPvpptHbbmvJG1Ns88CBH8bj+Z8eRR3tJsP0vEiOuGLJ3f8eXDQTWZ2UlmZXSXWqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791537701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=NOEndm6xZxON68GJlhIU8fq/k9azRdAwO9gJ09w6r5w=;
	b=FCsO23dVLRkUG/1aArjDfnkWnA+kf6wi8VBtYDfjKL2xfllSVLlisPQXuiNbk/CVa1RT
	 4w48qASlDCr54XZ5J7IM06sHCP51I2IiByN8TcmEFqBNRlD1+Hu2EDkk5aNBz4SzkDFu4
	 T92EvB/+UXaPPZ/O/bghtB1+Nz+agTz7fmdVW2LlzrOfDQUmsTZNd/LyuBygG2qMdQC2k
	 1swyjqkPHCq5rsoiSEGKzrMMdLiz/1DWiUCE6aOSzw1xJ8z0wPm2qdPPdGcfS933ipzO/
	 W9rnU32wC+8Eja+Q1FgvFmaP9UlpgGMtc/daxmAz1VN7C62SMNwgvhhNM0tsROWltRg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791537701;
	bh=NOEndm6xZxON68GJlhIU8fq/k9azRdAwO9gJ09w6r5w=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Pb/vZPhAdRC9EiTzscFiZ3j/q3pzFD2+Lcb0jxpBeRPGK5brMmN5Us3XXndi8Tidp
	 cDiQXCmV7v8QXcxEI+YZi6EAyX/fonjZdZk51JoBmQznXotJvEbimG9DGsKW7CVs0k
	 gGIZCTEj+gBXwQEY58RSymzuquewcnX6fciGQK4gBC/sMr4QgZi3orNV6ZH5Xwrcdw
	 gPITzguvSPFSu3XPDtp19wcCfEwjSiWnBiyKV5795j6yhyW1G71PAAgOX8LoZ6y/tP
	 QQM9s2CIge7SAgOp4Neuc+I7a8JHD9CoLR0T/NeAqYDdl7d/pZ2/lzRIUcsE3ePtV4
	 fanKA2s91UD6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C68E5606F3;
	Fri,  9 Oct 2026 09:21:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C9B6356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1283040911
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:21:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mmm10o1Dy7Cy for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 09:21:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F83C408F8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791537697;
 b=WPqYIR/KHgObsm6wI2D4QS6NU6QrsSwPkDzrng6CkXBzGJYJ9+ZrNbrAD9rDwFtnJWB3
 6zXsma8kdyNz2is+wMDIkktV7TSZdC/Jhwu/ejxLSQy2UyNd4+nY3g4EFRTbKbcNBIudz
 +tHMjSNiwgJ7pDhlPzJ5Ht9vRE5VNiwkboAuKMW2AxL+FZfuLUzMKhQa3wonlHSFChMFK
 sAUnKSsT0Zx2WrXOWDAHFCZ7igsXNv7NCHRtsRe6FRsLnHIanTl1vWzkT6z6WiqdGSTa6
 RwHGfJEiFaz+XI5o9UXpN/GQPuIXk2dwDXOElrrpxywCmHPdTfqjlNabUm75ci/giNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791537697;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=NOEndm6xZxON68GJlhIU8fq/k9azRdAwO9gJ09w6r5w=;
 b=ZdsKIbP5v0A5CVJ+zip9JIduhwgVHPFw0oCyY4XsjkwP+1KPso31e7ce+lYbIU2mH5aU
 DTkqRDHBwwAcKFzWE0ywwAlN0HgIZJ0LKIIU8pcFGcZeCFTQVaO6s8ARJv97G/DCXwSOP
 PUrRgaDrGh1S2p2IVJ3DNbA3f/HNrVdNc3H+OXq1vzHtGeDLcW364Mc9d9l4Ky9wYBioC
 oSVZd0De3+vXR7Tjao4ykkTA4hsOgV8d8qDoWBISwKT4J4z3xsUmUvLF5qWvrC4eDr76s
 fOVhtHA/1vD/fn+c5vPJcfhA/scvcAvuQBFysofC8B6pykQoZGmpCet7rlYDa8LNHwg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LyeGODNO; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LyeGODNO
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F83C408F8
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:21:35 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c2e26719a0fso384159666b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791537693; x=1792142493;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NOEndm6xZxON68GJlhIU8fq/k9azRdAwO9gJ09w6r5w=;
 b=LyeGODNOk25rXqRPTy+QCdg3Tn0rWIdMQRI1yW6bAUKCKlYHfe57OAJq6353kVW/Cs
 dyYZNeVvKY35+9zap5kiy9ujgxustQvJF9QSVfLVNQqqQJe7PGDuwLg9RTOHl+GpsIVU
 rb0FkKFE70TvYNWmgDQXyx7F1KUhEhZ6OrCDQztDifXp3lJSJ7d7RprGTm8HT31JPiEj
 TC+jRyuAD0VYOS1YJnNQnByReSklX0Dn1diVaJt/Z/aRqDJWn6EgEuHCV5LUoj1wFQMP
 rYJn9EqF4TahQQpTM6Fruz/I67YGjI4OmloyOQVhe+nyjlJYOHUIwX3YaZK/vSd88V5Q
 ssng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791537693; x=1792142493;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NOEndm6xZxON68GJlhIU8fq/k9azRdAwO9gJ09w6r5w=;
 b=id4ioL3rK7qHp8Bkou7wqqzy0hayy6gIlgEd7ooXAbCpB8zb/nBLzvoCfSI6BEtn2N
 jSCJPMkyzZrTNCUhpLmYOMeUWrWrbF6ZH528hvluMSRoxKvaCb91DGdHQVld5c11MIzU
 f/kYw1iBVBIw/fIFMVRWe7a0St9mEjBdK7gZIYmb8iLgbJVq0jwnpyqw0H5f7+1zj9GP
 Vrq/KIP4qTFuhgfm/29r6Pov5XSXS5yEz6tPDqjQViXXaufvNXT8IZpT8k1+VWXhZBwT
 Y7Lfm3sEWMc8ODYcZp1VsOSqSkOHPlMM8bpGDr+MtJuwh8uEGGw/G91LMjNzXw6Jdm4r
 OlOQ==
X-Gm-Message-State: AFq9FYKWlTHg5yAnoKD209wXIWb54EOsvMctDUl7iNquVTXjWsxLF4J8
 3FnrCxOyvM3u5SJjZj+GYiEwLL3kUaYuw9KaX6HrZUR2twpnzyt718dD3cXRmS4eI9U=
X-Gm-Gg: AYBFou2uG2jqPkJfBeOdQiq8/C7PB1Yc0NitDHcfo4mV8XA7/1hMdwqKB/swzrj95YS
 UrWeH7vmgOO/jxR4GYuTit1HTp0YkXrMLs7+MWyJiHgPIHUtT7RckbVQIAlNthIX0av+QawVPxo
 DWZArdaF3Fvfm5ZoE8dG79iexxS06C1ji6L6Fg5cmmIN+Ps0OfUh0s+3+fT9U7ggx6rjt3JnqwV
 Qp0rD7gJYO0b9w+Fw9fUXL7Wi6BpOq/gaz5WfW06KRR1rJ5x3czIG5ay0PnCliPpiRF4LYcflLi
 vb7z0JHtBRFgxiiq2QLmTE1hoxKkUYYSs6x3DgZvaNEcQHWGgDdChtAEJFAeSboG52zasDgnk1w
 CtmtGkfrSWMcEEBU8zD5czmY5grbdVals6zJhFIR9qhv/85/M8QmS4idcsN/2GX5Nxz2G03DT6F
 yxr8WY8dA7IltCpSZ9Kq2t/GTQXpuhbmQQlLBbkiSr1ntt01VFwcMyV+WP1FeTBX4TPc6ajiFp4
 aM9yJycoLt9tVzQJNLpWURov3mzOTc=
X-Received: by 2002:a17:907:9694:b0:c20:9447:bd5e with SMTP id
 a640c23a62f3a-c31a9fa1d3amr130540466b.9.1791537693193; 
 Fri, 09 Oct 2026 02:21:33 -0700 (PDT)
Received: from [192.168.151.76] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be97d1esm71139245e9.8.2026.10.09.02.21.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 02:21:31 -0700 (PDT)
Message-ID: <f7aca815-72db-498a-bf22-c2d481c44c2e@linaro.org>
Date: Fri, 9 Oct 2026 11:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [ANN] Meetup during the Embedded Linux Conference / Open-Source
 Summit Europe 2026 in Prague
To: marek.vasut+u-boot@mailbox.org, tgamblin@baylibre.com,
 glaroque@baylibre.com, msuchanek@suse.de, andrey.lalaev@gmail.com,
 rui.silva@linaro.org, monstr@monstr.eu, marko.makela@iki.fi,
 henri.sundelin@iki.fi, nbelin@baylibre.com
Cc: u-boot@lists.u-boot-project.org
References: <dac81055-ff78-4b28-9539-ea533c12cb33@linaro.org>
 <b5d52786-4dfa-447b-9ca0-886bb00fd444@linaro.org>
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
In-Reply-To: <b5d52786-4dfa-447b-9ca0-886bb00fd444@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi All,

It was great connecting with everyone at dinner last night. Despite the unexpected heavy rain, I am glad we all made it and had such a great time!

A special thank you to ARM for generously covering all of our food and drinks.

Looking forward to seeing you at the next in-person event!

Neil

On 10/7/26 23:27, Neil Armstrong wrote:
> Hi All,
> 
> Just confirming our meetup for tomorrow! A table for 14 has been reserved at Krušovická chalupa for 19:00.
> 
> We booked a few extra spots, so please feel free to invite anyone else who might like to join us.
> 
> As a reminder, it's about a 10-minute walk (700m) from the Prague Conference Center.
> 
> The exact address is:
> 5. Května 798/62, 140 00 Praha
> 
> Looking forward to seeing you tomorrow!
> 
> Neil
> 
> On 9/28/26 20:28, Neil Armstrong wrote:
>> Hi All,
>>
>> Next week, during the Embedded Linux Conference / Open Source Summit Europe 2026 in Prague,
>> we plan to meet up on Thursday the 8th around 19:15 at the Krušovická chalupa bar,
>> which is a 10-minute walk from the Conference Center.
>>
>> The place has a large variety of food and drinks (menu at https://krusovickachalupa.cz/menu/).
>>
>> Please add yourself to the list at https://pad.sfconservancy.org/p/uboot-eoss-2026-meetup shared document.
>>
>> We will make a reservation based on the headcount from the list, plus a few extra spots.
>>
>> Looking forward to seeing you there!
>>
>> Neil
> 

