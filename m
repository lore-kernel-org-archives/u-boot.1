Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A88C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 12:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500D9830AF;
	Thu, 29 May 2025 14:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MLDEs1lD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A19A83013; Thu, 29 May 2025 11:40:07 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B6583010
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 11:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-602039559d8so1324231a12.1
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748511605; x=1749116405; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z0nHW3l/4T7ROVKg1AD9tJabCT0yy5vXoK1y1Ck0vm0=;
 b=MLDEs1lDVcDjw9CEI1kF3cnEpcgW23O3ndSF53s+EP9sIzn7UJpQUFcU1t0QbWsZ2G
 HbZ1nrp6cwCfPozG3aWPUp3uYaKAhJTmv0Y7SYU19xqnwPG0OfuzXWwigrm5CLUkcKNp
 nk6I4sjpchGbvXLlzl/aUpy1TC00FUg0uio5qkY7tKpcO9ryHzrNB6WbKsiLgqRfgUGY
 fecRmjab1PcJyD/Ovy6PSYiRENE9XyyxeXYg+RjcgTM3Los7QJ5D3Ol68R5mXkDrcU/Z
 OtzE3DZVUIW2U0IGICw4CTlD1HRLVAU7WJ/c6SjGQfNjIfT7W8/xSyJau/46ChglmFyN
 pPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748511605; x=1749116405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0nHW3l/4T7ROVKg1AD9tJabCT0yy5vXoK1y1Ck0vm0=;
 b=a1xLK82IhMh3hgSycWtMA5iK3cy2MpVX8C/+ekWtVRbOlMNnHBbQfJ6qitry9WZZT8
 l51cg4k5iiJjjSZUNuBXXARBsBExlI+gMQ1UJZGEnNCNYSvRlL5y/MEUACC9ufTZxpKj
 vTApzGdsG0U5rUmDzW4DVSafIwL0sSqPaTEcR1S/cglimZZworpv2Q6QLrR6omTY32ux
 8AlKP/94+6zseWWjE942Lc++w4w1908aFmb/BaDHThAz9scSmeaL7HkOpaX1RXOA4OI9
 bQkEQ2ERh8B6foCV8iYRX/D2ktA/v4ylYbd5o6zBLkCLqxnhEIL/De+17cdb5EZxr3XO
 XgOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmapu5KrV0ND0kcLs1jyCl9tMdb/EIqg6T0tieZcLa8gsFbJOtZ8XQEiMM4jpJWnlBZJqhUFY=@lists.denx.de
X-Gm-Message-State: AOJu0YypJGcJg8N0NpAms8hYX7NSyfJiW+D2PffOiIijrz0tww1WOr6j
 3DVt9v+r49w0X/9HuONwnVLpe7fjX+sN0ivWtFmkEhS3HHmjZkAmPdAlm4/qUaDxEeS2GcMUNoZ
 oFmvh288a4XN8LhIC7QQHxoOubkzxa3A=
X-Gm-Gg: ASbGncv7U4rTAnej2PWv6z83nLIy9PKNUBY82Ar7+or4nQDv9+02kqulDM4BEjrWgfQ
 YwGzYJP/TRYIwH8GA6nP2mgaZGSzDJFTqnJz6ZmlXWrAZZlaXzhF370HPXxR6TYkNyQwAwzSZZo
 ONuoFtK9RkKSVAwYLdSWYeuE254rmw9UY4UP6pABDvw3DZIQMweQ2n0H5CH2lr8foCHmuQrG7aw
 E5s
X-Google-Smtp-Source: AGHT+IH38f7icLJVV8ysHOWCyxVsq0vpOVWFeRRymhvduCtdvuc6CpleZ8O3V+iP5KbOmOgycNQBactoIxbsvnFwQUE=
X-Received: by 2002:a05:6402:3586:b0:601:f3f1:f10e with SMTP id
 4fb4d7f45d1cf-602d9061f77mr16365638a12.5.1748511604418; Thu, 29 May 2025
 02:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250523130651.1329593-1-sjg@chromium.org>
 <20250523140613.GQ100073@bill-the-cat>
 <b8c81f80-a32b-4935-b2f6-edb361822b6f@linaro.org>
 <CAFLszThaeVF_6ewTqupDH-CvpZAvXr=6XxkUzv2UbaX9+z6Hvg@mail.gmail.com>
In-Reply-To: <CAFLszThaeVF_6ewTqupDH-CvpZAvXr=6XxkUzv2UbaX9+z6Hvg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 May 2025 10:39:52 +0100
X-Gm-Features: AX0GCFvdEFXsxsMfmyS5qdAkkJVaw4uS-MQTvCBTfoNO-GWQxOEvSBlI5C4lFDs
Message-ID: <CALeDE9Mp14T-JMWhdmKvBjvpYdiKf8hXE=B_62bRZ4T9=n+wFQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
To: Simon Glass <sjg@chromium.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?Q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Janis Danisevskis <jdanisevskis@aurora.tech>, Janne Grunau <j@jannau.net>, 
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Moritz Fischer <moritzf@google.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 29 May 2025 14:27:20 +0200
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

On Wed, 28 May 2025 at 13:40, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Casey,
>
> On Wed, 28 May 2025 at 12:03, Casey Connolly <casey.connolly@linaro.org> wrote:
> >
> >
> >
> > On 5/23/25 16:06, Tom Rini wrote:
> > > On Fri, May 23, 2025 at 02:06:35PM +0100, Simon Glass wrote:
> > >
> > >> Some functions provided in lib/efi_loader are actually useful for the
> > >> app as well. This series refactors the Kconfig and directories a little
> > >> so that code is easier to share.
> > >>
> > >> As a starting point, it moves some filename and device-path functions to
> > >> the new directory.
> > >>
> > >> The next step would be to move device-path code over, but this will need
> > >> some discussion.
> > > [snip]
> > >> base-commit: 3599a58a5114224a01557d18371036a5823233cc
> > >> branch: app
> > >
> > > Please base this on mainline, next branch before asking for review.
> >
> > Seconding this, for the second (third?) time: please don't send me
> > patches that don't apply to mainline U-Boot. This especially sucks since
> > I want to see EFISTUB upstream>
>
> OK, I have adjusted my system so you won't see future patches. I must
> have missed your previous two requests, sorry.

There have been multiple requests from multiple people. It's also
standard community practice for projects and good manners not to waste
people's time.
