Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2B2C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 19:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BBAC82F33;
	Mon, 26 May 2025 21:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O9S0DHJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F76082F66; Mon, 26 May 2025 21:58:56 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB1482E67
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 21:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-601f278369bso5360395a12.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748289534; x=1748894334; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZX/R1gNflXIV2gIQLy7vJlSEWsYPsxWchBlk8tbyd4c=;
 b=O9S0DHJ6fC1UtwmwO3F+s13/sP52cZbe9WXtwlA3Fdc7lc/II8vkA9HUNa19W/raCf
 F9m9xhwF5eCUL0DBlXS/2Wt6MTV1CCsoOOnuwVUMCgmRHR1f6h76r/CnVIxrZuDPHfii
 7YFXpIbATrkXmXZ2sWKAr3p8GaLtbpWnCvESuiTbh4a7fq8EBp9KwIxlMKAbqQUKs245
 lRCfiWJp7rsMeMf8VAm+zI/at0L4nG56ulcRfH5+N3XnOBYHDrVQTQ2PrJqQoQNDZhIF
 dvo/AsLCddPafLalJ/7d05TSbKsVxniUXWQYxX79QG5lNWeHERbBmbjylOkJTgSHznlU
 zoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748289534; x=1748894334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZX/R1gNflXIV2gIQLy7vJlSEWsYPsxWchBlk8tbyd4c=;
 b=OMd97+4FgJR+wTfSgJlFaw2sYPAaDxbFnEFKIZ4xujXGWyaZq4UlHgHnCwLlKmZ/rK
 bzQy2jp+4rhYL+lQT8dvjIy5PI3BFRaH/a2bEPFTDZajBck5xbmsDKp0EI9xMLuH7igl
 1i6+5l31msEo7ZTLPIfizbOCa0e5qZy8BcaTPq7RGcQl0DjjthE1fGNFeO2DTB696rL8
 myaFNVzQe6jS3PNU5e3TiLySc0ycjtRjto30cTXgRixSblmOdtI5MOGNgDgTArsdUxUi
 /aT/yU3Pmfwzn7f1PvxAu5iluVUgBX+JJzZCy1XA0cZiaho8hIVUw7zH/cdT7Nsv3gUb
 hlNQ==
X-Gm-Message-State: AOJu0YwdpGs2kOjEZcZ6isQzaq/W9DK6ch/9Ck3vBDhF/6kjTSHuI9oE
 +LrR2c4tgA+DG6UnYcg3n4gwmzkJoJrtadtCyoCwjNmDnGs7/WGK++pVoI3z58TZXDtFGOhblEs
 2z/DDTxFhoLwQY8bMdQP+8XjXz87KYMoyGw==
X-Gm-Gg: ASbGncstNP9J0a5j2cUNwNInDo/WAXwbdMM3Ba/KIe6hJlRMr9Nbei2Ly2welJLmUxj
 D736s8F1x9cuF3i1f5a0erB7MTft7RlSWl2OhjE5Aq2rHsM9zzsMufuKY1TD1evVyPvzJ59TjR6
 DPy9kH9bcCCOHBH+3+xxqjXv5TMEx+ComZh1W+wCT2SKE80oZwgyok/P6w6rJANM1r
X-Google-Smtp-Source: AGHT+IHXy2e3Lo1hEQQaxdBwb5p8Yq7kPrWR6cm1SNq6xvWLCqunMmgkDTM+WPEPDClK2QRsrn8tlCvLVv1fPjB9tRY=
X-Received: by 2002:a05:6512:159a:b0:552:31c:d263 with SMTP id
 2adb3069b0e04-5521c9b32a5mr2533538e87.39.1748289523490; Mon, 26 May 2025
 12:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250526194811.1179530-1-michael@amarulasolutions.com>
 <20250526194811.1179530-3-michael@amarulasolutions.com>
In-Reply-To: <20250526194811.1179530-3-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 May 2025 16:58:32 -0300
X-Gm-Features: AX0GCFvUQgKlh2NXJecZNbHhgDValPcECLYEFvnoiL7ko-cIKe3ezvBC1MNhIk0
Message-ID: <CAOMZO5ARdWa2bZrg+0VnndR66yFbmAOMNaMtn6PFS1Y9b1xPOw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mtd: nand: Add support for EDO mode 1-5 to IMX6ULL
 platform
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
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

Hi Michael,

On Mon, May 26, 2025 at 4:48=E2=80=AFPM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The clock driver allows to boost the NAND performance
> controller. Make changes to let it use the new clock driver
>
> =3D> time nand read ${loadaddr} kernel
>
> NAND read: device 0 offset 0x500000, size 0x800000
>  8388608 bytes read: OK
>
> time: 0.488 seconds

Out of curiosity: what was the original read time without the clock
driver being used?
