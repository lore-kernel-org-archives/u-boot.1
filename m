Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF825C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA318083F;
	Thu,  6 Feb 2025 13:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cs0s9J2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6E69807FB; Thu,  6 Feb 2025 13:31:37 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 858D880885
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5dcdfa7df68so1531654a12.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845093; x=1739449893; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=75r8n2oHkGbSBKRjnMQyPKqpdFLG0t56vSUSvPnzQLk=;
 b=Cs0s9J2ijPc5IzNIWOUyWAZ8UlGDowBUFfqRv6qPcpFECzk4Jpf1h0DUQXn8rp7out
 xgQ7xzBoBYsaRpyhH99fMr2jnAUFT/5IQ2ArSFtMZ7M4TMu61809KVlX5j+9lKMfi/jV
 imTAbAJjtL5X6vbes3ougWGRP1PG1o8SvEF3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845093; x=1739449893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=75r8n2oHkGbSBKRjnMQyPKqpdFLG0t56vSUSvPnzQLk=;
 b=wJ+3KGU0SvAxdH2FdtOiQ8QEAPIVlNc6fp3mL+xc2cibP+wQapcsxzzeWiydLnxSNL
 qfGJfZTNKyGLtm4sUXE6ZsqnatPNl1Pzkc3C/+/FhfBMh49SakP39bzfO12GFs8ai5tC
 QCAJgphEkskTqOd+to3NWsbgTbGzJfr22JAE4olGangERNGULaozLP74aOsGkywZX+gj
 rwOdZiDmferhLGiZiZlTueGUHiQaRgK0Yp6J/ZMs2VgV6Jrb+oOCjqwSxcyyhlz++0me
 xxdsfHNBAw4Ryi3sM+wtc2dhBVQiWbwdBVpGY5A6TXBo0UDEDRZgnCrupRgjmNbhYnKB
 kxbg==
X-Gm-Message-State: AOJu0Yzqlaltw3A+omD0/ur0Zdn+XBHgGoai9pGuPxdkLo9/2fwtNwKb
 QB6VX5+C196nicGl/glEw0CbnBxZ0NKNwgkadXMzhN1881x4Kc0SShKHHeUfNsphx3HNuJMmxlk
 QyjOLvtQlg5LK+LX1YlBXgl6osPScbTFWOmIM
X-Gm-Gg: ASbGncuMZVxj5iuf7yCqwY8PGcOovVxYHAG52jW+pdlJH8vWEgYVTfDg824aHgavVPw
 wjWtZPg5/DzS2VMC7ibEbEZT0fBKU+gN+7pu3w0KbLolMbXFazani/iLV7+oSQ9wraz6G0zTCJA
 ==
X-Google-Smtp-Source: AGHT+IE6g1MwCD1xlfnraW7By4RLdqZ7iMvsWIf10Iyvk/vsKT7u91VFIPr9qwQD7lvqeCRw6Of5bfo3ZXOAccRRUls=
X-Received: by 2002:a05:6402:3205:b0:5dc:71f6:9724 with SMTP id
 4fb4d7f45d1cf-5dcdb76382bmr7638520a12.22.1738845092886; Thu, 06 Feb 2025
 04:31:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:31:21 -0700
X-Gm-Features: AWEUYZmctVZ3m4Bh7xb0MymFrgYyNxWAOKT6XJvDHNxXLL4QHvJ-Jeat4LMvwAc
Message-ID: <CAFLszTicLJR6n7WAaAmp5DDnk96gELO=x3qaOCwLCSJ510kKMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>,
 Matthias Brugger <mbrugger@suse.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
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

Hi Oleksii,

On Wed, 5 Feb 2025 at 03:15, Oleksii Moisieiev
<Oleksii_Moisieiev@epam.com> wrote:
>
> This patch series provides generic support for Raspberry PI 5 in
> U-Boot with additional hardware drivers.
> The following features were implemented:
> 1) add generic board config for Raspberry PI5 including device-tree
> files;
> 2) add support for RP1 chip with additional hardware;
> 3) add support for rp1-clock driver with dt-bindings update;
> 4) PCIE BRCMSTB driver support for Raspberry PI 5;
> 5) add clock/reset/gpio drivers;
> 6) add ethernet support in u-boot.
>
> This patch-series introducing the basic set of supported drivers in
> U-Boot which allows using such features as tftp and\or NFS.
> I've posted this patch series as RFC because of the following commit:
> e51ca0d221 (HACK: drivers: mfd: set bar configuration for RP1 driver, 2024-05-21)

Where is that commit?

>
> It includes HACK for rp1 driver in u-boot. This HACK is setting bar
> address in the correct order because RP1 driver in Linux Kernel rely on
> the pci BAR configuration which initializes BARs based on BAR size.
> This results the Linux set BARs in the same order on each boot.
> U-boot does initialization without any sorting so the configuration
> may be different from the Linux kernel.
> BAR address configuration is set to match the Linux Kernel order
> to avoid fails on address translation.
>
> This should be changed after upstreaming RP1 driver to the Linux kernel
> mainline.
>
> Probably somebody from Raspberry will post an advise about how this
> can be properly done.

+1

> U-Boot support for Raspberry PI 5 was added in terms of the following
> project: https://github.com/xen-troops/meta-xt-prod-devel-rpi5
> This is xen-based dom0less system on the Raspberry PI 5 with Zephyr as
> Control Domain and Linux is Driver Domain.
>
> It is Yocto-based so it will be easy to build it on your side. Please
> visit link for the details.

I tried to apply this but I get a lot of conflicts. Can you please
advise what tree it is based on?

Regards,
Simon
