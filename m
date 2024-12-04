Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B937E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 06:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE678890D8;
	Wed,  4 Dec 2024 07:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ivM91TnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED9A891C4; Wed,  4 Dec 2024 07:53:12 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD83A88EDA
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 07:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a8640763so52753045e9.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 22:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733295189; x=1733899989;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UPWjXRhA1toWHf91VgmT27PbWvQvvIMDpjst7T5Vqqg=;
 b=ivM91TnJseb7Jg97zCjmh0Jioa4ZWNYzEBu4qpLQKirOg6PAYRqkahuouMmylq8BTK
 P4CtqflaRhf2eqCjPWnayJpAD2rBc9Ekgj6hfjXghOVHZi24eORsxvG4SINS6VdjWkSA
 YQUaaAIO3f0MWJPB8BLv3mJQ2MMfq709+Nmm07LQVMpA4MyJpP/zB+HLsBCr1BvIO6V2
 FQg5DpBtwuK/yPlsNRJ4D6CSwFn1VNjTZvHJ/SQAfuRqHiA7aRPRevCaKX1r6I6rrH4K
 aAmBEAFOLWsCFwuSEqQ2luS5d1sNhwNHeYB+sSfZKsnJ4xBAJqoMZrxwjOCYiK7jNWFN
 pmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733295189; x=1733899989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UPWjXRhA1toWHf91VgmT27PbWvQvvIMDpjst7T5Vqqg=;
 b=h76ckbEt14gTP1mv32UJuhzVrUNGrloL7uWda+vFwRnt3z9JApDvjKLBWlcntzNF6S
 84AHQ55iEPa49GqokO9egpTtxH0p1e/Y9EbFPCvw1Yw/OItAQTNqdsAv/Q9/X7PNCYd6
 0DcQttz5bptemGwCMZ6SVow74OS/JbC+RCNtxZz2m5/Q6akujIm7bYVLfxeJ9kPQiVDs
 zWwDgRb36EN66pGiiC0MvOvuuuVCDaqqSIc6ijlivgBCostxSa/lMX9V/I0O0Xl1qZvG
 3ECLIwPtMPPy3iwyxz+r8Oo6BVSAGMBDngmjA/19R1aDiG6rmF0re2nr3Z77F23EJUs/
 bYmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXunbXcHFQ1F7Bl3mosBXoe3xujQkOCQvKx7FQgec7opskotnxr1aV1wUe4XiD8aMveUkPhuls=@lists.denx.de
X-Gm-Message-State: AOJu0Yzxhk6HBUZwgvr9T/KfQXXMThQor1QA85ByMvFvyy5AhfD71Zir
 TyLo19uX8U1ANpxlgx0Mo8ZlkvXhoyiJhKzPxqSzx1ksuu8OEvivqBksA3RmEqk=
X-Gm-Gg: ASbGncs6itLiJzE/SMYGRcNm4t8FST/bYORpB1qGY6qlE7JSRYOk3idFSBP0kWFFIMY
 VAsnK5HkvDO2QTg5k+DkpQWHM7RkcxDYDstz6f0nAN8qUZqHr5G3qKxjeAaP44raJoo6LcHckhl
 KtKybN1pAPfJ4Og66q7Zw5Q+MZ4Qz0JhDsnO4V7OjXkFe5FV9Euton4JHhCLH23qPajqcwClvag
 GJZk5J1mWGaqCgd0Cvz96TKY+qC+8OhBBtH6kDvfSXH5cw284Egb3RZsDEtH76GjKlXX3ls+Q6f
 FNBoxn7Xhz7b4UwR/Zcuig==
X-Google-Smtp-Source: AGHT+IGHFFHZDdoTYMqiBzKQlcev4aGWb75k2wBfgvetqnDzTSsH+dmx7SPXs56ogqcDtGWb9StJhA==
X-Received: by 2002:a05:600c:4f12:b0:434:a29d:6c71 with SMTP id
 5b1f17b1804b1-434d0a1d4admr41628695e9.27.1733295189178; 
 Tue, 03 Dec 2024 22:53:09 -0800 (PST)
Received: from ?IPV6:2001:861:d40:ed60:9d28:ed72:8d80:6e88?
 ([2001:861:d40:ed60:9d28:ed72:8d80:6e88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52aa0b4sm13113565e9.35.2024.12.03.22.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 22:53:08 -0800 (PST)
Message-ID: <44fd8932-2aec-40ec-81b5-a8135e618ce5@baylibre.com>
Date: Wed, 4 Dec 2024 07:53:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] boot: android: Add bootconfig support
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
References: <20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com>
 <20241128-bootconfig-v1-2-0e63a5dae82c@baylibre.com>
 <CAFLszTgFBtQBiC_Hd9gjUJa26aFFXLGuuvJ5gVDLEaKH-SV-dg@mail.gmail.com>
 <991937a4-9bcb-43f8-99d9-013d0c9d2dff@baylibre.com>
 <CAFLszTjY8YUhY5ZowWN0BgCK4tis8TJKJhX-n=d=MwFynq0E7g@mail.gmail.com>
 <20241203003421.GK2457179@bill-the-cat>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20241203003421.GK2457179@bill-the-cat>
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

Le 03/12/2024 à 01:34, Tom Rini a écrit :
> On Mon, Dec 02, 2024 at 05:20:20PM -0700, Simon Glass wrote:
>> Hi Guillaume,
>>
>> On Mon, 2 Dec 2024 at 01:03, Guillaume LA ROQUE <glaroque@baylibre.com> wrote:
>>> Hi,
>>>
>>> Le 30/11/2024 à 21:24, Simon Glass a écrit :
>>>> Hi Guillaume,
>>>>
>>>> On Thu, 28 Nov 2024 at 03:15, Guillaume La Roque <glaroque@baylibre.com> wrote:
>>>>> For android vendor boot image version 4 bootconfig is mandatory.[1]
>>>>>
>>>>> In the android_image_get_ramdisk function, after copying both vendor and
>>>>> boot ramdisks, we extract all androidboot.* entries from the kernel
>>>>> command line. These entries are added to the bootconfig section.
>>>>> We then update the sizes of the ramdisk and bootconfig.
>>>>> Finally, all androidboot.* entries are removed from the kernel command
>>>>> line.
>>>>>
>>>>> [1] https://source.android.com/docs/core/architecture/partitions/vendor-boot-partitions#vendor-boot-partition-v4
>>>>> Co-developed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>>>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>>>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>>>>> ---
>>>>>    boot/image-android.c | 29 +++++++++++++++++++++++++++++
>>>>>    1 file changed, 29 insertions(+)
>>>>>
>>>> I am not seeing any tests for this code. Can you please update the
>>>> test to cover this?
>>> i don't know if it's possible with test framework in uboot, to validate
>>> bootconfig raw partition is reading by android kernel. i don't really
>>> know how i can do this , if you can say me if it's something possible or
>>> not .
>> We don't have a way to boot a kernel (yet), but we do have tests that
>> check things are correct - e.g. bootflow_android() - and after a
>> 'fake' boot - e.g. bootflow_scan_boot()
> We already have a test that boots the kernel, test/py/tests/test_net_boot.py


Thanks for your feedback i will check all of this and will work on test 
for bootconfig..

Guillaume

>

