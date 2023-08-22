Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C72EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 08:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C858648A;
	Tue, 22 Aug 2023 10:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PFEEc9uD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016DB8648B; Tue, 22 Aug 2023 10:24:29 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5388B86489
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 10:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso1713514f8f.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692692666; x=1693297466;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=xky6lykeXWJ7KdcEhtptv9VMBp2Elqi4FU3Ze9PGhHA=;
 b=PFEEc9uD+KzxWd4Nu/dQkGAgg9hGQwhyKfegCwVObgPSwFFkTWAOBHeoy/4qLpgBdk
 AG+UdoDU/+6k4QZbofEz+Xpj4y52hgcMz6vNHKBbmAetUwpc4kZyR/fwxxJ5w/pi6ixc
 y9Xq+s9H9/1CajOCvkntpexze8mxBtmLQC0qRAzO/dbOXJ9Caji1o9V//nYNkym13exy
 4F6r62hgpNUR8TWcl65jvLn4lzf99vTy5Qkb6oWzEglYzMupXUnd78G+RG1ypYoTW1ZW
 R3SO1DbPpAOckBphkh+4sYk4Q7WYD6lqi3NReQbb6gLDIl+uzdO1eimRPbCWH0cupYdM
 0mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692692666; x=1693297466;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xky6lykeXWJ7KdcEhtptv9VMBp2Elqi4FU3Ze9PGhHA=;
 b=a9ZglHLVxn34Za1ldUix5A5+qqcX3hecBEsbrwwRdHFJknhY4bqZX+Wu1m3OWyvsn0
 nCRdtPirjp+wryg+WASoAoSyGQjRJfmzpLqe+qaGDxsaI8chb9bH4JUHgwvaFrMVQE8H
 8O0nV0Lmr6rRmoPtYG8+K8oPM/y9mga/x/9CH9d/VLRsfyarverNTjZ7sMVChsYMqA/2
 xxYVxK0X55DZ7CHTTrTavxI7eX2Uks2Ibe/I0W8S6mLhxhg1ofQCitXNNtLt0KNd5EW2
 OeqexnkU2tmG9DWLuhMC2NHNmXXQOc4CPxLzD0v9yH4HtIqEKSaWGKpy6NCzRYaG3L4P
 535g==
X-Gm-Message-State: AOJu0YyO42ceiR2p9y2n/XL25FuNx4ym2XHNQjV9rSnZS/Ts342g/MsA
 w15BPcaXiIT+wAzxETBous2ltA==
X-Google-Smtp-Source: AGHT+IEJfxGkPCKuJEF13x/20GILsqwJsrOIfIY1E6bnwUXu/t7+NulrCEt43bP0sZz6EY8sgjItjw==
X-Received: by 2002:adf:e704:0:b0:314:2f3e:dca5 with SMTP id
 c4-20020adfe704000000b003142f3edca5mr8385438wrm.28.1692692665770; 
 Tue, 22 Aug 2023 01:24:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:8390:46ac:a6ce:2040?
 ([2a01:e0a:cad:2140:8390:46ac:a6ce:2040])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a5d4b8e000000b0031434c08bb7sm15030609wrt.105.2023.08.22.01.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 01:24:24 -0700 (PDT)
Message-ID: <7a9f5cf0-d7b2-4477-8a56-a3aa7f764e2a@linaro.org>
Date: Tue, 22 Aug 2023 10:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/2] drivers: firmware: introduce Meson Secure Monitor
 driver
Content-Language: en-US, fr
To: Simon Glass <sjg@google.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexey Romanov <AVRomanov@sberdevices.ru>,
 "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
References: <20230706112020.24528-1-avromanov@sberdevices.ru>
 <20230706112020.24528-2-avromanov@sberdevices.ru>
 <CAPnjgZ1AqUYxAU0BNhxZLXc+y_h5XKbuoLBDekbkqzaJeon-1Q@mail.gmail.com>
 <20230707084313.vecmsr5z3aj4gqxs@cab-wsm-0029881>
 <CAPnjgZ3Wfnc_rMJBVZTv_eikUu7vpPWsL1MQ_SruXySV9EZi3A@mail.gmail.com>
 <20230710083443.fuw74gbvwoha75ab@cab-wsm-0029881>
 <CAPnjgZ1aZsFBaX2eBh35CXVExaE90YJHQ98S+2XOWJrJ9pz37w@mail.gmail.com>
 <20230711102459.phpyem2ehlya7osz@cab-wsm-0029881.sigma.sbrf.ru>
 <CAPnjgZ2t2xf05PSgCbQr7MUvJrpQPcRs_Zoux804h4UmTrZRKw@mail.gmail.com>
 <ZLDdaIyXjp9yN5aW@laputa>
 <CAPnjgZ3oQ1qZtWFpezNfV-dZhbCrnqbi1+B=JKb1sfJP6xk-cA@mail.gmail.com>
 <6303961e-3edc-4356-905b-89820a52b227@linaro.org>
 <CAPnjgZ2GA7ktNi9HVJ1Mw=4nuqcQJALVBqHQr1_JtVmkzEVgdw@mail.gmail.com>
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
Organization: Linaro Developer Services
In-Reply-To: <CAPnjgZ2GA7ktNi9HVJ1Mw=4nuqcQJALVBqHQr1_JtVmkzEVgdw@mail.gmail.com>
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

On 21/08/2023 21:11, Simon Glass wrote:
> Hi Neil,
> 
> On Mon, 21 Aug 2023 at 03:16, neil.armstrong@linaro.org
> <neil.armstrong@linaro.org> wrote:
>>
>> Hi,
>>
>> On 16/07/2023 01:40, Simon Glass wrote:
>>> Hi,
>>>
>>> On Thu, 13 Jul 2023 at 23:30, AKASHI Takahiro
>>> <takahiro.akashi@linaro.org> wrote:
>>>>
>>>> On Tue, Jul 11, 2023 at 01:13:29PM -0600, Simon Glass wrote:
>>>>> +AKASHI Takahiro
>>>>
>>>> Me?
>>>
>>> Yes, I'm asking for your help to try to clean this stuff up.
>>
>> The thread is long and hard to answer directly, but as AKASHI
>> said there's no point to add a SMC class since it's only the message
>> passing instruction, and there's no point using remoteproc since the
>> firmware runs on a separate secure state of the same CPU.
>>
>> And I don't see how we can actually define a finite set of ops because
>> none of the secure firmware interfaces has even similar functions.
>>
>> So a new UCLASS for each firmware interface should be added, not sure
>> this is scalable or required since those firmwares are mainly SoC or
>> vendor specific, except the PSCI or other ARM specific interfaces of course.
>>
>> So I think UCLASS_FIRMWARE is good enough since it avoids using UCLASS_MISC,
>> but it should be probably documented somewhere that the ops are implementation
>> defined.
> 
> Yes it needs docs...but what exactly is the 'firmware' uclass? I
> assumed it was for loading firmware into a device, but it seems that
> it is something else?

Nop, it's based on the same "firmware" naming as Linux, which is an interface
with a system control firmware like PSCI, SCPI... not to interact with loadable
co-processors.

Systems do have multiple interfaces implemented like PSCI, SCPI, OPTEE and other
vendor specific ones like Alexey is changing, all via the same instruction call.

> 
> Perhaps we should have a UCLASS_SVC (supervisor call) or something
> like that, rather than continuing with firmware?

I have no opinion on that, I don't think the call type is significant here.

Neil

> 
> [..]
> 
> Regards,
> Simon

