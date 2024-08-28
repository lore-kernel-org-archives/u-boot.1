Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B779C5B54A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 15:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4032F8890A;
	Wed, 28 Aug 2024 17:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TJAUdK+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8E288703; Wed, 28 Aug 2024 17:31:29 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685D1885A0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 17:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c0a9ae3665so4001057a12.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724859087; x=1725463887; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYGv+HVwwPoKCQ2FAeNmRsQdVVDK8LMblAefUUvY7gs=;
 b=TJAUdK+hO0uQ6RU3vXFV+ELzpncM6szdjf3kRjb0Cp4GM/sAazuD30qGZEHw05unaR
 NHLgSWaD4nqQg7TeNXxWJBbP3diS7svmevUKW9QtGxw3A2V/bm5O6P9flwdHnrn+eX8h
 hI+W8ibtkM8RISQ15zgGTfj91JF8jyWCvFWWdZZLgrH7GeFq9EkBDryOPexHXm1pbyRi
 S5IEqa6JiqCEXSQjgS8Jt8HzrY9RdIcdh/TjNfkDDqF3E6xexXt/ILYBRER0mbwDHlBX
 RfzRX5c86Bwzm/m5evqsAFd4958/YLWqgsQa6bdsnnv3a/VG+jRQuaMIHXB9Tfdpv3DI
 p9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724859087; x=1725463887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYGv+HVwwPoKCQ2FAeNmRsQdVVDK8LMblAefUUvY7gs=;
 b=tHCxgFHm9wBpNIt2AI33E7oWSg8w6z+4CHzhhn4UKrtWLHVPRMH3ouBdXOPIphZked
 4esjewGI37oCyU0fPSx2YDqjGDkMdeK4kSaMr83HPRkRhZ68eAXCXsf4GdaRYGpV3Vmi
 o4vpsFVIaPym1I9cG+N5M69xYf7O4jpNzau5Lo4eEdPyk6jRgUhy0yATlVV2juq8gJaM
 5EiuNawe0/ZI/ZC9uVvWJ0kqA5Cj2eeqO2Eb+EY3aomUzexLShwNFwqktpZ4TsZci5jk
 TwtwW6GJ5E7dra1UZhjIRanYveMGb3nIaP8yJ1OtwEkatsJ3FddpqLk8h4AEtDrCPxYC
 Scog==
X-Gm-Message-State: AOJu0YzvCwotxXxFaXt3p/u2oyb917+EzT8AxLCXc2quNMbeQrzXTiXe
 htPR43a2NCuaeJSeRv3nbR/UAiGcyDwCU8DZNNh3vuYi5ay8ACUbOfq1D/ovJ3iA6l/oATcRx+T
 ZMbVVuoayExys1bNIZD8/qS1sv5o=
X-Google-Smtp-Source: AGHT+IHChGZhn/V4QHSR2Zl4ykhDFuw8kpI1gN0BXBLSxomPwoMpWQt7+E5lmR4dYrWkNCDPKLk0IGCJXcojvtyeVZA=
X-Received: by 2002:a05:6402:270b:b0:5be:fd66:edf3 with SMTP id
 4fb4d7f45d1cf-5c21448623amr1747699a12.18.1724859086220; Wed, 28 Aug 2024
 08:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHseuWCmRF2HsVJ3RbK49aKwB6rbrHwPAOX10caJWQhLtFo1Zw@mail.gmail.com>
 <CAHseuWBeMu2kgKNQHc4OWa6Au0mAry_j4N5CVy4qWaSr3JUouA@mail.gmail.com>
In-Reply-To: <CAHseuWBeMu2kgKNQHc4OWa6Au0mAry_j4N5CVy4qWaSr3JUouA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 28 Aug 2024 16:31:14 +0100
Message-ID: <CALeDE9NuRLfeDfPusTTxnWkz6HyRGUFOhuL710BRe6EybWHdfQ@mail.gmail.com>
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

Hi,

I appear to have missed the first post.

> Is there any update on the below request? Are there any functions similar
> to eth_get_ethaddr() to retrieve device-specific info? I am working with
> raspberry pi 0 and there is no network interface card.
> So, eth_get_ethaddr() returns null

So there's a bunch of drivers for OTP/eFuses in drivers/misc/* which
provide access to those sort of unique options such as CPU serial
numbers, and possibly stored MACs etc.

I know the RPi has a OTP/eFUSE HW IP block, I don't believe U-Boot has
a driver for that as yet.
The main RPi firmware may have an mbox/API for querying those sorts of
things, looking at board/raspberrypi/rpi/rpi.c there's a
set_usbethaddr which calls a msg_get_mac_address to request a MAC from
the RPi firmware, I suspect that may work for your needs.

Peter

> Thanks in advance
>
> On Wed, Jun 19, 2024 at 9:11=E2=80=AFAM Sourabh Hegde Ramu <hrsourabh1107=
@gmail.com>
> wrote:
>
> > Hello,
> >
> > Currently, I am using the MAC address from eth_get_ethaddr() function t=
o
> > calculate a hash value. But, I would like to replace this with a more
> > unique device info such as cpuid or other values. But I could not find =
any
> > function that can retrieve cpu info.
> >
> > Can anyone please point me in the correct direction? Do we have any
> > functions for this? Are these things part of the documentation?
> >
> > Thanks in advance.
> >
> > Kind regards,
> > Sourabh
> >
