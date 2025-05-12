Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A31C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 21:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D8A80C83;
	Mon, 12 May 2025 23:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bFwRLwXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ADCF82162; Mon, 12 May 2025 23:51:01 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ECD680584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 23:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-326c1f3655eso37115481fa.1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 14:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747086659; x=1747691459; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBOqia1vmAOv9KBlNpt4kCRYYIksV4qohhk7cCwEM8k=;
 b=bFwRLwXPzoDKRmqsMK3uWB0LPyVOu2ydCeRWUzwQ7RDvJKhOZU8SPeekCuTXGztwaR
 yz0uL2iC9r+qNvKvXU4BhfsHzJ6cFQG6LUoeHbLEDk89ZA5/eDVHPLP0gCqXkwjVXriJ
 GRizX32DvYjXQd6oCowfSNr79B3SGUQm5b7QQw06wmlM+9fOGBC+z7RLnbrcH6uj+X+n
 2V2J/f6PDlMZsHvj2wFRdUF5cc1iGL1sI6A7weraYuYw4q61TjtIpyAHhZApm4Emlt00
 cUPhKrEiRivQeWCBMibzSFQpx6q8OHDajwXm2GOYZhOgOiMjY6TbY5YnJHGSXmT3KObB
 krsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747086659; x=1747691459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBOqia1vmAOv9KBlNpt4kCRYYIksV4qohhk7cCwEM8k=;
 b=YjzXvmEfQ8qRCQ5qTN78xMNfsxGftp8yp/HxSvIJXnOQaJNgxfqpLOdCgN+bYlOjYq
 Yg4IoEAgPRs+e8S1wi6lelgxDOg5tl2uzsGzc9osc8scGRTFgYGOHRPOG2IoEY3OHluK
 DqqQGQAUtZ8wDwWhzf38M9n+NO+mpLDFuThY/mtNfhPMCIrsK2xN6Q58i6ibl1Ty9vJK
 OxSykODhNtWP3LpppX0COsd6nA4LnxrDa/1ysk9WLT0Om9R8Xokbd3NWFqDhbyGWFZp7
 t2byVogGjTXsyxcUdmt9OLnDIR6n80FGd82l9Fg1HEr8BJpNGoyoXuZ7i0YlmhuINCDR
 tL8w==
X-Gm-Message-State: AOJu0Yzsq+Ic82Y85xvj28ZuDF63GC8GXdhh3RYSgALQqd9BfXS5/NHs
 2XvvWe8OLKGiWUH1tK4xaVkkLyyL4bElpY64rDRVMKTF/8wSHWactcRT/igZbq3YHBIsNOASUvk
 pVPaAtJaxBZUXXHgQo29gz5rLMLk=
X-Gm-Gg: ASbGncvNP3aKr2ulzebm7TBmQxqMFDBtORHGc1FRxaa7s46x8hPPDWB6u5rUWhOysKq
 AqRG54LwBp3KQCDKD2yVxly4B2Q6fpbFrByuaQXSmJ1PkQyBOeLG47KDnBtejvC4z/tJtNbagPN
 e9iiTBl4ix9TNijxHLe8PF33ql5eK72OQZ1R/rL0gYGNgwhuJFWYomeLBdQGVezu0d
X-Google-Smtp-Source: AGHT+IGzioiCJDl1rzquaPudB9SXi7Vo5oARNKBRauZ0ApATVqiA9y8ibYVUMpSpXEBbbsTYRKhdt8G++aoB/9oLFD8=
X-Received: by 2002:a05:651c:3226:b0:30b:f42b:72f6 with SMTP id
 38308e7fff4ca-326c467d22amr62897371fa.32.1747086658772; Mon, 12 May 2025
 14:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250428095945.1432389-1-heiko.thiery@gmail.com>
In-Reply-To: <20250428095945.1432389-1-heiko.thiery@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 12 May 2025 18:50:46 -0300
X-Gm-Features: AX0GCFto7F-lELlfiCY6pXp9zq5Y6Fcs65DzzrwCu6PMJ393VOIQp19YjEEAauo
Message-ID: <CAOMZO5CPMpym1QyytnQAzTgWGFTnz-cJMC-W752+_UDJqkB-Lw@mail.gmail.com>
Subject: Re: [PATCH] net: fsl_enetc: fix imdio register calculation
To: Heiko Thiery <heiko.thiery@gmail.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Michael Walle <mwalle@kernel.org>,
 Thomas Schaefer <thomas.schaefer@kontron.com>
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

On Mon, Apr 28, 2025 at 7:00=E2=80=AFAM Heiko Thiery <heiko.thiery@gmail.co=
m> wrote:
>
> From: Thomas Schaefer <thomas.schaefer@kontron.com>
>
> With commit cc4e8af2c552, fsl_enetc register accessors have been split to
> handle different register offsets on different SoCs. However, for
> internal MDIO register calculation, only ENETC_PM_IMDIO_BASE was fixed
> without adding the SoC specific MAC register offset.
>
> As a result, the network support for the Kontron SMARC-sAL28 and
> probably other boards based on the LS1028A CPU is broken.
>
> Add the SoC specific MAC register offset to calculation of imdio.priv to
> fix this.
>
> Fixes: cc4e8af2c552 ("net: fsl_enetc: Split register accessors")
> Signed-off-by: Thomas Schaefer <thomas.schaefer@kontron.com>
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>

Applied, thanks.
