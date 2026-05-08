Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E61CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E5C84D5B;
	Fri,  8 May 2026 18:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dtyHu3fL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD2484D78; Fri,  8 May 2026 18:34:29 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05CB484D42
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bc47a96d3bbso298438166b.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778258065; cv=none;
 d=google.com; s=arc-20240605;
 b=AJ4dxvfmgCaXNXV4qsyGYGxsiDvcq1cJyyxYOFszrs9qv180HSONOkpydv63J/y95J
 HGATyefVLAx9ndj15fFXnHn/kuhieRdCN6oJ47FGbDTpmNCNSxbHz76o8Ebq78VzJTrB
 6LMn2vKpNd++DWspJRbTd7ZraAjFMWxIuJUEY+awXcnYyhaX7+1ofM+4JUqhvnND17NF
 Apf9iPWJOx2aP2kODLQ2AwSUmvUPDPp80KndmUUVTkTshuOgtxYUgHr3vTAAQaMKjM63
 leNAwG6Uq/7Ae+oiiQno48AqoORlFxfYCj7vYmy2tvfSXdbhXllZDkEcY06ZAWQDre1V
 /gVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L7K9YDIr9bh+thd9XIsCViNh5SPR8oYJh62CnSuGAbk=;
 fh=HyhfckoCvYt4+sPDg9hhBxEWaWW2hZbbNQ637EygBls=;
 b=OVqtVFtGbqOvrDX91YwDzpI1mT71nU+rKpzSkS/Udi6eRVyRHhHcUbqpsZNic+gvYZ
 J95a3sWntnIO4ikG/SigK2GpavhppZ9F7o4veP0HEcW/FaMIuUE5bnokV2V8ts+aH0aj
 OThq1GbOP7IMLVBogDPb3csuX2tkSGpwLYNxQmJoim33CClKrz4T3whgqv3ueyEzy2ls
 G3Qxhk8R45RbJ5hRyMSj/dzKLuIhOoH7ZKmc6F0KiF6YwDimvY3OHZzyWgbtlwueVXfC
 GLRFtgDniK0YA4TpkBWik1+SHCkpqi0gwgHDKf6vCwUpzcvKwIm7F5M/hMMOG+IleXwR
 MFkA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778258065; x=1778862865; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7K9YDIr9bh+thd9XIsCViNh5SPR8oYJh62CnSuGAbk=;
 b=dtyHu3fLULqJPExp7a8ANltUIY6FHmIByIezT/Fgiy3s8DIXLNPQ28p+faCSg0WT+S
 54g5pRFnKsREtsDERIggLXeUIp4t8IWEJ0Ei1T5bF9R05ZB/MlEr2cWUOZnzjqQ2kJPH
 mTPnE2c2mibXCdigrx4fAiw1PharbXsCk5xMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778258065; x=1778862865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L7K9YDIr9bh+thd9XIsCViNh5SPR8oYJh62CnSuGAbk=;
 b=TT+rQ1d7z/htQhFI2gmUc25r6p6IjYpbN9NIw4sfTbSnrjY3yC6bc9XAvpKou3679M
 7F/Q4OH5l2vZwhHSgE3iKjrmChYG4sh45SWo3dWCqp+VflkL15aJYS8G8Hprmkc55FP8
 h5ggQTwtCYhPrSoAcBGw23lBvJ9Tvbq714LRGYi5X2eFmaLXG6pP3QpRdy568netD4ty
 NGMLtErilbd+Ny5ZjNRl5HFMm5GbkC7wCr1fLZAfoCnA/T5PGEdg3fEcBAq96ZlnAAjV
 q5MeqGehsgMRv+ZavteIA0tzCDawkyJmlobaaVj+2woR0vV6Oy+aAbgZHvBbQuTCRTbO
 LO1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5rO5qa0ANRvd/vW6+e5Kfw9wUcXy0rMEkHuC1TrnpGzQv4fjuoMUErp4EhE/eT5C8X6zDEQc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzl8R6SVs+yFb0hdT+Qmlw2WtD8kdlVgG5erUqOsvI07JV2mmum
 8QOpKdBThudRv+hp0/dRR/GMrQWxC2YY28wjivBU3/Nd+HqPlgIhLVO27Ri77K1C8WOEhprDWne
 iYYk4vMNa1AqoeCwCcnoNpGpbY4l2b8TNbPbvAYZE
