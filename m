Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00938D339A1
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887868911B;
	Mon, 28 Oct 2024 18:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n0J+FiCX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06D189117; Mon, 28 Oct 2024 18:05:15 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A966189128
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a6acac4c3so712099666b.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730135113; x=1730739913; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JTXNmJQ20IDl4me4JgRIZRBF1xCkXOopbtjVU8ZnJHM=;
 b=n0J+FiCXJe8b5/+vE+5V6wkXj6WYE+3swkMxxCDl2+67JSvQ8bzpdFlyz99+wvFfgJ
 DUaI9TxJF4Kx8zYNwa8X0qs+Bfcg+Yq0xSyPkceSpK0jBHEADAAQVgPFhv9DAvCaGhzu
 5TTuF2KqZ5HrRVfmq8mn89A2VMHQb+xkcyx2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730135113; x=1730739913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JTXNmJQ20IDl4me4JgRIZRBF1xCkXOopbtjVU8ZnJHM=;
 b=B4RSZ98DyTeBDf7o2tvphT/mgt8u+Ma3NDQnhsUhNC1Ql9s/y/N3LAW/IB1bBGWGQV
 dm4B8K5A2oKjbO9P1BMSaALL00qnA+wF6NVVJbz34LTiD7yPafonjzTHxGLXZMvM9EiP
 yXP5dTdFdKvJrqNLkMcfSxtHUAlf1TU7kl5d3VsgF5olvz3nllRtNsaYHA+FjdhXvjKd
 +1ugnsvqYwSI2nB7y0FRzUrMMXVEnnmiHpUWi9v8svaOZN2iu8NECjueVMB9NHPk0+Tf
 6fH0MMkmvq/Xn4+ZEv7l2Z4k/kJDVLVyIYOcGpBQY+J3atLRMdOwaWSveeM7zJKXXKcr
 fnTQ==
X-Gm-Message-State: AOJu0YweCAtlvOh20gw0q/ZQuOLyJr0QWP7efT5O1EBF/V43nP9+N+7b
 gE8yF46M4ng0VOyAB91hk18P82tS/wSlDqjQiRNNUJtR4+yiCqqw1B6rCJN/0H+3CGLnwpCiIcI
 1Gs6ldv4qhOQcIaoviUeP7qJgKuU3TuqaOt1f
X-Google-Smtp-Source: AGHT+IE9hoNaS/Ot1fOu2TSSf1SFZvEkC3cOl9WP6vkp+or95tJ5dLkZrSeF5qxbzcm0aMOs5vHBu/3ecrsx6XX4580=
X-Received: by 2002:a17:906:fe01:b0:a9a:6477:bd03 with SMTP id
 a640c23a62f3a-a9de5ff917amr767591166b.38.1730135113060; Mon, 28 Oct 2024
 10:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-9-raymond.mao@linaro.org>
In-Reply-To: <20241022200543.116343-9-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:05:01 +0100
Message-ID: <CAFLszThV83LtvSnO_S09zzyJZVZqRsoh1PNmVS72v9Eoin=MkA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] configs: Enable sysinfo for QEMU Arm64
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Wan Yee Lau <wan.yee.lau@intel.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Enable sysinfo smbios by default for arm64.
> When SYSINFO_SMBIOS is enabled, disable QFW_SMBIOS.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
>
>  configs/qemu_arm64_defconfig | 2 ++
>  drivers/misc/Kconfig         | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
