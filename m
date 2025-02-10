Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A581FC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 22:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6856E80821;
	Mon, 10 Feb 2025 23:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ESGM0dkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF8D80548; Mon, 10 Feb 2025 22:04:38 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC1D1803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 22:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e573136107bso4186546276.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 13:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739221475; x=1739826275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jC6TJzIaRqD4wDYEWfyzKgToOeoXSz8q5bVbSIfm2zE=;
 b=ESGM0dkRRgw53WTGlcz9hY+AyKrbI4x5PztVygU83adJ4R+gtWT7ay1ppoBYUEEIiE
 MFfShJ3u6JaUc+Q6JrGWyQf9ruX3eNRzQBUMiVSCoGeo2VN70TQn8ii9vIazlIxaInec
 JyJB6uDU9h1ES9kHjIaUW+drVpAhYTI99pc0aRN6vqABh7GTa1TaH/efKxw5vcGsosZm
 K563pDtym4U1037dRZhB2D8H9M5o3zaWEEfudzivrdqJFVT/xCnF+KsBMI2KxxsWqJOh
 BR8aBlNU789AnVWHMHVU2lCfseSUqXsjIMjUiX0QFlXBwyAMkN23vwrISP5DFlGNHp8l
 PFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739221475; x=1739826275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jC6TJzIaRqD4wDYEWfyzKgToOeoXSz8q5bVbSIfm2zE=;
 b=fpYKr6Bj3+z/XvoPfnE/kYxWfC+NoOpkwGjGTiiPBz7GgingWz5fldkLt9W7RINrRp
 aiTYv7nHdDUimSVxMhk4Meyrr7lWaJbb4SN+xc3M52gS0WE9i6uKU1Q1ucq/7PJVeKTb
 usdm3M8JeZuLCioknwQG00oSuecSAyTvdNtg7JcsBPr5o6lrPhqPwLT3MXbXUmSf46Ro
 WHh95bn32JohkE2b27iY/FC/+Uvnb7AGXGHVNYf8XZABd31FTiIh0RFpwojgWVxVP6+1
 /qU8R2ghfB5BxSAQlMZgJLVNkqEMtp4BMaL+JVY0IacOr6ckNlk4Rb2nDjAa/v8+AG4y
 BNPg==
X-Gm-Message-State: AOJu0Yxe596KSqAF/9SSjl3um8CKgkrbHRk/gtAovh3IdyKAVgip6/lM
 oV6VqGhEsJRkUaR4ovti3stbYzntMsQNPxcH9l/udvvw6TRviVOcArF+7kmAK/kix7eX17+nDjL
 Cuztb5JVWZ0QJgmIF1dHm2/Mk7Nrmj5ToeAX6Wg==
X-Gm-Gg: ASbGncvo6RMAY10U5ReJzu/XsjuXwz0zRc3zhH++5ume9qu+W6mbCH94D4e2UV+ZYST
 AcZyV7ILTRv7LSb8LJyA8KWvdqbglHc77P9ukIs6aXKniY1teyVIpbpL3gfEJFgTWMfR6Rg==
X-Google-Smtp-Source: AGHT+IE7YsqwRKrIiNvVxqF9UxPOV13x5ZN47mWs/LdPuOBpxdtIh7jZO8Gv3tj5zFnQgyeQl1JXNXKaT7xk9TkdpNo=
X-Received: by 2002:a05:6902:849:b0:e58:31ce:a9f with SMTP id
 3f1490d57ef6-e5b461e31dfmr13239963276.26.1739221474673; Mon, 10 Feb 2025
 13:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <173921993557.2921783.3890127949068603825.b4-ty@konsulko.com>
In-Reply-To: <173921993557.2921783.3890127949068603825.b4-ty@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Feb 2025 21:03:58 +0000
X-Gm-Features: AWEUYZmQzdADRYA-9O6O0uazFjqhaafMJIflQWgC0CI1Q3xfk-mlopY_DfjFbtw
Message-ID: <CAC_iWjJ-Ue13-WP6LqAH7dh9Wcc-76siM_0hgsZ3WaRQvzfH8w@mail.gmail.com>
Subject: Re: (subset) [PATCH 0/8] Reverts and fixes for board failures
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Lukasz Majewski <lukma@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Sean Anderson <seanga2@gmail.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Stefan Roese <sr@denx.de>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 10 Feb 2025 23:29:01 +0100
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

On Mon, 10 Feb 2025 at 20:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, 01 Dec 2024 07:42:28 -0700, Simon Glass wrote:
>
> > This series collects together a set of reverts and fixes to get most of
> > the boards in the sjg lab running again.
> >
> > Unfortunately three of them have developed a failure which requires more
> > diagnosis, as it may just be a hardware failure.
> >
> > For coral, the TPM tests fail, but the board is working, so this can be
> > dealt with separately.

Which TPM tests fail? Can you point me to them? Any idea if they are
related to drivers or the APIs?

Thanks
/Ilias
> >
> > [...]
>
> Applied to u-boot/master, thanks!
>
> --
> Tom
>
>
