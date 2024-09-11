Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C01EE57CF
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 19:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C91AC88AB2;
	Wed, 11 Sep 2024 21:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E4AGMNI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC9F88ABF; Wed, 11 Sep 2024 21:50:33 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E23D8880F
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 21:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5365cf5de24so230404e87.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726084231; x=1726689031; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQtBfS5UbfOMT1fsOjo0GXO2inuxVvWaSsb+EAntqCU=;
 b=E4AGMNI0zHTqeNOaSUCLVqYLB6zWePpKMMc5L3E7EaK1pZevl4ztwBxP5Rv79Z68R+
 RFh8vQeJ//nvjXJJIm7ABks0MY3nhCIsxQnv1oSbEispw+qaC3bJyIms8UEpd8pqqY4M
 edouaSruEl9PtRBE5n34MkhKshWAqosoTza+68JCAdAFj2o6MijPoRTxQLrGBLc0K4jl
 Jz5+bKMDUZqu5KvQK813z1DLf3ikb51CUn908FbDAz4Vc/QSfTyve5lzrozbqdZP2kmw
 xuOTEmhjWdASogT39EooJtTlpS7DcolxZROZEOyXP8/dwJmApEotxxpQ4zkTNxB7wxbe
 wBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726084231; x=1726689031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQtBfS5UbfOMT1fsOjo0GXO2inuxVvWaSsb+EAntqCU=;
 b=WQT1nDyti/s+XlheZAheCXGfaedYoPZwWJpUWqEowtTNCUcL24eE3xmbUQ1eTlJ2SU
 K3NcNwnb9PhoSL8Pm85jk0Ocw0bumpbtZCyXu454LaSyHIAccufs6pgu2itajkJ4iiWb
 OjWAbtKm/h95ZlsA0BszRMppoztEvJp6zmbx3aDBeou8QPG8/36HWdYm1JMysACVN0rs
 b5mM0eJ03wHlqahtkHNz3RTQxkX3PZFe2HZoIVPsMcAjJorLrw3DcSkV97EJ1cSnOXW0
 LAGE109vZ4mfCrVVhqsDMokys3RVqGoVBEJP8TXfJm95yciMbhBpqjou3ZY1P8Dc2auW
 4tgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbYK3IxAFAmqHr41zXYM0MqyG35gN5e8YMN1rcSMibjuKhCwMWhQ14PQm5EbBPeXoO7akPw0w=@lists.denx.de
X-Gm-Message-State: AOJu0YwDbzpyOHk9P8vsDMSI6xkh1gHWstx8Ic2diO5P/wo/Tm455Pg2
 jE8SCcr61qw5roD24JB1ShDecdH/7nVwigO6oy0CW/5wILc0CjDLSrlQVg9vpbQ7zYVfC9qVORe
 +fY6ZPluo23ZJsg8mqCV4ViOoww+HBbZu
X-Google-Smtp-Source: AGHT+IFatR6D2Y4vmkjwBj4KaFC7loKe57I0tPAQXPl2+TxUgiQu/a8gAn/ngKDkgq+WNQxbaBRizq3VnqqoAJdeA/o=
X-Received: by 2002:a05:6512:39ca:b0:535:6033:265f with SMTP id
 2adb3069b0e04-53678fec444mr296000e87.58.1726084230268; Wed, 11 Sep 2024
 12:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
In-Reply-To: <20240910101344.110633-1-miquel.raynal@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Sep 2024 16:50:19 -0300
Message-ID: <CAOMZO5Cq7CEDgkDLAgh0SbARB-hNLpPPyXQBnmKf2hYnZDoi8w@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add imx8mp video support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

Hi Miquel,

Thanks for the series.

On Tue, Sep 10, 2024 at 7:21=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:

> Miquel Raynal (8):
>   dm: core: Add a helper to retrieve devices through graph endpoints
>   clk: Ensure the parent clocks are enabled while reparenting
>   clk: imx8mp: Add media related clocks
>   imx: power-domain: Describe the i.MX8 MEDIAMIX domain
>   imx: power-domain: Add support for the MEDIAMIX control block
>   video: imx: Fix Makefile in order to be able to add other imx drivers
>   video: imx: Add LDB driver
>   video: imx: Add LCDIF driver

Please also add the newly added drivers to some defconfig so we can
have an in-tree user. Otherwise, it becomes dead-code.

Thanks
