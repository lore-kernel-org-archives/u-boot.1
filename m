Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C87C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 17:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E9383FEE;
	Sat, 27 Jun 2026 19:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pUtCb07p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871EA841F2; Sat, 27 Jun 2026 19:24:39 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70173805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 19:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7f69b71f7b2so23282327b3.1
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 10:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782581076; cv=none;
 d=google.com; s=arc-20260327;
 b=kDQRV7U20+jBDGVSwHDJzj8CqS0FV+/iwvZYD/rQuZ0nOW4T+KKkjoZHJ7tIHd4YZ0
 gkKL65ZsWlm51R78OUOTfOz9tf8YSGYjJuzthBmSvp6sRKJUUeRqtEEcOhxCzk3k6brm
 shhNRbvJKtflRLF8Zwr+0dxZRbfPr0hHLf/7/U1tiK85w+ZOl7xsYM69vl8n3nuwj60o
 io/4ccs0LHu2oaqeU+YzZKjLVEVlCgEKB4uhzNRxWCCGg19d7EXojvu6T6rpEHe6eC8r
 ihJcFoZ+gfNr+nzchaCjgGE6YTfz4zTwqA+AKZpIAW0fR6IDZUlzyhRbGs7tmlbLlFWY
 BgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6v/atP4j546DHqwZ6ualptlxPG/adLlcG8dv72yAbMg=;
 fh=7w1nR8YNQ/Bvb2TNjZ+FLV9lvbtFWIuQNcdppRtGCVM=;
 b=efFfM/1RPqSYML+N63pWN0MS64ynEhId+H2xyoHhA+GnC6raLXAZAQs8t5387KRNy/
 GD+LQbj+63gb9V52CSRFtRxZyN+vBkpmLaOngVI1DhAFUP12dc6QdX+/W7yITV/BmlrZ
 vB3V/zKl3gEGa8vFqC1Cg1nXn2qSvAC6KpPJLi8mkn6uKGVoUH3j/PZa6o4NPfyorKfk
 KWLjDnLuOuWtwsy6wg/CaIWrdM2k3yg6xDD4GMIwI6xfK8rSEaN4VdL5YPPsfohhf2lQ
 SMTv0BY1/s/7Nd4ujfA8dwtadh3Jx6k/w5ORdvKPtIkQ+GrgGXulDKvfry6EDJ/+LGNC
 IqMA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1782581076; x=1783185876;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6v/atP4j546DHqwZ6ualptlxPG/adLlcG8dv72yAbMg=;
 b=pUtCb07pdIXcuWwa92Xh52IpkbVSVzTI062Utd/GUMopWuj1o27nB5jyw+Kto4rLvq
 xx6PX/JWoW3jKbJQGkUToa8fEDeHf2EVDz4n59nFMPl7oKHY92iucHzlIKnVP3bq/nX8
 bWJPW25DKpv2dADIyCZfXp4HUHgEEYRWMyHl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782581076; x=1783185876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6v/atP4j546DHqwZ6ualptlxPG/adLlcG8dv72yAbMg=;
 b=fzeQ+qhgW7dIsBZdk5BQlGbWLQeR8KYLAn6PYsT6Zv+QOjo0KN4kkPNHzQC36hJOMe
 +A7ZTLH1xW0oXbyCB/fSsgYjV2wcatrS4Smxnd74eHSG7dSsyjTEdFM8KhUWyB+4A9YO
 9dWLu5W5lQ94Mzf0FswcXgfehWDVL5vhNkzZR29ViwNMMcwKQz8lfNt2XBN/3G3UVs4K
 j+qd+JS2qzqgkSLnj0+kcCxQ+toNBy1yUkaqWkP1CbQ8snAeRUSK3xrRwDpKQUNvjiod
 YpxaiID1FjKU8Lie+fg7lb/fe5RUnnKm484IA91e7LJHgiYvabMnvKsUo9R0RKhD6PkH
 FDnQ==
X-Gm-Message-State: AOJu0YyNkdZv7VBC2PfleP5kCAYagEc4+/UAe7/lSsf8xIq2CT2NBzxa
 2FruoGMUX3G8zt5gcjipF7o5q9h9drUql29XmDP7kye6g89u3eDopIhesLpt2tkYjEI+Nd/CvIv
 Gbdp3m20jyETvYjQm/TIXucBA2cROxWa/n3duReRgcA==
X-Gm-Gg: AfdE7cmMQwCaPJ4s3tmvya2fFxzoALhygbbTn8Zw72ul9TAmcu2L2CFlvAuJqPZri6a
 fBQxE1gk0LCCV+DDFVAqqjjbN1cpwA1OkpAixfXeJGfeuS15FFAS9voH4YaKMtqEojNeXvjnysx
 CXy8jUwoK59azpiizxrtIENRTWjd9nQsSIBxs/mFxjn6ycowqlEiYoWhCYpNomwkgSHLAd+G3Pm
 HqXc5siwJhWEwRmfPus72YjBzUMLc/SwG0eslGY/suCqH+sXWWTnfmUEP+3tOigkOsGwdpHQ5jJ
 9T9OpR0mUeZcp6NBhmNiRzXjZHg=
X-Received: by 2002:a05:690e:1443:b0:664:8e4e:6709 with SMTP id
 956f58d0204a3-6648e4e6a65mr8343253d50.7.1782581076273; Sat, 27 Jun 2026
 10:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
 <3dfd02eb-fcc1-49d1-aea2-6bd20f052692@cherry.de>
 <20260626215804.GB382693@bill-the-cat>
In-Reply-To: <20260626215804.GB382693@bill-the-cat>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 27 Jun 2026 19:24:24 +0200
X-Gm-Features: AVVi8CcPZhTHFAYp0TCzSht_8R3OwH4g9L9THg-yVevRy_RRwtIL6P7IsVTuoNM
Message-ID: <CABGWkvrCJn_ABadB0AmTQ6dp=ufDi1GdSYgSP1fkwCQQM=OL9A@mail.gmail.com>
Subject: Re: [PATCH] test: cmd: part: fix integer handling in
 setup_gpt_partitions()
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Fri, Jun 26, 2026 at 11:58=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Jun 26, 2026 at 08:40:36PM +0200, Quentin Schulz wrote:
> > Hi Dario,
> >
> > On 6/26/26 8:33 PM, Dario Binacchi wrote:
> > > Coverity reports an INTEGER_OVERFLOW issue because ut_asserteq() comp=
ares
> > > an unsigned int (mmc_dev_num) with ret, which can hold a negative err=
or
> > > code.
> > >
> >
> > The trick here is that ut_asserteq() takes two arguments and casts both=
 as
> > unsigned int, hence why it complains.
> >
> > If Coverity is happy, I'm happy :)
> >
> > This looks fine to me, so:
> >
> > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Yes, were you able to push this through coverity on your own?

No, I haven't.

I couldn't find any documentation on how Coverity is run for U-Boot.
Is there a recommended way to verify Coverity fixes?

Thanks and regards,
Dario
>
> --
> Tom



--=20
Dario Binacchi
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
