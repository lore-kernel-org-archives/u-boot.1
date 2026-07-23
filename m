Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA1AC531D0
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 19:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F331C81148;
	Thu, 23 Jul 2026 19:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zuvlEIy1pUFE; Thu, 23 Jul 2026 19:07:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF2498113F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784833634;
	bh=DmVaA+pEoZ8+I5JXH6fo6YtK8XcjBXm3R0awM9m3JHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yDJPZGScEEhR/JfTL/Gs3embnBRx4+wVrxqMp3HE4FqamDH1UnLa77LvNsIjqkXpw
	 fM2dewkJzERd+XDviiPqN4mpRh6mQkTwxFc51y2mHh3KyroGrBqkkk2/1RKqskWa9T
	 PAngIRyGWE3GMIQ6BcY75sd/ZglP/3DRNKynCp9D+whcHlSNiwU/FXD5GBd00pU18R
	 x8pw/RRlP9+8398FjFgygGSaef/eZqzsS3MEv+prFpbYOU4o/5vLLheEPBWiYheh7L
	 qDMTneYBrhfLYHYtcXfGp5B5MNYZSD+VHmJ4K4pPZ/Ovso+OCpBKW/hOKHSPkGwLzB
	 fVW/QzCqcR3ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF2498113F;
	Thu, 23 Jul 2026 19:07:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D06AA47
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 19:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6F0960AA9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 19:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sJA5T3QuBepa for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 19:07:12 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3BB8D60A88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BB8D60A88
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BB8D60A88
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 19:07:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B841D80287; Thu, 23 Jul 2026 21:07:09 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C025C800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 21:07:06 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso10634095e9.1
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 12:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784833626; x=1785438426;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DmVaA+pEoZ8+I5JXH6fo6YtK8XcjBXm3R0awM9m3JHU=;
 b=dXptcxNnUPbi1w0HdgbQOMJcnBWJ2K5OiyN4q/MSsmX3EcXDiVAhLko2wKs7aBwr0x
 LJGs6wSilDUScoi+W/m6c99XDq4fWO6qeh5YfLovqoraX4LkyJykqimbUxBgSJZNFZ4E
 7a7WSx02h6l7asw0+8EdlxJEhmtA7QdZhx70WU+Hh8fToI83yLa+kWJcH2OSyK4v6YtH
 sVVRP8Sw4KP0dyyec6oci9ESJZN1MirIru2km42IyYKGku4Nl4lnyRzeUHKDRX6JTF1Q
 vRi2C5uwO3NTPxrOrMTsqR6rKJm5Fv0bf5cFTJtu85jwYU5V+3pLdQnygAQl6LwpEH0n
 YVKw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqur9NSyNSrY4l6AqJqhS/InyTC6X9m8QWIu1J54e5xgMfaFOTvSLt77pPXqdboSsNjmQyJsHc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5QkAhN2hFFjdj85lqwtHadx+C8GKs7R5u6hv66+DrngCgCmB+
 guYED5H+tlCouMzuK4xGjCsLevOk5cav8I5cBjzOvQ6l1iMLsG0Zs1tGHlAS92DkAyc=
X-Gm-Gg: AR+sD11awNkBGEb7szwU3I1Rv5JeYyIiJrsExGrwMYpRYoEulYoFxGcyTcbQB05+PyL
 n3lckz964MpORtTAPiqkiCHbyQ/6AlqhVIVlVLd8i32Y9vCd17ydee54tXwLG7T/YmpcpoY8SbQ
 9JHyoNyPxmDzEkG5j6pd3np6WjSG4rFj+4av+dkWBxNzZZwt1qP6/6quWtzuWBG0oOm6hK5p9UH
 qnNDsmPpUdpXSjcA6hlL9rtZIg0G74xTKu5Ls5yIveMO3BRL3KH+KAeAvSlEu7y3hndSPKJlbK7
 9H57P8SidkRrpAIyn7VPDHXugv0wflI36dhelvyA/8WB62XsufTreGYLIphMW5yjKimMXJ5nKKK
 8JcJhs5F79Rie9PW2cpmpKX8dXiszIWgxRWIFObbMRuNhEJrpErGtqiXOzqLmNL3+euX6suMfbf
 VPHTpUiLnn71X9UndxRE5qKt8x9U35yibvsLiwj0JAyQ==
X-Received: by 2002:a05:600c:4708:b0:495:5172:6620 with SMTP id
 5b1f17b1804b1-49573d13256mr46137585e9.31.1784833626041; 
 Thu, 23 Jul 2026 12:07:06 -0700 (PDT)
