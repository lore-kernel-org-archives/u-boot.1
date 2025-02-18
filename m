Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463BAC021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 13:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A49C280ADF;
	Tue, 18 Feb 2025 14:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JrRk5rxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 946AA80BAD; Tue, 18 Feb 2025 14:29:35 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 723C7809A4
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 14:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso10138848a12.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 05:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739885373; x=1740490173; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bali3rtzwG1H1s5PNGJL68ARKM/aXYmkDIG+FEd41sU=;
 b=JrRk5rxgruy/h4JfsED1Iv4ZyMqON+yoRuMObW1G8kx+D4lfjRS24Icx/6ATzvIB5t
 vwzLVXIzctssv4QLrCk3nUX+it7luS59OYSQtMFpbpGABZqsC2wZehaQ85PtdymT9hpu
 OqoJZO/Kb4Ai+RJyFUwlqaZvavRYGSCtY4GW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739885373; x=1740490173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bali3rtzwG1H1s5PNGJL68ARKM/aXYmkDIG+FEd41sU=;
 b=bxTWntMifaGaSZKSi4OpMQ+h1NcyDmf07vRi4rBafLU/Pdsq3SN9i0K+3FIe2f/JWg
 0UTZxqyss6KHpzNCp8NKGGr6f9aF946gXbgtfN7q7KPVmfsuU6GzrXZiizcQmSlliB6r
 ou6HG0YS4RcavG8wqmJeXW0uuaTrka+mlIO/68J7EbsUoGst94kvrUi0gahtDTG2zuHJ
 wb72Yi6JasymeKBAjgyPGpTr32caw/LPWh7mBrPNVqWX2t9BvowEtCfR8MaR+RC5zxMy
 1Ujw9859r7/pdhaZo6CQnDlCrzHBRHMfxKiQtO464PnKI9GKm4E+VzTox4amEjk7vWTr
 3+nQ==
X-Gm-Message-State: AOJu0Yybi1OzIHnVFNxDTAMeR9jlU9EapPqL5hMVg0ml+vhj7b/a5Gf6
 7zJ9XNZ7Vs90RNRT/vIJEIJUYntzp8cpGKheYoU80cdzdBHbxuqicorHs7OGG20LwBLvXyvFW15
 yqxndSMOidZWQt+VEKAEwT2ZUjKtlqryZp/QE
X-Gm-Gg: ASbGncu43xp5Ma7go0KSDQMz0v6pW1FXqPERBDbphBD4nqip+ib2j95D+yOBnMVOPmg
 yl8ePAQ+vw1dbh5WQKm82jzTiX1QSZxyyK3xz8gm+19CdQA4M5KwlTmn5uP+mo+PaQQL6eyohzQ
 ==
X-Google-Smtp-Source: AGHT+IEAj6AEVTym79+qmNNuROim7gZHoMbDrMu6iBrv933g+/3v9sAXvj3QOmS5b8WslH0O/td7krewh9XsslWPnj8=
X-Received: by 2002:a17:907:86a1:b0:ab7:cc43:c51e with SMTP id
 a640c23a62f3a-abb70cbbcf2mr1247996966b.13.1739885372838; Tue, 18 Feb 2025
 05:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
 <20250218025705.50051-3-dinesh.maniyam@intel.com>
In-Reply-To: <20250218025705.50051-3-dinesh.maniyam@intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 06:29:19 -0700
X-Gm-Features: AWEUYZnNZDF6ylbTdLK6wqbRTlmKPXN0CutckjGWDZeERnMKpLaskpb_jtApkCc
Message-ID: <CAFLszTia6BqKtNbfvbio0Q6WnznkzSjWuMzpBHyYi2D54NFVzQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] drivers: i3c: Add new i3c uclass id
To: dinesh.maniyam@intel.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Wang Jie <dave.wang@rock-chips.com>, Tingting Meng <tingting.meng@intel.com>, 
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>, 
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>, 
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, 
 Jit Loon Lim <jit.loon.lim@intel.com>, Sieu Mun Tang <sieu.mun.tang@intel.com>
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

Hi Dinesh,

On Mon, 17 Feb 2025 at 19:57, <dinesh.maniyam@intel.com> wrote:
>
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> Add i3c general uclass id.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  include/dm/uclass-id.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> index 270088ad94..1d259b439f 100644
> --- a/include/dm/uclass-id.h
> +++ b/include/dm/uclass-id.h
> @@ -78,6 +78,7 @@ enum uclass_id {
>         UCLASS_I2C_GENERIC,     /* Generic I2C device */
>         UCLASS_I2C_MUX,         /* I2C multiplexer */
>         UCLASS_I2S,             /* I2S bus */
> +       UCLASS_I3C,             /* I3C bus */
>         UCLASS_IDE,             /* IDE device */
>         UCLASS_IOMMU,           /* IOMMU */
>         UCLASS_IRQ,             /* Interrupt controller */
> --
> 2.26.2
>

When you add a new uclass, please add a sandbox driver and some tests.
There is the existing i2c to follow, but your tests may be simpler.

Regards,
Simon
