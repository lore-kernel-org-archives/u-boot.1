Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8705C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6370D8786E;
	Mon,  4 Dec 2023 01:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pl6nX3th";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C33878B3; Mon,  4 Dec 2023 01:44:43 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 134E2877E9
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a195e0145acso414590866b.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701650680; x=1702255480; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RcJV6bp/GQQlfBGAdjjDzZ5gvcpq6EJ+/e748NTiies=;
 b=Pl6nX3thhiueUKSot0FNnxlWf3IPZO36CDRto7zwqOSGY9ev1T0/WM2z8NCLw1DkaP
 1PoYADjv/qoR/Ep300yAL18MA7i9p2QuYOj/irX61i6aS95JIRhXczsEYb8skkw6tZCu
 r/D7vujV024vaXaTGMWg2PDTpxRdeKf2ziI4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701650680; x=1702255480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RcJV6bp/GQQlfBGAdjjDzZ5gvcpq6EJ+/e748NTiies=;
 b=k0pSsRIHWwOVQ1l+0AKHaonL1vsYoEyDoc6HeajWmmaiurC33qparsYVPZF8FP66dO
 c4YvV7L69Jcylz8qvgnzfeTp6/D/os9gi4g6N1TZe7AsXuF6+lhADJKBEkJxrRyKUERQ
 HCcJahUtMVB2LpiJrCjaq/5NZ524Y/Ay57UI2xiBkm5aRqELqmg2TMAnqdvX4QmE4ZMp
 +0Wsl0b/tzABq3EgYFimN0cJ1/bOfypQJ3c8c5N2taGD26TSs0I3QCluKcWQXbZTrT8Q
 ziYONLdBNrnnY1eQB8V8elGY4aa7/Sd36Lo4hTKUaB/t+baKWbCMkayNYaBj1/scZIjp
 Xo8w==
X-Gm-Message-State: AOJu0YyFbg+EG8c9rL9YugO2bteVj9OvXopDyGw6646KMIXwOAy+t90F
 gdsgTJ1R1qxlvXHBQNFcBVEGqwAVu/hDZIEqbac4UcD2Lq5q7383wXWdBQ==
X-Google-Smtp-Source: AGHT+IFYVqCzrO2T+Hegjy3s2NvqahG7cQiYrjVPGipqf7m8opJtrbPunAhEF11Y0P8SRrOqMPzM569lS+7ldOQP5ZU=
X-Received: by 2002:a17:907:9856:b0:a19:a19b:421a with SMTP id
 jj22-20020a170907985600b00a19a19b421amr1724521ejc.133.1701650680392; Sun, 03
 Dec 2023 16:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20231202234109.208243-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ1__QvjN2C8Gc_GCvB++HFv6Ni73nC6wDuN7dJq+wDwGA@mail.gmail.com>
 <9dbad2ea-2439-4974-930f-ca80c6551615@mailbox.org>
In-Reply-To: <9dbad2ea-2439-4974-930f-ca80c6551615@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 17:44:25 -0700
Message-ID: <CAPnjgZ3FcKAAMqB=nZ24ritOwucWxQXmTtZCrDnBp_9qHWm-wA@mail.gmail.com>
Subject: Re: [PATCH] mmc: Poll CD in case cyclic framework is enabled
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Marek,

On Sun, 3 Dec 2023 at 14:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 12/3/23 18:44, Simon Glass wrote:
> > Hi Marek,
> >
> > On Sat, 2 Dec 2023 at 16:41, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> In case the cyclic framework is enabled, poll the card detect of already
> >> initialized cards and deinitialize them in case they are removed. Since
> >> the card initialization is a longer process and card initialization is
> >> done on first access to an uninitialized card anyway, avoid initializing
> >> newly detected uninitialized cards in the cyclic callback.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> >> Cc: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>   drivers/mmc/mmc-uclass.c | 27 +++++++++++++++++++++++++++
> >>   1 file changed, 27 insertions(+)
> >
> > This is really nice!
>
> I wonder whether we can use this cyclic stuff for USB , that's on my
> roadmap to look at . We could auto-detect new devices in the background,
> which would be tidy. And maybe do block transfers in the background ?

Just the detect would be amazing!!

One thing on my mind is that we could have a console buffer, so that
output from background tasks can be collected and written just before
displaying the U-Boot prompt. I am itching to implement that part of
it :-)

>
> > Is there a remove() method where we could unregister the cyclic?
>
> I guess I need to move this into mmc_init/mmc_deinit .

Yes, I suppose so.

Regards,
Simon
