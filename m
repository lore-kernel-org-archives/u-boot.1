Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F48CA0ECC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 00:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD32888D17;
	Fri, 30 Aug 2024 02:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IkqLQB8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A02C88D1F; Fri, 30 Aug 2024 02:59:07 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF44288D06
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 02:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-44febbc323fso6756811cf.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724979543; x=1725584343; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4iELr4gaUmCtw1AkJ1B0Q53p1vCF1aIcu05n7dTHAVY=;
 b=IkqLQB8LkUEzeS0Mzq5OLB4rnzOloCUOZv+uUv70gwvkHybz2JHNCeVjmKRs08DsFd
 3z4bXj66QhNKR9PgDKn/llz77GIrnz78seglOo2Cup2Xqfe6GzdFDi+uHSCYt3uDnNy9
 ER4+bFtn7hCylcqQ+lwLaTlOdQeR9hFYKqsOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724979543; x=1725584343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4iELr4gaUmCtw1AkJ1B0Q53p1vCF1aIcu05n7dTHAVY=;
 b=b0BmbwYybtBceiJtq/WdHPRSXXJrQL5sWpRaGc30emsJvWrm5RouGAnpihvuGqr9rn
 abwym8kQ/ZzHItvbJWSF2vWGEOwHCg/fjzVRsiH64Md3oGe+Zmb9IxhMiDF5qiTrx3j2
 E080NnlcMESMQpI6aOkoVHFyE+vSR9o39Sa2WzIuSc4D+E0nCDN1gz/dvlbO62tWSJQK
 616QxygyEtGbruwmbh3A4ga+oT5rYDk7UkV+nqFmzX5BHfK80y8KFU8ERqI83aNGHKx1
 Qx8klWB5oOChmMq7yzZAak2ULCCoCceqlMGQKkJtNpOvXUCJPOOnhC/I/VsjpbjgnaPr
 MgKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU77jiwEfrPDo4xEI8JLYwwR/8AXPhdPge12G6F+Lp/tfF02PaOLsfur3+b5tRYE7KxmUhzfKI=@lists.denx.de
X-Gm-Message-State: AOJu0YzMsVYxdfcgV0995ScWxiCYhgyjhaFMGjOpRzyRGewspwIC3uaw
 tOE2SZNJx7OYXxoZOH7H9K+W5wjkLMD97Q6n+3RXl+HByrwXVLtHAVNtWmqZEO10h0SQdX3QB2j
 iWJGH6ZilTAIaPyRGrBvh/Tou0qdCm33TDTg7
X-Google-Smtp-Source: AGHT+IHZIt7ZTn/JnciWY6FK9HMDSRPVcfGecqgxm20kwhRNJYej0t9BRD0lncQHNapP3tgD4yBT1SIPHlFnda1/nks=
X-Received: by 2002:a05:6214:5c02:b0:6c3:3c6a:a907 with SMTP id
 6a1803df08f44-6c33e69c649mr47556786d6.44.1724979543575; Thu, 29 Aug 2024
 17:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
 <20240825122617.3708982-2-dario.binacchi@amarulasolutions.com>
 <CAFLszTgN=GWbrJAmtBrb95i2ovAhfE1BPco5p3whnL-oCAhbKw@mail.gmail.com>
 <CABGWkvpfiduptB9H_5zK3SwKwXjuQN1u1YPGukypviDstuZoEg@mail.gmail.com>
 <CAFLszTg47_=TnQ6qy2UJj0n89B8TWrw0tH4RVk+GQKFS_+Sjmg@mail.gmail.com>
 <20240829150329.GB2479150@bill-the-cat>
In-Reply-To: <20240829150329.GB2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 18:58:52 -0600
Message-ID: <CAFLszTiE4QApoJP3hfkL-HZbxZNLC0T2z2BaGrRDVedtB=f-LQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cmd: booti: adjust the print format
To: Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com, Eddie James <eajames@linux.ibm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom,

On Thu, 29 Aug 2024 at 09:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 09:00:30AM -0600, Simon Glass wrote:
> > Hi Dario,
> >
> > On Thu, 29 Aug 2024 at 08:25, Dario Binacchi
> > <dario.binacchi@amarulasolutions.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, Aug 29, 2024 at 4:05=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Dario,
> > > >
> > > > On Sun, 25 Aug 2024 at 06:26, Dario Binacchi
> > > > <dario.binacchi@amarulasolutions.com> wrote:
> > > > >
> > > > > All three addresses printed are in hexadecimal format, but only t=
he
> > > > > first two have the "0x" prefix. The patch aligns the format of th=
e
> > > > > "end" address with the other two by adding the "0x" prefix.
> > > > >
> > > > > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.co=
m>
> > > > >
> > > > > ---
> > > > >
> > > > >  cmd/booti.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/cmd/booti.c b/cmd/booti.c
> > > > > index 62b19e834366..ea811244a0a9 100644
> > > > > --- a/cmd/booti.c
> > > > > +++ b/cmd/booti.c
> > > > > @@ -78,7 +78,7 @@ static int booti_start(struct bootm_info *bmi)
> > > > >
> > > > >         /* Handle BOOTM_STATE_LOADOS */
> > > > >         if (relocated_addr !=3D ld) {
> > > > > -               printf("Moving Image from 0x%lx to 0x%lx, end=3D%=
lx\n", ld,
> > > > > +               printf("Moving Image from 0x%lx to 0x%lx, end=3D0=
x%lx\n", ld,
> > > > >                        relocated_addr, relocated_addr + image_siz=
e);
> > > > >                 memmove((void *)relocated_addr, (void *)ld, image=
_size);
> > > > >         }
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > > > I really don't like this...numbers are hex in U-Boot and this just
> > > > adds confusion.
> > >
> > > Sorry, but I'm quite confused.
> > > Doesn't printing 3 numbers in hexadecimal format with different
> > > formatting (two with `0x` and
> > >  one without) create more confusion?
> > > At least we should ensure formatting consistency.
> > > Also, it seems to me that this patch:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20240825122617.37089=
82-1-dario.binacchi@amarulasolutions.com/
> > > has been considered correct.
> > >
> > > Thanks and regards,
> >
> > IMO we should avoid adding 0x to things...particularly for addresses.
> > Better to remove it when it has crept in.
>
> That we don't prefix with "0x" like humans generally expect is why
> people have been confused why partition 10 is in fact not 10-in-decimal
> but 0x10.

Yes, that's the one example which was in my head when reviewing this patch.

Regards,
Simon
