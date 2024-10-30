Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE8BD7497D
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 07:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C361891D2;
	Wed, 30 Oct 2024 08:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gEA4cAKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52BD2891D2; Wed, 30 Oct 2024 08:44:20 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CD72891F5
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 08:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so899499066b.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730274257; x=1730879057; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wtWTxVAsBDAWB86Lz2sPC26mb3hIacVKAhvkp3caemM=;
 b=gEA4cAKRJdXmEyRtIdbL6tNL15HYCgT19tuM+eotRkas9UJCHMXE+hez4ZHH7FdtAQ
 yHYXhERHL5OWoiNe/Ph2ygku9lSXmLxzZ6mBcdbbCDlUupBvs2pIlLWpESZCH9dXO8XY
 fL/QnZf63lmn6//xWks2YwWhhterz+dw9EEZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730274257; x=1730879057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wtWTxVAsBDAWB86Lz2sPC26mb3hIacVKAhvkp3caemM=;
 b=WmO/UMXYqebC/5YDPmHIORnzbCUv9XBY+oNf4+VPpY0dvykhwbxhyAEIR23hesTGKp
 lWly+CjbxwkZGT00Wlz85nTGdvTwj0R+LN/A+I+tnxX0HcQU76NFlEVuw00tNKrKhb0u
 FViy2Ni0aZDn5QUcRYqOpeBzr2Z6sjDPBcG5PhCK7fTp023WsjSB4VMJxmrhcQtcef6m
 DUezn2hA2h31Mr1rzt5fo7+x00x2yatS9wCYF/ehyVWxxitbpiXjfKmMjcinvEgghQYP
 WRF2BRspC1ZQ3r8sDUKYZUQfqdH+QvoDoWYQvgepIdh8mAEvcern5G4/IxEp8d4eU0zc
 /IFg==
X-Gm-Message-State: AOJu0YxNfJqcRNjjWRYKqdUAhStCmU+VgHcdp9l4mpgsUzY0FrlM14fS
 lpYhm3z5oqAgTvW1BfoZqhco48RABjj9ZXTDQJwHCiRriCiDEZOrTNLMNCkeJamJOVpftEqIQCa
 O6NoKkxSQYNedo7UJGoxT8i8zQSV+5/V2FEx+
X-Google-Smtp-Source: AGHT+IFudhSWGAufmU7hVqdG5gcNgb7gwS9iZ4eahwD24X/I6OzlP7NU7FwZIpttNA2cvvR6DBp800rXeSZIdlLWB9Q=
X-Received: by 2002:a17:907:7f10:b0:a99:f1eb:8deb with SMTP id
 a640c23a62f3a-a9de619b6ecmr1420067766b.62.1730274256759; Wed, 30 Oct 2024
 00:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-3-sjg@chromium.org>
 <20241029201259.GI4959@bill-the-cat>
In-Reply-To: <20241029201259.GI4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Oct 2024 08:44:04 +0100
Message-ID: <CAFLszTiS3stKYmFMQTW5wh4FnV-YD+EucUDk747Uxq-PwUQ0Jg@mail.gmail.com>
Subject: Re: [PATCH v9 02/11] efi_loader: Add a test app
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>
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

On Tue, 29 Oct 2024 at 21:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 29, 2024 at 08:22:10PM +0100, Simon Glass wrote:
>
> > Add a simple app to use for testing. This is intended to do whatever it
> > needs to for testing purposes. For now it just prints a message and
> > exits boot services.
> >
> > There was a considerable amount of discussion about whether it is OK to
> > call exit-boot-services and then return to U-Boot. This is not normally
> > done in a real application, since exit-boot-services is used to
> > completely disconnect from U-Boot. However, since this is a test, we
> > need to check the results of running the app, so returning is necessary.
> > It works correctly and it provides a nice model of how to test the EFI
> > code in a simple way.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This approach has been specifically rejected with an explained
> rationale: It breaks how UEFI applications work and you cannot run
> further UEFI tests in sandbox without resetting.
>
> Since as you note, you can't reset in a C-based test, rework this to be
> a python test where we can safely reset the system and verify that. I
> believe Heinrich even noted that a test which checks ExitBootServices()
> working as expected would be helpful as we only have a watchdog test
> currently.

Unfortunately I believe this is the wrong direction, as we are unable
to check the state of anything once a reset has happened. Thus I
cannot build on this test, e.g. to see what happened to the devices
and whether they are still bound. It becomes just a 'black box' test.
None of the other bootflow tests work this way, BTW.

Regards,
Simon
