Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878B9C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CADD60869;
	Thu, 10 Sep 2026 12:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPp1eqiY20HS; Thu, 10 Sep 2026 12:55:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8229960890
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789044906;
	b=kDb5Agyw2mnU2b0b2RBn3XL1wZMOY536fuuj3Q5U3tghcoWbXTuwIZhyvgzSLvToVi74
	 NICqKdH64WG72EPCLOZj5xIAyQ7KsTKo5vN/HNv0RWZNQO7Sj0oIFVS2AlNjKRMnHqXk9
	 2Ua2fRWuDn7bUi6qv/E0GnBgG2EcqUgQ0X+EJW5ppRJRSHzmzVCpGyfv8EZOFe8DpFWMY
	 NBsHTUOOBlpH/GNn1ljOcnAyBsYc6yGSW6MOPJuT/3zuXaqJy5nyE1Fja9jfNGvXH6JxM
	 GDLr/gBD+JmZs9HNK4dcXkh6SiK1/1kWrrG75cQL8nTr7dU9R5SBPIUCQqCKFG/+V6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789044906;
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
	bh=D9Rdo9wtGYEb8GsrEnSw8NgauFNQ9E9MgnwqF4ny+eY=;
	b=gbF2LyHvfXU06EKNHICcer0eooX0Rhz5LWHUhATEdLvzvek1ojhX/8TrSc953LVvoB6t
	 JWoC5c6cgRTYj0Jbt0cAjW5Qk0306Y2tFDuXrGCx5WpXg0gXfSCrmp1FuRQ3o0bqqCWjW
	 w/jwVWjfe7ylX6kyGso3pP+dLQqeuihUDEPlDfOhTzyAr5RIL/C+mhja/SQu/N2OAreoe
	 vPDeaqxDuKF1T5jr7Yw2v4AcVcV94WGzUPvC/nDIPSFeDp7a16joZoeGSsk3audDkCFTa
	 3r8vwcDmAs6frx5/6p/2Vl31r8ZuyQ3UAGpj+cSZKhQ/ixK+S9pXhn7gkhP1SIteevg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789044906;
	bh=D9Rdo9wtGYEb8GsrEnSw8NgauFNQ9E9MgnwqF4ny+eY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=VzCyJ1uRbX9tc1KBcMhmtmgkcm5SZ7xXCj6Ol71xbFpWBdi07585MkbHv3xsk+Tzm
	 OUmzVWctsZlq1wkDGYgL7SzdYApwRbdkJJHkRs0dJRy9aaRmqiwSrOg/oDtbUW9PWi
	 XeENaTHDY9TP5pWvmxZQRbdZuwAAD9hbbQx0PymSK5Ito2OBCO/JVOLv8sZs4mZo0E
	 JyOEExlij4/d1pcw6W6WZlEQgZfItGktP4x54GPRvHKACvdIHcMFeyXSDMzcVFQs14
	 gRqtgSYlggOprkPqaaSN0moGtMF1kYBPPpXQF5akTz7RqVroiuCMtyOkDMh9KJ03RB
	 VAFwRIKk3xGJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8229960890;
	Thu, 10 Sep 2026 12:55:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 00F0343F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6D4980FC1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:55:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYk_BiR0BE73 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:55:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D48D280F80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789044905;
 b=egOtTe0472tCtzR4yrDpDUTTJXH19zC6fVLDDWaZ6nMO6BqFvf7VgubEayLcplZqe0gH
 hLJGvE1IcocLalQRad+Q4XHK+5zSOinJ7mlK7OtZa6kYC5Hj11w8rY+kFKH/+LdWWRERL
 BWxW1NL9q/75SUWroCBZ88wWTYrHh0hbJ97XM7cBUTx5pLvGeuMP58gBVnzZo4tDh2o/1
 ReRymbuTskcypJFXDwb2BTUwMhGPl4umfZKAzutm2xVixyzcvNkolIBy0EdCe1Xh33Omr
 cgsHoSxSFzBEaefsh7JYaIZ93suUISucYwLOEas6JWvmKzYFHFgmwuVH/opD1SrukWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789044905;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=D9Rdo9wtGYEb8GsrEnSw8NgauFNQ9E9MgnwqF4ny+eY=;
 b=iVzAD3CdAA9ATbGGQW7xvqCnylhkXGWgnT33Wm+eEMu5/17IPloBaAdv6rM25aFP5NRL
 CR/Swk6xQGKGFBISOgWO1iXNJWNesTomFjI+wEgERf2AxeMgrXTyr+bQ6OAR5U7gczRxd
 7TVAdLQETEkG8WPFWMPQjar5DAvACTSt4pT9VXzLvwyNkPZ0Q5nqR1tDtPkZX6lR6F/9I
 IN4eSGKX46WpNEeNEnEkaBRkDw1U8FB1teAFVgaS/gBKGB6nfbl/hehmj7KhiyZPamHAJ
 hIYscSBtxiVEFXeynhHjuRM+gOUPPqpMfLdBdqQjXQHIKJf1u+S/EXGGfeAvpGDeiLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bMUhAqAC; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bMUhAqAC
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D48D280F80
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:55:04 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so13994735e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789044902; x=1789649702;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D9Rdo9wtGYEb8GsrEnSw8NgauFNQ9E9MgnwqF4ny+eY=;
 b=bMUhAqACSAOonR03hgQYQIClIbqKgbdx1aK/ldu/EZZ0qg9/pcwXke6VIEB6tzJCZD
 wgn9caRm6GWf8KndOS2fKVv3JX9F6E1uFZ/I/+70WfW75GNE60+QF94RBq6wcTV22YRw
 Xu5N3C1dcZy1cYrnOqtsOdPYopB7U4mS7MtzMXTcSO6j9CGX5nS9Mur618llRtm/PdaR
 n17ExClilGYT+ZzqiwjMYBuGrGOIzxS9n72hC4zzsAoT1RII+EaEHCov59aE2+iyAtt9
 c2c0WLQ8fn7xkHehQtUla6QzZSAUY20syWy/pPePmLy/VhfnKAaY9gPj4ngRWmHFfRVZ
 U0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789044902; x=1789649702;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D9Rdo9wtGYEb8GsrEnSw8NgauFNQ9E9MgnwqF4ny+eY=;
 b=OAfUhKYV+qHvdFahJWA8GlsPb+41rNqjjQZMTaFSOiMGA3kt9NUEbzmbVklqIGB3hW
 sPrAquuKF8Cx+Kg356E+u4rg8FWIOzE/KKtT4ms8hnSGvTqJJrqUGkS0ppOaZ9/wZJAk
 rvi2XuN0RFPs0QouISDt8Ug92I1hXJtNXH/iYD8tquIPOIHjFK1atifNvCLRpEb9yO0q
 N8m0BolCjOzextpVw19zzJ8NE7CVIUNeo/YLIHy2Dtpbny+DN8siWs7/Vb5BbD96nCMu
 ukoNwtmrub02xkgpX+8KpE+zmAZvr97eSDF3ACEx8WxL60XiWwGdnBYn03zeaSVUQU9N
 9mNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBym18BGrA4mhPx5x54yTGw504KBlV4tA555YaOiSEojsqCJFKTzDsl20k4DaY2J5RwRxWUrfps=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nZ1S8gxtxPQSAjGtaDTWvPIanHYcnvCFkzJ5RJO2ape+FGueaW
 t2QEhDM978zZDmiR48HZwKhxPSPU+w2rHhVwaNcBHqoXsyuNQdSFpE5THLTxAW0AWQgsiqHpts6
 8hEbT
