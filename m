Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6A2C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 15:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4BE481261;
	Fri, 25 Sep 2026 15:04:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IBNNlrLxJ1ua; Fri, 25 Sep 2026 15:04:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 12FEA81246
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790348693;
	b=LXXaalWQnCk0Vnrq2EgSQFFvDi9odLR5ZLUUm5QS4MoLPlZ+d/A7N4nNQPjLct5cykpW
	 3FCQXHP7e3YP1SHclVYsQpo/uEWw8M1i8tli+fSXTm/KeUqkuN5v+jxV7yfZVuWfoAbmf
	 ywboWGdGwjzOlMwJ6U1cwx2flhED9Xbqmdd+/jhs0+aOKv0T/Inj1Ue6+tti55pUu+6X0
	 w9qm9Kk6E5f7lslkgoiKNTfwOWwD3UCmPHiD/ITZZOPbSpHGSweriowM2Ilba64eiOqhR
	 QlEoB1/mDXUR439Xkm7iE+uygQgzKleoXKqITahYg+8/BpJ1nXpAVDUBta39Lp4NRwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790348693;
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
	bh=avWe43OBeNkGOY5VdBUb2fZ60u0fdDmIYpnmWq+Fyz0=;
	b=RXj1e7OHuCvt+nCNe+gLF1T+d2h3q3tyUEDYaM+/1HmoFQV3uPDhgGaBesNoIlB11RTw
	 7pmnusXDKWBTkWlfGMTS+SywSamhkN+mHKIP7+zUU7fJ1S2zdtU49ef9UzBhtRYVwhXuX
	 kxtRVp2y/oybNj8c4KVTQ/GPZl2DwNAannUgdbLjqzt+upSgz7NqZwrNs481Q4UhW+F7m
	 jRz6tG2JS4Q2hcq9Z94eiWfTUetTpSggNmRZ2NUNa+BlUK21PCsBlntlak7g+NIqx3onG
	 NiSgQ2wLwCo2xKs5xgil1Gdq322gMKh7KA5nKJu+aKyMmKahCDqswygxJe7UdFOWXXQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790348693;
	bh=avWe43OBeNkGOY5VdBUb2fZ60u0fdDmIYpnmWq+Fyz0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=LB/MQeK0H2ZCywPFlU+4A8IcsF+xlF/s1mFx6Re7UWJEiVL7LRY8PmET+qs1Qvosg
	 EMbeCzV0PpHG5Q41QsPeLLa+kngOqNER5W2ZFTqB2nQ5mh66kv7HltWgIyDAPw0OPX
	 g4lNsRp8lSH48a+B2B1mNcFzy6mJ+ewldeQAM3h7EpCXg59FqCW267/ihPsWyOhSo1
	 +QVazPTWi1I+r+eaKPPjklTq6gpn77c4MEBZvflIxshY6l4WSgtXUV9Ykba0V7ovgU
	 6cUf2hBaV92ZFdfvAzYUgOVRd0jsFQD359HVxikI6v5uu7DS6L8/7D4tja5x0Rw0n4
	 JiUj2KPkVkftQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12FEA81246;
	Fri, 25 Sep 2026 15:04:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AED8035A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 15:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94D3140181
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 15:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uNe8YVnOQQT9 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 15:04:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 30C424016B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790348690;
 b=XlsBzh0X9y0pmnUcUEEx5PpspP3FNYnsLokF6FTGHPNLHQ4/BxI8WxOxELqWuILM0RL3
 Jmg3a+LobifgfGD/kLSBxkL5VHn0sA4+2Z73kyoQLUxRbwCQeujely7ZauPipoiSh2Ng5
 +X6o/NcUWMtwRV+RjB6E2e6+PPyx1g4YvTWDdoCV5d1hk4TKJ/TPkcM1AlQSU3I5Aqj+l
 KoaJwEuFMU5hegUzZkFFUSlmUPEzoaEFdqmT+/lY7AOYvt4LUhD3RSROKbNezCgmGP17X
 bLj1GEHvvd4o7ftZVD5zbTOosbdJj/cyv59G7+vp5/nG6jeHv9GowRhweN42DkP+Xqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790348690;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=avWe43OBeNkGOY5VdBUb2fZ60u0fdDmIYpnmWq+Fyz0=;
 b=CgLuDaPqjh48zzWWB6MOrOxNKk/B36lmb+uh7+4xNzksQmiHhODL7tTcphrKs0i3wyTt
 XpsaufaWiLWYHFjZcKBXmk6ExOA8JiHkKwZ9eC8s6s9svqXgDsymdCuGHNJygO+yDDg3I
 TAR7KF80hkRJOsED7eLoZlcOT2VIgy+I5gHeDUM81ggwN+yVwh0aDjGODlwng8zNB3Oj8
 05YCend1CMVpH2ront4DL892qQkyipLpphpxjkBPxxfDpzsqeSMjMhr3v4c1A9E1yrGY+
 QnsTISP/aYFGYTavpCqS5Uzx7+7miHM9BEDNwno7A2Ln3efJw5hLiAAZA6MfT0z5JBQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YKWxt9L+; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YKWxt9L+
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30C424016B
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 15:04:49 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49fe8bf173aso5714835e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790348687; x=1790953487;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=avWe43OBeNkGOY5VdBUb2fZ60u0fdDmIYpnmWq+Fyz0=;
 b=YKWxt9L+VNKse0dBlRo3UzDLj/KO/4DfcyGpFyyBSbFaDX/9Y+qW3Zs4lQMdbcS272
 9S2SeB2nPPoHXnW63yjRSz2RhPXeHrPp4e1Im4j/vjFZXjoJQtl5zFPGbEQS5Toym6hD
 tTTuRURt4YCl+4GXExivZf6UlO6tdbxzYfUtLNaxWlII8nEtzPenONJFWulaobs5MzGk
 B+esiBGn+188Q/3m0+ortewCClYLva4zcvRXerufZlLyOuV0/vOF4iLRus0sQOP/3PN3
 J+Dmaix0dobad5xEk3fpaKHEgLtpFIq3EgSvQg1X3qIX2y15crcOXryIg1/iOjWm5Ar9
 8bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790348687; x=1790953487;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=avWe43OBeNkGOY5VdBUb2fZ60u0fdDmIYpnmWq+Fyz0=;
 b=x6VUSfVP/N3Xo56j7x1Qw+VA7u1XontKxNRX4C6Y7aXYiXITz0cfjBIY1VFBX72u/P
 HSalHb+Nmj8SJ9SLsNoZRy4FFn7/xRWpdeVxYgjOPO0Df/rlxpMbipTyMMnzMd4BFCFe
 rnzD16SUQBpSHtuTM1S28YrLpoW+AfhffOIxDdRmd04Rf6pl7cThptKxWj0fhP/MkxYt
 uSe7EPY8gL6APKPkwqGHyUMmpkVXdixS2081r+/auz9wREc3SgSwqoE2MdgTPkx0gYYj
 akiFc3Z4XdLOm0tQ/9IdxWjsYnbhDwJ+yP9CHc6sycM9XcXN+IKiIjRkyTlVseS5jViM
 NSkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpEDnG0NkRpYEGzCLfW8wKEwxtt11neElOlakGCH+qzCjq+2tU5Uz8GTFOGC8uL5OIron5Xy0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lFcW9HTm8Wdxhvnm2KH6xhsOrqQZtELWPGqxRo7aidTuKvpD6M
 /3SBc7Zf2f2fQnAAQZl2fLfGhA6jg7+jWpcTKcskXfMxsdtqh1Nzje6vJUaTqSisPC4=
