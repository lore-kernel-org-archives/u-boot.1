Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816BAE6B27C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 13:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0FF489045;
	Fri,  1 Nov 2024 14:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D03XOAcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6803489287; Fri,  1 Nov 2024 14:36:41 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D36F88DEA
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 14:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb599aac99so17868221fa.1
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730468199; x=1731072999; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZInocNriOb6k7zrdPtNQlTa9bD5odqP+C0wxiAcFdY=;
 b=D03XOAcIRcyafUxWVMZkUx1RU7tar90O5OUdHqfm0yb5mvwqRqzaPx1KLQECCgu2fY
 fFgyxMw9Cdvb6i7gLpl/4pAo7Ecn5KoxS4s9BXwEYweYd1XGcYflpOPt7mrekzs8GGyP
 +ZhCO0rG2/iuQOVurAhxkyMcrDCK+nQXXH8BW8KxtRFm0kQusHfSaqoiDk6hb7NJl0J8
 637kF2he7P983Hjs02bZaWuvCiCg95jczLWUZeXgJZi6M+8204P0tWnhEZK9gym49XnN
 4KeKAp/X+SLlfHsA2t1UmLKtA3ZZQI8s1mH9XZG6wR5H5Xu6qCBHbBAqjtc+bs2DoD4k
 suGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730468199; x=1731072999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZInocNriOb6k7zrdPtNQlTa9bD5odqP+C0wxiAcFdY=;
 b=L/mnf7GV1BmI7m0NRZlDE5lX+50As1FirUhirIqYbjNfDnhE3MRfgJvMUsfPDRhJmB
 b/f2HkHUqezfyJFtb4oGszWy41cu1th/qa7SmVk7KcMuWpToUKji6nn+HpLTiO1tWIjt
 cso6ytjT9adTLf5gRqWtzD7OwSOH770913ezPKVqs1s7iCg6E4UUNPSF5B+5o4U6H7bt
 TL1drGL3aq+nKyfYB1H8KXhcV2Bn4ZdYq4gxySAR8AK3UGiq+GXPRESZKD8/qJ0Opqb4
 j7RA4s7zLMn6MjCxDrwCBtmk9FN03jzmv+vwGUCxPbcIj2PsnpUvjbYYhJjALCbAfizd
 5cNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU1v8nYDanp/BItqYXp64zhEG0nIiwAIaBRaulyFNcYr80Ft4xCtT/I1jG40CZ2XkUHAPjuXA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf5frHretXAsXHJw71JdzWSZvcvHgQSueFYASJuEz2Timu28Gu
 tTYhbSvHUdX8i9Py/zZFFfOywDKztKCwiFAGnIpM0dfH53NA/ZTi0RirnZ2YYi+0wLR8Nh9xMK0
 WpMmho6d2vRxtgSawp4+zCKIXv9E=
X-Google-Smtp-Source: AGHT+IGIMCXXqWS5bi4tirR1bKQU9mAgf4FibE7G/KMw3K151H4rLP3ajK/1MVE7GnYgsUTMAG7TF22P94qCZDMOf88=
X-Received: by 2002:a2e:a10e:0:b0:2f1:5561:4b66 with SMTP id
 38308e7fff4ca-2fedb833b62mr17882671fa.44.1730468198388; Fri, 01 Nov 2024
 06:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <20241016-imx95-v1-14-f640c8f3bc1b@oss.nxp.com>
 <CAOMZO5DY7LeLvp33cnocTuW4UgA7tnmJdeUX1e3Y6wqusahBDQ@mail.gmail.com>
 <PAXPR04MB964465837D7E1BB2D85FFED7E2562@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB964465837D7E1BB2D85FFED7E2562@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 1 Nov 2024 10:36:26 -0300
Message-ID: <CAOMZO5D8Ncc7DR-3zbh6i7_Sx_LSrdh5abn7qh1yF7FHGn-vAw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 14/17] imx95_evk: add i.MX95 19x19 EVK board
 basic support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, Marek Vasut <marex@denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Alice,

On Fri, Nov 1, 2024 at 6:43=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:

> We will have new revision silicon that not compatible with current silico=
n container format. The current version will not goes into mass production,=
 so I prefer to defer the binman work when new revision silicon arrives. Wi=
th current patchset, I could add doc to use imx-mkimage to pack images. Wit=
h new revision silicons ready, we could switch to binman and update doc the=
n. Is this ok for your?

I cannot accept this proposal. I'm sorry.

imx-mkimage is a poor custom solution developed by NXP and I don't
want people to depend on it when using U-Boot mainline.

Just add binman support from the beginning.
