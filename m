Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC66C47074
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 16:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398878781C;
	Sun,  7 Jan 2024 17:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="psil/e4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F239877FC; Sun,  7 Jan 2024 17:19:33 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B52B8781C
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 17:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e7ddd999bso1047267e87.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 08:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704644365; x=1705249165;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=60MfkMjLtlUoXZ/4Ob0gQEEszuQ9z8dJQMtrAFjSuDI=;
 b=psil/e4gziaNXayhWL2JpVt/a3Bqfab/i3ifw6tgEBC1D0Z4ZTkkRtZrldVQJuErnR
 CUWiMgHMEZlYil2uB62vr9gzEqb0xDBge9D8PFp/s87/NEPaG8UVigZVor3cwEDPg/Ci
 JAHmz3XIaeTWIb21EZ+45K6Sj8qK2imQ9uQzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704644365; x=1705249165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=60MfkMjLtlUoXZ/4Ob0gQEEszuQ9z8dJQMtrAFjSuDI=;
 b=L8vKfoQQGwVClrwAAay/jAOjFJrFPinBGGL0D9Vi26/o6gfMDIeGMrJMWwEx+jrnlA
 jo23npEDrio2GMhWj4jxHzbTZAfxwGB6oy3oTf8RWo9gEha05ilbL6dRUABAcvobAilm
 GIWjXdkmvZ7niKU9w9isn2c9+n9+gJSOigPvola7DXvDCIFBDB+Ns9Mo+cOf/ac21x58
 DnFsW9yG4FMEsmtqSd+Ry6agzLXwXACeT2n4PGBpef+oXdAkNXIiOJiiHhhfksfFxOtw
 MNj9mLs+LRjlXtarq5K8aN254lVTl2Z889enqsYbfEZlOIzSYlCVczI49Hr5l4OKV4G+
 hzlQ==
X-Gm-Message-State: AOJu0YyBYqm78LsE8//RyUjb9wVufgmWfAAWHTgcWvJD72XUmGxM3s/t
 l6WtVOExN0ePnJRjDUJ29mY4uwx1oPlK9XeVyb+XVS7QF8yyRg==
X-Google-Smtp-Source: AGHT+IH8U7Uo64mJpe8NoeDjcLWLH93NHf+uCc4NbuFQzwHz7jyhYk2tDOJ1K3cC6lcZw2jao9uHzQGmHWCCk9ooJdY=
X-Received: by 2002:a05:6512:3f25:b0:50e:398b:3946 with SMTP id
 y37-20020a0565123f2500b0050e398b3946mr1203015lfa.70.1704644365268; Sun, 07
 Jan 2024 08:19:25 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
 <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
 <CAOf5uwmDZ5DtAhe-GauhuyYwSSXQnavVNfzaJkdSG3TWE1N2FA@mail.gmail.com>
 <CAOMZO5DtCDe-VzY1yx2f+LTz0tCqmtiLemrH=xTnPQs7=07aSw@mail.gmail.com>
 <CAOf5uwn1LuN6uFQe9d7zXWDFnvOAqwb-etQow96fzAR0qim5Hg@mail.gmail.com>
 <CAOMZO5AqatVOGsJGwxXJCoF+tBemrfM8+pgrRCvDwHNHv1caFw@mail.gmail.com>
 <CAOf5uwmb0vJOwSj81KvfWpK6yobyz0Ozm5vDGCa9K0rZejbZLA@mail.gmail.com>
 <CAOMZO5Aa4ynpHqfqiAF6qAJmTJeAPQCmT4wyTz6H+UE3yX0jpg@mail.gmail.com>
In-Reply-To: <CAOMZO5Aa4ynpHqfqiAF6qAJmTJeAPQCmT4wyTz6H+UE3yX0jpg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 7 Jan 2024 17:19:12 +0100
Message-ID: <CAOf5uwmBdtUBQbgKncLBBV0XC06JqOOKmgOrwxbt=oSZ6mhqKQ@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Fabio Estevam <festevam@gmail.com>
Cc: Paul Liu <paul.liu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi

Il dom 7 gen 2024, 17:08 Fabio Estevam <festevam@gmail.com> ha scritto:

> Hi Michael,
>
> On Sat, Jan 6, 2024 at 5:49=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi
> >
> > Is this code correct?
> >
> >     if (tcp_seq_num >=3D initial_data_seq_num &&
> >                     store_block(pkt, tcp_seq_num - initial_data_seq_num=
,
> >                                 len) !=3D 0) {
> >                         wget_fail("wget: store error\n",
> >                                   tcp_seq_num, tcp_ack_num, action);
> >                         return;
> >                 }
> >
> > Can not be seq_num wrap around? Another point seems that is not
> > guarantee packet reassembly
>
> If you submit a patch, I will be glad to test it.
>
> Cheers
>

I have already wrote something but I can not test. Will send tonight. My
feeling is that sometime the initial sequence number of TCP ip is next to
wrap around but not sure.

Michael

>
