Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9DBC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEB988D51;
	Wed,  7 Aug 2024 16:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yi5BM49M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C927E88D15; Wed,  7 Aug 2024 16:36:33 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D2588BE7
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b7a4668f1fso10956746d6.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723041389; x=1723646189; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pnCIddEdxbgKZ9+C4rJiIW0at1W9mdLZwH/UgWwsjvI=;
 b=Yi5BM49MP8PGQvj7UDY+WGN45VNpyYyrvpgiQ2JlFujv1EfVrMXpcXteZJsRPkijFV
 DFul4V3FyUlIP8Iszrd5Lde6vWcmWdItsiFObH+W1H8Y28+/0IdvzJKI5ZERv1YwORb2
 W+CAEn9/bV1W3goYCvZrYioaOLoFbdqtpKq2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723041389; x=1723646189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pnCIddEdxbgKZ9+C4rJiIW0at1W9mdLZwH/UgWwsjvI=;
 b=V5jgRSK7jav8ARMaXOYDaHJrp68bMbSI3OJFOPHaum/hYsDtAvh3JJMMRf+KpOdxw8
 vjU6lF4PgGZiFPaLRdDL4D+iWClxxOV8GNSNIQbC+38NrV35pQ1XcQe/X5kN7PIU0O2N
 6tnC3jwgn75VdX381Ch91CTx9AiI+x/R14aXHCpVppPPeGhceGQLpCn+gImLvgAsI43a
 tQNeLA6k1WhmlbBgwNYMdUTbZcueLRgcGpKed/xcfwWg5QFePRYZOZBRZFPDwS/8eUIa
 UtzU3GYNXWPfjmZlSoNIHjQAGeNrGXWJLn1PaeIuL1aMGtVjG/bQH8981TPY7JNY7Mq/
 gK3w==
X-Gm-Message-State: AOJu0YySq1qgmGpBXOT+qOepoxBYlpnfjIhMaffB4NNRU9Vp/Z/0Yabb
 x7SUISjOvoPWOIjHOaxO33kb0QDjyv/4mdkjP9Dsq1AbaTiSM2DgbRIY+6Ap+z0dxgIwi1VH8Zf
 HJJVcZ9IDVlD6Xazdfqn5Ket9QAZrE8io4GKF
X-Google-Smtp-Source: AGHT+IGuN96R94RirRZPxhh0/MzdjVgvyMj3HW0kQmVK3cAmJ5gE8ipGmfFt5I7onzaHUAJn+TqZWuVacZYDD9bXY5E=
X-Received: by 2002:a05:6214:3384:b0:6b5:7e70:3537 with SMTP id
 6a1803df08f44-6bb984192b9mr180734096d6.50.1723041388660; Wed, 07 Aug 2024
 07:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240713070055.2172883-1-sjg@chromium.org>
 <87a5iliubh.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87a5iliubh.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 08:36:18 -0600
Message-ID: <CAFLszTgssphMZjqkks_KCakMMLsjt_48EEceY2=rWoEaOYOAUg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Universal Payload initial series
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, seanga2@gmail.com, 
 sheng.tan@9elements.com, akashi.tkhro@gmail.com, abdellatif.elkhlifi@arm.com, 
 agendin@matrox.com, linux.amoon@gmail.com, andre.przywara@arm.com, afd@ti.com, 
 artur@conclusive.pl, bmeng.cn@gmail.com, bb@ti.com, caleb.connolly@linaro.org, 
 chanho61.park@samsung.com, devarsht@ti.com, eajames@linux.ibm.com, 
 etienne.carriere@foss.st.com, francis.laniel@amarulasolutions.com, 
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, vanbaren@cideas.com, 
 mr.bossman075@gmail.com, jonas@kwiboo.se, jpewhacker@gmail.com, 
 kever.yang@rock-chips.com, leon@georgemail.eu, lukas.funke@weidmueller.com, 
 abbaraju.manojsai@amarulasolutions.com, marek.vasut+renesas@mailbox.org, 
 marex@denx.de, mkorpershoek@baylibre.com, n-jain1@ti.com, nm@ti.com, 
 oleksandr.suvorov@foundries.io, pbrobinson@gmail.com, 
 rasmus.villemoes@prevas.dk, raymond.mao@linaro.org, 
 semen.protsenko@linaro.org, samuel@sholland.org, yangshiji66@outlook.com, 
 sughosh.ganu@linaro.org, sumit.garg@linaro.org, sunil@amarulasolutions.com, 
 tom@tom-fitzhenry.me.uk, trini@konsulko.com, troykiskyboundary@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 07 Aug 2024 16:37:37 +0200
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

Hi Mark,

On Sat, 13 Jul 2024 at 02:12, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Sat, 13 Jul 2024 08:00:34 +0100
> >
> > Universal Payload (UPL) is an Industry Standard for firmware
> > components[1].
>
> I think you have some trouble understanding the concept of industry
> standard ;).  I guess you want this to become an industry standard.
> Firmly https://xkcd.com/927/ territory if you ask me.

Please refrain from snarky comments on the U-Boot mailing list. The
Linux list might be a better fit but we don't do that here. Yes, I do
understand that we all have weak moments where we get frustrated with
something.

Regards,
Simon

[..]