X-Gm-Gg: AYBFou0FjKLTnH+gfAmu1Z8HZ29gjASWcDqRpCB0ReMAjsIekzPJEFOZaj7BuTd42Ii
 BSYlJ4JJdz7YLjfYnF8fJJQ1NpWtlTHiaM+1P7UOmbG+j1hnSyVY0bUdceCmL9f+t1pqPi2nIc+
 mkCQVG6ZZZvtuFfzWFITT0YNBIEzlUBN9jLjfyXvFqLVOBjmdsSqopKtpMMPJzm0jJXX0LESeNr
 ze+6D9IK0n+NvOQqfknIpXOuC6cdB5dM5YBC3s+KbJpcEO87PyLM4hCsgnvXmplftx6aI+kLMQY
 5vKMsMrz85flD4yvE6EzzEqcxwEgLkrOnkY5k+gMRBzz1x9m1Iy0KjZNgpcOe+Ke39Iva6V/qy8
 9L/GEllj2Z+/SB1c5iNNn/avx/txcLnZARA+dwr1sr2s8G2X4P/xaZCje56R1xPBRZ5z8jz+bX2
 2L/YGDNAEdk9ic3ZHTT3ETJ8m8bVcS8dxvzgUxz+e3Vor2eWu3YRLlznomjW/baDSPbACkGP/Q9
 UilW4WSdquYmSYauQlUdxlTBqds5KggbRT3fbRRHfd4DS+4pp51+Xc=
