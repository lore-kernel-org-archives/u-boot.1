Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F9FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DECA6870C5;
	Mon,  6 Nov 2023 18:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WEzZOe+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BEA86DD2; Mon,  6 Nov 2023 18:25:30 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BF286F1F
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53dd3f169d8so7869196a12.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 09:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699291520; x=1699896320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mK2ItT2Xu/7VzqXYQeHoArvW3w6EsY5qYUrucec/DkU=;
 b=WEzZOe+65tJO3o0QZfEvMLj75xoGFmxC7rLRI5VBCWT1xHDOsgFOHNBg7Dn5i7j1OY
 Z0cvnMMmC10+itYmPFs9To4k/rR8unyv70a2RIdby4tc8rd2NJcKKaRdDm/VNUmPr7CA
 7TBc24HIudgHqa+7ZFabGZm+fpsr0CgbpOLGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699291520; x=1699896320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mK2ItT2Xu/7VzqXYQeHoArvW3w6EsY5qYUrucec/DkU=;
 b=IM6Dr8rkTR0zKJWiGiJJPBqH6bAQZ2zPpkLmCoi5gTs0Uvoue57rI05GY+b5s7yt6/
 qi13kCIXqUvB2LoOzD5EPvzfcUi1Adeh1X0tCnvSWrNmYaAAzg4eJV70sL6dQJU7dfkF
 ASPTn1R3gVRfY02TxUIIYc08tX81CRaOIEkeEUlg49uu8ZCOrPGB9z5LzFxAy09i45Px
 tZxagydGIYlPZglKtyVO2MxZlW1t+8MfKp+8aaMBRnfV+NJ+95CM9uhx76cXIYZLRYik
 Fzw2BGhx/bqGx27RRKQ314y1b8Ml6fHb95Gmxn5AW/yRREed3xl2ZpxLQ36nvidVgHQg
 5aUA==
X-Gm-Message-State: AOJu0YxUBHZWHG+qytnTn0ErodDplAKlblvpQUk8P1tyqvO6yjoI63F+
 1Eh9Mka0xNoZoWH7zIxv5xabiOCuZrsJkQhB+CUUJA==
X-Google-Smtp-Source: AGHT+IHFqlS3GXJ2fQzbC8s6J2nMACe1309RHRtT8CZixqKyNy8ZvfVNk/WNGkL7ctVSAWKMvGsHbuYpAD44R2Zjp+E=
X-Received: by 2002:aa7:d796:0:b0:540:7aa7:874e with SMTP id
 s22-20020aa7d796000000b005407aa7874emr23847216edq.29.1699291520106; Mon, 06
 Nov 2023 09:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20231105200453.1887418-1-sjg@chromium.org>
 <20231105130351.1.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
 <20231105211910.GE496310@bill-the-cat>
In-Reply-To: <20231105211910.GE496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Nov 2023 10:25:00 -0700
Message-ID: <CAPnjgZ26DyfvayO8BgQvCoEVDfmxotG7A7GMWc9T0wK0Okho8w@mail.gmail.com>
Subject: Re: [PATCH 1/4] bootm: Allow ignoring the load address with
 kernel_noload
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
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

On Sun, 5 Nov 2023 at 14:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Nov 05, 2023 at 01:03:51PM -0700, Simon Glass wrote:
>
> > This image type is supposed to ignore the load address. But at present
> > it fails if the load address is missing. If it is zero, the image is
> > loaded at address 0, which may not work on all boards.
> >
> > Make use of the kernel_addr_r environment variable, instead, since this
> > seems to be a more reliable final address for the kernel.
> >
> > Another option would be to create a new Kconfig for this, or to use a
> > region of memory known to be free, e.g. calculated from the DRAM banks.
> > But in any case we should try to avoid conflicting with the
> > kernel_addr_r variable. So the approach in this patch seems reasonable
> > to me.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> How are you creating the image in question here? A noload FIT is
> supposed to just supposed to go from where it is. Where do things fall
> down later?

The image is Image.gz built by Linux, for example. So compression =
"gzip" which means that it has to be decompressed.

Things fall down as soon as U-Boot looks at the image, since it
doesn't have the ARM64 magic.

Regards,
Simon
