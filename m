Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB6AD7876C
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 966C288360;
	Thu, 21 Nov 2024 15:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IHanvjno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8084288599; Thu, 21 Nov 2024 15:38:57 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2B188278
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3823cf963f1so582040f8f.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 06:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732199934; x=1732804734;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oK1393gYpLPLozI0flx6XzivXGb7Q+x2jfve9WOAibo=;
 b=IHanvjnos4plD2qrquVAhMw2L89ez22EI9qHUtCzTNIPaZuEsslcF+IRutFT2M+Lyb
 9739IjC14e2q52uscZU5htEab4dXSq52k09WdsY3/lGmF96GQuzAZigRr5gHHyn8s1m6
 l+9jP+Pfmuxc4yx37ABLgRVY+Vovzz9XyvJNUriQIZzHkpBlwen+QAe19RDeHsJxT+s9
 7yCHsQ2ospuzOLkM+ggbkldDtROPLgj5ocyJPwqZBzrSsdK5ITTDN0H39FBw6fdCV4eq
 ebSw1ox7/d48W45gyoVwF1ynv90w8C+VLLteRhXePsWikttKLDif2Hl/UzpGs64zbgYh
 pMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732199934; x=1732804734;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oK1393gYpLPLozI0flx6XzivXGb7Q+x2jfve9WOAibo=;
 b=atiTFwg5T0qZAMJUSO7kr8zPjCAQ5Qi83z+K6BYyGfHkt1Fnr8vUAvAB9j+389cF4U
 BlItJY4160K076CcAu102hWftAan2bx/O6Znd0SKhakbjLJ4m+ABiv1VZz5JPhGxsrxG
 HphiBnOK5KN3Jsg3PkxokO3LlLVkgBAEwegNACR5zFlCYOwVcNMhRsrWPlNbRivSKDX8
 p5S7+lE5HSJkBX6WaSuxRxG6wrEW7V6r8XvY9pwJBRGy4Q/GVtbGXe9B+ezo+1IykP6e
 RFqRwVJ5qeeiDlkMxzs6LUNVpMo74bTCv/TjfmBmp8yJ5E6R25cq7vITmsUkBSVkUf2W
 dWJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5s2PM1iSPTwMFiVhsZ40wnieZbY/pGCQhjF3SuxZeRJkxi20yQpPZEKKHP+yXRWkprRpiNyk=@lists.denx.de
X-Gm-Message-State: AOJu0YxfNYko1B3TWSrxxl7muZB/PTJCgxogPG9/Mg73Zy80uSYyTXCE
 sR9UIp1fgBEdObnBbh30aM05Kq4+VI/esFxblNBD+fKlAelqjgMZCPaJ8V488fE=
X-Gm-Gg: ASbGncsELyiuj+8dHTm1s6P+N2Oh4kKKriVD6MTlVGZ4VHocY1Y/tJNkwk14bCtoGfN
 oUmaEhMwuUnQsJ5KXj5YFHsr36JEnh69F4g65YUBTYB+X8qx7rkUMf8jGB1ZHPqKmeMHx/afVm7
 Jlt4VjU7MxXwaKFERINxiMjjbj+rKv/j6V3XIoingrA18mLSQn2oOMq6FLr4vfSrMzmQA3ngFQ0
 ligtr8JsB/FgpyHHAfwFoWwcCsmzQB0vORDZI3IYpTiJVsH0iKegg==
X-Google-Smtp-Source: AGHT+IECyKZLz4kiVaLstqehqdigqTq9jO5V41DVlPixVj9skm9JM11lV0WjF5JLLAGY4BuCsg9ECQ==
X-Received: by 2002:a05:6000:178a:b0:382:58b8:37c3 with SMTP id
 ffacd0b85a97d-38258b83977mr3282449f8f.14.1732199933842; 
 Thu, 21 Nov 2024 06:38:53 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43366cbee1csm47931945e9.1.2024.11.21.06.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 06:38:53 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, Guillaume LA ROQUE <glaroque@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil
 Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
In-Reply-To: <1809F75B2A63D1F3.14676@groups.io>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
 <87mshvxhq3.fsf@baylibre.com>
 <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
 <634d3625-deb9-4286-9b1d-4f18bdb49166@baylibre.com>
 <877c8wncvq.fsf@baylibre.com> <1809F75B2A63D1F3.14676@groups.io>
Date: Thu, 21 Nov 2024 15:38:49 +0100
Message-ID: <87plmolkhy.fsf@baylibre.com>
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

On jeu., nov. 21, 2024 at 12:11, "Mattijs Korpershoek via groups.io" <mkorp=
ershoek=3Dbaylibre.com@groups.io> wrote:

