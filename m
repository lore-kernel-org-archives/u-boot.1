Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06F6C3DA49
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 06:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C34587DC7;
	Sun, 14 Jul 2024 08:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="I/KMOmTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C187387E13; Sun, 14 Jul 2024 08:39:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F6287D87
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 08:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720939190; x=1721543990; i=xypron.glpk@gmx.de;
 bh=SZ8gFtsVUdHatkyMNfmWKaiZu0iguzeaiqbcJIVDeJU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=I/KMOmTR08zQu3qCEKa7Mqi0y9j8yg+Z/sEQcjKiiLlo7WehUHi8cqqIY51sxcOY
 iN/oRfN7aOZmL7LhT4sf/Ox6mDu/NcNuWnxZEiddl6Nj4GRLBu/ZO+LPsGbSscvFi
 3IATrA3/dyMZRs4OKPO2VNwQqGPkApxH2Rm1cDW+Scjao94P4FxnP+45bdMNg3nT9
 ggIqR64vyNF+32g2c75t78C5tgeqyjR7Ih5s8TvQip9R42Qsl0gpwNh+SFYOCFqZF
 Wx9KUDITh1FnAHvlQ/uTnnRDWoR9o2L7ncX2nJ6fyjGgSgqL2VYnN2a/GnX45DBwK
 6yUUezAUVfBV/b6WWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY6Cl-1srnlD14Qf-00PUeE; Sun, 14
 Jul 2024 08:39:50 +0200
Message-ID: <fce841a3-b44b-4653-8e47-1246c359ed54@gmx.de>
Date: Sun, 14 Jul 2024 08:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] part: efi: Rely on a definition to specify the primary
 GPT position
To: Roman Stratiienko <r.stratiienko@gmail.com>
Cc: sjg@chromium.org, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240519153542.2572014-1-r.stratiienko@gmail.com>
 <b4549859-022e-4992-8a44-9dc9a21d943b@gmx.de>
 <CAGphcdnTFZvxdZf+ZT1aAmbh6t9=nAa+gWmW_PQD+7t2EQy29g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAGphcdnTFZvxdZf+ZT1aAmbh6t9=nAa+gWmW_PQD+7t2EQy29g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DCBGpqmSR03s9i/QZd+OGG1+Ru9aj4hFQboKOnVcBTyTKyVMeXb
 PfUhLYvm2+JzgJbvQmP8ffmgHF0q5FY8VanlNVvhTf27pVWG/QqIkF04wYXt8BHsMRZFaSj
 Udm5y8H13+TYDLlCTFJtYGRUtGw9DziQt95ZM4NTsYIfGwjOAExOg1KomPaSXmtEVfiN5pk
 pohQmp2hKk+GOGFy09L2Q==
UI-OutboundReport: notjunk:1;M01:P0:tNteKHvtBlg=;Up5+LekttZ45HvUy3F7pg/L3kSb
 5BW1QoBy0uwXXGitpJNJQJaNeVgPUzCEbPUpf+rk2yCrslPI/aEhdzO0VCmngQbXwlBxb3t8Q
 isygq0BokENFtX9XUKai42g7nXukUVUr2j2vHpFXFsHDp5NT4zaMJva9NmcHCVX+2VZ0MKcNh
 JeGoKrIXWg99LIdrWXiJ7BB3pxZ75oQDBflN9XZqBGTvSiXFZ8ayxuSZHrNwdHYp0Rhucyb5o
 JuYi47I4mjnQoiB4szpUwA4iQwnNWpMjiuBgIQo9wOCSgmqXpCIWD+6wYDtMOaFsIp3FInfra
 YS7aeO0dAujiHurmOz77d0UlM7vd1D7E5c/NyFicHZaEsSuyHr6q8j0oYJHRQUTmZQ9i1zhix
 6xw4GtzEu1bhsbPe5Wa3TJwE+u/NWRbZSDczLClrFyWkVCYzMhCyU2wrk0zQP9bif35MUpqPm
 meLiYy2NY4RUStWvzhjzyc+9v7355lbVyhea5gxl7UySf9A2Ke5sBRtDymY79PDePd2n2fzuV
 l39SGz/cFOhOv7duFWxZ3y+xt7Jx97R1/RBalMKx7/SUlGSqRvOf1kyNCX0Dtwe3Zc+eqJLgL
 3XCyeswNvELts/q9e5oGmOl2sUYCfg+AFBkdLuO+HjNATT5wTWP8Ltn2bWaCP43br/OduEgev
 oOJszHwDFJoIFZ60zNPvtysh9JpUMHcBTRCwvqTTS7FXKBPe5ZGtCUvK3ouTYBVFpfktDHdBl
 A+ECb/pS7NkFGpDWRT71wUYaZh0CzYDATq3fr/yaVm4sXaZjZrlKExBTnR+LhpYePsTBMvqwA
 /RF8afiYQefrUlLD4zpBSYrg==
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

On 7/13/24 23:16, Roman Stratiienko wrote:
> Hello Heinrich,
>
> Thank you for your comments.
>
> Just a few thoughts about this patch.
>
> 1. I was also sending this patch as a noninvasive, semi-cosmetic
> change. Relying on hardcoded values is usually not a good practice.
> 2. Shifting of primary GPT works in u-boot and Linux kernel with minor
> tweaks. See patches [1] and [2] for more context. I'm not going to
> upstream them.
> 3. Accepting this patch upstream helps me to reduce the dependency
> chain and potential conflicts during the rebase.

