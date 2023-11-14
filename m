Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2718BC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 10:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3321B8745A;
	Tue, 14 Nov 2023 11:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHqdPplR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E2C687456; Tue, 14 Nov 2023 11:42:28 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E8487243
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 11:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6ce2c71c61fso2938107a34.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 02:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699958542; x=1700563342; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e1S+txNFMqFcnRAZGsjPX7rixQw2I/IQqbqtDOSdJUg=;
 b=mHqdPplRKHXusAgTsPNU9qtq144o6R8MPicHD/8tRJvy8isprOXSfAHE0atDYwS39R
 ilBFt7TXmBkRqnFALwnMGrxO0JSw3JUQ0LGXGO06ZuY33xyx0mIzkD4c5PW1XtcnhpuZ
 3CwGSOH/oS18WdpaLO2lxVuJryYcb36Vs64BwJM2ggNLXq6HQKIhXW3r4RpvusKAZO9O
 0l7THtqeVkBx2BSfHTccWMJ+8mrSTsrbq/P96DYxwuZ9GuqyXw9htRJifqZolZWuY6qr
 mSUdeY1LOg/BxqzrgkRSWi5kb8a7xSxdikizSCmbU4d5lyFQShXjo/tpdQTd55UfFzVg
 Eemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699958542; x=1700563342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e1S+txNFMqFcnRAZGsjPX7rixQw2I/IQqbqtDOSdJUg=;
 b=hMzMd/7H9ieiUeDXbA3boRkKXdTrV12YqA5FHFEVlK63Sv5ucQ8CRmCugf6OM6CRbR
 Q9o45mN91GvQ7QRqnYTX1auP9DzuP8tOKEcTW6ZmFLOkg3D9791yKsTQK27wUB6jHvgA
 crxWxRSic3y5vJSQD4jCIhhvJRwRW59dl+vpOwvc32AsKzqzJJuA2CreXbji6hbPiF9k
 qC9Mlkiw/2FWWN1dSdzn04juI+5Hw96fTifsy8jhYWTADz/v/sgCUj5A5QUL8LtKdNUN
 ZKKDJO267MZDR88zIAtKRqmf+vpG5Pt+23VQtn6bwMEKRebyw8Kfm/uZpdRFmF2qxKM3
 3Sbw==
X-Gm-Message-State: AOJu0Yxu7p3IgMmq2LH6U/LoVSNNPA5ykDXvKYglc62qL+qwxVarzHxz
 drofr15QWCaCU/1kl1riP+mDsaUEB9zpBzOg/cg=
X-Google-Smtp-Source: AGHT+IEsZh1j1BckP6m1ZXvyucWBacmQeFUe21El0esVwjjdA0ZtycxUdfmAZA5XC0Y9lFrCWwo6YBQYGqmKhuQITWk=
X-Received: by 2002:a9d:7d07:0:b0:6bd:db8:db with SMTP id
 v7-20020a9d7d07000000b006bd0db800dbmr1809037otn.32.1699958542005; 
 Tue, 14 Nov 2023 02:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20231107212200.1457-1-semen.protsenko@linaro.org>
 <a84f5367-237e-7599-42f0-bfb3e99f9f63@gmail.com>
In-Reply-To: <a84f5367-237e-7599-42f0-bfb3e99f9f63@gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 14 Nov 2023 19:42:10 +0900
Message-ID: <CALrBrZ0KOhPyFe9qU1hgxu+VRbcusU4ZWeozvo=hFv9Feq+qPQ@mail.gmail.com>
Subject: Re: [PATCH] clk: exynos: Add header guard for clk-pll.h
To: Sean Anderson <seanga2@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Thomas Abraham <thomas.ab@samsung.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2023=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=EB=AA=A9) 04:54, Sean Anderson <sean=
ga2@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On 11/7/23 16:22, Sam Protsenko wrote:
> > The clk-pll.h is going to be included in multiple files soon. Add
> > missing header guard to prevent possible build errors in future.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Fixes: 166097e87753 ("clk: exynos: add clock driver for Exynos7420 Soc"=
)
> > ---
> >   drivers/clk/exynos/clk-pll.h | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.=
h
> > index c79aac44258b..7b7af5e67612 100644
> > --- a/drivers/clk/exynos/clk-pll.h
> > +++ b/drivers/clk/exynos/clk-pll.h
> > @@ -5,4 +5,9 @@
> >    * Thomas Abraham <thomas.ab@samsung.com>
> >    */
> >
> > +#ifndef __EXYNOS_CLK_PLL_H
> > +#define __EXYNOS_CLK_PLL_H
> > +
> >   unsigned long pll145x_get_rate(unsigned int *con1, unsigned long
> fin_freq);
> > +
> > +#endif /* __EXYNOS_CLK_PLL_H */
>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>


applied to u-boot-samsung.

Thanks.
Minkyu Kang.
