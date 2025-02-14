Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDC7C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 16:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D3F580B98;
	Fri, 14 Feb 2025 17:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eF3xVzf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20E5F80756; Fri, 14 Feb 2025 17:54:58 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1508880C7E
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 17:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso1587924f8f.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739552095; x=1740156895;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oa8i8LDLFCUWGf3EY+9H5KTg5wWtKa39b8rHe6gJbDw=;
 b=eF3xVzf93Awks0u+Yr/kDIm0pTXg05/uY5xz/R4uky+xELKrGhYthjo6X2tdmlzr0s
 SfsEdvdkqwR8LG2YHXE1J9SLv3E3pJunr7AMn1pc6K17TJ/o1pVB1W5JagrCG8YgBqVq
 FJ3K7pPJD6AYDObQqzUE5B6P8yq0PTWCcbYVuIPhPCKV+QxD1Mkp+Fn22C8xhQDHN/sw
 tZf0HTeVE6d+JoRfcI1Ftl5K4HQRZHPTGoMSeeg1yuvr3uOSORmDMr7nMVsEzaWXwYgq
 yh80mAbipHW9RVN1AW+FV7bnmydsTZNNZ1jvv1AZGTPFGEp/2Mkhg+Y3Ez9vbP/4OkcJ
 5TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739552095; x=1740156895;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oa8i8LDLFCUWGf3EY+9H5KTg5wWtKa39b8rHe6gJbDw=;
 b=xT/QoBEnZ5vDf5X7u/fhacrTJyaMrDsP0Gn2XWS6o1sXZuMLmcO6X/KzRsoXwSz0Y5
 CQJodhJH67cwAibbvQQo0nm8P8ilNcGPzCQetNpRBK8gVTtUkQgaQxl91CUaVTxx+jO+
 u+PoQ1uJPZco1pO210fVfVvHVyUzqxRhc49QjYRxZ7fbspZlnIlPCv8s6dVpjg3Ks63E
 nkQG5yRAFqyhQy8pHS5qtCvnUMWVOOWk3qVr6at68j5IP+En4YnGbk1E4ZG5GSFMJ7KM
 6bKlYKqi0x/4/0JeAYSCp3nZ016NLPdX8xAvpsAm1epuZ1zD9q7Y/JYeZvLfynvm3V4u
 scfQ==
X-Gm-Message-State: AOJu0Yz34LoBwaRUb337GCy/0g3yBrlHNrfv0aQfFr1OARVu2kd7bdax
 ZKMxg4blBGxcoB7FjI0Q/Rz48tZbmvOxR7UVeM6u5PEP/VnanQ18TOY54DM2Dog=
X-Gm-Gg: ASbGncv2yRm+DccrgsOpmTalneHhVSlFeZG+7sorT6TGnm35WJKlcDAHUIwybvXvW65
 gmUdDPFGEnJs6maI1a1rH6NV3DHYm/3/K5WjMivGcSWiJ95ma/B+y0/nV88b5AZ9kBDS4OmeA5k
 Pu19G52Av4lo1ZnH2LXSo85nLBol/ccR9v9s3haBuJLDzPMc6DB2oHG1g2dyZWsQ9gy4VwjYzXw
 g2nMEO70ae2BcAbNyppDBsjefPtaaoHLVLX+UnP/Ex/CgM6yjC7rNHW5ovWnOpXDJuxRTKd2Djp
 euMweQflLtAaDK4sHrsinnGJ
X-Google-Smtp-Source: AGHT+IGj6YgRFOh7/fhkiy0jQCkAu5wINpRzRD45edtIHgLeAQft53DGjC8JccJ2VTupGIkrI3PPVw==
X-Received: by 2002:a05:6000:1f88:b0:38d:ba81:b5c2 with SMTP id
 ffacd0b85a97d-38dea2f875dmr14035632f8f.47.1739552095443; 
 Fri, 14 Feb 2025 08:54:55 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b44a7sm5180630f8f.12.2025.02.14.08.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 08:54:55 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao
 <raymond.mao@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal
 Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, Simon Glass
 <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Neil Armstrong <neil.armstrong@linaro.org>, Aashvij
 Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>, Jonathan
 Humphreys <j-humphreys@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Wadim
 Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/3] efi_firmware: set EFI capsule dfu_alt_info env
 explicitly
In-Reply-To: <20250213195351.3518305-3-j-humphreys@ti.com>
References: <20250213195351.3518305-1-j-humphreys@ti.com>
 <20250213195351.3518305-3-j-humphreys@ti.com>
Date: Fri, 14 Feb 2025 17:54:54 +0100
Message-ID: <87wmdsh3fl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Jon,

Thank you for the patch.

On jeu., f=C3=A9vr. 13, 2025 at 13:53, Jonathan Humphreys <j-humphreys@ti.c=
om> wrote:

> The current implementation of EFI capsule update uses set_dfu_alt_info() =
to
> set the dfu_alt_info environment variable with the settings it requires.
> However, set_dfu_alt_info() is doing this for all DFU operations, even
> those unrelated to capsule update.
>
> Thus other uses of DFU, such as DFU boot which sets its own value for the
> dfu_alt_info environment variable, will have that setting overwritten with
> the capsule update setting. Similarly, any user defined value for the
> dfu_alt_info environment variable would get overwritten when any DFU
> operation was performed, including simply performing a "dfu 0 list"
> command.
>
> The solution is stop using the set_dfu_alt_info() mechanism to set the
> dfu_alt_info environment variable and instead explicitly set it to the
> capsule update's setting just before performing the capsule update's DFU
> operation, and then restore the environment variable back to its original
> value.
>
> This patch implements the explicit setting and restoring of the
> dfu_alt_info environment variable as part of the EFI capsule update
> operation.
>
> The fix is fully implemented in a subsequent patch that removes the capsu=
le
> update dfu_alt_info support in set_dfu_alt_info().
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
