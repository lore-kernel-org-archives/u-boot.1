Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF72CC6B2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 09:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E22D460818;
	Wed, 14 Oct 2026 09:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z-nJ-KbcBu2Z; Wed, 14 Oct 2026 09:46:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18AAF60783
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791971181;
	b=fEL2gkIZRqykkiHJIVEf58JMy24ZY2hTUGB3S/ZVJJu/wDq0IIeDlASMdJwh/g+RcM1+
	 752T3hOU18oog2IGvJsTAbI/rC0OJcMeEjZ+UWog97ROkN26Zuh+sNjKBqTh+dsQ/RAHa
	 IbfLMEaeJx99hVIsyRNJC5iZopegFMPxqJHdZMix5PlLVl0iy7A0+xhKbS2zT/UHoMNwD
	 7dCtUhrQMMdvLh7jyB3bOdK0hE/q+7x10sfjDjc2odyt6Xu2/KUbcOclBLqSSJA3wBCoC
	 jlvrhwwrgwnOkCSbG6SlmgwoMzpNep2l0sDymUmiYz7GAGj5eMaKJFvs5iwbD7aPjPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791971181;
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
	bh=7OWGCIPcbNGiJSbGxIFwCTCg+W++D0AwkbWNgCH5LJE=;
	b=cr/66ZnYzUoXzmcJmt//eNSbJuqdkykeGB1PEFLvqDOr5mfKFsaPlvjVGKBVpRFfhueY
	 F4Ig7CH/Zg2ljlWt0EruwQ0/cZdBkBaiARVB+f5FlF/EywiFESdhJY09XFFyDSJkE45iy
	 dbMJweN45MdBnQ0Dr8TEsZi/KKCjS9nZvMz1Us09iGGtfYBFIIywUoS1CV4kMvhZnPQCl
	 7+3mjNsxasVjVtvr02qGPpLYGVtz8AfWPd26qYP5hy+lufQz3KqsiCMY4gSxOPXJohI+p
	 O1BYxntQgHutQbQMb5CjcLczaOgLs2sso18UxuHcHgTnJXinLOiaqMAzNdizZTnjnFQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iQdV25QB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791971181;
	bh=7OWGCIPcbNGiJSbGxIFwCTCg+W++D0AwkbWNgCH5LJE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=PEbXJSTzspGZOlhaF32azFfDYCCte8mUmIruE9bhMiFeGXgKQoqI0SGASoJafulFt
	 xGKZxj4mUeoiFEE4vTC5WSeCprJ3ezhyZA1aR2Ve1fCjb6mH/ZIRT0Vr8TgDpFg6gx
	 rGChbhltic1UZO8SpLTh2DJXBa08t7wkvNwYtFbaHAwuruHtHZS8JKvkgUJtiKskkT
	 GT5nY3o3KbvdjPKnwDG9Gsc+TCx3Vh+xrQAIZgUubG7RF3073OEKLncfnu6PiQTN8V
	 6A1yoq/Z5FAT9e7XaZAClhiUAnTXdchLkE8t/c/ZGsNmZ/tsfL456iu7Zg4Hhzt5O6
	 XXKPGLKmfNaKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18AAF60783;
	Wed, 14 Oct 2026 09:46:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6ECD51DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 607FE60783
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZEHYwyX_wFx for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 09:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03FDE606CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791971178;
 b=cQgY7t2Rb4ijv74KJrnsZR6L7t7AoFQLfD6C9AWimvPoSfLMA8+85TCPBsA0dDIAkTI7
 OuCGjs1ek1ptySyEsAt4O2mrHc2G7H6r010x3WacixcMsWJ9TrVhDP7TpQixWr5t/r0NT
 spRoImOflOMkpd74pLquviPnG86ABrv7dhH9jXrLLm9Nvz7lOTlPHRbICb5aSWJalcz/w
 +L3w9U7mZNIjCSGcwjt05gsg5ViEbwb8Pdr+xwUnx3MtE3EX9kWSpGpxWGlI30qGLxICi
 /d28MzQryv0e2mNsE6t/oN/Jw+SzTxeH+8adxdixv2o4fqx4CESeNa9fXhqXLnLljNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791971178;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=7OWGCIPcbNGiJSbGxIFwCTCg+W++D0AwkbWNgCH5LJE=;
 b=Nr7L4PtkwhE9c9ODu8R7d2Ok8f0rcupiihwU0+EdIWHQfowy5H8/Q8rHifTgVaIOGoWL
 OienpbIv7hp+wxTm5e4ZZGXQO0OFnqubh4OQ9qUUwqZ7Z3gbCTgiTzZzRtsIHn1fD4Eo/
 RrluTdsgUsH+voZ+weA5vvFl69Its3lmKFjLTcT/bbOJQJ+WbyyJFrvW0UU7yLxgdSjXj
 dDhOSThKvB5HpAVWpqyuMG3lbGeD1awu1eLPMuR+kbDBSZH1tYcFP6EDbJ6OFJzzsUfjj
 /HxukyI53NuFXQj1gTv+BpLlvAiaMV7Lg7zn+wtLfqtH3PWpO0i6w8Gj7xoPHvaOTTw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iQdV25QB; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iQdV25QB
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03FDE606CB
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:46:17 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso30694275e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791971175; x=1792575975;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7OWGCIPcbNGiJSbGxIFwCTCg+W++D0AwkbWNgCH5LJE=;
 b=iQdV25QBWmznutcbX5hOKK++dto2otNwkIpR5sKpiB8MQ0eIJA2JQaJlusvXhrckhJ
 2Z0VLW9IuJDYDkRnL1yf/0XI4VEX2b0//TdW983Kq7L05ad0oqfMbQofquok5omVptsv
 9g/XtGDeCTY46LJ/lbcljRl/Et+p83MDITkdXvgT8jAzoK0FyVEtpndiVpNqdxcXltiC
 VdWTM7BFF2JJ6A9CCkuP3RnrB6lmNbc//JDEvU6Uh6rWXVqvqqaXyc5St+jqU3x9ToK/
 3qgZNa3iNW/QO6BpUZ5nUy1SJTVhl1vRNtXuQVv73lWcGJoceyGlOS+P8lmg2wfeXi/1
 i9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791971175; x=1792575975;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7OWGCIPcbNGiJSbGxIFwCTCg+W++D0AwkbWNgCH5LJE=;
 b=TkT32QieOHFemjt6Nsyd4/hPm5dMke4y7fIOVcNQdDKzVb+U4694C33Sm3OQL3LvWL
 aecva6Uo8fhO3u6MfZs5gwxUYsXnGhH533Bd2xjM6axwgmZLwQIQzLw4RVHCJHsMeiPo
 rMw8zQknUkgGyopAtu0qpFj+YvJuXkc3qk40hudpDgBYf03w7yJqTu7mxjQyHj7xfHiA
 kgiXodtuxMJGpVUHX0kZxOOQU1AlRJvDtXVUUntW8jZAba8LkMTCKQsCCgtTG8VpCoTN
 k11r/dgN5OglXQ0NF0WHkp6py6yOYY4h9B4heFht9cFP2CZjfdztTp03I6+CdQIKGvFL
 Uhrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkABEmIGSpAFWDLO4E3M0UUv9Z48MfWkM+q11AMLP//GwBBrO3FMC+3sgWidVb/f5RK7q4nT0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIMyC5MeGHuy6VGa9SaNFfLgcmYJ7M9HeL5pTovlwD1kGLLtRL9
 3LRY0GMgaJu1Sp0rh++C34lQUJPWR0NYsAjW6LnsnQz5IxRrg7RJrxXmlrd2I3ks0ui0HzsRUu6
 l7lQF
