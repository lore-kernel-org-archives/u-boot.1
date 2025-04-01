Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBBDC36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 05:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE9181EC0;
	Tue,  1 Apr 2025 07:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mlruCj/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCA31817C4; Tue,  1 Apr 2025 05:42:03 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E656780FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 05:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac6ed4ab410so812353866b.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 20:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743478920; x=1744083720; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Llm6v0M77o3nrwL95j18ZM2edKTO+ywCJo6q1MJrg+o=;
 b=mlruCj/qaN8mxiPTq81gIbpFV007x8duSxGU72aUgyLSlNxODYt8Mr6MxzW3ooMurc
 jTlkORLfNIBINLSnxEstk0o2PSK6/QQZstnJiLA3AKaPZjH5TtpbzRfwU7emmtPo6IyV
 Qf3u8NBeKd3uU5igLL0AiuFHl0NdefLB702f3a+CCA6uOZlDZxO5EY8Db+LNgNLKrNB5
 noN8AzU6HC3GqEc5jOfrTUlSquvjQXnvntRUXfEb27pdo0tPZQAr5o5KRelaiwYujV9r
 3G5AZds1EL3W705M+4TlRQcGOTrhUlNlDHK1Z3il2SuGOKNaw+7w+41VqIVI+5WNl7ar
 KpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743478920; x=1744083720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Llm6v0M77o3nrwL95j18ZM2edKTO+ywCJo6q1MJrg+o=;
 b=fdgmRn7llqWzprBS2PXK2Flnbpv5s0y2YuFm/Q5RXIngjottALIM/O3nDEJ0+KINc1
 BlhVIM8fPc+cQFA1wfpxCe5D035dzRaolZPDe1JNQdas5RS3BZDs1MQFUS8XeeLYERTs
 fsr7GQXw6EL7Z4lfVAztWhmGsJZj7vYQqMQJkL638tocteQ7b6yLI7uNP5Akc+Y9VrTf
 I4Rh5HANwxG0rXN5FxuWbfibzAGM1AbiAOcyocve7A76/yaULfCUoEqXwVbNdXHulbfD
 OpgliM0loW3p66cKtpIjknbtqe5Hbp1RqAM+0bjmGLi4IZ2LrPhJv/Dz52JtLIxwzb3B
 wqEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9DOn8zUj4mKFxqB5VPPetgtqlJclfVbwo09b8SsVBHL5ge7b6S5MEGheAPa+LqRLC2OtM12U=@lists.denx.de
X-Gm-Message-State: AOJu0YwmQo6F1rfYMMQjQUxTs9SmXwibtYSlCVNuCRgIRaI3dyUnF6Ur
 CiLW6WVAHnc69S8WXFtZuQAtiNqIjx9Ye8S2JgdhYfykszSAt7DcAH2QUrVux+5dHUG/EFayc6v
 7WqjgIEUogpQcxyZINpDUIUIFHAA=
X-Gm-Gg: ASbGnctlt7H3NgDqnp/SU+0NlpogC5tAiMXSO/6ujOAErpZZRGgPYavspS1VsDSno/W
 J0FCH5jg/VeGvXbvLJTHGW1qhmk6Ofk+s8MF4q0Mm711m9okgAmo7Zr3dDFIAaA1yZyY/GkLA2d
 5CgoXxlACOEjWi66KpzwlUNG96NA==
X-Google-Smtp-Source: AGHT+IFiKt1VygeyiRwkb78DXh+fzyUIR907S3s/xaDgP7zaYQTq4YVenRBsBezw/M+sgQc16AKeUh9WBXrrWb2dmKw=
X-Received: by 2002:a17:907:7f22:b0:ac7:7f21:a9a4 with SMTP id
 a640c23a62f3a-ac77f21ab69mr177740066b.10.1743478920084; Mon, 31 Mar 2025
 20:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250204172319.3361870-1-wens@kernel.org>
 <CANAwSgQTMBLW2Y5YHpoAYDtXHyAbD9-s8KpWU1zBTRAB=rsJow@mail.gmail.com>
 <97223c88-8f32-4cfd-8465-dd034f85f3a5@rock-chips.com>
In-Reply-To: <97223c88-8f32-4cfd-8465-dd034f85f3a5@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 1 Apr 2025 09:11:43 +0530
X-Gm-Features: AQ5f1JoJk60eVDZkFaejgaYXlyMsbQ9QfUhme2rEA6DBQUG8WEJORU6tcCxihiQ
Message-ID: <CANAwSgQB9ZdsE9vh2jOCGsATsjAUSUZQAfftPp=VsrogazmdOw@mail.gmail.com>
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
X-Mailman-Approved-At: Tue, 01 Apr 2025 07:33:17 +0200
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

On Tue, 1 Apr 2025 at 08:30, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Anand,
>
> On 2025/3/30 21:33, Anand Moon wrote:
> > Hi Chen-Yu
> >
> > On Wed, 5 Feb 2025 at 07:39, Chen-Yu Tsai <wens@kernel.org> wrote:
> >> From: Chen-Yu Tsai <wens@csie.org>
> >>
> >> The IO domain driver controls the I/O voltage for various pins,
> >> MMC included.
> >>
> >> Enable it by default for all supported Rockchip SoCs.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> >
> > Can we enable following config default for all the boards
> >
> > CONFIG_MMC_DW=y
> > CONFIG_MMC_DW_ROCKCHIP=y
> > CONFIG_MMC_SDHCI=y
> These two driver, SD card and eMMC, are board specific, not all the
> board has enable all these two interface.
>
Ok,I thought it should reduce the configuration options on all the boards.
> Thanks,
> - Kever
Thanks
-Anand
