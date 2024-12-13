Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85C4E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF5480104;
	Fri, 13 Dec 2024 15:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z2xfPA5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9A78012C; Fri, 13 Dec 2024 15:32:39 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D73800D7
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso331121366b.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734100356; x=1734705156; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vvLdo+bLG8twPQra9HRCHAOKC8ppOybs+7wHXjZU/qI=;
 b=Z2xfPA5l4h51D48gCVlutqa7ytmAM0H+S550/oNZPQSwCccsPnY2CQ3ZiT1NNGsKCS
 kzd/+NEXrd5tnpqP6Pyh+jMN5tP89zJ5qTvzUi7QhlXa0iD4bITmThCFVIcAvpr4iY0E
 +DzFIO9+v7W0hg/XCIojI/6O44PDMyaXe7ylk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100356; x=1734705156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvLdo+bLG8twPQra9HRCHAOKC8ppOybs+7wHXjZU/qI=;
 b=cqt87Zf1q7dXECtg0gFhALz7amUgA9ds7rZ0K6xfSjorjSk/aFXtBrF7UAWBSwdsSB
 /5XP0UMQhqRSpnrIEI2+qS6uuV0RUQH4Dg+ZK2L8ZhxLZzVQuPZPRtLN4G1fyrl/uJ7+
 WJCHUz9it8l8svK6WJomznX2/ZBi2vL21x2v2/7PEimAxiEQ8U0P47btzKsM3/U20Vaj
 9MZ9ZgwG9XT5HvIDjRjYeLs3AA2zaRiUosyVjkBegwuUwgao1ThQogQGimTRrpTS5lYO
 lRdlYTgfFV/iCxqfFWCzpVsAVbfbC7MwrffQq5vH82TA93sTyC6NheWaDwt6ULzLHO9R
 b9Lg==
X-Gm-Message-State: AOJu0Yzj1jSvaxp4tvako7zZ429UBDlDsYIzxFD+IXCHD2mbtvqnM0mw
 UZ0u9OhbD1x0XB/Sq/hXcv6pRGLjoSLR7sLMAZPa9d6YKgSYnmBI+s7f/kX8t/JKhDLchWPDHis
 GVkNou27bRAXkoeAbWmKkF4yejnR4xC6QWZOv
X-Gm-Gg: ASbGncvbpMfuDN9/YPPcOryOhhy3ptbI3uD6+pAAafHjmFYP0uy/M1XpoINV1DFv74x
 ZYoVmUda1LaUkKtrOIWn66J6BPcBP41QR1QTYLp8=
X-Google-Smtp-Source: AGHT+IHTgV+Qo543BvNjhCI72WHZ+8Bou+dVhj5EqHREA/fgBnSkVS+ZpwiYpJQo4LVLVQPE3th88QnyJI56Jjqv1lo=
X-Received: by 2002:a17:907:7204:b0:aa6:3de7:f258 with SMTP id
 a640c23a62f3a-aab77e9d1e3mr280885266b.37.1734100356278; Fri, 13 Dec 2024
 06:32:36 -0800 (PST)
MIME-Version: 1.0
References: <20241212151142.1562825-1-trini@konsulko.com>
In-Reply-To: <20241212151142.1562825-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Dec 2024 07:32:24 -0700
Message-ID: <CAFLszTiF8m7P8mBCNRhhiRQt=bcfRB3ddaaumF_EXETTXbUmDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 12 Dec 2024 at 08:11, Tom Rini <trini@konsulko.com> wrote:
>
> Introduce an option to control if we expect that a prior stage has
> created a bloblist already and thus it is safe to scan the address. We
> need to have this be configurable because we do not (and cannot) know if
> the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
> on-chip memory and so it may or may not be safe to read from this
> address this early.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
>  lib/fdtdec.c   | 11 +++--------
>  2 files changed, 35 insertions(+), 8 deletions(-)
>

Since this is the essentially the same as my OF_BLOBLIST patch, which
was rejected:

NAK

The issue is not whether some 'previous stage' set up a bloblist. For
example, if VPL_BLOBLIST_PRIOR_STAGE is enabled, that presumably means
that TPL set it up. But it doesn't mean that TPL put the FDT in there.

You are basically adding an option to tell U-Boot not to look at the
bloblist when setting up the FDT, since it might not be there yet and
the machine will hang. So confusing. Only the board author knows the
intended flow of boot, so just let the board author decide! Within
U-Boot you can infer from the bloblist options which phase actually
creates the bloblist, and there is some attempt to do this in
bloblist_init(), although it is pretty messy ATM. Anyway, As soon as
you say that some secret-source blob might create a bloblist, you need
a way to describe that. But again, only the board author knows.

Regards,
Simon
