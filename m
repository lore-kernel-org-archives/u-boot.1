Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EE9C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 08:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21EC183FEE;
	Sat, 27 Jun 2026 10:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fHaqyDij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11A398460E; Sat, 27 Jun 2026 10:31:11 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C232805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 10:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so3256891a12.3
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 01:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782549068; cv=none;
 d=google.com; s=arc-20260327;
 b=ct1DaSt/DV8ic+HCq6jKzS38I3+LvsRnaZ0bngB7DO/PStmfdmdMb8mvlijAg+4yYx
 ez4yA3YLUTm6TqYQAgoGJHY7WNzPYP0hTZE/jbhfEgqGYPqdwtEOo0nhr+79jUX6k5sy
 dr8oJlK9OZ2O9vNs7zOe/L2xJ7rVtU6lWX7uNImuYXbYOFCfsGAyALeMgjoPloj4vuQn
 Z56F14bllR+CmwpnFnri24DAtu+cGyIAkFd1HXHlMkhZ3+oIriHwREH9nmld2DZnyDLB
 X3wfuW7bjw7LbP60HJcckoxn/ZZOysYIclgOUAaIewBYturV7mNiPGTBuT7dmxfFQ1Iu
 p4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gbcCLZhCqVx2+jyw9IFl9SrTy1zIXiWoFFM2Exg1WdA=;
 fh=Q/CwjpMAK/uqNAGfcOaGyE/lxJBUDSZAXkR27KMCiQQ=;
 b=BIb7CV5FC9tvGVlukH4vXqjksLydk5s7K7EdtpX0yngNofMywm6P+bXsChn5rNFXhq
 rkWshuvDmTyvwCcQwuDOntrCD9Yy2FLON2uZHzsT1Z239U8UK6x+pS+LmYfaFwgRDecz
 +rKiMlTHpeMof/OzdA0+r1aQAQAOMhM0SkGEZup0ArS6DsGMrUcOPDL6w3KekoBEZ43F
 kLJXX6snc2osJvbkFsOW22qgAe5qvg7IrFrcKhHoIAim7qBwPQfyHcq5kQ/y2/67fyj8
 Xol+QC9ALrINSphQKuwRgvpCJ8Fk2gv1YauQkB15LUOlaxLLzjM20D32PQdao8/vVhcy
 xcrQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782549068; x=1783153868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gbcCLZhCqVx2+jyw9IFl9SrTy1zIXiWoFFM2Exg1WdA=;
 b=fHaqyDijqZ65djyO6DuqAuDyIuY7XuDxzp1E/lPl59w2IMeCL8qsixnHpMx6c76k5f
 2e4BL/rHsDWWfGas4U+li/uaOBlJdW/f9RAqdBJVjz9L2SbqnN90sx6CUTLP4lFLiZBU
 HgCbBRDFJf/ZDnLu8WrOOkEAjQdpdngVfdp/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782549068; x=1783153868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbcCLZhCqVx2+jyw9IFl9SrTy1zIXiWoFFM2Exg1WdA=;
 b=Jm0xpoo6pg+0173n+aPJt0iKp/bKVX1LUtPLbt4v9FiAwEJbL0BFnVqPqG4xyCDb5d
 Scol2mNIb5IAs6S9g5vvKU5OA2feo83BCU2VruZetv5ycku+BlC8mC0p4khybakPiiOu
 rV99dSJtd0xeEzsvwXw5uaVab78SR2jnRCcdbwgIgm/uY8+IYrDiYCEK2Qqu6QsrRkuV
 GfgGTaXCovn1fdm48TMeUt6wlzrBDSl05arTgMkvDttQE776wQBgj9eORSWeEghm/DUr
 5PcCyU+2vQn2peAWQDyhFIK8m0mHjlLyTZgm75UddFMgCBIM8H7lBBjp6ST2a5RGWMtF
 HkUg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1rQtv6hYqAkYq5Hh82OkDLpqEHZ4N6Nkhc8ctpVpkBBD5KyYdZPSkEliVgUMvP0Z0u3CZFac=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9V+fL3Zgv4zwoY0/WlHLb6+DV+8OHHWUjvOnJ3aFN6VZoMGCV
 1yA83ld6zNc5m9KteuL4gPTo6CCaD7lLhKjf8919eUqyy3KWuHVidVFGmxcJ3AG4OfsXH+Pcmx5
 vi0ZEb5v5nWf1WeBPYXjHPemKWeXRGNed3M00dJQoDnf1U/B5kVVlaQ==
