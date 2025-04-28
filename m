Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D203C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 16:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D248091A;
	Mon, 28 Apr 2025 18:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eBZn+xOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9471981F4D; Mon, 28 Apr 2025 18:12:52 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6BB8056A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 18:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-549b116321aso6104886e87.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856770; x=1746461570; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ob+UJPNQKH/bdY3MWn/x+eVo0xWB36xgrvq1/Lwyj3U=;
 b=eBZn+xOezjdODQOCLCl4SUyjQUefpXP7FdGMocoICjLa7OKgv97Xt8/A2U9NL2LqkN
 r0dIsNvvhC4Ty51qkOXmcy6PkeulZWrmFkAE3l2FOn73+786x69Z+LAIPn/7NKjmn99T
 YdEAgU1MXhEBV469wLDCj8e5uripzg6ZioJUGOVUbWM+IYNHb+26k7RMiy6KsI99A2aV
 4JAduv1UwojE7+iKD5iUBci2gcn39SeJe7eehBMkSkDNyHHD3pOQ8bxTBUd6uh9GzV6w
 HklKbm3bDVfGjDrZV1OTgZgvYa98RSqzJlRhFWI6fzmcwgmovn6KzzONcEPrxE19aB2n
 /d/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856770; x=1746461570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ob+UJPNQKH/bdY3MWn/x+eVo0xWB36xgrvq1/Lwyj3U=;
 b=bVsxHLHSVl6Vi+CQtCPIOAJkd+R7oodLXeM1NHd6QSvYbDqvtbjkcDaGYXRtDhjMs9
 nT5sx3Bkor3BRPe1qqwnCyyQxcfGpPmYEhIU2KA+jBQ6PiXbvXQI+J/FsinThmJO0w/N
 +zOE8t+Q9qfdqJEPfumooiTtb9Dh8X9LitxdYSERl3wxBiuDLIdLrprhpfO59N+xfLLy
 K09xD2A7DBzy3GUSG61e6BkNVgArXBYw+meMY4cRzMHjq2q6XT9qRqWqNxqxHAFJH5td
 ESmSOmnQzbq30aTk9o00kQpA1OWxop8EYUuN83tX9nP5X0xVuCZH+3GTKcU1Z4gLKyhU
 Fphw==
X-Gm-Message-State: AOJu0Yx8DIT+5itbd4VRTW8TCT8M5ehFGLA/K+U+mvCGOsq9J3rUjgN6
 kdGQUboN7E65dgmRnrZgW/OdvyKQfbyiG3iqTWQaBqZTSFbVXjB+uVj4p12sPPNJ4Rwpzets8eP
 ESnx32vTR2IFYLsUlvs0TUISKIxfhRA==
X-Gm-Gg: ASbGncuMypOBMDZN2Yc+mT2gf93D5s9iKrMWk0fO3S4MYcBHmmCw0HE8iKiOOvO+N7b
 gZoaY8Y6SE3vNEQC6WmoJoINtyYXD6LSrwDgXBRohqWd+8x89dFty/RdUA9wGJPN+OFnscoZrmN
 ZJdXcIlrzyEwquV9T2GOa5j+lsAmEKMQw8XOdnXSx/1qJprt22RmEsKA==
X-Google-Smtp-Source: AGHT+IGd92fUc+f4XVOW4lI8Rnh2tfqtbJmfusqqaVzzIttiTScEYpyHIq67RUAK/RTmCu2yIOd7DyO+8IUrZtcBs2g=
X-Received: by 2002:a05:6512:3502:b0:54e:8160:d316 with SMTP id
 2adb3069b0e04-54e90008351mr3119450e87.40.1745856769701; Mon, 28 Apr 2025
 09:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250413110118.1027383-1-sbabic@nabladev.com>
In-Reply-To: <20250413110118.1027383-1-sbabic@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 13:12:38 -0300
X-Gm-Features: ATxdqUHnMRuL2N8_J1wighZr-CzptjiiYOfb-BtRWfCGVXLaSpqwLI23Jq5pJNM
Message-ID: <CAOMZO5CHR=a8rcLatGJL_CcrPW7BHd38Vqtrc0wzrDz-rK8R+w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update email of Stefano Babic
To: Stefano Babic <sbabic@nabladev.com>
Cc: u-boot@lists.denx.de
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

On Sun, Apr 13, 2025 at 10:47=E2=80=AFAM Stefano Babic <sbabic@nabladev.com=
> wrote:
>
> Replace my old e-mail with the current one to get still involved in the
> project.
>
> Signed-off-by: Stefano Babic <sbabic@nabladev.com>

Applied, thanks.
