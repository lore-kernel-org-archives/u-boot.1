Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04484C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF2D87E13;
	Wed,  3 Jul 2024 15:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O6gfops8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AFC187E13; Wed,  3 Jul 2024 15:44:27 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A7987C68
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 15:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ec5e3799feso5053261fa.3
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720014263; x=1720619063; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dzj6e4ISxFxdvA7coQ8TbrHVpjjAiusWaeNspfp5Rzs=;
 b=O6gfops8+Twg+y6QIlTFwIUT6Jlq3upeLje+/RKqgUXw+QKXh/qYQ21VSNQgxuMnW6
 fvvOV2m0RBRiKrQ/IfFMHpvTBCDH7OLKwhxjZNZnhD1a17Wcg5n7KJlfErOgZkzjZTtE
 K6WUIJOEWhrdpEmt4hr2L4BLEBGt9L7y0BAEv29TVTx5/HNahbGV+ZmQExziSj4dSzNM
 e2j5tTolLKtcy4qeFtDLCee1S87Q3B7d2AGI4Xv3WKaC4EpW1J96SHBBh93hETuUb/96
 hbtsFuDAP4AWop1So2SoSnttEor3rJSQJzhq6NOVZKLClKMYbmFUySnTVA/BO37xDTSn
 vo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720014263; x=1720619063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dzj6e4ISxFxdvA7coQ8TbrHVpjjAiusWaeNspfp5Rzs=;
 b=W6YS+h3pH039N0V//mFrITzrixR5lgnFS7vaXfnS435gCxrUrwKcXw4rdsgCfRQQ6Z
 rNTy8zqQ2JR4cnlLiV4sx267IpGCfMUkvbj/DtCN1Tr7tizfhDoYmSi4zL2C4nOsBxjM
 Wt2SJFA/Ix/Jl20PeqcUtkE8lMUsoktB9REf/VxhTieaNADLQmL/AOm/4N2srNfv8s1Y
 FpCS94VJ0CXsKkuwIFRbCX66JCHtWgl4CkCEhIOaLMpDjw12PAeDVRfbllYRU239wHNw
 GuludJXIbYKimIhzYNMKZHnvliVRhxvmTxM/LgSI2lA5rcPEp+bPGm8MQpiPYD6HWj9l
 nP2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhUerqRq8+ClHzf3+huoXFDZe62lM7o+H7L1mSTJnTbxLYjwOsVxh6odxqpAw/jIVPWtedKsSoeA3zBNC6TzEZcuObrA==
X-Gm-Message-State: AOJu0Yyb/DFyb9Fs25UurpfYSZdPDOH9bQGTlAKiSnyq1V3apkFGQGFT
 l+j7Hij+kFS2a2iJS1ndWu2vgMrlvEGJrX7wyPnF9roth3I17wxSqVCR8U1KQZv144fs2G+lxKs
 gF5w+YlvV8Ds5yPUfo6Fg54yech1MNA==
X-Google-Smtp-Source: AGHT+IG1/o/RvJLwsr8AO75hTpduxXgz5lEx4/1dNPwYkweEkxkYwVYUrnTzRflNIEpj/5lk+G5/dctBWdrraMzqlw4=
X-Received: by 2002:a2e:a98d:0:b0:2ed:59fa:551e with SMTP id
 38308e7fff4ca-2ee5e6f6a65mr86223251fa.4.1720014262583; Wed, 03 Jul 2024
 06:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240703090512.92636-1-michael@amarulasolutions.com>
 <20240703090512.92636-3-michael@amarulasolutions.com>
In-Reply-To: <20240703090512.92636-3-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Jul 2024 10:44:10 -0300
Message-ID: <CAOMZO5BLx+NPPZTpWajGe75iW+dm7-VE4dkTUeYk4cVvHPFiTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: imx: add mux ops for i.MX8M composite clk
To: Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

Hi Michael,

On Wed, Jul 3, 2024 at 6:15=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Upstream Linux commit f90b68d6c8b0.
....

> The CORE/BUS root slice has following design, simplied graph:
> The difference is core not have pre_div block.
> A composite core/bus clk has 8 inputs for mux to select, saying clk[0-7].
>
> It support target(smart) interface and normal interface. Target interface
> is exported for programmer easy to configure ccm root. Normal interface
> is also exported, but we not use it in our driver, because it will
> introduce more complexity compared with target interface.
>
> The normal interface simplified as below:
>             SEL_A  GA
>             +--+  +-+
>             |  +->+ +------+
> CLK[0-7]--->+  |  +-+      |
>        |    |  |      +----v---+    +----+
>        |    +--+      |pre_diva+---->    |  +---------+
>        |              +--------+    |mux +--+post_div |
>        |    +--+      |pre_divb+--->+    |  +---------+
>        |    |  |      +----^---+    +----+
>        +--->+  |  +-+      |
>             |  +->+ +------+
>             +--+  +-+
>             SEL_B  GB
>
> The mux in the upper pic is not the target interface MUX, target
> interface MUX is hiding SEL_A and SEL_B. When you choose clk[0-7],
> you are actually writing SEL_A or SEL_B depends on the internal
> counter which will also control the internal "mux".
>
> The target interface simplified as below which is used by Linux Kernel:
> CLK[0-7]--->MUX-->Gate-->pre_div-->post_div
>
> A requirement of the Target Interface's software is that the
> target clock source is active, it means when setting SEL_A, the
> current input clk to SEL_A must be active, same to SEL_B.
>
> We touch target interface, but hardware logic actually also need
> configure normal interface.
>
> There will be system hang, when doing the following steps:
> The initial state:
> SEL_A/SEL_B are both sourcing from clk0, the internal counter
> choose SEL_A.
> 1. switch mux from clk0 to clk1
>    The hardware logic will choose SEL_B and configure SEL_B to clk1.
>    SEL_A no changed.
> 2. gate off clk0
>    Disable clk0, then the input to SEL_A is off.
> 3. switch from clk1 to clk2
>    The hardware logic will choose SEL_A and configure SEL_A to clk2,
>    however the current SEL_A input clk0 is off, the system hang.
>
> The solution to fix the issue is in step 1, write twice to
> target interface MUX, it will make SEL_A/SEL_B both sources
> from clk1, then no need to care about the state of clk0. And
> finally system performs well.

Shouldn't this also contain the original kernel commit author's Signed-off-=
by?

> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