X-Gm-Gg: AfdE7cncfedu2sXifNm3QTWkmyDj937w+Oh/D8eIt+vk6oZd+MeFBQAmrawLkNJMG4m
 t4033m0+UjOSnFgN5uHCOLdxAO0Ircxxy4bQMKkMr3rU6isnFMEaLkMW93G8o9DbYn0oO5OH0W2
 iBWHcDpJi8uO6NXYOikq3d4QftXaclOC0V07Ds4Jm5goUk1qFpAT+FGPcH/hrQE2YUnVDQExPhR
 ho5aN3Fzav+awiAK/HNbCB2cOi6HGpLMx8+AL2eltjum4WbjhIRNZH/BuEQpTVJ5hiaAdpwSA==
X-Received: by 2002:a05:6402:548c:b0:698:1504:e3e0 with SMTP id
 4fb4d7f45d1cf-6981504e484mr3744190a12.29.1782549068642; Sat, 27 Jun 2026
 01:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-4-dmukhin@ford.com>
 <4946b40f-21b1-4a48-a01e-6f81548aafda@cherry.de>
In-Reply-To: <4946b40f-21b1-4a48-a01e-6f81548aafda@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Jun 2026 09:30:56 +0100
X-Gm-Features: AVVi8CcoYLRRx0CoY6AeZpEWxTO6tOLa4QBBvkuqVKF_6F9RRB5Z4eT4loB2bC0
Message-ID: <CAFLszThwW5Ff6JjCd+xX-fKR6phTD3ZoqtfvS6+hXRc-cH1Oeg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] reset: Print reset type on diagnostic console
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
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

Hi Quentin,

On Fri, 26 Jun 2026 at 16:01, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Denis,
>
> On 6/3/26 9:07 AM, dmukhin@ford.com wrote:
> > Add a diagnostic console trace indicating the reset type.
> >
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> > ---
> > Changes since v3:
> > - moved get_reset_type_str() next to do_reset()
> > ---
> >   drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> > index 1ba698b37285..2b7717857ce6 100644
> > --- a/drivers/sysreset/sysreset-uclass.c
> > +++ b/drivers/sysreset/sysreset-uclass.c
> > @@ -161,6 +161,22 @@ static enum sysreset_t sysreset_get_default_type(void)
> >       return SYSRESET_COLD;
> >   }
> >
> > +static const char *get_reset_type_str(enum sysreset_t reset_type)
> > +{
> > +     switch (reset_type) {
> > +     case SYSRESET_WARM:
> > +             return "warm";
> > +     case SYSRESET_COLD:
> > +             return "cold";
> > +     case SYSRESET_POWER:
> > +             return "power";
> > +     case SYSRESET_POWER_OFF:
> > +             return "power off";
> > +     default:
> > +             return "unknown";
> > +     }
> > +}
> > +
> >   int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >   {
> >       enum sysreset_t reset_type = sysreset_get_default_type();
> > @@ -181,7 +197,7 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >               }
> >       }
> >
> > -     printf("resetting ...\n");
> > +     printf("resetting (%s)...\n", get_reset_type_str(reset_type));
>
> NACK, this is potentially misleading as sysreset drivers can end up
> performing something different (see sysreset_walk_arg() just below).

That's always been the case, but it was silent - do you suggest that
it prints a new reset message for each type? Bear in mind that when
one succeeds it is unlikely that the serial console will be updated
before the reset happens. In the majority of cases the requested reset
succeeds.

I quite like showing which reset is being attempted.

Regards,
Simon
