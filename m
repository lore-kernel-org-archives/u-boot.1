Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A67CF6495
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 11:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B75C88D25;
	Sun, 29 Sep 2024 13:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M6cTbYrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F8388D2C; Sun, 29 Sep 2024 13:50:55 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E87788D3C
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 13:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb27e974ceso21297526d6.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727610652; x=1728215452; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d+dWxXqDHwkbxwGLy7pZjx6IFhVyRZIcK5i2hmohqL4=;
 b=M6cTbYrSAd/D0aqBkeavfxvGgDp7lrAQAesw233NFuK2WnfiIsF/Rtcl5QAuTWELP1
 CcaF0dbDUEcTfp6lx0jB2p4kBbHXqyDt4RfaEbR2JungnOjxACPzEFcUfCtq/9lxvP0N
 eAvnjFIkzkTO4HBCTxsjlPZocU6BmMZegvd5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727610652; x=1728215452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d+dWxXqDHwkbxwGLy7pZjx6IFhVyRZIcK5i2hmohqL4=;
 b=aIT05iTVe2vgBYA8uf1haODTetozgHrYrar4yK37pTAwHNBtjtn21f6n3BItUw/ykc
 iGsiAWzpeameWcE+02vU/cHHqOkXddTVHg6h0Z9YXTV38OFuWlvMZL/qfzSyNxA6HZQl
 7c2Lz3jxglWtRrWkxA+NW/SqJfplkhnJdW6vQ0WEMtfrR0OgX13nnaL0kj9LYotwPDp8
 IkCRUv/X4OARMJv4w8QCHNDjVBAuMybRZsOgTbFLYlu1iCARS7mEkM2Vy/2es9XVMlF8
 fHFSMAC++fnZbd/Sec9kBKqoOOi4rkcCXbIDgdzlGEwOdHVzEPskfcy+MHprQhb6i2Gi
 w0rQ==
X-Gm-Message-State: AOJu0Yx/dDo8GIlPqymkOnE282XYkqyEhr7TbXqlzdt/4EQelUBCBQ7H
 gJmP8hYDHeU2/k6VFRaP2BwCnRmfe7i4STOFmdrBapgqyeBhOkNJ5Z+h68fRzv5TRt2HJNJpV22
 pARqk9MgNtdZL6p8FXvX6DeA09/dfA8qbyiXP
X-Google-Smtp-Source: AGHT+IFEJF0v+iigoJIOC9ZnU3MOquphdpOGrUTWgiejaO5HXdwiSmkmGs8qEZV0rp3Jr1Oj77AVx4uly6u2C3h4c48=
X-Received: by 2002:a05:6214:5bc5:b0:6cb:2c4c:3c with SMTP id
 6a1803df08f44-6cb3b5c25admr119919926d6.5.1727610652464; Sun, 29 Sep 2024
 04:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240928200030.194546-1-sjg@chromium.org>
 <20240928200030.194546-17-sjg@chromium.org>
 <0ecc8823-65ad-4231-8b96-5c694c382df9@kwiboo.se>
In-Reply-To: <0ecc8823-65ad-4231-8b96-5c694c382df9@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 29 Sep 2024 13:50:41 +0200
Message-ID: <CAFLszTiMH1_fo0J=GS3zNzgUC-h6J9sfcWweUPdfGXejarFuzQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/30] kconfig: binman: Check for SPL instead of XPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
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

Hi Jonas,

On Sun, 29 Sept 2024 at 00:08, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-09-28 22:00, Simon Glass wrote:
> > Now that SPL means SPL (only) and is not defined for other phases,
> > update kconfig rules.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  include/linux/kconfig.h                | 10 +++++-----
> >  tools/binman/test/generated/autoconf.h |  2 +-
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> > index a59f2a61e6a..ec9584b2426 100644
> > --- a/include/linux/kconfig.h
> > +++ b/include/linux/kconfig.h
> > @@ -40,7 +40,7 @@
> >  #define _CONFIG_PREFIX TPL_
> >  #elif defined(CONFIG_VPL_BUILD)
> >  #define _CONFIG_PREFIX VPL_
> > -#elif defined(CONFIG_XPL_BUILD)
> > +#elif defined(CONFIG_SPL_BUILD)
>
> This change back from XPL to SPL is probably not needed it you did not
> change it to XPL in the first place.
>
> Just doing a mass search and replace is making this series hard to
> review.
>
> Personally I did not fully realize that SPL_ or SPL_BUILD meant any xPL
> build before this series, so I would look at each SPL_BUILD to XPL_BUILD
> and SPL_ to XPL_ change and try to understand the original intent.
>
> I know multiple places where I have used SPL_ and not SPL_TPL_ because
> of this, and similar have used SPL_BUILD for parts I only want in SPL
> and not in TPL.

Yes and this will be the case all over the tree. I have added
countless similar things myself. The good news is that everything
works as before and there is now a clean 'SPL_BUILD' which can be used
without any dependency on !TPL_BUILD etc.

>
> How should I best handle sending fixes where I e.g. have used SPL_ in
> Makefile that instead should be changed to SPL_TPL_/PHASE_ and similar
> avoid a change to XPL_BUILD because the original intent was just for SPL?

Ideally use xpl_phase() if possible. Otherwise you can send a patch to
clean up and simplify the #ifdefs.

>
> I will also suggest you rearrange some of you patches to make this more
> reviewable and possible also make git bisect easier, maybe:
>
> - any fixes not involving XPL first, e.g. _SPL to _SPL_TPL in Makefile,

Where are you seeing those?

>   SPL_BUILD in Kconfig etc

Here I think you mean the fixes for tegram etc, Yes I can put those first.

> - add XPL_BUILD symbol

OK

> - all fixes and cleanup involving XPL_BUILD symbol

OK

> - rename and use spl_ to xpl_ functions

OK. That will generate churn, since they will have to be using
SPL_BUILD at this point, then changed later to use XPL_BUILD.

> - doc updates

OK

> - replace SPL_BUILD with XPL_BUILD in code, preferably in multiple
>   smaller logical patches instead of a single big patch

OK I can split it by subdir, perhaps. It is about 15k lines of changes

> - remove SPL_BUILD for TPL and VPL

OK

> - rename SPL_ to XPL_ in Makefile

OK

> - rename SPL_TPL_ to PHASE_ in Makefile, NAME and PROMPT

OK

>
> or something similar instead of doing the big search and replace early.

I will give this a try in v3.

Regards,
Simon
