Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067E8C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640A580EF4;
	Sat, 25 Jan 2025 23:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jJpBK2XY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C166D80F10; Sat, 25 Jan 2025 23:56:16 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B989080ECD
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5db689a87cbso6535668a12.3
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737845774; x=1738450574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xd4dvy1Y2oxWlJ7mfazYntAg6lP4ZRRtdhQ1KrhnpYo=;
 b=jJpBK2XYXVD1XDky4+qERu+oxd9um30POWtsOfODr6uL1PJY3D9NDeW2GrddiPDoEt
 EpoLKnnNOf77C+i/ntGqVXuxjWKydJf+B5ffZxKQsnwdQ6iOK/CioLyWGe3HSKLUnc95
 E8XfRIsxczLQ4GqCUTc+gceZL9+hdSfXYUUSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737845774; x=1738450574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xd4dvy1Y2oxWlJ7mfazYntAg6lP4ZRRtdhQ1KrhnpYo=;
 b=QEHZvre2t3OUGf0BdJHEizKP3aR+X1/srK0NAMoT1unLw+oY3P5MJ7gCyKYULj9zGR
 2Eojsh79GP2JFKyh804MM/ye1eE5ZDN9GjgG7oESInJG6K5I4+z6nIs7Lc/xlji84cY4
 qi4JlzlUt/jT5f9zVE6UekmheDP2Cf8XlX+NIUeBEiQVIxnzi3yT1tnlHyyu3zkZbGF1
 UQ3YPRFpqrX7oa+Wt6RxaiBtHpzYIhvKJSRi6Xr4A3f2hx+wZkchKOewjQLYWsqhAP3M
 mFESCGi9gPmnQnER/EjbM7iT2ngTGUC8OYnqGVJyAZPQ1Wr22m5+X9dDIVMOQ27gCc57
 W0Qw==
X-Gm-Message-State: AOJu0YwgQOu80D42nj3gtPQInA+Lr14/eWSpAlRhcqfCUWA6E3bCttzV
 9mnfyMkEbGN9zUylb07yTv3CbXOhT75HWj9Q3mQ4YZAQlfUZCcZrjrnYS6vwYz9bQXfMi2lBIKD
 i60FhPoF+ATSZMeW8aDUbCLPuSxKFD6eLswDe
X-Gm-Gg: ASbGnctmZHVCXaMzi7AFE9bjcpnoN8PuO/96LGSOFlX7dzL7tN5B7U1vNxxHDG7+eMk
 XO07lwT/WMntIDfliO0M2RP9Q8SVxGM41dMqdDdpqv7PJksWytdtXsfspBoW7pVY=
X-Google-Smtp-Source: AGHT+IEBwNfmKLqmDjez3f7siFJsZXtOEKLroi0SjBZr5f6dL2En3WDMPCzyxrKTKCWxrkCsNcCiQBQxBpEo9AUAeBI=
X-Received: by 2002:a05:6402:26c6:b0:5dc:545:40a7 with SMTP id
 4fb4d7f45d1cf-5dc05454350mr12794957a12.12.1737845774216; Sat, 25 Jan 2025
 14:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-5-sjg@chromium.org>
 <20250125214443.GD60249@bill-the-cat>
 <CAFLszTiqhKn4DF0CQg7egocvvVTu_NhC4BgGaOV6j8zbDXkoxw@mail.gmail.com>
 <20250125225042.GH60249@bill-the-cat>
In-Reply-To: <20250125225042.GH60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 15:56:02 -0700
X-Gm-Features: AWEUYZmjmWnjwIs776U7rxQ1fNtR26c_R6gNtAoxdpCG7Z5SnAXlRB6jQaVJx0c
Message-ID: <CAFLszTgc4=gFuDuZrN0LYRrN28w6QZPQRWdvKSzn4rq27RyEUQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] test: Make net tests depend on CONFIG_CMD_NET
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Love Kumar <love.kumar@amd.com>
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

On Sat, 25 Jan 2025 at 15:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 03:47:26PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 14:44, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jan 25, 2025 at 02:31:39PM -0700, Simon Glass wrote:
> > > > This fails on samus_tpl as there is no 'net' command.
> > > >
> > > >    => net list
> > > >    Unknown command 'net' - try 'help' !
> > > >
> > > > Fix it by adding a condition for the test.
> > >
> > > For this part,
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > >
> > > > Add a blank line to keep pylint happy.
> > >
> > > Can we silence that pylint? I don't look forward to the churn of adding
> > > more blanks everywhere especially since imo it doesn't improve
> > > readability either.
> >
> > Yes, but we would want to do it globally. But it isn't really a good
> > idea IMO. We are trying to use PEP8 which loads of tools expect...e.g.
> > my IDE shows warnings in this case. It might be better to just fix the
> > problems.
> >
> > As to readability, I'm on the fence...in practice it doesn't matter
> > much as few non-trivial programs have a lot of top-level functions. I
> > would rather keep the tool happy and use the Python style that people
> > expect when coming into the project.
>
> Yes, we should do it globally. Can we not globally also tell tools the
> deviations from PEP8? I remember back when people would argue about if
> we should tell file editors what to expect for whitespace, etc :)

I'm sure we can do anything. But why deviate? Is it just that you want
to avoid churn, or do you actually not like this part of PEP8?

Regards,
Simon
