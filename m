Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7F0C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 12:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00C1E875EB;
	Wed,  3 Jan 2024 13:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CioSbTkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D710387661; Wed,  3 Jan 2024 13:41:45 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C70F87516
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 13:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d41555f9dso105055965e9.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 04:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704285703; x=1704890503;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=64OK9B4RlnKch4oYUUbGmsB30a2mwA4DZacMOjA6svk=;
 b=CioSbTkOBXUhc7UZ2dpzBQWksl+1x1O0lIuzveGRZxGjc33G4GSXCzZQjfoWge4gE0
 kcAicw5GpJOSiz8yiLFrdOfX4PRNXfO5H0exOvpcvhmPysRgD9cn/uTPgO74DHKWngL9
 LRH9xUPCuRso+ZWQL1v4YPq64sNeOlFaq5emgZINzbnaEfKYumDmHt72aLYXOrH5oi2u
 VMoXcdq4mU8vjaH8h+hp6Ovv7FXCPYa9ndAMMVQTYBzyNMHjCrW3AFu8MSxIf+vmqWP2
 EBOq57Wn4C6BFwWiG/9psx5TNK7aPj56EDc1EnQ8SiqafoNumhMZsJKfNqr1dV4R4CLV
 muew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704285703; x=1704890503;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64OK9B4RlnKch4oYUUbGmsB30a2mwA4DZacMOjA6svk=;
 b=dbpVe7J0iz1kkLE3Sf9hCQ80HaHWsOn5oERBaIguViw/OfBnz6PWTt75Wn0lGGWNJQ
 +u33mJFe0jaNcruoca7R+l+4iSvIGg2XoKX58N864VSSk/939ARwAKdKHHcVei751wTU
 QvzimDlozkEwr6CbKQ0VgyBEACSHKltMpGFqxcsrVqDRO5yncZ0x/JexvqCG9FygdoKW
 pNjrRaPtWn5Vpb9HywO3gwrfG6DscgFDg4AK2ZO3dhGiQkDu/ILVk9tG1xBlv0pP16Pp
 E2gKRvmNc/Cu5A0D3Rz2Sp8G0UAvWDtzVQFJkZOuoa+Qd1crwJS/VddJ+Z6slw4Zs5oK
 36Zg==
X-Gm-Message-State: AOJu0Yxbsboqs48x2MP7wAd7n2j5ocBcV9x4CB1/Y8VZIEHIXJ5A0dc3
 aS74ZSfmXd4qusGb5cufohtQFZ791X7vtg==
X-Google-Smtp-Source: AGHT+IEyHb1mHzvNkj06ucV7tWmIFIJ6722hBCV3wccYLFgUjejp2iIisfR2i0frYqkFlP8kF7R54g==
X-Received: by 2002:a05:600c:3411:b0:40c:7103:d9c6 with SMTP id
 y17-20020a05600c341100b0040c7103d9c6mr10564262wmp.183.1704285702570; 
 Wed, 03 Jan 2024 04:41:42 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a05600c199000b0040d5fcaefcesm2186462wmq.19.2024.01.03.04.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 04:41:42 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>, Ion
 Agorria <ion@agorria.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, Heiko
 Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v6 4/6] common: console: record console from the beginning
In-Reply-To: <CAFLszTjmvpbxGguK+FuXZLO=kpYR4pVr4E27BGn1u0B-6uB2eQ@mail.gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
 <20231228180154.50473-5-clamor95@gmail.com>
 <CAFLszThd95iSPMOBr_21_Zckg74BtgA23EVpfXQKqnArFc-UDQ@mail.gmail.com>
 <CAPVz0n3OwhrW41tV9x32UXyL6yZdLr8CU9S7XuTneDiwUQY7AQ@mail.gmail.com>
 <8734vg5afv.fsf@baylibre.com>
 <CAFLszTjmvpbxGguK+FuXZLO=kpYR4pVr4E27BGn1u0B-6uB2eQ@mail.gmail.com>
Date: Wed, 03 Jan 2024 13:41:41 +0100
Message-ID: <87le964mii.fsf@baylibre.com>
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

Hi Simon,

On Tue, Jan 02, 2024 at 07:06, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On Tue, Jan 2, 2024 at 2:52=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Simon, Svyatoslav,
>>
>> On Thu, Dec 28, 2023 at 21:52, Svyatoslav Ryhel <clamor95@gmail.com> wro=
te:
>>
>> > =D1=87=D1=82, 28 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE=
 21:48 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>> >>
>> >> On Thu, Dec 28, 2023 at 6:02=E2=80=AFPM Svyatoslav Ryhel <clamor95@gm=
ail.com> wrote:
>> >> >
>> >> > From: Ion Agorria <ion@agorria.com>
>> >> >
>> >> > Set flag to enable console record on console_record_init
>> >> > and not only on console_record_reset_enable. This fixes
>> >> > missing start of U-Boot log for fastboot oem console
>> >> > command.
>> >> >
>> >> > Signed-off-by: Ion Agorria <ion@agorria.com>
>> >> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> >> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> >> > ---
>> >> >  common/console.c | 3 +++
>> >> >  1 file changed, 3 insertions(+)
>> >>
>> >> Reviewed-by: Simon Glass <sjg@chromium.org>
>> >>
>> >> OK, I can see the use of this...but I wonder if we can now get rid of
>> >> the same line of code from console_record_reset_enable() ?
>> >>
>> >
>> > Interesting question but let's leave it to a dedicated patch :)
>>
>> I've looked a little more into to this, and I'm not so sure we can get
>> rid of the gd->flags |=3D GD_FLG_RECORD; in console_record_reset_enable(=
).
>>
>> Removing the flag seems to break quite some tests in
>> test/py/tests/test_ut.py.
>>
>> The breakage can be explained that various unit tests clear the
>> GD_FLG_RECORD with:
>>
>>         gd->flags &=3D ~GD_FLG_RECORD;
>>
>> Therefore, I would suggest we keep the flag in
>> console_record_reset_enable().
>
> From my look all of those are not needed in tests, i.e. are bugs. If
> you are able to do a patch to remove those lines, it would avoid the
> confusion.

With gd->flags |=3D GD_FLG_RECORD removed from
console_record_reset_enable(),

When I run:
$ ./test/py/test.py --bd sandbox --build -k ut

It produces this list of the the tests that fail:
https://paste.debian.net/1302906/

I can also reproduce individually with a bootflow test, for example:
$ ./test/py/test.py --bd sandbox --build -k ut_bootstd_bootflow_cmd_boot

Produces:
https://paste.debian.net/1302907/

I did not investigate more on detail but it seems not trivial to me.

I can continue the investigation in the coming weeks but I would like
to apply this series this week.

>
> Also, by setting UT_TESTF_CONSOLE_REC for a test, console recording is
> set up automatically, so the console_record_reset_enable() is not
> needed at the start of the test.

I was not aware of that, thank you.

>
> Regards,
> Simon
