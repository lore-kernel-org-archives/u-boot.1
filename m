Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B474DCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A31D838B7;
	Mon, 20 Oct 2025 19:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UCqsW95e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793F982E34; Mon, 20 Oct 2025 17:45:55 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C828782C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 17:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-580a1f1f187so1872627137.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760975151; x=1761579951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lkGeAlR6LQ9sZigG8/Y16uZ/lquA2uSgbYkNVW/DAGw=;
 b=UCqsW95e4DmUcpELecmvE4jvLjTqTG/7EKJTnrjtuQP8v2XNeBlqek80iOKRYjtUH8
 E9slvEmM4BYMT8en2OK0kMnh6HSl+rHFHXEyjml0WHo+iUp7T/2GpZhqxN21vGFJH8/Z
 Jmc6z2kGlWEdAKFkh2FDju0AcgNkH3Xuu/sQAAamEVToo2wMBbphLrD/714RekV5Cop/
 Qi+z9rdmv0uRqgQK/i6oZ9P8ooqCSDJaO1i1EJYTMkn4QNH7i4J50MBXjzu5UVSQiNfL
 8RSNcbKTlnuUAD/4jnnzKhAgbfo1iWOj8xTGqM8hKfMLDSF6ryMt0Q+M6hh/EsZ7L376
 Amqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760975151; x=1761579951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lkGeAlR6LQ9sZigG8/Y16uZ/lquA2uSgbYkNVW/DAGw=;
 b=OH0soUiIk/OB+Ryz2eOHQ6npufhPYbVTAEDy/u8WK98NMAQHJYzIu7MWzUzF9hoYo2
 n/hozc23or5E77duBwYTiju0ryKWxPP95s6FYXzG2dZp+3uIZrrbwal6Ju2P275gn8OQ
 uLBtCgNcsZzfe45Z0RSYCF6qm4UB9KOSZyl3h8hNHeYHNK5FcjC/yl7CmVmHA1G7XnSh
 cflLP8nAuJ81e7yl/IPNGZSlnmL0yFqoAnchejYqTZzYG1CEisOEL2cIlTD16REuwMdj
 NBjSNFjtBmglVHBrvqQEo3+vSBrC0AlIZ4diqb+bnd9g0tLKaH/JBPdJy9kTzjRck5F7
 OQPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmbcf6/zp8GhuK/Ze4roe3NvOCPbNptoM26FHv68V49AJ2os/CZthQ13CrMpp2YDy9PPiS1/c=@lists.denx.de
X-Gm-Message-State: AOJu0YzjH39ay9beT0albjdaq7uzeD5hoKiOFdEEHF6HFs5X/p5htsNu
 /FZ/2YSTDC05is5hhK8yw9JNaTYC+DU6ZOGKrD8P9oYT2cbGLSPn0nL9VEQ1vHCakAZxlx3VHir
 gEWuQnF4R01vqvhSHislWcBLQB2PhdvQ=
X-Gm-Gg: ASbGncsissbd4fzsN1ggMKKC5WNtnPl1Uh8uZTPV5SBFvj1ZW+xDGXUgENea1bfgJpz
 gV8/GSPjkreXDwZwh+IogoCo3SJqvirT35Ku0bq0fMsxe4q+nTZwvggj4YB9XXvzj8qZdRaS/y8
 SOodAwJZuZRnJbsvVVyDq6mVAnf3U9pejXBOOM06IjjFgDP2GEBRMweOodokrE/qGRTlPYimIeb
 gWMd0p9kz1QHTAWn9MgSrN8LOn/HM9JgobdliYaBKqsrMRs61k9ykH//cTmuWslGFMpgunGiLJH
X-Google-Smtp-Source: AGHT+IGojuvaZ3d2w06PnavPkmx47rneCaatLV6YeWvyA4YLE1XCBaSkgLs4x9qJjXZni7owEp+wm9KHI5dNybPTWdg=
X-Received: by 2002:a05:6102:3710:b0:5d5:f6ae:38d5 with SMTP id
 ada2fe7eead31-5d7dd6f55f7mr3907186137.42.1760975151494; Mon, 20 Oct 2025
 08:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <CADgMGSsxkrqZ3Dirq9KPoP0aaHew0A9DZEuoTotvqcHsfkEw6w@mail.gmail.com>
 <1b0bb579-5024-47b2-8fe9-58c2edfa081f@baylibre.com>
In-Reply-To: <1b0bb579-5024-47b2-8fe9-58c2edfa081f@baylibre.com>
From: george chan <gchan9527@gmail.com>
Date: Mon, 20 Oct 2025 23:45:40 +0800
X-Gm-Features: AS18NWCt_7YUHG4PS6NziAUAwkyCyu8AbVdunnrplN75IcV-In_mRJyOJE9Ti4Q
Message-ID: <CADgMGSu-6tmZNwGSt=o7D0So20=ym=YwWVrRaCUrW15BMXgWfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] android: add bootconfig support
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, 
 Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>
