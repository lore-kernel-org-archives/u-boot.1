Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2990C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 13:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C3787BDB;
	Mon, 29 Jan 2024 14:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tjLQlWe2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE98287BDB; Mon, 29 Jan 2024 14:31:17 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F7487D6C
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 14:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-602cf7dfeb1so24751917b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 05:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706535074; x=1707139874; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPx+yQ14k8oVPGoYCKK3Vr0CF+CdmENX2ZHSLPbxytc=;
 b=tjLQlWe2a3IGlEtySp92n3YGxQgC29tefshKqYrWpMDqiG9baSYWIzUSwjkaUWkAMN
 TuGNZJ2RB69j6GiMx+KrMTNrWipFRBQePBVNXZFATjRqH+2/VUhfNUNAv1uxkH2kF1Tn
 docCSSUuB5Gd50i64z5Km8IHlbPfJyPMJtc7ulUw6ZOhtiw8+H1gpE2wVoTtPDB2U1kt
 h5fFhMP39WC5XWwBMtM0Bo2S1FPf55Nj21yOPgrGicLvuQdu18zxkl1jVTazME7HYWBl
 F3RpBPrejRwQL9J4N9HKy4NVdgUYdTqRXpm2WYMpd0gqUcLUgDUXHJ+zGSeH7MAMNm2T
 J5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535074; x=1707139874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPx+yQ14k8oVPGoYCKK3Vr0CF+CdmENX2ZHSLPbxytc=;
 b=vUQsTN9mfN1tYrC5DFQ3Ezd6JnGZOj5ZixkHeJjPygtCX6vmPcE5vOJ4wVM1b9eeKS
 +WrvCBGyMelpglFAcSEjqFcWrNcjxzqn+YStn3uxcLbT1ZGP3dOI55znzmda/smpdMIB
 YRFRDe24Q50rPYusotOrlxIzdrGJfFyXYQlTS7alSKBx3u/i4EZmApa85/h7IZ1vNxOc
 LiVS0OeNfxZy1NO6qII70lqCC93/sAeNArtT1PtQnhBh4H/1ISSPpG17xHZqWvHm6cJr
 vpscUS0+gTLMLQaDfuieUx57rkzmUWdeQ5XZnQHF+Od9BEYa04EmjFBcc5Uo9rY3eKoS
 KVWg==
X-Gm-Message-State: AOJu0YxvcpsfWgjhrVpNPpfrvctu8u2CivTVR7yyZsvSSL0zJGCfWG5Z
 8g95wOotM4oqjD2ObFya9SaTiN8l+PbpUZjgbNwbwbihPessWjgfPsT0GNbTXYQ8SANj6tuNJVk
 9Aqx9kKLArm2+fDKpWbVMQP9/d7yC14KgI4cjEv7/91FP7ldo
X-Google-Smtp-Source: AGHT+IHRby8C6HJ8F3nWGgkcH6ZyY072fK9q0RNyQUMQM+SSn1Hir0fk9MuDujNwGsx7ccqPZPoSpRVrKY0SeMe7M7w=
X-Received: by 2002:a81:ac57:0:b0:600:23d2:8db8 with SMTP id
 z23-20020a81ac57000000b0060023d28db8mr3219059ywj.56.1706535074190; Mon, 29
 Jan 2024 05:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20240126124801.1164892-1-ole.orhagen@northern.tech>
 <CACRpkdYLizF9Duy3ZCfqRsY-NMoLZJO8+TCyBHbQDqSOWuzonQ@mail.gmail.com>
 <CAD5A3Cuba_EchhDWBfej5HGHsP-T6smgL-L+C6SV_bONf6EqYA@mail.gmail.com>
 <ed02c9b9-5505-4aad-bc92-a2678607ff54@northern.tech>
In-Reply-To: <ed02c9b9-5505-4aad-bc92-a2678607ff54@northern.tech>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 Jan 2024 14:31:02 +0100
Message-ID: <CACRpkdaiYgmzjsX8SPMFOFo=iK19s2y8Uuaysc+46Ba7D1PFBg@mail.gmail.com>
Subject: Re: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
To: Kristian Amlie <kristian.amlie@northern.tech>
Cc: Ole Orhagen <ole.orhagen@northern.tech>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patryk Biel <pbiel7@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>
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

On Mon, Jan 29, 2024 at 12:54=E2=80=AFPM Kristian Amlie
<kristian.amlie@northern.tech> wrote:
> On 29/01/2024 12:41, Ole Orhagen wrote:
> > On Fri, Jan 26, 2024 at 8:57=E2=80=AFPM Linus Walleij <linus.walleij@li=
naro.org
> > <mailto:linus.walleij@linaro.org>> wrote:

> >     Are you using the actual hardware, or QEMU?
> >
> >
> > I only have QEMU available, unfortunately.
>
> Just providing some context, since I'm listed as maintainer: This board
> was going to be removed some time ago, but was resurrected specifically
> to work with QEMU. The "virt" board, at least at that time, did not
> support some key ARM features that we need in our testing, such as SD
> cards and Flash. Hence we opted to keep this board around. So
> compatibility with hardware is not important to us at least, unless
> someone else is requesting it.

I actually have this hardware.

Last time I tried to bring it up it had severe problems with caches,
especially following the meltdown/spectre workarounds that start
to really stress the cache, and probably the caches simply have to
be disabled to make it work.

But I will try to dust it off and test it again.

Yours,
Linus Walleij
