Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B95C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6699586DD1;
	Mon, 15 Jan 2024 10:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Gx5kKBE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89E15865D0; Mon, 15 Jan 2024 10:44:09 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A9ED86D9E
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-db3fa47c2f7so6895699276.0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 01:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705311846; x=1705916646;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRoGWt5fYDu3ZDMTVp7td0DY++DBAhdhZDhWkqN/5K0=;
 b=Gx5kKBE04eTMmSaTH1r/6KUFLXgBWjY8GxGR85c1R6/F4OsFO9Nc2NDVZcrHBGmsui
 Wp1+xigAflAKzAymf0i4u5a4ElOay6aP87Wesi0ZiwcS1jz950KT1pEnQgJKkbvlxKah
 cGU4sSlHH2fyJ7gLKTZSn9RMhT9PnAW26jJ1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705311846; x=1705916646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRoGWt5fYDu3ZDMTVp7td0DY++DBAhdhZDhWkqN/5K0=;
 b=QhmWYeK5ls+Yabidnx3CSnxBjQsDrINIYfgO2jvt8weq/tS7fcUo2Lb3X0L+CQz+Zd
 RVgpJfyKGhRApcBDXiS37J6hpl9xF4LqWQEz5oA4NcuI/9KzeK031lP/Q6oS+qkI1arw
 Ag/YlxzJomdm4mUXW5vkCWvyDbE3Q45BhUdIePWN6M1+oiQ2VyEeb80a7NXav07w5NV5
 2uoDtPu8AIuLEb4kdsT/OvzAX2iFeYqNPJthq1LEf4DDjMyAYqwycbdslpLYUtRGcljq
 fIIl7lwaY2QYNedzT2ee1vj730LRK6U9n9iTf3faEeKrRscVdyC/6ryXArfhCSRjZCDB
 c8/Q==
X-Gm-Message-State: AOJu0YycWyV/rBLaZbAYEH1zVmNUwFbsX3iSQ5LDm/sbybVGgXrkAx0j
 7ZGUOTR0sytpIp6KKt+CAhm5thKy+IWnSL8JsD8bCfPKmmSAEw==
X-Google-Smtp-Source: AGHT+IEDV7gUWL7beWZ3oK74Q3b9/5/9O4+wqAqIpq3JP4W9TkTzXKU9z2/my/kNZnDOsOBIL26UnjKKgpfmZDt7sU8=
X-Received: by 2002:a25:13c4:0:b0:dbf:67f0:efd1 with SMTP id
 187-20020a2513c4000000b00dbf67f0efd1mr929111ybt.45.1705311845886; Mon, 15 Jan
 2024 01:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20231211114600.4414-1-rogerq@kernel.org>
 <5d79b1c8-4dc8-44d3-bfe7-4514f41c7102@kernel.org>
 <CAOf5uwn6Q24OcrwHBEbSJhvkX2MV46ea+EZa7yOBDN6WZrw5Dw@mail.gmail.com>
In-Reply-To: <CAOf5uwn6Q24OcrwHBEbSJhvkX2MV46ea+EZa7yOBDN6WZrw5Dw@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 15 Jan 2024 10:43:55 +0100
Message-ID: <CABGWkvptPdusNjWYSGYUBgWiuOw2TeJFq4Jata1bE_kF+nMyQw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mtd: nand: omap_gpmc: Fix NAND for AM335x
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Roger Quadros <rogerq@kernel.org>, Heiko Schocher <hs@denx.de>, 
 "Leto, Enrico" <enrico.leto@siemens.com>, Tom Rini <trini@konsulko.com>, 
 "Bajjuri, Praneeth" <praneeth@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh R <vigneshr@ti.com>, U-Boot-Denx <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Roger And Michael,

On Thu, Jan 11, 2024 at 2:13=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> Il gio 11 gen 2024, 14:06 Roger Quadros <rogerq@kernel.org> ha scritto:
>>
>> Hi,
>>
>> On 11/12/2023 13:45, Roger Quadros wrote:
>> > Hi,
>> >
>> > These patches fix NAND and ELM for AM335x and related legacy platforms
>> > that use HW BCH and ELM modules.
>> >
>> > All CI tests pass: https://github.com/u-boot/u-boot/pull/453
>> >
>> > Changelog:
>> >
>> > v2:
>> > - added __maybe_unused to omap_calculate_ecc_bch. fixes CI tests
>> > - Added Tested-by Tags
>> > - Explained about omap_elm single sector support in commit log
>> >
>> > cheers,
>> > -roger
>> >
>> > Roger Quadros (2):
>> >   mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
>> >   mtd: rawnand: omap_elm: Fix elm_init definition
>> >
>> >  drivers/mtd/nand/raw/omap_elm.c  |  4 +-
>> >  drivers/mtd/nand/raw/omap_elm.h  |  6 --
>> >  drivers/mtd/nand/raw/omap_gpmc.c | 95 ++++++++++---------------------=
-
>> >  3 files changed, 31 insertions(+), 74 deletions(-)
>> >
>> >
>> > base-commit: 2f0282922b2c458eea7f85c500a948a587437b63
>>
>> If no objections can this be Acked and picked up please?
>> Without these NAND is broken on some TI platforms.
>
>
>
> We will queue them and send over the weekend
>
> Michael
>>
>>
>>
>>
>> Thanks!
>>
>> --
>> cheers,
>> -roger


Applied to nand-next.

Thanks and regards,
Dario
--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
