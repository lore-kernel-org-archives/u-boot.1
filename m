Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C319CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 15:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5606F83FEE;
	Sun, 14 Jun 2026 17:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AVQ0PF9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B59384105; Sun, 14 Jun 2026 17:29:39 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 520EA83EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 17:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4905529b933so25415085e9.0
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781450976; x=1782055776; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=35er+6TefObePxthTkqzz9nImolq4ALgJWydU1To28Q=;
 b=AVQ0PF9yaGBaRDnOAzs/EZQxe4q7z85kF94s2upE3IBxL/ptgQ04WqT6Lqqd8JURdB
 rBaSYFObWFPq4888dbuGObEI5+bHk/6bWiPA/xbaPiic9BU2YYi8eh14J7aDpvVH9gmy
 xhZMC28+qsp/qdUzA8H6JSTQnKQ3/MEkFL9QEe0+6QNh9KWRlCHP9BIcv1mEstZ8NXyC
 OTCxNYjMhoi8jLmxW7AqnDyaJdGlAqDRiQuBUbRsKQGeTF0FviTwrQ8bqmZQV4vK5IDu
 kB+9WCEIFjjm5ir9VoS5TsxPsguZ/NCG5/BeapNvVYCWKjX5yeUkCG7XjN1LzCXFowNw
 CqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781450976; x=1782055776;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35er+6TefObePxthTkqzz9nImolq4ALgJWydU1To28Q=;
 b=WC69/y6HZ5aW6tR1mrkDZdXQz+p+Bkz8LrI3BMSY0c/VxqNaW8VdxBtZZNsblFddxk
 q4/uy/UAeDywAkOtrOAHzgIN8TmGqR3JLxkpDzVoXFJML65Us0JT9e3CsFQr/amQF8Za
 C+PyjsJmfJnNDKl67dva9IdvBdf1pk7ndHwvWWXf9KS4BPQyHAx4mnUXB2LmTFHwatap
 CWONQ8fGkra/t8jVDEr5VPUgdfmTSubrwy95a4sOoYDZkO6ZCUELrD/v9YxfFu08Lzty
 GVpoDZJac710HNovmEbduVsd3FgfDBd0w8/hnqHy0vo2Icrp/LpsGQ6inz2Vufr77mqU
 woGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5b7fPlS0YDsi3gwdZ70Z7hGx36IrOTgJZgNnYCYZOF2IRAhAWi/iBNgkXtkk1BogMeO72prI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy38dlLt5NfQkkwjycFjPWo1nlUBhE+ks97YDcBJNDifpkH9ctM
 4/ENy4bdCrUGbAdhsBTxL9vJd8V34/raoxX5W2Pc/Yp5WXCrKMzB1yn+bFbS3wdZ69k=
X-Gm-Gg: Acq92OGn0zEfQMFdcElqZtycpDhWtt0FmugIJitxreXlhgDn5+Bqd4Z3Phb5IUHxNlB
 F9zopBorGdIczxURqIQlV0au95OSL8U2TPWFaUjQ6dQAx0dy9/rDTCmNMoJ6/2qF3j3KxzfIlXT
 TvVA7nh0xMgj1k4p+/Gov2580YJL7A/lO+Xq5eBxs0C2akJX4qsGf1VKA0p+b/JRN4JIJ5xCEtb
 xjbdF61N4v0wtZJEv8J8h9eCcobMvWk04E3ZS7dYr19s301zoKi6ye4d+UzsXN6sLSo/p1zkIhC
 narRWJSo1xa7ZFUlTHB7fpawTAvIgdKzr7dWovwWdIbpJ6o3MyAcHiIPL+VmYyrNWEkmwEHMpgp
 05fgqMUyjwqPGsyaVlm7J3P2hT9u3leRTV/kJGaBio1UWsnZvPiy/rR7IYHCcEQ1ZFNcJS+zvos
 eERkBq+xh89r7FfmA47NyOHrAHyzi78FPMQvI9XzchBLpEN3RYAD1ITrPcrfbpD2z0
