Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5579FC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F17CB8132B;
	Tue, 28 Jul 2026 12:21:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 82Fjd5qYAr9U; Tue, 28 Jul 2026 12:21:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDDC18126E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241301;
	bh=t4jrYy+E9o/6KE9GgUMK1yugUn/iFgxtVLOe7zrQghg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vKGouHn/fc1MBUm/g0zcViam1k7lCuwrINwyrViUCZL0lWzEbrxXoL9HwxtnHmi1r
	 gn67AOa+ENDyFHg0T+H2FmJVRqI4EN0nsTfpP8/QZhtWm2RKazEmkJGXHvC8LmGCpT
	 NFpDGJyDeQrtrgckJH/OWimo7vrSzabGj24g06I27bfjmZQboLR5Cwm8f6tPy18+1Y
	 cA2aZAK+OyUDP68Kx87tWVX7ICX3lznVhBPYl08AWh9UfxfXgyNVOBQjMkkxH7t5QS
	 oi1Q0ONf4y0z/WCkKbKxrPyIYHDIf4oa2H2PT9P3jfdOa09p67L8vf4PR2BZdQyyKb
	 z5C3rC9NJ6t2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDDC18126E;
	Tue, 28 Jul 2026 12:21:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 463C52E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2400E60856
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2TXHpcWXvdTf for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:21:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7AA3760861
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AA3760861
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7AA3760861
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:21:36 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4338494B; Tue, 28 Jul 2026 14:21:33 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88ACE82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 14:21:30 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so374927066b.0
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 05:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241290; x=1785846090;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t4jrYy+E9o/6KE9GgUMK1yugUn/iFgxtVLOe7zrQghg=;
 b=qMIE/GP+UYWAEdW82h2WpBn/HtgbIKRuGvQrYfgEq5m9GU4B8/i3qO6OvFlXWG/Kic
 pa3HW6Nt973FUUd1zPYEU+MAMqU3bQvE8gMsQ/HhKww+X8elZnDVxb5vbmja8kJyRIeS
 JNRR/kYHewVD8pbUvIxoDyz5o86x39bDanN/kC17E1aMV4Y5vGsr/jHJyI0AAqx+hTIa
 jFHglnPQ+EGLJu6gnJDkzNUX2eZ5dRzNGNlcFb7Q7N/PGNT2uFjJ58gHv50KIzYBoGSC
 88izk3mS5cMMpBtTSsccp5L5z3S3YoUx7hQ3QNhdfYuYIm/kMU6Eic8OuXPe+ULxeB09
 QTWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4ZtsrQ1Cotf0QvFB3C+TXuhFkb3fMzXAUAZDRNUJNqkSbecifAkh66Abf9nDMyVMJGMN1M+o=@lists.denx.de
X-Gm-Message-State: AOJu0YwUhOX8HgSu8l/uet6JZxedCu8+rr/3YJzw7azsPXfLWMJToh8Q
 4K5xh1jn+1JMIyy8gb/bR/2CynKqPtq/gZtR/fLFg7KxCgOAJ0/JTdFDX4yJxsLLLSE=
X-Gm-Gg: AR+sD11wm/FG1YxQWfNFXpMfOVH1IA+R5s1oZB9EI2iW5ObBg7Sxc43RpID0JwTE1yw
 bARsotkG1mYYgMOHZXojHNG8l03cVf4Erpa+zAznEGnCcoqFbicw9gIQnbgV1ZTKZJl0ijWa6SO
 OR9fdlDogg+dVSeJHaidkxZN8fCYteXp6Q38fGBVpUY6FJwLWPOdi5t7ZcHxvKMj40Ag5KrYcUy
 OtAjqE/ca186UXWnCxHi2IZIKjBSg/+zOCfD4Wx5k2YPbNcHjBmxi1qfokXypiP7QaSqwrBJdCz
 G+Ltyr1MNNpmtmjxivn+k/tSnJtZkMhL4l6GnVBZNMY69PaGTtdWXs4F1wzwtd5odrDkRaLorxe
 NLoNTiK3QDSolYo9qMacOayqT4NlTMXTzwyzk/fiDFsIbv5xm6bCqMIjGC1h4GJbpjX75HAXbpN
 nKRJ13ARgNAHnqsUrytFV1Xaadkq4EVGSaBu81lBd9hw==
