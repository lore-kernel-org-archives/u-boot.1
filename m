Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7080BC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00EBA81D65;
	Fri, 14 Mar 2025 15:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q3suqRgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A0A181D8C; Fri, 14 Mar 2025 15:45:43 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7CA81D42
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so385418366b.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741963541; x=1742568341; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kU9SlnBTRrRZwrvsZu45hcddYe1NblwVq6xwCVHCzKI=;
 b=Q3suqRgnWbMHVmF5ABcRn3+GgoKYw5Pub3+8dYDB1zVcFaEox52M7iTu6edDX8yt8o
 yLTp8d+vFl20r//DHI7HJUZG3s/2e5LTZjscbrFOxKPpqJ9DkzZK9zhP1YE8Y1qU1UW2
 +a9nhPf9KMbZV/HCX3VF+VC8Q50r42q3Xtjqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963541; x=1742568341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kU9SlnBTRrRZwrvsZu45hcddYe1NblwVq6xwCVHCzKI=;
 b=kxl7Rs+Qyq7hDZrj9rkV7v7p3oTWJsI7rJewz51zAzOOcgPb0OBSJfx0V8I96hR1m7
 4cnWBcsMjsvnSog5CwvLA8LV0X++6ZLPzmWxJKoK3qqJsUgui+5zIWsT+GDTC+gJE+7F
 7Pz5G0ohuUFtUZpaVA/6FsBLHzxOjV/0CoQs4OeXK7J503dXQ16UUHHhRMPLYsGLbrh1
 K5FrX3xa0Xec8CLEZQBFb7OdMWVnm+9njr84uBQ5/yMc6Yzf0DGfAS5qgblcQDD6WC0F
 +5O3Vv4SvcuZoy+8jUfQlgKQxY3M7k4+7eBvXZDlXR7BNfDsX6ROxXz4Hw4xpzc7PXSi
 KkHA==
X-Gm-Message-State: AOJu0YxKX1xSYnHekdJslPtCljqQkQjaluJi/dHIJoNdQOX9O/iAO9io
 qp8V7DGXYFcOGHbcqCawrY7myR4H+3L/FWZ8izmxvP3rn7etYvIL4pi8Lc4TE2t+e8K0jUO2SZ+
 DSS6ZEOXqIUd/VUYTsH/I5Tq0mT7xy+yUb0oa
X-Gm-Gg: ASbGnct5NplbaEQLZ6+56KMJeJzbvNewnsRMOJVLTkGZSvQ555rSybId/HfnfMDm14r
 SlqCUVYePTybWwkYQLbhm33MJsvKNptgGjMcuQ8ZR1jCU700TVCyZbDCFSGYEpxZpsr3MYzX0fC
 PoYHiRSUuq+5xHj1oa9MXo4tA8mkhG4iKPLQiDgEQ=
X-Google-Smtp-Source: AGHT+IFYVK0t70gcVSKuJldndAgKrx6EE7y/MvUEuY+xAgUMrE2gtGne8LJtb+X986thJwoKvSUmAOuuoALXHJjVGqs=
X-Received: by 2002:a17:907:d92:b0:abf:733f:5c42 with SMTP id
 a640c23a62f3a-ac3301e0188mr337572966b.8.1741963540947; Fri, 14 Mar 2025
 07:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250209212714.2317040-1-sjg@chromium.org>
 <20250209212714.2317040-2-sjg@chromium.org>
 <20250217192316.GW1233568@bill-the-cat>
In-Reply-To: <20250217192316.GW1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Mar 2025 14:45:27 +0000
X-Gm-Features: AQ5f1JrdPEhXM3t5T8hgNJDe4NhYGowSG6GvBmQTFh6fU8BPPIOOdc3HSnt7zWg
Message-ID: <CAFLszTjXnz7coW9_MSLxWVH+Ea5bdka8oYByG4LQtTUNpije7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] u_boot_pylib: Clean up pylint warnings in gitutil.py
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
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

On Mon, 17 Feb 2025 at 19:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 09, 2025 at 02:26:01PM -0700, Simon Glass wrote:
>
> > Reduce the number of warnings in this file.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  tools/buildman/func_test.py   |   4 +-
> >  tools/u_boot_pylib/gitutil.py | 240 ++++++++++++++++++----------------
> >  2 files changed, 128 insertions(+), 116 deletions(-)
>
> As I think these all were warnings from whatever other linting you had
> mentioned in another thread, I deferred this patch as it also doesn't
> cleanly apply.

Some of it, yes. But most of it is fixing things that we should fix.

This is going to open up a significant diff for patman, unfortunately,
just as I am adding new features for series management. So please
consider applying it. I can rebase if you like?

Regards,
Simon


>
> --
> Tom
