Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9F3CAC592
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 21:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D54382C84;
	Mon, 15 Sep 2025 23:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cTZliopw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BA78344E; Mon, 15 Sep 2025 23:57:29 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA19F81E13
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 23:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b00a9989633so912516366b.0
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757973447; x=1758578247; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvds91N8CaGzULu/i9psqkffekPgXS3fC/L74vPAwdg=;
 b=cTZliopw6GB7VGI5NfPyMKS7y56mVpHbro8yC7aGTPBHA/fMmcEl4Vea6TZZtv2CER
 2/a5IU6lsF6Aeo5RyjUwxkcb7BJWTlrhXv/xgh7pMznnumc9EE9rIrmDfkqQey+N4JJB
 CEGR2L0tKW5KboiWuwgve/asdkTaDM2wtVrWo1I5Xbgm9OILxcAbQFKoj427s4VGe+tw
 77aXZljtOpcUECK42kT1+plonuxMZYoD6BqsgXfYp0Y3vOGvbQUa/q27okV7WAzExLlq
 pyBnR//jGgjfH76e9kKgsk7/Aez/8OoWBVy+x6/O9A0gc0LsmdH1hY09o14KxmPhGtdM
 sUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757973447; x=1758578247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvds91N8CaGzULu/i9psqkffekPgXS3fC/L74vPAwdg=;
 b=UyewXud29iLmfnuhH/k/HC1KJ6aGSrEL54yPDuaQiFrDd0mm7WUBB7ML3usij4VgtZ
 o7ICKxYtLs/FjVNITOvlQcnIVIPzwUAQpGgjAdYClcyIZiULefh9LQJIp+8cPw/6N3i/
 0k70/scI9+oSU+tJnLg1F8MRIs/kDDKW2jkX0lYKL6Y/eSOCkuJ+BUFsf/oHcgaLuQxj
 ZSieKHz1vBCMT1toU2u8Kcmd4jMK0KhPkc49WAWYDFUDDBZ4crKU772PTbDalQFtXP2Y
 r9UndXpQVaL9t1HMptNYXLLHnPoYhxivjec+q2IA8Gcuszdkci22jTYLFO1M+hVS8lrj
 HTfg==
X-Gm-Message-State: AOJu0Yzm0GJp3+uRBY0FZPQy8RqVGxUV6uFaldUL6w9JvfFUatnl/qNh
 RZieam/8DdCQqEnlNFwqI7KH7S7ZYiLlAIlfIHpW8oCKHAtIaPoC+qrS+pu+RyyxYitfdAO92Mx
 uYVMhsXefDu3ra2gIZ4KjEJ83TDr4lm0=
X-Gm-Gg: ASbGncs6y2IzLwdASF8/exlDAvWafqHP20qfuHRak+RyuIXgzActxKSVwcgAtmrh6jJ
 Rk0hxaLQ1Rjp0PtTaiJxctQoTQB+kJajHAHlIDAzV1ZHrltgJAVF+pylH+pKQK2Mmv1VhRYLD1v
 9rR+TAI8KoOOs25kAEH7KopCX9mY4w3kG4FlS44INVdKayfkmcULEJvTy1pBuoTTcZCXfeLwWO+
 NS/sUQrU0tjosaZ2hJKd2maplD3aA==
X-Google-Smtp-Source: AGHT+IHGgzdq3XMPHtWX3Ka4/F/ZI7QzcU4f7i9f9CcOIZaoW4b9st3xf1/ke7B06IBnTgcOvDFKcYyhpoY42FDXb7c=
X-Received: by 2002:a17:907:9621:b0:b0b:5d7f:6ae4 with SMTP id
 a640c23a62f3a-b167ea62cacmr2505866b.8.1757973447042; Mon, 15 Sep 2025
 14:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250915203827.GN124814@bill-the-cat>
In-Reply-To: <20250915203827.GN124814@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 15 Sep 2025 14:57:15 -0700
X-Gm-Features: AS18NWA4jTYmc6sJOdMFNNQa-ejwAVdJf9EjgrStfS-B1Y7duyo44uqwrTbGmZw
Message-ID: <CAJaLiFz2epS5+nh4NYJBg5PDakfR+kNASBjqiWvPZmAABGUK5g@mail.gmail.com>
Subject: Re: Continued need for ATAGS-based booting?
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dave Purdy <david.c.purdy@gmail.com>, 
 Ion Agorria <ion@agorria.com>, Jason Cooper <u-boot@lakedaemon.net>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Luka Perkov <luka@openwrt.org>, Luka Perkov <luka.perkov@sartura.hr>, 
 Michael Walle <michael@walle.cc>, Peter Geis <pgwipeout@gmail.com>,
 Phil Sutter <phil@nwl.cc>, 
 Stefan Roese <sr@denx.de>, Stephan Gerhold <stephan@gerhold.net>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
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

Hi Tom,

On Mon, Sep 15, 2025 at 1:38=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
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

IIRC, Debian latest mainline kernel still expects ATAGS for most of
these boards (ones which they have installer for):

n2350 ds116 dockstar dreamplug ds109 ds414 goflexhome
lschlv2 lsxhl nsa310s nsa325 openrd_base openrd_client openrd_ultimate
pogo_e02 pogo_v4

I think we should keep ATAGS around until the Linux kernel removes it.

All the best,
Tony


>
> --
> Tom
