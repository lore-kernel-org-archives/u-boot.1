Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CB5C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 12:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A449A40583;
	Tue,  8 Sep 2026 12:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHUKGBHPJ8-H; Tue,  8 Sep 2026 12:58:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 717234054F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788872338;
	b=h1S43nx6+KlIexYXUplBy6Ta8MiH5PSEzbY9B2O785NNUhaiuRRKIkSJpnB+SEPPanVx
	 u6qM8Qe8KDRnBNUbwZHzB5/f3x3gNx2/VsBrrhW7vJ2pFaVb2WxXVczRGOL+Az3cck92d
	 VDgYHfkJ9Pw3s7wtTMMh0I+soBCXJmO1pHLTC/WPaJFoFvWJe2/z86QunWWfNAeh0YrVY
	 5VFk+uJfFwTIlSetj/e2blNzS3OIp+HgIan0q7Riv1VtwwoMnWBemKZNOaMIJUk07oV9d
	 i8zGXIzkHEIesCAXF9uzY6iKAdNeCtblX340Ljb4c6xS8dn/CnMCMEen74/5g4Jvywg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788872338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Content-Type:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6Bjypzu0dhwgRa43AouhAOQpK+F4gxEvjJG9sjJfMlI=;
	b=Pcde64owjBgfwLWG56ESpePJyQ95iidjCf+RAEPfNMflxWW6NlaJNVhiw92sCH60SA/m
	 oLINJqHC+czQ5hqsKokJAtlJCuEs13dmred0ZwK3g8HGpy0jxSTpm8VaAx90VjscXdRho
	 BgQN3bSyMTpMlA92cDku6O64TFdBaOS9tzbw2z/ksQr9rCBO75uYNIsss5yLICrzUZt/A
	 OIVEuiY2mW5nZPpkP0HlKfBkTcVdc21Jx+rvdgZtMTgu5py7t9qGHYw30ZBXGskRyW2Vt
	 TFn3obPuvBDNxIQaN4nll6amd/fS/AprI+7IqGcMl1ZNqH01B5y5kBEjc6vZSP69Csg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788872338;
	bh=6Bjypzu0dhwgRa43AouhAOQpK+F4gxEvjJG9sjJfMlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CCfgPYERIWiMM4nyLg/1+ZVEN8ANI63R0xT8BgAtwTTyCzvIG6tEf8H+vkCgjSuEY
	 Rpw+3FZu+m0LvBhi7D1RDyw67Sxgg/czLBL8lwWo0Q8xHX705PZ8jlZJBRVs9d1nax
	 m1jbe39S/DEzj+kRCSJeIlwiBpvG4S7+eU1yHLyFdP25Q9T4Kt3fqFnqe4exMZtRw7
	 XOtJdukWgbq8bfrypdXhb7Q3dom7vYZFMazXS3Wef3MA7WdH0la52P41q02zizEh3q
	 VI8luEila/CeR/CpESTgd78l7Fqfzi2l0XZgaXGpmJ/7mV1QJfte5osUPs5EX+Vj0h
	 wS8twe8WdBx6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 717234054F;
	Tue,  8 Sep 2026 12:58:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BE49990
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D594606F5
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xmHWwImgGUJe for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 12:58:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B68EF606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788872335;
 b=QF5OcEghmzKM/QEw5Zqdm5ooVgSbeyk33Wd92VdAAo3zh4YPWfy0Jxh5TdtVD0/XyX3k
 4SN+r57VjapwlQAz4rlwrSQeTE+Mi3hNoYzIUqdwO4K+x8Hqxz1j7/w2hjEetPojulWTX
 auga67BrQVNonWXpHXsgwyHrkOxfgMcyGaDq+V3xBOSTNF1L++x6IP6xMusreKy4xdnV+
 NXwzBa1TNMbtEAEFxMx76n1jkTjyvNYa8bU/am5BOM6JlmpvKxtqh1+B0406oyvB4TJLS
 kVcG9SIZZZlstHil8b4IIZNINMhCnmgHLGhUMJZ3S2G3te/KiYV18DprKOfBZfbb5bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788872335;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To;
 bh=6Bjypzu0dhwgRa43AouhAOQpK+F4gxEvjJG9sjJfMlI=;
 b=OiiBGuFTFHri9BuoRKJT9zgxOUYYpZ73Cr/nWwUk9IrhsychymxgMKvnv9ZRKWB4qj8W
 xVOFIQfq+ZySYstWydvKHkib6tEfCCLR+SdersbM0e1o3C/OteIuXoKB71gY4CBKlHI4z
 p7dWMSpT9dEnaGsZuSARmLgaQmjMDKBwwP3M3r64FkNhnjYFe7TJCQPXzoUV5XjpJuBhg
 71kCtCi7cE287DgtKP33HMUAtPJ45XbxHLP2ESb+3Sk/OYIUkN1rRdT7aHdbU9EmocOqW
 Cn2u9B111gxVtRwrJ5MOHC/xKhaIaOrX1kyZwjzg7fm7ilbK+QZqwO94yglbmyD3FBA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kBM9TNNf; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kBM9TNNf
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B68EF606C4
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:58:53 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso45148295e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788872331; x=1789477131;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6Bjypzu0dhwgRa43AouhAOQpK+F4gxEvjJG9sjJfMlI=;
 b=kBM9TNNfW2Beh0iNIuZfghYuLuIlon+/s+jUoHeuOxpnzgAWLZ9tWxFQwI0wePGDgd
 8mGBgN11kPDcloUoelhjdvkLXb5KCIZbZl1HLmet6JZi6MMpsGOOH4Ob1X8QRYf63VTy
 rP9H9OLXjIWLNUnce6Lv9/P2rqNONahMOc2QFLsWZB26bWUGyyHUKvmctdsRs19Bv64X
 JmW5OuQjbthgwrZ9FcVJvX4iEEIfwgo+vkGDdFFMSGKmmo53xF8aVqcM/7ZUtSEplgaN
 8I1ASXIoLGbJZcHkqO/aYMoRebtFJV1uGpy4LKwGz5GkN8u3tHy9tq45D/rpr9NgU35X
 f3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788872331; x=1789477131;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Bjypzu0dhwgRa43AouhAOQpK+F4gxEvjJG9sjJfMlI=;
 b=JgaPW26c0P8NQh14GVwVIcgJMKwd9C3wbBC3iin4VR1WVtxCr2wXpIMm/ViAg9Dx0T
 tmLFi43UxR7E6c8P2hkZ22gCgVdRsb4JwvGqQBJfn1BXSksDbHYgA4RFGiC4GIxdQa8A
 FYRNckutq2WlwcXXIxG8ZJIUfp1swXvaSs0vdp7WpQ6Mmd9BH8O9VL11rnD8BFC1NOAK
 lbHweNCbKY762kXFuiC8DpNTAbV+TE6+V3mIpMDUqfzJUhIDUO1xj8bcOFM6QMw+CZvi
 /KhT0XJHNg5bJ7497Nsv8+xOem8VaIapfMqGmVhzpDl5FJsA+ZQCGswsfqlrzRL+Q8js
 0p5Q==
