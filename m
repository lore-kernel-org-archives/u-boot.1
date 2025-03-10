Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C4BC28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82A8811B2;
	Mon, 10 Mar 2025 14:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TDPJIV8G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BABD8129F; Mon, 10 Mar 2025 14:43:29 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADD180107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30b83290b7bso47605951fa.1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741614207; x=1742219007; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxn5uojbjpPzQX6bI2gJ4Grv/w5HLUantRM1TDSR/Sc=;
 b=TDPJIV8Gi1xPoxK2ykEGbhf8ifgJP4WgHV7332dD+zkLorkp7HF6vKRjY0OU0k5yZX
 YiWC8lnHCH+NBBag60nJIAbI3pVGDtqeZxMEvZyBJk1DQvNLe9NlMJHHJYaPg8CfeZaI
 MLYP7KmmVLylJfqW+Hr9jKR4G0nVZUwdul56q0ac063btM9yuHUSmDUJcg0guVslsLF8
 gkMr7tTPPBQu7xYtwkm4rKnFaKM5IArGzqzDQTjOTqRtNFv8VNADCBsfoLcaDFvFNuCD
 HIMumywTsUU9QvWz252xlqzZVlb86Fr+g5BlWfW0G8sCDeCaEOyULGohZYlRS2uyQf9C
 wzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741614207; x=1742219007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxn5uojbjpPzQX6bI2gJ4Grv/w5HLUantRM1TDSR/Sc=;
 b=tQjbgO9JgzYhcTnXZzcdm8gjkciTqOHEXzKy1DeDcvnB7u26FKDJYGNZJg5zWgoY5G
 6IySfaZzhJ3Egxzdwl35HaH1NfFSNdgC6B0mu5U1IUriHRSP3HjQk2ny7iq4SZhEDSuK
 usxPTnK/ZJLVlmkjPBGUhn91QbEKwe0eXB0VgPb2SYurlkRQhNv+FPKfTmAKhKDmP/vR
 8EKkEOL8gouDUMsr78t3Al93WDkWC3jg0yBzCPanlTHTIhzDWZpq/rQz1EJwMbXoxUhy
 xVP2aqa6OONU9ekEBlYUXvm97RxL/H2Zm3w5xMQianGP8vL6NlChQtFBb13U3aPfRXTR
 v+qw==
X-Gm-Message-State: AOJu0YwVmoTsYSI6OltycRs4Hm+RJAYi2s4G7BYGgqDohUeCD8AijZZG
 3kK8JVDerHfKeskg/yiFS+BLlwu576SH+J7Fbl7PAhotOHb3OweCDu8ldQSh2x6qfqabvFCbp2I
 tPZG6qmOvJxxMuzavh/EXPbIjGNc=
X-Gm-Gg: ASbGncuS678R7TnrrBwMBR4nVsXKN24eXumL9dM9twreKHA2PLBvvYPTxbA7gjq0Dtg
 H6l/bS79dUErcpYyl6wV302nwSygZJEsEP5V4m56WwCbdEV3/PFJDvpw8BP643TnSARgzDPNHXr
 wsB0DVI6HyB0jMV+L3pF8XEhLdMqG+yA42s4M9nGNAhHMJk6tbaY1nMegM4g==
X-Google-Smtp-Source: AGHT+IFrKnJm2cPatqGjEIQYcnCmxJbdQYGUqdkgxrv3BCwzauVgIEFesEBINsopzqHz3dNbfQXd3qkPXqFJsj4wRfE=
X-Received: by 2002:a05:6512:12c3:b0:545:17d:f96b with SMTP id
 2adb3069b0e04-54990e5d38amr4056844e87.14.1741614206355; Mon, 10 Mar 2025
 06:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250310133647.2712374-1-anshuld@ti.com>
In-Reply-To: <20250310133647.2712374-1-anshuld@ti.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 10 Mar 2025 10:43:15 -0300
X-Gm-Features: AQ5f1Jp2tc7mieLA0H1NIVuCN3VBqNOaYdZuDlpAztWx4-tsE8zQTShWhEiYTlI
Message-ID: <CAOMZO5D=x4VLvHHu+0J-k4DN-d3ex5V2OrSViPZnHuvj-BLpgA@mail.gmail.com>
Subject: Re: [PATCH v1] config: falcon: move CFG_SYS_SPI_* to Kconfig
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, trini@konsulko.com
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

On Mon, Mar 10, 2025 at 10:37=E2=80=AFAM Anshul Dalal <anshuld@ti.com> wrot=
e:
>
> CFG_SYS_SPI_* are used in falcon boot to specify the offsets and size of
> the repsective payloads. This patch moves them to Kconfig keeping the

s/repsective/respective

> values consistent for each of the effected boards.

s/effected/affected

> +config SYS_SPI_KERNEL_OFFS
> +       hex "Falcon mode: address of kernel payload in SPI flash"
> +       depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT
> +       help
> +        Address within SPI-Flash from where the kernel payload is fetech=
ed
s/feteched/fetched

> +config SYS_SPI_ARGS_OFFS
> +       hex "Falcon mode: address of args payload in SPI flash"
> +       depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT
> +       help
> +        Address within SPI-Flash from where the args payload (usually th=
e
> +        dtb) is feteched in falcon boot.

s/feteched/fetched

Reviewed-by: Fabio Estevam <festevam@gmail.com>
