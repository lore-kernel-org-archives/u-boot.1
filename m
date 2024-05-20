Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9AAC25B77
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 09:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0E488124;
	Mon, 20 May 2024 11:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d0mt+9FE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447528854F; Mon, 20 May 2024 11:52:38 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1208587E9B
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 11:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4820c2dd6d7so222561137.3
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716198755; x=1716803555; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40ckdM4XSTvRBjLl/jA6UiXZ3I+wLI0bSOPVyCYGmak=;
 b=d0mt+9FE5NHgBQgvRETqqSz3rwkobJ6iimolKWGCNZpqWFhfRTg+NVdNCOLMr80jcN
 n4DAPnmGBk/QMrWCe82Ps/NnLjgRj1hsgI6ba6WqEI2wa6myt9xrvjJTde/0g7mq7utl
 YbGeFvMYDB2r3/ksKZ93uhHgvQaLlZxdacGr0wCNEWLw50BsCN6WEKYQJiDIkPVTi8Yt
 8dZUFq0MBI1Fi/P54zXJiOyrRilCwjvOHdq44HCq4g+0qwzw+aiI53UB+FkSxwdxy8Qm
 Opvfsja25lfm+UUYYcpNyv9Mh/KtA+z8akeqgMeV5jZyyPzV6lPopzbngUSYYp26pXO4
 Uhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716198755; x=1716803555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40ckdM4XSTvRBjLl/jA6UiXZ3I+wLI0bSOPVyCYGmak=;
 b=hfeDRN8KSjcl2VEsAekHWzyKD4Kb92SWt4GyZOvj159tWc47CP/nfOJvz05YiNtyZY
 fXqf1m7cUjpiAuxnwjUpWPXfExEWVBGKIv8eKcKuFcapS4SZs+f6pV51vqRtFf7w8xb4
 OwTD+naP9q/8725G+pId6njVc1F3NlOF2prZVm1tC/QBwcYR53DcQBwFH9ukUiEx+kw9
 2Uy8yS1dB6T/QXrdOT4guk3nSzpz6DlUk0IPk6D9ovcsfmyThQWfGxHx38etTv9ZzWE2
 9DGdYr6n7UYaC4dz9ABELghFapMMEZLxRtCsUNiER2khMiP7gu8BLL4bUTDha6Vz1ns7
 5Bag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDBMFezmXKi1CFOM20pSa0WUm81h+aWOmAmV9bUyU1XJljx05rQKIpWP/lNM/UtQU8qOg9BnkKLk6YJw79GzYnrgHLIA==
X-Gm-Message-State: AOJu0Yzc7iIImLZt70grgt6Re7d+m1IYkzJihGAeGdXvJ5eDekm5MECu
 9MsW+XT7HgFPCnEqJKM+qf2M8Zwscjtsj3UW1z34/TdXhPxlufdoPDikYlZQ/KVUdcEx1TwqjCv
 tQXXY+OFdRir+K2IMHcpAUkVI25EgYrsM32wW1t8k8larEBFXD0Y=
X-Google-Smtp-Source: AGHT+IFCEATe/VTyFMrnMsXxmkNcwo79eHtGGGag8njCmMtKuB5AW2atQpIXEL5EYITdWrpuUG6meD7pLVgVHpF9XNE=
X-Received: by 2002:a05:6102:2ac1:b0:47b:d787:9ca6 with SMTP id
 ada2fe7eead31-48077de307emr29337336137.18.1716198753242; Mon, 20 May 2024
 02:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-11-1ea7d23f4a1d@flygoat.com>
 <05c8e427-0bb3-489f-915c-d6a7e743f63c@gmail.com>
 <56e0d09f-2499-4f04-9e52-8c122a40921a@app.fastmail.com>
 <20240519224745.GP2568172@bill-the-cat>
In-Reply-To: <20240519224745.GP2568172@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 20 May 2024 15:22:22 +0530
Message-ID: <CAFA6WYNkDrmPywfCdCMnbC-0JiAWAv+hT9-Zx7J_Ky_7Trmz5Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] MIPS: boston: Migrate to OF_UPSTREAM
To: Tom Rini <trini@konsulko.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, u-boot@lists.denx.de, 
 Michal Simek <michal.simek@amd.com>,
 "paulburton@kernel.org" <paulburton@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
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

On Mon, 20 May 2024 at 04:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, May 19, 2024 at 09:57:03PM +0100, Jiaxun Yang wrote:
> >
> >
> > =E5=9C=A82024=E5=B9=B45=E6=9C=8819=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=887:20=EF=BC=8CDaniel Schwierzeck=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> > >
> > Hi Daniel,
> >
> > Thanks for reviewing the series.
> > >
> > [...]
> > >
> > > should be 'select' because the switch to upstream DTS is permanent an=
d
> > > it does not make sense for the user to be able to deselect this optio=
n
> > >
> >
> > Do you want me to send another version or are you going to fix
> > it as you apply the patch?
>
> So, in the case of OF_UPTREAM, it's "imply OF_UPSTREAM" everywhere else
> and while there's a case to be made it should be select instead, that's
> probably a future clean-up for all users.

I think it depends on whether OF_UPSTREAM is enabled for a SoC (with
multiple board variants) or a single target board (I suppose that's
the case here). For the former case, "imply" would be preferred since
we can't enforce a policy at SoC level where new boards are coming up
which have to opt out of OF_UPSTREAM. For the latter case, "select"
would be preferred. However, I agree that it can be a future cleanup
patch.

-Sumit

>
> --
> Tom
