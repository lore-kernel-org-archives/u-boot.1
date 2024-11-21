Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78582D6ED04
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 11:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA98D89745;
	Thu, 21 Nov 2024 12:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SK5UF+2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23BA8974A; Thu, 21 Nov 2024 12:11:42 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7113289745
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 12:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3824aef833bso565315f8f.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 03:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732187500; x=1732792300;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WptBH79be/xHpGCQR+RCMRy74m8idxdy2atR7o1SHFg=;
 b=SK5UF+2hYsvPvBkWiP4VSSzX/Q4DGnLrD587QQ8C9wiDrTtd6a3ufHF6m4+cDxBG1E
 x4NzLst3d+BDTFUHd/Max3mqnMjO57BXWYKYuZDbhdi9wXKUxFUnP2CeRMp0P7TGIhuF
 eKhnLrKpO+0y7vSnzR/0lHKcbiuQkL+zEzPP/ExFs2zBdJy+7MiPEo160sVrgEB6QLN3
 yP9WnD6GU+rXac+XZsA4Cvw4maLhMFEovKHrnb6qIZtcd5MVcECnFcogB/Lvtm1MAzx0
 XNzgDgnM6PE+plzccAijGjYhTvpPVXmDbiYOOq4SUVgWWfMFNy41USrrzW/5J3z64iUF
 +9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732187500; x=1732792300;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WptBH79be/xHpGCQR+RCMRy74m8idxdy2atR7o1SHFg=;
 b=FUFGgk089+1bpiRS34ZUWMEE9DDEVOWTE7KlqMwuGq8LLS9iJbNJGhXKLInO/tL319
 IlSwbjWLadGHF/vfU+dDmj6H3ELI0g/wVyBSY7PSq0Vaxxz40bkZPY55iwwSA++o0eod
 16CWft1e8j7bb2TOrnhg8tFm+ikimILwa3LqzpdCz06Zq3SQbyZ/1a5G0EsOgHrbI+QO
 9YlFNKk7/kot3Ds5IQGQeAlpmw62WlXXchCrC2asJnFX4ku4J+CrXOmIfFFhfZ4MT+fa
 QuSd8h8qkwXtyugsCOD87z0eekAw11H5DV3ZWGo5sr1rRcP2zswKOPIJs3Hfe6BZMztY
 +4eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7b+Y8LRmGOtM5LwrCzKXQKGUOh2M0ych7csP7+4XvtsggJwZ7IFpl2eKjwFKpBNkee12BEV4=@lists.denx.de
X-Gm-Message-State: AOJu0YyA6TERDhraiCn5Q4Kc97jmHJ/fciZ+W2KLEu3UebA9PLeM05+V
 dd0bZWcCaodDZKLYW+CS/DymVh/ljsaJikdzAJTr1gmD2DAijmVRyeP0XAr/7qE=
X-Gm-Gg: ASbGnct2eF7pHLUnwoiMTyNZG0uP56GAoEJGvJ50p+ZxxrxsBjx0t0LKSceAQh0bk6B
 64C47rVm/l7zVsCDQGUMusjGxzc5BIc8oQdCbRLqABiL5JplORsAlSRGK6JC1hHF0Y/OXn3evW7
 mZtIK7wmf27FApWn8kW1vmPahAwX+nhBurSIkPmuaaPUNVyZrs4ldtxZNDu6KsxCPfoooC+cQM7
 hfJYVXndy3qhz50LvpJk5QlK10LV2PPo3CGNa8VYUsl0e8VeHGqIQ==
X-Google-Smtp-Source: AGHT+IHGEBWxHz15xkeGgnNptxuXrPJ16T9RzK3iSJHSRcGqDY3gGI7hQ5b4MAeDEnSL4o2DVu9RQA==
X-Received: by 2002:a5d:6dab:0:b0:382:4115:1ccb with SMTP id
 ffacd0b85a97d-38254ae039cmr4902345f8f.7.1732187499842; 
 Thu, 21 Nov 2024 03:11:39 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38254905421sm4702514f8f.14.2024.11.21.03.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 03:11:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume LA ROQUE <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
In-Reply-To: <877c8wncvq.fsf@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
 <87mshvxhq3.fsf@baylibre.com>
 <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
 <634d3625-deb9-4286-9b1d-4f18bdb49166@baylibre.com>
 <877c8wncvq.fsf@baylibre.com>
Date: Thu, 21 Nov 2024 12:11:35 +0100
Message-ID: <871pz4n8ns.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi,

On jeu., nov. 21, 2024 at 10:40, Mattijs Korpershoek <mkorpershoek@baylibre=
.com> wrote:

