Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B16C48BC4
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 08:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDBF187DE8;
	Wed, 14 Feb 2024 09:25:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JkvChYkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F9C87CFC; Wed, 14 Feb 2024 09:25:56 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89C8587DE9
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 09:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51171c9f4c0so6326339e87.3
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 00:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707899145; x=1708503945;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rAosmDUWxOcyZxvJbv0fHos9YYb6/FXiq77fd+PH1gg=;
 b=JkvChYkv9hSk7MD2Xgw3aTG+kA7El2JTc9v3jcYzkwtLHsgiRK7HAwo19rLMcDVdq7
 1Piokj/SbldmlMRgKLvWyvAg3tNkfrKHoGgeLPg8NMNtDIz2XlxXzgT1mqT3owMTz22v
 hHmWqkhFeG1+gBDjr92A0Fqf0Hbw8I9cx57z0uROkQ5obCC1YRu/G99hFYe7buhGVx8g
 +Ts5QV/QLN44pmZuIH4hOFwXLOiOaZM0rCcV0UHwrCslEzFH4oxSqHKN8PaxoG4bXgOF
 Jz3cK0OJak6DYY/deu1yYWJ8ea0+Tj0GxzxuiY9dX8p7RhFYWwgGBB136tJiWXMTFGjr
 lmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707899145; x=1708503945;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAosmDUWxOcyZxvJbv0fHos9YYb6/FXiq77fd+PH1gg=;
 b=bSQvw6qVwnLwlRtW/i4OOMLrl4Oq5AqmSB/8nrdXZzCH32SYquYGAjvLtnWarkb+BC
 RykGHZKUevXSNozkeOY0MnkG210oSnVJVBrJtwcY/lBp+oCn1I9f/46Tjgyhxg8HkXX5
 7ChCpfqTG0z8RWQmjhZa6PqYrzkCX1roMsKq1EeBNqmUjBmK42a3yTZ1hrOEFu+AeP1c
 YWikU32RtJiTvGJavT/kXcJtIHOYHCW/S3iX/LlNV+pNifb36pG30sTC6glUMH04642X
 OC0qc/5J5PEq4zocsW0LDmeX2b6mCrx/0HK9qQcThzC3NisEHDgdtOoAxZH5d3PhabZZ
 Ourg==
X-Gm-Message-State: AOJu0YwRDPOBj9TAcwTIqd3A65vxSpm1g32PxBVSJ5eNWKU7FzH3huyi
 UgYXnxUc+AhqO0+yNaFaIFf1oZMopry/8M6EIjVaZHGWteX0I5Ji/JCplTMeNhw=
X-Google-Smtp-Source: AGHT+IHewNW3e5YiQFbUxcsJXWWm42KFKU7SZoGSVyKPYPWbvz3/p/jJBoe7ceHuWuOJdOhwFAWQyQ==
X-Received: by 2002:a05:6512:2027:b0:511:4824:6718 with SMTP id
 s7-20020a056512202700b0051148246718mr1235961lfs.56.1707899144596; 
 Wed, 14 Feb 2024 00:25:44 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 i30-20020a0565123e1e00b005119901e5e2sm554024lfv.53.2024.02.14.00.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 00:25:44 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [AVB/AB] Overhaul plans
In-Reply-To: <CAByghJbZrwA3SZUkacS-vGBCey8497e7v783FQyAKeLBmGSWnA@mail.gmail.com>
References: <CAByghJb633bMqVhQ+zFzU-tR_hM88EFFhr7mXhj6nWDUhHhHYw@mail.gmail.com>
 <87wmre2amu.fsf@baylibre.com>
 <CAByghJbZrwA3SZUkacS-vGBCey8497e7v783FQyAKeLBmGSWnA@mail.gmail.com>
Date: Wed, 14 Feb 2024 09:25:42 +0100
Message-ID: <87plwz78qh.fsf@baylibre.com>
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

Hi Igor,

On Fri, Feb 09, 2024 at 17:17, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> Hello Mattijs,
>
> On Fri, Feb 9, 2024 at 11:30=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Igor,
>>
>> On ven., f=C3=A9vr. 09, 2024 at 11:14, Igor Opaniuk <igor.opaniuk@gmail.=
com> wrote:
>>
>> > Hi everyone,
>> >
>> > I'm currently planning a big overhaul of the current implementation of
>> > AVB/AB in U-Boot during the 2024 year, which I have barely touched sin=
ce
>> > 2019. I used to believe that it was stillborn, but looks like it's
>> > being actively used
>> > now by some SoC vendors and Google folks [1][2].
>>
>> This is great news! I am not aware of any development related to the
>> above but I'm looking forward to this.
>>
>> I can't speak for all vendors but I know that TI uses both the AVB and
>> AB implementation on their AM62x Android solution.
> Amlogic also uses it.

