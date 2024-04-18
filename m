Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A81C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 11:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351F688607;
	Thu, 18 Apr 2024 13:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G0obHp39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A70A188609; Thu, 18 Apr 2024 13:48:32 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8505688319
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 13:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-345606e8ac0so99278f8f.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713440910; x=1714045710; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVRxNyZ0HZ4iSuQ1J+fUHEfJfTWOoqTLrz95VjTZqXQ=;
 b=G0obHp39vB318zQMr7Us2eOinUYq4qEtH90J64P/j6QCcf6BKbSspNX15CQF6svgmy
 iKWU9vijuXxmM6AHl9jgsgyvS8gAYW7EzLQacsKs5tdykeZOTO0rrrXxwBXBo92fQbUB
 XYJC3es9FVuur08HXt5ocFIZ2E58ExaehfRxDEO3/+pM0ISOhYt9K8hCwwZB3X1Eci5H
 z4AMeK9yrxtdYqjEWo1uezavCdNE+JFWlmbkRLe2jWqxT/AZDId1rn0P4uUyT/KCF2uQ
 BmgD/DnZaSRr2DC88Y0umP8Ko6E7C4P6x8dx9mnTYkq/p0jY94c3bpRD8AbJn4C9elZW
 8zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713440910; x=1714045710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVRxNyZ0HZ4iSuQ1J+fUHEfJfTWOoqTLrz95VjTZqXQ=;
 b=EeEVA64JaAXo4K2Hrs44xv6MyoZJsDWoAg47Zlr72AfoB+rWgp+34FvkwcMIPNAV0+
 /jUQ4/OK7XQbbojb5qP2dj7giAf9iJ1hmKX4YArDQboo45f/Io/bTpVL6nV0RR0LNnx9
 bPUlY2FX67uy3LIWCyYgCLY0XEZ44iOmrox9Aeijm9Fmc5tXkIKP0L1hkXnmyVeC0gLU
 WifEv3YHy3+3XJyCARcgYDnvQGGFqaKsrm7ivoYSec3hf42kQz2QJv2piqnT5sxN1ACr
 lguvJAyr5nE3B1rIbtU/HZo3j+VFIRkHr7n11tUQalEnRtn7S/CGRpqwQebOP9RD/6zp
 oKXA==
X-Gm-Message-State: AOJu0Yx6+HgaAciNF4UzuxwpiYW0Hwvg5evVPuM+67qGIDfNahkUzUm1
 ZCQXbmt9qFowSpECzApiA6D4Ram6pu0P81219Jxc62CumTXjxdlDXS7i+ZCYY8dfBo2FDpw61hV
 AiUdl9DIKBvXh5pOEuKhAhaQZD4g=
X-Google-Smtp-Source: AGHT+IGnqrDiNENt2RCbmiWzOHFfTcFohBJvcpB0F85/mGZMuyJBLRbJOO1mLIEtOPDHR3B5QNlfQz8uUGrcVDdwadI=
X-Received: by 2002:adf:a4d0:0:b0:34a:31fd:51c with SMTP id
 h16-20020adfa4d0000000b0034a31fd051cmr219201wrb.6.1713440909847; Thu, 18 Apr
 2024 04:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-6-patrice.chotard@foss.st.com>
In-Reply-To: <20240409150215.2497778-6-patrice.chotard@foss.st.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 18 Apr 2024 13:48:18 +0200
Message-ID: <CAByghJZG403R9g0S+Q+aDgiCh74j_JzY+CXydv33mLCjSwFjLg@mail.gmail.com>
Subject: Re: [PATCH v1 05/25] configs: stm32mp1: Enable BUTTON_GPIO flag for
 stm32mp13_defconfig
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Tue, Apr 9, 2024 at 5:05=E2=80=AFPM Patrice Chotard
<patrice.chotard@foss.st.com> wrote:
>
> Enable BUTTON_GPIO flag for STM32MP15.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>  configs/stm32mp13_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
> index db09e63100e..caaabf39ef3 100644
> --- a/configs/stm32mp13_defconfig
> +++ b/configs/stm32mp13_defconfig
> @@ -52,6 +52,8 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D-1
>  CONFIG_ENV_MMC_USE_DT=3Dy
> +CONFIG_BUTTON=3Dy
> +CONFIG_BUTTON_GPIO=3Dy
>  CONFIG_CLK_SCMI=3Dy
>  CONFIG_SET_DFU_ALT_INFO=3Dy
>  CONFIG_USB_FUNCTION_FASTBOOT=3Dy
> --
> 2.25.1
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
