Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540CFEB8FAF
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 06:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D3D86625;
	Wed,  6 Sep 2023 08:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fo8Xl5rt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066AC86667; Wed,  6 Sep 2023 08:37:27 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4468B86545
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 08:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59231a1ca9eso32360757b3.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 23:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693982243; x=1694587043; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cZzo2I5zZfeR4EdhRMPvOoq297ylSyh3tnG5/z4qceg=;
 b=Fo8Xl5rtF3pqytbu1kT5dS5i69R94Xaa6PJOF1Csl73hOluhL9m6mvC4AXOOWYAUCU
 5J+oOTpx/mv5CsadBiAgeWnp3BjNg+6U62/LUlqA7+ViNDFb3NdW/Ea2S7JcGP63Wbet
 MCdjQHcLM4D7exW9wxAUX5vizwaRUrFrBfUNvl/hn8PoClUsL92qSfSrEysgWmx79zR7
 h/UHchskguIU8IawtmAeAZCgU3AnH+Hh5JJIePauQvk8ZyYmS4yyvTE8FiOAzMl3PIpy
 ewssgu1ftjyPwETX8y6T+RSNTAuVtCaJM83oAHhjuQrhvKPg9MSQWiA/NOh+MntHLJE1
 UgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693982243; x=1694587043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cZzo2I5zZfeR4EdhRMPvOoq297ylSyh3tnG5/z4qceg=;
 b=Gid6z7dzwuPbxsat1AZ+8bL9K6WZcULGNG4AxcWUlLD4cuL5Dova8Y2SYQMUmw7RdN
 kBeq07tOOvRH0qdk62GcVECLRKHmgUusJyVEwzd+bGmdbQesRPmm0WQtNt2hcVzsUEw2
 FKypga4LD/uh2xeQaeuME/wSuSAksAWIkcmhrWrnGPELS4MgY+AITy7kHSGLG4Mb29DB
 z3itDfZ0tjEuiiiYwE83Q/fwwpQ/ruZ+ByL/lCvjcHiFEmgI7sGXPiAlwe7DdF7nL+2r
 EvZIq+Nc19hjQVTdpNET+dJ78bxDnpgv921pRagDUBbBjQS8b4w3HvGoaS4BF6c3iE7x
 x2Aw==
X-Gm-Message-State: AOJu0YymSjO2c6DKo6B2oyMcr5CpzeLvLprs2K1w1TJxuLn9k0s00suu
 wgN0mpcS4ZCS762XUCpXtz5tP6/K7BeTDI8W90c=
X-Google-Smtp-Source: AGHT+IG6jnWpcAKAh/XkngNIS647q45IPbnBSYC+ZGr5Eh8I6v/fBT0TtqVKvYpOUB2YRrFzTci3M2NWgkS5YfSmyDI=
X-Received: by 2002:a05:690c:3004:b0:59a:59e9:9d53 with SMTP id
 ey4-20020a05690c300400b0059a59e99d53mr8103694ywb.52.1693982242994; Tue, 05
 Sep 2023 23:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAC928HYMtd=RZnZYW9CNc5wPjzGk11X0+RpcuwHMFEuUpv0C4w@mail.gmail.com>
 <c2b9e22b-e55a-03d3-1bac-f7801a8d60c4@kwiboo.se>
 <CAPnjgZ0isSOEBnPi4NWHwx=pm244kkYcavSMZAfrMa0wNDirwQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ0isSOEBnPi4NWHwx=pm244kkYcavSMZAfrMa0wNDirwQ@mail.gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 6 Sep 2023 08:37:11 +0200
Message-ID: <CAC928HaWqeN9FxeJaT0k4mMpCu7TAwLOACxSMesQv+tVd7aXtA@mail.gmail.com>
Subject: Re: Binman how to build using Rockchip BL32 binary as OP-TEE
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Il giorno mar 5 set 2023 alle ore 20:16 Simon Glass <sjg@chromium.org>
ha scritto:
>
> Hi Jonas,
>
> On Mon, 4 Sept 2023 at 10:52, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hi Massimo,
> >
> > On 2023-09-04 17:05, Massimo Pegorer wrote:
> > > Hi,
> > >
> > > Is there any way for binman to package FIT with U-Boot TF-A and
> > > OP-TEE, using bl32 binary provided by Rockchip as TEE?
> > >
> > > I've tried with TEE=/path/to/rkbin/bin/rk33/xxx_bl32_vX.YZ.bin, but
> > > binman failed.
> > >
> > > In my poor understanding of Python code, it seems binman accepts only
> > > ELF format or a binary format starting with optee_v1_header, but
> > > binaries provided by Rockchip in rkbin repository do not have this
> > > header.
> >
> > One way that I have used/tested before was to create a tee.elf version
> > using something like:
> >
> > $ aarch64-linux-gnu-objcopy -B aarch64 -I binary -O elf64-littleaarch64 xxx_bl32_vX.YZ.bin bl32.o
> > $ aarch64-linux-gnu-ld bl32.o -T tee.ld -o tee.elf
> >
> > tee.ld:
> > ----
> > ENTRY(_binary_bl32_bin_start);
> >
> > SECTIONS
> > {
> >         . = 0x08400000;
> >         .data : {
> >                 *(.data)
> >         }
> > }
> > ----
> >
> > And then make with TEE=tee.elf, however keep in mind that U-Boot may not
> > treat the memory region used by OP-TEE properly for aarch64.
> >
> > Regards,
> > Jonas
> >
> > >
> > > Thanks in advance for any hints!
>
> Should we do something to support a 'flat' binary in the tee-os entry type? For example, we could allow it if so long as a fixed load address is provided? It might be a bit of a hack though.

I do not know how much fixed is the load address and how much it
depends on SoC and OP-TEE build, instead.

I think it would be preferable if Rokchip will provide also the
tee-header_v2.bin, so that binman could extract load address info as
it does when parsing tee.bin.

Regards,
Massimo

> Regards,
> Simon
