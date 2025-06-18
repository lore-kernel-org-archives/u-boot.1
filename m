Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884C9C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 08:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E0882C55;
	Wed, 18 Jun 2025 10:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G82eFoqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A3FF82CF4; Wed, 18 Jun 2025 10:12:08 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C769B82C2F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so57677195e9.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750234325; x=1750839125; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=8ybU2Zn3YnRHG5vW6B96Ewsvg8kID3JhRGBPwTFmFFU=;
 b=G82eFoqkAxGAlnmpLF06PeZHsYn/fdiNxeZUm+pjfY7O1a7kt8DfdSt0q2I4E2Ngur
 G35nclgGVDpmiQVPZd7KRmMxAyLREMVpNeV3jERKEVy9DS2C0fUxPIpJqfGCktSHTfX6
 2PnlYLZfNqy16CeOOETxNhWk5gSXmWSBRPJZC/dRM6xZWe77HM03nNHtV/mpo27GcAue
 G9Lz3Uj27PrMaOsbK8S3fVBv5Cjj3/MfWlQe3rmBXl4EfEWr0ugvRDUbMF36EoDJk0gG
 TmsMTt+0bUxuKue/PGXAA+tsPz01moP7veFl6cdOQhMg0x3EvKVixsmPEQmrLLhXZaws
 0ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750234325; x=1750839125;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8ybU2Zn3YnRHG5vW6B96Ewsvg8kID3JhRGBPwTFmFFU=;
 b=s1cTVHRhJ2nJxwfIMfeIsS2RTXJLPDlUKSqZVhvFJGW5JsY4/nM+/71IVcwS2l/4CD
 zQ/FbSbP2ox8WEPZI05dbNLjwrwWsSg2u3k+SJ3CmtIfI+pJD/mOhblr7xqavxYkOejP
 X2DZ+VkbMMMHHGyjdXFUL2kS3Wn7jeqG1PVskYragIO0VYbDJoKqMOPPxG78coTQ+Jf7
 gDvE2iDrfJ+Uay7APwA1pLU9s3dhT5K+bqt82Vf1C3BA84tF5Qxco4XogHLqkCZycpYC
 Lqqy9HMSRMhjEc35Syycg/LU590ghKrTOJIQhUzlJUC7o7VhM6bP/+q7VuPc+l61bOXB
 7kYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4MypHU92aShTdJ9pcIEI5/sR+V7RO0z8NjklLIW8cX5Hn8fzmlCbXaLwh8O8qPIL/aIc+t8U=@lists.denx.de
X-Gm-Message-State: AOJu0YwPHHLWruXtEdhKLk2OCzXtpk4grWtPGhJ7m3NFZsT/oka7MB/b
 wkGaLESM//oOEpzmP9jT5tOSyOC6ZEKsfUvC1arGgjGnHCzN/z/VxN4bssgis4MPToH7UGJDQ9g
 kxMOF+4I=
X-Gm-Gg: ASbGncvnuOvOP4Ea/eAPnENrv5SfXb/2GZWx2sU4iqOzRQoaOiq9028IvV7hRplKE97
 t/aE/JgWmL+9X2Ex2n6WvSUYafoYrgiyiUKZeYbAonGc/V3izzjY+xKYRSsyzmCHiQ3VZ0Oynkt
 aeK64Pf9+9QxsReNn27rRDx4d6QsiI39SqTeGXvDp2/0JXbPo/Z+LxSntTkbdnanQ9hHpzFhtYZ
 shXffaYp1UJJycY3YUMQ5e2nmeNZeuF2F1+8CJ3UXl2tsAkjTT0qcV4fMPN3kQiCuRGYXbafVK2
 W5S1Ml4nvzmAKoN5FFZnIAgA7ZL4DZk1ThA1k1mdWAyhE5k1y/kUcXA8rgINrHA3iuOxBEcZekl
 FobPtOPF+j56D90uCKxdCjTpCuzjX68V1l4QRP8TGscAYNrI=
X-Google-Smtp-Source: AGHT+IE8HEjtHYdD5zzx5zCbwgQWoRvc4bsc/AFmAoJ2cu1RndDZezx1k21D4ICaufYK53DgR5500Q==
X-Received: by 2002:a05:600c:8b16:b0:442:e9ec:4654 with SMTP id
 5b1f17b1804b1-453526df09amr56293205e9.8.1750234325144; 
 Wed, 18 Jun 2025 01:12:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a29:d3c:4dad:4edf?
 ([2a01:e0a:3d9:2080:7a29:d3c:4dad:4edf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532dea07e3sm197895325e9.9.2025.06.18.01.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 01:12:04 -0700 (PDT)
Message-ID: <c5e8f85d-858e-4d22-8b6a-83f14c990328@linaro.org>
Date: Wed, 18 Jun 2025 10:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [RFH] Future direction of the U-Boot project
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250602222738.GC100073@bill-the-cat>
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
In-Reply-To: <20250602222738.GC100073@bill-the-cat>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

On 03/06/2025 00:27, Tom Rini wrote:
> Hey all,
> 
> Something I've talked about in release emails earlier this year, and
> promised a follow-up on but hadn't gotten to yet, was how to manage the
> project moving forward. The email I made last week about Simon also I
> believe highlighted some of the problems that we as a project and
> community face.
> 
> As a starting point, I want to thank all of the people (and companies)
> that have been working on the project and doing the less visible but
> important and expensive things that need doing. DENX has been running
> much of the project infrastructure since inception. Currently, all of
> the fast AMD64 build machines are from Simon. Linaro has been providing
> two of the 3 fast ARM64 build machines (the other is from Simon). Our
> patchwork project is on OzLabs group. A number of years ago, Simon
> picked up the u-boot.org domain. There's likely other things I'm
> unintentionally forgetting here.
> 
> So, what are the problems I see and would like to get some help and
> guidance in working on resolving? Well, in a lot of ways it all stems
> from one root cause. The project was founded on the "BDFL" model,
> which was quite common at the time, and a relatively reasonable option
> too.
> 
> But now? It makes getting resources harder. There are a number of people
> working in the background now trying to get things donated to the
> project (thank you, again) but I also know historically it's been a
> challenge not having some distinct entity for U-Boot. Individual
> contributions are best done as "I have a server" or similar. Conferences
> are a strictly individual thing.
> 
> Then there's the day to day parts of the project. I feel like I
> shouldn't complain about taking vacations where I just handle pull
> requests and not patchwork stuff too, or only doing a few things on the
> weekend. But it also means there's no real way to handle contentious
> issues other than what I say goes. Which isn't ideal.
> 
> What to do about it? Well, I've talked with the Software Freedom
> Conservancy (https://sfconservancy.org/) (SFC) earlier in the year (and
> before that, years ago at conferences). There are number of open source
> and community focused projects that they provide a legal entity for and
> help with administrative things. I've personally been a fan of what they
> do, and donated yearly for a long time. I think they would be a good fit
> for the project because they do this kind of work for a number of other
> big and important and community centric projects. I would encourage
> anyone interested to look at their website and look around.
> 
> But that is something like step two or step three. The first step is
> that I'm hoping some members of the community would like to formalize
> helping with the project. SFC can help us with creating some
> organizational structure for the project itself, but we need a few
> people to do it. And before we even get that far, help with the mailing
> list moderation queue and triaging patchwork assignments would be great.

You can count on me for any help, for now for moderation and triage and
I'll be happy to help for the project structure.

Neil

> 
> Thanks for reading this, I look forward to finding a sustainable path
> forward for the project and the community at large.
> 

