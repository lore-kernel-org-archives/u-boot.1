Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FF8C7EE3A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B8588950;
	Thu, 29 Aug 2024 10:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nqzPiHLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B36AE88AB2; Thu, 29 Aug 2024 10:05:33 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC49F888C1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5bf006f37daso624574a12.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724918731; x=1725523531; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXSsVw6XAKDl0AZseMEQcA9OdT9UpeU8eMplBhMyDfs=;
 b=nqzPiHLqJ5yx3oyZ0eQL1H40a/rO83LCJ2dk0kG+i5xNgZp61Y5SciWWzsnuafD49h
 XBgXfpHB7RBNEZJOL2hVdA/aapss3Ca+TAq/zzr6NP4Qr3MhZuse2y/F3Mj1eH6OOBd5
 444HoOWPJf1ytFgrjmgz37cFm5JPhslcOGBSp9dx7X+J010bjuUFPTCjfxGgo/N2QGR0
 c6Qsk5Ta/qviklKrphA6ijRTwRBIw6l+JUEB9/3uQ8Kl5731oAj8Hht+lKNwTHsfvlAg
 n2LVHEl06hwSMv7xCeOmuPTwpidS39GJsCCCxZ/biKDlboVKl2afi/QToFPpiOasURai
 OI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724918731; x=1725523531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXSsVw6XAKDl0AZseMEQcA9OdT9UpeU8eMplBhMyDfs=;
 b=o/kL1tQ32RGsES/uXtQOUqbrG1u1vueeuX1CZIkNf38YJBoCiKRM5uq0cKoyiLnNxI
 NJTGBqle0iHCbH/kWD+JxYRRNqMTu7Dm/ehS5sOc1cXXOZygsL6lz+rqz3hBlG2a3nUq
 XONaFmNE8eag1Ak9pzb4u0+BrBtHjKzeEeZ2yZ7O0lTlCtoFJCYbrxTiakyjcQCg4ZxA
 Xy3YlbbPvy+9jYdieQBX1SvFHGndPdEyuTvC+AQ71amX6FhxbdjVjvb+lvpdO94Rqdw7
 cTa07v7JI7EAiDI11LHDC4B8w3x1F8SwNlnW0IVhs5j+VHsw/m3croqFt9MowfNBMJ1G
 tmJA==
X-Gm-Message-State: AOJu0YxsHujQO+W2Jv738vMjrc7ApAPtSkyPdeV3VdZNny7wXU8vn1xG
 n4s0cNovEHEyDaYBpdLaEb1VH7AkwCr1H/RciHVIcqoqgMs86C3F8FkCtw1awEgB2mr+UvCpTv9
 r/5KewJilMx6wdg6Ri3x2ACKtv4PdoPvua78=
X-Google-Smtp-Source: AGHT+IGuJORLAyH9+oHGSfoAUtADas90cWQwNrmc9jahwu0vX4krT21uc1AeeR3fYf8KnTnOJvydfGF1HYIKfxbSjmM=
X-Received: by 2002:a05:6402:90c:b0:5be:ddbe:2798 with SMTP id
 4fb4d7f45d1cf-5c2201d2293mr1712704a12.18.1724918730710; Thu, 29 Aug 2024
 01:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHseuWCmRF2HsVJ3RbK49aKwB6rbrHwPAOX10caJWQhLtFo1Zw@mail.gmail.com>
 <CAHseuWBeMu2kgKNQHc4OWa6Au0mAry_j4N5CVy4qWaSr3JUouA@mail.gmail.com>
 <CALeDE9NuRLfeDfPusTTxnWkz6HyRGUFOhuL710BRe6EybWHdfQ@mail.gmail.com>
 <CAHseuWCP8jk=s7GH3w7KyzCrD=MbSqrgNFmKcb00-qRyvXv0rA@mail.gmail.com>
In-Reply-To: <CAHseuWCP8jk=s7GH3w7KyzCrD=MbSqrgNFmKcb00-qRyvXv0rA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 Aug 2024 09:05:19 +0100
Message-ID: <CALeDE9PtZ3cfKW-XDm52ALLDM-=97NMpXd5NQCfLz4wz7FgqyA@mail.gmail.com>
Subject: Re: How to retrieve cpu info from u-boot fucntion?
To: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Sourabh,

> Thanks for the update. Looking at the board/raspberrypi/rpi/rpi.c I think=
 MAC address is only returned for models that have onboard ethernet. but fo=
r models raspberry pi 0w / pi 02w it might not return any value.
> Am I correct? (maybe I overlooked it?) Is there any other approach for th=
is?

TBH I have no idea, in a lot of cases the MACs are written to SoCs
long before they end up in a final product so they may well be there.

I have not tried, I was merely pointing out to you possible solutions
for you to try. I don't have the original pi0 but I also gave you
other possible ways to solve you're problem :)

> Thanks in advance
>
> On Wed, Aug 28, 2024 at 5:31=E2=80=AFPM Peter Robinson <pbrobinson@gmail.=
com> wrote:
>>
>> Hi,
>>
>> I appear to have missed the first post.
>>
>> > Is there any update on the below request? Are there any functions simi=
lar
>> > to eth_get_ethaddr() to retrieve device-specific info? I am working wi=
th
>> > raspberry pi 0 and there is no network interface card.
>> > So, eth_get_ethaddr() returns null
>>
>> So there's a bunch of drivers for OTP/eFuses in drivers/misc/* which
>> provide access to those sort of unique options such as CPU serial
>> numbers, and possibly stored MACs etc.
>>
>> I know the RPi has a OTP/eFUSE HW IP block, I don't believe U-Boot has
>> a driver for that as yet.
>> The main RPi firmware may have an mbox/API for querying those sorts of
>> things, looking at board/raspberrypi/rpi/rpi.c there's a
>> set_usbethaddr which calls a msg_get_mac_address to request a MAC from
>> the RPi firmware, I suspect that may work for your needs.
>>
>> Peter
>>
>> > Thanks in advance
>> >
>> > On Wed, Jun 19, 2024 at 9:11=E2=80=AFAM Sourabh Hegde Ramu <hrsourabh1=
107@gmail.com>
>> > wrote:
>> >
>> > > Hello,
>> > >
>> > > Currently, I am using the MAC address from eth_get_ethaddr() functio=
n to
>> > > calculate a hash value. But, I would like to replace this with a mor=
e
>> > > unique device info such as cpuid or other values. But I could not fi=
nd any
>> > > function that can retrieve cpu info.
>> > >
>> > > Can anyone please point me in the correct direction? Do we have any
>> > > functions for this? Are these things part of the documentation?
>> > >
>> > > Thanks in advance.
>> > >
>> > > Kind regards,
>> > > Sourabh
>> > >
