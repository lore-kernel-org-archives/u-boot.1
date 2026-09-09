Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BF9C79FAD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 09:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0682F406E0;
	Wed,  9 Sep 2026 09:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xlaikdxw7UMz; Wed,  9 Sep 2026 09:19:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B14F2406D1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788945547;
	b=r5pKJCui1RNM4MRan7qT2JYBfnTob2x55Kp4AlJA/1O2+la6xxzcA4Wycg43URp++DwX
	 qjHPA0hVmoEqn3nZRoh7oMOiY0Bk0q1UGQAzD7+eEU54es2IY0M/1JYcceoZgiNaiS6aG
	 St6kfBZucxfVH7BKhN3Qcn+pVfE8zMyzglyTcWjdVkGIekSV2hjeIpCxA1h1ttRn7dSqW
	 RbVvcO4myFEnABIHukCfo6aCXTgv0sZvp3g9gZvKGZ0qUAlB20PgBDct5YY/Hb3Ag13ht
	 vmGWhK5HtRpuqmB86eLNBfX2XLXlIIxsJuv9XfOZtcWFESEbqG/jSXQ3Q4q8BjcA6nQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788945547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V46pi6Zoy2+vtqushQJiByEfLl0y2qJK5TxylxW6ZRY=;
	b=RXFw5LKVlc6FBBx2R0W9XZBLMvPLyf5V49LeJs+jeuZ0PIUVR5y+Sv2gEar0WLZ0LhXS
	 bK5YvpqfpFyUqo33v4W70wW11MGV2ZiMhQ1mDhAOCMCHPIT3EzOWi9VgXTY3a8kNuh7Bt
	 EvOlnJiHwuX526w/JPglJASR+3zO7jvoUy+rignoPI39X7Jij78RFwNuWLjo2bsYgfQqd
	 BjD4Kj9Mx3/VYj5dw9rRUFDFB/6GGUTxbMGH1rVyWY2jzjH5jt1SkXjD9k1wb1vsrMnmD
	 gQ93hGhOwNAXb7Q/PBJFsjjklnj+oi4OBgtBbo5AteSbLddcFiLm9RbQKFNVWeWcuIA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORZEHwz0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788945547;
	bh=V46pi6Zoy2+vtqushQJiByEfLl0y2qJK5TxylxW6ZRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b6jXEgb+tg2dmmIyF2oEq5+6lqQDM9/5GoOdaJiYzyfPG1+/xOdhMkq1tth1RJ8tA
	 88P0D5Jt5lbwNU40duYRocZTb88kyT2l8lWLxkAoBAaNFV9rv+nt1csykdcKP0kzPr
	 mhw04yRKJtT917h2asNtmpbvHise4qhAbuInUDlmw2g0JeRjsV6vxXLMQiGh8m/djd
	 AT8MIbjsvWjjox6CnCMl/SoEDPhPJ+bAq8jSdFgKSJY872htOpRzbeBDJmaizHq3y7
	 47AM1zXAKAswuKPUdUCvA5fkVuyZ2qTZKm6SJ4H0bchnefqSmk99GUSQcGtoc0i87w
	 rJ0NNdZxtY3Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B14F2406D1;
	Wed,  9 Sep 2026 09:19:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A36A2D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20199406D1
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ywBnzW3ec5iw for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 09:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D66C4406C3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788945545;
 b=lqrtvD/+r+0FVK8yZtDBuMeebp3qw7T1lq7Up0ZVMj2Z+04AcKDHsqB+KbfTd2boy7h6
 sntfCZZIdRUIWKBWO3Hgh56UexpZVv7DC7WHyvhaC+yvd71h7R+8bOo5fQ/Fi/d0qCOzC
 tuLzm5BZq6wrwmGPxXSbwb3r2IWc/U9O9F2WOAnb+habd9+OUT67WDLi1U8dLR6k3NDKs
 tVovmlIDTwhlNXHNfPwDwAIi5vaj/CjVsJAOa5GTOaTWrHWWDPTe35jR09Qhu4DTNIui8
 7SsNIclJFva4sJrKiLn9QMrnfSGPuythN0ddU6CLh4dGY8OQRc3qzlOqp6NJxEsxcUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788945545;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=V46pi6Zoy2+vtqushQJiByEfLl0y2qJK5TxylxW6ZRY=;
 b=Uwg1S9KftqyZYfJdbnOwyDkJ/POJoS1vTFudDkevb3gNj1rdXrw/gbtutJ10FRZBcGsE
 q4gQjiz2q6NvkLblJicv/EycDhL8XkOBcBddbdnViJp3HcAtZMOXZmy7tEYjLPaTFYc0B
 wYwLog93HOtRpKiZLGosFZE7ojO+dX3OgYnH1OOKhT3ShNsl+0YImHFTgPmwVKJr7pZMa
 Rn8clwVKUPsU47D2t1sALzz7pWbxJocgLtE29c2+aT6KPGwhY7oOf2EP6aURXIMPsvsH0
 6kBvsPEeI/+omBWgK8topk9b/GvijVYw2RBU2VTDCNy34T5TRV0KZLXo6DAPUvILq8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ORZEHwz0; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ORZEHwz0
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D66C4406C3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:19:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D625601FD;
 Wed,  9 Sep 2026 09:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735D71F00A3A;
 Wed,  9 Sep 2026 09:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788945542;
 bh=V46pi6Zoy2+vtqushQJiByEfLl0y2qJK5TxylxW6ZRY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ORZEHwz0cEUw48ITCn3reY0IjoCO61C7bGtj6YVrzbwhyx8Ri1JiIw2n6I7f16sQ4
 f7/1PwrynHYj+31yvuaUHJ8UVXQGn1GdOPyYmvcGKo5fAVrfzwbGtblwSHc+WRCC8f
 NCkCNja1Pm6+pj+zEvA6JDaxIiu7g+UD+q9w7PRUOJLlXy7ioIB5tJ5zJGHtEt+wWK
 mjbtkLQB74ecBu7IqnHliUpjUoIu0+AWXS9TBc9He8al7Keh+msMpbPnws/3o7oc0n
 zQb6IvVI1Ki7552anIeMjkExE8EwLJ62pVMqZqY+wMfwUNTk+3jenmbwp8NWJza86q
 vpPkTX528nDhg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, =?utf-8?B?5YiY5Z6j6L6w?= <valentinliu@icloud.com>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 igor.opaniuk@gmail.com, alchark@flipper.net, quentin.schulz@cherry.de,
 marek.vasut+renesas@mailbox.org, daniel@makrotopia.org, rs@ti.com
