Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB279CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 12:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE1BA831BB;
	Fri,  5 Sep 2025 14:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zzz7Iq3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640FE83678; Fri,  5 Sep 2025 14:27:23 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD17D830E4
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 14:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id B8BDCC8F1F9;
 Fri,  5 Sep 2025 12:27:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D868D6060B;
 Fri,  5 Sep 2025 12:27:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8C1EF102F1BCE; 
 Fri,  5 Sep 2025 14:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757075239; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2jxisyfLafc5UT5iJgkI2g26/qXhdtkJat3XnxkfEVg=;
 b=zzz7Iq3tc9fltGoGIG5gF04MlFiLHxRNq9RfKGOc/BwSdKRaSTXxHE2QEO12NTfU+3Jj4+
 HTfcfu0x1D9BOiwYfPJt2VPli/0H9XkR0wQqLMVHQTVj8f1pAaDNQr0isuwCJDgsRc2ykT
 Ozk1kf8wjH3Pk7Amvztm1uMZcEY60xuJp/rGAm0RGW39SOrJ28Gv924qY683mDf1Ik0vjc
 I44sWpJTC7FuESpRYs1425lAFTeRmnxzWOoGgdntMqUiJyezor3sgIE1K3EMZ7pi9BLXkJ
 gFNo33xF1IzleMPxtJiIXZJ4cUOWSbp46Na4d9+eDkryFGNjGLb2EmU3JDwy2w==
Date: Fri, 5 Sep 2025 14:27:06 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v1] board: ti: am33xx: Fix serial_getc comparision in
 spl_start_uboot()
Message-ID: <20250905142706.2b0256b4@kmaincent-XPS-13-7390>
In-Reply-To: <CAJE-K+AYm6nbbSCkNm23KoPHPVvRNGjwzjWSOnEMJw5q6hO92Q@mail.gmail.com>
References: <20250905104534.382508-1-sidharthseela@gmail.com>
 <20250905132510.500d5777@kmaincent-XPS-13-7390>
 <CAJE-K+AYm6nbbSCkNm23KoPHPVvRNGjwzjWSOnEMJw5q6hO92Q@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 5 Sep 2025 17:00:21 +0530
Sidharth Seela <sidharthseela@gmail.com> wrote:

> On Fri, Sep 5, 2025 at 4:55=E2=80=AFPM Kory Maincent <kory.maincent@bootl=
in.com>
> wrote:
> >
> > This seems weird. =3D=3D precede in terms of priority to &&, therefore =
the
> > parentheses should not be needed here.
> > =20
> is the issue maybe left to right interpretation of code?

Indeed inverting the condition will change the behavior, but is it really t=
he
issue here.
With the current condition test, serial_tstc() is called then if it return
something not null, serial_getc() will read one character and compare it to
'c'.

According to documentation:
serial_tstc() - Test if data is available on currently selected serial port
serial_getc() - Read character from currently selected serial port

I think the current order is correct, we should test available data before
reading it.
Your issue may be somewhere else.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
