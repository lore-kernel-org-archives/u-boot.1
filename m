Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F156DCCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 11:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C64883CB9;
	Fri,  7 Nov 2025 12:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SHsQ8jOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8408A83D0B; Fri,  7 Nov 2025 12:04:32 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF6D83CB9
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 12:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b67ae7e76abso380442a12.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 03:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762513468; x=1763118268;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfAOGZLLnnOjJKSkgOJKooRbVTf3u/4eIvoenz6pZQQ=;
 b=SHsQ8jOwkflTmaIDVM2bKKdJs2Mp26pymWgiwUCI+vMaobc7F0Fl85pV6RxOMz8KsB
 uZ8IkfDCitfoPsZSlEVloZzClIoP0wZ+LWf5MLxMpjfHG9Se4DwVGEy/XTtDo6fcV92P
 ZUhU/tt9ARaAkZTzacNuMXIriQt/M85PkvedM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762513468; x=1763118268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hfAOGZLLnnOjJKSkgOJKooRbVTf3u/4eIvoenz6pZQQ=;
 b=VnSc4aKzEeN6xeXXQM55dyWqxYas6Q37/NT2ZSdQJxoZKtzbD9Nmp8sQsDThKLODJ+
 JKbFvcRzlQaC/womruKfY1S3FtTKhZzx0ys1jpeE5nbY42aqrGLwCoOwrP3eRZn2XlGS
 aH1R7Bcfjur1Zifsyr7USgJvKUWLl/Z7S/Oj2JmqBZc7pTm+DVzQNo7fH3p8oC/XRQOA
 3LK5dsOhSNfoQ5I4emCsJS7fBi58FFnb1fpAhU+Wx5xlefr27ayxpWb36QlCH71HSkkn
 8lmC1jSpAgtfUUpNNNuQLgWTGbKfAXG9aNY/WIWpTP17mP+lSus4sxb/sJFX6OJhUL0n
 feRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJUM75iuLXn2oBNERs4ztt7Z76TJIkj3A7PfKocIHvCGZneLuKLM/ZbpTFBHaAzQL2e5g+vNE=@lists.denx.de
X-Gm-Message-State: AOJu0YwSq9f34EcgyRdg8v5lHJNCCCofkBAWw7769uE+W5JofXvRTEt8
 HBbqnet038Iqig4ck6u0foj62YAEZ0JIFempDqN598cXhLJvwgXlu96FUlWz0mS3jGGG/nba37T
 8rQgd6xiIolmzOpelY1P/FepwnCjxa1aFBhBYnSK0AA==
X-Gm-Gg: ASbGncsgmockGvo6qn9xyL2F9/q/7bewcIgQW5X3nM2S+Pkfzd9ja3AYP7HKZoPxNnl
 M1SzvaGnzHorM4eFW5CNbHAmMTrIQALQSSHGyns/YDHZSQcm2xGSOYi9MBneNNdWb2cEKEYLiph
 u7SMo3OqHnQzRMOmjPTDqrxqA8gN5WwO+PXSBG3fpZH14niNUtSDkLuT48z56AFPMGHxrYL4xJu
 iQl5OZ+hZ2RvJW6rOaSksgBrDX7YS9R652lW66mCbpfvxwcVAT6R0QT0iyYfz6DPTwf8UkxruDa
 VBSDjsOvHbZyBA==
X-Google-Smtp-Source: AGHT+IHbgkWXY4z/biDzcZHSdRgZi4c8RRcPKNu7VAPkPWMylu0RSq1OSk2lTDsK8VVTqFXsNCWVs4yVKxCX02tqPP8=
X-Received: by 2002:a17:902:e80a:b0:295:9c48:96c0 with SMTP id
 d9443c01a7336-297c03d2bcdmr37926235ad.5.1762513468233; Fri, 07 Nov 2025
 03:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
 <20251106-pmecc-v1-2-a1f3cf430be9@hifiphile.com>
 <68d45e9e-8eed-439d-be9b-9d6f9e13fe89@linaro.org>
In-Reply-To: <68d45e9e-8eed-439d-be9b-9d6f9e13fe89@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 7 Nov 2025 12:04:16 +0100
X-Gm-Features: AWmQ_bmDwiE2kKwFGVuqpn1DC2WF1pHOVBP7z87POC_vrt80Y5MJe2udml8r80I
Message-ID: <CAOf5uwkZUnUSjJ=CqtZhVf-rQ31eU4gC5o+XDXKJEAtRrY4NKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: atmel: Remove timing from atmel_pmecc
 struct
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Zixun LI <admin@hifiphile.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
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

Hi

On Fri, Nov 7, 2025 at 11:56=E2=80=AFAM Eugen Hristev <eugen.hristev@linaro=
.org> wrote:
>
>
>
> On 11/6/25 13:12, Zixun LI wrote:
> > "timing" is unused in atmel_pmecc struct, also it's not exist in Linux
> > driver, let's remove it.
> >
> > Signed-off-by: Zixun LI <admin@hifiphile.com>
> > ---
> >  drivers/mtd/nand/raw/atmel/pmecc.c | 2 --
> >  drivers/mtd/nand/raw/atmel/pmecc.h | 1 -
> >  2 files changed, 3 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/=
atmel/pmecc.c
> > index 7c4e9bd5f9967b119239adf2b39e683ea62b71fd..8fc5614cc0091d3e0f4b928=
0beee9e684fe2a57d 100644
> > --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> > +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> > @@ -839,8 +839,6 @@ atmel_pmecc_create(struct udevice *dev,
> >       ofnode_read_resource(dev->node_, 1, &res);
> >       pmecc->regs.errloc =3D (void *)res.start;
> >
> > -     pmecc->regs.timing =3D 0;
> > -
>
> I see there is also an unused parameter to atmel_pmecc_create() called
> timing_res_idx .
> Maybe this parameter was intended to be passed to the timing mapped memor=
y ?
>
> If the timing_res_idx is related and unused as well, isn't it supposed
> to be removed together ?
>
> I see it's being called with a hardcoded "2" , does this have any
> significance that you know of ? Or it can be safely removed.
>
> Eugen
>
> >       /* pmecc data setup time */
> >       if (caps->clk_ctrl)
> >               writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_C=
LK);
> > diff --git a/drivers/mtd/nand/raw/atmel/pmecc.h b/drivers/mtd/nand/raw/=
atmel/pmecc.h
> > index 43f96b2f168c7b88e0c907996f2ae64f8554ed58..88b0d18040e7c48f226c74c=
e9b5caf93b5760360 100644
> > --- a/drivers/mtd/nand/raw/atmel/pmecc.h
> > +++ b/drivers/mtd/nand/raw/atmel/pmecc.h
> > @@ -65,7 +65,6 @@ struct atmel_pmecc {
> >       struct {
> >               void __iomem *base;
> >               void __iomem *errloc;
> > -             void __iomem *timing;
> >       } regs;
> >
> >       /* Mutex used for pmecc enable/disable */
> >
>
I'm willing to help to clock part of nand, can someone point where I
can buy the board?

Michael

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