> Hi,
>
> On jeu., nov. 21, 2024 at 10:40, Mattijs Korpershoek <mkorpershoek@baylib=
re.com> wrote:
>
>> Hi Guillaume,
>>
>> On mer., nov. 20, 2024 at 18:54, Guillaume LA ROQUE <glaroque@baylibre.c=
om> wrote:
>>
>>> Hi,
>>>
>>> unfortunately i don't find for now how i can fix issue in test.
>>>
>>> i don't really understand with when we launch test individually it's=20
>>> working but if we launch test_ut test not working ,
>>> I see on android test for image version 4 to mmc7 in bootflow list dete=
cted.
>>>
>>> =3D> ut bootstd bootflow_android_image_v4
>>> Test: bootflow_android_image_v4: bootflow.c
>>> scan_mmc_android_bootdev: mmc7
>>> order 0: mmc2
>>> order 1: mmc1
>>> order 2: mmc7
>>> order 3: <NULL>
>>> Enabled mmc mmc7 bootdev
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting sl=
ot a, tries remaining 7
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting sl=
ot a, tries remaining 7
>>> Older order: mmc2
>>> Showing all bootflows
>>> Seq=C2=A0 Method=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 State=C2=A0=C2=A0 =
Uclass=C2=A0=C2=A0=C2=A0 Part Name Filename
>>> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- ----------=
--------------=20
>>> ----------------
>>>  =C2=A0 0=C2=A0 extlinux=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 mmc=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 mmc1.bootdev.part_=
1=20
>>> /extlinux/extlinux.conf
>>>  =C2=A0 1=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0=
 mmc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootdev.w=
hole
>>>  =C2=A0 2=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0=
 mmc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootdev.w=
hole
>>> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- ----------=
--------------=20
>>> ----------------
>>> (3 bootflows, 3 valid)
>>>
>>> if we just launch bootflow_android_image_v4 we have only a=20
>>> mmc7.bootdev.whole and so test is ok.
>>>
>>> if someone have an idea or can give some idea of what i can try or chec=
k .
>>>
>>> thanks for helping.
>>
>> I'll have a look
>
> The following command fails:
> $ ./test/py/test.py --bd sandbox --build -k test_ut
>
> Running both test at the same time fails as well:
> $ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v
>
> However, running individually, no issues are observed:
> $ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v4
> $ ./test/py/test.py --bd sandbox --build -k bootflow_android_image_v2
>
> Going back to look at the v1 series [1], the tests were working fine.
>
> If we use the following base (from [1]), it works fine:
> commit 9e1cd2f2cb86 ("Merge https://source.denx.de/u-boot/custodians/u-bo=
ot-usb")
>
> However, the don't when using this base:
> commit b7d4c80fce44 ("Merge tag 'efi-next-2024-11-18' of https://source.d=
enx.de/u-boot/custodians/u-boot-efi into next")
>
> I've bisected the issue and I've found that the following patch from
> Simon causes the issue:
> commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests=
()")
>
> Reverting the above patch fixes the problem when running with:
> $ ./test/py/test.py --bd sandbox --build -k test_ut
>
> However, I don't understand why Simon's patch causes a duplicate mmc7
> dev to be mounted.
>
> I will continue the investigation.

Ok, I found the issue. it's not a duplicate mmc7, but we bind the
bootmeth multiple times, which causes issues.

This can also be reproduced on next with:
$ ./test/py/test.py --bd sandbox --build -k test_ut
$ ./test/py/test.py --bd sandbox --build -k "bootflow_android or bootflow_c=
ros"

I will send a patch.

>
> [1] https://lore.kernel.org/all/20241017-adnroidv2-v1-0-781c939902c9@bayl=
ibre.com/
>
>>
>>>
>>> Guillaume
>>> Le 20/11/2024 =C3=A0 13:56, Guillaume LA ROQUE a =C3=A9crit=C2=A0:
>>>> Hi,
>>>>
>>>> Le 19/11/2024 =C3=A0 18:21, Mattijs Korpershoek a =C3=A9crit=C2=A0:
>>>>> Hi Guillaume,
>>>>>
>>>>> On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek=20
>>>>> <mkorpershoek@baylibre.com> wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>>>>>> Actually bootmethod android only support android boot image version=
 4
>>>>>>> and with AB image, some old platform wtill use android boot image
>>>>>>> version 2 with AB or without AB slot.
>>>>>>>
>>>>>>> This patchset add support of both version 2 and non-AB slot images.
>>>>>>> It's fixed in same time a boot issue seen on khadas vim3{l} board=20
>>>>>>> with 16GB eMMC
>>>>>>>
>>>>>>> [...]
>>>>>> Thanks, Applied to=20
>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>>>>>
>>>>>> [1/5] bootstd: android: add support of bootimage v2
>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee=
992e90bbe84278db20d29159e3eedfe0d
>>>>>> [2/5] bootstd: android: add non-A/B image support
>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0=
e7bd3665366ca2704d1142d3f16f22c36
>>>>>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/8854777=
3b2df5e4cabbaec57a0f2e7f212dbf823
>>>>>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e587=
17f2f33ef0dbb422026ef71938f2265aa
>>>>>> [5/5] bootstd: Add test for Android boot image v2
>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f3=
5a33146f887948d34130229388280844a
>>>>> CI has found some issues when applying these series:
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452
>>>>>
>>>>> Could you have a look please?
>>>> i will check
>>>>>
>>>>> Thanks!
>>>>>
>>>>>> --=20
>>>>>> Mattijs
>>>>
>>>>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2578): https://groups.io/g/u-boot-amlogic/message/2578
> Mute This Topic: https://groups.io/mt/109662676/1991006
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@bayli=
bre.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
