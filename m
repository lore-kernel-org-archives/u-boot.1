Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C7606B81B
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qQVWpJHU;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=B0XeizEd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFEEB60663;
	Fri, 13 Nov 2026 17:30:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3NZZXobRoXly; Fri, 13 Nov 2026 17:30:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4F647606C7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794591050;
	b=DPl0BRYZT2DSusOWPtNkh47O3gSXcDKYANdbMTFmXYenGJm9njIi26DYjhN+cV5jFWkB
	 mtKp+o8x7UHniBXUje5ZmnfHeGEzI2IRqI7Lild7cpb7cejpr8OjxX8hu3fUXGVjGA8xj
	 WUkzaDSmpT/Hov9XM62sB1XT85lwTHWeYbDe7XpscVn0cKKTVGbsN2cQ6DvoGXPz1+yTs
	 JSbA5mWmMZy/U/d164nZN/tgTSsw7aJoOB6bkGDcbsaSTxyT7mN+o3GowriQHKlMwi7KK
	 36whHiGtP7gPmZ34AnWzLk8R/rELlIyhG24zKxKmt+CCn3mqvqtbkdNm0Md4KljTMFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794591050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=maWTa8Gs+qRlVpy5yZj9lqaQr9oapDQsxjIjC3DwspM=;
	b=fJLhTJ3snrJUu6fxE7lsRvJjHD5oTiaK3A5WP4Zcj5oTLdwjYPNhCYuIlQBIlBTgJn7v
	 qwLqvA5zbRiQSAQLRJJH3LnfZigCaBxFifwC2yZG8xtUyRFYrt+aDTf5KlZfb9048CX4+
	 62WF5tfgNJC+mE+w4gMEuY9toYdzbwss1PjPY9Hf8Je0vDoroscS68u8expDDdIozkegN
	 yIhTR9qofTS7JaWs9u/MOx+fncuXy/kmLlQLu1r6R8Mlko648xO2h8wU4Yzh47w9FiQdq
	 1J4CSQv4wpM6FjzZ5YX2RYihtVKLV/2Ud5dpFOcnAmPF4Nn7zz0Sur1fC4cr8dSLDtg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794591050;
	bh=maWTa8Gs+qRlVpy5yZj9lqaQr9oapDQsxjIjC3DwspM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=qQVWpJHUgvn8UvNE+ThvATD9pBm4QQOGhK1BDmq8rCYM6RObPhqB6jhA3wzhOzDob
	 N8YyuSk01OjXkEqQPQ7CoxH0J8YeYWA2OHNNNZkZrLu5qgGJVYOf+vvf5UbGmHl+oR
	 /+mge/zQ6X0QWgNq1dgm+VyL9S80KPPOOpsKzcguC8kCM3hQXnzOjfBRMudnN48KQM
	 BjUg0kfDH5k/qHBuXEQhFM6quiwOdGzEY6rhfxqkoj6gZxbMbaw3b6TMr3ucGqUzND
	 JsyC0t03Fmit5jVkKoa38EqhvXSs3AjoNZE4mn5sfp/h1XMRcIZsKwLEOqUt3WgqnD
	 V+bCroISYwZCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F647606C7;
	Fri, 13 Nov 2026 17:30:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA484F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB345409D0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:30:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0pccKNRluXrD for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:30:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E358B4098C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=B0XeizEd
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E358B4098C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:30:46 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so7042485e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794591044; x=1795195844;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:from:references:to:subject:reply-to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=maWTa8Gs+qRlVpy5yZj9lqaQr9oapDQsxjIjC3DwspM=;
 b=B0XeizEdZGILvwUN7oIbeVnxn75dOEAvzYx76oupWm1beTLcDUAoU2Z12YGc0TWP1d
 o1kRUcnGrfiGtX+/K2UA8M3HjFOZH+/DcRGtiv9jhC9sRbTS7K6XPKHN3Gm+KJsZkDYl
 653SdnM6q9kh9WC5TR6mwYKyBJ5eLZTPZgOrOA195W9GACQz4c+cqZ+t9vzCKFmVwv8V
 TOh2pMYzz+S0qcBR6J0auouduZWGSM7+TeD4CMzW/M9Gx/8xaT7qWDHumISyCc+NIzZz
 yub5IKFE2VjSuS4A20rTE0vKaT/x3bLwwb5sFPfRvqreQp7gq5eRGFIvZdljU6jwJRQo
 b6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591044; x=1795195844;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:from:references:to:subject:reply-to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=maWTa8Gs+qRlVpy5yZj9lqaQr9oapDQsxjIjC3DwspM=;
 b=LbN01Po3xLPQokjuUWxxWX5RXUmGFPha+hRu3DB4gCy8koQPgoprGQw0zoBZGguJ6u
 SUPZfI3j4bUikdFmUC8uupmFUpysqhEFNrGTOg0SnC84r+WuZQSS/y9X8BoR9RLf7P2N
 TYhC+/Tf92KsXusmCTPAQsAKQ7eqk+8ROPoFnOusRoNRArmDte55idJS0XtBN281eFhk
 bpeabB05hhGoRi+GNN6MbKy9lzl1FynX5Lcxk4ujUupwQ1XjbJOCqYc3hq+U55zayykj
 PrSb8APAv3HxbfSIGLXLZLZoDdQVgafRe3UiKEyza6NCAMWd7bWhdQyjdityocqfsCSt
 bUEg==
