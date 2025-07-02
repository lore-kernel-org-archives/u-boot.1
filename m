Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4C9C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E0382ADA;
	Wed,  2 Jul 2025 09:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AEFTvQhA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E29982E86; Wed,  2 Jul 2025 09:45:52 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2859382103
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-607434e1821so6035257a12.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 00:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751442349; x=1752047149; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMXYrh8umUqZf/qXGVVSNyT9fWagwVMemCEuRM4ZpME=;
 b=AEFTvQhAf9URKXkBbcfBSRtVlVhd/Ik8mniUbSPDXv8f+7hVsjU5lTWoNbS2Int6MK
 0QZFnepoDcBKErVPs7GoC00LpDIh0VQiPOPNiwxxDGe14oU3Tdy+BnGk/nL7sIF4LVee
 MFXuBpoJp/mXHc7gBNoq2MHs7HoAt3HtEfroKrosrIkrnxcUTut/3cbh4RWpAQRP3PZy
 UmPgJa6HF4yNFbd73tTYP7DtPASRGrHVG8llkt4bkoMPUBmOrlzDsqrHlFeUyTIz57VW
 U+4wGfatoH8qxly59SFIWIELzCxz0Lmpukg3ATi2vmXWCcSANAOw4DSk4F3hg7LBP53O
 ocYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751442349; x=1752047149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMXYrh8umUqZf/qXGVVSNyT9fWagwVMemCEuRM4ZpME=;
 b=nuLFkFB/IYosOg0LV0vD581Memlulmjttbnv5AyBWuWPZA5xGsxdF9dWCWnDpz+lN/
 VXOE9hHsUyYGoxJjeRfBnVWh+5wZFDdLP4THboputCiSwlumvdmjdVGtQ6BCNXvmZtSW
 EVdWdtx++Mwx7XQLxs3ZJvE/+Y+AuePAtFBFUqwwZZjerJosq4l7CwgyNUoYcfV4CTW7
 ntowyiwtlmFaHnJGQTsDPJzG7MOuT2wRNPCnUDQZgTrCswVGxhij3I8gk8wixhVwwU+/
 ttFIwPMpJE1UPL4argfL/Wi7QXFkooh7ryJGCSDBADsNyp13RdsdQteA2emdYJ+b82hk
 3ivQ==
X-Gm-Message-State: AOJu0YzmoVP1sHOS9VLw1VijOBmso0PtmHCBOl24OtLupQQLUAg3bKyC
 nwTX6+993NWLQc9gJOVV8UrpZc2Z6BCNULqa23HTbnvMqstAY5vdRy09Cp2i/E/bh6970Rfjze7
 rlhH4qVzhHoZIwyMbkn+uDMc5yvZGyn2dvXqA
X-Gm-Gg: ASbGncvqBgYtQIaCvH7bT5XQipCEdSApMTZtnWQNOQVPjvcVYAWWB11ZObsFVo9NPg4
 nnFRz5D0F99fPobs0eC/tU7ExLlkC/OnHyoqB04yazF4BcyYRsWVHZIPNeotNVy31j+YTijACNq
 4CcyvrRR5T8H6CHxJa2+pySCofjhpmZ5TKHLb4EeUggoLaU8OG8zQ0Dq4=
X-Google-Smtp-Source: AGHT+IEjkbMfkKYYfziMO5qsAe2ceQTmPXdCQUhYRbVgp6G3M20itMATiB68T1IFdAmUW9H4c+q1XOAURvTcjQ4wSgw=
X-Received: by 2002:a17:907:7f0b:b0:adf:7740:9284 with SMTP id
 a640c23a62f3a-ae3c2e1a412mr182295866b.57.1751442349237; Wed, 02 Jul 2025
 00:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250702010429.18958-1-trini@konsulko.com>
In-Reply-To: <20250702010429.18958-1-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 2 Jul 2025 00:45:33 -0700
X-Gm-Features: Ac12FXx_MI6rqe2ha-irM1zA0EQ4rL20q3z2qW_u2VVk-Dbe04mHFlDjFu0_Xmk
Message-ID: <CAJaLiFwvLX8SHm6vg1fUw3ZPibCK_sVFsu9LvoaCCgJePXWdgw@mail.gmail.com>
Subject: Re: [PATCH] ata: Correct two dependency issues
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, Jul 1, 2025 at 6:06=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> First, the SATA_MV driver can only build on kirkwood or mvebu platforms
> due to header requirements, so add that as a dependency here. Second,
> SYS_SATA_MAX_DEVICE is also used by the API code so allow it to be
> configured in that case.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/ata/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 29ceab849c02..da9c72a99d03 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -131,6 +131,7 @@ config FSL_SATA_V2
>
>  config SATA_MV
>         bool "Enable Marvell SATA controller driver support"
> +       depends on ARCH_KIRKWOOD || ARCH_MVEBU
>         select AHCI
>         select LIBATA
>         help
> @@ -148,7 +149,7 @@ config SATA_SIL
>
>  config SYS_SATA_MAX_DEVICE
>         int "Maximum number of SATA devices"
> -       depends on !AHCI || FSL_SATA || SATA_MV
> +       depends on !AHCI || FSL_SATA || SATA_MV || API
>         help
>           Sets the maximum number of SATA devices which can be supported
>           by U-Boot.
> --
> 2.43.0

Reviewed-by: Tony Dinh <mibodhi@gmail.com>

>
