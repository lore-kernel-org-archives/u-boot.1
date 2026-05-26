Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB57CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0564848BB;
	Tue, 26 May 2026 15:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xa61hNEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4219C848BC; Tue, 26 May 2026 15:35:50 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105BC84873
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49041e84237so34316825e9.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779802545; x=1780407345; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZjTFZjxcnjBc7DXwXJLkf/GYAVGaSlGpXl696tj5+o=;
 b=xa61hNErDcEU9UU+R+Q3ZSHM8cLJM7MahJNyHzwJAMsukOXfILcRcK6QqkUjufJD5v
 /+pZbYVqAniTKrGg7xoyw0+Fe+XIEWIaEvk1dzX1AC9rywL5FrMzhxq71KUNBWjk/u72
 arcg871TedUu3pkCvT/SvBjmPz0HULJ/kZD4msCSf3dZguic5ag690kI9NdkH+tCRmLt
 pnbvbb0LMy+vG8QFmhcSIm7rxfNaWkZySIlk7y8njxOto3hRJn/uIQmdY4V5wdOvdBAD
 kOwMWyeHtRkI3zye4KxhzZPwyA3IstSVu87Ju/1P2DXR8b/c+9rN2x0jdG18pVO3lzDP
 IhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779802545; x=1780407345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZjTFZjxcnjBc7DXwXJLkf/GYAVGaSlGpXl696tj5+o=;
 b=RiNeAT2ugjVywwUoSl97Zjakxq6Yi7LPB+tVwvpVB6jKlE+cCKObpUID0c9oFdkuQW
 0L/VwJSQexsUvQOj7w61NOkBW0LNpyNaV/pJ/ysL22pOO0dJFqwUG2LWX4st/zT5e5DD
 DTsSWOOhFDJl+1NfRsz4DMTEM9b/urFkQ31yIaUm3ye0bXxQHjLluK0r6NZ+5BTMdaik
 0SU4YSU6wpBoJc3JJvKwt8wVtc92mvSKZvOrQ43Ef2pOUvtyDashOmK8sAUulKdXvzTt
 MPSKabC6hJZ5gkfG6gyOye9FJpqkIWFDmqkFAUXUdQiXdwgzng/pU7T9w82PR42IZ+lG
 qdPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xjtUA6ZSaXgU4oLACI3Mz+zQarMphIO904Ztjv6GmUckEUpx8Qx2C5G40RSNddlqCQRuEX1c=@lists.denx.de
X-Gm-Message-State: AOJu0YwkePe+F5LqzSLoVYvQ0mknJtEchbMva6nqhPFdZe6yj1B8qlXL
 dy+eg1X6wRdeGaKYabev0EDZPIUnUg6Zs6BdBTV1PA8UV4qHRDGyPsGGSkls8B574og=
X-Gm-Gg: Acq92OGy88DcLbV1YWqsMMmJkwLrLkeHf0JbDuzxjyXA8BfW8QxyFLCCKlIrlTHajlq
 D6uTFvmSwyJtMyyQA78Nl/ijZXrqOxJwLQzvIY5pkAwYfx4mT5rq9n6PJfASwgduijQgaUbaiKY
 Dc4urjxp31aj/eXiJ+Rpg5jGF/KURT3i3Ao76gLfztdau5ic3hP1waB0JiVik1jC6coG8hSsvhC
 PF2a5zN0n6wp4KWFmTOMTPRuyrXWGjgjxHPPHIl30LVWdTps/iiVHUGAW4bQNm+diNYP8l0g3Ls
 DtDxeRG1WSce0Lsbmv2Ks/pQ8+x3VqJiJylTf3gXKQGxahcsmLKEjdggJHJYKNKZdYtcYs6yKCU
 4VIkab27NXafrmNzijeLxQcBJOlcziWk3pH9DJn+9eu5+GZ0JH/+QzSIPFNII6eNy67KqbF12pM
 9Cm4uR6VjOIOSH4a3gcyHpb3SjVNrPU51isj7BbExnqEWLSEMP93y81/vcSiNtUKs=
X-Received: by 2002:a05:600c:1d19:b0:48a:761:5816 with SMTP id
 5b1f17b1804b1-4904245fe58mr266187675e9.8.1779802545389; 
 Tue, 26 May 2026 06:35:45 -0700 (PDT)
Received: from [192.168.1.36] (p549d4239.dip0.t-ipconnect.de. [84.157.66.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454c600esm321581615e9.3.2026.05.26.06.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 06:35:44 -0700 (PDT)
Message-ID: <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
Date: Tue, 26 May 2026 15:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <20260522-capsule-v1-1-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWj+VQyO1Zy+mPqcQJY91aEFsrwXFT4dbObejar0fDpCaSg@mail.gmail.com>
 <a4b3eeed-0789-4bec-b29f-d13e3e3b3016@oss.qualcomm.com>
 <CAC_iWjLQxOVb7H-Mib7NAYLmzumhL5uBi8dZ_ufCksJMrcQ8OQ@mail.gmail.com>
 <89329f38-d2c5-4014-a1e1-44ccfd09b3bd@linaro.org>
 <242ab545-c274-4b65-afa9-2c3ab056a918@oss.qualcomm.com>
 <CAC_iWjK_U_TtNJsXjgVggXa28iHb9212tEQEdQn8wK2XqXmJiQ@mail.gmail.com>
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
 <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
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

Hi Balaji,

On 25/05/2026 13:24, Balaji Selvanathan wrote:
> Hi Ilias,
> 
> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>> [...]
>>
>>>>> To support multi-image RAW capsules, we would need to:
>>>>>
>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>> There's an equivalent tool in EDKII that can produce a capsule with
>>>> multiple payloads. There were also patches posted for mkeficapsule,
>>>> but need some minor tweaks to merge them
>>> Can you please point me those patches? I did a search myself, but
>>> couldnt find those patches.
>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>> sughosh.ganu@linaro.org/
> 
> This patch you mentioned here can create capsule with only one payload;
> means for multiple binaries we need to create multiple capsules. I have
> also asked the person who made this series to respin, but havent heard
> back from him.

From a quick look it seems like it would be fairly straightforward to
extend mkeficapsule to support multiple images, the capsule header has
an item_offset_list[] array with offsets to each image, today we just
write 1 but it shouldn't be too much of a challenge to put a loop in
here and extend the argument parsing.

Given that we a) already use raw capsules and b) they are part of the
EFI spec, I'm gonna try and save us all some time and just put my foot
down here. A single raw EFI capsule file can already support updating
multiple images, U-Boot already has all of the machinery for it with the
exception of mkeficapsule but I expect that's something you can tackle.

The upside to this is that you will be able to build capsule files for
updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!

Kind regards,
-- 
// Casey (she/her)

