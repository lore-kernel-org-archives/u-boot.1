Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386D3105F7AD
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 13:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC0384221;
	Fri, 13 Mar 2026 14:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wftE1nLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 741E38423D; Fri, 13 Mar 2026 14:58:38 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 758A78420D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:58:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6616cb8c80cso3362581a12.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 06:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773410315; cv=none;
 d=google.com; s=arc-20240605;
 b=HPQW4ehm/ad2Z9ZvPk07Lug6oFu3Wlc5Jfe6r28Zqw+XwYEj1kRUTdCrApemMEwIjB
 4KRkm7eMoE676Lmoxucwuf9nc8T0G36f1H24C7sqR1iBjdcL81qAYFCt/rR3KuP9zMN/
 uEPg2+EdAnjMb3XTMFZ6jnmEpT845t6oiIcWwJr6A3d0agCylvTwIzeoyjA2TGAfmmUX
 XEgADl1rRde5BB/7bG9StrNnZ7CNPDCE/tIu3Gtft19RuWnKwgDJQUAjH9U+yA/P9JIf
 uCkFcdnqnfwPfj+3IO1RMqLionmnbL/tczQT9NjNbJkcYA9vYqMXGqICmBRNmBHwsi7P
 iUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pZoS0XCdkooSnofsUENZT3eSrtpbd7VsTK5TD/vKq90=;
 fh=sY/B501gdvVYUnMsfX9pRJj0VAGyOOciGa7UWcOEmEM=;
 b=ePs6LiE0//pOy1Nv7j41/k7glf6I84wiILwtYj7yDn1/CLKcZchpmcfYNvC/Fx5uuS
 /vp1IUxb/NKT9MZGBLVGrr+3nLq8NdrFgwLshEOvRwwKPa8q2qhaTcL9z5cVgYaQzzRb
 TWnYcJl2SNXI0M8gVYEMUCSH9vV6dY0XkXI1kL+IUo/BQM7I9Eyq7RIBl+/K+SJSiE6t
 uLNvmiOYRdAA96MxIogFixDjXTYc7QEOvqU6QnM2F9Svq8NrNpJE4oLa1pRqScTYsAXY
 wEE79HOknNR2RTHDpi8lFWno9Qp7wtM3qclD0yKm2YomfAY7l2MnISBV6prDuBba232Z
 R2kA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773410315; x=1774015115;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZoS0XCdkooSnofsUENZT3eSrtpbd7VsTK5TD/vKq90=;
 b=wftE1nLfosFcwdwMQYX/VOkY/kM6K9CYYlxYRwGwn/ryO/jydD0x73AkJ646nedk3L
 QKkgzP3bn7qJlKGJGSxu+4KwItTg3gHMFzR7CU84rzb3FqPdd7ydnLk+9xNADAgtc6Ir
 WdNl9sMZcx67lVliVlBX1gkSKxXg3F0BMV8aTt7iXWD8vz2mw+ITDmL05+6NCv+GyljR
 vULTNkiuPwfKZOWQfr2xyBa/AAhVz9XiHcsLs0VT/bwl4BR1PWM/gWUDRin8AHep/hfk
 GOFHIzEPLgUCuFLRT9/n4BVTAWFzty8YN0OtCk3/xCAV6xx2pGK1rRlYfIDtmV7cvLWI
 GHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773410315; x=1774015115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZoS0XCdkooSnofsUENZT3eSrtpbd7VsTK5TD/vKq90=;
 b=ftP3Z1W8wssO1GjOzsLebCNtm8liYkfbt0DdnwQ/CJRRYHn4y4QHRpsiwhorfGa0D3
 h230Md8D3r1x2ziwr9MwauM/B/OvWwApad5QPjxR/ArqZ4n5njDjhlgE02PavdNZUC5r
 yD+Ibrf5htLJw6AAAyEppf3BeFsYmwLgfqxgwYrgCsHk7FYDMLBYqADIRECJqoXmi6qQ
 0HIeJOq8532yT4Tsq4O7QKrMetyYys2EdeTtKKRKiM929PcYrgMZEjhM8cG0gAbxciAb
 SKOzKPYxFPDlBCkP87iG6689lRpxuQcXPAEc6AoClX3Ez6qoiIlWEP4VLLAfqAF/hg7n
 wPmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL4Gx6jguAfnQaywepb/EymU22oDRLR1BxzfpDF9GAzcKPOXFHEzgPRqy/deTtpASXQ9ggI+A=@lists.denx.de
X-Gm-Message-State: AOJu0YxPqEkpETjyTtMnRdpiDf9004UDw4c+P9EfkRzKIQsSNVFIl/3e
 93vHhd8Um21euOMHIKO4JyAWdAlJ1MeKKFxwJQ5rSeo2k4IVZYV9NPmg2HDk9Zl4J8cO92fVUpL
 8O0RYRwO3pOYiJx9IXjUQi+EauG3fTcE7+2+GWv4d+A==