X-Gm-Message-State: AFuF++k2XnEpwfzDx2IkDVlZxv4hqDx/ABSQrsJ3M7SxVIz0H0YV6Ax9
 yVz4LcwngNEAMI/hg1y60mUiKG9A3V6tAbzigIrCE3qPvajD86/15vzIZgtfOa5mlZcdzncc+HZ
 Yvel4ZlE=
X-Gm-Gg: AYBFou0ZGrm5NJ2DTuVDZO1AfIwLT7P9U7X+m7KeQwapSOThOG81N7mk5MBNwOF8Ej6
 dE/cwaVz08pf10XAl5/tegU8Mo1qcrIITr4tSO+5GceU5z4HOR93Tm65GgdJYFj43nDt5XFyUA5
 XB34N3dhbhXZ3Yua2efkcib+QzAOX88gjcwmp7bZEHaNckSL9+ahbEOz2geLK3/CqgxmAAYmf7H
 PM9wt9wmJnj6TC5tBp62PUjcdYANDgHy6YmM0lX2FE7D4B8relzWL3X8IJc5QgCCTGOEz4Nw2kr
 O4Z46GlL3dpNoMUhTS+aIgwqvvnikLGKjdZJVJltVemGDXb79qSXMtxRo7pbFph6BbAIK7aipNJ
 A/828DP7i208VywUOHSYsCUW+MD8UErGTawYAZtzauoxY//Lv+yyKSRufVaeNLZ89zeTpHQD1Ol
 t9jWqyxIXjju1thTh6uRuOMQndV2gMG1jQB2GxaHXKQWAok7gNeYZoVBgl1gKsl9ouOzf9AYmGH
 M4vuj0Crw==
