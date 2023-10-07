Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E77E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 17:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99B5C86B0C;
	Sat,  7 Oct 2023 19:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VDklnP/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526EF86D61; Sat,  7 Oct 2023 19:34:54 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8BD7868D1
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 19:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-690f2719ab2so716707b3a.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696700087; x=1697304887; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRFY7VlHUWvG0GKDB3XxYrhzcwcKY09M98ozuqh//kU=;
 b=VDklnP/HiJORNnw19ursvQC5GaNxIX1bXK3TQPYvHrQhJxD0ZfCsEv1ANFUGEgmxFq
 yGxf5Qpt4Yd9XCabLtrSX8xneqnQxMf4DsBvDXJmiaoOWSd0SE7cnpNPIqsEHrMexEyh
 KiPsz5cTc4zzi3HVHQ5zRGs059RlYEu28yldDNkX67DsVn/D7ibanFhrIMrWYpsVUg2h
 eo5b9lV0JMGPIIFyv3ahzNi8MyI89hnlNw3puLqNa7fIhdKGjRZaTi/wjoYSIvaSXd2H
 e5tfovdZwaPn5+XDOZgnccsWD5gePWhDi2AoQMUIPJmcBWNJM2w3/6JwPE5+7AtijwhI
 WXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696700087; x=1697304887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LRFY7VlHUWvG0GKDB3XxYrhzcwcKY09M98ozuqh//kU=;
 b=uc3ZUmSht5elJoiWt7Gt563DbNyihcrBuBvym8bJ/8rWXe3Mgy2jbQGyPbOUQEyMUu
 nvyDqg2y6M5ev7LWRpRf8yGY79e4WyG8tRqjpdroCIagzEo653xAEhVEmakb9NqCTUgN
 /X29nJHPiHbwUsVTDJ3Qk7l0tBEuigtIZP/lw0r1CoO0Q6n+zuObQU4IAyekyqO2lUgW
 J6rwQALm89gtQ6hxD5DXgrN0pW4/W7nSdXkCabs4llN2oQzrIl+rx55yW0A5sWfRM0i+
 lM1uOHorvnhER9gf1o91cU7tRwvKicYDW6TDXvALlYvf7fQLZgc1t9iu7Va9gT/0Ot+1
 oZkw==
X-Gm-Message-State: AOJu0YzvXOjDec7jmVzUtS+wKANWufGRkA5psfFPOSTxJqeOSZCnaKeP
 +wqE5jfx774HmOztN6NNOwc6dInDJpKCMufKamSv2/++
X-Google-Smtp-Source: AGHT+IFof5EX6YBn0UyiZ4MTD8BANIUMs1CGjh0GTIexB0qRxaXJv9xDe8TOWej/9xLE4QNzlduYb8l3MKlXvsFQ8/o=
X-Received: by 2002:a05:6a20:8f02:b0:15c:b7bb:2bd9 with SMTP id
 b2-20020a056a208f0200b0015cb7bb2bd9mr13046765pzk.6.1696700086915; Sat, 07 Oct
 2023 10:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230629105931.-r3v-pmW@linutronix.de> <ZRaTt4NvbJ7F5yNe@mt.com>
In-Reply-To: <ZRaTt4NvbJ7F5yNe@mt.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 14:34:35 -0300
Message-ID: <CAOMZO5A2jvZT_f0UDvMrSZ_qnTsLF=uRLZ1Ob4Ra642x6CBJOA@mail.gmail.com>
Subject: Re: [PATCH v5] imx: imx8mm: Add support for Mettler-Toledo snowflake
 board.
To: Manuel Traut <manuel.traut@mt.com>
Cc: u-boot@lists.denx.de, Sebastian Andrzej Siewior <bigeasyat@linutronix.de>, 
 Frieder Schrempf <frieder.schrempfatkontron.de@mt.com>, sbabic@denx.de
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

On Fri, Sep 29, 2023 at 9:13=E2=80=AFAM Manuel Traut <manuel.traut@mt.com> =
wrote:
>
> This patch probably got somehow lost. Rebased against latest master.
>
> It is originally based on:
>
> From patchwork Fri Mar 31 14:18:41 2023
> X-Patchwork-Submitter: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> X-Patchwork-Id: 1763795
> X-Patchwork-Delegate: sbabic@denx.de
> Return-Path: <u-boot-bounces@lists.denx.de>
> X-Original-To: incoming@patchwork.ozlabs.org
> Delivered-To: patchwork-incoming@legolas.ozlabs.org
> Authentication-Results: legolas.ozlabs.org;
>  spf=3Dpass (sender SPF authorized) smtp.mailfrom=3Dlists.denx.de
>  (client-ip=3D2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=3Dphobos.denx.=
de;
>  envelope-from=3Du-boot-bounces@lists.denx.de; receiver=3D<UNKNOWN>)
> Authentication-Results: legolas.ozlabs.org;
>
> The board is similar to "Kontron SL i.MX 8M Mini" SoM. There are two vari=
ants.
> Snowflake_v2 has an external SDCard Interface. LEIG is the same, but with=
out
> display and without external SDCard Interface. Both variants support
> only 1GiB of main memory.
>
> [ bigeasy: porting and a bit of cleanup ]
>
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> v4?v5:
>  - Rebased on top of todays master
> v3?v4:
>  - Added Frieder's tag
>  - Rebased on top of v2023.07-rc5.
> v2?v3:
>  Addressing Frieder's comments:
>  - Add "kontron,imx8mm-sl" to the compatible string.
>  - Remove pca9450 node and pinctrl_i2c1. The included
>    imx8mm-kontron-sl.dtsi already provides this.
>  - Merge the overwritten values in dram_timing.ddrc_cfg/fsp_msg directly
>    into lpddr4_timing.c.
>  - Simplify the init in spl_dram_init() and panic() if the init failed.
>  - Replace a reference to SMARC with the current product name of the
>    SoM.
>
> v1?v2:
>  - Clarify details about the board and whether or not there is an
>    external SD-card interface.

The changelog should go below the --- line.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
