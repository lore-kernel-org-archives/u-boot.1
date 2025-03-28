Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097C6C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 11:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A3881273;
	Fri, 28 Mar 2025 12:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PVuM+eaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D2F805C8; Fri, 28 Mar 2025 12:34:29 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B8E581E60
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so372904066b.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743161666; x=1743766466; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NHV1K0oGOCUhrxGutZHxWOpXylYd7JE/qlz5Y8t6raM=;
 b=PVuM+eaQa1sepI1yiWQu6QcK8wEjtmlrJ8scWmvLwL9nvS5oKG5vQLlqsz4BMFmVBU
 M+IU2YzXen8/0qmG4/zhMy3yU7Jo3QN9JLXBG3TTpzbJNM4snt7uz0UUBcBu0ZcFtMxf
 1OwZn5WebnjWgnairkprqCvWtPxDtgRClukik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743161666; x=1743766466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NHV1K0oGOCUhrxGutZHxWOpXylYd7JE/qlz5Y8t6raM=;
 b=ZksEwRbI5DibK+UzVbbqK5jaE+WTdvFoblzHLW/oeD0NeMiJTfnRPyciwUI9i9t6t0
 8X01PYIl+kBj2aMuO4kuqgMnBYKi/zAwbLv/+dZziaSRJwLx0CzKPvS83PDZDETOqHj+
 FBIOYKqwNa0TBeee7NP+b8/srNiFSkfCx0eVSAbaovwwCd7dcbyrrmIDETrPay9aaT2R
 P1MoYqGF1ycNgCnNgvxfTWZuA2o5PaUsiwC+DmKznyn8O9lBjpySMchGiwxrK/r1cPJw
 6aAH/OY7QL8Cn260vkrS+RPBh6+vIPh6HTjyqZbMzIj4bBe7fjeTEWxBcKd0O55Vg4nU
 mSGA==
X-Gm-Message-State: AOJu0Yx5eZOY/dCBZVZ6yvQSGduS1CkK9T0cxmnnJALkt9K7TKRFnT3I
 Fl2gMUBGT0Sj0b4mil765RX5WqUbVh/rZCwbWiBdSOGgiVzXIH7lXOWWWjo8stayg3WPMywLD0T
 +67r49Eanq+B4ZMRjC5RdfjT4A/HgiuAHqf7kLeQEY0bJZUE=
X-Gm-Gg: ASbGncuE5pWvIDgHAUadQBeAvVqhM8BOjjp1rFwUZV4nMgmnLVKRtSaAdBGOTJXdrPd
 CuSgXiNtEspSHJy6SUUkaOMcL8eCq1wCShYzDdCrrXAJ046rQBWn74ifvLrjNbpBLlbHGAym3pX
 xwmRp8Cwu1nFLOfCvEFZMvdwxe2L4=
X-Google-Smtp-Source: AGHT+IHU+wdsHiAPmGRfsGnyB6/2yTUD7+GGTwvgVY/uTJaVho66YOUQ6Pmvb2jPDTfOhMOJLoMdGCOy/gOkX3F//u4=
X-Received: by 2002:a17:907:805:b0:ac2:c75d:f30a with SMTP id
 a640c23a62f3a-ac6fb1570ecmr696813366b.37.1743161665536; Fri, 28 Mar 2025
 04:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-14-sjg@chromium.org>
 <07df3ff7-65ed-47d5-928b-0c901ec5448e@linaro.org>
In-Reply-To: <07df3ff7-65ed-47d5-928b-0c901ec5448e@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 05:34:12 -0600
X-Gm-Features: AQ5f1Jo_cZreTweQULcRhUWg1Wver6bYKpD85yuhsUfmv3ed8mvGFMMNGVCAUQ4
Message-ID: <CAFLszTh6f2NRKWvEq=RDM4fKG-fboRR_LBHuty7H1eJ11myieQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/29] efi: lmb: Avoid access to _start
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Janne Grunau <j@jannau.net>, 
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

Hi Caleb,

On Thu, 27 Mar 2025 at 10:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 2/15/25 04:22, Simon Glass wrote:
> > The app does not have this symbol. Also the memory where the app is
> > loaded is not under U-Boot's control.
> >
> > There is no sense in relocating from one alloced region to another.
> > U-Boot is not able to relocate to the top of memory, nor decide what
> > other parts of memory are used for.
> >
> > For these reasons, the EFI app skips relocation. It is not running at
> > the address pointed to by the _start symbol.
>
> is there a symbol or not? If there is could we have some "relocate in
> place" mechanism so that it's valid? When I (finally...) get around to
> re-sending the symbol lookup support it would be nice if it worked for
> the EFI app, and it relies on _start.

Can I leave you to do that clean-up/investigation in your series,
then? Tom has already reviewed this patch and it has been sitting here
for 6 weeks. I applied it yesterday.

> >
> > So disable this reservation for the EFI app.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Expand commit message to explains that EFI_APP skips relocation
> >
> >   lib/lmb.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 588787d2a90..420eae4d0b8 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
> >               lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
> >                                 LMB_NOOVERWRITE);
> >
> > -             if (gd->flags & GD_FLG_SKIP_RELOC)
> > +             if (!IS_ENABLED(CONFIG_EFI_APP) &&
> > +                 (gd->flags & GD_FLG_SKIP_RELOC))
> >                       lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
> >                                         gd->mon_len, LMB_NOOVERWRITE);
> >
>
> --
> Caleb (they/them)
>

Regards,
Simon