X-Received: by 2002:a17:906:7304:b0:c16:9ca5:e547 with SMTP id
 a640c23a62f3a-c1f727c1a1dmr107765866b.62.1785241289461; 
 Tue, 28 Jul 2026 05:21:29 -0700 (PDT)
Received: from [192.168.1.37] (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb50bbfc0sm3910695a12.2.2026.07.28.05.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 05:21:28 -0700 (PDT)
Message-ID: <49cc74de-5d73-44ad-86e0-6acd0f61ff1e@linaro.org>
Date: Tue, 28 Jul 2026 14:21:27 +0200
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
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
 <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
 <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
 <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
 <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
 <73fa32f5-0d10-4f95-a02f-2cac91d072d6@oss.qualcomm.com>
 <013d5bbc-983e-4386-b236-8c63f4406fc0@linaro.org>
 <aaeb155a-6195-4574-b4b4-fa7d6a88a00f@oss.qualcomm.com>
 <20feda09-ab10-43e4-831b-6a8647f5c62e@linaro.org>
 <37b8a403-b299-4e0d-98fe-b4b3ae660b13@oss.qualcomm.com>
 <CAC_iWjLJRk34i4S04L+3bKMVji-JzmieBKrEmYUZmEuc7Jd-4w@mail.gmail.com>
 <bea27826-0028-4de7-a4c7-94ba3eb2f1b4@oss.qualcomm.com>
 <e1ca0b58-d38f-46dc-a9e4-e0695e69a950@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <e1ca0b58-d38f-46dc-a9e4-e0695e69a950@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241290; x=1785846090; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t4jrYy+E9o/6KE9GgUMK1yugUn/iFgxtVLOe7zrQghg=;
 b=tHTu31sFYC1HOrki4zOAtiSpXeBkG6AJ0Axt5kAUaQCKSmIuGjF91lIjF9B+Uad2UC
 rHalcXbA9As+hU/r2KAhmafxZuymNVeBQnRlW72ajt5DH0JfWTTaiWmhj5WVs03bCj5P
 PC/xeTB+2I+fKHwsWv9wE4Nzrjvuif4ZlngTovJCyHsQaDA3LS203+0uaboL7/UGye/Q
 B9N0/Xrpk3Bdt4fdJaDgUMVaReDg3u9CHDwlWSf4Ldc6+lq10yILO+dYYFJpl4rIBkh4
 zxQWRUa6MGAHapkzGocMySjS6tf8eYj1ErsQV3EXsKG59HWyWofpsYQecv1sycE83SkW
 VFfA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tHTu31sF
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="tHTu31sF"; 
 dkim-atps=neutral
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 28/07/2026 13:44, Balaji Selvanathan wrote:
> Hi Ilias,
> 
> On 7/27/2026 9:57 PM, Balaji Selvanathan wrote:
>> Hi Ilias,
>>
>> On 7/27/2026 6:11 PM, Ilias Apalodimas wrote:
>>> On Mon, 27 Jul 2026 at 13:00, Balaji Selvanathan
>>> <balaji.selvanathan@oss.qualcomm.com> wrote:
>>>> Hi Ilias, Casey,
>>>>
>>>> On 7/24/2026 12:37 AM, Casey Connolly wrote:
>>>>> On 23/07/2026 18:43, Balaji Selvanathan wrote:
>>>>>> Hi Casey,
>>>>>>
>>>>>> On 7/22/2026 8:19 PM, Casey Connolly wrote:
>>>>>>> Hi Balaji,
>>>>>>>
>>>>>>> On 22/07/2026 11:23, Balaji Selvanathan wrote:
>>>>>>>> Hi Casey,
>>>>>>>>
>>>>>>>> On 7/18/2026 4:19 PM, Casey Connolly wrote:
>>>>>>>>> On 7/17/26 18:16, Balaji Selvanathan wrote:
>>>>>>>>>> Hi Casey, Ilias, Simon,
>>>>>>>>>>
>>>>>>>>>> On 5/26/2026 7:05 PM, Casey Connolly wrote:
>>>>>>>>>>> Hi Balaji,
>>>>>>>>>>>
>>>>>>>>>>> On 25/05/2026 13:24, Balaji Selvanathan wrote:
>>>>>>>>>>>> Hi Ilias,
>>>>>>>>>>>>
>>>>>>>>>>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>>>>>>>>>>>>> [...]
>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> To support multi-image RAW capsules, we would need to:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>>>>>>>>>>>>> There's an equivalent tool in EDKII that can produce a
>>>>>>>>>>>>>>> capsule
>>>>>>>>>>>>>>> with
>>>>>>>>>>>>>>> multiple payloads. There were also patches posted for
>>>>>>>>>>>>>>> mkeficapsule,
>>>>>>>>>>>>>>> but need some minor tweaks to merge them
>>>>>>>>>>>>>> Can you please point me those patches? I did a search
>>>>>>>>>>>>>> myself, but
>>>>>>>>>>>>>> couldnt find those patches.
>>>>>>>>>>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>>>>>>>>>> sughosh.ganu@linaro.org/
>>>>>>>>>>>> This patch you mentioned here can create capsule with only one
>>>>>>>>>>>> payload;
>>>>>>>>>>>> means for multiple binaries we need to create multiple
>>>>>>>>>>>> capsules. I
>>>>>>>>>>>> have
>>>>>>>>>>>> also asked the person who made this series to respin, but
>>>>>>>>>>>> havent
>>>>>>>>>>>> heard
>>>>>>>>>>>> back from him.
>>>>>>>>>>>     From a quick look it seems like it would be fairly
>>>>>>>>>>> straightforward to
>>>>>>>>>>> extend mkeficapsule to support multiple images, the capsule
>>>>>>>>>>> header
>>>>>>>>>>> has
>>>>>>>>>>> an item_offset_list[] array with offsets to each image, today
>>>>>>>>>>> we just
>>>>>>>>>>> write 1 but it shouldn't be too much of a challenge to put a
>>>>>>>>>>> loop in
>>>>>>>>>>> here and extend the argument parsing.
>>>>>>>>>>>
>>>>>>>>>>> Given that we a) already use raw capsules and b) they are
>>>>>>>>>>> part of the
>>>>>>>>>>> EFI spec, I'm gonna try and save us all some time and just
>>>>>>>>>>> put my
>>>>>>>>>>> foot
>>>>>>>>>>> down here. A single raw EFI capsule file can already support
>>>>>>>>>>> updating
>>>>>>>>>>> multiple images, U-Boot already has all of the machinery for
>>>>>>>>>>> it with
>>>>>>>>>>> the
>>>>>>>>>>> exception of mkeficapsule but I expect that's something you can
>>>>>>>>>>> tackle.
>>>>>>>>>>>
>>>>>>>>>>> The upside to this is that you will be able to build capsule
>>>>>>>>>>> files
>>>>>>>>>>> for
>>>>>>>>>>> updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
>>>>>>>>>> Thanks for the detailed feedback.
>>>>>>>>>>
>>>>>>>>>> We agree — we'll drop the FIT capsule approach and move
>>>>>>>>>> forward with
>>>>>>>>>> RAW capsules.
>>>>>>>>>>
>>>>>>>>>> Here's the plan:
>>>>>>>>>>
>>>>>>>>>> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule
>>>>>>>>>> series
>>>>>>>>>> [1] to support generating multi-image capsules from a config
>>>>>>>>>>       file, so we can build a single capsule covering all the
>>>>>>>>>> partitions
>>>>>>>>>> we need to update.
>>>>>>>>>> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only
>>>>>>>>>> supports a single firmware image (U-Boot itself) via a
>>>>>>>>>>       single-entry fw_images[] array. We'll move to a SoC-
>>>>>>>>>> specific,
>>>>>>>>>> multi- entry fw_images[] array (defined per board, e.g.
>>>>>>>>>>       board/qualcomm/<board>/fw_images.c), so a single capsule
>>>>>>>>>> update
>>>>>>>>>> flow can cover multiple firmware components — each with its own
>>>>>>>>>>       ESRT entry and FMP image_index — instead of just U-Boot.
>>>>>>>>> No need for this, just build fw_images[] on the fly derived
>>>>>>>>> from the
>>>>>>>>> partition table on the board, with an entry for each partition
>>>>>>>>> that
>>>>>>>>> can be updated. You just need to add a map from partition label to
>>>>>>>>> fw_name string, starting with the xbl/uefi/boot partitions we
>>>>>>>>> already
>>>>>>>>> handle.
>>>>>>>>>
>>>>>>>>> The entire point of having logic here was to avoid per-board
>>>>>>>>> stuff, if
>>>>>>>>> you're thinking "ah I'll do this per-board" you should immediately
>>>>>>>>> wonder "but can we do it dynamically instead?".
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Casey
>>>>>>>> Hi Casey, Ilias,
>>>>>>>>
>>>>>>>>      Thanks for the pointer — agreed, building fw_images[]
>>>>>>>> dynamically
>>>>>>>> from
>>>>>>>> the partition table is the right call, avoids per-target code
>>>>>>>> entirely.
>>>>>>> Can I talk to a human instead of an LLM please?
>>>>>>>
>>>>>>>>      Plan:
>>>>>>>>      - Keep a fixed table mapping "partition label → fw_name + a
>>>>>>>> fixed
>>>>>>>> image index", this mapping going to be a superset list for all
>>>>>>>> the Boot
>>>>>>>> FW images supported in different Qualcomm targets.
>>>>>>> This reads vaguely like a rephrasing of what I proposed, not
>>>>>>> clear if
>>>>>>> you really understand it though.
>>>>>>>
>>>>>>>>         Sample table:
>>>>>>>>
>>>>>>>> ┌──────────────────┬───────────────┬───────┬────────────────────────┐
>>>>>>>>        │ part_base_name         │ fw_name                │ index
>>>>>>>> │ guid
>>>>>>>> (fixed)                                │
>>>>>>>> ├──────────────────|───────────────|───────-|
>>>>>>>> ───────────────────────- |
>>>>>>>>        │ xbl                                  │ QCOM_XBL │   1
>>>>>>>> │  QCOM_XBL_GUID                  │
>>>>>>>>        │ ubootspl                       │ QCOM_UBOOTSPL│   2   │
>>>>>>>> QCOM_UBOOTSPL_GUID     │
>>>>>>>>        │ uboot                            │ QCOM_UBOOT      │   3
>>>>>>>> │  QCOM_UBOOT_GUID            │
>>>>>>>> └──────────────────┴───────────────┴───────┴────────────────────────┘
>>>>>>>>
>>>>>>>>        Target-1 supports xbl and Target-2 supports ubootspl.
>>>>>>>>
>>>>>>>>      - At boot, scan the partition table against this table. Only
>>>>>>>> partitions actually present on that target get an fw_images[]/
>>>>>>>> ESRT entry
>>>>>>>> — nothing hardcoded per target.
>>>>>>>>
>>>>>>>>      - The image index for each partition type stays fixed and
>>>>>>>> published,
>>>>>>>> so whoever builds a capsule (mkeficapsule) always knows which
>>>>>>>> index to
>>>>>>>> target, regardless of what's discovered at runtime.
>>>>>>>>
>>>>>>>>      One wrinkle I want to flag: today's SetImage() path assumes
>>>>>>>> dfu_alt_num = image_index - 1, i.e. it picks the Nth entry in
>>>>>>>> dfu_alt_info purely by
>>>>>>>>      position. If a partition from the middle of the table is
>>>>>>>> missing on a
>>>>>>>> given target, everything after it would shift by one position
>>>>>>>> and the
>>>>>>>> wrong
>>>>>>>>      partition would get flashed — silently. Since I'd rather
>>>>>>>> not touch
>>>>>>>> that logic in common code, my plan is to keep every fixed index's
>>>>>>>> position in
>>>>>>>>      dfu_alt_info stable by inserting a placeholder (U-Boot's
>>>>>>>> existing
>>>>>>>> virt
>>>>>>>> DFU backend, which just no-ops) wherever a partition is absent,
>>>>>>>> so the
>>>>>>>> position
>>>>>>>>      math stays correct for everything after it. The missing
>>>>>>>> partition
>>>>>>>> itself simply won't have an fw_images[]/ESRT entry, so a capsule
>>>>>>>> can't
>>>>>>>> target it
>>>>>>>>      anyway — it'd get rejected before reaching DFU.
>>>>>>> Skipping past this noise... Ilias probably knows better here but
>>>>>>> yes the
>>>>>>> way dfu_alt_num is derived from ImageIndex does impose a
>>>>>>> limitation here
>>>>>>> currently where we need to ensure the indexes always start at 1 and
>>>>>>> count up.
>>>>>>>
>>>>>>> That being said, it's already quite complicated to have to
>>>>>>> maintain a
>>>>>>> database of the indices for each board, and even more complicated
>>>>>>> when
>>>>>>> we have boards that may or may not be using U-Boot SPL (for
>>>>>>> example).
>>>>>>>
>>>>>>> Having fixed ImageIndex values for each image would then seem to
>>>>>>> make
>>>>>>> the most sense as we could just use fwu to set dfu_alt_num (or
>>>>>>> another
>>>>>>> platform specific mechanism), however the EFI spec is clear that the
>>>>>>> ImageIndex of EFI_FIRMWARE_IMAGE_DESCRIPTOR must be <=
>>>>>>> DescriptorCount
>>>>>>> as returned by fmp->GetImageInfo(), so we would need to also have
>>>>>>> dummy
>>>>>>> entries in the fw_images[] array so it doesn't really solve our
>>>>>>> problem.
>>>>>>>
>>>>>>> https://uefi.org/specs/
>>>>>>> UEFI/2.9_A/23_Firmware_Update_and_Reporting.html
>>>>>>>
>>>>>>> Currently, other than for setting dfu_alt_num, the only other place
>>>>>>> where the image index needs to match is in efi_fmp_find() which was
>>>>>>> added by [1] seemingly to prevent an incorrect image index in the
>>>>>>> /capsule/ file causing dfu_alt_num to be set wrong resulting in the
>>>>>>> wrong partition being flashed. In other words, we should be able
>>>>>>> to find
>>>>>>> a way to safely remove this check.
>>>>>>>
>>>>>>> But alas, it seems like we are stuck with fmp->SetImage() being
>>>>>>> called
>>>>>>> with the image index from the capsule file per the spec, and it
>>>>>>> is the
>>>>>>> only way to identify the target partition without doing other hacks.
>>>>>>>
>>>>>>> I'd like to get some feedback from Ilias on this, since adding dummy
>>>>>>> entries really doesn't feel like an acceptable approach to me.
>>>>>>> The only
>>>>>>> alternatives I can think of also don't seem great... Either:
>>>>>>>
>>>>>>> 1. Sidestep the EFI spec by either caching data in the call to
>>>>>>> GetImageInfo() or by assuming that the void *image pointer
>>>>>>> immediately
>>>>>>> follows the efi_firmware_management_capsule_image_header (this is
>>>>>>> true
>>>>>>> for us today but would be a fragile assumption to make).
>>>>>>> 2. Use the internal image index (looked up via the image name and
>>>>>>> type_id) as the index when calling fmp->set_image() - going
>>>>>>> against the
>>>>>>> spec.
>>>>>>>
>>>>>>> It's not really clear to me what purpose the ImageIndex property
>>>>>>> serves,
>>>>>>> since GetImageInfo() is meant to match on the ImageTypeId anyway, I
>>>>>>> assume it relates somehow to the fact that there can be multiple
>>>>>>> instances of the firmware management protocol, but in U-Boot we only
>>>>>>> have one.
>>>>>>>
>>>>>>> I think the other way forward would be to use the only included
>>>>>>> escape
>>>>>>> hatch in the UEFI spec with a custom GUID in the capsule header
>>>>>>> capsule_guid field which would let us have a custom mechanism
>>>>>>> which in
>>>>>>> our case could just be a soft-fork of the existing spec with minor
>>>>>>> changes so we can just remove/ignore the UpdateImageIndex field
>>>>>>> in the
>>>>>>> capsule. Maybe this would be the most correct solution?
>>>>>>>
>>>>>>> Hopefully Ilias has some time to chime in on this, I'm sure we
>>>>>>> can find
>>>>>>> a way to go about this that doesn't involve exposing dummy data.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> // Casey
>>>>>> I feel we are complicating it by trying to go for dynamic fw_images.
>>>>>>
>>>>>> Rather than introducing a solution that diverges from the UEFI
>>>>>> specification, shall we use a board-specific static fw_images[]
>>>>> Well, the solution I proposed at the end very much doesn't diverge
>>>>> from
>>>>> the spec, that was kinda the point.
>>>>>
>>>>>> definition. This approach is simpler, remains spec-compliant, and
>>>>>> other
>>>>> Simpler for you to implement or simpler to maintain? I think that's
>>>>> quite debatable...
>>>>>
>>>>>> vendors (like NXP, TI) have also implemented static fw_images (in
>>>>>> board/
>>>>>> nxp, board/ti).
>>>>> The decision not to do this for mach-snapdragon was quite intentional
>>>>> and was the motivator behind dynamic generation of image GUIDs:
>>>>> https://lore.kernel.org/u-boot/20240830-b4-dynamic-uuid-
>>>>> v8-0-79b31b199bee@linaro.org/
>>>>>
>>>>> The image index issue was always bound to come up, and it's absolutely
>>>>> something we should be solving and not just sidestepping. We already
>>>>> support dynamic fw_images[] anyway and it's already being used by some
>>>>> devices, so we need to maintain the existing support regardless.
>>>>>
>>>>> As I understand it, Qualcomm also intend to support multiple boot
>>>>> media
>>>>> (UFS, eMMC, SPI flash) with a single U-Boot binary, so to some extent
>>>>> this array must be dynamic. And since at boot time we have all the
>>>>> info
>>>>> we need to generate fw_images, keeping a static list per-board is at
>>>>> best lazy and at worst will just make things even more complicated
>>>>> when
>>>>> we suddenly want to support configurations with/without OP-TEE and
>>>>> with/without SPL.
>>>>>
>>>>> So unless I'm missing something here I think there's a strong case
>>>>> here
>>>>> to add support for ignoring the capsule provided image index, but
>>>>> we'll
>>>>> see what Ilias has to say when he's back from vacation.
>>>> Okay Casey.
>>>>
>>>> Hi Ilias,
>>>>
>>>> Request your input on this.
>>> So the problem you are trying to fix here, is that you have boards
>>> with multiple configurations, that their image index might change, but
>>> you want to update them with a single capsule right?
>>>
>>> If that's the case, we can have a board specific function that does
>>> nothing by default, but on the qualcomm case, re-arranges the capsule
>>> image indexes *after* the capsule authentication has passed. I think
>>> this still violates the EFI spec, but I am ok with it.
>>>
>>> Cheers
>>> /Ilias
>> Hi Ilias,
>>
>>   Thanks for the input. Just to make sure we're on the same page:
>>
>>   Our understanding is that we'd add a board-specific hook (default
>> no-op, so other vendors are unaffected) that runs after the capsule
>> signature is verified but before dfu_alt_num is
>>   derived from image_index. On Qualcomm boards, this hook would look
>> at the partitions actually present at boot and remap the capsule's
>> (fixed, published) image_index to whatever position that image
>> actually occupies in dfu_alt_info on that specific target — rather
>> than assuming a fixed 1:1 mapping between image_index and position.
>>
>>   To be clear on scope: we're not ignoring the image_index value
>> itself — it's still read from the capsule and used as-is to look up
>> which firmware component (xbl/uboot/etc.) is being

