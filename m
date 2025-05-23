Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB5AC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 20:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D135A833CF;
	Fri, 23 May 2025 22:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b1cDx93Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9407A833B3; Fri, 23 May 2025 22:20:49 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 700B08334D
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac34257295dso34783666b.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748031643; x=1748636443; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YXw6MeibJNmsQMS87JNiNqde2O7hdrsNnwKlBD0Orik=;
 b=b1cDx93YSlbqlktTScT4CfWQujNcMeh2t4F6R+5WLXFURuReCQjIdvMQHhJV+/pEG3
 XA2sZsW6zQGohdgQfv2uS6c2WoNCAAhZIoXIgEW/G2+POlQZkXUzYwAwLutRQjN9fv/5
 qBRQa+rD4EzUQClxm6zqDJ2AHv8VlUxby3byc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748031643; x=1748636443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YXw6MeibJNmsQMS87JNiNqde2O7hdrsNnwKlBD0Orik=;
 b=PlDx4jm4UVIPU19WeE0HbYNPszLeLHUdCwEswdAz0Y0P68PEH8Z+Rn+ehEbS5XCHnr
 vMYRQy6uPt9F+ZtqibLTXDTtxDvdbcdSsj8EvPhk2S798KTtQLhqdbABQX8KNsRISxLy
 dcx/wXbGQQcuDMj7vKWNTjcegh8MLw7NVqCCg9qKjxcl6axvYbpw+AJH1M6oH6lU/yf3
 S/UXRJEmy7mUGtnJkQ54SOVa1wlstmRHdLIDcV13W1cOJAVsaejELUxY63F442IDQNJL
 BIE9CFOgO8fGOnjv1AM4B9lKclb0+pfMHIawE82WTZc93Y2RqMwZB67Mzp6TsX/HIkpp
 FS4Q==
X-Gm-Message-State: AOJu0Yw2uP8Jgwt/bzv23GNhO1tIIRxkKKqVFGG7ricdXwknfxWye/XP
 oehKTCvdIwp7iibYujAqBbbLEht0CgMGwe5Y8GXo4taW+WkAOgsUA1JcJudMp3ODgkfXRVvOESn
 6Abp9BpgXjqyZ3Zfejc+Ari5xcFh1r7u4ubYueA2U
X-Gm-Gg: ASbGncuqG5JWDcNXhlV3Y1HErEkJr3UQDSRQmlrziZag/ZmnNYu9on5HeVz6O5Bd0B8
 o+fxyac9hNKuJ/olH23Mu9lOP4RB6ozk2wfNxF0ml1GAGF18TJO8aT1qoU4WzYdwowsESjDv7if
 MHt9mtTTE41SkW3SPzeyi6Mlhg3R9XPyhpjzPbuo8uIw==
X-Google-Smtp-Source: AGHT+IEvtgScLS1bD/3XgoeM9vVscW5h6EmdVnA8hREhs1dcxuFnQVEGiX9ZWwVrE0+aWjxyvrh2JIUAxR7y6cF52og=
X-Received: by 2002:a17:907:d92:b0:ad5:3746:5906 with SMTP id
 a640c23a62f3a-ad85b319916mr47785866b.49.1748031642901; Fri, 23 May 2025
 13:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-2-sjg@chromium.org>
 <CALeDE9M2HMxnNeiA2Cb2AXhhAeYsadP2hjSdr=+T6qjO8UWFEA@mail.gmail.com>
In-Reply-To: <CALeDE9M2HMxnNeiA2Cb2AXhhAeYsadP2hjSdr=+T6qjO8UWFEA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 21:20:28 +0100
X-Gm-Features: AX0GCFsJw7efzHcYzgotmynY1t4WZBqb2JDYyqC0If7xRK6s1WUx93z2C4JGM_E
Message-ID: <CAFLszThUn76PU8N=oJcfn2isLz4coE5paGAF98JfBeaxajYMWg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] rpi: Add myself to the list of maintainers
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
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

Hi Peter,

On Mon, 21 Apr 2025 at 11:09, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Simon,
>
> On Fri, 20 Dec 2024 at 00:41, Simon Glass <sjg@chromium.org> wrote:
> >
> > Add my own name to the list, since existing maintainers are fairly busy.
>
> I've spoken with the other maintainer and we've decided to decline this offer.

OK, thank you for your consideration.

Regards,
Simon
