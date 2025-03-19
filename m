Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB421C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 16:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2014B81D0B;
	Wed, 19 Mar 2025 17:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ExBHSYrr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D9081D5A; Wed, 19 Mar 2025 17:52:42 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 748EF81A04
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 17:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso2336139a91.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742403159; x=1743007959; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqJaM7lsxu950plAsciuqz20rstKjFXtiUfLflT3tO0=;
 b=ExBHSYrrVLAOJG+h9p2wSILtqYGVCYWLVFBmeKPy13hV9JkGFgAy18VWkAN9pc1dTQ
 fijqeeLGQF3F18irpV3QnZacaCrmkEW6aEUz8a+eiZxiNArzRy19msnWZI6SR+KzYkPi
 dJNfcbZci62k5/1bNTSi7aYs5BZ1aeTSGujaXYNXdj95b1u4iTobWI1FHHJWWjMXJL6I
 +GNDFlaJS6owI/+ZevRIEc55VAxgSlFb2XcEJqYEvftxmzU698d//8lrCuJZXW8HMK5R
 6xjAcFUfCKM78dg5xWX9coLsksBklPwIBp4/5uUD7FUjeYjBNJF+Wp3g09QCj47SaP0x
 ehWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742403159; x=1743007959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqJaM7lsxu950plAsciuqz20rstKjFXtiUfLflT3tO0=;
 b=CNvWIhtVf5D828S5NF4TAcaq9VqBMJEeguq9pSr0n/8t5vfZcx6iJhZl5ri+V4fv69
 WnXC2rSx8C8f6kqI01C2eVBipBX1Z64rTjaMrnsYC45rHWB9qaUnxElJLjuF1RkgWOHF
 VwKUtqIvCf79SxxLPnj/G2jC0/DWHonnuzVU611GSL0JAzJlksXsXvOVtIebFreurhWD
 jA8KfCpX7+txLIq18dmVkjugwT+GN4VMkElD/ZQgGulRBne5Ttv0KmH5g/dTQY+1Y7u5
 CmFu7ZDjeCaA04rBU4V2tCQBf57BwhMUoQ0VsgW3pd941nwOdp/pq1db0q+jiwG26boh
 l17A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmsmXvNRsTF/1JdU2PhwVOJvVKQmCIyLQVIMt20zCJSasEm2vQ2IDDljpq1wxQoSNoPhltpvA=@lists.denx.de
X-Gm-Message-State: AOJu0YyF7s6tU2nNLTOjLVJKJbE17OdNsMfhY9Qtp06aEn3Cy1zrOwCp
 x9u2A07HV9WgtysY2UauLYN0rup2TruDjAIDXgHWZ4fRokFCcDZ+YVZegyOdh3WhVBk9NW4ReQ1
 YbHchyjaOCOxME1hvRV8xT5AQlNA=
X-Gm-Gg: ASbGncvn3QLyGWIF5qh2izhhUZXwjUkM3b+v0wi0E94/i+pEPXxTl8Q87kGRTVTKWA7
 VZ3oO3urp/PztRvnLeeX+41+Hu1jMtEotzNYebmJuuwUg80G3zL7fNVP8iHVCGK5WDOeRX6o+5y
 31pMG2/VDLNXQoVRW0A25WXWCNbw==
X-Google-Smtp-Source: AGHT+IETo2K7gCLJ/tSho3YIltHDREVV67QZ6KhULDvQxgMPdCz5c83iBhxJA0PM+QSuNM4djmM5tBraRGEkhACySJk=
X-Received: by 2002:a17:90b:52c5:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-301d42e0018mr333872a91.5.1742403158891; Wed, 19 Mar 2025
 09:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250319031852.233537-1-marex@denx.de>
 <e09f009d-4a00-45a7-9a33-dba22da6ca4b@denx.de>
 <132-67daad80-19-611b1e80@141681007>
In-Reply-To: <132-67daad80-19-611b1e80@141681007>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 19 Mar 2025 11:52:27 -0500
X-Gm-Features: AQ5f1JqrmOw1kgzLZlyclxm1qZLix3TsnmHw-OKu09_vp5nuLEKx7v9Coskk890
Message-ID: <CAHCN7x+St2V27aox5hxOUbEaLnEUWTBuOybKeybpNmawC=44Nw@mail.gmail.com>
Subject: Re: [PATCH 00/24] clk: Add clk_resolve_parent_clk() and fix up iMX
 clock drivers
To: Fabio Estevam <festevam@denx.de>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, 
 uboot-imx@nxp.com, Fabio Estevam <festevam@gmail.com>
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

On Wed, Mar 19, 2025 at 6:42=E2=80=AFAM Fabio Estevam <festevam@denx.de> wr=
ote:
>
> On Wednesday, March 19, 2025 00:23 -03, Marek Vasut <marex@denx.de> wrote=
:
>
> > Sigh, get maintainers missed Fabio, sorry, +CCed now.

I noticed that Fabio was being left off too when I sent some stuff.

adam
> >
> > Fabio, do you want me to resend this with you on CC?
>
> No need to resend.  I can get it via patchwork.
>
