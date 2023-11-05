Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E02DC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 16:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C2B86F45;
	Sun,  5 Nov 2023 17:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QQlsGntg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFE486F38; Sun,  5 Nov 2023 17:29:33 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 025C186F44
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 17:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9d224dca585so548958866b.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699201768; x=1699806568; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XTDWJHHuE3JdKW6g184IR2hpm1Eqr3ajkVCzD6Kapkw=;
 b=QQlsGntgnU27Fj+uImY9XjFj5Ka2bhdj99Iy+TdO2ewqp8sr/5zvzGTuuXkaGCxT3z
 K2qphzWAcwgkZwk+GYzA8ECSjp7WWtQAhHCWac+H+c01U8zbYWTBnM73Rpjn/xpVEUdS
 rVCmjOvdpJ2dFCMPDcae/S54qVNmeorE/6gNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699201768; x=1699806568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XTDWJHHuE3JdKW6g184IR2hpm1Eqr3ajkVCzD6Kapkw=;
 b=tSjmcVPgk4T4CtqbnoIflKz4reZVtwhrGE4tkA67fe6m0G6XgwnAPEPeBQcjCm2aQY
 LcaVyaG62m81S/eXrEEL+2KzW+a5qf20EnMEXSBhzKkjgXXYO+viVhhkKnGGIm7vJ7jr
 JmQ/Kp8w2642GbPndSIeibWCC+0JKMXrhfof3mgrFYrozoS8SKYrgGIQc+eDnWjFZ7g4
 H50kyYLOL73wGh48CcxSeeiOtepb0RDtCN4lIA58N7rSaU26+1a04I6kVm4exzNa1ekH
 ImjMyRqsgBKwP3n33XkJwoOcCzpUp39btm2JOieXIzlT/GblOAuZHvql4eSJyNDDzD3Q
 ReeQ==
X-Gm-Message-State: AOJu0YyMRLLuFIX8gF76F6UE3xCIckrFls3rRK6FoAiU2gjvdUTjeWPt
 v8s6zTOX/x9NJclsBcO7A2TcjyYsHt2omgem6I5aqQ==
X-Google-Smtp-Source: AGHT+IGo7le9ouM54E2Jt4t8Lti+ydjLBKONHjMfFgBf+52XG2/0XXkz0CuVO325XFvJjSR3+DoECBM4DTnwxZh8E9g=
X-Received: by 2002:a17:907:7b99:b0:9bd:d405:4e80 with SMTP id
 ne25-20020a1709077b9900b009bdd4054e80mr13108625ejc.46.1699201767762; Sun, 05
 Nov 2023 08:29:27 -0800 (PST)
MIME-Version: 1.0
References: <bf1e575239af2f0dae872543dbc4f9974c618c95.camel@physik.fu-berlin.de>
 <CAPnjgZ0zjD+vrsyHkRpAzatZvA7Cv5-9Q+96O1mUN0Ei4H70uw@mail.gmail.com>
 <891544b36a1a9a1cd62345f341828c144e7f1ec6.camel@physik.fu-berlin.de>
In-Reply-To: <891544b36a1a9a1cd62345f341828c144e7f1ec6.camel@physik.fu-berlin.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Nov 2023 16:29:16 +0000
Message-ID: <CAPnjgZ35bJSBE_HqVxh_fb42AYm+vYmx-oyaDQzXqcsmqFvHxA@mail.gmail.com>
Subject: Re: Need advise with u-boot on SH-7785LCR
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi John,

On Sun, 5 Nov 2023 at 09:37, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Simon,
>
> On Sat, 2023-11-04 at 19:42 +0000, Simon Glass wrote:
> > Is it possible to check if it reaches the kernel? E.g. with
> > earlyprintk ? It would be good to know if U-Boot managers to jump to
> > Linux, or not.
>
> Thanks, this is actually a very good idea. In fact, we recently restored
> earlyprintk support on SuperH which got disabled by accident [1], so I
> would have an opportunity to use it right away.
>
> Do you have maybe any clue as for how to update u-boot on this machine?
>
> Might be a good idea to start from the most recent version that is supported
> on this target. I assume the "erase" command will erase the flash. But there
> doesn't seem to be a "program" command.

No, sorry I don't have any idea about that. You could check the
MAINTAINERS files in U-Boot and Linux for other people, perhaps, or
check commit / blame logs?

Regards,
Simon

>
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