Received: from [192.168.1.37] (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957afb4da8sm11795615e9.12.2026.07.23.12.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 12:07:04 -0700 (PDT)
Message-ID: <20feda09-ab10-43e4-831b-6a8647f5c62e@linaro.org>
Date: Thu, 23 Jul 2026 21:07:03 +0200
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
 <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
 <73fa32f5-0d10-4f95-a02f-2cac91d072d6@oss.qualcomm.com>
 <013d5bbc-983e-4386-b236-8c63f4406fc0@linaro.org>
 <aaeb155a-6195-4574-b4b4-fa7d6a88a00f@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aaeb155a-6195-4574-b4b4-fa7d6a88a00f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784833626; x=1785438426; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DmVaA+pEoZ8+I5JXH6fo6YtK8XcjBXm3R0awM9m3JHU=;
 b=iosYW97is7jr9bcNPH9nuwftIkJyxveBIS4AhtS8noH8hCS29SaU2V7dg3vKih5P4+
 vT3cbjL333Vhv/Dazz4b8DMl60UiCyk4XxqBxpvi3enFy0cGiZSXyviQJR+Gqay7F1gw
 em2t6xtW7qHX1apURpItVmDNgUdcO+XiNvJy7llNbgqeC00kHUklaIFHTa6gsUylOsQm
 HRCY8zaxWiHdpQWdzbDPHybWJXUltx3fdeZo02qjpdWw3l/jlpf6GtARGYlsBkqYNxUB
 p2UJDxAvh1i7Aph1sO8hPPbaq3Xm9hSrm3BgVfjwAZEq4DKa9K8dN39d3cy1ysZoRjSe
 9CxA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iosYW97i
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="iosYW97i"; 
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



On 23/07/2026 18:43, Balaji Selvanathan wrote:
> Hi Casey,
> 
> On 7/22/2026 8:19 PM, Casey Connolly wrote:
>> Hi Balaji,
>>
>> On 22/07/2026 11:23, Balaji Selvanathan wrote:
>>> Hi Casey,
>>>
>>> On 7/18/2026 4:19 PM, Casey Connolly wrote:
>>>>
>>>> On 7/17/26 18:16, Balaji Selvanathan wrote:
>>>>> Hi Casey, Ilias, Simon,
>>>>>
>>>>> On 5/26/2026 7:05 PM, Casey Connolly wrote:
>>>>>> Hi Balaji,
>>>>>>
>>>>>> On 25/05/2026 13:24, Balaji Selvanathan wrote:
>>>>>>> Hi Ilias,
>>>>>>>
>>>>>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>>>> To support multi-image RAW capsules, we would need to:
>>>>>>>>>>>
>>>>>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>>>>>>>> There's an equivalent tool in EDKII that can produce a capsule
>>>>>>>>>> with
>>>>>>>>>> multiple payloads. There were also patches posted for
>>>>>>>>>> mkeficapsule,
>>>>>>>>>> but need some minor tweaks to merge them
>>>>>>>>> Can you please point me those patches? I did a search myself, but
>>>>>>>>> couldnt find those patches.
>>>>>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>>>>> sughosh.ganu@linaro.org/
>>>>>>> This patch you mentioned here can create capsule with only one
>>>>>>> payload;
>>>>>>> means for multiple binaries we need to create multiple capsules. I
>>>>>>> have
>>>>>>> also asked the person who made this series to respin, but havent
>>>>>>> heard
>>>>>>> back from him.
>>>>>>   From a quick look it seems like it would be fairly
>>>>>> straightforward to
>>>>>> extend mkeficapsule to support multiple images, the capsule header
>>>>>> has
>>>>>> an item_offset_list[] array with offsets to each image, today we just
>>>>>> write 1 but it shouldn't be too much of a challenge to put a loop in
>>>>>> here and extend the argument parsing.
>>>>>>
>>>>>> Given that we a) already use raw capsules and b) they are part of the
>>>>>> EFI spec, I'm gonna try and save us all some time and just put my
>>>>>> foot
>>>>>> down here. A single raw EFI capsule file can already support updating
>>>>>> multiple images, U-Boot already has all of the machinery for it with
>>>>>> the
>>>>>> exception of mkeficapsule but I expect that's something you can
>>>>>> tackle.
>>>>>>
>>>>>> The upside to this is that you will be able to build capsule files
>>>>>> for
>>>>>> updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
>>>>> Thanks for the detailed feedback.
>>>>>
>>>>> We agree — we'll drop the FIT capsule approach and move forward with
>>>>> RAW capsules.
>>>>>
>>>>> Here's the plan:
>>>>>
>>>>> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule series
>>>>> [1] to support generating multi-image capsules from a config
>>>>>     file, so we can build a single capsule covering all the partitions
>>>>> we need to update.
>>>>> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only
>>>>> supports a single firmware image (U-Boot itself) via a
>>>>>     single-entry fw_images[] array. We'll move to a SoC-specific,
>>>>> multi- entry fw_images[] array (defined per board, e.g.
>>>>>     board/qualcomm/<board>/fw_images.c), so a single capsule update
>>>>> flow can cover multiple firmware components — each with its own
>>>>>     ESRT entry and FMP image_index — instead of just U-Boot.
>>>> No need for this, just build fw_images[] on the fly derived from the
>>>> partition table on the board, with an entry for each partition that
>>>> can be updated. You just need to add a map from partition label to
>>>> fw_name string, starting with the xbl/uefi/boot partitions we already
>>>> handle.
>>>>
>>>> The entire point of having logic here was to avoid per-board stuff, if
>>>> you're thinking "ah I'll do this per-board" you should immediately
>>>> wonder "but can we do it dynamically instead?".
>>>>
>>>> Thanks,
>>>> Casey
>>> Hi Casey, Ilias,
>>>
>>>    Thanks for the pointer — agreed, building fw_images[] dynamically
>>> from
>>> the partition table is the right call, avoids per-target code entirely.
>> Can I talk to a human instead of an LLM please?
>>
>>>    Plan:
>>>    - Keep a fixed table mapping "partition label → fw_name + a fixed
>>> image index", this mapping going to be a superset list for all the Boot
>>> FW images supported in different Qualcomm targets.
>> This reads vaguely like a rephrasing of what I proposed, not clear if
>> you really understand it though.
>>
>>>       Sample table:
>>>
>>> ┌──────────────────┬───────────────┬───────┬────────────────────────┐
>>>      │ part_base_name         │ fw_name                │ index │ guid
>>> (fixed)                                │
>>> ├──────────────────|───────────────|───────-|───────────────────────- |
>>>      │ xbl                                  │ QCOM_XBL │   1
>>> │  QCOM_XBL_GUID                  │
>>>      │ ubootspl                       │ QCOM_UBOOTSPL│   2   │
>>> QCOM_UBOOTSPL_GUID     │
>>>      │ uboot                            │ QCOM_UBOOT      │   3
>>> │  QCOM_UBOOT_GUID            │
>>> └──────────────────┴───────────────┴───────┴────────────────────────┘
>>>
>>>      Target-1 supports xbl and Target-2 supports ubootspl.
>>>
>>>    - At boot, scan the partition table against this table. Only
>>> partitions actually present on that target get an fw_images[]/ESRT entry
>>> — nothing hardcoded per target.
>>>
>>>    - The image index for each partition type stays fixed and published,
>>> so whoever builds a capsule (mkeficapsule) always knows which index to
>>> target, regardless of what's discovered at runtime.
>>>
>>>    One wrinkle I want to flag: today's SetImage() path assumes
>>> dfu_alt_num = image_index - 1, i.e. it picks the Nth entry in
>>> dfu_alt_info purely by
>>>    position. If a partition from the middle of the table is missing on a
>>> given target, everything after it would shift by one position and the
>>> wrong
>>>    partition would get flashed — silently. Since I'd rather not touch
>>> that logic in common code, my plan is to keep every fixed index's
>>> position in
>>>    dfu_alt_info stable by inserting a placeholder (U-Boot's existing
>>> virt
>>> DFU backend, which just no-ops) wherever a partition is absent, so the
>>> position
>>>    math stays correct for everything after it. The missing partition
>>> itself simply won't have an fw_images[]/ESRT entry, so a capsule can't
>>> target it
>>>    anyway — it'd get rejected before reaching DFU.
>> Skipping past this noise... Ilias probably knows better here but yes the
>> way dfu_alt_num is derived from ImageIndex does impose a limitation here
>> currently where we need to ensure the indexes always start at 1 and
>> count up.
>>
>> That being said, it's already quite complicated to have to maintain a
>> database of the indices for each board, and even more complicated when
>> we have boards that may or may not be using U-Boot SPL (for example).
>>
>> Having fixed ImageIndex values for each image would then seem to make
>> the most sense as we could just use fwu to set dfu_alt_num (or another
>> platform specific mechanism), however the EFI spec is clear that the
>> ImageIndex of EFI_FIRMWARE_IMAGE_DESCRIPTOR must be <= DescriptorCount
>> as returned by fmp->GetImageInfo(), so we would need to also have dummy
>> entries in the fw_images[] array so it doesn't really solve our problem.
>>
>> https://uefi.org/specs/UEFI/2.9_A/23_Firmware_Update_and_Reporting.html
>>
>> Currently, other than for setting dfu_alt_num, the only other place
>> where the image index needs to match is in efi_fmp_find() which was
>> added by [1] seemingly to prevent an incorrect image index in the
>> /capsule/ file causing dfu_alt_num to be set wrong resulting in the
>> wrong partition being flashed. In other words, we should be able to find
>> a way to safely remove this check.
>>
>> But alas, it seems like we are stuck with fmp->SetImage() being called
>> with the image index from the capsule file per the spec, and it is the
>> only way to identify the target partition without doing other hacks.
>>
>> I'd like to get some feedback from Ilias on this, since adding dummy
>> entries really doesn't feel like an acceptable approach to me. The only
>> alternatives I can think of also don't seem great... Either:
>>
>> 1. Sidestep the EFI spec by either caching data in the call to
>> GetImageInfo() or by assuming that the void *image pointer immediately
>> follows the efi_firmware_management_capsule_image_header (this is true
>> for us today but would be a fragile assumption to make).
>> 2. Use the internal image index (looked up via the image name and
>> type_id) as the index when calling fmp->set_image() - going against the
>> spec.
>>
>> It's not really clear to me what purpose the ImageIndex property serves,
>> since GetImageInfo() is meant to match on the ImageTypeId anyway, I
>> assume it relates somehow to the fact that there can be multiple
>> instances of the firmware management protocol, but in U-Boot we only
>> have one.
>>
>> I think the other way forward would be to use the only included escape
>> hatch in the UEFI spec with a custom GUID in the capsule header
>> capsule_guid field which would let us have a custom mechanism which in
>> our case could just be a soft-fork of the existing spec with minor
>> changes so we can just remove/ignore the UpdateImageIndex field in the
>> capsule. Maybe this would be the most correct solution?
>>
>> Hopefully Ilias has some time to chime in on this, I'm sure we can find
>> a way to go about this that doesn't involve exposing dummy data.
>>
>> Thanks,
>> // Casey
> I feel we are complicating it by trying to go for dynamic fw_images.  
> 
> Rather than introducing a solution that diverges from the UEFI
> specification, shall we use a board-specific static fw_images[]