X-Gm-Gg: ATEYQzx3UaWUXz6fWBGKuNs5i12DZtsSs5HEr5M+ykcCd9N1WWUBoqHVmJ1Z0JTKI7s
 9xXR5qH4HzNx6z3xtbYrHsO4SFf3X2QiRadrvllFIWNSsSrHK3ftbGV66lfo6DxZ8+3jPfSrpBn
 TX3s/tIRRr1w5iKEhLkqJrTFQIe7gwZx3nqo9WgyxRHpuI4L+B9Ddj63+z0f+EOv75gM3VqY6mJ
 0XboffkLzvDxMuwUoMpU9L9IabEXhpovvOTadx88+3NXd1cWiGWNq44vlWD5IyvnxXOA9YY1Hpc
 KIToGIviCCg+skhKZJFleSeH7aTO+rYDaxLlyS7hdCcZFoCNB3vUFhHIcpIqaaC4GysJdvWOcPB
 2HiUgQDteEoCnK+wPxKizdhlLhQ==
X-Received: by 2002:a17:906:1719:b0:b93:5612:a57 with SMTP id
 a640c23a62f3a-b97653524e9mr158210366b.52.1773410314723; Fri, 13 Mar 2026
 06:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
 <20260303-mtk-mt8189-clocks-v4-7-ee85f8dd2f0d@baylibre.com>
 <1348f10407c0f6d68852bc457bbd1da9fc83de31.camel@mediatek.com>
In-Reply-To: <1348f10407c0f6d68852bc457bbd1da9fc83de31.camel@mediatek.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 14:58:27 +0100
X-Gm-Features: AaiRm518BsXdI55v91FxsOOuA3FQ8eXqt5VpzRrqFsNimCcF0dm_yyZVLdbX_RI
Message-ID: <CAEHHSvbzG3ggPiX9YJ2ZQ3++DNRnK-SbddgytZEaW_jGJ4ePQg@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] clk: mediatek: add clock driver for MT8189
To: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>, 
 =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>, 
 "lukma@denx.de" <lukma@denx.de>, "trini@konsulko.com" <trini@konsulko.com>, 
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
 =?UTF-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>, 
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 =?UTF-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
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

Le jeu. 5 mars 2026 =C3=A0 15:14, Macpaul Lin (=E6=9E=97=E6=99=BA=E6=96=8C)
<Macpaul.Lin@mediatek.com> a =C3=A9crit :
>
> On Tue, 2026-03-03 at 13:54 -0600, David Lechner wrote:
> > From: Chris Chen <chris-qj.chen@mediatek.com>
> >
> > Add new clock driver for MedaiTek MT8189 and compatible SoCs.

nit: MediaTek

> >
> > Signed-off-by: Chris Chen <chris-qj.chen@mediatek.com>
> > Co-developed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/clk/mediatek/Makefile     |    1 +
> >  drivers/clk/mediatek/clk-mt8189.c | 1748
> > +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 1749 insertions(+)
> >
> > diff --git a/drivers/clk/mediatek/Makefile
> > b/drivers/clk/mediatek/Makefile
> > index 5bede819c0d..d4cac6aaf52 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_TARGET_MT7988) +=3D clk-mt7988.o
> >  obj-$(CONFIG_TARGET_MT7987) +=3D clk-mt7987.o
> >  obj-$(CONFIG_TARGET_MT8183) +=3D clk-mt8183.o
> >  obj-$(CONFIG_TARGET_MT8188) +=3D clk-mt8188.o
> > +obj-$(CONFIG_TARGET_MT8189) +=3D clk-mt8189.o
> >  obj-$(CONFIG_TARGET_MT8195) +=3D clk-mt8195.o
> >  obj-$(CONFIG_TARGET_MT8365) +=3D clk-mt8365.o
> >  obj-$(CONFIG_TARGET_MT8512) +=3D clk-mt8512.o
> > diff --git a/drivers/clk/mediatek/clk-mt8189.c
> > b/drivers/clk/mediatek/clk-mt8189.c
> > new file mode 100644
> > index 00000000000..9e48d668db6
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8189.c
> > @@ -0,0 +1,1748 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2026 MediaTek Inc.
> > + * Author: Chris Chen <chris-qj.chen@mediatek.com>
> > + * Author: David Lechner <dlechner@baylibre.com>
> > + */
> > +
> > +#include <dm.h>
> > +#include <dt-bindings/clock/mediatek,mt8189-clk.h>
> > +#include <linux/kernel.h>
> > +
> > +#include "clk-mtk.h"
> > +
>
> [snip...]
>
> Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
>
> Thanks,
> Macpaul Lin