X-Gm-Gg: AYBFou1XOlGW2alK3AbnKbQp1RjQLTJP2rov2QzLf+Byi1JfkyH6Ucm6ZvxR2159mq7
 e2wjye7uO66oneC0//zOh1/haQxpjjWG2pOybDhwn58gkTHwl03Slh0R7jcRaNAnyci6qD5Jpqf
 wpBnHA1eyQWuSViZnTfpTkOGJ+g6oS74Fg0NfSMgCxxh1bSS8A4RUl7RPi79QgGgAtmHieJL+1T
 NT+liPUd83V3e86IeAVAN48K2LbWIuSIsUZBWR2VV/k6URLi/5Gp8az0oR+088qfPhL6Bkwgk69
 p8PIOQeGbWI7ytGTj0oNqVLvbd0G+6NAtswoSZrR+hPiy4QkWgzHNVieebs4cAX1jDjxwS8pd80
 25Aqw0HMC3JlkQoErY9wJwCCp4ga6dFZn72nFLc+9H7S6KhoR4Xp3Qd+WtIpS+OJz+K0us4cqPl
 oldD0OZeZeEMmjFMa15M5qczGqy4tQ4TD6Sbrk1gXEm2hATSBokpNcyGsDrsbgIhpujGQs2flX4
 MM6aMh184qxqdjfyzGcUOzQHlRRyI3KvikgGvE4CiCwGcrGIVxNHw==
