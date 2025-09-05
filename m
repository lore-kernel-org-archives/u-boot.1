Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE07CA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 13:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481FD8382A;
	Fri,  5 Sep 2025 15:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHfsEt5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B618383A; Fri,  5 Sep 2025 15:29:22 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD90183622
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 15:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-336dd55aae1so20123381fa.1
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757078960; x=1757683760; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ApXx7rtbF88fqb2sxIz7SP+xnOVtEIArHlOxkreDArs=;
 b=jHfsEt5cHmZQQj/eK3A68L+VbUcH2s/GCqNfPAyXOWCVtEF3dAlp7SrktKDDdpK0yu
 Ar9X9JddROpc4VfFIoGnbMUCGodhHZ6+0i1CwUH03w/79vreYGwr6oLT13VMGTJla6U0
 uYlC4Bang05bGdVyrX+g10+lfnWUnHuU3sscKYebrbXFxlfSRa/Tg2+yOq0B9i+tJ8Va
 mlPIHTU9mNmFWKGwEIlk/7306sy9LJQX1ZD6CxqShCAImpZAcZPiVNhi1f7F5pw7/12s
 uHgVPTMOGe0j0SsHcl2CXiOPSqUcDmUHxot5rp6K3lLtx2HUZB2306SFf0PYkrzopTCo
 t6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757078960; x=1757683760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ApXx7rtbF88fqb2sxIz7SP+xnOVtEIArHlOxkreDArs=;
 b=qhHpQ0zka2Ue0k0y2mgFNer2VuIV5TKjeq/5oc/Sh4jM2NuAVXVZMovz5xYlwL1B6P
 m9/WUtnLp8WHOcgJ1FCXxuOgNML4JtrxKfKNS8dXvkdhBW0+fP7F4w8j9HdftNah8aeu
 Mxg9lRrF7GYk5rGWhIpXmVXMXQXwNUKBeLFy/G4Mety30vsEYeKvJsA3eTcUEwpfiqNm
 qoMHYw1FBKckmvZCMqbXmarCFQsZXEmxwHiHt3VxcB4AkphS7F8cq+IsgJcKEWO1amUW
 AqStNUjSifMUcHCODyGGkhFW7Yprg2dtPaO2vyZr4lk1yJDcha7eohBOeckHM28WMaRo
 hZ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrgSp50aaNTKoS45vfA6la0sHrEf2jlT7+gVP28hudAvI5efwXjPMUAeo4no90zEry3mVemL0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywyhj+p/Jn+IPuwP2O5fhtJo7HL5RPYCPQtYyuBWfjy9OxnJXbY
 LYKMdre+nyZOVLbdnEygcuygl3xkde/L5HSH2iX/ge22/c0FEhrHm8ZJGfB3LQtfLXPLrYdLU0S
 ME0gsdfqC2Bfc9I7X37GfQvh6ruvbuBo=
X-Gm-Gg: ASbGncvDCqr2cxfxp4xy6ctgiX1s/kKReh6iXam/evnuDvl248BALqRWNHgtxEZy1zD
 b6hoGJKsiNIAafLqJwP1qGoKR+ww5qopfedggd7X0XbpibWA+NJaQDvxaNdGLxrgedTgi6xtIlf
 aVjOui3tLXqXIjMi7mqJm1h5TsBeA07hWRxR+rRmPTLDbLbpUnofG6gnPOZAHmP9J4xEg5bU3f4
 EFJu7NBD4pMcmqBxzDcQG4kll+w8zJqCqN6T6c=
X-Google-Smtp-Source: AGHT+IE2TzTyNkz2+tWAROvZ/OpRD/G6fMGImivoDTC32zw2E4hs1oHSmCYj4/3hxdF9GjkRFNYt4q/McvsQRQ7mGus=
X-Received: by 2002:a2e:a590:0:b0:336:e32f:7a4d with SMTP id
 38308e7fff4ca-336e32f8084mr58717271fa.5.1757078959736; Fri, 05 Sep 2025
 06:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250821064614.2644332-1-primoz.fiser@norik.com>
In-Reply-To: <20250821064614.2644332-1-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Sep 2025 10:29:08 -0300
X-Gm-Features: Ac12FXyF06vZlhfKJBkOterYcxMSGkZs2-4_yKA5Q9Kh3OjiOLCMtP-wI6lVMa4
Message-ID: <CAOMZO5AF=jfD-sFhnkJ3+D87Zy4wAThZ5HmPew+zpbtQ7BSiXw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx93-phyboard-segin-u-boot: Clean-up already
 upstream nodes
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 uboot-imx@nxp.com, u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Thu, Aug 21, 2025 at 3:46=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:
>
> Clean-up "imx93-phyboard-segin-u-boot.dtsi" internal device-tree from
> nodes already part of the upstream device-tree since commit 79f3e77133bd
> ("Subtree merge tag 'v6.16-dts' of dts repo [1] into dts/upstream"). No
> functional change is made with this commit.
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied to next, thanks.