X-Received: by 2002:a05:600c:c162:b0:49d:16dc:e721 with SMTP id
 5b1f17b1804b1-49d16dce7aamr88280305e9.24.1788872331007; 
 Tue, 08 Sep 2026 05:58:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e50:3860::642d:5bda?
 ([2a01:e0a:e50:3860::642d:5bda]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce831af89sm333080785e9.1.2026.09.08.05.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 05:58:50 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------iv0Qt9a6SAByxgnc0NQBiew9"
Message-ID: <715b99a0-6e08-42d5-9d22-64a9f81efa28@baylibre.com>
Date: Tue, 8 Sep 2026 14:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] boot: android: Add Android 13+ bootflow support to
 bootmeth.
To: Simon Glass <sjg@chromium.org>, =?UTF-8?B?5YiY5Z6j6L6w?=
 <valentinliu@icloud.com>
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org,
 trini@konsulko.com, igor.opaniuk@gmail.com, alchark@flipper.net,
 quentin.schulz@cherry.de, marek.vasut+renesas@mailbox.org,
 daniel@makrotopia.org, rs@ti.com
References: <20260818175301.818739-1-valentinliu@icloud.com>
 <CAFLszTj8g4xxzt9A7txOhDMU6hLe2=twZoZPo_sr7Z5m=6BC4A@mail.gmail.com>
 <05f6b482-fb91-4979-a513-c991657b55bb@me.com>
 <CAFLszTiTiYHCzwc6yN9hn49FQUeOkPRjP5H-JxJr45_Pae-_Gg@mail.gmail.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <CAFLszTiTiYHCzwc6yN9hn49FQUeOkPRjP5H-JxJr45_Pae-_Gg@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------iv0Qt9a6SAByxgnc0NQBiew9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/08/2026 à 15:16, Simon Glass a écrit :