no, the entire point is that the image index is bunk, why are you
feeding these emails through an LLM?

>>
>>   targeted. What we're overriding is the spec's assumption that this
>> index also encodes position, i.e. that dfu_alt_num = image_index - 1
>> and that image_index stays within descriptor_count.

the spec's assumption????? this has nothing to do with the spec
>>
>>   Since our FMP descriptor list is built dynamically per-board, a
>> fixed global index can exceed the descriptor count on boards missing
>> some partitions, so we remap it to the correct DFU

no
>>
>>   position ourselves instead.
>>
>> Is that a correct read of what you had in mind?

please use plain text formatting for emails.
>>
>> Regards,
>>
>> Balaji
> 
> If the above assumption is correct, then we will have following problems,
> 
> During authentication, U-Boot performs anti-rollback checks.
> 
> As part of this flow, the Image Index is converted to an Image GUID
> using fw_images[].
> 
> Since the capsule Image Index does not match the fw_images[] Image Index
> at this stage, the anti-rollback logic may resolve the wrong GUID or
> fail to find a matching entry in fw_images[].

I'd like to understand from Ilias why we need to authenticate the
firmware first before adjusting the image index, I'd hope we could avoid
that? Unless changing the index would invalidate the checksum

The image is authenticated inside of fmp->SetImage() at which point we
don't have the image type ID or name so it's too late at that point. We
would need to adjust it earlier.

