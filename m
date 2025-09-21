Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37345CAC59A
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 12:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 511AD830CA;
	Sun, 21 Sep 2025 14:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZOTWyS4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612228317B; Sun, 21 Sep 2025 14:15:58 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6841581E13
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 14:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-368348d30e0so6726641fa.1
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758456956; x=1759061756; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AC4alj7BODy+tGg63FW+FvwgwFWTUOs8ikXVgt7Jzw=;
 b=ZOTWyS4qdcpw2dc2YV5hHdQNmZuVdbMwQ3OY3OjI2QJ+seFEpDp6Z8y3RYk3WN9YNO
 TDSq7VcQtKUh3ufTnvPia92WcpxqFzIE0ARxyxGViyC8lS29CkKOEYT7vscLubhZkAn1
 ZAFSagg1ONZi6zciQh6bxEWrH9ha/dzqOAnHq6+WooXanOBWP0MlIJ8aF5/lXymYvtu7
 rc694PKZdKQNWTVd/gBakNJMJ30M8UG4KziKYnH0zrYvKQMwb/+ctQl330Fjj/ow3n2L
 c0VrJSXQJUdL44fmv1Zk2+e9vRoxn8cbIWItWc3TS3lo8hh+mSwnvyj6hs6EJNZcA+YG
 9NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758456956; x=1759061756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AC4alj7BODy+tGg63FW+FvwgwFWTUOs8ikXVgt7Jzw=;
 b=fBdS7QjybkBrFgmGJ+UJjOi1zf+/HP31o5y6gPVvLVF27AZXF7rI9h62MVTMnESnJJ
 pJohBy6hCs/XWtOChOdi2rasD1YxEHZt9Ty2wF41WQu3WK+uDM3vncj+M29FiFTwhSw9
 84oGSDLdd4NPSBwQppR/35TMe5yGdpA7NDe8l/dW/k/3KBCITCnCnsld/I0BqGSefbry
 BLYjNWCjPFTW2k9lTIh36yFlF8uf/jpPtSEuVpJEW73PwfdLm4OC3QgY+QdsZxlN6mY7
 JBxY2uATa/JgLYEEVLHzztEcD5eQk8m1ZUe0hD4LVR0Io+/XijmL9Ovv/8yTQyg58pOa
 xMfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQT9tgbr96P9v8+V4z0rxDpPx+AXEWiiAfoBoKWD3OJLh2tojSQLXBQC6rJCj4eOyzuJ6F6Io=@lists.denx.de
X-Gm-Message-State: AOJu0YwaSvjAHvbj4SYarxxRvrcE1PqRSClAV8HQqC5LfJe0WkncXafZ
 ETMO07Bm04eVGZZB60lLiN2F3T9wbk6oFpdIfboKas2OOUb1pQaEO+vionUJgF1oa0C0BlHRN0W
 a4w65ikRqzMqBzOHueySd8m/XFb4jzSA=
X-Gm-Gg: ASbGnctV+xJzA6rDHT+3zc5cCNh+HcCvAnJyMg9zvfzYAz8djiDEz9nuC4ahYMRKqBj
 1HpUYogN9EzhD84lyojOC/ytVmb/GjamSw8h54nYHlJM9xMVlL6h1qiaFEpVtS3NEuBVfvsRVwl
 ORPHSpMPYK6CNuCd690InxvI2zPCILj4TtPQpCVrluvsV6QJO+OqaEVKU2L+aHbWTiq9Y3sEPqa
 Y2zXlOqyqbatdKcSLl1G0ABrzeRy9r6CgnetzU=
X-Google-Smtp-Source: AGHT+IFikKT1lhivZtx10Z0Ia2Ssp6r9shO+tCY7GVtRteLdfeSV5Q7jUv/gaKbFKQ/qdF9RXCU6A0qv6akX+W818LU=
X-Received: by 2002:a2e:be06:0:b0:367:6b0b:be70 with SMTP id
 38308e7fff4ca-3676b0bce83mr16875411fa.32.1758456955373; Sun, 21 Sep 2025
 05:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
 <20250901-imx94-v1-4-c85ae7cdd95c@oss.nxp.com>
 <5ce9ad71-2d24-408b-ba55-cd87bf96afb1@freeshell.de>
 <PAXPR04MB96448A9D96B04749D3E882FBE209A@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB96448A9D96B04749D3E882FBE209A@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 21 Sep 2025 09:15:43 -0300
X-Gm-Features: AS18NWC29F3yVcgJuyY0VztUUgGuBH3n270PMRQGn6DfGQP6-NjKKYxzPVM_N8E
Message-ID: <CAOMZO5CmBuOBT7snFVV_KLw_jJJ_b1-BGUk+pVAEYC6JMOFBRw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v1 4/8] imx9: scmi: Update the files under
 arch/arm/mach-imx/imx9/scmi/ to support i.MX94
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: E Shattow <e@freeshell.de>, Stefano Babic <sbabic@nabladev.com>, 
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
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

Hi Alice,

On Thu, Sep 11, 2025 at 3:42=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:

> > >  #include "../../../../../dts/upstream/src/arm64/freescale/imx95-cloc=
k.h"
> >
> > What is this? I asked and it was suggested to send a patch upstream, bu=
t they
> > said no. Ref:
...
> This line of code is unnecessary and can be deleted.

> > Again this weird include relative-global path... not good.
> >
> > I don't know what it should be, sorry. It is fragile and we should do s=
omething
> > better.
> >
>
> These files are derived from the Linux source code.

Please address E Shattow's comments and send a v2 that also contains
the imx94-evk support.

This way, we can achieve build coverage for the entire series.

Thanks