X-Received: by 2002:a05:600c:8b78:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a18e4837f2mr289648215e9.5.1791971174837; 
 Wed, 14 Oct 2026 02:46:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb?
 ([2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be8c5e7sm547666275e9.4.2026.10.14.02.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 02:46:14 -0700 (PDT)
Message-ID: <afdf3fbe-3a4b-403e-bcfd-fd166cc72a82@linaro.org>
Date: Wed, 14 Oct 2026 11:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] configs: khadas-vim3: refresh Android support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot-amlogic@groups.io,
 u-boot@lists.u-boot-project.org, Guillaume La Roque <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
 <179146357781.183177.17223915816731601716.b4-ty@b4>
 <xhkdb1p9u7x4f.fsf@mkorpers-koolstof.csb>
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
In-Reply-To: <xhkdb1p9u7x4f.fsf@mkorpers-koolstof.csb>
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

On 10/13/26 11:44, Mattijs Korpershoek wrote:
> Hi Neil,
> 
> On Thu, Oct 08, 2026 at 14:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> Hi,
>>
>> On Fri, 25 Sep 2026 15:42:23 +0200, Guillaume La Roque wrote:
>>> Update VIM3 and VIM3L Android support to match the Android 16 AOSP
>>> A/B images used by these Khadas development boards. Remove the unused
>>> non-A/B defconfigs, increase the fastboot buffer to 512 MiB, update the
>>> partition layout and correct the DTB indices in vendor_boot.
>>>
>>> The layout follows the AOSP generic boot and vendor_boot model:
>>> https://source.android.com/docs/core/architecture/partitions/generic-boot
>>>
>>> [...]
>>
>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)
>>
>> [1/4] configs: khadas-vim3: drop non-A/B Android defconfigs
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a2d0134bfc140b9b2092ab09cfef37a7da7c51ac
>> [2/4] configs: khadas-vim3: enlarge the fastboot buffer
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/349d13ce42f60dba1604accc3abb24d5f6afeb18
>> [3/4] configs: khadas-vim3: update the Android partition layout
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/09aee880eea6cf05e117988da1be8231b07c5bc0
>> [4/4] configs: khadas-vim3: fix the Android DTB index
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7a403d3db56db9f1efba44ed145e875c23fb785d
> 
> I see that the patches have been applied to git.u-boot-project.org [1]
> but the b4 ty note still lists source.denx.de.
> 
> Can you consider updating your b4.thanks-treename and
> b4.thanks-commit-url-mask so that it points the new instance?
> 
> FWIW, this is what I added to my ~/.gitconfig for DFU:
> 
>   [b4]
> -    thanks-commit-url-mask = https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/%.40s
> +    thanks-commit-url-mask = https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/%.40s
>       thanks-am-template = /home/mkorpershoek/.dotfiles-private/u-boot-dfu/thanks-am-template
> -    thanks-treename = https://source.denx.de/u-boot/custodians/u-boot-dfu
> +    thanks-treename = https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu


Forgot to update it, fixed thx.

Neil

> 
> Thanks!
> Mattijs
> 
> [1] https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-amlogic/-/tree/u-boot-amlogic-next?ref_type=heads
> 
>>
>> -- 
>> Neil

