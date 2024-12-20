Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A6DE7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6617880381;
	Fri, 20 Dec 2024 18:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j9HtTu7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 152A780384; Fri, 20 Dec 2024 18:18:32 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C12B08036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso371107866b.2
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734715109; x=1735319909; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wcs9T/R0eXiUZvM1aXmMisoa+wbAGGSWWTkaG69fpvU=;
 b=j9HtTu7R2UZMwedL6ZqhC/lOEzneznWOcHlJX6AI+9u/+Np0Lto7eZudIwzdVbGlJo
 CHFCPEzawVuD3f3r4ht/odDe2oUwMroCJOhO6TAuqCkJY4DeAUWn+d+0clbgvcV6JCd7
 HSh+f2S+P9Voy28A4EWdEbnxOq9u7U+tXbKb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734715109; x=1735319909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wcs9T/R0eXiUZvM1aXmMisoa+wbAGGSWWTkaG69fpvU=;
 b=ihDutGxtyuNz0p+gLPGJyUx8RhM3tg3BdWwKp+dXsrGPjFIDawBJdWxSDpbDzGazxB
 1fg6l6FEYopYKYvnlFVAUTD3eFWJIYqwPGfDP0xgtM/AaygULswnIXqtGZQOduBiJmGc
 kiDOd3wUIHCFVPrTEDeSQjz0TdtDRjGYxg1ohBbYYk2/499bshyJGagngLoUNoyutvHu
 rCZDAUmrNZq+sFn3xoHa43CxcEj+4ag+k7CwpvAljHb7nWXm5W9fn9W6o2x7JwHOU1ky
 4iiEhTNzK0JzXmLeBkj4pTilROoiDlctMql/JrKUyAqgvHjK2v/MeifaisWAD6Y+VIUp
 suaw==
X-Gm-Message-State: AOJu0YzH0aWYdC8wBw8IbFx4FwTGlXw9Fzb9nGBceP2iKtG/CXEOHNH+
 RVhWmJ5XitxkOHp2qqkydRAZJyzXeC+ZrB3d8RmHFuWJu03klEU7Tewv43g5/fHK0Hlz5I6fyBk
 WTzngKQdN4RyucJnuSsGieSP+2GrxgcKvZh8+
X-Gm-Gg: ASbGncuAqKPjKDe1ShXnAmvsNTjZsMWOmLQDo1bOIoiSyxaECWWg9LI6e0njD/Xp3w2
 pNu7WPv3rdwIKlQclgU5UVjEtykKjHdiqxDRieI8=
X-Google-Smtp-Source: AGHT+IEkGtW+LfDIYSO8KpEs2SB1YKCiqayM4NFKs9rJueePErKuAb0MOO0+58RKXWI25HAGCU8MDg+87EuPkAU6zXg=
X-Received: by 2002:a17:906:c106:b0:aa6:7cae:db98 with SMTP id
 a640c23a62f3a-aac2d447333mr302573166b.10.1734715109224; Fri, 20 Dec 2024
 09:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-5-sjg@chromium.org>
 <20241220145609.GD1505244@bill-the-cat>
In-Reply-To: <20241220145609.GD1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 10:18:17 -0700
Message-ID: <CAFLszTjzP+vm1YoUX_avNq4_4qnUtNzzjLyFocEhJYrCA7cGOA@mail.gmail.com>
Subject: Re: [PATCH 4/5] pxe_utils: Support a backup for localboot
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Richard Weinberger <richard@nod.at>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Fri, 20 Dec 2024 at 07:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 19, 2024 at 09:01:19PM -0700, Simon Glass wrote:
>
> > The current localboot implementation assumes that a 'localcmd'
> > environment variable is provided, with the instructions to follow. This
> > may not be included, so provide a fallback in that case.
> >
> > Add a test image and test as well.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This is a pretty niche feature, I had to dig around a bit to see how
> it's specified elsewhere (not really) and how it's used. And I think
> that based on how it's used, making up a bootcmd when localcmd is
> undefined is the wrong approach. It's the hook for "run what I defined
> in the environment", so if not set erroring back out seems appropriate.

Yes, but unfortunately it seems to be used and we should support it.
The problem with scripts is that we don't know the boot device, etc,
so it needs to be integrated into PXE. I did consider putting
something in bootstd, but we only find out that it is requesting a
localboot when actually running the extlinux bootmeth, so this is what
I came up with.

It will be interesting to see if any other cases come up.

Regards,
Simon
