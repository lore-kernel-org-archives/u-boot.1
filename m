Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FAEC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1FB4608AA;
	Thu, 10 Sep 2026 12:44:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MbTWMDWrpHk4; Thu, 10 Sep 2026 12:44:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F0D2860874
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789044286;
	b=NdSImPDuuBjTW4+SwT1wPdovMlf4za1YzJKiiS+KeMC5RPheVi9G+RpXi8Ul61ndctPY
	 BOS0IegjO+6OyPIOqYamWI9cM9VY2S2MvoXNVLRvw3jEuhtPB+ZTwmhpzSRiC0qjVF/s6
	 bKfKFV+WZLQkibJEQVOTGv6dgR39M1l3GKrskFnAFhISxeqG+Ikr8icK8zRRrYUD8d1PC
	 mNJKxZIzPdG3jibALdAdtzogkjxl/iOlvNz3GrFDJDC0xr5gNej+NAwn5SQj+Gm81r2p4
	 PWYO4sEfPuVK0qu4JIZBVXUNNOwaRkVYX2B4Up9sOaCxs5Nnu5sH4OuiKekMW6FovYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789044286;
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
	bh=JlLd0MTwxSZ1tg0QA5irkz4aMwQ9l7oCIbDKUgF0cJc=;
	b=bnNMj1mc7Kzi0PuU/pEChP8g0CpbhxdOpPvMBeSqLc67JrUIppW6Y6eD6qJwNQQRV7Wg
	 2SuVpFffKflEiCu1L7H74RH4sHG0oo2ZOmDiiEZDF+gA51PsFGGexLQgb10PpzrlXs3Ux
	 +7cm6HNRK6hpm7NtrT8DvxtVDG4wpXRxALnki0UHg0QeQUBBwQyKdb/3xOE4y9atYv6xA
	 L1W6Sp5fJufIYb4SaHRMvjHf7kaBWZcE0mOIELKQazXeMg9FVGCJN8fNSG3UJ5sL5Uy1x
	 tHHKeIViAJfigzQalbbutjlojGL8CCCiJNL2LR4pDuhWS+PHcFyi4goQXN2W0ltMZEQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789044286;
	bh=JlLd0MTwxSZ1tg0QA5irkz4aMwQ9l7oCIbDKUgF0cJc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=l6gpN7YmT5HngqhOHhPZ40+Xjxa8u594dUbL492uM/Bba93fp6IT++Yh0FvX1uazG
	 uc/gEg/NHjNn4lOxjjhUEfj3ZfZWMIJnyZWBY8PVgmVy5ML9K5kQFpNj+hRlWHHtAI
	 Z6JvFHXJCRV6w9dewIPFH00ouKGGbJqdGGL+a8i8obMKkiZEnV3ycsSyOL6IfEfhn7
	 SGuYMfmvCSuHF1Mho78AQbejg2NiQ0Og+p6Hw9I39kqHQuMWyBBbSTS015Kck49S6l
	 HaLJpO3R3frlZTS8s/3YPOUEpYMmENJa6IBsRB2dbdPIFUM6Yk3lEFB69wHjifjgCs
	 b7mzH5QjLl26Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0D2860874;
	Thu, 10 Sep 2026 12:44:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ACECBE11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F4A0400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:44:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lIAgQ176fTWU for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:44:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7428240090
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789044283;
 b=Sm0vjIJzDVyrNMUGQAJLVXDyx69Nx1c2R6YpW4fzApswhEzyJZh+Te5YS53eNT1TcShN
 nFLJI91nGlPoDSRVvmZjUaOdCbe6evCZKdMgFzDDDkcGrD0qg6HPbe/yl04sn1M/+N6HQ
 UopYaoIXU4CUrVUs5NypHUHmeeUaPnlgzTopds1vkU1oewJR+CimVKI2xWFyPnG0FR69G
 1CNyzzqJMEpd7maKwD/6KoIE1rj5ixe9ATvoaopn7ePEOlyN5Bi5ExG7wB4IZ/b1CuKV/
 PhzLklmIJPq7rvUJs17zESwPaHm70tC99oXm/aGAMTTXSQoWUkQi0Ff9YvhEQfhoHVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789044283;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=JlLd0MTwxSZ1tg0QA5irkz4aMwQ9l7oCIbDKUgF0cJc=;
 b=joFlRNTGU3SeoBkEZBqbXtRAopeciO3QvFNS27cJVRIEmjsPqyGfBU4D1ErW+DjBVNfi
 3F5C6hI7n90TZPE8kORDZpdqJF88TNN2TYHGNudiMc1o9UBmygRnHpDkKw3jwGHOiJEvt
 Ej5txwgibMycPZsZKQU1RbFSXU6fzpVkPZckjfBlEcG9tGw087ZnF8kS8n6Z5Mz14Q/ES
 QHhQrcWfryAZqg4bz4YBFjNlaTehSxuv/ZhoL3Kz+zsRrJDBdRvz86AIuvBN26vEjyA5L
 ltngMWGS9EK/1/yAH7g7nhz5yC/JvZiA6zTda5D/9UcpI5DjMZacmB8vFmF4ij5Kh1g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FizDEiBH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FizDEiBH
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7428240090
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:44:42 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so69162735e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789044280; x=1789649080;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JlLd0MTwxSZ1tg0QA5irkz4aMwQ9l7oCIbDKUgF0cJc=;
 b=FizDEiBHdfgu5GqDMjQmC81tXTCV0MpNyAw5uGqlcHnGBYeeUhcLH+DbyZoIwTmlDV
 2yBetVK3aqcXapNgHd6Y/EZnyZnAglghRa8nBhv5hBHdVpmMUGEpN4Ty4dQBaQvQrj/z
 l7lW/krFMlqQXpQub04FlGXXvRCY09P5sPL8o/F+HQ+5qwnxy4uwHvJs1A/DpopnJAkO
 UKVMXxH5iPtNHa3fOrMe9vvHLLbUSU5vIHY5farF/EHfaf3iDgqGiVnjWORHrthZmDJW
 zNz+ncvx9mdqJqBBec06+/gCvsQZXJnm43zWL5o1hrPSSjohwQIzV+9cymlvjp1jEZ6k
 W4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789044280; x=1789649080;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JlLd0MTwxSZ1tg0QA5irkz4aMwQ9l7oCIbDKUgF0cJc=;
 b=GoC7AEoa+whoMIyq8eRcTZCKmrAl1kX3KepITh7rvxxNZAh1noz3PHNE1AJu+SZAKM
 ylhsLbws7mS4I8k2A414F7h+V+tcV/5ouRtKM1tDQD2tHwedDUG4I5hIduwgaUZ6ffgK
 dToAFJ2e5DIcE1Xox85GZDcvtWByBHTczOMGNNvieWmk1V0hut/secF11WgxKkO9bxPP
 ddwxj0ztxcB897ZFUtQjULG8n5iMpZdupTAqiwx8XPG3Q64ZMVrmNMWLUqBlrR7FeGO4
 Bk7zrrPEpG+6ehRjnePaO4d2rykFEEFTLQsSen1rhAdF2W7nedt6GWHY2/wFRmggmU4w
 1vSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9C3epS4TkUZCXNIw7pkq5qzrtHM20MpfeXl5Xp7QCWxc6yn4FRgiEfxY6OKZxTE+GQzahfk4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kTYJKNY9C2ZhZ8gz/zmHleAqv/9/XgHMCWMzGPXgXrH5e+/TR1
 9vuZ+O+OhRvpS/zpNquC1buOHY3WsYg8anLmKHLH5h0zjYr52y8zW0f4/op4bH8bY/8=