X-Forwarded-Encrypted: i=1;
 AL+hErH2Hek8pSWWHknRkCq40T+uzUj0SGq2w0nDeCqKasC8fPVDfG6gY2PkP/dYOMdRP20mf86aRn4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/q4fXKwCkBj/iPXIp5KKImepbv5LnUSPWUsOQAeq4E85phDivn
 31CYy46UW/sB76HzgGEmFtyTHxS2w5Px5B1pbVRHpLrcvmDOw/hAmRobio+UwQk5loo=
X-Gm-Gg: AYBFou2n7Kbd0NoVhYwqgfr61w74fvUCLqApjmcw5gqy5wvDAB4h/1todJuJWcuLD79
 3qZhrux3ZTWsb2A/GIhNdJVWvn4STAmfOVDiWGRZbHiXu51VRmT5GMaAuqC/1BSn7Y8m88dVcv5
 RfxGzpFDkChA7FoGrZSZjIiftPsDDCevhY9Cq9mEH5d07EyFh3KWtBQSDXJpv4oivwgGFRhswSA
 q8YdF1weUlQrlxvfAix1ibOmYXlQz70o6zoEhcw8lPVaCgXfyN17Dt6aAxqy9k3GaKDTK51VRnj
 Bi09B0SrwmwFAiLt6wcC09p2RuA4glzNIQT6yi7qAMxHIGwiwJqDZe7AeizkFV0ylgSfEoN+cQm
 WI4sf7oK8eWPxu2RJTJAsw0pDD23zSjQqzr8xyBQUghr1s/KbehmkP+bBjmrPqKg0ESVwIAt4Pl
 HFRUPDkiUbPSSTRt0FlZzRaLSVBJ6IVVIO0SVU2DTqWSnC1hUL6N+VgPuXDKmSLqCe0/oJx/dtP
 h9WqtlRh+f/GjQLDxuZSdFJevrqIEH/5vmuVRSKIvhPItPIn/dlFBHFnP15xOkXMoVrZ2XwjyeH
 AVPatjV68aOrugBNDuPA8NAcLDxViBzi+/t6SdrAr4BgvvL3Gk9MBPYp7bZaHJcTZTMn6qLJwDZ
 kMNJUR0dPFSpitnAca/tB2/5O9u6Trw==
X-Received: by 2002:a05:600c:8906:b0:4bb:5f07:10dc with SMTP id
 5b1f17b1804b1-4bb5f071358mr18295945e9.22.1794591044153; 
 Fri, 13 Nov 2026 09:30:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:425d:19c0:6d18:4379?
 ([2a01:e0a:106d:1080:425d:19c0:6d18:4379])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb56689bc2sm44095575e9.2.2026.11.13.09.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 09:30:43 -0800 (PST)
Message-ID: <82e13ed0-11d5-49cc-9d45-e0b62d80ab5e@linaro.org>
Date: Fri, 13 Nov 2026 18:30:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] google: Take over maintainership of
 coral/link/samus/panther
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261113170759.1231845-1-trini@konsulko.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20261113170759.1231845-1-trini@konsulko.com>
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

On 11/13/26 18:07, Tom Rini wrote:
> These boards no longer have an active maintainer. Take over these boards
> for now, with the intention of dropping them if no one wishes to claim
> them instead.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   board/google/chromebook_coral/MAINTAINERS  | 2 +-
>   board/google/chromebook_link/MAINTAINERS   | 4 ++--
>   board/google/chromebook_samus/MAINTAINERS  | 4 ++--
>   board/google/chromebox_panther/MAINTAINERS | 2 +-
>   4 files changed, 6 insertions(+), 6 deletions(-)
> 
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
