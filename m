Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699A0C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 19:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C502D86F80;
	Mon,  5 Feb 2024 20:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dHxbByE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03E2D87C31; Mon,  5 Feb 2024 20:22:53 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1991587944
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 20:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so1643533a12.0
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 11:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707160968; x=1707765768; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yes/q1YghRIWpwkr8bDLtZsDbIH00q/oPBGYm9uATGQ=;
 b=dHxbByE6I6WqUmXgUfzbuma0NpbjwQF/EZ9O05E0aHzNjBUv7ob5u6I2dYccZyF+dK
 MSVJPPT5JBEovLLhM06gQ6VaGS52oYVwP/LgClAVBQ27eraG3v645OazWlV8km17YGC+
 eAL55H9U+k83Qv1dHU3V3X0/wKVQ5s2xISMvQbrLC+WVOjoil4W9o2eWQ2yppxH21lzL
 +m5nsi0Hce7pZYZylhB5+SOeMj8h1m2tR2gwWf9DVyzyEhzU3q5PWVT4YmHHS6h64t4B
 d0CtFVXAvRo6FAXAFwwgOe9+6TJYu704PNlUghwzMPzZNF7H8GoCw4GMC6T5dr2/wwtL
 lCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707160968; x=1707765768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yes/q1YghRIWpwkr8bDLtZsDbIH00q/oPBGYm9uATGQ=;
 b=hQ9cwzmYP+PW9lLr1ajNiIpC3+Cjhhn7Rd7zvPWlq1UFRM3D6mE2o/Ultii2hQr7q4
 8dhmCXzLXizXP7BxDh/nnUgk8NEANkaQ0HFWlb2mX9wrWQTUcmVGDAOcbZ7eEBtuXChI
 fp3fsPJXAMwqNS1+2cJJA8mV6xZIww/mn9L1myTforg6pT9qEcUgxT9eyZmIzEBoODXn
 3RmuZHrJL1P34A9Uv8q5mqIml5eOvJ7/aV22SQvK8516Wz2EmVgHorZFsdTzYUK+wHR3
 dHAUNPIep1+tSsRf6Dmd9OS3/ubxtVioDEGXGlZwOupg0y2INc+NWE0OPd92SrVjSJ6h
 hxdQ==
X-Gm-Message-State: AOJu0YyVo9j+0Z4qVyZfWufy7eFxs2Sb0euWIoDMmYkPqN7Q9MVLmktG
 kPR2WnyxSe641AXd+a3kvYrzHUI2orhPAIp7AuTdQ6pkEZZFM40Zpl/xpB5rRjQGhabvRkFlC1C
 GdDpRtXOpPMe2oIkR9k5LodqdRrWiMbz8zLI=
X-Google-Smtp-Source: AGHT+IF/NZstcqPOZ06YhQga8bLWwK+ANr/hLPSx/o5AS7si4dd7pGZZQgECJaq11ph9FNBjbzEEi95pThBbxv3CaBw=
X-Received: by 2002:a17:90b:17d0:b0:295:cfd1:a861 with SMTP id
 me16-20020a17090b17d000b00295cfd1a861mr374333pjb.4.1707160968252; Mon, 05 Feb
 2024 11:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20240205190858.3076363-1-tharvey@gateworks.com>
In-Reply-To: <20240205190858.3076363-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Feb 2024 16:22:36 -0300
Message-ID: <CAOMZO5CmMDhHKndFbbKsR8e82ShXnSz95yE2nPXqQog_2CpE_Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] update venice dts
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

Hi Tim,

On Mon, Feb 5, 2024 at 4:09=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> This series brings some recent upstream Linux dt updates into U-Boot for
> the Gateworks Venice family.

Please specify what "some recent upstream Linux dt" means.

Is it 6.8-rc, linux-next, or Shawn's tree?

Can't you instead sync the imx8mm-venice DTs in U-Boot with this kernel tre=
e?

> Tim Harvey (5):
>   arm: dts: imx8mm-venice-gw7901: add digital I/O direction control GPIO'=
s
>   arm: dts: imx8mm-venice-gw7901: add TPM device
>   arm: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
>   arm: dts: imx8mm-venice-gw71xx: add TPM device
>   arm: dts: imx8mp-venice-gw71xx: add TPM device
>
>  .../dts/imx8mm-venice-gw71xx-0x-u-boot.dtsi   |  7 ++++
>  arch/arm/dts/imx8mm-venice-gw71xx.dtsi        | 40 +++++++++----------
>  arch/arm/dts/imx8mm-venice-gw7901-u-boot.dtsi | 14 +++++++

Why is u-boot.dtsi being touched? Please add a justification.

>  arch/arm/dts/imx8mm-venice-gw7901.dts         | 14 ++++++-
>  .../dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi   |  9 +++++

Same here.
