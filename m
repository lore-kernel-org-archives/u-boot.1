Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64BDC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 14:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C00E64087D;
	Wed, 22 Jul 2026 14:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hQ6YmsZRy39V; Wed, 22 Jul 2026 14:50:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03E4640849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784731809;
	bh=F0cUB0HYdSNKq7WkbE7n9HxAZaHNgR+0/guBzdcIssA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JBZUU+HWf4p8CsiFNnnUB44T+9Yd10+Pje4C7ZUT14GqhpP3Y5axr4rejpQrW4JPJ
	 dsQ7VHujwBP4dJZb2jYRxAg4Q3FLEY0boJ7TJ+hfL0YliFjZNIk28tb0As0PsW1esP
	 AcfHbBONkgYnvxjlS3dUBD6k4apRF+SU6USxcu27vE4Khkf8eEcTw4AQmTpsdv8HxD
	 c3E1VMucn0hdjpj+iJecfKlQvQ2WkWAwOKSP3fNieauO3+JGZP9ikiTCCYushmda5O
	 Do/izPgDYJ4rzwS9nZx1C4Yd0kwYAA18VBqn5sclfuocO200QUxetJ2nn2ZCP3KnJG
	 4AWbE7i3N+Qhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03E4640849;
	Wed, 22 Jul 2026 14:50:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 641B5788
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A8E340176
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BbYAnj5s8-SB for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 14:50:06 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7C2FB400BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C2FB400BD
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C2FB400BD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:50:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 256408494B; Wed, 22 Jul 2026 16:50:03 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D06A848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 16:49:56 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-475417f010dso7253273f8f.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 07:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784731796; x=1785336596;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F0cUB0HYdSNKq7WkbE7n9HxAZaHNgR+0/guBzdcIssA=;
 b=P+Zx8S4C9aD1HX/eImhsUCjAgKs2yIxEKqmMqKjr9Af+Z+YQ3bksl/7pZSJdBOJAVa
 iWsl+Dtd4FSBL1Sinpg01v0lb/onUHPvCxyZ/EgZNqLvtlMLFFsxo9OY4PR0+R6UT97z
 aOar91QG08dcL6FbT0xVl1y/RZ1Pd6WZ6k7yhcF1xqdScIacKkQcGwe+fXlklc0Eq1iU
 0jg5lj3YOHaHvB9WVss/zf+gEnRUl7scAnLLU+qF5wEC/MBGATnIrlqYMH1me7uaCU2h
 vGtzCppvdlgPpBe/TMlbtfcuITIs2fMK1ZbyWX6VdULamkIiUiooz6WcYujfwTG0sq/6
 muuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnYjGUH9dvIPgT37Xg0/5o3UfYrJDPKnHLgmi8X7slhHo17eImG+OL1AnXH3M5Fa1hUxadmH4=@lists.denx.de
X-Gm-Message-State: AOJu0YwNzvJay5AY5i5qKs87a080fQnoRQugKs0UDue+SZa+JLZtRPcA
 8xqxdA2y3bUlg50/xS+zY9OpyM5auwKEpMbY2izOMxTEs9YSYJFp9nLAG2PS+x9mcl8=
X-Gm-Gg: AR+sD11ph082URQ3y7m3lQhS6D7bE5V/sJLb6x1Xlccpdz8ft+aeI+werO776U8UcgR
 fjHOSl5U25pp3NocKX8BKXlvMHw8Zvv0Nrt8AQnajMfTrHhGmcwd9mATWE3k3iyQazL1cQboz8t
 3UmdSfj21fKzLFE/SnxIe7p22v7q14Wxob+1Vb8l88IW4mNAmQFEPLQk0INUcCnss/yZzga1Q8t
 KwMAwBTOryTZMpB/9d+1MV3oN+6LzWoofWJ7t2cgWLDSVwqQjqv7qkK6IubrWp3TtqNv+FmqiQ4
 TRd1uxyyl42/V/i1LRvR4ZT8Dj7+Mla3bFBQZPj7rmTsC1D3dUlrPWhtzju5Av2IuOrJR43t8cs
 1FBiP9dTsR23hvFBCZtSD2b8WC9W+DbjzZsm07J2F3bxihZob9ZZPRkHWf3mJOOOuxjeY4gFP55
 wKEKNFdsPxfbl9/Dw01r9qj0bZpmWkyee9YJcilWjYS7odiVSFJuYS
X-Received: by 2002:a05:6000:2284:b0:47f:8ac1:a2d1 with SMTP id
 ffacd0b85a97d-47f8ac1a565mr1111691f8f.7.1784731795508; 
 Wed, 22 Jul 2026 07:49:55 -0700 (PDT)
