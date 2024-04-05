Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733F9C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 16:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC79F884A0;
	Fri,  5 Apr 2024 18:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hCvunlw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3BA884B1; Fri,  5 Apr 2024 18:47:12 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7532883E0
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 18:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2a2fbbd6cd6so335407a91.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 09:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712335629; x=1712940429; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BMoFFnC+TpaoltojlNDSFtVDhjHmB+MnxD/8vTc/QA=;
 b=hCvunlw58+lTa7B3Idja6JKu9OiIdWv9G2A9loRhukOkwf86r0jV71WlEA874aVHyq
 3gEh0fJc2AnCYGEO4nb+ckMBtnkdKp+6pmH9fFAgFpL2F+WkCckcz2pkrVaA1wn7ZcKm
 8MzrPiUzzoirrIrSpA/FI8PhhrzgrZTzfw0iz8qfC91AVksaEwQFkzzTeXjS1by9CvIO
 gOSKBn2pVVE700XXQceEGljoS6Suud5aiXxr6vwFFBqhMGUrtZgVL4dL4SXhXNk5D7AQ
 1yqMDwrnaSwTKmc7/Au1K0yuf2CO1Yjnu0yAvG4Ib171DmdbdwNEmQan3Z4o5ZyL+aHt
 z2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712335629; x=1712940429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BMoFFnC+TpaoltojlNDSFtVDhjHmB+MnxD/8vTc/QA=;
 b=Y2O3Ct5L2LWDGP0gWflRbpZLsgfNOc6S4l+DIT25HGEwn4R2to+VF9mL1DaImqd51K
 zGQzDIVtacdDXYRKssljCBxlN6HVu1k320w7Xz+uNyk5J4odythFOHPS08OSbPnKc3nB
 8SUYJiOcD0iAn/p7p2k6tryNsqSp7LKEWooXJtJVjjLDYDeEoCFDe/sk+RJGjXF8hbbi
 frvEdGhc12ZY8vYMCtxFOWNM/KF0DkrA0qJZObSHiXpLRwqmCQxdWnzY73DihDOpbJkK
 F6jgI/BQ8jWYQn8KcjMnI36OaF/q0/B8guLyJp97zEcIq9aJQTPOdGuW+gXTRCosGvWD
 0wHg==
X-Gm-Message-State: AOJu0Yw0arYYzcKKHznZQ6i//dPGabYKcGtK7n6VPlrcwP911zeF8fUb
 QtlYwmI9JH0sAH3cWOznc6EMzAzU9FFprtURU6kYIXhyCha+FuBm3DQ27g9QO0D/C6PjP1oJTK7
 +UhtwVTwxmw6PX4hlV2r9DI3s1cE=
X-Google-Smtp-Source: AGHT+IEpw+tMVTbfOeRnqqMytdbNLZCPhvdug29tEIAw6YNBRwbfRoXwD8SOTYOmFto/GYX5PNH0Gwr5tukw5iw5EcU=
X-Received: by 2002:a17:90b:244:b0:2a2:666f:966d with SMTP id
 fz4-20020a17090b024400b002a2666f966dmr1911082pjb.1.1712335629093; Fri, 05 Apr
 2024 09:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240312211628.32842-1-marex@denx.de>
In-Reply-To: <20240312211628.32842-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2024 13:46:56 -0300
Message-ID: <CAOMZO5CBpkCiFRvO-1Ome5BqQhyyxJPDx_uCmUJPpyguB2R6KQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: stm32: Test whether ethernet node is enabled
 before reading MAC EEPROM on DHSOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
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

On Tue, Mar 12, 2024 at 6:16=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Check whether the ethernet interface is enabled at all before reading
> MAC EEPROM. As a cost saving measure, it can happen that the MAC EEPROM
> is not populated on SoMs which do not use ethernet.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
