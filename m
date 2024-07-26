Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C31BC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 17:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A67F87CF8;
	Fri, 26 Jul 2024 19:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="difV3oHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF1087702; Fri, 26 Jul 2024 19:40:15 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF3087B84
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 19:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-66ca5e8cc51so28034347b3.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722015611; x=1722620411; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54aK1PmjZaqc5lexgAQpIJeBNCDVf4khwNbmRFfrAr0=;
 b=difV3oHDwsgoaiC9B653gbiNvg1/KXgkYubpk9in4pi8zqAFGlfgip5VD7zIf8RSor
 IFP2QsgWJIaj79RuiVa8X1CR9JmTVog5tWTwyxAux1AUU3urBQiA+AiIOOsyuG/Lub8s
 hAYjSUFzJctik4CoKVER7ZxGk0pMS71uDKjecrvukPNVHu5/9NA+XdyIuerbAYgsVWF0
 FHWaAKMJwyYBpbrTR2zfVJOSU8JcyCs8cudaKG278VkNhQnD6PVo7TBGNlZN3kcP3tkU
 WQjQCD0ZaluUFmih7IXYxE34SRIQDg9FutXXFhRP9uVb7BNXkNJVdr6YrogafWDFLm/1
 lI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722015611; x=1722620411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54aK1PmjZaqc5lexgAQpIJeBNCDVf4khwNbmRFfrAr0=;
 b=bvYppt2zrBFdO0cnUxEJRmRmg7p+cqQ4bXSuZu6KJunL+rab/jgBHw49DGu0Fh+ewN
 ++iJXKj5KxQ3SowrYhtoz439O3ZNlWGtIRiGHln9F5TosT0MznHQfgJsJDVsJ3WPwUnz
 gqEtee6yHBQdTaUGtWOF2k+CJN8CGF+rottqhMDFsUY2wWoDCJGPw1zolceDQWIbMA+I
 niU9oONRTjMKt52djgnMVN7FVuaRxxF7PAPkKG+EofKMUrAIhnvVrn18rIB/RODdx6Ea
 ZxYpNLKIX/K+T7wwzfGcPiyMQYgm8vTzUW8Y+2VcOHmR0f9eF2LIVM2Lq25LcUNOrlVq
 TNIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg+mdrraEpzKC9YLAAPncoOt/FZEhp014BlD+tsbG82x5fIOi9Q6xSvRpanqNFDNKlqqzkeurls24DYSGzXzOM2Vrm2Q==
X-Gm-Message-State: AOJu0Ywanj9DU4N2s/tWm/gOtx4bU9LBlQVnaKIr+lqROs61me6J6xth
 2bbIf1qI0h9+PXUJ39hx6DtNnr7xrld+2LhUxDbhhsHA3yEv4eQ/jKQVds1t/vR6jjMLswCgj0o
 Krxh2RwVj7Ug3tmi0XLZsbRzMwuTUwvrbDr7C0w==
X-Google-Smtp-Source: AGHT+IE8BXN6+c9Yw71MXtaUDMcf6waeLBuS5cIrPjDJekijOs5PDtQo80MiZQAcJjXL9jAGNhH2wxIlcAEwzwd6Cr4=
X-Received: by 2002:a0d:fdc5:0:b0:664:80e0:ac7f with SMTP id
 00721157ae682-67a070cddb6mr6342077b3.19.1722015611255; Fri, 26 Jul 2024
 10:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
 <CAPLW+4=xXM8m7y030kcxTBwgLfm_cud8HYrwF0k75=GOg==zAg@mail.gmail.com>
 <CANAwSgSw3ZkZBaVeAUoj6hCtGoydEmMEoLBaEkU4JW586M5TEA@mail.gmail.com>
 <20240627144205.GB38804@bill-the-cat>
 <CAPLW+4m6SjAmDxQFBJhQwmGP-DOOPXipEY8n6CuWk81ZFZRbeg@mail.gmail.com>
 <CAOf5uwmy0DkjmPW_Nb3iP-3jLfgmtV0toPhFPM7=Zsi9h6RMBw@mail.gmail.com>
 <CAPLW+4kOEin1SJA=vat4fB-R4Am+mFX0S9awr=R+bM3nfrUR+w@mail.gmail.com>
 <CALrBrZ2WRiEOgjOxWVtTF104-V=XH6Q8FRTu9j8yDvFf9tS_4Q@mail.gmail.com>
In-Reply-To: <CALrBrZ2WRiEOgjOxWVtTF104-V=XH6Q8FRTu9j8yDvFf9tS_4Q@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jul 2024 12:40:00 -0500
Message-ID: <CAPLW+4m6+dbrGfqzt0dZUQk-m6ZETSHQLoYL9wzG7oeEv7UWjw@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mmc: dw_mmc: Enable eMMC on E850-96 board
To: Minkyu Kang <promsoft@gmail.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, Yang Xiwen <forbidden405@outlook.com>, 
 uboot-snps-arc@synopsys.com
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

On Fri, Jul 26, 2024 at 12:27=E2=80=AFPM Minkyu Kang <promsoft@gmail.com> w=
rote:
>
> Hello,
>
>
> 2024=EB=85=84 7=EC=9B=94 26=EC=9D=BC (=EA=B8=88) 05:58, Sam Protsenko <se=
men.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> On Thu, Jul 25, 2024 at 1:25=E2=80=AFPM Michael Nazzareno Trimarchi
>> <michael@amarulasolutions.com> wrote:
>> >
>> > Hi all
>> >
>> > Il mar 9 lug 2024, 02:48 Sam Protsenko <semen.protsenko@linaro.org> ha=
 scritto:
>> >>
>> >> On Thu, Jun 27, 2024 at 9:42=E2=80=AFAM Tom Rini <trini@konsulko.com>=
 wrote:
>> >> >
>> >> > On Wed, Jun 26, 2024 at 10:12:12PM +0530, Anand Moon wrote:
>> >> > > Hi Sam,
>> >> > >
>> >> > > On Wed, 19 Jun 2024 at 02:26, Sam Protsenko <semen.protsenko@lina=
ro.org> wrote:
>> >> > > >
>> >> > > > If there are no new comments on this series, can you please app=
ly it?
>> >> > > >
>> >> > > > Thanks!
>> >> > >
>> >> > > Tested on Odroid XU4 and Odrroid U3 boards
>> >> > >
>> >> > > Please add my
>> >> > >
>> >> > > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
>> >> > > Tested-by: Anand Moon <linux.amoon@gmail.com>
>> >> >
>> >> > Thanks, Minkyu will you be able to pick these up (and other outstan=
ding
>> >> > patches) for a pull request to -next soon?
>> >> >
>> >>
>> >> Hi Minkyu,
>> >>
>> >> Gentle nudge :) Could you please apply this series? I'm working on
>> >> some other features requiring eMMC enabled, so it would be great to
>> >> have it merged soon.
>
>
> I'll check at next week.
>

Thank you, Minkyu! You probably already saw it, but letting you know
just in case: I submitted v4 for this series yesterday [1]. It should
apply cleanly on current U-Boot/master.

[1] https://lists.denx.de/pipermail/u-boot/2024-July/560057.html

>>
>> >
>> >
>> > I think that we should merge your clock patch. I will rethink my serie=
s and make a differente design but agree that 5 months are too much
>> >
>>
>> Thanks, Michael! Please let me know if you need any help with further cl=
k work.
>>
>> > Michael
>> >>
>> >>
>> >> Thanks!
>> >>
>> >> > --
>> >> > Tom
>
>
> Thanks.
> Minkyu Kang.
