Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCBBD59D85
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 00:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5876A89338;
	Tue, 26 Nov 2024 01:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bn8dVsqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C9E89A09; Tue, 26 Nov 2024 01:33:32 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00BFF88BFB
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 01:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ea39f39666so3968001a91.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 16:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732581206; x=1733186006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bQzaFjelvQM37DyTwtTG1pv7NLKMguPGcSjB2fRrbTE=;
 b=Bn8dVsqelqgZfhu2OwBLYBLdscG7wQTT1V84I42fF11LtV84rW6IQlkD83jLkUnkpZ
 mLl9y9Ag5jNkYiL3rrU9FEVMFjFP4QJejtO6JVXXJyzNK/lwmuA76326bFSY56/90j2s
 7fPA2Gx+cty58LkbQFKYMFlZRMm9vMIZA300M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732581206; x=1733186006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bQzaFjelvQM37DyTwtTG1pv7NLKMguPGcSjB2fRrbTE=;
 b=Owe8kgP8r8JZOABjyiKLlsK4oJ0x6K/J5sJRtxHO5rT0x1sIqXH5ytCg7QyrteUqKH
 iuXby9Qxl3a0HDwKR/5IHBGS1sTJw2NKJjKPxRmeDpZEN9N1Tb4PeXPdhZ90sdNde11s
 mgzBLbfVmTJZJYBQwSuy+DDSTKPtnyWXPVS2CjxeAck/gkkFCeUaNpJOYJx9qD/5ZS54
 oEs57avLydb1gcolCwR2O1AsmuOH9wm6GmD+6tSJDf/5L++NSDrQaqYX95sOgu8P5TA0
 qjNQpeV6SwyumDqy+vpWBlETg8qeO7jz5ncNScIQVkaTCDHkwhqbw3X9yitguqVUswKi
 L2Ow==
X-Gm-Message-State: AOJu0Yz0tktdG+VkJdIDzuJp9zBqIJJAn4etdFI6JqoWsSKA0zUbTYVU
 SHkPz8hyy56RTd95vizFuZLsichg61Z4ay4NsDg3KTdszSKs87shSFv5tZPPCmiIrwZgEWkWrt1
 V8ztuRoGpj5Wh3meazupqyMp6K27EpLJE4VOR
X-Gm-Gg: ASbGncuiZTO6wD+rzgZ6SIkKNMOonCsw5nD+rFIJP3GpXETLKN94JOdbGCy9kN+7NV2
 CzAbOs4EtHoeObYlFtpG8meD0gH5Hh9o=
X-Google-Smtp-Source: AGHT+IFK7oTAkYr6NxAqfe7g6XFSS9x2kLTKIpsc3NUHnaKIoAryFBFPtmFUyhpIbvPuBlSUSUkFO2BxBfwiv79gfbY=
X-Received: by 2002:a17:90b:33cb:b0:2ea:5823:c141 with SMTP id
 98e67ed59e1d1-2eb0e22ce72mr20784333a91.16.1732581206582; Mon, 25 Nov 2024
 16:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20241122015858.557561-1-marex@denx.de>
 <20241122015858.557561-2-marex@denx.de>
In-Reply-To: <20241122015858.557561-2-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Nov 2024 17:32:44 -0700
Message-ID: <CAFLszTjJWrrxbeqr1hRnMsaJyTGLWx2-mY1LKQ4NMkkHHjxYQQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] build: Respect CONFIG_SPL_BUILD in DT sources
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Bryan Brattlof <bb@ti.com>, 
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Stefano Babic <sbabic@denx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Marek,

On Thu, 21 Nov 2024 at 18:59, Marek Vasut <marex@denx.de> wrote:
>
> Currently the U-Boot SPL build uses the same DTBs that were generated
> during U-Boot proper build, and calls 'fdtgrep' on those DTBs to filter
> out uninteresting nodes and properties. Those U-Boot proper DTBs are
> built from DTS which are first preprocessed by CPP, but that CPP is
> invoked in U-Boot proper build context and effectively ignores the
> CONFIG_SPL_BUILD macro. In case the CONFIG_SPL_BUILD macro is used
> in any .dts file, the content of the macro is removed by CPP.
>
> Fix this by building a separate set of DTBs for the SPL, which are
> preprocessed by CPP with -DCONFIG_SPL_BUILD set. Use the same way
> for the other PLs.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Bryan Brattlof <bb@ti.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Greg Malysa <greg.malysa@timesys.com>
> Cc: Ian Roberts <ian.roberts@timesys.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jonathan Humphreys <j-humphreys@ti.com>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> NOTE: For v2025.04
> ---
>  dts/Makefile         |  5 ++++-
>  scripts/Makefile.lib | 11 +++++++++++
>  scripts/Makefile.xpl |  7 ++++++-
>  3 files changed, 21 insertions(+), 2 deletions(-)

As mentioned on the other patch, this should be handled in fdtgrep

Regards,
Simon