Received: from [192.168.1.36] (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bd850asm6472390f8f.15.2026.07.22.07.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 07:49:54 -0700 (PDT)
Message-ID: <013d5bbc-983e-4386-b236-8c63f4406fc0@linaro.org>
Date: Wed, 22 Jul 2026 16:49:53 +0200
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
 <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
 <73fa32f5-0d10-4f95-a02f-2cac91d072d6@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <73fa32f5-0d10-4f95-a02f-2cac91d072d6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784731796; x=1785336596; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F0cUB0HYdSNKq7WkbE7n9HxAZaHNgR+0/guBzdcIssA=;
 b=FKRpkd+YbD5DlUkTpxa/8uoNIPF75POLeEj3hcdwcshXzc34AmbC9VOqRdO+Haf6VT
 w7mDQ6x7WzTpspF2boMdxs3aLam+LWW2X1DB8zm5oy2sWoWQaBR0+v9j3e4YzY1oI+fR
 vI1wBP9wFVjFiqhrByuQRRy99XrvckekpOqabnolir71IJMIMbjt5zg/r0YX/d7q970t
 gaVRph6ydN4t+Fc0NlyzIzYm3lTxdkqNMDDodAgIK6iZmWh+cBpT72iBLGVflLvcDzXU
 ac4aPA9b19L7WZKa+d241Ra6UlPJz8ozZCSXohbUVARWrLOTAPIFMevhQLuzTu/iox9X
 T6qA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FKRpkd+Y
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="FKRpkd+Y"; 
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
From: Casey Connolly via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Casey Connolly <casey.connolly@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Balaji,

On 22/07/2026 11:23, Balaji Selvanathan wrote:
> Hi Casey,
> 
> On 7/18/2026 4:19 PM, Casey Connolly wrote:
>>
>>
>> On 7/17/26 18:16, Balaji Selvanathan wrote:
>>> Hi Casey, Ilias, Simon,
>>>
>>> On 5/26/2026 7:05 PM, Casey Connolly wrote:
>>>> Hi Balaji,
>>>>
>>>> On 25/05/2026 13:24, Balaji Selvanathan wrote:
>>>>> Hi Ilias,
>>>>>
>>>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>>>>>> [...]
>>>>>>
>>>>>>>>> To support multi-image RAW capsules, we would need to:
>>>>>>>>>
>>>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>>>>>> There's an equivalent tool in EDKII that can produce a capsule with
>>>>>>>> multiple payloads. There were also patches posted for mkeficapsule,
>>>>>>>> but need some minor tweaks to merge them
>>>>>>> Can you please point me those patches? I did a search myself, but
>>>>>>> couldnt find those patches.
>>>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>>> sughosh.ganu@linaro.org/
>>>>> This patch you mentioned here can create capsule with only one
>>>>> payload;
>>>>> means for multiple binaries we need to create multiple capsules. I
>>>>> have
>>>>> also asked the person who made this series to respin, but havent heard
>>>>> back from him.
>>>>  From a quick look it seems like it would be fairly straightforward to
>>>> extend mkeficapsule to support multiple images, the capsule header has
>>>> an item_offset_list[] array with offsets to each image, today we just
>>>> write 1 but it shouldn't be too much of a challenge to put a loop in
>>>> here and extend the argument parsing.
>>>>
>>>> Given that we a) already use raw capsules and b) they are part of the
>>>> EFI spec, I'm gonna try and save us all some time and just put my foot
>>>> down here. A single raw EFI capsule file can already support updating
>>>> multiple images, U-Boot already has all of the machinery for it with
>>>> the
>>>> exception of mkeficapsule but I expect that's something you can tackle.
>>>>
>>>> The upside to this is that you will be able to build capsule files for
>>>> updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
>>> Thanks for the detailed feedback.
>>>
>>> We agree — we'll drop the FIT capsule approach and move forward with
>>> RAW capsules.
>>>
>>> Here's the plan:
>>>
>>> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule series
>>> [1] to support generating multi-image capsules from a config
>>>    file, so we can build a single capsule covering all the partitions
>>> we need to update.
>>> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only
>>> supports a single firmware image (U-Boot itself) via a
>>>    single-entry fw_images[] array. We'll move to a SoC-specific,
>>> multi- entry fw_images[] array (defined per board, e.g.
>>>    board/qualcomm/<board>/fw_images.c), so a single capsule update
>>> flow can cover multiple firmware components — each with its own
>>>    ESRT entry and FMP image_index — instead of just U-Boot.
>>
>> No need for this, just build fw_images[] on the fly derived from the
>> partition table on the board, with an entry for each partition that
>> can be updated. You just need to add a map from partition label to
>> fw_name string, starting with the xbl/uefi/boot partitions we already
>> handle.
>>
>> The entire point of having logic here was to avoid per-board stuff, if
>> you're thinking "ah I'll do this per-board" you should immediately
>> wonder "but can we do it dynamically instead?".
>>
>> Thanks,
>> Casey
> Hi Casey, Ilias,
> 
>   Thanks for the pointer — agreed, building fw_images[] dynamically from
> the partition table is the right call, avoids per-target code entirely.

Can I talk to a human instead of an LLM please?

> 
>   Plan:
>   - Keep a fixed table mapping "partition label → fw_name + a fixed
> image index", this mapping going to be a superset list for all the Boot
> FW images supported in different Qualcomm targets.

