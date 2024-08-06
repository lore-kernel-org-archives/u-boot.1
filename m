Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C497C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 07:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF1D889C9;
	Tue,  6 Aug 2024 09:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="I3K4n6r7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0270C889CD; Tue,  6 Aug 2024 09:14:06 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1C9587DB6
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 09:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7aa4ca9d72so23429466b.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1722928441; x=1723533241;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Z3IHuGj7IROQoo6Pidr2KaCYD82oNLOnVx6DKMJAb8=;
 b=I3K4n6r7ZeHQizEri+jssG5eF2Mdaun77WKEKGRF5GQfP1jjgLaSdus6pV4euZwUw/
 1uhNP0lunCvTz6YjxbmJbmRTSEFn1mZMpPhlLZQtaKsbXf+pb5QZ1QBXuxMbGiaHcUIE
 lrQ3NoAEZZbDkISr1cTwE/SctX0afcG3Bk8Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722928441; x=1723533241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Z3IHuGj7IROQoo6Pidr2KaCYD82oNLOnVx6DKMJAb8=;
 b=arYffaAb0yOJBAzg7qddnTum6T2Bj0iKD+r7Huarc7LMvT62IjzxAa0i6LhSSo/MCB
 EEVo61/yWORXxWW768ZiTl0jP4oDSISGx3mAg2tsjDFxHskrAuCQFkc/SukMyIhneK/z
 JZxj0Q9reE3RDM/bogrotQZzsEHxsJ4LUas4yJVVUq83O2rNzrULLPUWHm+hwgqJF49Q
 ENzAI31Qs9R3L6/ebNPiHyBkDsUNag7h5ID5+0RGS5PO+aljPjV9YSOcC1FzfFHZ7H5T
 gDlvbKuMTWR7ceYfNWMjEmgjqcphTWXQLCPSEKe0s+nfpma7hMnAF6PYl92jidebXuMk
 0BAw==
X-Gm-Message-State: AOJu0Yy3iAQfzGnu+uAiYw/OmUQDAVpPSXnbyjVbNPSIRx4vsqLQPVt8
 N7xiFLTetHrHg94yTki1JVcQjs900jtM50QqEt1aopt7ytGQzn6T5Agyl3vUX+iJTMPFHtpnXzo
 BXlpJlHwJO0WCuReWofEHMH2PmlaWwybjLy589w==
X-Google-Smtp-Source: AGHT+IE0buOUAlp8RWUph0RbuLW7suyG4GdS85bSP7n0zPrtJppHBzJIruY2AgiQlN2RJyK6PAtxCpNSN++A4z4EXZY=
X-Received: by 2002:a17:906:d25a:b0:a7a:8586:d36b with SMTP id
 a640c23a62f3a-a7dc4da6f9fmr1010032766b.3.1722928441416; Tue, 06 Aug 2024
 00:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240805173140.84453-1-michael@amarulasolutions.com>
 <40ec5639-fcc8-0e4f-a592-afadce34ad6f@denx.de>
In-Reply-To: <40ec5639-fcc8-0e4f-a592-afadce34ad6f@denx.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 6 Aug 2024 09:13:50 +0200
Message-ID: <CAOf5uwmohRnQ1hHKR1w8p1NVLsRi_TwZALdbWJpWFs2mwmR30A@mail.gmail.com>
Subject: Re: [RFC PATCH] ubifs: Call ubifs_iput when ubifs_iget is used
To: hs@denx.de
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Heiko

On Tue, Aug 6, 2024 at 6:29=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> Hello Michael,
>
> On 05.08.24 19:31, Michael Trimarchi wrote:
> > The inode should be freed after a reference is get to avoid
> > memory leak
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >   fs/ubifs/ubifs.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
>
> As discussed, that patch looks valid to me!
>
> It would be good to have some testers...
>
> Looking through the code, I think there is one more place:
>
> $ git diff
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index d8d78a2d3d..a5d141055c 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -2322,6 +2322,7 @@ static int ubifs_fill_super(struct super_block *sb,=
 void *data, int silent)
>          }
>   #else
>          sb->s_root =3D NULL;
> +       ubifs_iput(inode);
>   #endif
>

Right, I think that people are reporting now those problem can try to
give a quick try on it

Michael

>          mutex_unlock(&c->umount_mutex);
> $
>
> What do you mean?
>
> bye,
> Heiko
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de



--
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
