Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064EBD637CF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 22:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E1F388F55;
	Wed, 13 Nov 2024 23:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g8P1QwaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96AC389198; Wed, 13 Nov 2024 23:37:57 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D3588E3F
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 23:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso10808717a12.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731537475; x=1732142275; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vA2GSXypLACklVHco41U07QF/E/eRYNbeJqv25vly0M=;
 b=g8P1QwaC159QnZPFXZSqOKqcjl/eqKTqjwhHJBCzliHl0xgShaqsKtctw7nlZDC5Ha
 FUot2aXat14HdD4bX7wJdDaDo2bfcCcVtvtQmspok+cEUYZJRpdhFmCjiykEc0NLKhUu
 5reBtMP34FDzyzv26kcljplV6E8vHP2/+80ZX09fAZabB2QUYDPoH1oKudYNP7z7IajR
 Ta1ZU8JSeVncvgvbVz/MNInjcKCcuC+MRlzvZ0WKMFvGi6e8a0eJcNHVr5q4IFGWzOK7
 FLYMgxnx2owG5l4BUJUvg5LO4PRlGVi7cWILQccbPgy7Yf/1x4b+/OplfXSiGkqMDYOP
 7IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731537475; x=1732142275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vA2GSXypLACklVHco41U07QF/E/eRYNbeJqv25vly0M=;
 b=Nfnb3H9i7Fib9JNLN/jCq5nFV8Iqm70hYjDdt4PLUP1nimBck5e6ejSIxOHqBXI3Vg
 /kZTTv3/KF4muZ4j0OOE0E4C7aOf94RxrwwevuTDogkFEL1/z+SbiQFLyPzBEcumWKZV
 2Oz9tkzFM1Vj1tb6+8VJZVHc0ZjRauWo+4VQdRlYYyoI+9OT5/UN/n7XBvagLNrqHnbD
 Rn0+kPwSNXICTcNiqOU38BqB5TmbTfeSvNLvudM1jJbe/eNM9Z9Riud8PQbGU4QIO2Di
 T91/QKUeQU0GupQaSvtRDrp0vNJb++vk9twMblaAzyfAETXMbtw92/DNZ+h0ZtVRyddA
 932Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUeuntj6L2YAizNlM0kCa5bIfFk3f6ZC2fVk1aUDKtEpJ+hXUYB1b+7WHXRAID9LDBSF1i+ks=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6axdpCduomtnyJhmDnLq52uIpAL/fgHR9HuN9v72GPmFEzPXO
 feXlJcR+j4HmOdwLcXUSjachltLd8wHxP1NHvDAKuATYC5vPTCpEZJ0Twa/uQLQfxM9HI84iWO1
 RUyW1CwTRjvz3p0IYqxDALa235LY=
X-Google-Smtp-Source: AGHT+IFw6nqofb7ROvhrNjX6Dxgvc9TWzC+wkw+TNyNiwzmrzr9BEgm3Q9otJbo+sAHIB5jKmDJM9ou92j5MyMe2M2M=
X-Received: by 2002:a05:6402:524f:b0:5cf:7044:588e with SMTP id
 4fb4d7f45d1cf-5cf70445c99mr2105805a12.22.1731537474416; Wed, 13 Nov 2024
 14:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20241113042536.1792150-2-caleb.connolly@linaro.org>
 <4dc079b8-4087-4c50-919b-dc676d38191d@linaro.org>
 <47DE77F8-1EC3-44F6-AB70-2D7599A79FDC@gmx.de>
 <20241113152243.GO3600562@bill-the-cat>
In-Reply-To: <20241113152243.GO3600562@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 13 Nov 2024 14:37:38 -0800
Message-ID: <CAJaLiFyovRsAbyH6iC7k6vCN60Ay6UykhfzgJDqcUhmS_zFcNw@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: add a fetch utility
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, neil.armstrong@linaro.org, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de
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

Hi Caleb,

