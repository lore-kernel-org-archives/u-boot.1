Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B556D591A5
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 16:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ADFA88CE7;
	Tue, 19 Nov 2024 17:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A32+L3Jg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E4D894FA; Tue, 19 Nov 2024 17:49:06 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACB2C88C44
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 17:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb4af0b6beso51062401fa.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732034944; x=1732639744; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+cTeg0L/QKlRFelZ0IeMFjLOE2yFeH88stWyE7fdI1E=;
 b=A32+L3JgeABKQvh0wN6hPDKBpvRMtEf3FxTFpSkWnZtHctYJ3B25d0RntGCk98K7EV
 zFYwhn+Hsz9M7JERWryGWf4u8zO9/RrdkF8AVzHnfspc9K6jzPvHijMtVO3FvjJR8QCf
 FKGNrla0o7oXYJsNnJvmyMNuw8Qmck0RTqq0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732034944; x=1732639744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+cTeg0L/QKlRFelZ0IeMFjLOE2yFeH88stWyE7fdI1E=;
 b=BiQbV5HUP26QIRV3hag6tEq96ClgyvxhNIH/RPs/rqcR3rkYk6pv02KT0te2Ytt73+
 j0EO5HhunNo/Ma+AeYddNuIjQwWkJxfbGPdU5BkyIMg9a1Jvh2Xo0hM7mhSXpiDJC6WO
 1FHAqPTbLPtFfxtqJh4NcwnJlcbGB1ZzDASC9BpiVYlsbg5OWjqpjUYF0HuwhbkaCdWb
 /4ItSPohjgnnPXxvqu/w+ihDsbYF7UIqar6aTT2u7PYPRkeTztD3XIMwfOfeTQ5OUDDA
 zqrsEhji1WJCfAHDbaFF0YHEzANyu0y2qAIW0kyrHbbM4XNn+4ePzXN+2fUGC35QRE8q
 DCzQ==
X-Gm-Message-State: AOJu0Yy8HSB3SNwdGKnUTkfWOUgMiIYtDRv4IejUIdbxYfwKQR9cjBmV
 mWPdcD2jpiTVqP9tsHvIwdpkYyCyV4ef/76hjc0mmongHRd6JjRWgqdXN3E3HbsGTZL0p6WUJ9P
 YbNGtw3ZxnjsQepyTHCrJo1Uia9WATxqid6Fe
X-Google-Smtp-Source: AGHT+IFUaUMZ51Dh1Ny6U4Y//BSvVfY5ORLuF7X0gIcEgvH9rJJDIiQArkR5miGVddgylo/6VVUxq9NAvXyb4gMxyQU=
X-Received: by 2002:a05:651c:4012:b0:2fb:3960:9667 with SMTP id
 38308e7fff4ca-2ff6062b084mr72277511fa.14.1732034943890; Tue, 19 Nov 2024
 08:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119162730.GX3600562@bill-the-cat>
In-Reply-To: <20241119162730.GX3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Nov 2024 09:48:52 -0700
Message-ID: <CAFLszTiWLtZFC4A8JN2cW5NAVwO1RGnHm_HtKvADxr8XHR8Htg@mail.gmail.com>
Subject: Re: [PATCH 00/39] pxe: Support read_all() for extlinux and PXE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria <ion@agorria.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Tom,

On Tue, 19 Nov 2024 at 09:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 19, 2024 at 06:18:05AM -0700, Simon Glass wrote:
>
> > This series implements read_all() so that it is possible to read all the
> > files relating to a bootflow, make adjustments and then boot.
> >
> > Unfortunately quite a few things stand in the way, so this series
> > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > required support in pxe_utils and the differing code in the extlinux and
> > PXE bootmeths. There is very little new code, but quite a lot of
> > refactoring.
> >
> > The bootm, booti and bootz commands have all been refactored previously,
> > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > At the, time, zboot was left alone, since it is x86-specific and a bit
> > more trouble.
> >
> > This series adds a programatic API for zboot and uses the forthcoming
> > bootstd 'image list' to collect information from an extlinux file. It is
> > therefore possible to parse the file, load the resulting images and then
> > examine/adjust the resulting bootflow, before booting.
> >
> > The addition of options to extlinux resulted in the PXE and extlinux
> > bootmeth having slightly different features. This is tidied up in this
> > series, with common functions for both. This allows the same features
> > (loading images as a separate step) to be provided for PXE.
>
> This doesn't apply cleanly to -next and doesn't say what other series it
> depends on.

Yes, that is a bit vague, sorry. The 'forthcoming bootstd image list'
is the dependency.

Regards,
Simon
