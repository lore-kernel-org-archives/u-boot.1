Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FEEC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 09:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65BDD82991;
	Wed, 28 May 2025 11:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ECzuvK+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B942483A24; Wed, 28 May 2025 11:35:40 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A7848070C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 11:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d35dso1406339a12.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748424938; x=1749029738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=06z9JUxpK3c73by+kPC+fzNAMVijopd7Ys46+F+a/78=;
 b=ECzuvK+2U/KdC2ztQWJLNOf+nVK6i9Movc+OzsFE7sB3py1HC09UVV6sJuB3cN+24p
 QGBHCxQL49U565fr4jerf8EnZyaznieox70Q5iMHkKGdC73UagBG32TWC5cKO6nGwYTZ
 px1KqnHqU0KjO+PYiF1LRcu236n9TyqIIM5Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748424938; x=1749029738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=06z9JUxpK3c73by+kPC+fzNAMVijopd7Ys46+F+a/78=;
 b=vC3naaIwJGf4350lCTDVwkCFJ1InPMpmaZgOA+gPAMtdjgWlL6r43C8wb+maP3DWs6
 ZeDf9SpUEnIXlxHXBK68sppjBFeGwlfLgw+RXFUy+ahMblvOMB9HlEN/8MCle8ej8it7
 49RU9Qr7R6YFF1osPA3CmxsOMAVGwwqVyxYmTTTG8zLI9QpVjQZ2W3zSNMv2gqeNf8s7
 U1ieCZFCLw3/z0Fdy1ylsHHplA4ShWfU8U0bmLHWEdepAylZMduWjvRA9j/jFlpcZ5Cx
 iel3cnvTKsRgAtQW+APO4wdonNsUOvz+m0dWhsAN0rAO99NPeaCBrpydUfsyGBBjU8FG
 5NKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9BlCXU52n352SVSa94VcylJRmYpUlKjS1KunYYM1p7JmV7qi207SfQepTcohhLkk9eya4+EA=@lists.denx.de
X-Gm-Message-State: AOJu0YzIZgB0JSO9o/697v0ocScSjUxuhN2wno8YwJoKKUzJ+23G0juG
 sxp7bfJTgRvkPpMqGIJ7hvuCpcLCSz71N2OVnqGsYnmpAyg5sDyQG1UpIlinZzoCUCKsBJTV//v
 LY1Fn63rwOpyr2VriYwlCDrTT6XtjTUiYsRzjiyRR
X-Gm-Gg: ASbGncsvAdDm9DxkheeEOP+730mrp8MUktX4H/cT1qaQawygFO5Yt36LnnowdtsOIS6
 0CuN+3ojqubJ72cG4p4S0rCrGk5id0P7icuhYg46K/iB2/PHz5CG37OOGSzYYatoGr85MybMZqf
 pguqXyhYx1APtPeugjlWBYTU2sNWGViVe69Aq9Zy4jsg==
X-Google-Smtp-Source: AGHT+IFIHEtK9PyR1VwfbA4f8GyTVZWsQo81zpkOXJkFgZRrKMBHq54jSDGuXDN5yg+MERZtIXYWC0pIbbO6Ej4bXdg=
X-Received: by 2002:a05:6402:27cc:b0:602:7de0:b30f with SMTP id
 4fb4d7f45d1cf-6050e58b1a6mr3319781a12.16.1748424937893; Wed, 28 May 2025
 02:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjtw8s2NnrS+B6-K8i_YF0ZGU9JB+O_vNYmT+AD7Km_AA@mail.gmail.com>
 <20250526145128.GW100073@bill-the-cat>
In-Reply-To: <20250526145128.GW100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 10:35:26 +0100
X-Gm-Features: AX0GCFtsMeNCBiOI_yks-a18-nIsExATe1ScuacXA7smPb0oDsFJkB4YNuZpLhA
Message-ID: <CAFLszTiF_3hMcgL7g6scpHRPa0wdmZSbKL4wfe+YYS5Wv94OJg@mail.gmail.com>
Subject: Re: Booting distros in CI
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Mon, 26 May 2025 at 15:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, May 26, 2025 at 03:10:49PM +0100, Simon Glass wrote:
>
> > Hi Tom,
> >
> > What do you think about having a Linux distro in the docker image so
> > we could run a 'boot' test in CI without needing my lab?
> >
> > Alpine Linux has an image which is about 250MB.
>
> I did say we should be doing this in some other thread we had, so yes, I
> think it's a good concept. Ilias I believe has been telling me about
> some HTTP (or HTTPS) boot pipeline Linaro has for a while, and with
> Adriano's patch to add a simple web server to CI too, yes, a pytest
> doing that would be a good next step forward. I'm sure we can find some
> sufficient and small stock images to fetch and use.

As discussed on the call, Ilias / team is planning to take a look at
this, so I'll hold off for a few months on anything here from my own
side.

Regards,
SImon


> --
> Tom
