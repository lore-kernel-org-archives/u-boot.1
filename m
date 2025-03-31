Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61633C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14E581ECD;
	Mon, 31 Mar 2025 19:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aJvRrMhT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44898171B; Mon, 31 Mar 2025 17:08:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1327E81026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 17:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 04A8844CC3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FD1C4CEE4
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743433728;
 bh=Joz5W9sb57Brv6Ot1vHHylJ/t2hiqHoGb4GbRXO+3qs=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=aJvRrMhTUHTqB35LU2B3SPXILYqQ+s2SUDdgPedzAgDhCaa6wX5J09tmNuzhxaT5Z
 3sxPlDyaHyhKbAwam2Aq7ecZ8xOg2sfuQAd1h/nUnY3xfE9TRQBFcgHLPejRrN1uGh
 vvwobPj0Y4dBW83cKwnTIh3q0VKJ6tTmZE+1HSvu5HMxn3/s+NDRZJpckcoYgLI5PI
 GL53kIUA13qUSK4Mk8cagFCxMTGm18mfls8MW1wwTQeRxoan5HT3cN/nDGHglzTXJP
 t6i3eOA4Pvvc7vU6Nm3LexGnChJI8S4x5RaY2yyA9rNfRheydlKNXak8GS88ZppXck
 Xewon7hw+E1Gg==
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-30613802a04so46734181fa.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 08:08:48 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw0BGWwAdL81vNfugMXPCraIO5n8QxwZlLzSTRWaJj7elFdfWDZ
 IOxhuMCWn2T1gFS5Pgi/x6tZZLg7giCw1SukNa3anlfrrXaFBYAsPvdRYAfDq7p2dRElQ3Nz2va
 eagIzvhYbf59Gj3X5nCa8bPSEDYA=
X-Google-Smtp-Source: AGHT+IFnnU2iRRWZwaOr6DjY5UjQBKf9rAI+zVIGN/Yso0o2sJwd0Ji13RyRXuZS/eRGzv8W3e9ftglplkvP0xYi7Gg=
X-Received: by 2002:a05:651c:2118:b0:30c:201a:149a with SMTP id
 38308e7fff4ca-30de02c874dmr28176061fa.25.1743433726489; Mon, 31 Mar 2025
 08:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250204172319.3361870-1-wens@kernel.org>
 <CANAwSgQTMBLW2Y5YHpoAYDtXHyAbD9-s8KpWU1zBTRAB=rsJow@mail.gmail.com>
In-Reply-To: <CANAwSgQTMBLW2Y5YHpoAYDtXHyAbD9-s8KpWU1zBTRAB=rsJow@mail.gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 31 Mar 2025 23:08:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mMmJ4w-w9LMTYBs0AKyjgQfWRbou=HF2_KNQBnyrAgQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqpZMC_hBDQ591tceTuRA55r7BXFr-zwc2LfS5VS3bgj47rJe1Ar1xMSuU
Message-ID: <CAGb2v66mMmJ4w-w9LMTYBs0AKyjgQfWRbou=HF2_KNQBnyrAgQ@mail.gmail.com>
Subject: Re: [PATCH] rockchip: io-domain: Enable by default for all supported
 SoCs
To: Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.denx.de, Akash Gajjar <gajjar04akash@gmail.com>, 
 Alexandre Vicenzi <linux@alxd.me>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Levin Du <djw@t-chip.com.cn>, 
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
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 31 Mar 2025 19:00:14 +0200
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
Reply-To: wens@kernel.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Sun, Mar 30, 2025 at 9:34=E2=80=AFPM Anand Moon <linux.amoon@gmail.com> =
wrote:
>
> Hi Chen-Yu
>
> On Wed, 5 Feb 2025 at 07:39, Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The IO domain driver controls the I/O voltage for various pins,
> > MMC included.
> >
> > Enable it by default for all supported Rockchip SoCs.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Reviewed-by: Anand Moon <linux.amoon@gmail.com>
>
> Can we enable following config default for all the boards
>
> CONFIG_MMC_DW=3Dy
> CONFIG_MMC_DW_ROCKCHIP=3Dy
> CONFIG_MMC_SDHCI=3Dy

I can do a separate patch for these.

Would it make sense to enable MMC_DW and MMC_DW_ROCKCHIP for the whole
Rockchip family, and MMC_SDHCI and co. for the SoCs that has SDHCI?

ChenYu
