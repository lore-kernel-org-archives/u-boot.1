Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D7AC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 05:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2441787F5D;
	Fri, 15 Mar 2024 06:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ugboiQLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C3C87F5A; Fri, 15 Mar 2024 06:37:13 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C11E487F5D
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 06:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-476025fde0aso549116137.1
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 22:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710481027; x=1711085827; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lcsef1JSPm3fHKs8opqQcDoP8BlR8vc9ZOA2MdJeC3Q=;
 b=ugboiQLWXAuFdfo6A273fh+J/H7tlEtuMktvMW0Cjw/HhtmdWjBNepioayMKpqKBJM
 pbj8SN5d+7emYk2sSK1Nh7jPZP56vwpYdvrPX7HkrvO5jztvz8L7zFmSUjYgB2dANz+O
 ovT0OyteHiZUZqePUtB6TOberdtVrUqhzzELSloyharJHv8TnrK3cahFakW6DpVLr1Sb
 i/UTy6gFsy2gIik55gqJt/W0Jx7w8/LJ/BQlGhXWduQNrVgu9faqnjoXV4ywfzoKEqVY
 DsryxwbPpIxlKL+EdccfOPTSkoPwLE099qM+qIPKMe6EK8lCFSOpqBmWfqnJiePjlMSg
 Oq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710481027; x=1711085827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcsef1JSPm3fHKs8opqQcDoP8BlR8vc9ZOA2MdJeC3Q=;
 b=G+5DmD9ujlnFBaQR/f6eKglyILrnYEPtWU3dY3rQXfR+tVC0T3y4dDO8nGFmMXuTv/
 gxcsq4D1rErjcckt2fpRrSBx+cDdhkksHhZfCci0A9xc1OFNktcvY6SPKrkldSfYIiaI
 ZFk6uRhk6u/quxQir7qXGqJXf4qS4wb/kh4AWhcjywqVB6tkNk+lHMpfRC7dnzc8HH7o
 PBdzud4yCAZ64o2/Ufm33dwUNuURSTHuWJb6BtLuMk6OWWyhnqNa831MCo29tWQqGn62
 ocMOAlRYQmsjoca10AsRYq9WimYHIFv2cpXhOL9XjrMnwgUhReJpRVfDTeJdLr6aTlyb
 tZ0A==
X-Gm-Message-State: AOJu0Yw1vwe9MKOhPf3HW0IQhxOXEHLwcUXhUruGJZBy2aBis+dpYS9N
 tROMFux8+rZFhKClazibVQp8l3at+PEksljQCW5OO8/greHrkWFJNjZB3Ww1rhymdFRexjFrXJK
 vPPyZfODceKORlyPa6bYaT0alJe/XJUb8d7UEHQ==
X-Google-Smtp-Source: AGHT+IE1iStmgEjyVNDvMyw7KbPm7xrNeuDsYMf4SM18NC/WUBsiZZJUHg9q7Mv8640eo2cR5KizTL2tQe4j0zupq7E=
X-Received: by 2002:a05:6102:4411:b0:476:577f:aad7 with SMTP id
 df17-20020a056102441100b00476577faad7mr3826265vsb.31.1710481027249; Thu, 14
 Mar 2024 22:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-3-sumit.garg@linaro.org>
 <d477d827-5910-4c5b-9b35-116e85fb8e53@denx.de>
In-Reply-To: <d477d827-5910-4c5b-9b35-116e85fb8e53@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 15 Mar 2024 11:06:54 +0530
Message-ID: <CAFA6WYOXi_JDgkbF5164jBuyPL+0r3mT6LtYx2LRNKqkFwnMuw@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] reset: imx: Refactor driver to simplify function
 names
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com, 
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de, 
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com, 
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, fathi.boudra@linaro.org, 
 remi.duraffort@linaro.org, daniel.thompson@linaro.org
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

On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
>
> On 3/12/24 8:03 AM, Sumit Garg wrote:
> > imx7_reset_{deassert/assert}_imx* are a bit more confusing when compared
> > with imx*_reset_{deassert/assert}. So refactor driver to use function
> > names easier to understand. This shouldn't affect the functionality
> > though.
> >
> > Suggested-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   drivers/reset/reset-imx7.c | 24 ++++++++++++------------
>
> You could even rename the driver itself now, but that would be separate
> patch.

That can be done as a followup patch.

>
> >   1 file changed, 12 insertions(+), 12 deletions(-)
> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks.

-Sumit
