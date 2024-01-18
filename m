Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D85BC47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 20:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F9158795B;
	Thu, 18 Jan 2024 21:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="u/FBJb2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D7AD87B84; Thu, 18 Jan 2024 21:49:22 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E4A84694
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 21:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 96A432228F;
 Thu, 18 Jan 2024 21:49:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1705610960;
 bh=TSopf2A/DZk89ufqCq17FOn/F0JCZLiWc/klFUWH7eQ=; h=From:To:Subject;
 b=u/FBJb2OorJ5WMxJNKv83rUbd7zRRJC/4LC3XcIlZf1Z/B7SumFdBSPkZp6ItXB2M
 O4maaqYbZANAr8BcbmV3f7MfbnTCWCotyAUu0lkMkSvtpgvzJU3QUJW5QoslClDawZ
 DIHZ+IKE9WloNnLEdC94dTUjoQJZ0fB/QW3koWOz9cawjEfeGJwzfwtT742TQIcY5C
 ugbO3CRpWaE2+HTPhyQV8KbMe3cF84+ObwaXIrxJUAWI6B3Eb4rzUYR4BEKt1ajnSo
 WYw0QcPC7IhWUMldXuemCRGQksOW44p/MpZCRaDGlijHyq4e/fsjvxZfkA6+BztQBz
 AZczYGbU7YJxg==
Date: Thu, 18 Jan 2024 21:49:17 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Max Krummenacher <max.oss.09@gmail.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 4/4] board: verdin-am62: set cpu core voltage
 depending on speed grade
Message-ID: <20240118204917.GB25631@francesco-nb>
References: <20240117101743.3955852-1-max.oss.09@gmail.com>
 <20240117101743.3955852-5-max.oss.09@gmail.com>
 <Zaj0T33xqN3Eq6XT@toolbox> <ZalSWOw7UEvfnrKf@toolbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZalSWOw7UEvfnrKf@toolbox>
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

On Thu, Jan 18, 2024 at 05:31:20PM +0100, Max Krummenacher wrote:
> On Thu, Jan 18, 2024 at 10:50:07AM +0100, Max Krummenacher wrote:
> > On Wed, Jan 17, 2024 at 11:16:49AM +0100, Max Krummenacher wrote:
> > > From: Max Krummenacher <max.krummenacher@toradex.com>
> > > 
> > > Speed grade T requires the VDD_CORE voltage to be 0.85V if using
> > > the maximum core frequency.
> > > 
> > > Speed grades G, K, S allow the VDD_CORE voltage to be 0.75V up to the
> > > maximum core frequency but allow to run at 0.85V.
> > > 
> > > For efficiency in manufacturing and code maintenance we use 0.85V for
> > > the PMIC defaults and device tree settings and dynamically adjust the
> > > voltage in the PMIC and device tree to 0.75V for lower speed SKU to
> > > gain more than 100mW power consumption reduction.
> > > 
> > > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > > ---
> > > 
> > >  board/toradex/verdin-am62/verdin-am62.c | 47 +++++++++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > > 
> > > diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
> > > index 4e912b5f32f..8b9db224069 100644
> > > --- a/board/toradex/verdin-am62/verdin-am62.c
> > > +++ b/board/toradex/verdin-am62/verdin-am62.c
> > > @@ -13,10 +13,13 @@
> > >  #include <fdt_support.h>
> > >  #include <init.h>
> > >  #include <k3-ddrss.h>
> > > +#include <power/regulator.h>
> > 
> > In the !DM_REGULATOR case regulator.h assumes errno.h to be already included.
> > This happens when compiling the R5 SPL.
> > 
> > Will fix this in a v2 of the series.
> 
> Actually we can go on with the series. While it is true that errno.h is not
> included in regulator.h, the required header is included and its definitions
> available.
> 
> I will create a separate patch which cleans up the headers, so that they
> become self contained.

FTR, https://lore.kernel.org/all/20240118181106.4133924-1-max.oss.09@gmail.com/

As Max wrote this series does not require that cleanup.

Francesco

