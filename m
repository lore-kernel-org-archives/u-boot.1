Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AB3C8303C
	for <u-boot@archiver.kernel.org>; Sat,  5 Jul 2025 10:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E8A82063;
	Sat,  5 Jul 2025 12:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T9yDRgkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0158206E; Sat,  5 Jul 2025 12:02:11 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B598381D5D
 for <u-boot@lists.denx.de>; Sat,  5 Jul 2025 12:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-311a6236effso1286954a91.2
 for <u-boot@lists.denx.de>; Sat, 05 Jul 2025 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1751709728; x=1752314528;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/REjAzNcj37hWP9CIzVA0Ba1mexsJ/Jlm647mFWgB8M=;
 b=T9yDRgkVUEERB4pLX7Ajkg19V75YP1K3JOc7Y/UZvm7xwFljHFWqq8kGnpKYgp8z5o
 AWEeMVP0WdiwuO3vCHGRnrWzqcOB94puF2gmFbWap/YGxJC0pVn2f9V5Yrnyfg3mA7eo
 Umzx2JApzgNq9uuyFePlsCk/LbKDhK4OO3LQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751709728; x=1752314528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/REjAzNcj37hWP9CIzVA0Ba1mexsJ/Jlm647mFWgB8M=;
 b=NBE7W2qfREE5OKz/iQ2MVCZyxCV0QYfJU+4x81rk0BQeiKWtE+wX9+sVdxsJg8cUrT
 JRM6JMCt483Z055q994YvnPAoJAZdjiSshdNmWn2k057H/EPH96nx6VGHq85U+UFL0yw
 ro9qOWsel+xqmRVvzpm1TsOv0wetj8UHIzxCFItTnIEiOBUiNydGQI6X8dsNcLBmmwwA
 DLj0YlwK513I3EZfebjBSOf+priOhLHftopbO0wsWfnYyWkC0uflTlbIkoJ4UnJNDrsR
 RRVBIDzqjF+ZmC7Emy+UeIw0otw87Ixu5NQkoLGCKzBrfHZLxeWoSs47vy3I3P5o0Czc
 UkVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhsC8WNeK+78W9pxb0xdOO9zpa5wNHjOVVg4F3lL7ITt44wha5cYHkwMGKpY4NFokTTGxA4co=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2lXQu9Xqfr0Q8Q7XtJcAunyox2/Hg4iaKSVi5VBbCLH6bNQfG
 9THm7yDslpBkJIf3MCeCfODSFojRW3RvheJG8BPBa4ienFdmV1TmGbGn2sPA4Q/ryWBQlUkDLNB
 EcYVNHK32SwuZuZokfR65NO/EKqVI8pfAN/2DUhe+pQ==
X-Gm-Gg: ASbGncurCP49La2KYgKy682b605BNlFzAUeK9pZmhwSj6xrDqmSiDKeo3Xww8y46tjP
 4XDefYMC08fZyES46/G3wxP8x2TpnAQgkJnD20QVtNwdKksOzmJHrXu91IHQnc0FTCKnw0gDx9K
 YF6aSBL3ArDnfsBiMKMRPhWd6wZi3/yzok6qWc6sjzoA==
X-Google-Smtp-Source: AGHT+IHwIYkyQnBv0EiPpowqE/TjDrsNMAToGN9W4CHAPw1uzeU5H4/b6e6qRB2XDfjYdy7s95L6oddnHCfLKPPvmZw=
X-Received: by 2002:a17:90b:3804:b0:312:da0d:3d85 with SMTP id
 98e67ed59e1d1-31aac438684mr7932357a91.6.1751709728204; Sat, 05 Jul 2025
 03:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <CAOMZO5Dhs2GRgvjDCBbwsxxZadsVCrpXaWm4qToYfpak+CAKuw@mail.gmail.com>
 <CAOMZO5Bjxx5tjj75Bo8A4WJWBnV3Q8h1UHK45_xZgOavig0C9w@mail.gmail.com>
 <0b7fcdb0-0d18-41ef-8607-cf060ce3d058@linaro.org>
 <CAOf5uwniX09rvpChMVrFWVG-X5S52aK_ZjnpS8EAN24=r1youA@mail.gmail.com>
 <CAOMZO5B-4qUypOyVEiZt6V_4S35G4m6WATmdXqKnFCwsQJxF9A@mail.gmail.com>
In-Reply-To: <CAOMZO5B-4qUypOyVEiZt6V_4S35G4m6WATmdXqKnFCwsQJxF9A@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 5 Jul 2025 12:01:56 +0200
X-Gm-Features: Ac12FXzma_YB1Oofm7ERes9AD35nyL38nos5ZZrRg6RVdc04Vxm7YkHjfDlnxFI
Message-ID: <CAOf5uwntwHoVEg=DUXSkDzL3az4_wun0YyASAQV6p5UFFtB6aA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Static initcalls
To: Fabio Estevam <festevam@gmail.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Otavio Salvador <otavio@ossystems.com.br>, dl-uboot-imx <uboot-imx@nxp.com>
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

On Fri, Jul 4, 2025 at 3:33=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Michael,
>
> On Fri, Jul 4, 2025 at 5:37=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > We have problems that our board crashes with display enabled when this
> > series is applied but we can boot
> > if the series is reverted. We are still try to understand what is going=
 on
>
> What is the defconfig you are using?
>

If everything working on your side, I will check the code that is
added to our board.

> Does the crash happen in the SPL or U-Boot?

u-boot clock subsystem consistently. Change a bit the code allow us to
boot (ex add some more printing)

Michael

>
> Please share the logs and more details.



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
