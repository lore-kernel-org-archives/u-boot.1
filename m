Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E911CC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 20:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DE8988239;
	Thu, 25 Apr 2024 22:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D0A5Ckhw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0575088235; Thu, 25 Apr 2024 22:39:22 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62D288239
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 22:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e825c6c10fso709955ad.3
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714077558; x=1714682358; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cMSx1UXg2cBYzASb8OPEvsBZMXOFl0nZ9MszSXx6Hw=;
 b=D0A5CkhwTtaOxfVjVFXG0o5fpSuGPz2Iz1Cd2/LAeO1rT9hNs0P3ylkyaI1Dx1dW2o
 989qot4zYZabypoLIiTYWsh6lyEaVdlXxURS8/9l0fapMr9aK+IoBgrqI4Ie8wVcoXSm
 a/SVuAZRn8Y/cisj8l+LseveIvUbD7H62Ohg76+i8eJvoLPYi2tNIHsaf4a6U8/nz07n
 8lp3jqZCRIA3GT1kUytsBeHC5DOqwTFvf6mqsOXAoUe+SzldesMX7+GBxxbz/97f9yMg
 +2imjw+RqOw2JKojbfyGarNuAjlQJ/jexguSTqiCnmOZo00ljzN+gM3ZwNViPYP1F3rc
 VLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714077558; x=1714682358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4cMSx1UXg2cBYzASb8OPEvsBZMXOFl0nZ9MszSXx6Hw=;
 b=RBpVmUJfBErdWK01GUkDiJ4m6H2R4sFGOerLAZtCGcLGnIhhjEvfMHyBVzuvhbLa2b
 S1G95uN36XVIW2oW0rl9ObSbz/+LFHr7e+BfXvvMOvJnXEEALoD82wgrQ8AT0961Iu9+
 jyYS0lWb4U2KvnnsDtTvyFLvQyMYI3BVhkT2Ad3aZw/0BJ49shWT9eznsFNdQJvo1keY
 Uap8968hkr76mKlvfvurrdFnBQTcKOofCBifFjwERLe1+3Z/CiEcMmBcVYGKF3id06eX
 RAMdNJiJaDYfSKXbKT6x7G6ES9zO2QPIrcwMuY/ZpbE8kofnN41sHAMXC8rrfr0TJCEo
 CI+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdZ/c11VuV/80I7KDBFbxkvbXRMVgCiB9Eeq36JqksdY8McvYkpWfPFyHKImH4pN1jwfRIdG0u1cwWZR3FBtLrTznJvw==
X-Gm-Message-State: AOJu0YwvYOJZsBabM40AzhVTZ+meUTzRK1obuxeMfglfj7va8HM4lnTz
 qcginKJvIrYyqH/jNA9TcAxpBY7uG1HC9RyVVr9bGMw5RfCMdH+OE1luQE3jdc/Q2AhORmlWJ7N
 q2p8jITQjIykToxUuyRgRaOrrv6R4pA==
X-Google-Smtp-Source: AGHT+IHmSnHULum11Ctmh+MZ0Pt3VKD8P1N/TnUZ5WaWlKa9sJBEskoJzXbG/KeEKLw8H53kdZeEOF4lLF4dOXihj20=
X-Received: by 2002:a05:6a20:1f88:b0:1a7:91b0:9ba3 with SMTP id
 dm8-20020a056a201f8800b001a791b09ba3mr801450pzb.4.1714077558325; Thu, 25 Apr
 2024 13:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240423183247.335791-1-marex@denx.de>
 <20240423183247.335791-3-marex@denx.de>
 <CAJ+vNU1fvffzukqr0-u92EyLqXHiwRkvs3CA+1K_A+9p6xrgUg@mail.gmail.com>
In-Reply-To: <CAJ+vNU1fvffzukqr0-u92EyLqXHiwRkvs3CA+1K_A+9p6xrgUg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Apr 2024 17:39:06 -0300
Message-ID: <CAOMZO5DTuB50Rbjc-7fLaRG4QNig=wC43YV1zMXzHVqC0vNzeg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx: Convert i.MX8M flash.bin image
 generation to binman
To: Tim Harvey <tharvey@gateworks.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>, kernel@puri.sm, 
 u-boot@dh-electronics.com
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

On Thu, Apr 25, 2024 at 5:34=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Marek,
>
> Thanks - this is neat and I look forward to seeing a CST signing etype!
>
> Reviewed-By: Tim Harvey <tharvey@gateworks.com>
>
> I did test this on imx8mm_venice_defconfig and it worked great:
> Tested-By: Tim Harvey <tharvey@gateworks.com> # imx8mm_venice

I tested on imx8mm-evk and imx8mn-evk, thanks!

Tested-by: Fabio Estevam <festevam@gmail.com>