This reads vaguely like a rephrasing of what I proposed, not clear if
you really understand it though.

> 
>      Sample table:
> 
> ┌──────────────────┬───────────────┬───────┬────────────────────────┐
>     │ part_base_name         │ fw_name                │ index │ guid
> (fixed)                                │
> ├──────────────────|───────────────|───────-|───────────────────────- |
>     │ xbl                                  │ QCOM_XBL │   1           
> │  QCOM_XBL_GUID                  │
>     │ ubootspl                       │ QCOM_UBOOTSPL│   2   │ 
> QCOM_UBOOTSPL_GUID     │
>     │ uboot                            │ QCOM_UBOOT      │   3        
> │  QCOM_UBOOT_GUID            │
> └──────────────────┴───────────────┴───────┴────────────────────────┘
> 
>     Target-1 supports xbl and Target-2 supports ubootspl.
> 
>   - At boot, scan the partition table against this table. Only
> partitions actually present on that target get an fw_images[]/ESRT entry
> — nothing hardcoded per target.
> 
>   - The image index for each partition type stays fixed and published,
> so whoever builds a capsule (mkeficapsule) always knows which index to
> target, regardless of what's discovered at runtime.
> 
>   One wrinkle I want to flag: today's SetImage() path assumes
> dfu_alt_num = image_index - 1, i.e. it picks the Nth entry in
> dfu_alt_info purely by
>   position. If a partition from the middle of the table is missing on a
> given target, everything after it would shift by one position and the wrong
>   partition would get flashed — silently. Since I'd rather not touch
> that logic in common code, my plan is to keep every fixed index's
> position in
>   dfu_alt_info stable by inserting a placeholder (U-Boot's existing virt
> DFU backend, which just no-ops) wherever a partition is absent, so the
> position
>   math stays correct for everything after it. The missing partition
> itself simply won't have an fw_images[]/ESRT entry, so a capsule can't
> target it
>   anyway — it'd get rejected before reaching DFU.

Skipping past this noise... Ilias probably knows better here but yes the
way dfu_alt_num is derived from ImageIndex does impose a limitation here
currently where we need to ensure the indexes always start at 1 and
count up.

That being said, it's already quite complicated to have to maintain a
database of the indices for each board, and even more complicated when
we have boards that may or may not be using U-Boot SPL (for example).

Having fixed ImageIndex values for each image would then seem to make
the most sense as we could just use fwu to set dfu_alt_num (or another
platform specific mechanism), however the EFI spec is clear that the
ImageIndex of EFI_FIRMWARE_IMAGE_DESCRIPTOR must be <= DescriptorCount
as returned by fmp->GetImageInfo(), so we would need to also have dummy
entries in the fw_images[] array so it doesn't really solve our problem.

https://uefi.org/specs/UEFI/2.9_A/23_Firmware_Update_and_Reporting.html

Currently, other than for setting dfu_alt_num, the only other place
where the image index needs to match is in efi_fmp_find() which was
added by [1] seemingly to prevent an incorrect image index in the
/capsule/ file causing dfu_alt_num to be set wrong resulting in the
wrong partition being flashed. In other words, we should be able to find
a way to safely remove this check.

But alas, it seems like we are stuck with fmp->SetImage() being called
with the image index from the capsule file per the spec, and it is the
only way to identify the target partition without doing other hacks.

I'd like to get some feedback from Ilias on this, since adding dummy
entries really doesn't feel like an acceptable approach to me. The only
alternatives I can think of also don't seem great... Either:

1. Sidestep the EFI spec by either caching data in the call to
GetImageInfo() or by assuming that the void *image pointer immediately
follows the efi_firmware_management_capsule_image_header (this is true
for us today but would be a fragile assumption to make).
2. Use the internal image index (looked up via the image name and
type_id) as the index when calling fmp->set_image() - going against the
spec.

It's not really clear to me what purpose the ImageIndex property serves,
since GetImageInfo() is meant to match on the ImageTypeId anyway, I
assume it relates somehow to the fact that there can be multiple
instances of the firmware management protocol, but in U-Boot we only
have one.

I think the other way forward would be to use the only included escape
hatch in the UEFI spec with a custom GUID in the capsule header
capsule_guid field which would let us have a custom mechanism which in
our case could just be a soft-fork of the existing spec with minor
changes so we can just remove/ignore the UpdateImageIndex field in the
capsule. Maybe this would be the most correct solution?

Hopefully Ilias has some time to chime in on this, I'm sure we can find
a way to go about this that doesn't involve exposing dummy data.

Thanks,
// Casey

[1]: 7cf06f09cc51 ("capsule: Put a check for image index before the update")

> 
>   Let me know if this approach sounds reasonable.
> 
> Thanks,
> Balaji
>>>
>>> Will send an updated series once the mkeficapsule and qcom capsule
>>> update changes are in shape.
>>>
>>> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>> sughosh.ganu@linaro.org/
>>>
>>> Regards,
>>> Balaji
>>>>
>>>> Kind regards,
>>

-- 
// Casey (she/her)