> Hi 刘垣Valentin,
>
> On Thu, 20 Aug 2026 at 10:41, 刘垣辰<valentinliu@icloud.com> wrote:
>> Hi Simon,
>>
>> Thanks for your reviewing and suggestions.
>>
>> I can merge all scanning function into one "helper", just introduce a new variable to condition which partition we needed.
>>
>> But I have no idea about test and document and I have not seen anything in test/ or doc/ folder. Can you give me some advice?
> Yes you can see the documentation here:
>
> https://docs.u-boot-project.org/en/latest/develop/index.html#testing
>
> The android tests are in test/boot/bootflow.c and
> test/py/tests/test_android/test_abootimg.py for example. Let me know
> if you have trouble running them.
>
> BTW we try to avoid top-posting as it makes the thread confusing.
>
> Regards,
> Simon
>
>> I will refactor the AVB logic in the next patch in future.
>>
>> Best regards,
>> Valentin Liu
>>
>> 2026年8月20日下午8:31，Simon Glass<sjg@chromium.org> 写道：
>>
>>
>> Hi Valentin,
>>
>> On 2026-08-18T17:53:00, Valentin Liu<valentinliu@icloud.com> wrote:
>>
>> boot: android: Add Android 13+ bootflow support to bootmeth.
>>
>>
>> Please drop the trailing period and keep the subject under 60 characters.
>>
>>
>> The devices launching Android 13+ were using a new partition
>> named init_boot to store generic ramdisk.
>>
>>
>>
>> In the new bootflow, kernel still be stored in boot image,
>> however, the First Stage files in ramdisk were moved to
>> init_boot image. We should load it to memory and verify it
>> so that the kernel can execute init program to continue booting.
>>
>> Currently, we have supported loading the init_boot image by
>> abootimg command, but we still need bring this ability to
>> bootmeth, so that booting Android 13+ will be more easily.
>>
>>
>> Please use present/imperative tense throughout: 'were using' -> 'use',
>> 'kernel still be stored' -> 'the kernel is still stored', 'were moved'
>> -> 'are moved', 'we still need bring' -> 'we still need to bring',
>> 'more easily' -> 'easier'.
>>
>>
>> In the new bootflow, kernel still be stored in boot image,
>> however, the First Stage files in ramdisk were moved to
>> init_boot image. We should load it to memory and verify it
>> so that the kernel can execute init program to continue booting.
>>
>> Currently, we have supported loading the init_boot image by
>> abootimg command, but we still need bring this ability to
>> bootmeth, so that booting Android 13+ will be more easily.
>> Bootmeth will be able to recognize the new partition layout,
>> and boot Android normally.
>>
>> Link:https://source.android.com/docs/core/architecture/partitions/generic-boot
>> Signed-off-by: Valentin Liu<valentinliu@icloud.com>
>>
>> boot/bootmeth_android.c | 67 ++++++++++++++++++++++++++++++++++++++++
>> boot/image-android.c | 16 ++++++++++
>> cmd/abootimg.c | 5 +++
>> doc/develop/bootstd/overview.rst | 3 ++
>> include/android_image.h | 1 +
>> include/image.h | 35 +++++++++++++++++++++
>> 6 files changed, 127 insertions(+)
>>
>>
>> Please can you look at how to add a test for this addition?
>>
>> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
>> @@ -113,6 +115,51 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
>> +static int scan_init_boot_part(struct udevice *blk, struct android_priv *priv)
>> +{
>> + struct blk_desc *desc = dev_get_uclass_plat(blk);
>> + struct disk_partition partition;
>> + char partname[PART_NAME_LEN];
>> + ulong num_blks, bufsz;
>> + char *buf;
>> + int ret;
>> +
>> + if (priv->slot)
>> + sprintf(partname, INIT_BOOT_PART_NAME "_%s", priv->slot);
>> + else
>> + sprintf(partname, INIT_BOOT_PART_NAME);
>>
>>
>> This is a near-duplicate of scan_boot_part() and
>> scan_vendor_boot_part(). Please factor the common logic (build
>> partname, read the header block, check magic, extract size) into a
>> helper rather than adding a third copy.

For this i'm not agreed with simon which asking a complete rework .
you ask a big rework to be able to do a common function, for me it's 
more a task to do after of before but not in "i add init_boot support"

>>
>> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
>> @@ -291,6 +338,17 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>> + if (priv->header_version >= 4) {
>> + ret = scan_init_boot_part(bflow->blk, priv);
>> + if (ret < 0) {
>> + /*
>> + * Android 12 devices do not have the init_boot partition.
>> + * Some devices upgraded to Android 13 or later from
>> + * earlier Android versions may also not have one.
>> + */
>> + log_debug("scan init_boot failed: err=%d\n", ret);
>> + }
>> + }
>>
>>
>> priv is allocated with plain malloc() above, so it is not zeroed. On
>> failure here priv->init_boot_img_size is left uninitialised, then
>> boot_android_normal() and (in patch 2) run_avb_verification() read it
>> back as 'priv->init_boot_img_size > 0'. Please use calloc()/memset(),
>> or explicitly set priv->init_boot_img_size = 0 before the call and on
>> the failure path.
>>
>> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
>> @@ -556,6 +614,7 @@ static int boot_android_normal(struct bootflow *bflow)
>> ulong loadaddr = env_get_hex("loadaddr", 0);
>> + ulong iloadaddr = env_get_hex("init_boot_comp_addr_r", 0);
>> ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
>>
>>
>> If init_boot_comp_addr_r is unset, env_get_hex() returns 0 and you
>> silently load init_boot at address 0 and call
>> set_ainit_bootimg_addr(0). Please check that iloadaddr is non-zero and
>> error out with a clear message before using it - the vendor_boot path
>> has the same weakness, but let's not extend the pattern.
do read_slotted_partition  function should fail in this case ?
if not in this case we have same issue on vendor_boot_comp_addr_r

>>
>> diff --git a/boot/image-android.c b/boot/image-android.c
>> @@ -326,6 +326,22 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
>> +bool android_image_get_data_v4(const void *boot_hdr, const void *vendor_boot_hdr,
>> + const void *init_boot_hdr, struct andr_image_data *data)
>> +{
>> + if (!android_image_get_data(boot_hdr, vendor_boot_hdr, data))
>> + return false;
>> +
>> + if (!is_android_boot_image_header(init_boot_hdr)) {
>> + printf("Incorrect init boot image header\n");
>> + return false;
>> + }
>> +
>> + android_boot_image_v3_v4_parse_hdr(init_boot_hdr, data);
>> +
>> + return true;
>> +}
>>
>>
>> I can't find any caller of android_image_get_data_v4(). Please either
>> wire it up to whatever consumes init_boot_img_total_size, or drop it
>> (and the new struct field, and the header declaration) until it is
>> needed.
not exactly this , this function should be integrate in 
android_image_get_data , same we do for vendor_boot. so remove it and at 
this new check on init_boot partition in android_image_get_data function
>>
>> diff --git a/include/image.h b/include/image.h
>> @@ -2167,6 +2184,17 @@ bool android_image_print_dtb_contents(ulong hdr_addr);
>> +/**
>> + * is_android_init_boot_image_header() - Check the magic of init boot image
>> + *
>> + * This checks the header of Android init boot image and verifies the
>> + * magic is "ANDROID!" (same with the boot image)
>> + *
>> + * @init_boot_img: Pointer to boot image
>> + * Return: non-zero if the magic is correct, zero otherwise
>> + */
>> +bool is_android_init_boot_image_header(const void *init_boot_img);
>>
>>
>> Declared but never defined or called - scan_init_boot_part() uses
>> is_android_boot_image_header() directly, which is correct since the
>> magic is identical. Please drop the declaration.
perhaps update is_android_boot_image_header description to say it's 
included too init_boot image.
>>
>> diff --git a/include/image.h b/include/image.h
>> @@ -2199,6 +2227,13 @@ void set_abootimg_addr(ulong addr);
>> +/**
>> + * set_ainit_bootimg_addr() - Set Android init boot image address
>> + *
>> + * Return: no returned results
>> + */
>> +void set_ainit_bootimg_addr(ulong addr);
>>
>>
>> Missing @addr: description, and a void function does not need a
>> Return: line - please drop it.
>>
>> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
>> @@ -293,6 +293,9 @@ script_offset_f
>> +init_boot_comp_addr_r
>> + Address to which to load the init_boot Android image, e.g. 0xd0000000
>>
>>
>> Since this env var is required for Android 13+ to boot, please also
>> document it in the relevant board README(s) / sample env, and handle
>> the missing case gracefully in the code (see comment on
>> boot_android_normal()).
>>
>> Regards,
>> Simon
>>
>>

--------------iv0Qt9a6SAByxgnc0NQBiew9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Le 25/08/2026 à 15:16, Simon Glass a
      écrit :<br>
    </div>
    <blockquote type="cite"
cite="mid:CAFLszTiTiYHCzwc6yN9hn49FQUeOkPRjP5H-JxJr45_Pae-_Gg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">Hi 刘垣Valentin,

On Thu, 20 Aug 2026 at 10:41, 刘垣辰 <a class="moz-txt-link-rfc2396E" href="mailto:valentinliu@icloud.com">&lt;valentinliu@icloud.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Hi Simon,

Thanks for your reviewing and suggestions.

I can merge all scanning function into one "helper", just introduce a new variable to condition which partition we needed.

But I have no idea about test and document and I have not seen anything in test/ or doc/ folder. Can you give me some advice?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Yes you can see the documentation here:

<a class="moz-txt-link-freetext" href="https://docs.u-boot-project.org/en/latest/develop/index.html#testing">https://docs.u-boot-project.org/en/latest/develop/index.html#testing</a>

The android tests are in test/boot/bootflow.c and
test/py/tests/test_android/test_abootimg.py for example. Let me know
if you have trouble running them.

BTW we try to avoid top-posting as it makes the thread confusing.

Regards,
Simon

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
I will refactor the AVB logic in the next patch in future.

Best regards,
Valentin Liu

2026年8月20日下午8:31，Simon Glass <a class="moz-txt-link-rfc2396E" href="mailto:sjg@chromium.org">&lt;sjg@chromium.org&gt;</a> 写道：


Hi Valentin,

On 2026-08-18T17:53:00, Valentin Liu <a class="moz-txt-link-rfc2396E" href="mailto:valentinliu@icloud.com">&lt;valentinliu@icloud.com&gt;</a> wrote:

boot: android: Add Android 13+ bootflow support to bootmeth.


Please drop the trailing period and keep the subject under 60 characters.


The devices launching Android 13+ were using a new partition
named init_boot to store generic ramdisk.



In the new bootflow, kernel still be stored in boot image,
however, the First Stage files in ramdisk were moved to
init_boot image. We should load it to memory and verify it
so that the kernel can execute init program to continue booting.

Currently, we have supported loading the init_boot image by
abootimg command, but we still need bring this ability to
bootmeth, so that booting Android 13+ will be more easily.


Please use present/imperative tense throughout: 'were using' -&gt; 'use',
'kernel still be stored' -&gt; 'the kernel is still stored', 'were moved'
-&gt; 'are moved', 'we still need bring' -&gt; 'we still need to bring',
'more easily' -&gt; 'easier'.


In the new bootflow, kernel still be stored in boot image,
however, the First Stage files in ramdisk were moved to
init_boot image. We should load it to memory and verify it
so that the kernel can execute init program to continue booting.

Currently, we have supported loading the init_boot image by
abootimg command, but we still need bring this ability to
bootmeth, so that booting Android 13+ will be more easily.
Bootmeth will be able to recognize the new partition layout,
and boot Android normally.

Link: <a class="moz-txt-link-freetext" href="https://source.android.com/docs/core/architecture/partitions/generic-boot">https://source.android.com/docs/core/architecture/partitions/generic-boot</a>
Signed-off-by: Valentin Liu <a class="moz-txt-link-rfc2396E" href="mailto:valentinliu@icloud.com">&lt;valentinliu@icloud.com&gt;</a>

boot/bootmeth_android.c | 67 ++++++++++++++++++++++++++++++++++++++++
boot/image-android.c | 16 ++++++++++
cmd/abootimg.c | 5 +++
doc/develop/bootstd/overview.rst | 3 ++
include/android_image.h | 1 +
include/image.h | 35 +++++++++++++++++++++
6 files changed, 127 insertions(+)


Please can you look at how to add a test for this addition?

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
@@ -113,6 +115,51 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
+static int scan_init_boot_part(struct udevice *blk, struct android_priv *priv)
+{
+ struct blk_desc *desc = dev_get_uclass_plat(blk);
+ struct disk_partition partition;
+ char partname[PART_NAME_LEN];
+ ulong num_blks, bufsz;
+ char *buf;
+ int ret;
+
+ if (priv-&gt;slot)
+ sprintf(partname, INIT_BOOT_PART_NAME "_%s", priv-&gt;slot);
+ else
+ sprintf(partname, INIT_BOOT_PART_NAME);


This is a near-duplicate of scan_boot_part() and
scan_vendor_boot_part(). Please factor the common logic (build
partname, read the header block, check magic, extract size) into a
helper rather than adding a third copy.</pre>
      </blockquote>
    </blockquote>
    <br>
    For this i'm not agreed with simon which asking a complete rework .<br>
    you ask a big rework to be able to do a common function, for me it's
    more a task to do after of before but not in "i add init_boot
    support"<br>
    <br>
    <blockquote type="cite"
cite="mid:CAFLszTiTiYHCzwc6yN9hn49FQUeOkPRjP5H-JxJr45_Pae-_Gg@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
@@ -291,6 +338,17 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+ if (priv-&gt;header_version &gt;= 4) {
+ ret = scan_init_boot_part(bflow-&gt;blk, priv);
+ if (ret &lt; 0) {
+ /*
+ * Android 12 devices do not have the init_boot partition.
+ * Some devices upgraded to Android 13 or later from
+ * earlier Android versions may also not have one.
+ */
+ log_debug("scan init_boot failed: err=%d\n", ret);
+ }
+ }


priv is allocated with plain malloc() above, so it is not zeroed. On
failure here priv-&gt;init_boot_img_size is left uninitialised, then
boot_android_normal() and (in patch 2) run_avb_verification() read it
back as 'priv-&gt;init_boot_img_size &gt; 0'. Please use calloc()/memset(),
or explicitly set priv-&gt;init_boot_img_size = 0 before the call and on
the failure path.

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
@@ -556,6 +614,7 @@ static int boot_android_normal(struct bootflow *bflow)
ulong loadaddr = env_get_hex("loadaddr", 0);
+ ulong iloadaddr = env_get_hex("init_boot_comp_addr_r", 0);
ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);


If init_boot_comp_addr_r is unset, env_get_hex() returns 0 and you
silently load init_boot at address 0 and call
set_ainit_bootimg_addr(0). Please check that iloadaddr is non-zero and
error out with a clear message before using it - the vendor_boot path
has the same weakness, but let's not extend the pattern.
<span style="white-space: normal"> 
</span></pre>
      </blockquote>
    </blockquote>
    do read_slotted_partition  function should fail in this case ?<br>
    if not in this case we have same issue on vendor_boot_comp_addr_r<br>
    <br>
    <blockquote type="cite"
cite="mid:CAFLszTiTiYHCzwc6yN9hn49FQUeOkPRjP5H-JxJr45_Pae-_Gg@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

diff --git a/boot/image-android.c b/boot/image-android.c
@@ -326,6 +326,22 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
+bool android_image_get_data_v4(const void *boot_hdr, const void *vendor_boot_hdr,
+ const void *init_boot_hdr, struct andr_image_data *data)
+{
+ if (!android_image_get_data(boot_hdr, vendor_boot_hdr, data))
+ return false;
+
+ if (!is_android_boot_image_header(init_boot_hdr)) {
+ printf("Incorrect init boot image header\n");
+ return false;
+ }
+
+ android_boot_image_v3_v4_parse_hdr(init_boot_hdr, data);
+
+ return true;
+}


I can't find any caller of android_image_get_data_v4(). Please either
wire it up to whatever consumes init_boot_img_total_size, or drop it
(and the new struct field, and the header declaration) until it is
needed.</pre>
      </blockquote>
    </blockquote>
    not exactly this , this function should be integrate in
    android_image_get_data , same we do for vendor_boot. so remove it
    and at this new check on init_boot partition in
    android_image_get_data function 
    <blockquote type="cite"
cite="mid:CAFLszTiTiYHCzwc6yN9hn49FQUeOkPRjP5H-JxJr45_Pae-_Gg@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

diff --git a/include/image.h b/include/image.h
@@ -2167,6 +2184,17 @@ bool android_image_print_dtb_contents(ulong hdr_addr);
+/**
+ * is_android_init_boot_image_header() - Check the magic of init boot image
+ *
+ * This checks the header of Android init boot image and verifies the
+ * magic is "ANDROID!" (same with the boot image)
+ *
+ * @init_boot_img: Pointer to boot image
+ * Return: non-zero if the magic is correct, zero otherwise
+ */
+bool is_android_init_boot_image_header(const void *init_boot_img);


Declared but never defined or called - scan_init_boot_part() uses
is_android_boot_image_header() directly, which is correct since the
magic is identical. Please drop the declaration.</pre>
      </blockquote>
    </blockquote>
    perhaps update is_android_boot_image_header description to say it's
    included too init_boot image.
    <blockquote type="cite"
cite="mid:CAFLszTiTiYHCzwc6yN9hn49FQUeOkPRjP5H-JxJr45_Pae-_Gg@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

diff --git a/include/image.h b/include/image.h
@@ -2199,6 +2227,13 @@ void set_abootimg_addr(ulong addr);
+/**
+ * set_ainit_bootimg_addr() - Set Android init boot image address
+ *
+ * Return: no returned results
+ */
+void set_ainit_bootimg_addr(ulong addr);


Missing @addr: description, and a void function does not need a
Return: line - please drop it.

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
@@ -293,6 +293,9 @@ script_offset_f
+init_boot_comp_addr_r
+ Address to which to load the init_boot Android image, e.g. 0xd0000000


Since this env var is required for Android 13+ to boot, please also
document it in the relevant board README(s) / sample env, and handle
the missing case gracefully in the code (see comment on
boot_android_normal()).

Regards,
Simon


</pre>
      </blockquote>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------iv0Qt9a6SAByxgnc0NQBiew9--