Well, the solution I proposed at the end very much doesn't diverge from
the spec, that was kinda the point.

> definition. This approach is simpler, remains spec-compliant, and other

Simpler for you to implement or simpler to maintain? I think that's
quite debatable...

> vendors (like NXP, TI) have also implemented static fw_images (in board/
> nxp, board/ti).

The decision not to do this for mach-snapdragon was quite intentional
and was the motivator behind dynamic generation of image GUIDs:
https://lore.kernel.org/u-boot/20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org/

The image index issue was always bound to come up, and it's absolutely
something we should be solving and not just sidestepping. We already
support dynamic fw_images[] anyway and it's already being used by some
devices, so we need to maintain the existing support regardless.

As I understand it, Qualcomm also intend to support multiple boot media
(UFS, eMMC, SPI flash) with a single U-Boot binary, so to some extent
this array must be dynamic. And since at boot time we have all the info
we need to generate fw_images, keeping a static list per-board is at
best lazy and at worst will just make things even more complicated when
we suddenly want to support configurations with/without OP-TEE and
with/without SPL.

So unless I'm missing something here I think there's a strong case here
to add support for ignoring the capsule provided image index, but we'll
see what Ilias has to say when he's back from vacation.

> 
> Regards,
> 
> Balaji
> 
>>
>> [1]: 7cf06f09cc51 ("capsule: Put a check for image index before the
>> update")
>>
>>>    Let me know if this approach sounds reasonable.
>>>
>>> Thanks,
>>> Balaji
>>>>> Will send an updated series once the mkeficapsule and qcom capsule
>>>>> update changes are in shape.
>>>>>
>>>>> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>> sughosh.ganu@linaro.org/
>>>>>
>>>>> Regards,
>>>>> Balaji
>>>>>> Kind regards,

-- 
// Casey (she/her)

