Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B56C35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 18:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05F7881219;
	Sat, 22 Mar 2025 19:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a1rGOS6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D9D8197D; Sat, 22 Mar 2025 19:26:40 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1896E810FE
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 19:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5497e7bf2e0so3489427e87.3
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742667997; x=1743272797; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhNWdVH7rGKEYdfMNYUC9R3f5vDCvXycghR+pyY/AlU=;
 b=a1rGOS6b2m7iFDEA5YhhzO2rENUy7fwL8Zy1v24FrgoVlzoRQxi2oaIHFeu8gT8V5f
 lw2nYeE2we/qFQGcB63E506XUcEu8cmmXm8HNyzalyKbDNb9VLuQa83gfB5mgR4Zx0rW
 UyseQ8v+gpOvj+xgDvr723kRwOt5Y40SuROfefUQ+hz0/kHivtf40n4nckeTqcwdSLBo
 uIDv4+024LHZAETiRNDS8bKH6E+CMBwNio+k/zOZquK7JJripe/deo9VUz97DUlgbkOC
 k6Yc0WsH4FnR9jZXjEJsh1HQ/+f7jZWfhplxQCU/3PYwotXaHCrWMQd8gXBQXRIL5Clm
 3a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742667997; x=1743272797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhNWdVH7rGKEYdfMNYUC9R3f5vDCvXycghR+pyY/AlU=;
 b=luPyTXSgJTbBXWD11bF6/mdmnPU4cajcsa3hAKBDq4Sky063bONEK3Y/RRNTK9Fffa
 iMANkasGkZ9+1XYQwOkfVxMYRCgAwZD/dmaJat03G8UHkRO1mkezzjPSu+uE2tw7F0rN
 KLsfwz9U0+DI3vq4FTeS2UBbKjClNJ+TP3nSWN4zY0X1XDhCRn06jca8kJjphVeK9og3
 i/9P81RU7t2jwGFIv9G6fqfclM84B+0R4+MUQgXRd0PJZw9QpxcvBfwx1l+jBoXkiNUX
 NB/6wp2y+cQ0nQsu4G12zXn0GwD2IabGTqNMVq/4RaD5P20k/HUG3C+e31zjoAH7kvRD
 TrKg==
X-Gm-Message-State: AOJu0YywzsoIgI6pAf/LoCth7swyUdKBkUNPQ4oDMHgssKEcW5ptT5KX
 0cQBIFQaSd//zxdkq71d/dhGV1kwmAW57LynjHTA2QuomYshfcTPQkKEYZW3jZQe5iyn7gb9h9b
 sgRMUBf3KGt6OArjkHULyvxFdN6I=
X-Gm-Gg: ASbGncv6FAUe9xyc9KyVZCekkCCwOmk1DX79WyEioL3LF0ZJVVh59Uc+Pf/FBRYVRYm
 fQ6tMFLu0yPGy0kIZwQig+uh39mf8Sw/ERNVHL+dsA7jm39/v3u0zzunH1HsV8Xt2S7QpsRkxmC
 vFFpN5VmkOuH7zaIPbQ8roXRPtG4QfmT9Na0BBKj7gPdmy7VFzmCidorBy
X-Google-Smtp-Source: AGHT+IEsLB2NmSCIwyax/OMQgI/QmU3Vfuywkpc0e+RsagLfLHt8urWurP5Zn3pbB8N0RDVu5RAm2fAfdWJ6Z1e/qKw=
X-Received: by 2002:a05:6512:1152:b0:545:2f9f:5f6a with SMTP id
 2adb3069b0e04-54ad647e35cmr2568629e87.14.1742667996925; Sat, 22 Mar 2025
 11:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250319031852.233537-1-marex@denx.de>
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 22 Mar 2025 15:26:25 -0300
X-Gm-Features: AQ5f1JoSINfB3pySdVndn71IKCfPolFeaSn_H6OYJvGSCFKdlwwhNyBDxmh6VOc
Message-ID: <CAOMZO5D+nigasmFrQEsLQ6cGgbJr_LcxXAiQoDP2U1hDdBO05g@mail.gmail.com>
Subject: Re: [PATCH 00/24] clk: Add clk_resolve_parent_clk() and fix up iMX
 clock drivers
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
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

Hi Marek,

On Wed, Mar 19, 2025 at 12:19=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Add clk_resolve_parent_clk() to resolve parent clock udevice name
> based on clock-names DT property. This is used in SoC clock drivers
> to look up the clock name in clock tables, which matches a clock
> name in DT clock-names property, and convert it into udevice name
> which is used by U-Boot clock framework to look up parent clock in
> e.g. clk_register() using uclass_get_device_by_name(UCLASS_CLK,
> parent_name, &parent);
>
> Pass struct udevice pointer through the various iMX clock drivers.

This series conflicts with the recent i.MX UART clock work from Adam.

Please rebase and resend, thanks.
