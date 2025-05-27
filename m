Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4F2C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 08:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3964F82AFC;
	Tue, 27 May 2025 10:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eO5I0MwI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD28582B0E; Tue, 27 May 2025 10:21:06 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01C482A36
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 10:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-60477f1a044so2975952a12.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748334064; x=1748938864; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EZklb2m37WPLWZ15Rhv7FArx1SPFF/PUgqDKZL9WCqM=;
 b=eO5I0MwIHItE3WrL3lU6yIG7OBKszaXIKhJcNcha+xOb/g0CZIXzWKH6aV8yzM4RY0
 Tq/YQKgkvVu4so7zSnb8CFqt5d9ymZjKWOiB9wVRCoKxXtSkErhz132V0+U9WfLa34Z1
 lo0bhjkTAZvew6zp9EKANkD9e1HbvkW1IRDKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748334064; x=1748938864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EZklb2m37WPLWZ15Rhv7FArx1SPFF/PUgqDKZL9WCqM=;
 b=h3uFkLW9LEgx8cQJo2JluEr5BvlAaxPD/bEEz34jtpAA4jRk95HUEj4uqxWNQRGXin
 gwqf7euBMdoJQHAt7CIcDl4WgSbzFxKBR3b0u8pnBMFqLMWLOLIGc6HuIJ/Q+nlSOoVX
 g73hzyJlkIFpeVVhRS6kd1koZtckpqZ9ypYM8lxCQZHAJ5zlzJOaGjk0Fefr9rLGoOX/
 kPffQ9ha2DOLyb2kMgwyUZS+a+tiOL0bMYx3eUowIb1P5gKGz13xi/cFU8zpTGDV+Mn6
 9JC1MChDxK2+MewqyaZTDbZjEcWyt00T7FUBZawkmvnZ7Fn2J+/pTFtdrguHjX8j2n04
 KdHQ==
X-Gm-Message-State: AOJu0YzcWCA/4q4BhByFsU3Qpdn0LPn1k7t0xI91aE0tp+UdmHkuI2Gy
 tJG0bAtcE5oPt17hPg+KoqfmQKNhDXqZ4rpdPbrvK7n9BKNLy2SIIBArUH4A4PUA/BaR7Qdok9t
 SwXZ4K5BpvRsBwrcSnd+L+RpNjbse2pFAsS4PLIFe
X-Gm-Gg: ASbGncv3PFze6LwT3+F4Ie5Ln2SgKZBkrQbdhO6DQkUX11Y/APKyRPO66P5624jgJPF
 kSWffOzwRZC+mwPIHRpqgNrZt/62lNTMCJfGcAwT1KkFixt6/hjZp/so80ZA+usxS5xFhO5/H/5
 y5/0JbA10ZyqfEzB6PQEicDp1WRtOG5xI=
X-Google-Smtp-Source: AGHT+IGwBvNVkDo7/hvMVew7L/St9gffcWhbRXjZXoev1hAYOV9XKGuXsh8ta5n4KgbR4OTCre5umEELGoh3xeIZM4g=
X-Received: by 2002:a05:6402:2803:b0:604:becc:2f6d with SMTP id
 4fb4d7f45d1cf-604becc3233mr5193783a12.27.1748334064168; Tue, 27 May 2025
 01:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250524054245.409399-1-sjg@chromium.org>
 <97e69b7e-0ecb-4d30-945c-d2c32438149f@cherry.de>
 <CAFLszTgKawD=zj3tC2fWJsCv0Hpjv9eNaLcO7XVjn6SA8iFi-g@mail.gmail.com>
 <2ce9478f-d2ed-453b-8d75-c3d5b36efd32@cherry.de>
In-Reply-To: <2ce9478f-d2ed-453b-8d75-c3d5b36efd32@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 May 2025 09:20:52 +0100
X-Gm-Features: AX0GCFtMgFJHLQshgFluXUYN8PFPN_ES6lfp-bdg1hIY_oTpmFxVgkIVyAKGkX4
Message-ID: <CAFLszTieJiR5UhjkeknXR6pXfFrxq+d8naaKAFox-_P2ZvnZyA@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Use -c flag with bootdev order
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Mon, 26 May 2025 at 10:09, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 5/26/25 10:35 AM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Mon, 26 May 2025 at 08:48, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 5/24/25 7:42 AM, Simon Glass wrote:
> >>> Update this command to use a -c flag rather than a special 'clear'
> >>> argument.
> >>>
> >>
> >> I don't see the commit which adds the clear command to either master or
> >> next branch, so maybe just fix that in the original commit before
> >> sending a pull request instead of via fixups?
> >
> > Tom rejected that series (or 'changes requested' to be specific). I
> > added it to my tree in merge-request 68:
> >
> > d93f42d6e3d bootstd: Provide a command to select the bootdev order
> >
>
> If changes are required to merge the merge request and considering that
> you are the owner of both the patch being fixed up and the merge
> request, maybe sending a vN+1 instead of fixups would make sense?
> Especially if you haven't sent the "applied" mails like you say below?
>
> I would rather avoid reviewing patches on top of commits that may never
> make it to the main tree.
>
> >>
> >> Did I miss something instead maybe?
> >
> > I didn't send out my 'applied' emails for this series, so it was
> > silently applied to my tree, so far as the mailing list was concerned.
> > Tom wants me to operate my tree silently so I don't always send the
> > emails...
> >
>
> I don't want to pour fuel on the fire but this whole ordeal between you
> and Tom needs to be sorted out, I'm essentially not even looking at any
> of your patches anymore even when I'm in Cc/To. From an outsider PoV,
> the situation is confusing and frustrating. Please do not take this as
> an invitation to include me in the "fights". Nobody likes to see
> arguments lasting months even if they are not part of it. "Fights" may
> sometimes be necessary and healthy for a project but this has become
> anxiety-provoking to me, hence my reluctance to look at any thread you
> both are part of. I also want to be able to again trust that the few
> reviews I occasionally make on the mailing list are useful because they
> are for patches that have a chance of being merged and based on code
> that was merged or soon to be merged (in a maintainer tree with high
> chances of being merged in a subsequent merge request to the main tree).

Thanks for your comments. I fully agree.

Regards,
Simon
