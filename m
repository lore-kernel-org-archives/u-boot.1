Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C50C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 19:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF168809B;
	Wed, 27 Mar 2024 20:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fCa+Hb92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B0E88044; Wed, 27 Mar 2024 20:29:34 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A778809B
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 20:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29df844539bso51230a91.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711567771; x=1712172571; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCaR+c95Qo/SmHavfYJJKKCnW5U4einxcqTLd7MVReo=;
 b=fCa+Hb924AnYD7HN0ioZPeHUEcFlNPHzu3IIPV6FKVAYOfREL8dj7bS9tc/WSL3y0w
 DY+H4+8MAJi4p7EuHLNcZE1pM+m5+MZF/owenPNk2zpIvyJi9zfUPAGb8yh10fBmw/LB
 yRHy34p69vT4Zbhrk3dPnP1F5lNFh2QxvEsG+Mchb7zP1HZq46PVP+4Tj81lXX2EQkqH
 y0mn1G3c2e4u63z9PMDNIyCIYmGSnTlkCTkhAJ1r/RTMDCDdSxofvw3Fhsvo68KJcxcc
 oNYy/FrQQE397FR3oVIk+FHcCJEQN/kuSMAqjzj/K6NaJtSfDpsZabydUrK2Bnj4bxf1
 8Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711567771; x=1712172571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cCaR+c95Qo/SmHavfYJJKKCnW5U4einxcqTLd7MVReo=;
 b=GAxNYKDsh7kYQe3lin0ENZQXSsvDEcDfXzkbWp7FG+8Zd1ytojTItvGmSRf3SZYs3x
 hJ2Uhap+hGnDyMkqzwJ19EfPEBS0Xoqu3huyJqjG5RJo3dlA/rv11IyTiYpTwNW/XnbD
 IsST10bvpGbqtVXr3HJAkmGImMRjxGsC8yFd+V/scVVcSubGlQB1TkvBPSPZwSI2e96c
 ZnJWp/XJiHS1kiqkN2jpR4wXflmIDodVspZOZiDBHFhERnQ0fwOMrPnEFY5tn/wndmjs
 X3CmJ8gK6+2pLihCFpONbwptVnXS5JT9GSnEYLRjbyRvUcTC5t2FiDChFjDE+/ZG//TK
 hXPA==
X-Gm-Message-State: AOJu0YxFbRac/HRgoLMA22iNCgzeXbuu6f2TbOkukXJ3mpFROkVSY+yC
 bLXQnPIRga1UyKPCV28U75RMXd2bggNmGq28fgbb69w1mwcoSS68+umZK+fRLL3yrTvJsM1SNVQ
 abBK7J9iR3HspcvduNnlvgtO2UB4Yn6cTLr0=
X-Google-Smtp-Source: AGHT+IGEPFbYC5fphkHL2fktMsJ4YNgA0ooVP2s4EZm6B/3qfYn1B9bXgvsGId+3T78F5eu7av5ORD8BnauL7mLoljo=
X-Received: by 2002:a17:90b:4a43:b0:2a0:350a:a7a8 with SMTP id
 lb3-20020a17090b4a4300b002a0350aa7a8mr575730pjb.2.1711567770989; Wed, 27 Mar
 2024 12:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220728070540.28554-1-josua@solid-run.com>
 <CA+EmdG5+QYxVo27C-u5W6FkuDgcoey4i-md9L4b9cs1gtsv+1g@mail.gmail.com>
 <30c35e80-2015-4fac-b9dc-6902cc09c58e@solid-run.com>
In-Reply-To: <30c35e80-2015-4fac-b9dc-6902cc09c58e@solid-run.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Mar 2024 16:29:20 -0300
Message-ID: <CAOMZO5AQArxRN25J0+M1hjNSwBQUoLsGhD9cChDkfUrv3ys=Rw@mail.gmail.com>
Subject: Re: [PATCH] mx6cuboxi: fix ethernet after synchronise device-tree
To: Josua Mayer <josua@solid-run.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Baruch Siach <baruch@tkos.co.il>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>
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

Hi Christian,

On Wed, Mar 27, 2024 at 9:06=E2=80=AFAM Josua Mayer <josua@solid-run.com> w=
rote:
>
> Cc: christian.gmeiner@gmail.com
>
> Hi Christian,
>
> please take a look at this patch, I suspect it will (hack-)fix your
> ethernet issue.
>
> Unfortunately I had no time to revisit this yet and implement a correct s=
olution.

> >      arch/arm/dts/imx6qdl-sr-som.dtsi     | 30 +++++++++---------------=
----
> >      board/solidrun/mx6cuboxi/mx6cuboxi.c |  6 +++++-
> >      2 files changed, 14 insertions(+), 22 deletions(-)
> >
> >     diff --git a/arch/arm/dts/imx6qdl-sr-som.dtsi b/arch/arm/dts/imx6qd=
l-sr-som.dtsi
> >     index ce543e325c..2d7cbc26b3 100644
> >     ---_a/arch/arm/dts/imx6qdl-sr-som.dtsi
> >     +++ b/arch/arm/dts/imx6qdl-sr-som.dtsi

Please make these changes in a new imx6qdl-sr-som-u-boot.dtsi file instead.

This way, the changes will not get lost after a new sync with Linux or
if OF_UPSTREAM is used.