X-Mailman-Approved-At: Mon, 20 Oct 2025 19:17:32 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear Guillaume,


=E5=9C=A8 2025=E5=B9=B410=E6=9C=8820=E6=97=A5=E9=80=B1=E4=B8=80 21:58=EF=BC=
=8CGuillaume La Roque <glaroque@baylibre.com> =E5=AF=AB=E9=81=93=EF=BC=9A

> Hi George,
>
>
> Le 18/10/2025 =C3=A0 08:07, george chan a =C3=A9crit :
>
> Dear Guillaume,
>
> Thx for your patch.
>
> =E5=9C=A8 2025=E5=B9=B410=E6=9C=8817=E6=97=A5=E9=80=B1=E4=BA=94 21:19=EF=
=BC=8CGuillaume La Roque (TI.com) <glaroque@baylibre.com>
> =E5=AF=AB=E9=81=93=EF=BC=9A
>
>> This patchset add support of android bootconfig partition[1] in u-boot.
>> With Android boot image v4, all androidboot.* arguments must be
>> passed via bootconfig instead of using the kernel commandline.
>>
>
> it looks like the above add logic handled bootargs well.
>
> is this logic support the use case of appending existing bootargs from en=
v
> and handle the one mentioned in
> [1] for simulation of vendor bootloader behavior to append some
> androidboot.* bootcmd to formulate a new bootargs? Or is this series
> complementary to [1] so as aimed to "move" androidboot.* only to
> bootconfig? If this [1] user case is covered then I am very happy to stop
> [1] if this series can have same result.
>
> Btw, I am wondering if this series assumed Androidboot v4 only, so kernel
> ver must >=3D 5.4 and enabled with bootconfig. Since then bootconfig can =
be
> unlimited to it's length. So all predefined androidboot.* from bootloader=
,
> can now move out, and no need of default bootargs in env file any more.
>
> And how about those Androidboot v2 case?
>
> [1] https://lists.denx.de/pipermail/u-boot/2025-October/599708.html
>
> in TI project we have this patch
> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=3Dti-u-boot-2024.04=
-next&id=3D9d802d798ac143e06ffe545606aa657a6c32cc63
> , we forgot to upstream it but i'll plan to do it if it's not a problem f=
or
> you. let me know if it's ok for you and i send it this week. Normaly this
> patch resolve your issue, it's not mandatory for bootconfig support but
> needed to not lost all other bootargs no link to android in bootargs when
> you use bootmeth_android.
>
thanks to confirm. even through i dont have any idea of your internal repo,
I believe you will handle this issue well. I feel some resistance on
working with my proposed patch for months so, and better let go now and
stop it here.

>
> Except if i do some error in code, boot config code was only do when you
> have android image version 4, code take all androidboot.* param in bootar=
g,
> remove it in booatarg and put it in bootconfig partition before booting
> android.
>

Sure. and i interested to know what appened when bootflow select and later
with printenv, and how the bootargs looks like. if you are going to do
submit next round, would you mind showing this result as well=EF=BC=9F

> some arg was adding in bootargs in bootargs automatically(serial, avb arg=
,
> slot etc etc) so instead of check where it's done version of android boot
> image we have  we prefer to do it just before booting.
>
> for fastboot boot i never test it with TI board.
>
Ok then lets wait for some other dev to fix it then.

Thanks again for follow this up.

Regards,
George

>
> Guillaume
>
>
> Regards
> George
>
>>
>> [1]
>> https://source.android.com/docs/core/architecture/bootloader/implementin=
g-bootconfig
>>
>> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>> ---
>> Changes in v2:
>> - Add test
>> - Add new command to be able to load and read bootconfig before booting
>> - Somes fixes to works with sandbox test
>> - Link to v1:
>> https://lore.kernel.org/all/20241128-bootconfig-v1-0-0e63a5dae82c@baylib=
re.com/
>>
>> ---
>> Guillaume La Roque (TI.com) (4):
>>       boot: android: Add sandbox memory mapping support
>>       boot: android: Add bootconfig support
>>       cmd: abootimg: Add 'get ramdisk' command
>>       test: abootimg: Add test for bootconfig handling
>>
>> Mattijs Korpershoek (TI.com) (1):
>>       boot: android: import addBootConfigParameters() from AOSP
>>
>>  boot/image-android.c                        | 180
>> ++++++++++++++++++++++++----
>>  cmd/abootimg.c                              |  35 +++++-
>>  test/py/tests/test_android/test_abootimg.py | 108 +++++++++++++++--
>>  3 files changed, 292 insertions(+), 31 deletions(-)
>> ---
>> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
>> change-id: 20241128-bootconfig-276e247be992
>>
>> Best regards,
>> --
>> Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>>
>>
>
