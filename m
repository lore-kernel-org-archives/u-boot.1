Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EA3C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 12:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0615680EEF;
	Tue, 25 Mar 2025 13:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e3cB4MLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C0781026; Tue, 25 Mar 2025 13:37:24 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C3E808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 13:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30332dfc821so4090363a91.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742906240; x=1743511040; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5C9l/ZcF1zUfz/ikHinsvbNrkFxUV0h1Kx3NxZv33Gk=;
 b=e3cB4MLAbtJfUvXSGzXHrn2FPq81DWlGIJn0rOwN9Z1U/F8/eDbHx6akRle/ofv0ux
 MmHfUQLJSPJ3rHS5xDOI6Cb3M9JbRM+2v82gowC4+xwft+9cLBW1i1MQLKoXjZRLQj6A
 XV7OchR2gMj9CGQLkrYecgNl1eFrVCAh8BfPCoJyLR8CyOIZuRiyd4se2rpIv6AqvMOM
 m1LUG4r1bBGvt4E6gcJ4qilUsXbXcY+sKo768Fx85mdivtivE/bSZoDQ9HFYcXZKhQbk
 mfcuXzql80amOHbUdn9N7HNQ2+xczF6L3eh94+8Lz4OcUS97xN5BLPZXhSbmxYLXCEk+
 W8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742906240; x=1743511040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5C9l/ZcF1zUfz/ikHinsvbNrkFxUV0h1Kx3NxZv33Gk=;
 b=vu5jqyX4cNYmo9+0HM/isYpyhHDwwZzwVWr5lSIXfO6xGrN9Pfy2xGGTnrDu6N9lk9
 vjQYCMk8TFGj/hFaVlbZYN5mA8NNR33Hwh1IoXG4kJsdaglbQ3XCuWm9xRLKBWj4z1nO
 doFfwZz+d3jczBfLIzY6BhWRu73EEtMF0G4OcN+vjnl9svYBn5JgjHOHk4qpu1EhXKiz
 0ETeoy1lfQmWhNOeMcZnBxal6zYkOo9QlxrW5FQ+R1jWagGeq+AYVcY5bN+dXX/Ccaro
 EKGlaDZZ60Zz39BzVNmmEfUHhmb/lFCGg9MvIaNqYld6VgAKBewtW5mZIKwCc35Fgm4S
 E6jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRBe+7coI8+A7T58azfux1S2IVkTC5SKNZsJ9I9zRPEvVkqMnTNtmJFreW0b40nSJkF0kxous=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0HC1yyXjdOuAC+MNULnzfbjkoWTo68SIpHjoZN/a6wvsRTI6Q
 dwx31Sr+2rdHkfIAtg/nwD1oINTqrU2j9csCXRHSGXzboBVKz7p1g0qoN7oeyQw4jF0WyNxwQHd
 U+Z0otHnZ8DE2zace99cc1kNgiWQ=
X-Gm-Gg: ASbGncuG+tvoTxOLCvfG5wucJQlWM3hqJBTWGeuxXCDleev7VpEXf2VWfCiGvOjEDx3
 CrAMRiYC3eF8uJVIpW7ysVouYVdUYuAUahZk8g3axjChT9ihPk14P6FEl4na4QyllypVNBi5CgW
 iIFNzG88HIDRGmamPa+XPSHrWzwg==
X-Google-Smtp-Source: AGHT+IEJ6TuovB7+Rv9W41PZJb/JkIvPEdkp5UGEiPrVLHh6I/mg/d9883Au36eibCDsVwO1Xac4UV4A0wCUMj8oO8Q=
X-Received: by 2002:a17:90b:3e87:b0:2ee:f677:aa14 with SMTP id
 98e67ed59e1d1-3030fea69f2mr25011623a91.13.1742906240274; Tue, 25 Mar 2025
 05:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250325025452.950303-1-aford173@gmail.com>
 <20250325025452.950303-5-aford173@gmail.com>
 <6f58a557-d5b4-4bc7-87b0-6ed626ec534a@mailbox.org>
 <CAOMZO5CT0uevQaPWPAHM0qVULy+f6rsbwE72Kkph48ghpOSKkQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CT0uevQaPWPAHM0qVULy+f6rsbwE72Kkph48ghpOSKkQ@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 25 Mar 2025 07:37:08 -0500
X-Gm-Features: AQ5f1JpwD0mcDp6I5CdvSCiVy8e_lzfjXo5LGZSnc-uu_-BSDq2rroIxO5q7HYw
Message-ID: <CAHCN7xJoJYmZCG7e+zv3cJc8B460kqWpz8v-KibsVsHJzbpjUA@mail.gmail.com>
Subject: Re: [PATCH V4 4/7] cpu: imx8_cpu: Print Speed grade if IMX_TMU.
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 aford@beaconembedded.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, 
 Enrico Leto <enrico.leto@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, Gilles Talis <gilles.talis@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Tue, Mar 25, 2025 at 6:36=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Tue, Mar 25, 2025 at 12:37=E2=80=AFAM Marek Vasut <marek.vasut@mailbox=
.org> wrote:
>
> > Please drop the fullstop at the end of Subject and then add
> >
> > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >
> > To the whole series.
>
> Adam, no need to resend. I will take care of it, thanks.

Sorry about that...again.  Thanks.

Once this is complete, I'll have a smaller patch series which shrinks
my 8MP SPL code by around 4k by #ifdef'ing out dead code.  Hopefully
it's not too cluttered, but that smaller series depends on both the
UART clock and the CPU_IMX updates.

adam
