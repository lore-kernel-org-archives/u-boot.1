Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2D1C25B5C
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 10:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2576F8897F;
	Mon, 29 Apr 2024 12:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kcTHX07p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A7A8897E; Mon, 29 Apr 2024 12:36:38 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B6A880B5
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 12:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2b0fb1b6acfso424230a91.3
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714386995; x=1714991795; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ko80OFDnPPQYO5EDXIcBKer+RH/rHjE+ExbFv/2OT+g=;
 b=kcTHX07pE6XzWSdh23gErD1pzs3+cthh/vyDwst/diM+pnhPhForzsxOBLVKMty/06
 2lSXMZlsbyDeppTBAmLBkE2gruxztAQTNpbSMWhGnGmJcgUr07z6fXCZt950J0g/H3fi
 tlexLuFVRNEF3IzJajzSHB1xp7MfOXM8RFTYsisJVzWFtvB111n1k8yewQkdi67FQhtB
 KugpW0kbteBKXm0NdEjPYOnbujjEtKQ5kS6E/PplD0owXHJU+BtjykTbKwbKIgq2ANBj
 zvlD9lkt9fBv1ukbhLRr6O44HWUraKzs+G28jOmql+U/60FDEk5EowjhdXWOa6+qRVEd
 bxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714386995; x=1714991795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ko80OFDnPPQYO5EDXIcBKer+RH/rHjE+ExbFv/2OT+g=;
 b=tTk0niFV+IZbJS1+3Po6sBnFy72EJOFKOljlVe20vu00f4uheUiA2VHJmCEaDBSRg9
 rR7jKe4G4QjMqFz8n8iP6TT21iALkrY0NQ5PrkHtlVegzmTX4WnsuBIgkqcbj2ssQ2+U
 JQcJfB7mJfW0n9I+wOy0f7NcytnlWMS9+PnnqOeQ8G/uPkf17TB/q7hOANf3c4UEl45J
 x27uYAjJJwPbwve22rmFjqwe1NbtY/Rk1Q7cFy8hRTcLsEvZSQsXJLLisJAePESO0/GK
 zdtH+vLP3V5PjhYD6/x9g7iSPGBTGDA64HmCYqVDipwmqhVKa79XtKcfsqajTL6BH3/O
 WBUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj5U8eNkiBBQ+K64N+bEjBovpdPWF86fz+bDn66ly63DUH0dbPTA+nCmDpoKPWYf1OQ/05NoAAUsJ1NatuH28ZgyktUQ==
X-Gm-Message-State: AOJu0Yx3PLYZL+3Fd7F/Bl3oqPNeLF24CaRz9kjPb5W80LNWBGb/efKb
 qxBjKmrRBubieaVAsZCLkR3+CiwcHlv1lVr6xjJf5etATGr9Q4yEZFiCgS1ZvXfuIz3CP+5iKwl
 CE+8fiI/2R89ZSnqJBFWll2pE8kZtvw==
X-Google-Smtp-Source: AGHT+IF4/zkse32siyzmX8Q2HHBFLe6pknlFinSlHVBgSfU/SR867P4yGLhHNfRpZ62pcnPA5SNPIA8LHuRBOFzAdm0=
X-Received: by 2002:a17:90a:d081:b0:2ac:69b:886b with SMTP id
 k1-20020a17090ad08100b002ac069b886bmr9598681pju.1.1714386994836; Mon, 29 Apr
 2024 03:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240423155701.33657-1-francesco@dolcini.it>
In-Reply-To: <20240423155701.33657-1-francesco@dolcini.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Apr 2024 07:36:23 -0300
Message-ID: <CAOMZO5CE6YWz8nZ7_o6N1Mj3kaXVygk6bKAixZoZ17TY-ary_w@mail.gmail.com>
Subject: Re: [PATCH v1] board: toradex: colibri-imx(6ull|imx7): Fix missing
 fdt_fixup boot error
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
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

On Tue, Apr 23, 2024 at 12:57=E2=80=AFPM Francesco Dolcini <francesco@dolci=
ni.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> In commit 51aaaf5e7975 ("board: toradex: imx: Remove not needed env varia=
bles")
> the empty definition of fdt_fixup variable was removed, however this was
> still referenced from the boot command leading to boot failures:
>  ## Error: \"fdt_fixup\" not defined`
>
> Fix this by removing "run fdt_fixup" from the boot command and instead
> enable CONFIG_OF_ENV_SETUP in the defconfig that would achieve the same
> but in a more robust way (it works fine even if the variable is not
> defined).
>
> Fixes: 51aaaf5e7975 ("board: toradex: imx: Remove not needed env variable=
s")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thanks.
