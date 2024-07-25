Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000DAC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B63188100;
	Thu, 25 Jul 2024 22:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d0fdltBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D1458839A; Thu, 25 Jul 2024 22:58:50 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62F068800C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e0b2d2e7dc9so1118768276.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721941127; x=1722545927; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNZV0bk+k2IlP2tV5DUc0OepkkZKFP7VUK7W7i31JgM=;
 b=d0fdltBerGj88lV+1YOtKXC5jMY4Atpsz2jeVA/fqHBXMWosSjfMKeL28LKBzCOb0Y
 lSqmTg0TdL2914QPs598eKAQdJgoeKzk2uHXX7fixGi+xKq3Empe6Yz4z1o71EaKtvnZ
 IPl0gD+r1ApdFfR2s5W/plIfGd30sQ2nrwI5Bp93W6kbyOm2p9I7QHmBhWC5bmXa3g4r
 DAVGA4y8OZdJ9tImGyhOdZfwzM4EpTyr84RXdZoty7wTe+D5BK+IJmKV4vJsKxkMxPuu
 tCTBcKjzbOsv4P7d9YdB3HGKZ1cnMTeywTKXZueKvyDwkaMd32gmLsJj62BwdqbAqNXc
 /TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721941127; x=1722545927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNZV0bk+k2IlP2tV5DUc0OepkkZKFP7VUK7W7i31JgM=;
 b=imFw6BBV9v40jmBudoB8heGFfXAd/jdM9LpDKoaOMd4IAfwdhXloSSbM/ReEChPIpF
 iOjcQd+VkrdYts2pHHv/iuKkTMICvdtIIzBEuTnPepDmzveoCytaUWmGaV4RshPLi4Di
 76JdQgo28tA711K7cF5nNfFYZ24cudFMqvIwk94WvcespB2ooD8kvXhkbljVYQbgFFOw
 cZujwzPbe2ZPRWTYXtU8JFivTbLjGcaD3lt5jCsaI0vzX6xCpY5+vXZq27rbzwNHNLX/
 +fGVHnRyO/0EmI9HRH+abpbXnYNnc7GUg0zP8ri5MTIIbZJPBaGUicKNvYESf2fVEUNq
 MkuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVph+6qCbm7Mn1/QFHF/cNu/3d5VOfsWbRgaNz7OgB0riepq4+Vpy5erDhyeBJBLpT0iYhKD8YHKFAz4DvnGX+z+33nwA==
X-Gm-Message-State: AOJu0Yymjdot76Ht8ojGqNNkGTGUFhH62leVNlMBsYE62V8hDA8UmNmk
 nnylOaQaquGPpZ87jjax4BH2obQZUKW0j//kxZ3Tae/j4dH+VKqtrEgAJoMqbwGSG8dnewXEXqV
 fbKXNc2p83OTEKBowX7pSgaIRNvo9WzCD7UQzQQ==
X-Google-Smtp-Source: AGHT+IFq/0S0SHSHGMcgo3PGEs5o0WFbSxeoRLFHxR8e/jXeVqKPkWDrRTWj/hrJOVp0OVgqpRYuEInPew9oKgOE+nQ=
X-Received: by 2002:a81:8805:0:b0:65f:e307:d41 with SMTP id
 00721157ae682-675114a7eebmr46999377b3.16.1721941127224; Thu, 25 Jul 2024
 13:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
 <CAPLW+4=xXM8m7y030kcxTBwgLfm_cud8HYrwF0k75=GOg==zAg@mail.gmail.com>
 <CANAwSgSw3ZkZBaVeAUoj6hCtGoydEmMEoLBaEkU4JW586M5TEA@mail.gmail.com>
 <20240627144205.GB38804@bill-the-cat>
 <CAPLW+4m6SjAmDxQFBJhQwmGP-DOOPXipEY8n6CuWk81ZFZRbeg@mail.gmail.com>
 <CAOf5uwmy0DkjmPW_Nb3iP-3jLfgmtV0toPhFPM7=Zsi9h6RMBw@mail.gmail.com>
In-Reply-To: <CAOf5uwmy0DkjmPW_Nb3iP-3jLfgmtV0toPhFPM7=Zsi9h6RMBw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jul 2024 15:58:36 -0500
Message-ID: <CAPLW+4kOEin1SJA=vat4fB-R4Am+mFX0S9awr=R+bM3nfrUR+w@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mmc: dw_mmc: Enable eMMC on E850-96 board
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, uboot-snps-arc@synopsys.com, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Thu, Jul 25, 2024 at 1:25=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi all
>
> Il mar 9 lug 2024, 02:48 Sam Protsenko <semen.protsenko@linaro.org> ha sc=
ritto:
>>
>> On Thu, Jun 27, 2024 at 9:42=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
>> >
>> > On Wed, Jun 26, 2024 at 10:12:12PM +0530, Anand Moon wrote:
>> > > Hi Sam,
>> > >
>> > > On Wed, 19 Jun 2024 at 02:26, Sam Protsenko <semen.protsenko@linaro.=
org> wrote:
>> > > >
>> > > > If there are no new comments on this series, can you please apply =
it?
>> > > >
>> > > > Thanks!
>> > >
>> > > Tested on Odroid XU4 and Odrroid U3 boards
>> > >
>> > > Please add my
>> > >
>> > > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
>> > > Tested-by: Anand Moon <linux.amoon@gmail.com>
>> >
>> > Thanks, Minkyu will you be able to pick these up (and other outstandin=
g
>> > patches) for a pull request to -next soon?
>> >
>>
>> Hi Minkyu,
>>
>> Gentle nudge :) Could you please apply this series? I'm working on
>> some other features requiring eMMC enabled, so it would be great to
>> have it merged soon.
>
>
> I think that we should merge your clock patch. I will rethink my series a=
nd make a differente design but agree that 5 months are too much
>

Thanks, Michael! Please let me know if you need any help with further clk w=
ork.

> Michael
>>
>>
>> Thanks!
>>
>> > --
>> > Tom
