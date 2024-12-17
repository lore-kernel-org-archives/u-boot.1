Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2394FE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DFD801FB;
	Tue, 17 Dec 2024 20:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JKhXJc7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C15FD801FB; Tue, 17 Dec 2024 20:45:45 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0164A80291
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aabbb507998so495705866b.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464741; x=1735069541; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8UGrVxyaFH8Y5pQIFOikwzfpqnm0aeFnARpNQA9iNA=;
 b=JKhXJc7xJYUL40yIQhgpYVCpenUM/+qbuu29saEBcz3Sx3FR+gCSWhySTaX0OG55uM
 eMw0fg1++aZPD9oR+MZOvSgKOgJ6qFkAdoRGNkVNuAA9fwhK6Mwn8CM994FgivZvMAsZ
 lPZ0AXGkJfCBU7VUZaJBhP49hjQ/vxL8vmEZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464741; x=1735069541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y8UGrVxyaFH8Y5pQIFOikwzfpqnm0aeFnARpNQA9iNA=;
 b=rubpwjpSfu+1QSvjnqWMQzXT89usE2Frrw1VXktn9f2mCIRbtjbh8DNbXYsZpuUUOQ
 RNvbz/MPsG1BoO6UnpigJBfviid/SnF1Xle5plj4mCLIVpCQ3YVWAbEhcoMwYt7G5952
 V2JvpmudeHBNFKfWlNZME60SsYtlVsRVxGUMknelINQzdBFgN6VqNqcnvSwF7KDx6eD9
 Chk7hHkMi67WSmd/D2W/Dws+W711k1/hvu1MwzJdwPYleGY2I7LHOI4rBWunWXLBCOYK
 dMCW6sbBR7eD0jR/obiBHOrcAGd+j6IpDre4QujpVfW0nx+6FjBqFAjMcj2+etcyoemu
 ZWKw==
X-Gm-Message-State: AOJu0Yx0gR8fz6eQovJtJPS5+jZJIA6BOlBSq089gGW7LVR5YRMO2TNP
 uR7V90y42K0b7AWQWPIvIMZHo76nKD4OLX2mi6eZ6b0riBS2HQHeXiciqe9Zjd053i9rR0f83fL
 OYSRkt01+/Y5V/D4njfcn7TWIRtApr5UKoCXY
X-Gm-Gg: ASbGncs6aaGRXhEg2irXBcVQ2kwj8jE+GlflZdCfC5z4IyZHVxBPybHxWqdEiCOn8de
 3N7fcJjDv4YACm1Guexrq1eCpEE0DoY7R0Ty843A=
X-Google-Smtp-Source: AGHT+IFdiJ43ss2qgC30m1vYLkq5T+vPgFmTAoYL9Ktuu6qVoj3af+DSPtelYjXjtdOMskAOmHw4lPtuzMHwGkVR/iw=
X-Received: by 2002:a17:907:1c8e:b0:aa6:82e8:e89b with SMTP id
 a640c23a62f3a-aabf190c0dbmr60271166b.28.1734464741449; Tue, 17 Dec 2024
 11:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20241217132616.3708573-1-sjg@chromium.org>
 <20241217142016.GK1505244@bill-the-cat>
In-Reply-To: <20241217142016.GK1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 12:45:29 -0700
Message-ID: <CAFLszTjfxxseCJUvUXPgZQWQYNrL+yT3u8qZ9OieJHxaC=dfDg@mail.gmail.com>
Subject: Re: [PATCH] buildman: Add a way to build a particular target
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>
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

On Tue, 17 Dec 2024 at 07:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 17, 2024 at 06:26:16AM -0700, Simon Glass wrote:
>
> > At present buildman only supports building the default target. Generally
> > this is what is wanted, but in some cases boards erroneously have a
> > different target for product extra files.
> >
> > Add a --target option to help. Also add a comment indicating which
> > letters are free for new options.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> How do you use this? It would be nice to be able to do "--target
> u-boot-initial-env" for example for converting and verifying the
> conversion of boards to plain text environment. Except the list of
> artifacts that are kept isn't updated with that string as well. And
> FWIW, is this for a case not solved by CONFIG_BUILD_TARGET?

It's related to the problem where colibri-imx8 doesn't actually build
an image with the default boot target.

But yes, we could add more things to buildman, e.g. it could output
the initial env as a file for later parsing.

Regards,
Simon