Hello Roman,

could you, please, answer my questions below.

Best regards

Heinrich

>
> BR, Roman.
>
> [1]: https://github.com/GloDroidCommunity/amlogic-series/blob/8cc5ee7df1=
358092f77f43aa0c9661883473e5af/patches-aosp/glodroid/bootloader/u-boot/000=
5-GLODROID-Shift-GPT-position-to-support-Amlogic-platf.patch
> [2]: https://github.com/GloDroidCommunity/amlogic-series/blob/8cc5ee7df1=
358092f77f43aa0c9661883473e5af/patches-aosp/glodroid/kernel/common-android=
14-6.1-lts/0001-GLODROID-Allow-placing-primary-GPT-to-2MiB-offset-to.patch
>
> =D0=BF=D0=BD, 10 =D1=87=D0=B5=D1=80=D0=B2. 2024=E2=80=AF=D1=80. =D0=BE 1=
5:22 Heinrich Schuchardt <xypron.glpk@gmx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> On 19.05.24 17:35, Roman Stratiienko wrote:
>>> Use GPT_PRIMARY_PARTITION_TABLE_LBA as the only source for a primary G=
PT
>>> location instead of hardcoding it every time.
>>>
>>> Sometimes, we need to shift the primary GPT location.
>>> Having the location in the single place simplifies such shifting.
>>
>> In gdisk there is an expert command "j - move the main partition table"=
.
>> This corresponds to CONFIG_EFI_PARTITION_ENTRIES_OFF. It does not move
>> the GPT primary header but only the partition entries. So sector 1 is
>> still occupied.
>>
>> If I read you correctly, CONFIG_EFI_PARTITION_ENTRIES_OFF is not doing
>> what you need. Instead of only moving the partition entries of the
>> primary partition table, you want to move the complete primary GPT tabl=
e.
>>
>> Somehow the operating system must find the primary GPT table.
>>
>> When writing the partition table shouldn't the offset be reflected in
>> the protective MBR fields StartingCHS and StartingLBA? See Table 5.4
>> "Protective MBR Partition Record protecting the entire disk*" of the
>> UEFI 2.10 specification.
>>
>> Does Linux support this? For testing remove the backup partition table!
>>
>> GPT_PRIMARY_PARTITION_TABLE_LBA should be made configurable in this cas=
e.
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
>>> ---
>>>    disk/part_efi.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/disk/part_efi.c b/disk/part_efi.c
>>> index 4ce9243ef2..b55e251ea1 100644
>>> --- a/disk/part_efi.c
>>> +++ b/disk/part_efi.c
>>> @@ -387,7 +387,7 @@ int write_gpt_table(struct blk_desc *desc, gpt_hea=
der *gpt_h, gpt_entry *gpt_e)
>>>        gpt_h->header_crc32 =3D cpu_to_le32(calc_crc32);
>>>
>>>        /* Write the First GPT to the block right after the Legacy MBR =
*/
>>> -     if (blk_dwrite(desc, 1, 1, gpt_h) !=3D 1)
>>> +     if (blk_dwrite(desc, (lbaint_t)le64_to_cpu(gpt_h->my_lba), 1, gp=
t_h) !=3D 1)
>>>                goto err;
>>>
>>>        if (blk_dwrite(desc, le64_to_cpu(gpt_h->partition_entry_lba),
>>> @@ -534,7 +534,7 @@ int gpt_fill_pte(struct blk_desc *desc,
>>>
>>>    static uint32_t partition_entries_offset(struct blk_desc *desc)
>>>    {
>>> -     uint32_t offset_blks =3D 2;
>>> +     uint32_t offset_blks =3D GPT_PRIMARY_PARTITION_TABLE_LBA + 1;
>>>        uint32_t __maybe_unused offset_bytes;
>>>        int __maybe_unused config_offset;
>>>
>>> @@ -572,8 +572,8 @@ static uint32_t partition_entries_offset(struct bl=
k_desc *desc)
>>>         * The earliest LBA this can be at is LBA#2 (i.e. right behind
>>>         * the (protective) MBR and the GPT header.
>>>         */
>>> -     if (offset_blks < 2)
>>> -             offset_blks =3D 2;
>>> +     if (offset_blks < (GPT_PRIMARY_PARTITION_TABLE_LBA + 1))
>>> +             offset_blks =3D GPT_PRIMARY_PARTITION_TABLE_LBA + 1;
>>>
>>>        return offset_blks;
>>>    }
>>> @@ -584,7 +584,7 @@ int gpt_fill_header(struct blk_desc *desc, gpt_hea=
der *gpt_h, char *str_guid,
>>>        gpt_h->signature =3D cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
>>>        gpt_h->revision =3D cpu_to_le32(GPT_HEADER_REVISION_V1);
>>>        gpt_h->header_size =3D cpu_to_le32(sizeof(gpt_header));
>>> -     gpt_h->my_lba =3D cpu_to_le64(1);
>>> +     gpt_h->my_lba =3D cpu_to_le64(GPT_PRIMARY_PARTITION_TABLE_LBA);
>>>        gpt_h->alternate_lba =3D cpu_to_le64(desc->lba - 1);
>>>        gpt_h->last_usable_lba =3D cpu_to_le64(desc->lba - 34);
>>>        gpt_h->partition_entry_lba =3D
>>