Subject: Re: [PATCH v1 1/2] boot: android: Add Android 13+ bootflow support
 to bootmeth.
In-Reply-To: <715b99a0-6e08-42d5-9d22-64a9f81efa28@baylibre.com>
References: <20260818175301.818739-1-valentinliu@icloud.com>
 <CAFLszTj8g4xxzt9A7txOhDMU6hLe2=twZoZPo_sr7Z5m=6BC4A@mail.gmail.com>
 <05f6b482-fb91-4979-a513-c991657b55bb@me.com>
 <CAFLszTiTiYHCzwc6yN9hn49FQUeOkPRjP5H-JxJr45_Pae-_Gg@mail.gmail.com>
 <715b99a0-6e08-42d5-9d22-64a9f81efa28@baylibre.com>
Date: Wed, 09 Sep 2026 11:18:59 +0200
Message-ID: <87qzj26av0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 08, 2026 at 14:58, Guillaume La Roque <glaroque@baylibre.com> w=
rote:

> Le 25/08/2026 =C3=A0 15:16, Simon Glass a =C3=A9crit=C2=A0:
>> Hi =E5=88=98=E5=9E=A3Valentin,
>>
>> On Thu, 20 Aug 2026 at 10:41, =E5=88=98=E5=9E=A3=E8=BE=B0<valentinliu@ic=
loud.com> wrote:
>>> Hi Simon,
>>>
>>> Thanks for your reviewing and suggestions.
>>>
>>> I can merge all scanning function into one "helper", just introduce a n=
ew variable to condition which partition we needed.
>>>
>>> But I have no idea about test and document and I have not seen anything=
 in test/ or doc/ folder. Can you give me some advice?
