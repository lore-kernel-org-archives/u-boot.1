Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2695C6FD1F
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 17:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC7987DBB;
	Sun, 24 Mar 2024 18:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LULknE21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2FC87DBB; Sun, 24 Mar 2024 18:55:51 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBC1879E0
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 18:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29f8ae4eae5so755983a91.0
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 10:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711302948; x=1711907748; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KiRxJRhFi0jklFG/7GBu7RQMlo+yTy7WeYmvoqlGlto=;
 b=LULknE219eFRBYbjXN7N3A79Tmt+g+lbCRMTn7Y/59//C9dqBaTqmrmf2vi9VIVbUQ
 c6OMvqH7y8Fb3ndcI62J2WQjillci0Dii3rct/pDimXq521DljMkXbPYVi7YmmoEL96a
 3Evz4ttjlYnZCCTWTfOqmegiK9ElpwjDy63K/oLLY5r4Rafngrne40LODCnk7u0aNYgu
 nDd0XI8dHO1mKnj9ElZCAdaA7W7YjmdlhGFo6hECLQEKbHJTFt2C6dF7Tj226JUePMKL
 3sahdqCd1HIvv1CCwTmtRPzpv2GWxNjPp9M4pHX33IuU1DxDrpHd5sgb2wKo26CSmame
 iP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711302948; x=1711907748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KiRxJRhFi0jklFG/7GBu7RQMlo+yTy7WeYmvoqlGlto=;
 b=J/CWOTuxjrqKrr+4XwaAzLWbRITjXS9lBrY51py11wWcCEguQLVAhrdpPDjD4Bokbv
 iJitfPka4C/U0qHIOe1X1NBjUqwrxwQPid2DQU7gDh1cBC9K6DPh1Yv7bFqoM2mEBrFF
 NHWfeXbAvPZHgVF3Osdz3N2OQqmmi/CP7lesJuXzRnQtShTHaRUsiTnGdWUwMA4JtO1B
 PuSa+zKG8/aQ1YT0S2rT0J8sLTaLWdHFiX+hRaIZqVtglPpAea9sRSUcvo3u1BeCtLoa
 QFrSIQPomUQNez6o5KTJNbeZA+281ipbRuXwkBuFsILceku6eaLyshEPvfGQU4H2weKT
 sauw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQBqY+tmCbEMNKRKa0LEZ8xwm0NvJ+c4KmEZQUYpI5MARr3ghrjpVQl/mkCq9NDjeh/7S4fk50Kklx4Di6H07RTbEnEQ==
X-Gm-Message-State: AOJu0YylTR+q292Lbs8pnljrGc1xba3Ca1eGgbIx8FsI0BXrRQTkczRx
 aihGL4X1wsvAfEfzIRdKgadIvxN8qIJOlxdZliWXw+bJBAhDls2+9ZQNkqePhVbkdZ9PCvWk1+G
 08nTTUg98r+PiDgp+bwZamLpKGwSgOE9a
X-Google-Smtp-Source: AGHT+IE9zsk7HYsAdvvXjPqPNOfSXN4gMVRRAUttfCdG2UR/KI2CMiovr7Xe7WLdMe3pdVM5+F2ybYvdzbfJ+1ZYTP8=
X-Received: by 2002:a05:6a21:789e:b0:1a3:bd72:b8de with SMTP id
 bf30-20020a056a21789e00b001a3bd72b8demr4873643pzc.3.1711302947798; Sun, 24
 Mar 2024 10:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240321144541.15314-1-othacehe@gnu.org>
 <20240321144541.15314-2-othacehe@gnu.org>
 <7b72bd8d-653e-4bba-9d62-26a60d85792a@denx.de>
In-Reply-To: <7b72bd8d-653e-4bba-9d62-26a60d85792a@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 24 Mar 2024 14:55:36 -0300
Message-ID: <CAOMZO5BQvz2ZbjYb2_ZrvNg42YQ+-59iGKndhqHX11osnhcYTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm: dts: imx93-phyboard-segin: Add USB support
To: Marek Vasut <marex@denx.de>
Cc: Mathieu Othacehe <othacehe@gnu.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
 Yannic Moog <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, u-boot@lists.denx.de
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

On Thu, Mar 21, 2024 at 4:17=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 3/21/24 3:45 PM, Mathieu Othacehe wrote:
> > Enable both usbotg1 and usbotg2 ports. Disable over-current as OC pins =
are
> > not connected to the SoC.
> >
> > This
>
> "This addition to ...-u-boot.dtsi is temporary, ..." would be clearer.

I fixed as Marek's suggestion and applied it to u-boot-imx/next, thanks.
