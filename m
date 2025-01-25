Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1A7C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 22:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC72980EC0;
	Sat, 25 Jan 2025 23:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kFjArtB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4407A80ECD; Sat, 25 Jan 2025 23:47:40 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37CED80EB5
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 23:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6f6cf69so5428855a12.1
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737845257; x=1738450057; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o6dpnFGYcUgmVHRN7LdAOYxFwMUsYLbsy8h9+HOfhNs=;
 b=kFjArtB2KgeLfyWpqDb1jLg9XM5kOW/y9NLcE+yI107scuTW9rUfALNphYM2hdK2bT
 GywJGU/FX6GHmyhToqr8PgbBbLQ7oTWj+o+T62XDaVXjbD5/F4+i3UWfCeHlB1TToMLT
 0pOsp5qeOWJJEWsm0GnK3lZsxm/5SCa+dlxyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737845257; x=1738450057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6dpnFGYcUgmVHRN7LdAOYxFwMUsYLbsy8h9+HOfhNs=;
 b=BipKkEtUm2+BD4p/botXeu2eVNZ7e/2/yb6TucEgcKoICrMHuDRT/pMROu+Z0LCt3n
 PxuVc280FO2237W3GUq4vzM3CdTbjAal+5Lz6wpMZYfmpGuxiyurKP444+TiKscLCYtY
 D0pijXscN6d4Vsd3XgZkynkTqG6bsNlk814SJrUd6znkn5YBTdrjclsVGLzQiqWqIQKA
 qTo6tucLX6cV/sDnnbJyN/AZ5k4L8RSWwQBHBONdUzh6+f23j9aytmqx1EJrO3YfRVLr
 nzrRVrW9gxz7rml0LK0zhvmtj+GnsYYzImDk9rWQoNmk09uejxMdnELrC42HBh9zwzkV
 9OFQ==
X-Gm-Message-State: AOJu0Yy2xyYsBsVewTmCxSoRg+4pdg2NxAuOjay2Bg5zwLzbM1F/mpHH
 ojaFqgOgryWKlck58AcdpMkJS2U3CcSs9W6krlysa4B9p1LKXLAVjh4eMlZCwhGZMKr1tbMD8iT
 Yo6AquDToRO6qhOWhKrEnPWXMsfVFLP8pWjqJ
X-Gm-Gg: ASbGncuH86S/RvNP8OaOIM71cAap9BuCBowOS4rXuX9PrKxWqFZFMUt0GoyFDws9nxH
 BjpNTn8jC8Q4+UXM70biRX0uEHi/9s9ujABUJmaqussUgQzVqthwojzU9WqciSe8=
X-Google-Smtp-Source: AGHT+IGNnJ8InyTzE4aYlfHrAH8MqkE2L2aDN1hqriy8lesdRVpczEcyaFGBYaU/lvwT0bAK2mRoZOgDoV4X6xznnOg=
X-Received: by 2002:a05:6402:4403:b0:5da:b47:1092 with SMTP id
 4fb4d7f45d1cf-5db7d2f9b01mr29747776a12.10.1737845257629; Sat, 25 Jan 2025
 14:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-5-sjg@chromium.org>
 <20250125214443.GD60249@bill-the-cat>
In-Reply-To: <20250125214443.GD60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 15:47:26 -0700
X-Gm-Features: AWEUYZmtpTxF5NG-9BWzeGXSGKlKK1MaZG0a-PeRzUqtbBFYfTOpubikNIKpKwI
Message-ID: <CAFLszTiqhKn4DF0CQg7egocvvVTu_NhC4BgGaOV6j8zbDXkoxw@mail.gmail.com>
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

On Sat, 25 Jan 2025 at 14:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 02:31:39PM -0700, Simon Glass wrote:
> > This fails on samus_tpl as there is no 'net' command.
> >
> >    => net list
> >    Unknown command 'net' - try 'help' !
> >
> > Fix it by adding a condition for the test.
>
> For this part,
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> > Add a blank line to keep pylint happy.
>
> Can we silence that pylint? I don't look forward to the churn of adding
> more blanks everywhere especially since imo it doesn't improve
> readability either.

Yes, but we would want to do it globally. But it isn't really a good
idea IMO. We are trying to use PEP8 which loads of tools expect...e.g.
my IDE shows warnings in this case. It might be better to just fix the
problems.

As to readability, I'm on the fence...in practice it doesn't matter
much as few non-trivial programs have a lot of top-level functions. I
would rather keep the tool happy and use the Python style that people
expect when coming into the project.

Regards,
Simon
