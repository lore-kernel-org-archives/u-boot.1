Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D92C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFF9806DD;
	Thu, 16 Jan 2025 02:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g+jGuCBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835EE8069D; Thu, 16 Jan 2025 02:27:18 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41FD580214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so82526866b.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990836; x=1737595636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAyhSW7N303jSAmOruEtkI6GhNkz6nVPWV7pl8fEfb8=;
 b=g+jGuCBtzXJmvxOVwTKy7i16egMsZT8qDof5BPO75lkXV6BliL1m0dpX+w4AlNSK3x
 ZLojPZrOHNFXhRBqufjKLqVxoKVgGhmUWFdAD0c6BXqKoEW4pLmzXFfKOZggV99u4THE
 c0Y9cO0CmVO16pYi0zyjmnpFu6nq6gdnACyOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990836; x=1737595636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZAyhSW7N303jSAmOruEtkI6GhNkz6nVPWV7pl8fEfb8=;
 b=ppx2JLQU9sPDPaPALxANMIoa8A7xMcOFPoWYADfVZifMIKyFeZKECkhpR7/0p/qdKH
 wktMlBW0p5Zu5qRwVN/XIK9/SSdGYMLOQX2YxhWXnycUY7ZVzpUvHgq1DcWNqeZIRSZn
 CqQ0LEE73QSc84ByP/cQzqQXArLlScaG82ncnpxKCqsZfjhqhVEL6Rv7+YUwvPI8F74o
 4qG3+rGnH5LuuzToWeJLwVhQmkTaSjxetV1FSWUnYM819sU4bYiEPOUm0U5jKYmB8Ccm
 osZtlVm5bz7pEEVIH5WfeEZT4uHww2GAiGZuXp30dO+L+AkuEG1GKp891+vJ9MKAbHbx
 8D0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQbunqSwveQc4WrucWXC1ahd4p/aufqo5o84ESWFASe/GPPeLxS+BWUeqi7Y/efI3UOF8HyyY=@lists.denx.de
X-Gm-Message-State: AOJu0YxvsVDQENibJKPUEBCNhCNyCjDsicKwIZnXx5v6Sqxd8Whom0CM
 3geFjy1aUrZcNi8Pfk0LLCWf5WMr6XzDVT4yjFyFZSZFU/NUmZe/v+4gOn0hykccrpJS0JhoIFR
 DZGX/YbmYQSlhNmkMnm59+7nRY8OqKXcjVZtz
X-Gm-Gg: ASbGncuWu4EovgisymagsmfHKJzngyfbaNL96FVEe/1cC5a6JSpPr56B3P8GA9Zr2b2
 7cmsEMOTP+IgYAhH98Nu7vOF8vswzRVSBAovROLY=
X-Google-Smtp-Source: AGHT+IH7UZIp/MXXyugPXL7VhBFa008ARw3yQldzCQlS2ZmsTQoIUcHwErmG2sxIJ7fePeVmYv5nd/p15Bu+PUBUkRY=
X-Received: by 2002:a17:907:3e1c:b0:aa6:83cc:7996 with SMTP id
 a640c23a62f3a-ab2ab6bfec7mr3243786666b.42.1736990835709; Wed, 15 Jan 2025
 17:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20250115133114.590375-1-sjg@chromium.org>
 <8fde0244-546c-48dc-8480-068970df30e9@gmx.de>
In-Reply-To: <8fde0244-546c-48dc-8480-068970df30e9@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 18:26:59 -0700
X-Gm-Features: AbW1kvZc299-YHHboj9bJGD0XkLWAmP_Yd1drlEG1RE5BMYRZGuopAYwxX4Og6g
Message-ID: <CAFLszTht1zjWfReN+54rNfghkq31x7rTMrk3ft-U=E-WuK1-Pw@mail.gmail.com>
Subject: Re: [PATCH 00/43] test: Improvements to ut command and test-suite
 running
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Alexander Gendin <agendin@matrox.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Ion Agorria <ion@agorria.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Stephen Carlson <stcarlso@linux.microsoft.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
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

Hi Heinrich,

On Wed, 15 Jan 2025 at 08:33, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 15.01.25 14:30, Simon Glass wrote:
> > The current method of running unit tests relies on subcommands of the
> > ut command. Only the code in each subcommand knows how to find the tests
> > related to that subcomand.
> >
> > This is not ideal and we now have quite a few subcommands which do
> > nothing but locate the relevant tests in a linker list, then call a
> > common function to run them.
> >
> > This series adds a list of test suites, so that these subcommands can be
> > removed.
> >
> > An issue with 'ut all' is that it doesn't record how many tests failed
> > overall, so it is necessary to examine copious amounts of output to look
> > for failures. This series adds a new 'total' feature allow recording the
> > total number of failed tests.
> >
> > To help with 'ut all' a new pytest is created which runs it (as well as
> > 'ut info') and makes sure that all is well. Due to the 'ut all' failures
> > this does not pass, so the test is disabled for now. It is here because
> > it provides security against misnaming a test suite and causing it not
> > to run.
> >
> > Future work may:
> > - get 'ut all' passing
> > - enable test_suite() in CL, to ensure that 'ut all' keeps passing
> > - record duration of each suite
> > - allow running the tests in random order to tease out dependencies
> > - tweak the output to remove common prefixes
> > - getting rid of bootstd, optee and seame 'ut' subcommands
>
> Am I missing a patch for doc/ or will the usage of the ut command remain
> unchanged?

No change to the command, but the output changes, so I can add an
update to the 'examples' section.

>
> How would you specify a test suite like 'lib' in future?

LIB_TEST(...)

If you want to create a new one, you need to add it to the list in
cmd_ut.c as now. But it is now in a new format which is easier to
maintain.

> How would you specify running all tests in future?

'ut -a' as now

[..]

Regards,
Simon
