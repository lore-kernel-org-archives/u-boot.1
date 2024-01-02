Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBDDC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 09:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75AF886C68;
	Tue,  2 Jan 2024 10:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="SSAcye8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60C4186FFD; Tue,  2 Jan 2024 10:29:20 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7428986A81
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 10:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbd721384c0so7422191276.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 01:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1704187756; x=1704792556; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQy19F6QujIGpUa/oqHcp2PAeeLiqC7Au7H+9/zqDmY=;
 b=SSAcye8/QbbGOVqIFq4NeRnQsloU5Gb5rCDUrPqvi8tPEP0J943YPrSemEAy/kFcwj
 6DSOHJ9H6fbIoxWHJQ+gkhpqa4hKre9/8CmUns6awUx7DHJzk35mQbm1h0X4Fj5Rf+4N
 SIC1BW55RyXo9HO4MEm6P/dvLPwGU+uEg93fe4Grw05c/6zqP4huMM/ZPHg79GQHMtGp
 F6AlqubritZIquc5aaFnZEl3YesZu4pmqgNTk0BshIt9pJ6+glbcTFElO92s/vT37L65
 pfyz3qeAl6vkJgToM8X7TvC7KeqBeumB1ovK5unH3tNtQEoODW+4BGyS+DWt+pCOwwSI
 +Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704187756; x=1704792556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQy19F6QujIGpUa/oqHcp2PAeeLiqC7Au7H+9/zqDmY=;
 b=uCSqoaY3DvB+VNKjXA5l0ZkAv6G3C1ouygU2hekY6PHLm4mGlemjKRpundu23XXUaq
 v68v97qO41Kn24G9IKqCDR38cTwhcYHd2wjTc7N8GYg9wJTi+N7xXyYa1VC/3P4kc9nG
 yCYdWa02ZuG14pPp4vKXQwWMLZt3GGl2LvyLv99pK5LzeB+bvcCp1k2Z649LS9kavT7S
 b6F1yiPxJ2jEMEcIBgcM733ExDSGLy3f5riW2e0RorQpBt1f5p9Y5XELHLGuyFpXPQSV
 /s790hUAyFL1GBkuAko9X/Q3jsEmoIMlqz3tIKFJA49hXviGhLpTDBIT/KQR4Y0teGVo
 9kPg==
X-Gm-Message-State: AOJu0YwChAC2RvT3By3YHRsLQPwAc2c6c49ZMkzEMVxNGPUifrXQOgam
 coLMmooev1Uho/sEO59SNW00FVWSaYuwkmw0cUQUNmOw3ll+iQ==
X-Google-Smtp-Source: AGHT+IHvrXxbEtRp7FAcRGMiVczI62RTWsT+BhKfV0DVDnzgnf+p8pn1Rlaf5O6/fXKMmoezxamVEB0b+5HJnNev98M=
X-Received: by 2002:a5b:9:0:b0:db7:dacf:ed8b with SMTP id
 a9-20020a5b0009000000b00db7dacfed8bmr7220455ybp.108.1704187756103; 
 Tue, 02 Jan 2024 01:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20231220091236.1059109-1-naresh.solanki@9elements.com>
 <20231220191211.GO2513409@bill-the-cat>
 <CABqG17h=HC=Fifze+5G2kQ7x5DTW_THzNrsua8ZM=e1uLDn+Vw@mail.gmail.com>
 <20231220223816.GF2513409@bill-the-cat>
In-Reply-To: <20231220223816.GF2513409@bill-the-cat>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Tue, 2 Jan 2024 10:29:05 +0100
Message-ID: <CALNFmy26yQYiNb0-7pFzGa3Z1gxkCb1NpwzEwX5tDxcedg9N7A@mail.gmail.com>
Subject: Re: [PATCH] sbp1: Add support for IBM SBP1 board
To: Tom Rini <trini@konsulko.com>
Cc: Naresh Solanki <naresh.solanki@9elements.com>, u-boot@lists.denx.de, 
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
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

Hi Tom,
can you please clarify or point us to some documentation that explains
the new DT setup?
I thought the u-boot DT is only used for u-boot internal drivers.

Do we need to upstream the kernel DT first?
Do we need to provide a complete "kernel DT" to u-boot as well?

Regards,
Patrick Rudolph

On Wed, Dec 20, 2023 at 11:38=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, Dec 21, 2023 at 02:38:11AM +0530, Naresh Solanki wrote:
> > Hi Tom
> >
> > On Thu, 21 Dec 2023 at 00:42, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Dec 20, 2023 at 02:42:24PM +0530, Naresh Solanki wrote:
> > > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > >
> > > > Add defconfig & devicetree for IBM SBP1 board BMC based on AST2600 =
SoC.
> > > >
> > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > > ---
> > > >
> > > > Changes:
> > > > - Update MAINTAINERS
> > > > ---
> > > >  arch/arm/dts/Makefile                |   4 +-
> > > >  arch/arm/dts/ast2600-sbp1.dts        |  96 ++++++++++++++++++++
> > > >  board/aspeed/evb_ast2600/MAINTAINERS |   1 +
> > > >  configs/ibm-sbp1_defconfig           | 126 +++++++++++++++++++++++=
++++
> > > >  4 files changed, 226 insertions(+), 1 deletion(-)
> > > >  create mode 100644 arch/arm/dts/ast2600-sbp1.dts
> > > >  create mode 100644 configs/ibm-sbp1_defconfig
> > >
> > > Is this device tree submitted upstream?
> > This devicetree is meant for uboot.
> > devicetree for linux kernel is wip.
>
> Right, but the DTs in U-Boot are intended to be re-synced with the
> kernel and medium to long term the goal should be that the run-time DT
> U-Boot has is passed to the OS.
>
> --
> Tom
