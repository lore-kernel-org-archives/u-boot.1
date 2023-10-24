Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF3AC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32ED9879DF;
	Wed, 25 Oct 2023 01:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AQoEPQZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80D587A01; Wed, 25 Oct 2023 01:28:33 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C6B87199
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507973f3b65so7963999e87.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698190109; x=1698794909; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w97p4dw4OSO53e3BtEkUu6Rwm8Am1ta2n3ZTSKL4u4U=;
 b=AQoEPQZdYCU+VgnvRJTIlpkFMnm4nq+z1uU9KFsjirZfwMIifs0ceTipg/ukKNGpIZ
 aHtbPx7P+htjTmj8hVe7vy+Q13A3FMGQcGwc51uDjIB/TWmw9R4KD7hSrNggD91Q9ctH
 QUTx05D13SMPdDzj0bR388cYMzRQALQWit8zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698190109; x=1698794909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w97p4dw4OSO53e3BtEkUu6Rwm8Am1ta2n3ZTSKL4u4U=;
 b=u/JjJCaP7ImlNFqlqYuOc7bYPsjEfJ8jnrZ5Jlm5bzl2rubX5w+aNhXXrk85LtqJ/6
 FEjRFZDrshqyaiSGgX19z5O12Sv+XDtNtxpQTGbXD/ulnogEmhTMR5nwfmuY2wzchYwX
 6A49K9mS2UEk8dv2BxUug9UL2ESyEqwQX5eMaOIWfamy2cYddh0ohyi0T0ANBF6On5hb
 BQ4fTC3gXoKQV2N+jRKAuLsN93/JyUU6/xY7VwGkXQMocsJrFbpBbipqp+ATuJ5aXjJh
 mU03YrdUtriUtAY5Jok0gNBiTc3NpIhGqpIQiDuQuukhHM0v3XYllFN3jAQQw8LbsLRc
 i0LQ==
X-Gm-Message-State: AOJu0YxjUTbjVNwFORfaOkbCOAr6Rz5BchbkgO7JQn4V3u01mYeaA7tJ
 b7bYd5EfqNbsfWV2ubXiYV1mE++t5QPaYk0NpJ6f7g==
X-Google-Smtp-Source: AGHT+IFHOrLFKRRzNJpi8676pQVgYaWzvk3DSMubUE7KNyTSYfQ0iUC6vVH4FhExHV19clAqu3itYJJRfwipXsLdunU=
X-Received: by 2002:a05:6512:3763:b0:507:975f:6ccb with SMTP id
 z3-20020a056512376300b00507975f6ccbmr8704036lft.2.1698190109107; Tue, 24 Oct
 2023 16:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
In-Reply-To: <20231024223405.GM496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 16:28:10 -0700
Message-ID: <CAPnjgZ1h2GUWKupVJcNEQmQd1JJf1h9X+xkc3P=+qxmfCwAcOA@mail.gmail.com>
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, caleb.connolly@linaro.org, 
 u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, 
 bmeng.cn@gmail.com, brandon.maier@collins.com, kconsul@ventanamicro.com, 
 oleksandr.suvorov@foundries.io, patrick.delaunay@foss.st.com, 
 sughosh.ganu@linaro.org
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

Hi Tom,

On Tue, 24 Oct 2023 at 15:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
> > > From: Simon Glass <sjg@chromium.org>
> > > Date: Mon, 23 Oct 2023 00:04:14 -0700
> > >
> > > Hi Caleb,
> > >
> > > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On 21/10/2023 01:45, Simon Glass wrote:
> > > > > U-Boot typically sets up its malloc() pool near the top of memory. On
> > > > > ARM64 systems this can result in an SMBIOS table above 4GB which is
> > > > > not supported by SMBIOSv2.
> [snip]
> > There is absolutely no guarantee that arm64 machines have memory below
> > 4GB.  Examples of SoCs that have no memory below 4GB are AMD's Opteron
> > A1100 SoC and all the recent Apple SoCs.
>
> So one thing to resolve here is where does that requirement about the
> SMBIOS table needing to be below 4GB come from (standards wise), and in
> turn is that obeyed by consumers like say Linux or OpenBSD? Answering my
> own question, maybe in part, https://www.dmtf.org/standards/smbios reads
> to me like there's a v3 and maybe we should be doing what we need to
> support / identify as that, if it doesn't have that restriction?

Yes that was my previous patch. However 1) we apparently don't want to
use SMBIOS3 and 2) my patch had some sort of bug so that it wasn't
read correctly.

So my next version is going to be along the lines of what was discussed here.

Of course, we cannot solve Mark's problem with SMBIOS2, but I suppose
that is obvious. Anyway, those platforms probably don't need SMBIOS.

Regards,
Simon
