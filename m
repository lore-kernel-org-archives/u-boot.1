Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7E2C35FF5
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 08:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1BF880D8;
	Tue, 17 Sep 2024 10:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M+Ofd2zJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A38880DB; Tue, 17 Sep 2024 10:47:08 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE92D87F7D
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso41337615e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726562825; x=1727167625; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=dBUV6n6NEkC5vvZsjQldFMYu+CW4jRrd88sDOtNfCmo=;
 b=M+Ofd2zJPgeSEnIX8SuC0wBBC2ZEqyagqOwuBT4FXQ8plLC8qkGhmQeL7SLtDrO8kF
 eDRUT6+OQlr2BCnfdmLRa6Yc92m+pNPCxqsMrgzMIk/KLVvSCL6062p7v8T6eOGmYhyv
 uY2oBxbShrI1NUzG5qCUu2NGEkXi3jBQN9fCbo37AoXoGXFxa+22byhXZ4L4PzivpNtS
 OdarIJFVkEs1LZ9l9jnhcz7B5Gy95qQMj+abgFntRyWvQkkCqDX3YfYio0LfrBaZZdet
 P0d7MGBac7/0GEBr3wpzTsMOwJADsk4NBQ3iF3G3IprWTU6fsnnYBnBlQtsIRKaARW2G
 S1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726562825; x=1727167625;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dBUV6n6NEkC5vvZsjQldFMYu+CW4jRrd88sDOtNfCmo=;
 b=vVi4gAeJbO+IhWzSbQT68zwsVo7K3j7DU78tzKHtAtN4ytpPF36ZQeC4lkd7L15Iij
 HXM6nrdHcjqt803fa9nQjkG5bc8ONpqthWHs/f75wLU8gFqsu6HCIUq/bfnvbISPg1AI
 IP4Fvs50pDKNDYXioJJLddJWrZuUeVPfZ9cP4fd+Sr7fR86dQU0mMBIgsgMzphyZGH1D
 2A8avA9Z2oGdzRARn9nDUsEdUaX3REKGMa30CELRrU2oTpe6IV8L9rnyqnMTl1pWSq6F
 R5R8Dcfaz7sSagbKUlcfqZmGAPU60QTaTH/3T/7HABxoXBae8R5UN0EzajCypebxs8ms
 aV3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7KK5YADoOeMZQV8DyIAoAYVCzBShwDoRPkd5WjkZs0ZeC1tqh9I7L6KQAGvATuJFmkS91DQE=@lists.denx.de
X-Gm-Message-State: AOJu0YzXPs4UVYIWkRDlkWzf+f7EW3nnyARiNDSiVWdhHTCwKH0jLZIC
 v/mocsrg2UMIGwVhx0XiqgvMuNcAjNXu9DHnVdjLehyX0zkfTrmpU/gI7ArZBZg=
X-Google-Smtp-Source: AGHT+IFA0FUnt+jReJfc6DnmCAVwl8Zdf7JRzBYuDCF/OrQ2xhca/Zf17WLXcz4ZNsQFkyTcDl0OrA==
X-Received: by 2002:a05:600c:1c27:b0:428:150e:4f13 with SMTP id
 5b1f17b1804b1-42cdb572754mr121671575e9.33.1726562824551; 
 Tue, 17 Sep 2024 01:47:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e5df:ee06:f22e:a8cf?
 ([2a01:e0a:982:cbb0:e5df:ee06:f22e:a8cf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da22e8292sm97960535e9.26.2024.09.17.01.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 01:47:04 -0700 (PDT)
Message-ID: <730c32ea-bf25-4bb1-bdcd-5afa17d39f07@linaro.org>
Date: Tue, 17 Sep 2024 10:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/2] ARM: meson: libretech-ac: add suppor for EFI Capsules
 Update
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>
References: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
 <20240916162912.GF4252@bill-the-cat>
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
In-Reply-To: <20240916162912.GF4252@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 16/09/2024 18:29, Tom Rini wrote:
> On Mon, Sep 16, 2024 at 11:41:47AM +0200, Neil Armstrong wrote:
> 
>> The necessary changes were made in U-Boot to easily support
>> EFI Capsules Update and be compliant with Arm SystemReady SR.
> 
> To be clear, "SR" or "IR" ? I assume you meant IR here.
> 
Indeed IR, I'll fix in v2, I need to send a v2 because I need to
add set_dfu_alt_info() to keep support for the ram backed dfu I
used when booting from USB.

Thanks,
Neil
