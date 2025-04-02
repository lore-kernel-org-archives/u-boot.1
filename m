Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0FBC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 07:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5FA980FDA;
	Wed,  2 Apr 2025 09:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q9OkrWtm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6937C81CF0; Wed,  2 Apr 2025 09:48:12 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC86480584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 09:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so4836831f8f.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 00:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743580089; x=1744184889; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4gBy4GS4FhijBB8XV8X+KA7wZaA9huVUBMw75Qe7VtU=;
 b=Q9OkrWtm8hJ4VmmkJKaPQzBI6pdqcf7Hnpu2EnFKzuw9+rfhITVPBoJgLIIQQfze0I
 uYXoLbWWg6vIdnHr9uUvsXGOeU9Q6sWzjxZFYZ0kYBcnx6qY7A1CtokmMD3DiB0Mhu41
 gOBJ4vkotHWCWpWk5ZHcMB90uKDo5cyHs7rJj8XDfSA2b4jfryZ46hHYV2lNiRjJ6FSK
 wppntBEyQhNdWGWe2fzFbJQbhqCbIeWPEzbFbEAvxDtKbi/8c8y4GgREzk2IwcPnN0HQ
 SoX5kH7FUB5uxU8wRVFlR13DyweYbtXsq6BREHlAyadKpdcllyzRTSl7xb0Owp666pRr
 inPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743580089; x=1744184889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4gBy4GS4FhijBB8XV8X+KA7wZaA9huVUBMw75Qe7VtU=;
 b=uFaBknqPjeAEpK8nLyKRWpJPZGNbVd/MwhNYtH+8m8C9Jp9rMVvI8156AUrvqosg27
 CVaUWfkCwmdjze45fF4y5Go0xM6O4fuudgMyn5zkvjMF/7Q5Whscka75oQkwVZI+fvT7
 nIN/eFcniBgxT5gldxK2CZDYNw5mcYO1Y20qwb/6K4DkdkLyDJuHOAQAUkDA/pejLs3y
 iA3Hz5Ytg+Te56tqvo/soeJwtWSo6OSblYkWXQDTYOb0++q6TbEqLiNFXBNVGkLWp5JS
 fNu4KwTJi6E/FBpmSfvH1knGeoWGnXQ+wgJ5sXk+ZA4keLmKO2tz/s5iN8ta65KiI9wX
 HesA==
X-Gm-Message-State: AOJu0YwLKtJM9ge1RplCd2aDCmNeg23RrdrJEKp49TZpThOrs2RKYzTN
 bRYJnBtj3s6XVRWH7WL3GwkgzgKVKEYIXQHZbFtprlacaxaTHl2vUtTbWNFjYBc=
X-Gm-Gg: ASbGnctp2mf88UL3oWfY/r2MTFiWqiIlBp+jJ7Gnq8beyHRUV9aiT2HCl3zJ+JSs7uM
 /n5LjSxfzVJujVaTtrpd1tZJoIG9tpHUiccbx2XoxgLv8tIQg1EVl65nWVerlrNZMpZ0gb98n7c
 ORjuomCEj8UInmzB+rx2N4uK8VXXQvlDbr58zw0hxiEVjhZO/fl+oD/qpw/BP+LKb7EZNNaflKj
 eYDPO0AmQNob8MJMX51TSVgffuIqIw083NH+yKzDBcYAKlCL51/lHo5JleQ66t7GHP2e9bxppZE
 yv2Anox+HxNgCKef3F1TKKPQGW8D1M0kbp/ukPHu7iT3KUK1K3xFLBYWXP3w4f1rnxBN3U19tOE
 njw9YjUxJCMeXz3AytDSgmmTwsAypeymR
X-Google-Smtp-Source: AGHT+IGKZNmL1qScUEx9v5pSIKL0uw5xI8wjBFgAJAU79vxuPHDmGx0WkkJLlh0zJFo+KjkWJQoFng==
X-Received: by 2002:a05:6000:40d9:b0:399:6d53:68d9 with SMTP id
 ffacd0b85a97d-39c297e42a2mr1198214f8f.38.1743580089140; 
 Wed, 02 Apr 2025 00:48:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:98c8:cef1:9997:9a7?
 ([2a01:e0a:3cb:7bb0:98c8:cef1:9997:9a7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66285bsm15981329f8f.21.2025.04.02.00.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 00:48:08 -0700 (PDT)
Message-ID: <9869b70e-0fec-4682-8ba0-c679df9c4603@linaro.org>
Date: Wed, 2 Apr 2025 09:48:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] lwIP sandbox tests
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
 <84e047e7-f90e-4435-8f3d-132d970749ac@linaro.org>
 <CAFLszThN_0aRhtTRmEGmjyiekz1XtzZdH1qq0oLSyYcO5yKobA@mail.gmail.com>
 <CAC_iWjLHPLeX2DhnVqS3QtjhyPVd-Hkuqr0vF_dCXmBQApwvng@mail.gmail.com>
 <CAFLszThH3a7pLJG+zppu2qr5RwXAOk9Sj+S+RAT0B758hzOsyQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszThH3a7pLJG+zppu2qr5RwXAOk9Sj+S+RAT0B758hzOsyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Simon,

On 4/1/25 19:55, Simon Glass wrote:
> Hi Ilias,
> 
> On Wed, 2 Apr 2025 at 05:33, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Simon
>>
>> On Tue, 1 Apr 2025 at 18:42, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> Hi Jerome,
>>>
>>> On Tue, 1 Apr 2025 at 03:14, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> Any feedback on this series?
>>>>
>>>> https://patchwork.ozlabs.org/project/uboot/list/?series=448553
>>>
>>> No, not from me, but thanks for doing it!
>>
>> Aren't you maintaining the sandbox drivers?
> 
> Yes, I'm listed as maintainer for lots of things. What sort of
> feedback are you looking for?

Well, you were pretty explicit that those tests were important to
you ([1], [2] and especially [3]), so I was expecting some kind of
review/ack on your part. The series is currently assigned to me in
patchwork and I got zero comments, so I'm not sure what to do with
it. Unless someone objects I will probably add it to my next PR to
Tom for -next.

[1] https://lists.denx.de/pipermail/u-boot/2025-February/581988.html
[2] https://lists.denx.de/pipermail/u-boot/2025-March/582435.html
[3] https://lists.denx.de/pipermail/u-boot/2025-March/583362.html

Thanks,
-- 
Jerome

> 
> Regards.
> 
> Simon
