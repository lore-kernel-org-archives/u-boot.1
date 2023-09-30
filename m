Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C83E77365
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 10:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB1386BB6;
	Sat, 30 Sep 2023 12:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aG3aWAqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DB1B86568; Sat, 30 Sep 2023 12:25:18 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2465D86BB6
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 12:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d89491dab33so9973040276.0
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696069515; x=1696674315; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nFV3qE0BM6gu7WxJmH1gqGDR6G4fWSsw0CYR3CXeQS0=;
 b=aG3aWAqQJRXcIEsSgImXbsKA324aYpklQZQMd06DWzGUX0oNOaFifbk892IBEMXA/A
 gbx79Pqaio8dzipcxIBpm2wkOrBB7m74V+Jj0XTL/BwqRMPTjeVQQi4H2X+4A2tDz2dk
 4Tzlx0etSFNMn06lTXFo1FkiAmBV4qqY6eKm9ucSjK+A3QtvC+86HSz0I8YpyYpzpG69
 ip28SS3Fb6mlUxfYpzfy0x6kcETfovD2Xs3W2nUjXUh2g8S0Yqx725WhKsAF3ZdQRdV4
 nVBDbISUjCG0qx1zZMGyhFY76OXdBg/OIE1BUuwd2V/bpN3lzTi3wrDoIl9zPYBMtxhX
 2MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696069515; x=1696674315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nFV3qE0BM6gu7WxJmH1gqGDR6G4fWSsw0CYR3CXeQS0=;
 b=neRA2RgvyolNXPgdKeXTIdRSOvjR69DrQSmlhWrhXWSvMu7yHlcVikSPtmIwJVXgya
 czya2GYlOjadwPEGetWzjX++EzVGwl02TqfNBxfoC7opDc30GLzDzASt5BXaSqA1CJky
 O3NdH9B20B0/bf3qzwaoUqYNUwoDl/pv1U43ivfQTluYg/0E1JscOHphmBD4Mf/LyP5W
 jxye2XnXOFEZkNyp8vZNECRVafU/CyRSxa62aTZ+B+h/aNAsBcpFc7f3/3TbfsnSQZDE
 RzEt8Sk+rS5NlcOeo/bMKjLnljaQZP/qVnDPc5/ZZ51NpYWcFBhGAdkkJYlFV9QXJPLL
 cHTg==
X-Gm-Message-State: AOJu0Yz/eGYk82zT74lhZenaiQPFqLQZy/3YZ0eXgaQKFB+9CL2PbCDs
 facluBFwKVg+lIbKaWWDU5VOj0aGI/TiHOmLVHs=
X-Google-Smtp-Source: AGHT+IFu/NjSM0XhcbyC8sjAoNUCuEWom6f+krlkEqNari6IwG5ntBxyTNcjt6GU4HLL0C08DvC3TDleNp5fW8l/Z2U=
X-Received: by 2002:a25:9d87:0:b0:d0a:a1fa:b8e4 with SMTP id
 v7-20020a259d87000000b00d0aa1fab8e4mr5478351ybp.38.1696069514709; Sat, 30 Sep
 2023 03:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230805111041.750550-1-jonas@kwiboo.se>
 <CAC928HZ=ZiLwDMDF9yc2H=mH3On-P2HmNnQZ_2B-B_w5CZ9cNQ@mail.gmail.com>
 <85b5d5c2-7039-73f6-9a8e-1a3d19a100c4@kwiboo.se>
 <CAPnjgZ0nuv7QRxR+qQUNXEOOMhMrOZmDbF7GyCDzbJ=ZOAxD7g@mail.gmail.com>
In-Reply-To: <CAPnjgZ0nuv7QRxR+qQUNXEOOMhMrOZmDbF7GyCDzbJ=ZOAxD7g@mail.gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 30 Sep 2023 12:25:03 +0200
Message-ID: <CAC928HabiL5BO6X2NoAztiLrLR=xa88U2nXGEKh9LqccxV0pTw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Check pinconfig nodes pre-reloc status
 recursively
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: Marek Vasut <marex@denx.de>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de
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

Hi Simon,

Il giorno ven 11 ago 2023 alle ore 02:29 Simon Glass
<sjg@chromium.org> ha scritto:
>
> Hi Jonas,
>
> On Sat, 5 Aug 2023 at 08:29, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hi Massimo,
> >
> > On 2023-08-05 16:06, Massimo Pegorer wrote:
> > > Hi Jonas,
> > >
> > > Il giorno sab 5 ago 2023 alle ore 13:11 Jonas Karlman <jonas@kwiboo.se> ha
> > > scritto:
> > >
> > >> Pinconfig nodes normally bind recursively with PINCTRL_FULL and
> > >> PINCONF_RECURSIVE enabled. However, during U-Boot proper pre-relocation
> > >> any node marked with e.g. bootph-all will not bind unless its parent is
> > >> also marked for pre-reloc.
> > >>
> > >>   group1 {
> > >>       pinconf1 {
> > >>           bootph-all;
> > >>       };
> > >>   };
> > >>
> > >> This cause the following warning message to be shown during U-Boot
> > >> proper pre-reloc stage on Rockchip RK3568 devices.
> > >>
> > >>   ns16550_serial serial@fe660000: pinctrl_select_state_full:
> > >> uclass_get_device_by_phandle_id: err=-19
> > >>
> > >> Check pinconfig nodes pre-reloc status recursively to fix this and to
> > >> make pinconfig_post_bind work same at both U-Boot proper pre-reloc and
> > >> at TPL/SPL stage.
> > >>
> > >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > >> ---
> > >>  drivers/pinctrl/pinctrl-uclass.c | 18 +++++++++++++++++-
> > >>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> This is actually something we want to change about fdtgrep. I believe
> we should try to adjust that tool rather than loading this ontoU-Boot,
> not least because it controls what properties are visible in SPL.

So IIUC your idea is that fdtgrep tool will automatically add
bootph-xxx property to any ancestor of a node with that property? Or
to log a warning, or exit with an error, during build?

BTW, fdtgrep is applied to DT only for xPL builds, not for U-Boot
proper build. Therefore, Jonas approach could be used at least during
U-Boot proper pre-relocation phase to manage "bootph-some-ram" and
"bootph-all".

Side note: I've noticed that quiet_cmd_fdtgrep in Makefile.lib does
not strip bootph-some-sram. I think it should, doesn't it?

>
> Regards,
> Simon
