Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE2DE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D521F8037B;
	Thu, 19 Dec 2024 16:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZSqQUTaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 149438036B; Thu, 19 Dec 2024 16:09:56 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 671F580369
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa69107179cso147418166b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734620993; x=1735225793; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mvSJJAoTEW5pP5E/pDfVvFRGLlCSK3nrhZ2IpXLW8lw=;
 b=ZSqQUTaw1dvatjA7Xnwa7a0JbQmijNjGlHg6fvv/jAneV5MKWWuFWRBATttpOfhAK2
 2hOtx6RWpjzpKd4qTjpLAinCJxapV9woYsSXz/a1i9jqdlZreD8R7iXS9O3ultOUAJST
 u+mcUnjuOYX9JiaupnNv8r8iU7lNbP/iYIvQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734620993; x=1735225793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mvSJJAoTEW5pP5E/pDfVvFRGLlCSK3nrhZ2IpXLW8lw=;
 b=MmtHXHxfFqLctOehOYSumqDfALVkF/fcMVhZD9bNUWkKRUnvnY+03djPJPJ0Oh/yH1
 Jo+6TDHK4MdAZEZIIGyNjhfpz8KdXjFQQZTkOSLFKKCi6krAmHuZTwoCSqhiPxKPl2L9
 ZmprTBF/KJLsAyOUlTwGJhe5f32Uy0anKABs7Cau4vPvf8XPhyns6hhwKMHV+9JY/8GF
 mvtkc21a0FYBSDyH9pylT7if07Pu9qET0E4cr65jpR/PaK69/vPGrnKxGkETosz2KUAy
 99hWMeuDVlWgtvKb7TIEYuhdcyy2yu6Pvte1yXxXWzFFwygSzrLwl6G5kumhAaMNGtlO
 qiNw==
X-Gm-Message-State: AOJu0YwOa1Lka+p31xANZWpQPLWhOhf0H4HWN3NX7N1y3850JtzOmBGO
 0v4o1SJgUAuX3jWMjvhoiafu6cnkUw+3Zx0vb47peeiiDs+cmczadWyxzlm/MqEyo188Bj37xJL
 kbKSlsrghjJ+uYeJ2xmIsBLzFS3lw6iL/X0MF
X-Gm-Gg: ASbGncu9ZJkHYFBk1g7AB2ZFAOKz/2VMNrmMsx8PVlDqtkOFgIbQqMz2msNzFKMDdim
 oNQ5qNmVKwrSAZZ/oCdkZ99u8ZpC1s6WGVLX5GhE=
X-Google-Smtp-Source: AGHT+IF5tp0lvy5Hq2qtHQcLWxzrUSBZrwNYp+WFUojrx9J2zV0PBwGPCsyYEmzdszP9DHBi6a8Y4XGzdHElXmgQHhs=
X-Received: by 2002:a17:906:f58c:b0:aa6:8430:cb02 with SMTP id
 a640c23a62f3a-aac07be5627mr301763566b.61.1734620992763; Thu, 19 Dec 2024
 07:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20241206023626.2456858-18-sjg@chromium.org>
 <28dc85eb-6347-4f23-9781-52af035ea758@korsgaard.com>
In-Reply-To: <28dc85eb-6347-4f23-9781-52af035ea758@korsgaard.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Dec 2024 08:09:41 -0700
Message-ID: <CAFLszTgn++XiSb5FxxdBbyDcjYh287xrc82-h33J1w509vGa=g@mail.gmail.com>
Subject: Re: [PATCH v3 17/46] boot: Support compressed booti images in bootm
To: Peter Korsgaard <peter@korsgaard.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Fri, 6 Dec 2024 at 00:52, Peter Korsgaard <peter@korsgaard.com> wrote:
>
> On 12/6/24 03:35, Simon Glass wrote:
> > A compressed booti image relies on the compression-format's header at
> > the start to indicate which compression algorithm is used.
> >
> > We don't support this elsewhere in U-Boot, so assume that a compressed
> > file is always a booti file. Once it is compressed, a check is made to
>
> NIT: DEcompressed.

Thanks, I'll fix that up when applying it.

>
> --
> Bye, Peter Korsgaard
>

Regards,
SImon