> Hi Guillaume,
>
> On mer., nov. 20, 2024 at 18:54, Guillaume LA ROQUE <glaroque@baylibre.co=
m> wrote:
>
>> Hi,
>>
>> unfortunately i don't find for now how i can fix issue in test.
>>
>> i don't really understand with when we launch test individually it's=20
>> working but if we launch test_ut test not working ,
>> I see on android test for image version 4 to mmc7 in bootflow list detec=
ted.
>>
>> =3D> ut bootstd bootflow_android_image_v4
>> Test: bootflow_android_image_v4: bootflow.c
>> scan_mmc_android_bootdev: mmc7
>> order 0: mmc2
>> order 1: mmc1
>> order 2: mmc7
>> order 3: <NULL>
>> Enabled mmc mmc7 bootdev
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting slo=
t a, tries remaining 7
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting slo=
t a, tries remaining 7
>> Older order: mmc2
>> Showing all bootflows
>> Seq=C2=A0 Method=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 State=C2=A0=C2=A0 U=
class=C2=A0=C2=A0=C2=A0 Part Name Filename
>> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- -----------=
-------------=20
>> ----------------
>>  =C2=A0 0=C2=A0 extlinux=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 mmc=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 mmc1.bootdev.part_=
1=20
>> /extlinux/extlinux.conf
>>  =C2=A0 1=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 =
mmc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootdev.wh=
ole
>>  =C2=A0 2=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 =
mmc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootdev.wh=
ole
>> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- -----------=
-------------=20
>> ----------------
>> (3 bootflows, 3 valid)
>>
>> if we just launch bootflow_android_image_v4 we have only a=20
>> mmc7.bootdev.whole and so test is ok.
>>
>> if someone have an idea or can give some idea of what i can try or check=
 .
>>
>> thanks for helping.
>
> I'll have a look

The following command fails:
$ ./test/py/test.py --bd sandbox --build -k test_ut

Running both test at the same time fails as well:
$ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v

However, running individually, no issues are observed:
$ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v4
$ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v2

Going back to look at the v1 series [1], the tests were working fine.

If we use the following base (from [1]), it works fine:
commit 9e1cd2f2cb86 ("Merge https://source.denx.de/u-boot/custodians/u-boot=
-usb")

However, the don't when using this base:
commit b7d4c80fce44 ("Merge tag 'efi-next-2024-11-18' of https://source.den=
x.de/u-boot/custodians/u-boot-efi into next")

I've bisected the issue and I've found that the following patch from
Simon causes the issue:
commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()=
")

Reverting the above patch fixes the problem when running with:
$ ./test/py/test.py --bd sandbox --build -k test_ut

However, I don't understand why Simon's patch causes a duplicate mmc7
dev to be mounted.

I will continue the investigation.

[1] https://lore.kernel.org/all/20241017-adnroidv2-v1-0-781c939902c9@baylib=
re.com/

>
>>
>> Guillaume
>> Le 20/11/2024 =C3=A0 13:56, Guillaume LA ROQUE a =C3=A9crit=C2=A0:
>>> Hi,
>>>
>>> Le 19/11/2024 =C3=A0 18:21, Mattijs Korpershoek a =C3=A9crit=C2=A0:
>>>> Hi Guillaume,
>>>>
>>>> On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek=20
>>>> <mkorpershoek@baylibre.com> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>>>>> Actually bootmethod android only support android boot image version 4
>>>>>> and with AB image, some old platform wtill use android boot image
>>>>>> version 2 with AB or without AB slot.
>>>>>>
>>>>>> This patchset add support of both version 2 and non-AB slot images.
>>>>>> It's fixed in same time a boot issue seen on khadas vim3{l} board=20
>>>>>> with 16GB eMMC
>>>>>>
>>>>>> [...]
>>>>> Thanks, Applied to=20
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>>>>
>>>>> [1/5] bootstd: android: add support of bootimage v2
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee9=
92e90bbe84278db20d29159e3eedfe0d
>>>>> [2/5] bootstd: android: add non-A/B image support
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e=
7bd3665366ca2704d1142d3f16f22c36
>>>>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773=
b2df5e4cabbaec57a0f2e7f212dbf823
>>>>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e5871=
7f2f33ef0dbb422026ef71938f2265aa
>>>>> [5/5] bootstd: Add test for Android boot image v2
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35=
a33146f887948d34130229388280844a
>>>> CI has found some issues when applying these series:
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452
>>>>
>>>> Could you have a look please?
>>> i will check
>>>>
>>>> Thanks!
>>>>
>>>>> --=20
>>>>> Mattijs
>>>
>>>
