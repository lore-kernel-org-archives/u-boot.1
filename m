Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AF0C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81707820B7;
	Tue,  1 Apr 2025 14:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z0pG6kW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1AF281E5B; Tue,  1 Apr 2025 09:22:00 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91D3F817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e61375c108so6816835a12.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743492118; x=1744096918; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=asXpGxEhGSaT82Wjm6OmJfWRDAFHB+XTws2kHqY2g/E=;
 b=Z0pG6kW8ciujtUfb4W7kWb5nVasGzFhuqyhxsRycQDpwG7J2SmRTrPedLbqbq9in1N
 cUAYEVr4PM2A3+7zgjZwQMPV7VWaucSO0l+zIwmQQdF27PU1YovcF2QzwDRZ2d7gl3mZ
 BxRUz+U8QmIBanbzt1S9sj09ixZAhITSuT4Fx2HI4B7gzc0MN33H/fK+sjYS1VeIeVkv
 jH+dAhQX6vPqJTgyZTFnaWigILgiP6GWNyDWV4+MABdJsmiylqleeVcewYlLMmeXEbWl
 wrkHMA3Z5KzUkJj/ARPRN4/0WUzoXpRRnYYOKUagGUMkIcRBsbWYRFssj6v0FJR7fwX6
 PJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743492118; x=1744096918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=asXpGxEhGSaT82Wjm6OmJfWRDAFHB+XTws2kHqY2g/E=;
 b=db0XQmtdbiGZMWhqwnAyLeNqbNJtI5KFXbepcFWBfKgQpYB7dStaxOR8CbeDShNZ0m
 8xHoU63XAeQq8WpGEwrFxgc/zMeLPVAGJXD5uJQentdT50DCHq5FscpJi8gtaeuRDq58
 FiPN0nwxUJRNjhe5GxjPW34gWNUs1Ub5fWK0c+4pzP0tOU/k+hULqD2XB4nyW2qy+ICD
 G+WbSZkuKZz+7OE/1e43wZgTJN/g3PTimAn8HHMjhVRfYWel4kjRkzQwigLwG6q6lNUi
 XMKoAV0ws6LIjwRJJfBW3/AoecVF7Po+o1lOXGakhDH/y8CsiyYVtWqfDmuqracIJLw0
 FYxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVokAEkfREC3Kf7/sEOkUopylc29WMuzHGEzivjC81UxyjmUrgjVNLXnBJagsieLwsqggnQNuI=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ8G29BZdj57bDoEPj2lQe/Ta8E2LdLgoLdxzv4mHne6EUcDwc
 T0XYK94ngaHT2FmoEKzl6BlSr92MQBMsRRWdmqaPquaGMeO3Tii5ANXuFhqiEfjvkVzdTHmxxp0
 yvDbA8yLrI+5f/Ymdz2ikRrYxC8Q=
X-Gm-Gg: ASbGnctQC7Pka8x15pPOXqp1ZpLsNcD/kMUEeCmORZBPl/bkfZ5Hv5Kmuhu3gn1boNW
 JufoUhldsNZjB9pFwm3SScJ4yYaziuhAAefZe2PSjH1Nk/D9XqklmQSYgwY7hGf4JpZUdJQ6rT4
 KatMT5y9Fvlcxz812i+j2qxK5kTg==
X-Google-Smtp-Source: AGHT+IGcMjJ8VCbYAuZO4ciG0aKZn4aPDZIk+hKQwAUK41K0KO2Dys5KbilOSjkTf3qaDpMUV43WA5gjMHLSW27UKhg=
X-Received: by 2002:a05:6402:210e:b0:5e7:b081:e0d1 with SMTP id
 4fb4d7f45d1cf-5edfcc272d2mr10070366a12.3.1743492117814; Tue, 01 Apr 2025
 00:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250204172319.3361870-1-wens@kernel.org>
 <CANAwSgQTMBLW2Y5YHpoAYDtXHyAbD9-s8KpWU1zBTRAB=rsJow@mail.gmail.com>
 <97223c88-8f32-4cfd-8465-dd034f85f3a5@rock-chips.com>
 <CANAwSgQB9ZdsE9vh2jOCGsATsjAUSUZQAfftPp=VsrogazmdOw@mail.gmail.com>
In-Reply-To: <CANAwSgQB9ZdsE9vh2jOCGsATsjAUSUZQAfftPp=VsrogazmdOw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 1 Apr 2025 12:51:41 +0530
X-Gm-Features: AQ5f1Jom2zcRbx13o7eb6rkFDt3931_aS9zHHnNnUMxN3bkA1TJBBcYGCUEO1sE
Message-ID: <CANAwSgQS-ky7TF=k7OMOW4bQCJaozfYBjDS-5wXZ+3+3gU6crw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: io-domain: Enable by default for all supported
 SoCs
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de,
 Chen-Yu Tsai <wens@csie.org>, 
 Akash Gajjar <gajjar04akash@gmail.com>, Alexandre Vicenzi <linux@alxd.me>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Klaus Goger <klaus.goger@cherry.de>, Levin Du <djw@t-chip.com.cn>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Nick Xie <nick@khadas.com>, Paul Kocialkowski <paulk@sys-base.io>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Shantur Rathore <i@shantur.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>, 
 Xiaobo Tian <peterwillcn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 01 Apr 2025 14:32:32 +0200
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

Hi Kever,

On Tue, 1 Apr 2025 at 09:11, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Kever,
>
> On Tue, 1 Apr 2025 at 08:30, Kever Yang <kever.yang@rock-chips.com> wrote:
> >
> > Hi Anand,
> >
> > On 2025/3/30 21:33, Anand Moon wrote:
> > > Hi Chen-Yu
> > >
> > > On Wed, 5 Feb 2025 at 07:39, Chen-Yu Tsai <wens@kernel.org> wrote:
> > >> From: Chen-Yu Tsai <wens@csie.org>
> > >>
> > >> The IO domain driver controls the I/O voltage for various pins,
> > >> MMC included.
> > >>
> > >> Enable it by default for all supported Rockchip SoCs.
> > >>
> > >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> > >
> > > Can we enable following config default for all the boards
> > >
> > > CONFIG_MMC_DW=y
> > > CONFIG_MMC_DW_ROCKCHIP=y
> > > CONFIG_MMC_SDHCI=y
> > These two driver, SD card and eMMC, are board specific, not all the
> > board has enable all these two interface.
> >
> Ok,I thought it should reduce the configuration options on all the boards.
But can we implement this for each SoC, such as the RK3399 and RK3588?"

Thanks
-Anand