X-Received: by 2002:a05:600c:820c:b0:490:958c:46dc with SMTP id
 5b1f17b1804b1-490ec4e75d9mr133811375e9.17.1781450975722; 
 Sun, 14 Jun 2026 08:29:35 -0700 (PDT)
Received: from [192.168.1.239] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f264333sm25904710f8f.4.2026.06.14.08.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2026 08:29:34 -0700 (PDT)
Message-ID: <c6f11487-5c2c-4fd1-a7d1-13bb0046c434@linaro.org>
Date: Sun, 14 Jun 2026 17:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
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
 <CAFLszTjEbLTNdVe7bKQbAR1uxJzKjGPjo7obSQRJSHcWQkZVxA@mail.gmail.com>
 <CAC_iWjJ8v6OHJ9CODLjJhwgO=g1eN7La5trXmypHA8jUHaMG4Q@mail.gmail.com>
 <CAFLszTg2Ettpbi6RZmPnm2O_mTUsaxT+pv_AevpS834XRovRAQ@mail.gmail.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAFLszTg2Ettpbi6RZmPnm2O_mTUsaxT+pv_AevpS834XRovRAQ@mail.gmail.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 6/14/26 14:13, Simon Glass wrote:
> Hi Ilias,
> 
> On Mon, 25 May 2026 at 15:07, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On Mon, 25 May 2026 at 21:10, Simon Glass <sjg@chromium.org> wrote:
>>>
>>> Hi all,
>>>
>>> On Mon, 25 May 2026 at 05:24, Balaji Selvanathan
>>> <balaji.selvanathan@oss.qualcomm.com> wrote:
>>>>
>>>> Hi Ilias,
>>>>
>>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>>>>> [...]
>>>>>
>>>>>>>> To support multi-image RAW capsules, we would need to:
>>>>>>>>
>>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>>>>> There's an equivalent tool in EDKII that can produce a capsule with
>>>>>>> multiple payloads. There were also patches posted for mkeficapsule,
>>>>>>> but need some minor tweaks to merge them
>>>>>> Can you please point me those patches? I did a search myself, but
>>>>>> couldnt find those patches.
>>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-sughosh.ganu@linaro.org/
>>>>
>>>> This patch you mentioned here can create capsule with only one payload;
>>>> means for multiple binaries we need to create multiple capsules. I have
>>>> also asked the person who made this series to respin, but havent heard
>>>> back from him.
>>>
>>> Before this respins as multi-payload RAW, I'd like to push back on the
>>> suggestion that FIT is the wrong answer here.
>>>
>>> CONFIG_EFI_CAPSULE_FIRMWARE_FIT is already a first-class handler in
>>> efi_firmware.c next to the RAW one.
>>
>> We accepted it back then because we lacked capsule authentication. I
>> really want to remove it now, since I see no point having a capsule
>> within a FIT.
> 
> I may have misunderstood something here. My understanding with this
> series is that there is a FIT containing multiple images which all
> need updating atomically. So there is one ESRT, isn't there? How does
> it result in a capsule being inside a FIT?
> 
>>
>>> So the choice isn't whether to add
>>> a new mechanism, just which of the two existing handlers Qualcomm
>>> wires up. Both produce an FMP and an ESRT entry; the OS-visible UEFI
>>> behaviour is identical. The difference is entirely in what sits inside
>>> the capsule payload.
>>
>> Not really. FIT capsule will expose a single FMP entry and no
>> information of the firmware components in the esrt, unless I remember
>> the code wrong.
> 
> Well, FIT is designed to hold components so it is provided there, in a
> manner native to U-Boot.

Regardless of the merits of FIT, the EFI capsule spec explicitly 
supports having multiple images in a single capsule and updating all of 
them at once. U-Boot also already has the wiring for this. FIT is 
totally unnecessary here particularly since we don't live in the world 
where we use FIT for everything, so we don't gain any common tooling or 
abstraction by using it for this one case. As Ilias clearly pointed out 
we /lose/ visibility as EFI tooling just sees a FIT image as a binary blob.

If you wish to keep discussing in this thread please drop me from CC.