X-Gm-Gg: Acq92OHZE3h059RmEFCjdhGQfZwSuRJ8k2EO+Q61CVXtOYi66Yv9EqNVHzk2LZM0ZEw
 dTAx7zpw6voxxgICdRH8vC3ig2dS+1iwRazF2NLjSNJZVG2ZWsyUyiyvTwJ3hmUtUP8eh74I/NO
 lTPhSp+w8pWXSkzcGWdTQPEsdXLWUKq5xED/SWdvJS8UzFstcAJn0Zw6KsuR4AlJ6FQSq1mjQc+
 N9vmBf2zj2WWjXB/DzEvRgTURTT/xqPp6nhJAi1NEbxmpp1bMVSOkT50/VCu98gUgcIvIDcjpfo
 Vgqwie/X7BGWsTYm
X-Received: by 2002:a17:906:209a:b0:bc5:f94d:97ec with SMTP id
 a640c23a62f3a-bc5f94d99d0mr451393666b.45.1778258065278; Fri, 08 May 2026
 09:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-2-sergio.prado@e-labworks.com>
 <491f7007-0574-4fa5-897c-59002c7dcaf6@cherry.de>
 <CAFLszThW0u0SrntCfXFi083petNmszVmSjNgXFc87a38tHyx1Q@mail.gmail.com>
 <610b19bb-3282-4062-a3f5-3071c69dbedb@cherry.de>
 <CAFLszTgjvZnwsLBQicn4=g_wia3JP8EWs1H8o=pUe6L9kcC9JQ@mail.gmail.com>
 <CANu7NGspwLDTC=iVYse_TbEmJ8yLuGtVBnVB5_479d238qFaeg@mail.gmail.com>
In-Reply-To: <CANu7NGspwLDTC=iVYse_TbEmJ8yLuGtVBnVB5_479d238qFaeg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:34:11 -0600
X-Gm-Features: AVHnY4KaxTDZyI-OcLFavSfhuGf0FCfZTqlptaDxuEFEd3xRsotOienMhIISv1I
Message-ID: <CAFLszThkOu_LFSxYXjPyqPsyKN54D2stdJcpmKXgq7hn_7+QAQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: bintool: add extra_env parameter to run_cmd
To: Sergio Prado <sergio.prado@e-labworks.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 trini@konsulko.com, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de, xypron.glpk@gmx.de, 
 jerome.forissier@arm.com, afd@ti.com, Wojciech.Dubowik@mt.com
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

Hi Sergio,

On Thu, 7 May 2026 at 13:03, Sergio Prado <sergio.prado@e-labworks.com> wro=
te:
>
> Hi Simon,
>
> > My understanding of the justification for NOT passing the env argument
> > is that it is annoying to do that plumbing. But I would rather do that
> > plumbing. Perhaps not stated, but one of Binman's design goals is to
> > try to have callers pass in their requirements rather than relying on
> > state or sideways data (although there is plenty of that even so :-)
>
> I came up with a solution similar to FIT image signing. It is much simple=
r and does not require passing additional environment variables to binman (=
though it still requires defining a few environment variables when invoking=
 make, such as OPENSSL_CONF and SOFTHSM2_CONF, which I assume is what you r=
eferred to as =E2=80=9Csideways data=E2=80=9D).
>
> Please let me know if I should submit this new version as v4, or is the a=
pproach of passing environment variables to binman still under discussion.

Let's see what Quentin thinks about this...

>
> Thanks for reviewing.

Regards,
Simon
