Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D3CD18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B46891F5;
	Mon, 14 Oct 2024 23:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X0ETZV02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD5589207; Mon, 14 Oct 2024 23:35:37 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF35891E3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4603d3e456bso43155261cf.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728941733; x=1729546533; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=suXk7f74EzjAxw4kX2oVqePfUWiEw/SB57bW7oKhiDE=;
 b=X0ETZV02RaUgllFUHgXWq34JuAZzIsuzgprL0ZUc6/xcOLPnMeRoMiLZxBNriPAJkh
 kChZwNe9dQl3gszeMxf0HYYN/sOBqCE6ON+nPhl8fLpIxje520wByNnVdp2vyZinl999
 aaBwxddlY94CWjXKRZ3r+N2ynl7tqCvusCoW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728941733; x=1729546533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=suXk7f74EzjAxw4kX2oVqePfUWiEw/SB57bW7oKhiDE=;
 b=nGYvmz/2FNOh6FJSGB9N6AYcAqvYLna7FHEQVnzgzuAaTh0dP7DYwsSXl/ghBJ/zuL
 DJOrEqaOZpJzGEo+mXgTc4Erxm8Qsg9tM+ruA/RdGqP0feV3ag1BtTHoC0gsLNJIsFfa
 qtwv2nFdonXe2y55G7nKHY0W/+/3a0BXlI0DwvccoK3d8jcNYd7/5LTqYzGMrbb7DV5k
 n/Te/X9wr08YQiQOkXPJbiW5sND5QQXMkW5f67COFwm+EK+O+FTpphvHIs/+Lt91N2n2
 IbS9TJq11sbKYU6eHcxu4oOwCIvdAz4QV1DZOEO6kRqoAe9q0aOlQeWP0otODbmNVZyx
 e7kg==
X-Gm-Message-State: AOJu0YxoT3jWmCAaUmL7DZIVx6eiZxXa+BqImegzI44c3NPF+uH0Q75G
 GRXkExzutmPSMK/o2bz4bDxOPWK+QYVx7Clpm5+uCGe4G/SGmGTxuJ93JBpQ4i9w+P8CuqQ4ZmL
 arEGc9lVvsFCHb7Fg3wz2OkFY/AmtVZ3SKj/do9iHJ87gt1Q=
X-Google-Smtp-Source: AGHT+IHbGiPt6Edc8ygsg/Lq6U+/6h2BgCdvddCGlnIwuV6qAJNgWskADXuK2z3n9Qkp7kqHeLfmN3Zu6eHKHZf2Pgc=
X-Received: by 2002:a05:6214:5c07:b0:6cb:ee89:9986 with SMTP id
 6a1803df08f44-6cbf009f8cfmr164427786d6.43.1728941733579; Mon, 14 Oct 2024
 14:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241012232231.5638-1-sjg@chromium.org>
 <20241012232231.5638-2-sjg@chromium.org>
 <20241013161520.GM14210@bill-the-cat>
 <CAFLszTjijFBZar31k1QaLUKcFQyD+CGqyo5wH=7agFF1gr-CLQ@mail.gmail.com>
 <20241014211248.GY53053@bill-the-cat>
In-Reply-To: <20241014211248.GY53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 15:35:23 -0600
Message-ID: <CAFLszTg6fVsasb8=CJLqFm-T9Vys9_hJDeKfAfTmvfWXNcPZZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] qconfig: Ignore defconfigs containing #include
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

On Mon, 14 Oct 2024 at 15:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 02:20:00PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 13 Oct 2024 at 10:15, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Oct 12, 2024 at 05:22:30PM -0600, Simon Glass wrote:
> > >
> > > > Running "tools/qconfig.py -s" will re-sync files with #include in them
> > > > and so un-#include them.
> > > >
> > > > Ignore these and mark them as failures.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/28
> > >
> > > How about marking them as warnings? It may be good to re-sync
> > > configs/am62px_evm_a53_defconfig for example and then re-add the
> > > #include line, but configs/am62x_evm_a53_ethboot_defconfig on the other
> > > hand very much should not be resynced. Thanks for getting on this issue
> > > so quickly.
> >
> > Do you mean still do the resync, but show a warning? It does
> > obliterate the old defconfig, but I suppose people can just not commit
> > the changes. Is that what you are thinking?
>
> No, sorry for being unclear. I was thinking it should NOT be resynced
> but counted as a warning not a failure.

Well qconfig doesn't have the concept of a warning, or at least not in
the title. How important is this?

Regards,
Simon
