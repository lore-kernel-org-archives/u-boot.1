Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCCFCAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F638309A;
	Tue, 16 Sep 2025 11:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TmC7RI82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64C58318E; Tue, 16 Sep 2025 11:06:15 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA47483071
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ec4d6ba0c7so648134f8f.1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758013573; x=1758618373; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swtf9jQ8vWqPgT8xGFP+BKtxo32eLVwcSOM8rbUY/u8=;
 b=TmC7RI82RI97ENW1XQvDBpNcgg2aAXAMNEL7oEJV3jvW7/+AQwqmzRUk2ALtsPyhWk
 zTVYcnFdRk2C0qdxZMail3gJ2ptU44Rgd2Msbd7hoq3/s6lBoPQyPavqMOA7fgNqP/z/
 F8GDxq9khOvGwyBqbjm9e28u7p53MK+bbrdkTFDEIw7df5IHh4+ZFXZf2qXYBG0rudvg
 moCzM/11FY/nujlrp0y9olPSN5aW3trFGamDb6Ep9Z/goBH34tGdhekUVMtCECubWIuZ
 jvuW414fX00Kvv26Z3wqFF+Cg0Zj75ir7biUH2LNX9hE5fyiqyW3toRg6cdgqj1D/hwE
 damg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758013573; x=1758618373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swtf9jQ8vWqPgT8xGFP+BKtxo32eLVwcSOM8rbUY/u8=;
 b=ZtRZWr/Evh/vTq8TJpjPLHJj/wn6+rpxN8/KEG3HCNDsy0vpoDbqIvHAa3/S+d9v+O
 foqM7LLCYyYU0K2hI0+YS9SI14Bg004Iw6YvLCBw2wuLBXsCWTWsHN43re8buJnFz3GD
 eohnNxw7vsfrCMpf712c2oGbg1H+SanvVWse40N6007ZzRUPO5c2l0jrpESVNKT/HIXA
 qb8uJkftx8e/cvRjQM+zi0P/sKq/KS9RNf2Fgvmi5R+JGmhS5XpLeYyYxxT4b/w96Enh
 Er/NggLijsHxPaoX2IRCfGfrCSHsc+SwTNHVu1wF935rnAEIszL9LsrLzk7NbHgy5zlK
 +09Q==
X-Gm-Message-State: AOJu0YwOndfosrErYIEZLYK67/3MpRQ/SimZPDPi6NpGnM2j7WYiL2mr
 LA7ghI0h9zJhPdZCxV7HotpJE73DLnhb6TmlQH4nR6Owmo0J72lYs5Xrn0/4Nuca5oE4y/omXcv
 LcsLl4dlyGjhFoGTpeIeWRwWIetOyN3U=
X-Gm-Gg: ASbGncsGqeOY0LNZ4c00+HeF9GvAAdDZaxJJMUsnNSSlF6myNOIX81u+qytzMgaoJAJ
 BR810tNli9fmzIcEclI+fxFV+1s4wbZEpHlxOtt3aFM4WIU6g6mbxLKd03Nzm8Z98oq2djdIwNG
 Qo40rKAITDbqwlauhqH8I2w250Br5UeT3XXfJnMGGIOxBMNY3veP43tuIrUhGDIT4jwIEaxRjQa
 B4y55V/
X-Google-Smtp-Source: AGHT+IE4nACNwUFfL0ig8FzZ5UK6uqY2Zk7mQsAKq7ANz+pfGH35hLbd2iAgvqhFv6p2fr2q99NsgaYE/6kmkiHq3sw=
X-Received: by 2002:a05:6000:4287:b0:3ea:80ec:855d with SMTP id
 ffacd0b85a97d-3ea80ec89f6mr5817039f8f.19.1758013572854; Tue, 16 Sep 2025
 02:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250915203827.GN124814@bill-the-cat>
In-Reply-To: <20250915203827.GN124814@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 16 Sep 2025 12:05:58 +0300
X-Gm-Features: AS18NWCEEXUDuefzuHXkiEVziu4jhacm_yvoTjEqcDbjABuiSbW5Ca6OlzAVcg8
Message-ID: <CAPVz0n2tpEVrZ=1k9BPyg8h3Fa_P_J8VKoQFn0MZU0rOwVbstg@mail.gmail.com>
Subject: Re: Continued need for ATAGS-based booting?
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dave Purdy <david.c.purdy@gmail.com>, 
 Ion Agorria <ion@agorria.com>, Jason Cooper <u-boot@lakedaemon.net>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Luka Perkov <luka@openwrt.org>, Luka Perkov <luka.perkov@sartura.hr>, 
 Michael Walle <michael@walle.cc>, Peter Geis <pgwipeout@gmail.com>,
 Phil Sutter <phil@nwl.cc>, 
 Stefan Roese <sr@denx.de>, Stephan Gerhold <stephan@gerhold.net>,
 Tony Dinh <mibodhi@gmail.com>, 
 Walter Schweizer <swwa@users.sourceforge.net>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
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

=D0=BF=D0=BD, 15 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 23:38 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> As part of working on cleaning up documentation, I ended up seeing just
> how few boards still enable support for ATAGS-based OS booting. In fact,
> the list is:
> brcp150 brcp170 brcp1_1r brcp1_1r_switch brcp1_2r brsmarc2 chagall
> dockstar dreamplug ds109 ds116 ds414 endeavoru goflexhome grouper
> icnova-a20-swac iconnect ideapad-yoga-11 lschlv2 lsxhl mocha mot n1
> n2350 nsa310s nsa325 openrd_base openrd_client openrd_ultimate ouya
> picasso pogo_e02 pogo_v4 qc750 sheevaplug star stemmy surface-2
> surface-rt tegratab tf701t transformer_t20 transformer_t30 x3_t30
>
> And my question is, for you board maintainers, do you still need to
> actively support booting such old Linux kernels? Or can we disable this
> support and then possibly be able to remove the underlying code as well.
> Thanks!
>
> --
> Tom

Hello Tom!

Maintainers of some boards in interest have agreed that support for
ATAGS-based OS booting can/should be removed from the boards in the
following list:
chagall endeavoru grouper ideapad-yoga-11 mocha mot n1 ouya picasso
qc750 star surface-2 surface-rt tegratab tf701t transformer_t20
transformer_t30 x3_t30

Thank you for your support! Have a nice day.
