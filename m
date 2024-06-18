Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E717AC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 19:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26AE588335;
	Tue, 18 Jun 2024 21:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="HRiaYVpq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 670BB88180; Tue, 18 Jun 2024 21:51:45 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922838824C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 21:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6ef64b092cso731983266b.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1718740302; x=1719345102; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPu7OVIE5UTrgmZ/4H+nHGMNMBnGVCDvwmo2Iy0OKFk=;
 b=HRiaYVpqFXrmeWk5aysyUoHzkHSD2Zfr7pdyD9fSnLLxg7bFwsY68bmBRqBNGypx5N
 ISWSE6W6jsyXcpuulfXByBVrCjECVC/0jPK1wMCB8aCJnrq/Se+WT+PghV3TfHqii0Rz
 7y0xKlfXmN6ZFxuUhOBDPD6TS6t55e3Lg2LYZOHkxLektj2NjwIOeFJRer9bgglG/33X
 +cfWMQ5x+uXhyI8hxru3muzPISdOZKzpgNtCNOFRLVpCBoUAq61wtsrhgnPigYTHzr9l
 luF7smaB4z74ZDwLEN4cUwyCpa6RZ3YXdbXo8V14CZps2OYR+MDq6XV2EcfHGdbHjNRI
 rilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718740302; x=1719345102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPu7OVIE5UTrgmZ/4H+nHGMNMBnGVCDvwmo2Iy0OKFk=;
 b=TGNDhbcwnx8n+Kd2JcbJutASfxLgfRf/h78etxVcnmXcFbmivX4qVfcOAvLUthUGz0
 nOW0aGqk9zN0kknvsS+LaH0oVJLAafMGZOAc3/mH/xCMnPFYPtZ2hqdl/otR8zMCJwoL
 vhqx11jPsi5mHLvKnLhiuI+V5f7779LW8etpyaXqvbPXCk0JGSX2TAO59VsTwXqYfMNf
 pfxwgtahdDLASTUyz6twO2ieva3mYvyEJG3aHC4q06O3JYD69gX+dHDyjZqlYBOgWIi6
 e6IAE/xud5rMoXoJFS9Ce2p5XBQwH7nGymcWeKwlQCxA+ttWIGOfEOncem0z42c4vIiI
 NmfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXw0cFCrwF2NffL4HCii95enQ4kiChAF19gygxSbQm3qK/ZeT+4hkXh3JUKBuJXaeS+HZezjt3wzpArvgFMz4teES1gA==
X-Gm-Message-State: AOJu0YxTB3Gxb7+JJSbmMYEM5X49ufdPSzYTVXFvcKL+uzNw6LLpng5w
 b4qQktuZLNqKLBnF6mdKPiELgTJPchv08jlBZmpL3hZko6r6fyM4NkhP8TR00EeBvF3tFdCXYjd
 zzspxG76eeATLrl2wesL5bH3sA2HUhHIIeiGE5w==
X-Google-Smtp-Source: AGHT+IFI4VAbpJL9htyu8YZwSXgab5JCtWwSvmrm0mEqYn55CvQ+BtnqRh8drw689ugeu6+TXbxjAfx6ZusbnGhQJRw=
X-Received: by 2002:a17:906:1289:b0:a6f:e1a:3ee0 with SMTP id
 a640c23a62f3a-a6fab62f455mr27411766b.30.1718740302051; Tue, 18 Jun 2024
 12:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240617191416.1351790-1-tharvey@gateworks.com>
 <20240617191416.1351790-5-tharvey@gateworks.com>
 <626fe70e-ff61-46f6-84de-e9b8486ac5ed@gmx.de>
 <CAJ+vNU3rtrGkL3gQwEZW0x=ivSPqv-jxsdUX59bCcYRofe7Wxw@mail.gmail.com>
 <CAJ+vNU2KH8NgFkjWt5ZPKMauPjhLXwd-oNfGFy-+QHO6MWKARA@mail.gmail.com>
 <CAJ+vNU02a0VASJzAghDpSWm6XuOseQj9T70eRn0bD9deiHo6dA@mail.gmail.com>
 <CAOMZO5Cs6xWs-PvMq1u91n1Jmt8BDsZFMUwK8hCx1LWN3VPSzA@mail.gmail.com>
In-Reply-To: <CAOMZO5Cs6xWs-PvMq1u91n1Jmt8BDsZFMUwK8hCx1LWN3VPSzA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 18 Jun 2024 12:51:30 -0700
Message-ID: <CAJ+vNU0yoe8kNw6BmqpB_NjEoZE=efFGihTz=rQ5OOs5ZJNF3Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] test: cmd: fdt: fix chosen test for DM_RNG
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, Jun 18, 2024 at 12:35=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Hi Tim,
>
> On Tue, Jun 18, 2024 at 4:30=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
>
> > This seems like something from test/dm/wdt.c and unrelated to my patchs=
et.
>
> Do you have this recent commit applied?
>
> https://github.com/u-boot/u-boot/commit/1fd754cebd38d7456caa82bef15225cbe=
77960ec

Hi Fabio,

Nope - I'm 1 day behind :)

That would appear to be the issue... I'll rebase on todays
origin/master and try again.

Thanks,

Tim