X-Received: by 2002:a05:600c:34c9:b0:49d:1deb:a629 with SMTP id
 5b1f17b1804b1-49d1f21ae8dmr238854265e9.2.1789044901819; 
 Thu, 10 Sep 2026 05:55:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2?
 ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26bdb629sm62947015e9.2.2026.09.10.05.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 05:55:01 -0700 (PDT)
Message-ID: <db4ad378-322e-4850-86c2-b8cdc8e2b860@linaro.org>
Date: Thu, 10 Sep 2026 14:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] dm: pci: fix uninitialized fdt_pci_addr fall-through
 in pci_get_devfn
To: Scott Moser <smoser@brickies.net>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dustin Kirkland <dustin.kirkland@chainguard.dev>
References: <20260805203113.46567-1-smoser@brickies.net>
 <20260806181818.197191-1-smoser@brickies.net>
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
In-Reply-To: <20260806181818.197191-1-smoser@brickies.net>
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

On 8/6/26 20:18, Scott Moser wrote:
> From: Dustin Kirkland <dustin.kirkland@chainguard.dev>
> 
> pci_get_devfn() reads addr.phys_hi and returns the low bits of it as the
> requested devfn even on the -ENOENT branch, where ofnode_read_pci_addr()
> has NOT written *addr. The C standard leaves that read undefined; in
> practice the returned value depends on the compilers stack layout and on
> -ftrivial-auto-var-init. That value ends up in pplat->devfn (set by
> pci_uclass_child_post_bind()) and is later compared for equality in
> pci_bus_find_devfn() during PCI enumeration, so an under-determined
> value produces an under-determined driver-binding outcome.
> 
> Concretely, this fires on Raspberry Pi 5 (BCM2712) when built with GCC
> -ftrivial-auto-var-init=zero. In that build addr.phys_hi is zeroed
> rather than left as stack junk, so pci_get_devfn() returns 0 for every
> DT-declared non-PCI child of a PCI bus. The Pi 5 device tree includes
> one such child under the second root complex -- the rp1 simple-bus
> node representing the on-SoC RP1 south bridge as seen from the OS
> side. Under zero-init:
> 
>    * pci_uclass_child_post_bind(rp1) sets pplat->devfn = 0
>    * pci_bind_bus_devices() of the second root complex reads vendor at
>      bdf 02:00.0, calls pci_bus_find_devfn(bus, 0x0000, &dev)
>    * pci_bus_find_devfn() finds rp1 with pplat->devfn == 0x0000 == the
>      requested devfn, returns it as the pre-bound match
>    * pci_find_and_bind_driver() is skipped; the RP1 root port is never
>      bound as pci_bridge_drv and its downstream bus is never enumerated
>    * dm_pciauto_postscan_setup_bridge() then writes PCI_SUBORDINATE_BUS
>      = 0 and PCI_MEMORY_LIMIT = 0 on the root port; Linux flags the
>      bridge as "bridge configuration invalid ([bus 01-00])", the rp1
>      driver fails to enable the endpoint with -EINVAL, and every
>      RP1-hosted peripheral (USB, onboard Ethernet, ttyAMA10) is
>      non-functional for the rest of boot.
> 
> Under the default -ftrivial-auto-var-init=uninitialized, addr.phys_hi
> happens to be non-zero stack residue that does not collide with the
> requested devfn, so the same code path just returns -ENODEV from
> pci_bus_find_devfn() and pci_find_and_bind_driver() correctly runs the
> fallback. The bug has been latent since introduction; -zero exposes it
> deterministically.
> 
> A "reg" property that is simply absent now consistently returns -ENODEV,
> matching the documented contract in include/dm/pci.h, instead of a value
> that depends on stack state. A malformed "reg" property still returns
> -EINVAL, as it did before this fix.
> 
> Fixes: b52142004fbd ("pci: Add pci_get_devfn() to extract devfn from the fdt_pci_addr")
> Signed-off-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>
> Cc: Scott Moser <smoser@brickies.net>
> ---
>   drivers/core/util.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/core/util.c b/drivers/core/util.c
> index fa893485..57006554 100644
> --- a/drivers/core/util.c
> +++ b/drivers/core/util.c
> @@ -20,10 +20,10 @@ int pci_get_devfn(struct udevice *dev)
>   	/* Extract the devfn from fdt_pci_addr */
>   	ret = ofnode_read_pci_addr(dev_ofnode(dev), FDT_PCI_SPACE_CONFIG,
>   				   "reg", &addr, NULL);
> -	if (ret) {
> -		if (ret != -ENOENT)
> -			return -EINVAL;
> -	}
> +	if (ret == -ENOENT)
> +		return -ENODEV;
> +	if (ret)
> +		return -EINVAL;
> 
>   	return addr.phys_hi & 0xff00;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
