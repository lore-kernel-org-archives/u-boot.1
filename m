Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C6AC4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 10:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6599D876AE;
	Wed,  7 Feb 2024 11:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="LKHNtq+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C45A878EE; Wed,  7 Feb 2024 11:02:47 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D2C86564
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 11:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d0c9967fdcso3688581fa.0
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 02:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707300164; x=1707904964; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsM9fn+shOJl2suBWUUAxh4XzrE5KWfR3+MpeAAFmxA=;
 b=LKHNtq+C4WLXiVtTHzg6yHAz8r3+RMrZxiaOLv0N0rQzOn1GQBUOd1TZavyJsLv4ij
 JcgedP7rw3giWisRWmEbtiJIbxGsZVsf+fzu+dIul7eNVuW0hvLX98mEEq+e9cw1zsAA
 a2iz5iaztkqdcxazi1bS8ylFnQZBaP1mwVAVE/BznUlLJd9BnlTP4bSPyB42S8OmwVIP
 ty7xSZdAD02G113y6dimqs3Lf6QZ6Na20lxZ/E6XFdRmQ9a99N+6ZMdhysIdT3MQeY/4
 MwYbOHl8Pec6YaMXUmfVeHeGytsExjQUWs6wDGKletKyXXKOussGi8dPWiDDr4nuHImI
 Vk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707300164; x=1707904964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nsM9fn+shOJl2suBWUUAxh4XzrE5KWfR3+MpeAAFmxA=;
 b=atRllkwy4gBO+yYqpYJoPcYYIiOrCE2K51UJT3L3jwLDw9IXg2TgCgBhDrFcw6Wder
 QZ2qcoEIpftZddLZdLMMxnCPBZMdwt5o6cfKod26ATNq8xNI0GwLE/ZwK0z+EK38zfMN
 Kz+4F+3i3gSrFVafjOL/wp1y7p8cU8b6ZE9QH0+/DG1tWJlqHgG46IeludnAJKcHCwf1
 bLZk4qOZtJZu3b2/I0a8B5lQEDeosxQjaRB59QMOoGnXQe4cf16H92e0T6bNvkk4sdQN
 nePGbgIK2pAiQPFKcmNoWU5Cr29u5ixNEBcCoXutXAOST6/jdi5etDANABlZU9yjufK/
 z3fA==
X-Gm-Message-State: AOJu0YzDa3yEzB12MWD7fJOWBBXTPqb8U7N1jTi3xJG8KavqZANoAl1I
 2kJ6S2JBx34zTUba14UpbyvHeZWIPFeoVr7bX40Sfs89tYK2KhynUgpqiOAcQquXlQNmbq2DwgL
 nKvbItgVTvbsRgDdTQoZSH4wKLOB4Du+A2G4kHw==
X-Google-Smtp-Source: AGHT+IHkg5NA1JD879zw7GywN1hvH6C/X8lD7y9/9nX2PF5rfJhBintVW0ZouCzSRtU7+w6rHUSjS5jgilroTHT7BdA=
X-Received: by 2002:a2e:7c0f:0:b0:2cd:1c04:4f6 with SMTP id
 x15-20020a2e7c0f000000b002cd1c0404f6mr1798631ljc.24.1707300164514; Wed, 07
 Feb 2024 02:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20240202002448.1116407-1-afd@ti.com>
In-Reply-To: <20240202002448.1116407-1-afd@ti.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Wed, 7 Feb 2024 11:02:32 +0100
Message-ID: <CAL6CDMHuKEvhpMkwTgTMofcmj7iiX0SAXyVNcBeYorZJAFuXTA@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm: mach-k3: Move SYS_K3_SPL_ATF definition into R5
 Kconfig
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Andrew,

On Fri, Feb 2, 2024 at 1:25=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> Loading ATF is only supported from the R5, move the Kconfig symbol
> definition to match.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-k3/Kconfig    | 7 -------
>  arch/arm/mach-k3/r5/Kconfig | 6 ++++++
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 03898424c95..45cf740bb1f 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -114,13 +114,6 @@ config K3_EARLY_CONS_IDX
>           Use this option to set the index of the serial device to be use=
d
>           for the early console during SPL execution.
>
> -config SYS_K3_SPL_ATF
> -       bool "Start Cortex-A from SPL"
> -       depends on CPU_V7R
> -       help
> -         Enabling this will try to start Cortex-A (typically with ATF)
> -         after SPL from R5.
> -
>  config K3_ATF_LOAD_ADDR
>         hex "Load address of ATF image"
>         default 0x70000000
> diff --git a/arch/arm/mach-k3/r5/Kconfig b/arch/arm/mach-k3/r5/Kconfig
> index ae79f8ff6cd..317a6c4b67e 100644
> --- a/arch/arm/mach-k3/r5/Kconfig
> +++ b/arch/arm/mach-k3/r5/Kconfig
> @@ -43,3 +43,9 @@ config K3_SYSFW_IMAGE_SPI_OFFS
>         help
>           Offset of the combined System Firmware and configuration image =
tree
>           blob to be loaded when booting from a SPI flash memory.
> +
> +config SYS_K3_SPL_ATF
> +       bool "Start Cortex-A from SPL"
> +       help
> +         Enabling this will try to start Cortex-A (typically with ATF)
> +         after SPL from R5.
> --
> 2.39.2
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
