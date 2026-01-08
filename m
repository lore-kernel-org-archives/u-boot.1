Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCEDD14893
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 03:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BB3B83A1E;
	Thu,  8 Jan 2026 04:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IXdHGML2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C8483A26; Thu,  8 Jan 2026 04:58:46 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1FF839DE
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 04:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64b9d01e473so4250329a12.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 19:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767844724; x=1768449524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a02I5NpBoVcWqDpbDAzTVWJ5nKF27/6jiIt7hMe8aiQ=;
 b=IXdHGML22CS9N964XFHy30WuyK26QYc8HSY6XzRdioKlSgrmDoflBcBuNuHs1EO7oT
 kgR3eIQgh0Yn4y15xWuKWHA28bYQp7+T6u89w8tiUnzExrJyg8NDxE6bF4X+oYgiHz58
 EDhZ1SLMk5QfOGHfx+8aTJhcKUOlJLn5TNI3qi3G2JHZXh9Np0JvTd02+GZWvbFHgUfv
 TpJ1vp0YCU5ZpPa9wvO+/acMLcxuFzm2ihbkTKAM0QW9/SzvQ3swOygOHtSADkgkBADz
 QD+6p4I2QKTX5H00GQVJhGbQ8Gu4tF4fVv0FkS8k5MgVBsScM8LWtL6OTABtJKH2d7BP
 K+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767844724; x=1768449524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a02I5NpBoVcWqDpbDAzTVWJ5nKF27/6jiIt7hMe8aiQ=;
 b=Z6XVu2YkbUR2KpIsHvwRXqnagykUr4r74VCYX9r1665T6idiaZH1kp8dYe2zPeVBqy
 fD9xiosGmxwtlmCE/IYCs87QIrDL0Si0YBp+DSpOL5/4r0qXMPTRHqBdDU7dmg/CIgZP
 ll3qJPfzJAMU0kbwMc6iLbHUg2Kw0aqXV/CXlwI6sdlbDmateWh3T/Eip+XM7vWiTRmJ
 1FnGKCzM78hPClaDNrx+qbghUu4Jd6QG1kOvwaUnAe28sCfuVURQbwDAiJRc45sXZALK
 wKubP25JtNg2vlobTzqnoyaNvcVKZJozNjvkr9SOXVib2GNAk+Q6+0dDmbjnXKCJIIx+
 zg1Q==
X-Gm-Message-State: AOJu0YyK4Ja5WttMJ83+x7EqUiFdIXx9Q8FIP1hGcYo1Ak8g5V8oeCxK
 1/4lndeBmZHSZkTTDz9buqYkO25UvT9knhoSU0qSpv0jYTXZ4JL7E1cR7h074KYyYNCKkn6XfVe
 rTiMxWhIlSjqJbKvDpakJtSSmf99oXpc=
X-Gm-Gg: AY/fxX4WR1b0PrU/2digoYX86aitAPgymLByAU5uHBBuX+rzgfTNtySx2tKHfCcM+8P
 TRuxj8zIxJrKpXEfofXUpS9gGYGvVt9hMfBjKwgPNdbIPbHCkyjbRz9Ni+cwqm01sh9RsocUM4g
 7tYXid14t3UgOIoiC3MP+55EfO5aVLvUJohwGDwAHnlMAylePunSYaTKz9Vr+CDfTIHK9owoun7
 1lb3wiHeP9uMd3IsmUsTuYBJcdfo635FYSESEV9hBWz+BltxZ42opxDbEmCdsPr3G7Tgpb9UwKi
 umFkBQHYunictmgzh96Q+YJQdHLJLMOXASyJxP6G8NM0N+9OfVAUxrQpZ906Rgv2qmOuGUsZB8A
 LytTnhyws3HGgUElsTh5OQX0YMlXE/aK97dTH
X-Google-Smtp-Source: AGHT+IFFR99bPa4K/xGtVX/haFAM300OW/nt8zt6ohx6U+IswqtbTiMvY1cRt7sECzN2iLFXL45UcWiVBTN2absKRI4=
X-Received: by 2002:a05:6402:34c2:b0:63c:eb6:65e8 with SMTP id
 4fb4d7f45d1cf-65097e6a85dmr4374656a12.30.1767844724020; Wed, 07 Jan 2026
 19:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-11-simon.glass@canonical.com>
 <CALeDE9OzMUm4PjymcOs_iAWWwoN+BSi+gDHXq4JvmCsB_YM5vA@mail.gmail.com>
 <CAFLszTgPoJOvryUEdx5FSkgejy4p1nYrXd5cNXU_FUaWqeNwCw@mail.gmail.com>
In-Reply-To: <CAFLszTgPoJOvryUEdx5FSkgejy4p1nYrXd5cNXU_FUaWqeNwCw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 8 Jan 2026 03:58:32 +0000
X-Gm-Features: AQt7F2pe9I6LYRtG0BPLx5Y6tYvpnYFY7cr9mjbs9XhTzhjU05V8zhf-dPnWBSg
Message-ID: <CALeDE9P06_73XyVS00cfMXX=08QPRd-4yaxjehqRi99LW7_D0w@mail.gmail.com>
Subject: Re: [PATCH 10/10] x86: Add cleanup_before_linux()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Bin Meng <bmeng.cn@gmail.com>
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

On Wed, 7 Jan 2026 at 19:02, Simon Glass <sjg@chromium.org> wrote:
>
> On Tue, 6 Jan 2026 at 19:37, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Wed, 7 Jan 2026 at 00:40, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > From: Simon Glass <sjg@chromium.org>
> > >
> > > This function is not present on x86, but there is an x86-specific
> > > version which is never called. Add the former, making it call the
> > > latter.
> >
> > If the later is never called up until now why is it actually needed,
> > if it's not been missed until now why not just drop it? Please
> > describe why in the commit.
>
> I'll add it to the commit message for v2. The code is:
>
> int __weak x86_cleanup_before_linux(void)
> {
>     int ret;
>
>     ret = mp_park_aps();
>     if (ret)
>         return log_msg_ret("park", ret);
>     bootstage_stash_default();
>
>     return 0;
> }
>
> It seems important to park the APs before booting. I think it was just
> an oversight.

You think? Above you said it''s never been called before so it can't
have been *that* important!

>
> >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > ---
> > >
> > >  arch/x86/cpu/cpu.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
> > > index c373b14df30..f756a9ebf09 100644
> > > --- a/arch/x86/cpu/cpu.c
> > > +++ b/arch/x86/cpu/cpu.c
> > > @@ -80,6 +80,11 @@ int __weak x86_cleanup_before_linux(void)
> > >         return 0;
> > >  }
> > >
> > > +int cleanup_before_linux(void)
> > > +{
> > > +       return x86_cleanup_before_linux();
> > > +}
> > > +
> > >  int x86_init_cache(void)
> > >  {
> > >         enable_caches();
> > > --
> > > 2.43.0
> > >
