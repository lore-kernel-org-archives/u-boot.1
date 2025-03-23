Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8508C35FFC
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 00:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0ACB810FE;
	Sun, 23 Mar 2025 01:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MdzGt0Gt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57A3681219; Sun, 23 Mar 2025 01:08:57 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD2F80C93
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 01:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso5351140a91.1
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742688532; x=1743293332; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tC380zSfkbbp2az34mti+HQ8qD0rjJBlcEA4HJ7v5xE=;
 b=MdzGt0GtsdiYL/EHBbhBvlBtd0/tvVYlNHEDckTpcpJL6JyeBbXNE8rHglN66HNPc/
 K7Ld0aSLUL7FCBymyaQPlnqthzVaUr1VPNDj5NL6f18dn8ngN3bHr+8zAXq0KJMGjQEs
 kNgcDW9pBNyuc0ChLuPerl15tagYD0u29O4cKjs9cH4oI3K4Trr26z7bvwaOWeVA3R2C
 jNJ/kvpHYsPVJmTxUx+9T1izmRm+rZUmilEFCGW3lcwgG2Hcbz6BoqmDTvUK9ccTwWMU
 8zQegXJF6wlGBA+PTdxORGXNlMFig7FFC8Gu5/qT8RVDMz4ZRV45N25aP+YmirWz3H2j
 0eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742688532; x=1743293332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tC380zSfkbbp2az34mti+HQ8qD0rjJBlcEA4HJ7v5xE=;
 b=JN8ivpFi3A3+Z5q5733xUdgNqDfI8N1uAwIpFDbIM9/lmNbC7GR7lzyMJa14GOASWm
 sGdC1omMF+jV9TunprQmHN6g1oxGYoKC8sIKMg/NK/CYfHItAejv4b1ibqYjjowou+C1
 aobZnfIUbLbkDbUylP49x56a3qtThEb9b5Q4JydT8s3sGd9mSYA5qjUUy1xAkghtc+Oi
 BUlQ91poS2cjF8W1omEoIT8IkEcfnEzdR1821gS4KHdKZhWG3113TYjwdAFilQ23B3an
 VIXnklqGcWfn5Dsrga4+ugNODTpouYwVptMtdofdWi/LQID0wjQlFD4gZ9c9OF0MJ6ia
 pjvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYF+W2m+o151uVUzVIZzAl3sIzryBS1WZmmY0NUv4MGIEwmqzyTsLdbjz7dkzUaXySdX2Mdko=@lists.denx.de
X-Gm-Message-State: AOJu0Yxdw8HSPYGkkvBkSCk4koaqCPHKid0ZYwyVcN/PZBj0gVmjgl5F
 ez6aMj+4hlSpeJ395tXTGTlZOBB/7wjQH9SgVhKZeE70gI6PXFEcA0CHN5Q+7J3Su/UKBC1eMhr
 O7OAs1vqEijTZWBih0Mf8QllG8Rc=
X-Gm-Gg: ASbGncuBUzA/GWkRB5wSJcW0M86mqhJ/qTXS2QjPQUYYG+NLhkKaW8xSpnT1ExmeUnH
 m5pgLXmzQJw1QNeN/SpFD6dymZNBVNJS2e1k4eaVmWeqgzsY6pGE62X9CpofRLnguWy9BBhhV0l
 ZMRlw22+at+f647cm0kD3rPktf+w==
X-Google-Smtp-Source: AGHT+IFEMhysc5ZGatYAuJT0SXTbRRyDUNKWV0Ek/z3DIACP/RoPsbuNOLiPIIuIHUkHW+2UUKsp89Bi84s8d9Bk8us=
X-Received: by 2002:a17:90b:53d0:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-3030fb3e1b4mr16841477a91.0.1742688531927; Sat, 22 Mar 2025
 17:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250319031852.233537-1-marex@denx.de>
 <CAOMZO5D+nigasmFrQEsLQ6cGgbJr_LcxXAiQoDP2U1hDdBO05g@mail.gmail.com>
In-Reply-To: <CAOMZO5D+nigasmFrQEsLQ6cGgbJr_LcxXAiQoDP2U1hDdBO05g@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 22 Mar 2025 19:08:40 -0500
X-Gm-Features: AQ5f1JpSvfymRyo8O05T3lOlC0u9JQpfRTaOu36pktNu7uVZ5nQf38DDmL-S56c
Message-ID: <CAHCN7x+xxgKVg67Zjh1PK4w47wEkqEHcuzbAeCVuPLR7NOGTKw@mail.gmail.com>
Subject: Re: [PATCH 00/24] clk: Add clk_resolve_parent_clk() and fix up iMX
 clock drivers
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
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

On Sat, Mar 22, 2025 at 1:45=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Marek,
>
> On Wed, Mar 19, 2025 at 12:19=E2=80=AFAM Marek Vasut <marex@denx.de> wrot=
e:
> >
> > Add clk_resolve_parent_clk() to resolve parent clock udevice name
> > based on clock-names DT property. This is used in SoC clock drivers
> > to look up the clock name in clock tables, which matches a clock
> > name in DT clock-names property, and convert it into udevice name
> > which is used by U-Boot clock framework to look up parent clock in
> > e.g. clk_register() using uclass_get_device_by_name(UCLASS_CLK,
> > parent_name, &parent);
> >
> > Pass struct udevice pointer through the various iMX clock drivers.
>
> This series conflicts with the recent i.MX UART clock work from Adam.
>
> Please rebase and resend, thanks.

CC me on the resend, and I am happy to test on my 8MM, 8MN and 8MP boards.

adam
