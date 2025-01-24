Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C304CC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 18:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4139880ADB;
	Fri, 24 Jan 2025 19:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bdV3jC/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 296B480ADC; Fri, 24 Jan 2025 19:56:51 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E7C80A52
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 19:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d7e3f1fc01so4894762a12.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737745009; x=1738349809; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RjyJ/RZnlcaliFpCU7Doqr0Xws3YKEao2bLSQDl5duk=;
 b=bdV3jC/OiYmD7yvoMZyvmq/eldfcZda10/LUtTK4F9F+IGozl4MRjnvZUq32Q2JK9C
 1hJiV7zoDzntaZQXh9TRUaU2mduB8J84AGDfz9CiXr89jzLyf2Jgh6kOE+hZZMbdi5NL
 S5PDMZA+yNacHCAB1ZKUb/GDzlIZyjC4OxP6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737745009; x=1738349809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RjyJ/RZnlcaliFpCU7Doqr0Xws3YKEao2bLSQDl5duk=;
 b=Z+OZst3seP8Z4NzdbLTvlVby3szRnlT9K2aiBSTH0yXXK9lR3GPc7B9p0VpTl6X92b
 ya2kUVST/PA9Naxo6olCumJng1TzdQqOmC33XmoZN+73HJ2SdcvpstjhJlU9sqqgbIAo
 zoct2XSnTX7REaKSkUAZ6Ewd+Utj8336s+rj0412TVy1Xg8Fv4tVeIL3zPnhDemkX0zR
 IJDjofzoVKcExjUP1y4CLoNtL3t7jftuu0DVGME6bVOzzOaGfRYfjnKPS66sfexlkdBQ
 jO76tTtdsbCZ1xMUlEWC5WjaxsEH4R/DsstcQmEiAiPoE474S8usiVLCd7eRfDFk0bQm
 S0ug==
X-Gm-Message-State: AOJu0YzkfIPV8P6O5pKxIyTDU9pHEdu/pHM1pSExUJY2LOt5P3KiEprB
 fddqat0M0+4bIz8c+YC15IfT3/LWrsH5E/gFYH3s1a9haqQbCLyi//Oel311yJ+Pkt9H92/ktrv
 TLQb4MRruERg1Be+BH/mMnyAplqpuFcmhQo2R
X-Gm-Gg: ASbGncvdmcaUhczGedTIlv7EiQJoRWYd9xDV7WXTGVKqkgrCtw/28aVXZuMLCHTEdQC
 yr4JouIbnLg4oVXxWxm6/iPgQIENElY/1bfKIz5vxirtVGtNkwB1aJh+bovsK6Iw=
X-Google-Smtp-Source: AGHT+IG2dxbzWpa+399yozB24Ydc4q/VjyJLRg4POmS76Ll8CChMjo8wx6ncUozgS44kmsra6rjbmcE4s4lx6Qyltx8=
X-Received: by 2002:a05:6402:348b:b0:5db:67a7:e75e with SMTP id
 4fb4d7f45d1cf-5db7d2ec452mr29222771a12.5.1737745008663; Fri, 24 Jan 2025
 10:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20250120212613.516664-1-sjg@chromium.org>
 <20250122172420.GO3476@bill-the-cat>
In-Reply-To: <20250122172420.GO3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 24 Jan 2025 11:56:36 -0700
X-Gm-Features: AWEUYZmctS5B3in1hFUUwjjx6J4bJW6gRGJ7iT2lbIkSL8NFx4S6uwY8rat_1AI
Message-ID: <CAFLszTg5vi8ioCB_YwNnUJefYGMU+Wu8Wmcp3QduECB_F5gBsg@mail.gmail.com>
Subject: Re: [PATCH v2 00/44] test: Improvements to ut command and test-suite
 running
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Gendin <agendin@matrox.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ion Agorria <ion@agorria.com>, Jens Wiklander <jens.wiklander@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julien Masson <jmasson@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Massimiliano Minella <massimiliano.minella@se.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Stephen Carlson <stcarlso@linux.microsoft.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>
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

On Wed, 22 Jan 2025 at 10:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 20, 2025 at 02:25:22PM -0700, Simon Glass wrote:
>
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
>
> This is a size reduction when the tests are enabled (and so seen on a
> few in-tree configs), nice work.

Thanks.

Regards,
Simon
