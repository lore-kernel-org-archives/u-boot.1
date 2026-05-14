Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF23CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 10:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86AF8464D;
	Thu, 14 May 2026 12:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hxoYMTdl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D712184676; Thu, 14 May 2026 12:37:28 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A21968341A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 12:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67da63ae541so13764981a12.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 03:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778755030; cv=none;
 d=google.com; s=arc-20240605;
 b=lMGiNI5CNCvr8n1THr0k49t1vGXqmuCv04pghUTt8nA2igilt3q3Cq5fRkdowLSbaT
 O7LUeBKSBXA8EJvefUkVMi2GAxb5VU/q3xfVNYv1rEc8xIe+aCA5kIi8Ui4zb47XN07Q
 EQe4LKvG37OAkQMjHsHIiC9OgspJzBTyQc36Cno+IHjtI+kRFil3dH1/7HbO1dTOmh/L
 s6ZhE4Gli6qHbehwnJmmk4aYaH5rJpq6KaXkzT3zJOtInViQJSVwc+Q7VeVZdnGBEiVJ
 tr6LNGH9SjJVBrYJYwbZhl/8kPqarzsZQT5bRsJJ6KaHwQwkkEvQw6i9SXyv+LhLe+iD
 XJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vIQtJ8CzyVnSHc8sJSqsH3PIypAZmB2A/YeDi6QYuXw=;
 fh=LZ6dVfZKxvPC3pjJ6tHML/I723Bx8ry+pwFPNGkCPgQ=;
 b=T8JuRT1+xoJZu4SahvN8WATnT2Qf9fXECjWttFDCbEzFplcMeryTB5LGbYeoKLczcW
 NW8XE75OLf7TdeANG0X0c7iBZuvTmhF4a2JSAMPbuHsrZSOuVvJ4/gW2Co+9ojBmjfKW
 dpE/gg3o6xNwmlBnf4MwYH5saEHRneuR53DL6vlN9UFJ8yElyNA64ZkDFvTOODYWlpAe
 ADwBZ751Q1Vu8kRgVD4pIMb6r0CNTH/7ClyByj70j/143Hd7woN57+WFKpfQWwcc2Icz
 OQx7q1B8eq2gvKRzLcxJpTwWULG3QWEWt7fWq4BHYdn79Zx44f2XqvNda+inQpnR+pRk
 Y6cA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778755030; x=1779359830; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIQtJ8CzyVnSHc8sJSqsH3PIypAZmB2A/YeDi6QYuXw=;
 b=hxoYMTdlzi1f5byNewcqslOen8tF4r5HvFtgfopCUnyFOwRoFfXJ00YlChFh0f3xue
 KlgFhAx+vL6HkYzNYo2bS/Hi0JUTZRHvCmObAsbC1TeQroqzFRxiEIR3KSi+dODMSdQJ
 dI897CyNuPhx3piwqAvuBgqHP1Yic5Zxz8JTnZ7KbNwyEfMT6U04WzAI3pet6JiKVPtq
 YWgyXHWCMEjgQDYg8o5nHvR+VYKV9JtvejC1YHDRW29TpMJKwvnvWRJzVQ0HeM9HGUtW
 jS+yS7c8D9ae/oI/aauGMSQ6B2UePo33xY4F0WMhRg26m2a6CWH1LUNdNG8i8836vVm4
 yJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778755030; x=1779359830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vIQtJ8CzyVnSHc8sJSqsH3PIypAZmB2A/YeDi6QYuXw=;
 b=rM/4c9y7PCD5LuDGGMLcass+qtdwzy/cI0yI6c2sW34uv5vL3YX77vhC06eMk7yTB1
 M406ZciuazDZJMMpElon5YNIbk7Xq2vE8aHnMX3gQoddl/lq5LYlcJd9erPcaNjXuVEO
 TNLfdnCSfjT7kTRTt0ynlM0MkRUfKGfTqsOxDeql1Hp66G51sNDBcfOKyeAuPsD0/mCY
 oJLCGUl3ln9qUOWyI9+Wa3oqll+OEJEorxkbP3NszREZ8zXMA4qaXeNn6pMRPCiJflb+
 siSV7ObJHHfsV4N1N5KaVATi/8ALHZo4+3H1kvDO9FWLXlxnLc6OXaSwLyn5wcgsgMD3
 CL8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JKcE2x83Snejcei2IxTlZZAogiafEdCJ6x7XvYhpfXBUTkNmcBLqryISVtz2YfkNm3+prNf0=@lists.denx.de
