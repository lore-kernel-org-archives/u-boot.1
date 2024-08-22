Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DD7C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 17:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8799A881A1;
	Thu, 22 Aug 2024 19:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KM3cQET+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42713881A1; Thu, 22 Aug 2024 19:11:26 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A4F8897F
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 19:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a1d3874c1eso64113085a.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724346682; x=1724951482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=36Yf5jRFcPmnP6163EkcSjebiRDfRx2cTNbefeA7PZY=;
 b=KM3cQET+ROEJNLjEDW5qEljtun69K5Ejiod5VQ+i/0JTAyMAIL0vBWVGq53oXxQBNv
 Af3tAWzllO1C9ya7kjjp3hQK3lQTZZonnhb+XYEQFErtwBbi8oOabM6C1dgH+3i3Z9tT
 FgAlswPI61af5xDlQ1XZ5zTtUcd90GxjGLYwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724346682; x=1724951482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=36Yf5jRFcPmnP6163EkcSjebiRDfRx2cTNbefeA7PZY=;
 b=xOsnAwuHTqhn0s2MGW20cDvIuMzvppI8S70kBTwE6FKImQ6TfkO6gY6y7yZY9JiNq2
 sz3BoYvUMdA66NCf/BpQIUokuvw45CsvRRiBK7vtDEuJBbJgN/WFY/sz+3pxmqDYbyRh
 O/fhOzgx1dgmOTV7lyON7FuFVBnc42sDKgtzcSdNcNXRWRKoTJiYxiTgXbzlo8f/Q9Td
 qlvu4UwPPWlQLYzQfLNN58TslX/4CJqS1RH3ekqN/YBdaJvguArI41PR3pdBmIrimnHE
 6dExg/w4B0uWF+AXJa3o0v1pNTG/y+MmH+m5lq+B5ElOrLcD3SySAUYUPtSjXoEbe9FV
 TLeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgO0FR/e6dORN7AK3cRTbqwd6YaSQcTrhrnNpcRXLrbEPwsppIzMZw0H0GangKwEAYbKuLrc0=@lists.denx.de
X-Gm-Message-State: AOJu0YySQUAd9NF0nR37j53KUSD/88pQzGj+hvnB7ERkk20JzjaCNOWS
 0LJrFTvgIug7VuCrSQ75RAcEjTj7Hkokopinu3NsQbiIouPNrPacAfUYmuhW4pZFCrt34C9uG6J
 NJCC8nekfad3GMwnUg4C3lfdnhYfzW8+8g53+
X-Google-Smtp-Source: AGHT+IGnU/KJmMlFvB3rU5tBXEmQagDAGArK1L4+I2aHe+Cd+saAQrgVJhX/QLfRYFr5hXQShlbWyojd0VS76gf7hkc=
X-Received: by 2002:a05:6214:4b02:b0:6bf:6a6a:8996 with SMTP id
 6a1803df08f44-6c155e279e7mr93543306d6.50.1724346682187; Thu, 22 Aug 2024
 10:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-38-sjg@chromium.org>
 <23093165-6af9-4582-8448-7bbae3c86be2@gmx.de>
 <20240807015613.GD1626301@bill-the-cat>
 <CAFLszThhn0240xt1j6GQB9QTKxiHiAg6J3vMXCnHBE15iYZSkA@mail.gmail.com>
 <20240808200634.GR1626301@bill-the-cat>
 <CAFLszThM=23AXCOfZ_uOyGGDQTRurDpAjR-t8X_NHjz4LgQ9SA@mail.gmail.com>
 <20240814175601.GP1626301@bill-the-cat>
 <CAFLszThU+vLUm_fveWUgV3Qt3J+F3=Sr1aBgbc4T5z8zJJz5sw@mail.gmail.com>
 <CAFLszThG_oM4B3beUfOrjXD2-B3sMo44U5-G-J8Eky1uZU=bAw@mail.gmail.com>
 <20240822151322.GU1626301@bill-the-cat>
In-Reply-To: <20240822151322.GU1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Aug 2024 11:11:11 -0600
Message-ID: <CAFLszTh=bJ_W7d61OS33+Yo2f_Yk_XAPE5XSH4MjoWucJ9mDCw@mail.gmail.com>
Subject: Re: [PATCH v2 37/39] efi: Avoid using sandbox virtio devices
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
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

Hi Tom,

On Thu, 22 Aug 2024 at 09:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Aug 16, 2024 at 05:53:59PM -0600, Simon Glass wrote:
> [snip]
> > > Some notes from a little bit of digging: There are almost 1000 sandbox
> > > tests (17-20mins), but qemu_arm only runs 62 (2mins). With 'make
> > > qcheck' it runs about 2500 tests in about 4 minutes. I just got 'make
> > > pcheck' going again and that is a little faster (2.5 mins). Binman
> > > tests run in parallel if you use 'pip install concurrencytest'
> >
> > While on this topic I forgot to mention that the sandbox tests (~800
> > of them) actually run in about 10 seconds. Try 'ut all' (although
> > you'll need my test-fix series to stop it crashing).
> >
> > The reason pytest is so slow with sandbox is that it talks to U-Boot
> > through a pty. Stephen Warren did something clever to stop it being
> > horrible, but it is still very slow.
>
> Seeing about addressing this more would probably be very helpful then as
> most of the runs (by user, I mean) happen via pytest and not directly
> running sandbox I strongly suspect.

Yes, there is a long thread about performance[1] which makes for
interesting reading these days. We do indeed have >1000 tests although
it took more than 2 years. The Python approach is indeed quite slow,
although half as slow as using the real 'expect' library.

I do have one idea that might help, so I filed [2].

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/1447570381-1361-1-git-send-email-swarren@wwwdotorg.org/
[2] https://source.denx.de/u-boot/u-boot/-/issues/39
