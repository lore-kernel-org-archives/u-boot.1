Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21800C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 06:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59AF4870AB;
	Thu, 30 Nov 2023 07:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vQSK9Ivz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20A2870EA; Thu, 30 Nov 2023 07:50:04 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5595F87049
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 07:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c9b8aa4fc7so7711501fa.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 22:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701327000; x=1701931800; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zUtHTEw1lkpaeL20XZHA2RVVaeVWjf9zVT7afkKtzzo=;
 b=vQSK9IvzXA8zb2Nwtw6/olPn4Q3Wyx68Kp958MLSj7R9sle8Gawc0dhi7keLkLbcTK
 +MqGS8lEE8UmzXAogzJKtj1XtPUz+oM9LJMYyOIN+mQMw6CwAy9smSSbvjTgXPcb8Shu
 7YOX9IGy/hJWGuWrL3R9J+2ACidEwFwz/ChBMhuxRCHh1RrPJpXQ15lpDTFXugAtSji+
 khHlc9r/S9whCQv1XGwksXp0Qxd+GZ2ef/UTaR36LhN+nAMo5OqB1ZoAggea2f3ZTM1o
 1s7c8U7HYMJnFSjf9vXqppSCqd65NR8JEfD8CsMQBI5OFXBv64yRaCbdfJlIAHYyiFX3
 Ayww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701327000; x=1701931800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zUtHTEw1lkpaeL20XZHA2RVVaeVWjf9zVT7afkKtzzo=;
 b=vc/YPSdmk4S/SRVtExvzqzoL89MZxla8mu+HsXWKxzyofWziASudYuTiuFiKS7QgQu
 W7VXLts9QHnUZ/tlKejSA12cZW3oO3JiWUw2ajAzvDikdqrCQsBY7An824XFFLE8DL/u
 T+pz2/wB9MA4Qkx6wPVd87XcsO6m7neJVoExIMVQiWDQMQmTDtGoasYG0vi2paJkBMw7
 M3Pi04tpE3Rs96nMOfrmlr5VIVYcNLKvit6wJ9NB7MT+kTmLH3IUH9qBFbHLWslblWqB
 iqieYEpy017LQMpJIVCaXCCJElnJoZ+49XtL4CsVqKOxTqkN+xdv4Ek6C2y51UMtggFq
 NeKA==
X-Gm-Message-State: AOJu0Ywsi4w0fIsDqooWiS/yhDC+ZYV1tNY9rmt9mhbUDBQlnW46n9xI
 5rqcs99yOmMCAfsV3WdX5FcsHpGyLI98sDbxK7dSXA==
X-Google-Smtp-Source: AGHT+IFBAYl1TSPnc/a4rSkPZaclIj/JU8IlnczgWr2l/053k4hhgqrCokho3E2LjWAM/49NhQuXLXBnF3/m42Lqpco=
X-Received: by 2002:a2e:93cf:0:b0:2c6:ed74:4058 with SMTP id
 p15-20020a2e93cf000000b002c6ed744058mr12963656ljh.42.1701327000536; Wed, 29
 Nov 2023 22:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Nov 2023 08:49:24 +0200
Message-ID: <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

[...]

> Changes since v1:
> > - Tokenize the DT node entry and use the appropriate value instead of
> >   the entire string
> > - Removed Peters tested/reviewed-by tags due to the above
> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 90 insertions(+), 4 deletions(-)
> >
>
> Can this be put behind a Kconfig? It adds quite a bit of code which
> punishes those boards which do the right thing.
>

Sure but OTOH the code increase should be really minimal. But I don't mind
I can add a Kconfig


> > +
> > +       dt_str = ofnode_read_string(ofnode_root(), nprop->dt_str);
>
> Could this use ofnode_read_string_index() ?
>

Maybe, I'll have a look and change it if that works

[...]


> Any chance of a test for this code?
>

Sure, but any suggestions on where to add the test?
SMBIOS tables are populated on OS booting, do we have a test somewhere that
boots an OS?
Any other ideas?

Thanks
/Ilias

>
> Regards,
> Simon
>