X-Gm-Gg: AYBFou277dVn/X6v3g7IK55rGv3RJYDBtuDE/vGu3n5ez+FceCT75crX9iK6jWEGfhe
 EMVj5WU2q7PJ27yNjCqVSbO5UIdwWh3buPi5dyMA+ebl01KZXA+FDmgBUiqL2QLQfVjiqyjfr39
 8aMM7crojUoC4WvdKvNFuRY1nIrL7pxqhvw1okMArQ5k6TaVHKuj9jrVTxvJ8pwzQc9ChWp8+J3
 /is7AGamGoH9SgGx8zNi/5Cj+rKDZAhyfYoOczBpNMDtJmjVe6pQHygKmMB7bTAauY+9JGDTQJv
 aK4F2zgfol2ga5YgZ6EUWaIl4j3UsENyiGtt2XZdcLFFdi1UrU/Hb0HMKG8DtiwPvxp+GmZOd6n
 JtdCz237YnEoY3E3Inwxjwam/HY+fNltIReEf6BKZ5R+q+wIs50TPczahJgEMfDsVsK2vnJLHmX
 zJPN91RxcmrtoIUDXJLh84pjBEmp9hEoK1zMZY5f4/g5jlox+caPN7L6Al2YUei99M0T9JGqt99
 uPrLjNgPG4P+/YWnZa0j4Ji3Uir6r6fMPQoKbE6/1EprcROHuPHjVIexjtwZQ4E
X-Received: by 2002:a05:600c:630c:b0:49c:ffde:45ff with SMTP id
 5b1f17b1804b1-49fe66eb254mr102383955e9.17.1790348686113; 
 Fri, 25 Sep 2026 08:04:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3151:fc9b:d41c:770b?
 ([2a01:e0a:106d:1080:3151:fc9b:d41c:770b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef5fe71csm50799435e9.2.2026.09.25.08.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 08:04:45 -0700 (PDT)
Message-ID: <b40d236c-6180-47a8-aafd-971fc7497244@linaro.org>
Date: Fri, 25 Sep 2026 17:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] configs: khadas-vim3: refresh Android support
To: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
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
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
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

On 9/25/26 15:42, Guillaume La Roque wrote:
> Update VIM3 and VIM3L Android support to match the Android 16 AOSP
> A/B images used by these Khadas development boards. Remove the unused
> non-A/B defconfigs, increase the fastboot buffer to 512 MiB, update the
> partition layout and correct the DTB indices in vendor_boot.
> 
> The layout follows the AOSP generic boot and vendor_boot model:
> https://source.android.com/docs/core/architecture/partitions/generic-boot
> 
> Both Android A/B defconfigs were build-tested. Android boot will be
> tested on both VIM3 and VIM3L.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Guillaume La Roque (4):
>        configs: khadas-vim3: drop non-A/B Android defconfigs
>        configs: khadas-vim3: enlarge the fastboot buffer
>        configs: khadas-vim3: update the Android partition layout
>        configs: khadas-vim3: fix the Android DTB index
> 
>   board/amlogic/vim3/MAINTAINERS            |   2 -
>   configs/khadas-vim3_android_ab_defconfig  |   1 +
>   configs/khadas-vim3_android_defconfig     | 122 ------------------------------
>   configs/khadas-vim3l_android_ab_defconfig |   1 +
>   configs/khadas-vim3l_android_defconfig    | 122 ------------------------------
>   include/configs/khadas-vim3_android.h     |  36 ++++-----
>   include/configs/khadas-vim3l_android.h    |  36 ++++-----
>   7 files changed, 34 insertions(+), 286 deletions(-)
> ---
> base-commit: 951132236b9adc592c2e49faadd103c6a355cac3
> change-id: 20260908-update_vim-997dcb218017
> 
> Best regards,
> --
> Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