On Wed, Nov 13, 2024 at 7:22=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Nov 13, 2024 at 03:40:01PM +0100, Heinrich Schuchardt wrote:
> > Am 13. November 2024 14:32:57 MEZ schrieb Neil Armstrong <neil.armstron=
g@linaro.org>:
> > >On 13/11/2024 05:22, Caleb Connolly wrote:
> > >> Add a small utility for displaying some information about U-Boot and=
 the
> > >> hardware it's running on in a similar fashion to the popular neofetc=
h
> > >> tool for Linux [1].
> > >>
> > >> While the output is meant to be useful, it should also be pleasing t=
o
> > >> look at and perhaps entertaining. The ufetch command aims to bring t=
his
> > >> to U-Boot, featuring a colorful ASCII art version of the U-Boot logo=
.
> > >>
> > >> [1]: https://en.wikipedia.org/wiki/Neofetch
> > >>
> > >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> > >> ---
> > >> Ephemeral screenshot: https://0x0.st/XkQU.png
> > >>
> > >> Changes since v1:
> > >>   * Rework storage info to be more dynamic
> > >>   * use print_size() helper everywhere
> > >>   * manually walk RAM banks to report memory size correctly
> > >>   * minor formatting changes and fixes
> > >>   * MAINTAINERS entry
> > >>   * V1: https://lore.kernel.org/u-boot/20240808163153.2069650-1-cale=
b.connolly@linaro.org
> > >> ---
> > >>   MAINTAINERS  |   5 ++
> > >>   cmd/Kconfig  |   7 ++
> > >>   cmd/Makefile |   1 +
> > >>   cmd/ufetch.c | 224 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
> > >>   4 files changed, 237 insertions(+)
> > >>   create mode 100644 cmd/ufetch.c
> > >>
> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> index 38c714cf46a6..d1eb164ad590 100644
> > >> --- a/MAINTAINERS
> > >> +++ b/MAINTAINERS
> > >> @@ -1724,8 +1724,13 @@ M:  Heiko Schocher <hs@denx.de>
> > >>   S:       Maintained
> > >>   T:       git https://source.denx.de/u-boot/custodians/u-boot-ubi.g=
it
> > >>   F:       drivers/mtd/ubi/
> > >>   +UFETCH
> > >> +M:        Caleb Connolly <caleb.connolly@linaro.org>
> > >> +S:        Maintained
> > >> +F:        cmd/ufetch.c
> > >> +
> > >>   UFS
> > >>   M:       Neil Armstrong <neil.armstrong@linaro.org>
> > >>   M:       Bhupesh Sharma <bhupesh.linux@gmail.com>
> > >>   M:       Neha Malcom Francis <n-francis@ti.com>
> > >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> > >> index 4fba9fe67034..da736249a3cf 100644
> > >> --- a/cmd/Kconfig
> > >> +++ b/cmd/Kconfig
> > >> @@ -175,8 +175,15 @@ config CMD_CPU
> > >>      number of CPUs, type (e.g. manufacturer, architecture, product =
or
> > >>      internal name) and clock frequency. Other information may be
> > >>      available depending on the CPU driver.
> > >>   +config CMD_UFETCH
> > >> +  bool "U-Boot fetch"
> > >> +  depends on BLK
> > >> +  help
> > >> +    Fetch utility for U-Boot (akin to neofetch). Prints information
> > >> +    about U-Boot and the board it is running on in a pleasing forma=
t.
> >
> > The information is already available in other commands with greater det=
ail.
> >
> > What is your use case?
>
> The use case was outlined in v1 and maybe missed in v2. This is a "toy"
> utility, like 2048, to make it easier to show off things like "I just
> made U-Boot work on this new platform". So yes, it's going to bloat the
> code size, but it's also not going to be enabled in production (or
> hopefully, defconfigs when submitted for new boards...).
>
> [snip]
> > >
> > >Ephemeral screenshot: https://0x0.st/Xk2N.png
>
> The point is to do something like that.
>
> --
> Tom

This patch failed to build on ARM 32-bit boards. Looks like
current_el() is only available on ARM64, as defined in
arch/arm/include/asm/system.h.
Build log:
/usr/src/u-boot-master/cmd/ufetch.c:166: undefined reference to `current_el=
'

All the best,
Tony