I know for VIM3 and VIM3L (since quite some folks at BayLibre were
involved in this, including myself) :)

I did not know that they use the commands in their vendor implementation.

>
>>
>> >
>> > This is what I have in my todo list:
>> > * Backport latest libavb from AOSP upstream and add support for
>> >    Verified Boot 1.3.0 version
>> > * Sync include/android_bootloader_message.h with AOSP upstream
>> > * Check and backport fixes for AVB in AOSP U-Boot fork if needed [1]
>> > * Get acquainted with a current state of A/B support in AOSP and
>> >    backport all needed changes
>> > * Re-factor libavb, switch to U-Boot existing implementation of
>> >    rsa/sha256/sha512
>> > * Add SHA512 implementation that leverage ARMv8 CE
>> >    (pull it from Linux)
>> > * Enable hw acceleration of SHA256/SHA512 that supports ARMv8
>> >    Crypto Extensions to speed up verification process on ARMv8-based b=
oards.
>> > * AVB support for NAND storage
>>
>> I know that this has been send but I don't think Alistair has send any
>> follow-up on this:
>> https://patchwork.ozlabs.org/project/uboot/patch/20220926220211.868968-1=
-adelva@google.com/
>>
>> >
>> > If someone is already working on anything from the above list -
>> > please feel free to reach out to me, so we can avoid duplication of ef=
fort.
>> >
>> > Any comments/suggestions are welcome! Thanks!
>>
>> From my understanding, the AOSP version of U-Boot has quite a different
>> bootflow since it relies on the (out-of-tree) boot_android command [3]
>
> Correct, but it turned out that they are using some parts of the existing=
 avb
> implementation in that out-of-tree "boot_android" cmd +
> the made some adjustments on top of it, that we might be interested in :
>
> $ git log --grep=3DANDROID --oneline | grep avb
> ea8f0bb45e ANDROID: Add avb_verify unit tests
> c9f88bf213 ANDROID: Adding function comments to avb_verify
> c5599e4a9f Merge "ANDROID: avb_verify: Handle failed malloc in get_partit=
ion()"
> 3aeeae4426 ANDROID: avb_verify: Handle failed malloc in get_partition()
> 2910c1042c Merge "ANDROID: avb_pubkey: Use bin2c instead of ld"
> 30fbf100b6 Merge "ANDROID: avb: Extract avb_pubkey_is_trusted()"
> 296361e80c ANDROID: avb_pubkey: Use bin2c instead of ld
> 5af2c6d968 ANDROID: avb: Extract avb_pubkey_is_trusted()
> f74b3f5815 ANDROID: avb_verify: Don't Return ERROR_IO for mismatch in
> pubkey sizes
> d6615cd233 Merge "ANDROID: Qualify avb_find_main_pubkey() parameters as c=
onst"
> 9c8470ed6b ANDROID: Qualify avb_find_main_pubkey() parameters as const
> af808f4b04 ANDROID: avb_find_main_pubkey returns CMD_RET_*
> 2070f02c75 ANDROID: remove erraneous avb logs

Indeed, these seem interesting.

>
> Btw, my initial intention (back in 2018) was to make avb
> implementation boot-command
> agnostic, as at the time of implementing it different board/SoC
> vendors used different
> approaches for booting AOSP; moreover, iirc AOSP-specific cmd
> (boota/boot_android
> or whatever it's called now) didn't manage to land to the U-Boot
> mainline despite
> multiple attempts by different contributors.

Understood. Maybe with bootflow/bootmeth we could do something named
bootmeth_android !
>
>>
>> [3] https://android.googlesource.com/platform/external/u-boot/+/refs/hea=
ds/main/cmd/boot_android.c
>>
>> Please keep me in the loop with your progress. If you want, you can
>> reach me on IRC as well (libera: #u-boot, nick: mkorpershoek)
> Sure, will keep you posted!
>
>>
>> >
>> > [1] https://android.googlesource.com/platform/external/u-boot
>> > [2] https://source.android.com/docs/devices/cuttlefish/bootloader-dev
>> > [3] https://android.googlesource.com/platform/bootable/recovery/+/main=
/bootloader_message/include/bootloader_message/bootloader_message.h
>> >
>> > --
>> > Best regards - Atentamente - Meilleures salutations
>> >
>> > Igor Opaniuk
>> >
>> > mailto: igor.opaniuk@gmail.com
>> > skype: igor.opanyuk
>> > http://ua.linkedin.com/in/iopaniuk
>
> Regards,
> Igor
>
> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> http://ua.linkedin.com/in/iopaniuk
