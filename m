Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0501C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 18:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2133D82A31;
	Wed,  9 Apr 2025 20:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="akIO2rwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C455C838DD; Wed,  9 Apr 2025 20:26:11 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C752482A0D
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 20:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5499c5d9691so7958402e87.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744223169; x=1744827969; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfxHkYbUg0l+5XbHwSxVPnpi2aZIlxDAPnP65Exj28U=;
 b=akIO2rwObgF5wzX1T0v9HH4lMXWC/oGI28ZfOQ0xOJxo2l8ZJyitNrVBYkzH1298iP
 U6Np9i2WX7+z0rbEov8oRvOZu6lgScd5J2bb0m28pN4XmaDXh8n2bRkKzqOgaYrIokqp
 1+BqWSb8KKmoVzSlOp1/rINBrDoYsPMPHUov8P5s6xOslY/ijDUpwugDqtcTtYUziddG
 ukigu9kGkgwCCjXVA+w9Ad99zv7+7pZAZYKPByUfIvX629qvrlB0gCrXPLUCdni9ZwE+
 2V74/UrwhSWLt4k0YOwfFiD21daqCazb21jYdi3Wi+TYNo/rTTQ8bwQEHei27TSd/8mw
 4vTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744223169; x=1744827969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfxHkYbUg0l+5XbHwSxVPnpi2aZIlxDAPnP65Exj28U=;
 b=ZaUgjcsJALtlHefg9AmjZ4yMApNNXNe+fdk1P6a13OJ7Y4Sbvjc0Rz3XR4ZSnRzlFl
 3WeE1lc0wuas/V72W82Y+VFu/zLLQk1cQTHRrLh94wfWJcPnbTdKujIfZ2RyNTKK2gF9
 F0Lcg/bY9rQkeCbdwv1/bK500EkdRw+cGQJ7u7R0L6rX4zxiH0QxXz8kdyMb72B1sxJi
 QfHUyjDcC86h35xKEuns6tcHt4MQEdawoQK5t3m0ebwZ1m8mOQGvx/b2340WqMb6e6sA
 2gI4/j3oqv3wZB/VrLKzKyFPBM3SvJ80YhbpVsZOLQWn/cZ/XuroxPhS7No8vcdOcwDR
 SWmQ==
X-Gm-Message-State: AOJu0Yzi9fCkVEFGhlVaMzCQw+WtYbFGyNOQP9p0cmz7yds06C5EmbWe
 gwn3EcDbSW18Z7TMCru5jFgulqJTPxZe8JZUivpTZBHOZQxhCPxErhtJ7MMFeDbSxgOEtKcFkTq
 QT7sE+ccNGvr+jFXpxLwu9ngCUs0=
X-Gm-Gg: ASbGncva6V+Xc6TzOB9YRtQe/ybpWpPN4I7dTRNt3/cX2H5erIu5TmoZc8zPXdOldlv
 acuxIn/Mfge8Nibu6ri27l/fwuwITXlaqXoGoRvAoYBkGI+LJIkFTS+b45bv47CQN3Ct6HgttjS
 g4HSjeKqrJCmqqJR/8T1vRC1alJTTqlnGDXxiJSpvXb8TBBy5AsMe6cnx92LhSLNcC
X-Google-Smtp-Source: AGHT+IEU+AeGlEDR0wLEBAw6YPA0eXGRerMWypnndOXsrERN077J+B+CYqpXneutkldscRmdPaGpNTZ31JCaQfpUpgE=
X-Received: by 2002:a05:6512:3e03:b0:54a:c514:76f0 with SMTP id
 2adb3069b0e04-54c444d90b4mr1193390e87.14.1744223168920; Wed, 09 Apr 2025
 11:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250409180833.3812679-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20250409180833.3812679-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 9 Apr 2025 15:25:57 -0300
X-Gm-Features: ATxdqUHqUEbC6gV1-T4v06IT8kzaupfgiPny3eDUJ0cZZtIb4pVcBlF9NV0ahIw
Message-ID: <CAOMZO5Du6NLbu3Bx6EWMvSBMuGBfDd=-PNzqWk__xK_aq0wM_g@mail.gmail.com>
Subject: Re: [PATCH v2] common: Add CONFIG_SKIP_RELOCATE
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Richard Weinberger <richard@nod.at>, 
 Caleb Connolly <caleb.connolly@linaro.org>
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

On Wed, Apr 9, 2025 at 3:17=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.com=
> wrote:
>
> Add a check for CONFIG_SKIP_RELOCATE in reserve_uboot to skip the
> relocation of the U-Boot image.
> CONFIG_SKIP_RELOCATE skips relocation of U-Boot to the end of RAM
> allowing for systems that have extremely limited RAM to run U-Boot.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
