Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85B2CF11DA
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 12:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F3588C98;
	Thu, 10 Oct 2024 14:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jwxtye9m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A33588CA1; Thu, 10 Oct 2024 14:17:51 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11CA888C63
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 14:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4311695c6c2so5683165e9.1
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728562668; x=1729167468;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yct/5vTfEK0KbuV0R39yqWSGgpQy682lpprL4gUtnyM=;
 b=jwxtye9mpv3Tq0qevVj+TAyhcEAyYTriXHFBfAVjoaLFOxfITAPWPlA00rqwg4RpV0
 OJT5iI0+lRrE9x4BiCXGDn4GSkR6/mWHeT2wXOMR0S6rsaKu+miMZNDGFb7/zfwac/7v
 a+2XQKDqXb996emMiQKgG44e3vaZU7r0NgFcsa9Fg6G8/4x37vt4YHgb+zaGbEzQMWJG
 b1BYN4sSoLvZQltKPQt4Gu6BFVVrWBCH0OtJ4Kj43Ib3rNCN+nntYa58o++qYxZeL/6A
 tU3Bn14a6CQf/xg0SC96D+8+yGspDcF7kQY3c/5G1jWjby+bNDbnKAAaMkwfqSFbT+qr
 cuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728562668; x=1729167468;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yct/5vTfEK0KbuV0R39yqWSGgpQy682lpprL4gUtnyM=;
 b=UjVeNS2/fxrk4PlqUyNHF+WReiOSsc5WF4mCDOwImAL2pHwWVNge9Ax0eNffesfYzE
 zpPqqVAx8ycQ4/Pa6M7/fzXEk+ViWWJA50YEuCF9K8LJHZBnQl73cc5AUX/hGZzas4M8
 2THs8CvdAyXxF3KjB8toYR4QUJWhQ2EBTFVOusCA57eFZp14NbUe0BgkVr/eoHSql9po
 mRBRTND7xqV+QMEHySJvYp4mRYa1C6Un2cwSdhGu3vNiplOoXSFswko4EUNl6IMAPuTr
 1qkGoAu1qdoMvR53RgAq4m404DPr8ITUt6L9PKbTpuKTzI9aOxOrangjk25RCp/JVrtR
 6iIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn7tzp3pOhDTYJqzIWFaoHaWYzih5XvtthhVQDb304lUbguJXYjNQaBCjXHaEJTd7lTWUKwLA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2LjYb7Q18RJ6QDA61Bub1XxhkVC8+W4YVMZJMSC4fHymOuEoF
 ssJ9ogc+/tulFhZ/MpWc2h2BhuOPE1TofqPkf/Ld9BqWUssq0k/PAmhhReVYv0k=
X-Google-Smtp-Source: AGHT+IECXvqbNp7uku69+CANRCG2CY3TCHqI7JQuc+QtLMQlZIODyZ1EqzstcNY7XENW/ve/OTmaaw==
X-Received: by 2002:a05:600c:1c14:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-430d70b3f8dmr44462405e9.33.1728562668359; 
 Thu, 10 Oct 2024 05:17:48 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431182d7929sm14982945e9.4.2024.10.10.05.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 05:17:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Simon Glass
 <sjg@chromium.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <20241010102051.q67usj6oaykjaixx@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
 <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
 <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
 <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
 <20241010102051.q67usj6oaykjaixx@CAB-WSD-L081021>
Date: Thu, 10 Oct 2024 14:17:47 +0200
Message-ID: <87set49mok.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dmitry,

On jeu., oct. 10, 2024 at 13:20, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> On Wed, Oct 09, 2024 at 03:13:57PM -0600, Simon Glass wrote:
>> Hi Dmitry,
>> 
>> On Wed, 9 Oct 2024 at 07:26, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>> >
>> > Hello Simon,
>> >
>> > On Tue, Oct 08, 2024 at 07:57:15PM -0600, Simon Glass wrote:
>> > > On Tue, 8 Oct 2024 at 14:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>> > > >
>> > > > It's really helpful to have the ability to dump BCB block for debugging
>> > > > A/B logic on the board supported this partition schema.
>> > > >
>> > > > Command 'bcb ab_dump' prints all fields of bootloader_control struct
>> > > > including slot_metadata for all presented slots.
>> > > >
>> > > > Output example:
>> > > > =====
>> > > > > board# bcb ab_dump ubi 0#misc
>> > > > > Read 512 bytes from volume misc to 000000000bf07580
>> > > > > Read 512 bytes from volume misc to 000000000bf42f40
>> > > > > Bootloader Control:       [misc]
>> > > > > Active Slot:              _a
>> > > > > Magic Number:             0x42414342
>> > > > > Version:                  1
>> > > > > Number of Slots:          2
>> > > > > Recovery Tries Remaining: 0
>> > > > > CRC:                      0x2c8b50bc (Valid)
>> > > > >
>> > > > > Slot[0] Metadata:
>> > > > >       - Priority:         15
>> > > > >       - Tries Remaining:  0
>> > > > >       - Successful Boot:  1
>> > > > >       - Verity Corrupted: 0
>> > > > >
>> > > > > Slot[1] Metadata:
>> > > > >       - Priority:         14
>> > > > >       - Tries Remaining:  7
>> > > > >       - Successful Boot:  0
>> > > > >       - Verity Corrupted: 0
>> > > > ====
>> > > >
>> > > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> > > > ---
>> > > >  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>> > > >  cmd/bcb.c            | 35 +++++++++++++++++++++++++++
>> > > >  include/android_ab.h | 10 ++++++++
>> > > >  3 files changed, 113 insertions(+)
>> > > >
>> > >
>> > > Reviewed-by: Simon Glass <sjg@chromium.org>
>> > >
>> > > Can you also update the test?
>> >
>> > I apologize, but I didn't quite understand your point. Could you please
>> > clarify? This patch series includes additional tests for the 'ab_dump'
>> > subcommand. For more details, please refer to:
>> >
>> > https://lore.kernel.org/all/20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com/
>> 
>> OK, thank you. Sometimes it is easier (for reviewers) if you update
>> the test in the same commit.
>
> Should I resend the patch series with ab_dump implementation and tests
> in the same commit?
>
> I can prepare new version, if needed, no problem.

No need to resend a new version just for this, since it's already
been reviewed.

Keep the suggestion in mind for future series!

>
> -- 
> Thank you,
> Dmitry
