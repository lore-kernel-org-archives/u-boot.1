Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E418D0D798
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E4F08931F;
	Fri, 11 Oct 2024 16:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y69DdIts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA8A8890FD; Fri, 11 Oct 2024 16:22:50 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997F689322
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fac3f1287bso21627571fa.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728656568; x=1729261368;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bcOy+r/FU3kTGcYOGg4ThM0yvBHKqMIQKZkZP3gB81Y=;
 b=Y69DdItsw4I6sc/Oyz+uW0Te35/+r8rJ0ABsgfxsnFMFoVve32/prEylhVVWQzS8Zx
 uHCW6GA8BXzDYNsn+3pvzqsc6z4p7MpLX4CH851Lv7XKifMEYdigW8gA8MKpCU0kxTVh
 H6+w0HBkEsQM4hsCFjBBAjM2g8VpfnnK9yvBeXoy1UtRSxTP9w+UaUUx+0ULdwuKJm/6
 ZwcL2BJ+GzEA5nh1nq/HBhYSG5oGThp5Lwvv6fEG7Vg7+tK+k4wQn5OVL5QMMMM+CIMg
 SHqW++wrxV/w8fE0H2Cj0W+SRGeFIe4w+E19D6ftTTMBtE++Wf02m+A2Vh/B0W4C/LQn
 Iahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728656568; x=1729261368;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bcOy+r/FU3kTGcYOGg4ThM0yvBHKqMIQKZkZP3gB81Y=;
 b=GbY9rAY1l/XUdnQvxyC1WWhvdyhPo1U/RR/zuCchw+0L7tMzg8JUoFF5fsQlhftbjZ
 nKQdTFNr9CT/o9FU3LvzYvLM8EhwnrLpF40GgSkzF6nAPhBOngsqts0zMT2tMcF5e4SZ
 vuID3JSRPUGJbRgOBuR0jbiqDvm/KoE704KqV4/UEAagsNB6hj0oB18fC64uOD+QkVr7
 ccB52Yz9j2zAtEeKQVvdDcTeZtD0HHLWHcp6yFxSTC4JJKLEDBm9OdUkkvYNFtQxUzZm
 HOzJTHJIkfF4ilK8LUF7ZI0Ha0JJr6W0rboFFyatvBiW8Vgi+ZZ4EjWAXDeyQBc1zSAw
 LXJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFGer3sPfJQuDSwHSy8CyfJ6YbHNNpnsq03UqvFKzgP1bnlM1WK7450qX3ddQbSOJ3wPqCqYI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzhle3F+Pnxj4WzLZOsCcwmQTqO59olMavMxl+vQKlPuEUqG8oA
 vzoYleofsOUumxa6kiBQBlRJg+LtlepwfZ++ZRNxR4nYNzvRCgygRma7bZbce2Y=
X-Google-Smtp-Source: AGHT+IEig3YDLAB+pmbd/bzp+9P6x79a1HR0H1FNpDT5lqV89jsB9J1lPGvFz5zzNnzE+qpYKFMeYQ==
X-Received: by 2002:a05:651c:551:b0:2fa:c841:af36 with SMTP id
 38308e7fff4ca-2fb327b0ff0mr17174111fa.30.1728656567556; 
 Fri, 11 Oct 2024 07:22:47 -0700 (PDT)
Received: from localhost ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6d0071sm4022185f8f.62.2024.10.11.07.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:22:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com,
 kernel@salutedevices.com
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <17FD1697482D61A4.19251@groups.io>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
 <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
 <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
 <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
 <20241010102051.q67usj6oaykjaixx@CAB-WSD-L081021>
 <17FD1697482D61A4.19251@groups.io>
Date: Fri, 11 Oct 2024 16:22:43 +0200
Message-ID: <87bjzqhg7g.fsf@baylibre.com>
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

On jeu., oct. 10, 2024 at 14:17, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:

[...]

>>> > >
>>> > > Reviewed-by: Simon Glass <sjg@chromium.org>
>>> > >
>>> > > Can you also update the test?
>>> >
>>> > I apologize, but I didn't quite understand your point. Could you please
>>> > clarify? This patch series includes additional tests for the 'ab_dump'
>>> > subcommand. For more details, please refer to:
>>> >
>>> > https://lore.kernel.org/all/20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com/
>>> 
>>> OK, thank you. Sometimes it is easier (for reviewers) if you update
>>> the test in the same commit.
>>
>> Should I resend the patch series with ab_dump implementation and tests
>> in the same commit?
>>
>> I can prepare new version, if needed, no problem.
>
> No need to resend a new version just for this, since it's already
> been reviewed.
>
> Keep the suggestion in mind for future series!

If you do need to re-spin this as v4, you can squash the test commit
with this one if you wish.

>
>>
>> -- 
>> Thank you,
>> Dmitry
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2438): https://groups.io/g/u-boot-amlogic/message/2438
> Mute This Topic: https://groups.io/mt/108927502/1991006
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-
