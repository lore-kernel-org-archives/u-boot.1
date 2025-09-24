Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E6CAC5A5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 05:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2421C8362C;
	Thu, 25 Sep 2025 07:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nf+3iAhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C02F0835A2; Wed, 24 Sep 2025 18:21:19 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 313B683071
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 18:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharthseela@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b28e1b87c31so5416766b.0
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758730876; x=1759335676; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkZK9DUgmBni1FEZAUgLT9ZUc58YKHr08RU7C8KbPXQ=;
 b=Nf+3iAhnLiYhsEBxl7wIs7Zf1yAuzNW1F4y0piYDZSNTYfYMCHzDz69I+o+Ti96QOk
 2okoh1+t6z8U6REN+6EW7gsywS+vkgy2xgB153nBHoIeU1wm7ZLDx5VdW0bRzWRVqtpW
 kkSRDythhtlLHC5CEx4RQgakwP8VXcDYVg8CkzkWRbk6aQ33Awk9BITpIzRfzzSviuAE
 GzdAKaCLczCGIVvR4QmKVXEb+zPMX2AblswtTp7AZmA0WiCp+rODEBf3SbMJ7IUiHwef
 4b8qooZAjMOMMlRHcDGpDZ724Ekqj7BdMLe/v8yHG818rx+PM5nfXg/PLQIXrkNbMIdm
 8Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758730876; x=1759335676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkZK9DUgmBni1FEZAUgLT9ZUc58YKHr08RU7C8KbPXQ=;
 b=BXOLFeElluFe/n0z49lNVsnjNXxtS9Cj5hHMwmo/0X3XZIKBOv6CBxEG+bHRtWjP0+
 xo9+vrv+Dz9SMFUsNqsPt3xB6EngMNART7mnEotN2RBuiBVcfVC9b90LfF99hxZnNlNK
 P8HWj/lkwkyBNvFLodVpSL1SonpbXs3obrNQYw2zItfgeUmprjUm/DgIR9cZFexx8L7N
 1F20kCn0EElVPf9ea30xlP0A/k59NQro9czGWNVg5xUWuDsX0gUi0pRKjSpm/wPlOhfA
 cu6jEE8QUEmOR/Rvifi631mUq7Vv6PD7Vve1ZgtQHPPSab4OW8YD0flG+KeByjRIEmnU
 NN3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxkDPGexo0rAFYHCnfKUSE4A6EFkMFFkewoLd3OmCqdn2O6QidZIhQS6pfvGFwjN6/+ASNkB0=@lists.denx.de
X-Gm-Message-State: AOJu0YzOKUmDqc0DK0giXRmvmXU48SicoDJSoLkSqJDpHghCoLMhnRGW
 DueVEP2SRhUU2a/RkhKhxOQyolMX7/HYta62F+b652GBE6XUuerDkx9C56kf+8YKBj4XCha/uL3
 BsWXx4rnPrOXdnH4pUGHlB10NSiug3OgCtTvrnGo=
X-Gm-Gg: ASbGncszK//BuYNCEFio9tcRyCTu0E8aRujgSug2N1AtzdkUZeAUw+uN+aDhgUc8aHt
 H3fkJFgpL0CwPZ3myivgw79AWvOP5Z2mGtwJM/1ZUPqCnZD6NFU0Kb7exHdbg8gIqchqNpITEOg
 Hho5+NdsusoJUDMCLPywhj4Q47b0tVKDQkyHDZQ2zkU/9QFcz3yUADs7LpSNKuwepzhS0KrLaJ3
 jQ5bLS0I4BpJLG3UbI0vdoh9COgyjenuiBUBkI=
X-Google-Smtp-Source: AGHT+IFTJvr871gjmiEHQIpMYq/s853Kf2OfuKrtWWMYKWOnLmLXPrzTTk+efL9LOpHnCVxqVLErLnIlDZ5OnFtIzfg=
X-Received: by 2002:a17:907:7e88:b0:b0b:ff5d:3f4e with SMTP id
 a640c23a62f3a-b34bd645300mr34435166b.63.1758730874929; Wed, 24 Sep 2025
 09:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250903202043.285746-1-sidharthseela@gmail.com>
 <20250908055429.598536-1-sidharthseela@gmail.com>
 <20250908215825.GT124814@bill-the-cat>
 <CAJE-K+C0FHwxi4DneqqasD0D7H73BNk-ZO4GE+ZWSN=a0fdtqQ@mail.gmail.com>
 <CAJE-K+Bhk+jqYpdqLxtTYQA7bCM9i_MNrAnSM+9Pcfu838gb3w@mail.gmail.com>
 <20250910181400.GH124814@bill-the-cat>
In-Reply-To: <20250910181400.GH124814@bill-the-cat>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Wed, 24 Sep 2025 21:51:02 +0530
X-Gm-Features: AS18NWBNhKx9ZQ8oeT-CPqeIp34TKiLpvH6ihvr8I6iluqG7bCqvfJfXCRnpI7o
Message-ID: <CAJE-K+CNWsFYfUCaxwdH5Wyzusd4KFi8hjnTjKVXYGK5Jx_bRg@mail.gmail.com>
Subject: Re: [PATCH v1] doc: board: ti: am335x_evm: Add documentation
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 25 Sep 2025 07:23:22 +0200
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

On Wed, Sep 10, 2025 at 11:44=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> I've assigned it to Heinrich in patchwork and he'll review it soon.
I was hoping to get an update regarding the patch, if possible.
--=20
Thanks,
Sidharth Seela
www.realtimedesign.org
https://sidharth-458.github.io
