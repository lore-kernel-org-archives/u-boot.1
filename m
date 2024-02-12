Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E932C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 14:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F33877AF;
	Mon, 12 Feb 2024 15:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rXNPpRof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA0687EC9; Mon, 12 Feb 2024 15:06:07 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE6587732
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 15:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 016D460FF0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ECCC43143
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707746763;
 bh=UNAY5VYFqiqRmpViKlCJXkSH57Gy+awWS9IDJvN5K24=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=rXNPpRofdbzlDeX8R41iDxkXL6EuYNgBnHhAEmnM4/vTOs+PjOqNmRZ69PnFDAKTY
 g222Tx0B57XcmIaoYzuf1WPJij7VX81HojvxWRHfy1XWJADwaHokDgoEZWPNhWMOw0
 T1A/jGjDV8+Kd55LfMtBkU66UY3XbvZNbzOHRA0IsxpN1zlQBzzD7fGFIkwxXQkNz2
 95jkKcSu7Us4RcWt11l11hp6y5B0gNcvqV/rM0vNWbUfhukR2TLncjp3CnJiPp0V3K
 epsrxmNFP2fnKWOGQPxVZfHD31P3q7WgtxJPZHbKNT1EmTW0HxeziaZ4A/t6ME3jyW
 kXJXdOOQQc5+A==
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso2243186a12.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 06:06:03 -0800 (PST)
X-Gm-Message-State: AOJu0YzT0osuwwP/LMXYNPUKN1x5vQV7S46mlw9nF3lAoxadIy2B5wKn
 IG6Bj65SArtwvAucGFrfcPWmRcBHJ8lFYjTxkAt/Ws9nbMCVEL6+8zXpdl9qXEQ5FNhdzPklX4o
 PYneMkCGkRS+B+Th+YvV191S29Dw=
X-Google-Smtp-Source: AGHT+IFFKTIb3bwT90cScVWDPfZfX9UYHmoeX8vkOEyfhk4DjxwhJgJ1vPFmpgxsk097+qYHdI1iwg4fUK3M5dK9GVU=
X-Received: by 2002:a17:90b:3842:b0:296:6702:b042 with SMTP id
 nl2-20020a17090b384200b002966702b042mr4343297pjb.9.1707746762501; Mon, 12 Feb
 2024 06:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20240210063252.1065611-1-wens@kernel.org>
 <CALeDE9OUB6z=xLUPxEybFuEY5pHi1X8OmQC2h8ezCLu-E+i5TA@mail.gmail.com>
In-Reply-To: <CALeDE9OUB6z=xLUPxEybFuEY5pHi1X8OmQC2h8ezCLu-E+i5TA@mail.gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 12 Feb 2024 22:05:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v64PCkEGOmtq-Xj6Wer6DT2cqrTpy215u1ojtPFXB93yww@mail.gmail.com>
Message-ID: <CAGb2v64PCkEGOmtq-Xj6Wer6DT2cqrTpy215u1ojtPFXB93yww@mail.gmail.com>
Subject: Re: [PATCH 0/4] rockchip: Read cpuid and generate MAC address from
 efuse for RK3328 and RK3399
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>, 
 Xiaobo Tian <peterwillcn@gmail.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Levin Du <djw@t-chip.com.cn>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Banglang Huang <banglang.huang@foxmail.com>, 
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Reply-To: wens@kernel.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, Feb 12, 2024 at 9:57=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> On Sat, 10 Feb 2024 at 06:32, Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Hi folks,
> >
> > This series enables ROCKCHIP_EFUSE and MISC_INIT_R by default for RK332=
8
> > and RK3399 so that the cpuid is read from the efuse and used to generat=
e
> > a serial number and MAC addresses for all boards.
>
> For the series:
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Thanks. I just sent out v2. Could you reply there as well?