X-Gm-Message-State: AOJu0YzIbvJaF8dSk2o1vYtofaMmM56vVknlhXHQWRonZ3VFZseKl0Xq
 GbrMojXbHW6MJ+bu8WHaPaouTVp8ItmzkupnCoJdHvBMqCKBZOzjGRmhI6qFJiVwAjUT79wpeDL
 oVYHudtpd7Ri2YZyk0DcHE7mLwSQKK27X3o9c
X-Gm-Gg: Acq92OEfIwNFUI4ATuGfis/clh2qjqsIILRZPxiHVHo+If7RrMfcc3FH5V7mxQyXsML
 mI/B0q2ehDEM09phrYuY2cC+CPAKv2VDj29tO33JFWB4W9ydwhBY1T3qMCliAPX3mB+NpICNm7m
 INW0g6Vg5yTpDx/jsjIzTQns68sXMgJ3RLiNK1iUsIal8YWpzfG0xJFBfrt6CJk7IBK0NR7KzQg
 EbnKAZFzs4BbCYYz3Q2fos1BbdoMKYd0Y8NEzouq0DCNNGKo2l6X/sIJ4roN6n5qU+KGRbX5b1U
 n7+LhanXKKnk+ndUD9zx5G7hGx62EvyUOvHe7HjJCgu+WKVgS8rXIRx+OPD4ca4X+9AGtjrTuKl
 nFkSg84RsZS/KaUU0PeqADElUt1dFHdiyfZ5AKh9V5PJrgkEWcvaDh8XY/H7Kjj4S4lXCyjMxPl
 ut
X-Received: by 2002:a05:6402:22f8:b0:672:c169:606a with SMTP id
 4fb4d7f45d1cf-682580b31ecmr3136340a12.23.1778755029552; Thu, 14 May 2026
 03:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
 <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
In-Reply-To: <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 14 May 2026 11:36:57 +0100
X-Gm-Features: AVHnY4L0P-XotxcdlDAphUd__6dCEql9-ouV8rQ5Nz8EkFN-p6bZrtfgpV7hvrE
Message-ID: <CALeDE9PesKLwzt=uu_b8+pq5QXFnnK1YAO9WL3f8=CHx93w61w@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Brian,

You have made a very generic statement about levels of accountability
on patch sets and consistency in reviews.

Can you be more specific?

Ultimately there are subsystem maintainers and each maintainer has
variation on how they deal with their subsystem. You reference one doc
three times in your statement.

Ultimately the rules are there as guidance and if someone chooses not
to follow them to the letter there is little that can be done. if the
individual becomes problematic they will be asked, publicly or
privately depending on the situation, if they could better comply and
there may be further action.

It's very hard to act on your generic statement without examples,.

Peter

On Thu, 14 May 2026 at 09:41, Sune Brian <briansune@gmail.com> wrote:
>
> On Thu, May 14, 2026 at 3:29=E2=80=AFPM Peter Robinson <pbrobinson@gmail.=
com> wrote:
> >
> > Hi Brian,
> >
> > Can you provide more context?
>
> Hi Peter,
>
> Not getting you sorry.
> Context means?
>
> Thanks,
> Brian
>
> >
> > Peter
> >
> > On Thu, 14 May 2026 at 03:02, Sune Brian <briansune@gmail.com> wrote:
> > >
> > > Hi Tom,
> > >
> > > Sorry to bother you.
> > >
> > > I am curious that for me myself I had no issue to follow
> > > the requirements [1] as long as all patches that are
> > > passing the review stage do follow the rules in [1].
> > > However based on most recent commits and reviews
> > > most of those are not even close to what [1] mentioned.
> > >
> > > So at the end, reviewers in U-Boot just made their own
> > > standard and requested contributors to follow?
> > >
> > > Rather the U-Boot itself should all follow the docs rules?
> > >
> > > [1] https://docs.u-boot.org/en/latest/develop/sending_patches.html#se=
nding-updated-patch-versions
> > >
> > > Thanks,
> > > Brian
