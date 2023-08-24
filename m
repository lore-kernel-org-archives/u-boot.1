Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA46C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4521086430;
	Thu, 24 Aug 2023 10:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="jrdp0KM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE07986410; Thu, 24 Aug 2023 10:21:45 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40DB88657C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bccda76fb1so44904531fa.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692865301; x=1693470101; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DOG/y9BmvrRgXxf0GQQfxdSbF/7OWSSCveyHluKSwQo=;
 b=jrdp0KM9GNwOeNDwpk/HYwm8ovhzNt+NnaX9U1jK6r4GFYCmqisMLEGdhR5gXfIcrc
 I5TQhjAooMPJDM3WerCkHIZ9QEUsFdrwPbPJBw4yCU3GFehiQ+8vEP1kOVPiyY1BDWib
 bpBhAIkacOIOfEL/7zs9Y06jtiV+YOwWWSqORw5r35ok39W3vkRHj+82JeNJdAUReDot
 xget7cSYzFV/YCN0w7pJSzPeEStoj/s7+DrYMEeTJGwnabdY3QLKwE7D6a2sQGVrAd8f
 p4vjNuF7yTLh93Z3PQNsevOM3GmefPHeEZRi2p28yILxHLHlx6IfyNowORoXsPlkoZ6A
 5DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692865301; x=1693470101;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOG/y9BmvrRgXxf0GQQfxdSbF/7OWSSCveyHluKSwQo=;
 b=M7TmcIpwB5j2KPRSBhWeTm67iPCDDlhSN4+65W0ChFMaWEnidslHxdhnnfVGIyn4bU
 ArWlapKwPwNiH+zMLrYdsEqxALop5nFLqNErshR205Ycpng/rlOs6jVuVkThvjKmhbGI
 Uxsw3VlM7gObXbzAjEi8AQvrDcBUPNl/QT78viGbzMgTOOsSK6KrfBW0CqIVsEKfd9TW
 bfxkippsYXqk8jG4nECJg0JYym/l5krbm+b4l2JEJqu0bamX+lktElCXmVYgoMVWERkv
 X3i+tE9Bya/ouPp7LmcPfYAo0GwZOOcy787Ibgi+Ujc/zupjUga9X1VkKSleCvCx05Nf
 hmQQ==
X-Gm-Message-State: AOJu0Yx4OfvdXoQoDHmvGyvyxCEmx6XC0hRTXjs/MrcmfnqwdQu4p/DK
 kdyMfzqE1oVbdxDJBzWEaviz/w==
X-Google-Smtp-Source: AGHT+IFCJAefbjcN7Jalsm5a4yFI8GV1jyYbBJvDD1Q4yiR/ew01YCTlnFvi8V1wYcWZzr1Uxs5+Cw==
X-Received: by 2002:a2e:914c:0:b0:2bc:c4ae:c565 with SMTP id
 q12-20020a2e914c000000b002bcc4aec565mr7468883ljg.28.1692865301397; 
 Thu, 24 Aug 2023 01:21:41 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 y23-20020a1c4b17000000b003fc01189b0dsm1831620wma.42.2023.08.24.01.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:21:41 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Simon Glass <sjg@google.com>
Cc: Tom Rini <trini@konsulko.com>, Neha Francis <n-francis@ti.com>, Bryan
 <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan Kiszka <jan.kiszka@siemens.com>, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
In-Reply-To: <20230824032709.phneggflsw2ps2dv@reanalyze>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
 <20230824001848.vgzl7rcphic3gu2n@carnival>
 <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
 <20230824032709.phneggflsw2ps2dv@reanalyze>
Date: Thu, 24 Aug 2023 10:21:39 +0200
Message-ID: <87fs48rgto.fsf@baylibre.com>
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

On mer., ao=C3=BBt 23, 2023 at 22:27, Nishanth Menon <nm@ti.com> wrote:

> On 21:01-20230823, Simon Glass wrote:
>> Hi Nishanth,
>>=20
>> On Wed, 23 Aug 2023 at 18:18, Nishanth Menon <nm@ti.com> wrote:
>> >
>> > On 17:57-20230823, Simon Glass wrote:
>> > [...]
>> > > > This is how we have a common bit of rST for how to build N boards,
>> > > > without having to do a literal copy and paste N times.
>> > >
>> > > How about using this?
>> > >
>> > > https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#s=
ubstitution-definitions
>> >
>> > I was not able to succeed with complex includes such as:
>> > https://github.com/u-boot/u-boot/blob/master/doc/board/ti/am62x_sk.rst=
?plain=3D1#L89
>> >
>> > am62x complete build procedure defined once and reused in other am62x
>> > platforms.. But the am62x build procedure itself is reused from common
>> > k3 build steps.
>>=20
>> I followed through these instructions. I find the env vars quite
>> confusing, since I don't really know what it is doing. It feels like a
>> script:
>>=20
>> do $a $b $c
>> do $f $e
>>=20
>> it is pretty hard to follow. I think it would be better to write
>> everything out in full for each board, like rockchip does.
>
> Unfortunately, this is a few major steps that is repeated for
> (currently):
> 	AM62x SK
> 	Toradex Verdin
> 	(pending: beagleplay - )
> 	(once all the dust clears up, hopefully phytec)
> 	SK-LP
> 	....
>
> I have no reasonable way to offer to keep them all in sync.
> 	https://libera.irclog.whitequark.org/u-boot/2023-07-26#34662854;
> is kind of why I went down this path.S
>
>>=20
>> Some other minor feedback:
>>=20
>> - The 'make' lines should really have -j $(nproc) added
>
> Different styles of shells..
>
>> - The $ signs at the start of each command in the docs are a pain
>> since it stops me copying the commands into the terminal - can you
>> remove them?
>
> hehe.. "dont" let people blindly copy paste without understanding what is
> going on argument?
>
> If folks are OK, I sure can send a different patch series for that.. (or
> maybe motivate someone to do that instead of me ;))

Have we considered using the .. prompt:: extension ?

https://pypi.org/project/sphinx-prompt/

The prompt extension automatically adds a prompt (like $) in front of
each line and disallows copying it when copying from the html generated pag=
e.

>
>
>> - It doesn't build for me:
>>=20
>>   BINMAN  .binman_stamp
>> Image 'ti-dm' is missing external blobs and is non-functional: blob-ext
>>=20
>> /binman/ti-dm/blob-ext (ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip=
.xer5f):
>>    Missing blob
>>=20
>> Some images are invalid
>> make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefi=
le:1115:
>> .binman_stamp] Error 103
>> make[1]: Leaving directory '/tmp/b/play'
>> make: *** [Makefile:177: sub-make] Error 2
>
>
> ^^ Neha: This is what I was complaining about.
>
> https://u-boot.readthedocs.io/en/latest/board/ti/am62x_sk.html?highlight=
=3Dam62#sources
>
> source: https://git.ti.com/git/processor-firmware/ti-linux-firmware.git
> is missing, we never used to break build previously binman converted now =
does.
>
> I am wondering if I need to explicitly call out git clone instructions
> out..
>
> --=20
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D
