Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92805C44520
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 10:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD0380117;
	Sat, 18 Jul 2026 12:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YGim/m1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B8F80517; Sat, 18 Jul 2026 12:49:29 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6314E800AE
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 12:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4953ddae026so26415785e9.3
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784371766; x=1784976566; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MOydETU1Vv2yZ4wAjvzP6Yk5d/H+WzVthki7JeuJhSQ=;
 b=YGim/m1CMcSvZEQknET9++QXTgWiBPwT3Awt340aipsbKYMFcfch6fUbr9oUSIlfUP
 6YJW9qTnyc4/DcWx7FSCRRE7Av6GrpvUaKaDu8chUGjkg8khoPfNhqonC017763ztUw5
 ZMg+9RpVP7h/62yJ3LaYqt1THy2dL5Zva9pnPVD+dUgwIZFQwHaX3whQnsTeNbvAO/vf
 l26PyuNQUwgUOuRscO6R6Xy/8VP5hinhi6MnMIAbA8zfa5XEiRYvLwZ5SvE4MU35ALUu
 uK4v0BqU2JdFE11+o8WdhwZPw9oA/2UOPll0qNkjFaNpNM6LA/csz+wpbcuUWwAC4O/7
 LqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784371766; x=1784976566;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOydETU1Vv2yZ4wAjvzP6Yk5d/H+WzVthki7JeuJhSQ=;
 b=qFoZ8Jv2AWZgVsJJmtOjVQTi/bR3f0EYwESPd6tViMUFpCdcLi624NiQ46bd7MjrXq
 OnxgaQtlmfehsC/1PUrOdeKLG2su9GQlRxwQqo4Zo1T1xbqYJRnIeuVfRiVvdXIOikJu
 rz0/4XG2LTFNhJ0Vf5rv8rQL9krcvTEf1ZDL8jyDKNIDEUFDeDg5oWEPUvxubdij6Wsr
 wpk8syGIaE/L0jIRb4sqVQ+soGD/ZDOsck71OqKK55vDf5Nxmu8l2+b0obmUaJE3uu1/
 ZVbUWfS0yGTEw3yQ+CZCl5b1iaMD1J/hWodyzan4Q1S/d2t7+fQJ/mBA8DGdq7Wh2oV+
 7c+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdEPJAMtMXgCU5/sAdSt6uFSiAma0Kimesyawcpca5Iq1erH4/5VUCnJyaI1eXjNl+5xArlqs=@lists.denx.de
X-Gm-Message-State: AOJu0YyVATB3a+81NCYHN35NMOEXcV+1Z6HSTMgYS9+YeyGTZF0/slOk
 Nu49NIERiBq1n84UdUr/Y8UloXQkw2y2QvB6mvaE2x2GUIeG/P3pjsK135NUiidPPNI=
X-Gm-Gg: AfdE7cmH4a7UNcfbLc3rJN1PwCBO/MrxoYGLIgkj33eueyy3u7GUDmZmLzmeiuE8nCZ
 FG6+iD7aw7b4OtJTXyx/aRogloo+HD2FKnjS4Cm/RiupL+qlpQfpub2xRhXAlYel3/RQnET9zK2
 Ysd4EZ+8hqBLQWIR1KhB6OlCAR+ZKY4BG3XoO9FuVqEtDSJ16qcEWdXKsGx69015xGDeX/TmGsP
 pIkJRQHEkH8o1bJ5czW2JgHUH/4pfgSAOJ7vtaJJE9m7MjDUUJR+iIvs52CbGuiyvgzUTpY7Acb
 8HfY4Pi3qrrSHstbi9XzWfQf4iDz4YLV7P3RMJTGYj6sw4hF+3lW4xdxH/Qx9o6x/y6hvYvP4ll
 fg+7vcPsNvpuydQtsJzfJivGz8klRtfFCZfMYG+y6kRB1eNuJ5oxouo0fTKCaA+VIqLb5Xm28dc
 BY1hXaSaCZMtwmzaAIWtiwCV7v7cRYczMSUfeTHpbE4mAiIUhPUp5RYUiDh4M=
X-Received: by 2002:a05:600c:138a:b0:493:f318:3bc6 with SMTP id
 5b1f17b1804b1-4954a3dc7b1mr68952525e9.13.1784371765791; 
 Sat, 18 Jul 2026 03:49:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:1101:f76f:437b:dcb2:4cac?
 ([2a0a:ef40:1d11:1101:f76f:437b:dcb2:4cac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a2504sm126986775e9.2.2026.07.18.03.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 03:49:24 -0700 (PDT)
Message-ID: <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
Date: Sat, 18 Jul 2026 11:49:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
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
 <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
 <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 7/17/26 18:16, Balaji Selvanathan wrote:
> Hi Casey, Ilias, Simon,
> 
> On 5/26/2026 7:05 PM, Casey Connolly wrote:
>> Hi Balaji,
>>
>> On 25/05/2026 13:24, Balaji Selvanathan wrote:
>>> Hi Ilias,
>>>
>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>>>> [...]
>>>>
>>>>>>> To support multi-image RAW capsules, we would need to:
>>>>>>>
>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>>>> There's an equivalent tool in EDKII that can produce a capsule with
>>>>>> multiple payloads. There were also patches posted for mkeficapsule,
>>>>>> but need some minor tweaks to merge them
>>>>> Can you please point me those patches? I did a search myself, but
>>>>> couldnt find those patches.
>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>> sughosh.ganu@linaro.org/
>>> This patch you mentioned here can create capsule with only one payload;
>>> means for multiple binaries we need to create multiple capsules. I have
>>> also asked the person who made this series to respin, but havent heard
>>> back from him.
>>  From a quick look it seems like it would be fairly straightforward to
>> extend mkeficapsule to support multiple images, the capsule header has
>> an item_offset_list[] array with offsets to each image, today we just
>> write 1 but it shouldn't be too much of a challenge to put a loop in
>> here and extend the argument parsing.
>>
>> Given that we a) already use raw capsules and b) they are part of the
>> EFI spec, I'm gonna try and save us all some time and just put my foot
>> down here. A single raw EFI capsule file can already support updating
>> multiple images, U-Boot already has all of the machinery for it with the
>> exception of mkeficapsule but I expect that's something you can tackle.
>>
>> The upside to this is that you will be able to build capsule files for
>> updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
> Thanks for the detailed feedback.
> 
> We agree — we'll drop the FIT capsule approach and move forward with RAW 
> capsules.
> 
> Here's the plan:
> 
> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule series [1] 
> to support generating multi-image capsules from a config
>    file, so we can build a single capsule covering all the partitions we 
> need to update.
> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only 
> supports a single firmware image (U-Boot itself) via a
>    single-entry fw_images[] array. We'll move to a SoC-specific, multi- 
> entry fw_images[] array (defined per board, e.g.
>    board/qualcomm/<board>/fw_images.c), so a single capsule update flow 
> can cover multiple firmware components — each with its own
>    ESRT entry and FMP image_index — instead of just U-Boot.

No need for this, just build fw_images[] on the fly derived from the 
partition table on the board, with an entry for each partition that can 
be updated. You just need to add a map from partition label to fw_name 
string, starting with the xbl/uefi/boot partitions we already handle.

The entire point of having logic here was to avoid per-board stuff, if 
you're thinking "ah I'll do this per-board" you should immediately 
wonder "but can we do it dynamically instead?".

Thanks,
Casey
> 
> Will send an updated series once the mkeficapsule and qcom capsule 
> update changes are in shape.
> 
> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1- 
> sughosh.ganu@linaro.org/
> 
> Regards,
> Balaji
>>
>> Kind regards,