perhaps we could go about it another way, what if we add a dfu_alt_num
field to efi_fw_image (and add a flag to efi_capsule_update_info to
indicate if the new field is valid), then in efi_capsule.c just before
we call efi_fmp_find() we can call a new weak function that would adjust
the image index of the matching efi_fw_image so it matches whatever is
in the capsule. Then we don't have to care what it is since we can use
the right dfu_alt_num field anyway.

Maybe this could just all be done in efi_capsule.c and not even need a
platform hook, either gated behind a config option or just behind the
new efi_fw_image.dfu_alt_num field being used.

I worry that's too much of a workaround that might cause issues down the
line but I'm not really familiar enough with this to be sure.

> 
> Regards,
> 
> Balaji
> 
>>
>>
>>>> Regards,
>>>>
>>>> Balaji
>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Balaji
>>>>>>
>>>>>>> [1]: 7cf06f09cc51 ("capsule: Put a check for image index before the
>>>>>>> update")
>>>>>>>
>>>>>>>>      Let me know if this approach sounds reasonable.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Balaji
>>>>>>>>>> Will send an updated series once the mkeficapsule and qcom
>>>>>>>>>> capsule
>>>>>>>>>> update changes are in shape.
>>>>>>>>>>
>>>>>>>>>> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>>>>>>> sughosh.ganu@linaro.org/
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Balaji
>>>>>>>>>>> Kind regards,

-- 
// Casey (she/her)

