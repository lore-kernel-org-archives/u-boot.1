Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14C3D2A53D
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 342B888CFB;
	Wed, 16 Oct 2024 20:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aFhS+aUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2157D88E00; Wed, 16 Oct 2024 20:34:51 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F2D88C4A
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539f84907caso146901e87.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729103688; x=1729708488; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ezQMR3wekHs/lxqh3awYC0oJ1dIQOD2g20n//Rzajo=;
 b=aFhS+aUV3lc0KyxfVfRfVWs8DYziL6pAfIZ5wMBTgbGjpNexM7ly12zVoQwdwrq/rd
 8FFfxr/88rD2domWARMrGwlk9dwRqyhG9uhwtE29tyo77yMEh11Q18OXc6KDKCfJRS5v
 L/vc4I2t5A7Ab2p8IJcVmBjD/xM2Na3WYl/FIpkKTB+4Oa9icNdXj0kNXyGfp2N7RACn
 aq59BdeUpGmuhosKj7c/mjltH/LT/SEnLy9Npji5gA5Mxo+CBblUPTiFbmYfdYw6qgOH
 cgHBNm6o8qsbEOHmd9H80FSb2uMyhhKK9gQqRdfkwhawsbj9mVesVTD70JWguzPLhPd9
 GvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729103688; x=1729708488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ezQMR3wekHs/lxqh3awYC0oJ1dIQOD2g20n//Rzajo=;
 b=mtrcMSTDr1GtQKW6ixJn+RG2E+ORBRR8nv6cWCBOKTCr50O9sqzURxTfTS6c7k/kdx
 jOv1G5BoS4KddEo+Ih8xDENT6cz7L79bo5cw0RVA1CuW71M+WAFQ1UfKjsww/Zvd9WG6
 uN7U+5xZ0uKb450V9Bclvz8JYgHrjCs7cNq6EXf0C1fZ5iXOfqx3ENGLsfH2ldW5HEA5
 DIXfWXvRp0FHWLzmVAddIhietyPg7zCCLnMAOy2u+05XNO+58PQBPE1CIHf4Xk8PaiON
 a98RucyKrpqgXmnigJjLCz84dcs2qerydfhWFisarBp+lON7Shvr0q1sYbXQReyksGXG
 obKw==
X-Gm-Message-State: AOJu0YxS0aeHVVgwuWwCo0JVCahNlPXBr6My1fHjfSKKIkq3D6fVZ1k8
 UtNfeEoPcUZs0Dr8rmxWjgO/13hEdwPoe8zbPfZZnkqvm0shZ4pkNv46WxNBOQTOVeQ9oN8Nk4a
 hbA/HAa5cmotNaZq+9qtExEPZ/eU=
X-Google-Smtp-Source: AGHT+IGR1BfxS+ud9z7Y8Z5VOord/xRNx8yjxu+upQK7rBLG0KaooJLm0vRTVKDCMiXYgIzHNfnQu7jes87s/3HKut0=
X-Received: by 2002:a05:6512:3985:b0:539:e65a:8a7c with SMTP id
 2adb3069b0e04-53a03f8a55dmr3489269e87.58.1729103688342; Wed, 16 Oct 2024
 11:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241007120002.25690-1-marex@denx.de>
 <CAOMZO5BX3EvcGAJjKNt-vX9+9se9nzmf19_-4f4gfS59C9Q8Sg@mail.gmail.com>
 <d87b9fc8-5bdb-4e16-a219-51d05230bc80@denx.de>
In-Reply-To: <d87b9fc8-5bdb-4e16-a219-51d05230bc80@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Oct 2024 15:34:37 -0300
Message-ID: <CAOMZO5CGjRXC8kqq8FhDW133Eiw0319we+D9rgjvrs14DMYk-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Lothar Rubusch <l.rubusch@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
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

On Tue, Oct 15, 2024 at 5:22=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> This should now apply on u-boot/master .

Thanks for the heads up. This will be part of my next PR to Tom.
