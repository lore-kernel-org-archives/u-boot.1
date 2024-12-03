Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A0CE74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B045896EC;
	Tue,  3 Dec 2024 20:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rz26mWQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 425C289185; Tue,  3 Dec 2024 20:48:24 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8115896EC
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee88b57ac0so125420a91.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255300; x=1733860100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/m2Rp7WbFLwv5Sfw/fwbFm21JuOOmBTrrIJ2oYIGduo=;
 b=Rz26mWQcqEIMc7pxUFwHJ3xoVC2onevJ0mWlbdaK0eNEHjKVS56Kr9tPb097qFGpPr
 qXwje8b+sk2jQOOkWKHmiZ/clVkbJBzvwUnXmyae1jyRBMytfSQnGZ3cq/4/ryXwVJqW
 woNP7wR3DkUbWdf/ctBhbQM9bpoPRuLADL7Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255300; x=1733860100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/m2Rp7WbFLwv5Sfw/fwbFm21JuOOmBTrrIJ2oYIGduo=;
 b=UIM6yamRI9XPNShdGF2tyd+l9AO1lsecDpKLZxD7pyU3Bx7qMqTTLES74+Nej3GD14
 hZwQRrwtMo2DTOKxWyCZwMIFAmhxOVZGVzvha5xtMnzphsbUs8UhlnSFm3EWpcM7maC7
 X/s5PgsR0+ebSX3C9/G+gZnr601csu9f5Dd+vJrMBlfAz/I+k6tRucKQ01ezldUAHnlR
 4aYwCNWE18hMKK0v5WdZ4iMscCIVaGAkmD80g1pwAT5Vz3Doj93ha0ct3enW4i35AP/3
 8jzzM5IcPjr+PRANfIqoBmSmdRcqQbtitHJavH8UN/Sz8R08oF81LAsKOlslJPZ3C1/3
 6F2A==
X-Gm-Message-State: AOJu0Yyf1NgOCFsQUwOxvLhGFIwfm6KHzZgNxwD8SnQ1N3b394SKPLTg
 LOW0w3o+qmFGatJHyez03TzzkD8HkggWEcZRB/8Ygz0Se+wmGOTqzTKHhEvgO8awCENjcsOcqqm
 /DhLDQZHk0liYZMeWXXn+IR0QLIaxQ91tUZo9
X-Gm-Gg: ASbGncuPPIjmlNg9t8oEbnwkUw769PvcVfvLiZPuraiz0hyLPsoIDeAp9HImnSinwGl
 JTzteiV7VIYhF2VNMpgrdi4fFz07zgbn0
X-Google-Smtp-Source: AGHT+IH8cMymTs/4ytrY6lg2ZDxP0paEDy8jBS7u7VvdRhJbFERRqX1ryEgx8XrLwLjnWhP6ffuB56AQoAjkHujuyzE=
X-Received: by 2002:a17:90b:1e4f:b0:2ee:ad18:b310 with SMTP id
 98e67ed59e1d1-2ef0262ddc4mr5547397a91.18.1733255300314; Tue, 03 Dec 2024
 11:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-5-sjg@chromium.org>
 <CALeDE9O9sxCwf_scpbLQEtSxovN64jMWkfEVpUZviJFrXPbHTQ@mail.gmail.com>
In-Reply-To: <CALeDE9O9sxCwf_scpbLQEtSxovN64jMWkfEVpUZviJFrXPbHTQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:47:47 -0700
Message-ID: <CAFLszTierzLAVNu0iUW=ehjUkyXz_3t2yK_Z7WAged-y_wwTyg@mail.gmail.com>
Subject: Re: [PATCH v3 04/25] pinephone: Drop status-LED code and use LED
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Samuel Holland <samuel@sholland.org>
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

On Tue, 5 Nov 2024 at 07:13, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Sun, 3 Nov 2024 at 00:42, Simon Glass <sjg@chromium.org> wrote:
> >
> > Drop the STATUS_LED options and enable LED and LED_BOOT instead, since
> > this is the new way to access the LED functionality.
>
> This still doesn't work!
>

Could you try this series please?

https://patchwork.ozlabs.org/project/uboot/list/?series=432093

Regards,
Simon


> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Combine removal and enable patches
> >
> > Changes in v2:
> > - Add a patch to enable LED and LED_BOOT for these boards
> >
> >  configs/pinephone_defconfig | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> > index 9d39204a439..272fce1c1a4 100644
> > --- a/configs/pinephone_defconfig
> > +++ b/configs/pinephone_defconfig
> > @@ -11,8 +11,5 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
> >  CONFIG_PINEPHONE_DT_SELECTION=y
> >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> >  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
> > -CONFIG_LED_STATUS=y
> > -CONFIG_LED_STATUS_GPIO=y
> > -CONFIG_LED_STATUS0=y
> > -CONFIG_LED_STATUS_BIT=114
> > -CONFIG_LED_STATUS_STATE=2
> > +CONFIG_LED=y
> > +CONFIG_LED_BOOT=y
> > --
> > 2.43.0
> >