>> Yes you can see the documentation here:
>>
>> https://docs.u-boot-project.org/en/latest/develop/index.html#testing
>>
>> The android tests are in test/boot/bootflow.c and
>> test/py/tests/test_android/test_abootimg.py for example. Let me know
>> if you have trouble running them.
>>
>> BTW we try to avoid top-posting as it makes the thread confusing.
>>
>> Regards,
>> Simon
>>
>>> I will refactor the AVB logic in the next patch in future.
>>>
>>> Best regards,
>>> Valentin Liu
>>>
>>> 2026=E5=B9=B48=E6=9C=8820=E6=97=A5=E4=B8=8B=E5=8D=888:31=EF=BC=8CSimon =
Glass<sjg@chromium.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>
>>>
>>> Hi Valentin,
>>>
>>> On 2026-08-18T17:53:00, Valentin Liu<valentinliu@icloud.com> wrote:
>>>
>>> boot: android: Add Android 13+ bootflow support to bootmeth.
>>>
>>>
>>> Please drop the trailing period and keep the subject under 60 character=
s.
>>>
>>>
>>> The devices launching Android 13+ were using a new partition
>>> named init_boot to store generic ramdisk.
>>>
>>>
>>>
>>> In the new bootflow, kernel still be stored in boot image,
>>> however, the First Stage files in ramdisk were moved to
>>> init_boot image. We should load it to memory and verify it
>>> so that the kernel can execute init program to continue booting.
>>>
>>> Currently, we have supported loading the init_boot image by
>>> abootimg command, but we still need bring this ability to
>>> bootmeth, so that booting Android 13+ will be more easily.
>>>
>>>
>>> Please use present/imperative tense throughout: 'were using' -> 'use',
>>> 'kernel still be stored' -> 'the kernel is still stored', 'were moved'
>>> -> 'are moved', 'we still need bring' -> 'we still need to bring',
>>> 'more easily' -> 'easier'.
>>>
>>>
>>> In the new bootflow, kernel still be stored in boot image,
>>> however, the First Stage files in ramdisk were moved to
>>> init_boot image. We should load it to memory and verify it
>>> so that the kernel can execute init program to continue booting.
>>>
>>> Currently, we have supported loading the init_boot image by
>>> abootimg command, but we still need bring this ability to
>>> bootmeth, so that booting Android 13+ will be more easily.
>>> Bootmeth will be able to recognize the new partition layout,
>>> and boot Android normally.
>>>
>>> Link:https://source.android.com/docs/core/architecture/partitions/gener=
ic-boot
>>> Signed-off-by: Valentin Liu<valentinliu@icloud.com>
>>>
>>> boot/bootmeth_android.c | 67 ++++++++++++++++++++++++++++++++++++++++
>>> boot/image-android.c | 16 ++++++++++
>>> cmd/abootimg.c | 5 +++
>>> doc/develop/bootstd/overview.rst | 3 ++
>>> include/android_image.h | 1 +
>>> include/image.h | 35 +++++++++++++++++++++
>>> 6 files changed, 127 insertions(+)
>>>
>>>
>>> Please can you look at how to add a test for this addition?
>>>
>>> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
>>> @@ -113,6 +115,51 @@ static int scan_boot_part(struct udevice *blk, str=
uct android_priv *priv)
>>> +static int scan_init_boot_part(struct udevice *blk, struct android_pri=
v *priv)
>>> +{
>>> + struct blk_desc *desc =3D dev_get_uclass_plat(blk);
>>> + struct disk_partition partition;
>>> + char partname[PART_NAME_LEN];
>>> + ulong num_blks, bufsz;
>>> + char *buf;
>>> + int ret;
>>> +
>>> + if (priv->slot)
>>> + sprintf(partname, INIT_BOOT_PART_NAME "_%s", priv->slot);
>>> + else
>>> + sprintf(partname, INIT_BOOT_PART_NAME);
>>>
>>>
>>> This is a near-duplicate of scan_boot_part() and
>>> scan_vendor_boot_part(). Please factor the common logic (build
>>> partname, read the header block, check magic, extract size) into a
>>> helper rather than adding a third copy.
>
> For this i'm not agreed with simon which asking a complete rework .
> you ask a big rework to be able to do a common function, for me it's=20
> more a task to do after of before but not in "i add init_boot support"

I don't mind a third copy either. The code is pretty simple.
We could rework this later.

Note that MediaTek has a similar patch to enable init_boot here:
https://gitlab.com/mediatek/aiot/bsp/u-boot/-/commit/38055024d20c17d67fd863=
a393011554885e5a6e

The approach there seems a bit simpler to me.
Could we work on having a simpler patch for this submission as well and
add future improvements on top?

Thanks
Mattijs

>
>>>
>>> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
>>> @@ -291,6 +338,17 @@ static int android_read_bootflow(struct udevice *d=
ev, struct bootflow *bflow)
>>> + if (priv->header_version >=3D 4) {
>>> + ret =3D scan_init_boot_part(bflow->blk, priv);
>>> + if (ret < 0) {
>>> + /*
>>> + * Android 12 devices do not have the init_boot partition.
>>> + * Some devices upgraded to Android 13 or later from
>>> + * earlier Android versions may also not have one.
>>> + */
>>> + log_debug("scan init_boot failed: err=3D%d\n", ret);
>>> + }
>>> + }
>>>
>>>
>>> priv is allocated with plain malloc() above, so it is not zeroed. On
>>> failure here priv->init_boot_img_size is left uninitialised, then
>>> boot_android_normal() and (in patch 2) run_avb_verification() read it
>>> back as 'priv->init_boot_img_size > 0'. Please use calloc()/memset(),
>>> or explicitly set priv->init_boot_img_size =3D 0 before the call and on
>>> the failure path.
>>>
>>> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
>>> @@ -556,6 +614,7 @@ static int boot_android_normal(struct bootflow *bfl=
ow)
>>> ulong loadaddr =3D env_get_hex("loadaddr", 0);
>>> + ulong iloadaddr =3D env_get_hex("init_boot_comp_addr_r", 0);
>>> ulong vloadaddr =3D env_get_hex("vendor_boot_comp_addr_r", 0);
>>>
>>>
>>> If init_boot_comp_addr_r is unset, env_get_hex() returns 0 and you
>>> silently load init_boot at address 0 and call
>>> set_ainit_bootimg_addr(0). Please check that iloadaddr is non-zero and
>>> error out with a clear message before using it - the vendor_boot path
>>> has the same weakness, but let's not extend the pattern.
> do read_slotted_partition=C2=A0 function should fail in this case ?
> if not in this case we have same issue on vendor_boot_comp_addr_r
>
>>>
>>> diff --git a/boot/image-android.c b/boot/image-android.c
>>> @@ -326,6 +326,22 @@ bool android_image_get_data(const void *boot_hdr, =
const void *vendor_boot_hdr,
>>> +bool android_image_get_data_v4(const void *boot_hdr, const void *vendo=
r_boot_hdr,
>>> + const void *init_boot_hdr, struct andr_image_data *data)
>>> +{
>>> + if (!android_image_get_data(boot_hdr, vendor_boot_hdr, data))
>>> + return false;
>>> +
>>> + if (!is_android_boot_image_header(init_boot_hdr)) {
>>> + printf("Incorrect init boot image header\n");
>>> + return false;
>>> + }
>>> +
>>> + android_boot_image_v3_v4_parse_hdr(init_boot_hdr, data);
>>> +
>>> + return true;
>>> +}
>>>
>>>
>>> I can't find any caller of android_image_get_data_v4(). Please either
>>> wire it up to whatever consumes init_boot_img_total_size, or drop it
>>> (and the new struct field, and the header declaration) until it is
>>> needed.
> not exactly this , this function should be integrate in=20
> android_image_get_data , same we do for vendor_boot. so remove it and at=
=20
> this new check on init_boot partition in android_image_get_data function
>>>
>>> diff --git a/include/image.h b/include/image.h
>>> @@ -2167,6 +2184,17 @@ bool android_image_print_dtb_contents(ulong hdr_=
addr);
>>> +/**
>>> + * is_android_init_boot_image_header() - Check the magic of init boot =
image
>>> + *
>>> + * This checks the header of Android init boot image and verifies the
>>> + * magic is "ANDROID!" (same with the boot image)
>>> + *
>>> + * @init_boot_img: Pointer to boot image
>>> + * Return: non-zero if the magic is correct, zero otherwise
>>> + */
>>> +bool is_android_init_boot_image_header(const void *init_boot_img);
>>>
>>>
>>> Declared but never defined or called - scan_init_boot_part() uses
>>> is_android_boot_image_header() directly, which is correct since the
>>> magic is identical. Please drop the declaration.
> perhaps update is_android_boot_image_header description to say it's=20
> included too init_boot image.
>>>
>>> diff --git a/include/image.h b/include/image.h
>>> @@ -2199,6 +2227,13 @@ void set_abootimg_addr(ulong addr);
>>> +/**
>>> + * set_ainit_bootimg_addr() - Set Android init boot image address
>>> + *
>>> + * Return: no returned results
>>> + */
>>> +void set_ainit_bootimg_addr(ulong addr);
>>>
>>>
>>> Missing @addr: description, and a void function does not need a
>>> Return: line - please drop it.
>>>
>>> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/ove=
rview.rst
>>> @@ -293,6 +293,9 @@ script_offset_f
>>> +init_boot_comp_addr_r
>>> + Address to which to load the init_boot Android image, e.g. 0xd0000000
>>>
>>>
>>> Since this env var is required for Android 13+ to boot, please also
>>> document it in the relevant board README(s) / sample env, and handle
>>> the missing case gracefully in the code (see comment on
>>> boot_android_normal()).
>>>
>>> Regards,
>>> Simon
>>>
>>>
