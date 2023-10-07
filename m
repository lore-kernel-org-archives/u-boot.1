Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199C8E95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C2C86EC9;
	Sun,  8 Oct 2023 01:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RTGFkTym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A24A86DD5; Sun,  8 Oct 2023 01:12:16 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD8E86DF4
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a50756542cso40994667b3.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720299; x=1697325099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=//wCYinzy+eVKIJtd6Mg3Afs1yIE7jnwox5otG4b9Us=;
 b=RTGFkTymXK6V+lH7DR7biYp6sbvVewjUqIL0GeGZGIEw2zSuq2tm2hxmyZ1G/oCP98
 G8QxiEa55mbI3aoocqEHdgwIfpKQWcl9F5tXhOSldwfq0sf9tbZJ2XNRjg5H5AmxfbqA
 q+ApqsaTroRshVwaEcg1tZwKbIP3rpIu+ImWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720299; x=1697325099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=//wCYinzy+eVKIJtd6Mg3Afs1yIE7jnwox5otG4b9Us=;
 b=TD2/+CG9qKhvBwHA+vLZYMRIdRTCbzDnA0KgaWQdcDtpzOIvbAqcxRFKtjjo2CXRIc
 UXsu9heVgSNuL0dQqOPO4USFFdLV71h9JWW0pLQrpp0qSGAvqBk1t4Mr++Dv/6IwnwE6
 UadSmpZ/iA5ZjbobCeFzJTa5mTbJKjrx+KsR9A6xgI25OjcwtlEoROojR/LQOFNcGoTa
 tYMDlUlVgSReA/XfiBLoJJGiijDBjx/SuyB9So/QnXt3keOPdeAOMq4QzkjKlW+8Xmom
 5OKQ/LKBL/ux3M+ed9ZwQEXmVJGuNaEWl/zlXdHe0Ib/6OFvfhHZY6RNPLyZpD9vw2vj
 fOoQ==
X-Gm-Message-State: AOJu0YynVTepExCh/W/t+9qWzcjZx76BJKQpngVZt4TqnFLxNdKmtYym
 Jd1hE/cYXH4JB0ZZoT+lmf9YNYM7+A5dc84/bHyPEA==
X-Google-Smtp-Source: AGHT+IFGu3Scorf3htwff+B85JXNQl9OPVGEpbwpClplALyAKBF3OZsufx0PxDGP7pv3eSCvs2QEpQ9oaEb/AYS/bmE=
X-Received: by 2002:a0d:d402:0:b0:59b:c847:bce0 with SMTP id
 w2-20020a0dd402000000b0059bc847bce0mr12825255ywd.42.1696720299273; Sat, 07
 Oct 2023 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-8-sjg@chromium.org>
 <20230925004346.GP305624@bill-the-cat>
In-Reply-To: <20230925004346.GP305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:10:08 -0600
Message-ID: <CAPnjgZ3ieXXhidSeqzMuPBCgy9UrvOt5zSMO671t1KG9zWAGxQ@mail.gmail.com>
Subject: Re: [PATCH 07/25] tegra: Change #ifdef for nop
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Tom Warren <twarren@nvidia.com>
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

Hi Tom.

On Sun, 24 Sept 2023 at 18:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 24, 2023 at 02:39:25PM -0600, Simon Glass wrote:
>
> > This code is normally compiled for Tegra, but sandbox can also compile
> > it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
> > possible to disable UNIT_TEST for sandbox.
> >
> > Correct the condition.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  include/k210/pll.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/k210/pll.h b/include/k210/pll.h
> > index fd16a89cb203..6dd60b2eb4fc 100644
> > --- a/include/k210/pll.h
> > +++ b/include/k210/pll.h
> > @@ -13,7 +13,7 @@ struct k210_pll_config {
> >       u8 od;
> >  };
> >
> > -#ifdef CONFIG_UNIT_TEST
> > +#ifdef CONFIG_SANDBOX
> >  TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
> >                                    struct k210_pll_config *best);
> >  #ifndef nop
>
> Tegra? Do you mean sifive?  That's where CLK_K210 stuff is... but it

Oh yes, I got confused.

> also seems wrong, you can run unit test on real hardware, and this is a
> test that could (should?) be run on that platform.

Only if it enables UNIT_TEST. You cannot run unit tests without that.
The current tests are designed for sandbox.

>
> --
> Tom

Regards,
Simon
