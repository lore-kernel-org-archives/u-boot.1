Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D8BC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 00:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDE280834;
	Fri,  7 Feb 2025 01:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LygPg/kp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852058003E; Fri,  7 Feb 2025 01:49:51 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ABA98096D
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 01:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so277539266b.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 16:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738889387; x=1739494187; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JFZlbzOAPOsiJPu7qNkKUS5Rnjzq6Z+zDmfTci18k6M=;
 b=LygPg/kpwueZcvttpcXxovUt03WNr6WP7IPoDkqqIEuBP52hH/ILPET/knOdKTKzed
 JAyE0LUoQQ75d2gsL7140qZ2LeduqRGjS+A3ZrlPtBpffsQdrKs64xGgMWOWdBQWaiCq
 6nNX/8dGT2huJYXNZQL7mgCuJBYeZlPtjHXZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738889387; x=1739494187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JFZlbzOAPOsiJPu7qNkKUS5Rnjzq6Z+zDmfTci18k6M=;
 b=pWdgooGNEtjTse3u71HwfbvaSFtI3NK2CBxF7wLCPwP9P6qAxm/dF+sftawGYhsXao
 9nGZxuWExcGtBhPmTy6o1C8oYW9ODfcFb/8nxZ4MmRa/murm88sDHKv1XHNkLt0vHlyD
 8VDQGleruM7z52qber/yza0gW8vi4VPqqYKb0lgrk1WzSTPOu8MquyU3gxjjwCciNToC
 28MBkTA2Op51zpqsJohnA1sQsS3CRe6i38+lpxvDqgrl7J5YnlyGONGUpQQAMAJQXY+h
 5GfxsZ5JhZGfbZIk9Fydv2DkujJy7VRnOL0vNYNMozljOnThu2qSaTCHAmLyBkqWTrQm
 fz9A==
X-Gm-Message-State: AOJu0YwSb8jf2ZCWQmm/XN+Y7NiDzg2iS5Ez0ZnxQimd2qGd4uEtbaR6
 6wKxrCjMQ12qRYmpUgKAjY4rRA+34K2Vsd3daz7REW/AHE8rR5IiK90t/om9CNMwlFZAAhvVpjm
 0K1b1jRqK9XyxijZZ0Y6lik5wzOH0yS1RBpvF
X-Gm-Gg: ASbGncvvGUoQMg8HTTNQZCyYHLX+/pCcUIBNnbYVZdLvvQx41Wjr+25WlfyH03I7JSX
 LPIi//4O0ZCoExyY6urhQko1gQtD3URqVhdwEhrJRJ2z+3l5uBKNOtx0oxARlSW0h3oiHtfgZsw
 ==
X-Google-Smtp-Source: AGHT+IHZVHkPlVt/Erdk87mxWtUA1RV6XNXS6+vx+1m6+BtL8ETZlNwx82sVywSI8579A6MhQMPxCQScCTJR8nYJKRo=
X-Received: by 2002:a17:906:4fd6:b0:aa6:79fa:b47d with SMTP id
 a640c23a62f3a-ab789a681a3mr97968466b.1.1738889386852; Thu, 06 Feb 2025
 16:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20250205143641.65430-1-marex@denx.de>
 <CAFLszTjshfJMxZoj=aZdCmDzTNRz1rRdphHb4UT9uBwKf5vS9g@mail.gmail.com>
 <b492494b-15a0-4b62-9600-40d9525b8a00@denx.de>
In-Reply-To: <b492494b-15a0-4b62-9600-40d9525b8a00@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 17:49:34 -0700
X-Gm-Features: AWEUYZmaHtHz3EF4nRPEEy2q7C0LgIvuYXZLNLkLEdJmRGFEz8phnqcDC1hpjxc
Message-ID: <CAFLszThzW5jqd4685vwpu9KcjKQ=A31zJ1jbXKSkv1-tfoY8Pg@mail.gmail.com>
Subject: Re: [PATCH] tools: mkenvimage: Add pure shell implementation of
 mkenvimage
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Thu, 6 Feb 2025 at 13:52, Marek Vasut <marex@denx.de> wrote:
>
> On 2/6/25 1:38 PM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Wed, 5 Feb 2025 at 07:37, Marek Vasut <marex@denx.de> wrote:
> >>
> >> Add implementation of mkenvimage written purely in bourne shell.
> >>
> >> This is not a replacement for mkenvimage tool, but rather a simple
> >> implementation which can be used in environments where mkenvimage
> >> itself cannot be deployed due to various constraints, like hardware
> >> manufacturing plants, but where bourne shell and basic tool are
> >> already available.
> >>
> >> The external dependencies which are not shell built-ins are gzip
> >> and grep.
> >>
> >> All mkenvimage parameters are implemented and compatible with the
> >> C implementation of mkenvimage.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> ---
> >> Cc: Joe Hershberger <joe.hershberger@ni.com>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> ---
> >>   tools/mkenvimage.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 126 insertions(+)
> >>   create mode 100755 tools/mkenvimage.sh
> >
> > Would it be worth adding a simple test for this?
> Sure, is there an existing test for similar case I can look at ?

Well test_env_text is something I did for the env2string.awk script,
so perhaps something like that?

Regards,
Simon
