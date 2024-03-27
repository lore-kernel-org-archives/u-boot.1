Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583C6C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A820C880AA;
	Wed, 27 Mar 2024 15:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHNUEMIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D9A880B5; Wed, 27 Mar 2024 15:13:59 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A46AD880AA
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so1268702a12.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711548836; x=1712153636; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCv3jezk/fqYkY5SpFOABJ5UUc1jKQaMQwk80sstY2I=;
 b=kHNUEMIGqXpZe1wF4HnbdHUo40KlWsJZNskmLYWG6U+xcPSOX1fJ0VJu1WphTapcli
 qvq7lg+VoVnBrHBqRe6Xdr+AS7M6KY+7ZfMkyRYs4OwSiBUNwfS+JSCDoNV4Wtaxj49j
 +8ZAwaH3PTf/071GTKYSj3zpVCVQRrj+P4dkMWklWGOxkP8yuttj3ELDYK9UPfkl9b/h
 W5GuQ4kpsKxydXTQFHjQWrY/nhXFJrNKwmfXrcjrxWkJld644xmkEdr55yOqYGKr1ZNK
 /6ulsNE9D3TncPAVE3RCRMoFbkUCv3yAZOV6kzItp4E8M1GWSkebYqvSmwKCq2uIrd7s
 YCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711548836; x=1712153636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCv3jezk/fqYkY5SpFOABJ5UUc1jKQaMQwk80sstY2I=;
 b=s5Z3uvQU8eyHpdMGvlxmMZrPNERYWdJQCDN+INVu1XiUChcTgQO1e+nUX2Sxhv0/dK
 mkVEkUZ0QF9R0fjTVwpjmrRwY3Ez+2Bx/maL2iP1aCIGEISxCbbuyuSbUF5h8RVJySYQ
 0D2P5zXLkvgM4wo1d6r5zeF+P1mW+vc6PE4mfth0sYLhEqwwyc95nzamRMRXSLBrz8Np
 93M6XPlYGN7z4vK+dOl4A3D6yudp1kTXu/saUCcJn1HhavPtAvs6OyGtG+wzLkMoY9Dl
 Gv5d3u7rNqfOKCAnrrd2INaSDyD8n25ODZCW7UV5SGlx64YmJBZr2eJiBDSV5NeIMp2X
 J6pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZLsUUnpOgx2r5PCY0iTLr/MWI2vWcGz73v11ttpl35jzkkV7LOZD5M/pA22ODqq/1FYscIfGywHzv8OB2KN1WrV0T1Q==
X-Gm-Message-State: AOJu0Ywws0oeIKGteXuRZhDVB62rWraAXK2akh5118YrbCtPzDk4YL6X
 paDKXBfhN+LmUQL8CHsFpYlVAr+chVdMU7f84q1Tl3UArPAWw0v11hD7Cg3ZINghCeznQZXt/h+
 t1s4Po031C2FiiHS/1E3DUGiYUtY=
X-Google-Smtp-Source: AGHT+IF1Ez5K+X0PpJw4Nie4l2y+7Pe9Dpx9K6kWgafx6MVSK2oum1D/lWjHaR8Y6BM+C8iU88ha3FczB18aRLgXNek=
X-Received: by 2002:a17:90a:a00d:b0:2a0:30b9:d57a with SMTP id
 q13-20020a17090aa00d00b002a030b9d57amr11575307pjp.2.1711548836102; Wed, 27
 Mar 2024 07:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
 <20240327-imx93-of-v1-5-afab6b31422a@nxp.com>
 <CAFA6WYPb9wg128rYu_76d1vh2q47TfRgkF1e3LOaJfGMpGEaQg@mail.gmail.com>
 <DU0PR04MB94178343791A449EEEB4811788342@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAFA6WYMn=Ndq0S7TJbFe=yDBG7RkL9OZA_JXj9Cm5TVEKWF5uw@mail.gmail.com>
In-Reply-To: <CAFA6WYMn=Ndq0S7TJbFe=yDBG7RkL9OZA_JXj9Cm5TVEKWF5uw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Mar 2024 11:13:45 -0300
Message-ID: <CAOMZO5DjtaAaLOqJsavO8sPXYDk9FTSVmt5mO8k+WMEW1bU5nA@mail.gmail.com>
Subject: Re: [PATCH 5/6] Makefile: tune the include order
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
 Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Peng,

On Wed, Mar 27, 2024 at 11:07=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:

> That's the real reason why we should try to migrate to OF_UPSTREAM at
> SoC level rather than at board level. If a particular board isn't
> supported upstream then they can opt out for the time being.

All the imx93 boards in U-Boot are supported by the upstream kernel, so, ye=
s,
please migrate all of them to  OF_UPSTREAM.
