Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C67CF6495
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 22:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A32D3889C9;
	Mon, 30 Sep 2024 00:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P6wOO+GM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CE788D5B; Mon, 30 Sep 2024 00:49:31 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECAB889C9
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 00:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c5ab2de184so27039826d6.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 15:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727650168; x=1728254968; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TrNaI3w/l+AEz6t+merFXsM9gM1d1VYMeOZuMtvvWw=;
 b=P6wOO+GMz5l+WgooEbzMN/1xSMIEXLqDdXp53WV4HMlN4pRUY7YitJOVDYEegQzm/Q
 61YCCN6jySCcHefa/jJ13Nnx8SAIuC3R70mDLUiZZEZ6DtPQ9JPD2inKvvsUYrx5RLAf
 WKoJfKh09GAZ2RlK2ARtLuOz0ap79TALdjLJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727650168; x=1728254968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TrNaI3w/l+AEz6t+merFXsM9gM1d1VYMeOZuMtvvWw=;
 b=MgqHq1OjOwqNJ5Zm+N7/tAMw1UFsUl7yX7CrFuUq2VmSfEK7h43/D97efsBFafvkA9
 p5vdXXzfFWlhUvg8SG7FH9Cfn2FSbr1p1qEZIVzbrbcJmVBlqYscqqwtH47M9Pejjuzu
 ZBrPg1k6QM8jZVLgwNopFc7jYA+MyaXLSD/OHoRn8BqBs+YYvyv7d/PrxfHxm5qAG/ng
 iPrjY8jk+KqDMR1PPy8aIBWGSq2wiag6zkRUwoT8xvsLENGkhErpH/ePiKiD1puWL5ob
 Ldv9JpppNcYeYKHpvzu0uCqJCGif69wDNi88UF+1G9ZMKiLm7ESWj50gCnrao1LnF4jk
 1bKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP/fvFtEOahVBab66aEzLgjydwtPDy3F8EbrHJAFFMlB3566X/2KG/HlIEzFReeUSnFrucmBs=@lists.denx.de
X-Gm-Message-State: AOJu0YyM3VJYK/mRsZsNp+Ue3bkTiuyEwxOOamqLPGBxbsbyPCePJDcx
 wGqvKOBgZBEDPl0m5a8zw/jXo88C5khetizI5zswhwWp6XzFGYx4bVfXXMhmAn+69p2CAX/PKsx
 +MXBPThHAUc/ZELMlWqhkQh/V5Ro+115YYNaO
X-Google-Smtp-Source: AGHT+IGJccq44CxuYi+bDckO6Avf7N0EG3K/wQhJnFWkR0IzFqALpMjqktMP3+Sj00EvyIlcmOSyNrUQCMH75n+ZBMs=
X-Received: by 2002:a05:6214:398b:b0:6c5:688a:63b4 with SMTP id
 6a1803df08f44-6cb3b67c681mr136001016d6.50.1727650168086; Sun, 29 Sep 2024
 15:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240927124237.47-1-brian.ruley@gehealthcare.com>
 <CAFLszTjHkmT0JcgcZ6Yn69q27Pe7YhvwuXc0bC0N+agmpPtCfg@mail.gmail.com>
 <20240927204046.GW4252@bill-the-cat>
 <CAOMZO5DAUD3WR5z8ZxPkVhnv_2VZpYaHRziEvZ7MHvwooNS8Jg@mail.gmail.com>
In-Reply-To: <CAOMZO5DAUD3WR5z8ZxPkVhnv_2VZpYaHRziEvZ7MHvwooNS8Jg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 29 Sep 2024 16:49:17 -0600
Message-ID: <CAFLszTiUQBJvaU_bhUYdsujo-oeeT8RCDguu+pYQ9YEppqqALg@mail.gmail.com>
Subject: Re: [PATCH] binman: add fast authentication method for i.MX8M signing
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, ian.ray@gehealthcare.com, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

Hi Fabio,

On Sun, 29 Sept 2024 at 14:53, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Simon, Marek, and Tom,
>
> On Fri, Sep 27, 2024 at 5:47=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>
> > > Please can you coordinate with Marek as we need to sort out the test
> > > coverage for this etype, before adding more functionality. I did a
> > > starting point, now in -next, which should help.
> >
> > Well, when someone has both time and understanding of the tools and the
> > frameworks, we can expand the automatic tests while still having
> > functional testing as people use the feature.
>
> Do you think this patch should be applied as is? Could the tests be
> handled later?
>
> Please let me know.

Who is going to handle the tests later and when?

Regards,
Simon
