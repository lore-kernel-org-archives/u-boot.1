Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CCEC021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 13:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6147380F5C;
	Tue, 18 Feb 2025 14:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VY1fHAuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78EC480F16; Tue, 18 Feb 2025 14:29:49 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63EA680EC0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 14:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e0373c7f55so5555414a12.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 05:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739885387; x=1740490187; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D9t5N5UqrWTcr01ItA6NPWYGiHlXpfvQJ+Lmxi4RZG8=;
 b=VY1fHAuzQcuk4Xn76pkc25w8Fau/MU+Z5La/ERBiYbuNbLZMdMz86iAoM/nnPFdeAA
 XcsUt17DPAltNwXhX+ZHNprzjQ+qpKm1m86nL29lNiPsMlc/MjKqWDY5Yh5SMdSs3DSs
 G66rmuxs6LDjXfDcEPSiwpP7odyCbBr5FtcZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739885387; x=1740490187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9t5N5UqrWTcr01ItA6NPWYGiHlXpfvQJ+Lmxi4RZG8=;
 b=fNnmZOxnweLhCwJN3FfBX+EAWiN7ApQMzuKLo99pFtr8lxdiQiX6PU3CwxyfiiigZ1
 3KGg4S3Qo0VVm9IHQDxSibItmO+7+vR5BOnJ7eNuUU4O702rAomMkFFIe85HSfSEy7lg
 ZlvtcfLPrdo/EJTNUHT+OaVJToEUKRWCob2CSwun6J17bULu6JRrpa/JrdaviOZbQgJG
 XWby/zo/aqUV9J/Nhm2N87ewGQ5v1yjEBVQS3vMk93sftwOEQFu6kyatXgvMD3kLtlur
 /YGWWElGqDeVsv46BG0gmywKfRYpCS6dbHO+renQ1zHjMwHNQvwUWd3yrGcCyIUBohGk
 56lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9SR+ZbM7vSoHAi6gpHuysjoWJCrk04AG8IzWYFOeXd+NxgSDY0t8MM1iq77dzxpAuRJyVD7E=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9OzixragZg7iQx5HaieWKPeq36QVnAcQ7SbNk06G577QZewtI
 XAb+Jwcv9CDUgfWhZS0SAZR15QgHWyuu3diCfLFCPIrE27QcaObdsWJNARMdPsPvkv4LHsV12BW
 VFeCrtHVji3K2syhiMJPEjNs1+7cwqFXW38/n
X-Gm-Gg: ASbGnct6HzRR91+Mv/6M5SKQwMHHr0vX1a9d58v/YmCWA67QP5PokBatdB28wItPgs6
 oCPFxuoloVYCvczalBFFRMSP8A+qGwm5YIOUog1l1IvDdpzYj/rnh6L5RhDQjOu3F7ZrjpAcKtA
 ==
X-Google-Smtp-Source: AGHT+IGZLsyKxTByPohMSNo4+91h2j47Og+9fznKsisWNa+lwS0X3l6Og0bAEhSfd+CYXe4sy+GlCG0Y1RK1Z6mnJ3U=
X-Received: by 2002:a17:906:314f:b0:ab6:de35:336c with SMTP id
 a640c23a62f3a-abb70b39242mr1102123466b.19.1739885386762; Tue, 18 Feb 2025
 05:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
 <20250218120559.451678-16-alice.guo@oss.nxp.com>
In-Reply-To: <20250218120559.451678-16-alice.guo@oss.nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 06:29:31 -0700
X-Gm-Features: AWEUYZkSl3TACgSZw9tVbY3d5KPJC9q7E1zhmwlpulCs2jJdsw2slKRhtwW4C9k
Message-ID: <CAFLszTib5WUBMsVb1cQUAe8+B=sDQLVFXaHMbT=wQpDN5R6VuQ@mail.gmail.com>
Subject: Re: [PATCH v5 15/20] binman: add a new entry type for packing DDR PHY
 firmware images
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, 
 lukma@denx.de, seanga2@gmail.com, alpernebiyasak@gmail.com, marex@denx.de, 
 u-boot@lists.denx.de, tharvey@gateworks.com
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

Hi Alice,

On Tue, 18 Feb 2025 at 05:11, Alice Guo (OSS) <alice.guo@oss.nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> i.MX95 needs to combine DDR PHY firmware images and their byte counts
> together, so add a new entry type nxp-header-ddrfw for this requirement.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  tools/binman/entries.rst                  | 10 +++++++
>  tools/binman/etype/nxp_header_ddrfw.py    | 32 +++++++++++++++++++++++
>  tools/binman/ftest.py                     | 11 ++++++++
>  tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 +++++++++++++++++
>  4 files changed, 77 insertions(+)
>  create mode 100644 tools/binman/etype/nxp_header_ddrfw.py
>  create mode 100644 tools/binman/test/346_nxp_ddrfw_imx95.dts

When I run 'binman test -T' I see that there is missing coverage:

tools/binman/etype/nxp_header_ddrfw.py
              14      1    93%
> +    See imx95_evk.rst for how to get DDR PHY Firmware Images.

Your test is a good start. But please add a few more to get this to
100%, or remove some unused code from your etype.

Regards,
Simon
