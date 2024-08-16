Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6791DC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 01:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B6CC88A99;
	Fri, 16 Aug 2024 03:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GxlqvauH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399A988A54; Fri, 16 Aug 2024 03:34:48 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8946288A9F
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 03:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d1daa2577bso1129743a91.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 18:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723772082; x=1724376882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5qMpV+NFYfJS8Jo3cj4bwaHyhGUlye3p+leMkUOl6eI=;
 b=GxlqvauHNZ2WOZyJPmRZOS+lG1k7Y97xEJqdSA/HE7FVrF91M7Cd0JOhZTJWlkpxrv
 495Hs/MpS1dnM8xGgEkdD387agzRcjuWU0PygZSEFZHgIDqGsveGvmCkKNGrbRf6MLIm
 xSuZdYCIJh9JURgyd7+tRarUJc7vzyAOuYyhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723772082; x=1724376882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5qMpV+NFYfJS8Jo3cj4bwaHyhGUlye3p+leMkUOl6eI=;
 b=qPzNyJZKO9+BdquSr6LpmlCjTuU/wKdRPdsLMwZ1mpSlVSGuJsf2WmmSqktK6nK+RI
 IFg764EH1x+rea6YxfqLAtaNi/SV4Hcp30D8ik+8QPNRZwGIXKDVvTS3bCKzqdYXyE1c
 ozpaWU1vKrinmMOI+Fs9FtUmZamVCugDPHYX1M6ZRdj/t2PZkS4YyM7xP1834pd9+p9v
 ZZbjliQNB9OFiBrEyK6LRCyO2z7DCsShnMNOYSnxL7zMqFa7qMLhlTO+ed72TRRLkoZ6
 zFOSTcK1FCgDOZ3SqnZJm8vB5ilEbco8TQKjSdj/np/dWWbn2W2OnNQzA5lsnch43aNs
 s+qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiI8/yYfwLIc5dtsme8/5Via3QROqM7D3aFQVT7l8EfzlsKSOJ8K9OwnK85Kd0rkShEOnGH1U=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/HxzcqFW/+9r1Yf3EprfpSkP1cmgwkSTzzRgQ+YWdv/Ic8hhv
 y7HbT3OnrZo9Z6yxFjPbxXIaJE/yM251TNxDh4iAeP/W5cZ+pVDdB86XKnqQYx8kbiYsiNZokpL
 vQncxn7oMDLfnUlR9fE9MwU5Bld+GbIoZAmSB
X-Google-Smtp-Source: AGHT+IHwfwn6EAS9tYpexqkRQ5N23oULgGKbtpx0rP6QqN1SxEpPcfdLJ97WTq6y3dnxKdGOYlPAjIRnDZRFNuttFIo=
X-Received: by 2002:a17:90a:f16:b0:2c9:e44:fb98 with SMTP id
 98e67ed59e1d1-2d3e0870d16mr1620286a91.37.1723772082530; Thu, 15 Aug 2024
 18:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240814134518.82692-1-ilias.apalodimas@linaro.org>
 <CAFLszTjrBL-GonZKqp3Ab5vQPMZ+BZu8V21y4z0qBCGuH64uJw@mail.gmail.com>
 <CAC_iWjKF0DMfJza-ojYXPg_tHL14DTdK+GzhxhEX3etpaNiK8Q@mail.gmail.com>
In-Reply-To: <CAC_iWjKF0DMfJza-ojYXPg_tHL14DTdK+GzhxhEX3etpaNiK8Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 19:34:30 -0600
Message-ID: <CAFLszTjfhtRqRTdQOi-Dhzpa_aVSVSU8FjWmXEKz5vi=_0i=BA@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: clean up the efi configuration status
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Shengyu Qu <wiagn233@outlook.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Greg Malysa <greg.malysa@timesys.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Anand Moon <linux.amoon@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Thu, 15 Aug 2024 at 15:11, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
>
>
> On Thu, Aug 15, 2024, 23:33 Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Ilias,
>>
>> On Wed, 14 Aug 2024 at 07:45, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>> >
>> > The EFI_LOADER and EFI config options are randomly scattered under lib/
>> > making it cumbersome to navigate and enable options, unless you really
>> > know what you are doing. On top of that the existing options are in
>> > random order instead of a logical one.
>> >
>> > So let's move things around a bit and present two enties for the
>>
>> entries
>>
>> > EFI_LOADER and EFI options in the main config screen.
>> > While at it add menus for Capsules, Protocols, and Services in the
>> > EFI_LOADER so people can find their way around easier
>> >
>> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> > ---
>> >  Kconfig                |   4 +
>> >  lib/Kconfig            |   2 -
>> >  lib/efi/Kconfig        |   5 +
>> >  lib/efi_loader/Kconfig | 202 +++++++++++++++++++++++------------------
>> >  4 files changed, 123 insertions(+), 90 deletions(-)
>> >
>> > diff --git a/Kconfig b/Kconfig
>> > index 82df59f176ec..62c5441e3576 100644
>> > --- a/Kconfig
>> > +++ b/Kconfig
>> > @@ -756,3 +756,7 @@ source "lib/Kconfig"
>> >  source "test/Kconfig"
>> >
>> >  source "tools/Kconfig"
>> > +
>> > +source "lib/efi_loader/Kconfig"
>> > +
>>
>> This should be included from boot/Kconfig as it relates to booting.
>
>
> Hmm why? Booting is one of the things efi does. I prefer having it on the main menu since it's a pointer to the entire spec, protocols, services etc

True. From a functionality point of view, there is booting and
firmware update. Is there anything else? I have thought for a while
that we should perhaps have an 'update' menu. Where, for example,
would VBE fit in the menus?

>
>
>>
>> The EFI app thing should perhaps be under there too...I'm not sure.
>
>
> I was toying around with the idea as well. But eventually I decided this needs it's own entry since it's about building U-Boot as a pe/coff. I don't mind changing this though.

Yes, building as an app isn't really about booting. It looks very
lonely at the end of the menu, though.

Regards,
Simon

>
> Thanks
> Ilias
>>
>>
>> Regards,
>> Simon