X-Gm-Gg: AYBFou3pdNcBJ1njuV00tiL0vnczqv2Cac6GcV7+vz74XRSSqv7l0BGz/Tg9P8UjfFE
 PhHBZgaLsjRBnum44yW0rC5q7DPfCeJdl1RFDGSsy48nr9roPkckR/Qdgrv3hiiN0l4G7JXy/Jj
 1xSh+PkEBoy6PPEVh++zubRZQwZU0gH13osC6bACWF0lT/zj9VWEbDrxNzdiWL3HzOHD8TQHGSD
 WrEFXh4pq/EPNnh3setF3r1G/Us45B0ZFl5GVMKU2Lc1TdkeLnnV2PeT4Y//CD+iOATDzOkcvKf
 8IVe+rnJrhUobXNpMwOUZylVDDCHKviNjQCilNOT9DI7EzRnflnMTdROEt6gbf1j0whK3zWzhRe
 veyL6e5Dw2kux7bO/lifPM1NjhM46f7CYyxsRiA/O+BqDLahDFMFEoKbcz6kz/mOb5QDQ8hObD3
 RgJ5Y65Nqb24trIvrM0N3SEtz+68opELnXa/I9V8tqBVBdxQAfPpvF6M1PytbOI4rUkx+v4ohv+
 W5dP7AT2CBBBYe89SiRF+tyc2Rw52I1uDz0I8WJLs676RXqLcoGMPvAgs54CSRB
X-Received: by 2002:a05:600c:4fc3:b0:49d:16f1:94a5 with SMTP id
 5b1f17b1804b1-49d16f19576mr196399525e9.25.1789044280431; 
 Thu, 10 Sep 2026 05:44:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:edd1:1b07:ea07:35f2?
 ([2a01:e0a:106d:1080:edd1:1b07:ea07:35f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2a419sm81314925e9.7.2026.09.10.05.44.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 05:44:40 -0700 (PDT)
Message-ID: <6a3f39b8-d063-44d9-97f2-9b74fb06870e@linaro.org>
Date: Thu, 10 Sep 2026 14:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] Apple NVMe fixes for macOS 15+ firmware / M4 support
To: Janne Grunau <j@jannau.net>, u-boot@lists.u-boot-project.org
Cc: asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
 Sven Peter <sven@kernel.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Francois Berder <fberder@outlook.fr>
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
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
In-Reply-To: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
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

Hi Mark,

On 9/4/26 21:22, Janne Grunau wrote:
> Hej,
> 
> this series adapts Sven's Linux nvme-apple series of the same name to
> u-boot. It fixes bugs which are worked around on M1/M2/M3 based devices
> with NVMe firmware from macOS 14.x or earlier. Starting with the NVMe
> controller firmware from macOS 15.x (required for M4 support) the
> workaround is no longer available.
> 
> The quirk to require page-aligned buffers for the admin queue is not
> necessary for u-boot. As far as I can see the buffers are always
> page-aligned. Add noisy WARN_ON_ONCEs to ensure it's noticed if this
> changes or I was mistaken to begin with.

Do you want to pick those changes or should I route them via the NVMe custodian ?

Thanks,
Neil

> 
> Janne
> 
> Link: https://lore.kernel.org/asahi/20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org/
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (4):
>        nvme: apple: Don't set a DMA direction for commands without a data transfer
>        nvme: apple: Never set the opcode in the NVMMU TCB
>        nvme: apple: Add WARN_ON_ONCE for non page-aligned admin queue buffers
>        nvme: apple: Drop the PRP null check chicken bit
> 
>   drivers/nvme/nvme_apple.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> ---
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> change-id: 20260904-apple-nvme-fwabi-cf74f7cefac4
> 
> Best regards,

