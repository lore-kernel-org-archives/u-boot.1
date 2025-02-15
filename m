Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A742C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 11:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C51480B98;
	Sat, 15 Feb 2025 12:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SKwVCxk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DCDE80EB0; Sat, 15 Feb 2025 12:59:55 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A34E80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 12:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5de3c29ebaeso3790715a12.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 03:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739620792; x=1740225592; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WQfhF6iAAOUWIQhuk/GgY5087MXXSLrDVqY4kvnRtPQ=;
 b=SKwVCxk7VvN4tpY+0FT+dz40Nm7GOQi3A2Vvi5nK1FWjyzHqn6hXuyui9Wv13+27Nz
 WF3AQYqR2d2CCVfrRf03n8krAeztvI2ZVjCqAse1jXy5eo+dk+Pph7t39UBwxPX9zUaW
 ++7KyxRsH2RV1qBly0R4cQUZd702SmysVJrrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739620792; x=1740225592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQfhF6iAAOUWIQhuk/GgY5087MXXSLrDVqY4kvnRtPQ=;
 b=eK8HPP4UgWhFgmTLb6tCzCM5pkMsWNT021hQdQNv9Ljxfy85CnN1IgkCMIKFy6Ebxn
 kZOPp6CkDwW8iWtSlxtWxceHWbd54VLSLM13Rx9kc3E7iTTUjhbmjZ/IAmPgyb++BRnJ
 Fghl3jHZTz5utk92Szlb96LOTzo1jdHTl2BTH+QgkEn2NSnp28H8iwdr/wuNltbAEIcX
 HIFthW8DeN0I+HlEb7bTwvsSNG7YfBFySscQV6ClzpD2+BFNTDgP/NpqjhdzmrRfy8wk
 mfVEJ+1L1xn10YwRwqaMXvNkAQldmy+AjeS0dUwJuIYC5x+ipZMGxMO1z2eJqES5Kq30
 Nx1Q==
X-Gm-Message-State: AOJu0YypSg2fNrr2c7Viwg6sJ4ZcaeaJ83AmlgdZ+HtNkPNP9VqWOO+d
 5+p+vQDmQ+pR1zCaHZxvctnyrYSQFNRpB60/WTbvskam1rUNt32hOUveaHRw5nLYjlb4jwsV7Hc
 Y++s+wDMWrerb8GcSeO15/1pzlS80owuatVzf
X-Gm-Gg: ASbGncvhHYc0gLYe2LmFB0fGewv9KS9MT7ZDlI2Min7u9foQOU8Jb8gAPzYx+Cp7oqf
 VzMBDaflEPi5RBYgrjQlkc+wY0ki/0XwEFqM00ogSLeGtfP8feDO70t+O1W4CM6xMyBBv9bYmzQ
 ==
X-Google-Smtp-Source: AGHT+IEsMwJoM+ZfJc5dmrbMYjRmG6JMNX7wHo18b+H6MqeGQeWyOzca26asLqzaFETozB6mIfrXv9GmTfbyhBvH2Q4=
X-Received: by 2002:a17:907:1b1e:b0:ab7:d5e3:cbac with SMTP id
 a640c23a62f3a-abb70df7676mr246635366b.54.1739620792524; Sat, 15 Feb 2025
 03:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20250206223858.64672-1-sjg@chromium.org>
 <20250210162518.GA2902864@bill-the-cat>
In-Reply-To: <20250210162518.GA2902864@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 04:59:40 -0700
X-Gm-Features: AWEUYZmw-UsB_LTYnlL2D_4kVfpSFmzFhakAiLdGMd--6EisohT8RYxO4DNoEl4
Message-ID: <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
>
> > This is a global default, so put it under 'default' like the tags.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
>
> Please make v4 include the way you redid the second patch and be on top
> of mainline, thanks.

That's enough versions for me, so I'll let you do that, if you'd like.
It probably doesn't affect your tree as not as much is done in
parallel.

Regards,
SImon
