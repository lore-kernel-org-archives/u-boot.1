Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C96C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B0BA8380F;
	Tue, 27 May 2025 15:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zcu5WALS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F0C8381D; Tue, 27 May 2025 15:17:27 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE2C5837FC
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-549b116321aso4564312e87.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748351845; x=1748956645; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uYiDilazvMj9mJG04Oyj8m/Gyq+tIzHEtaUevPmfZU=;
 b=Zcu5WALStE+hCUWZdR/8R81nZ37OqeXvQgJ9Vo22JglVtC6F/Zi2XQFejiPAuZ238f
 68/cTCcvc/BnPRCoRB7Az1DiLNogtBf4T21Lyordkrh092RG8Ut9xW6oQ4Yta5l5bO9+
 K0348oKJ2lgaTYDAc0iHxt07fqaSXnCEsLQw9/HBxep6j5DHpUX/oisfjNj+FnsAs1FH
 PprY5e/Vy1O9C+p2qrixVqX/rbhEoMe3JnFFNIoYHYG5XA9nObdNF6h4qBTAKKXHyGaH
 wpSS/1b/X1m7AzumUtqUqG2Dj9EAJzJ+HykkGU2TwC3gpAceUGabknPczGZrPqy8Er/0
 QbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748351845; x=1748956645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uYiDilazvMj9mJG04Oyj8m/Gyq+tIzHEtaUevPmfZU=;
 b=aTwdfSQ9cn26MGaBz28rDbyRDuPI2HsDfwQ/EBeg9SSPXO+eXi/CoobS/ht7SJJwZH
 2IT7Eg8BlNhfS/WPc/GICgFrCIxmCmeTN/LOvkGaL0qnqXT7uM3hqF/n6dXS3IcSbOrk
 /2BeBX015l3xIvbgKZx29YPxiFcR01YuvyaZnaW13o9Vm2qlYhIUJ0YmcqW1OmkWuNPb
 xoL3xBMNimAq8UtUPArVfsCduShBD5zBtMtv8SONcFCGx+wedIPhvKScLnyYWREqbN79
 EsC5hbfl+riRJneq4PKuE53joBelas3rdnf2tJyP9TQcpay54ah/kW+naERt4pPW61Kb
 oJhg==
X-Gm-Message-State: AOJu0YzDJLOg0Jx+utea3u1GOxpYrcI+2AgimHUqsRU+6Vb0PW3Nyvap
 4r3g8t/LHMiuCMVNBhAU/sp7vdbO/Z1fw3d+TJzX9iFWhtFCGfmJXRHKO4xlcEv+97lBDO5Te5J
 IpdhTsFOppyIOVxqDILede25peFNpNeY=
X-Gm-Gg: ASbGncs8TMEDXH/MbXPbc4xbIDo4xTNI3ZigG9bIcCElUapYhmDleDHanVosWGoSEJw
 Gi17eIO9Ziq1FFLWL6dedxqO3WqP6Qdx/SAuP1YO/0eGUIWm71/DFbElgS7xjH0mC3sQrknCuxI
 aprse/wWHhdnpgznpfx0PpHO/+V+CORGbpz3lQniBFAtT+aO9ImruQQCtQbqaPTWpP
X-Google-Smtp-Source: AGHT+IGIsHrmsiQc31Etk2mqqb9LinsMtMjbQ/PQxXWLboSUJTijcg4z46pRSNUX8iK74qcbzDU8NiuWeQ8ySDox+Zw=
X-Received: by 2002:a05:6512:3b28:b0:549:b0e3:925d with SMTP id
 2adb3069b0e04-5521c7a83b8mr3878941e87.7.1748351844183; Tue, 27 May 2025
 06:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250526195844.1180801-1-michael@amarulasolutions.com>
In-Reply-To: <20250526195844.1180801-1-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 May 2025 10:17:12 -0300
X-Gm-Features: AX0GCFuZ6CQNdqX7ylbsUfl-hRNplbGomiPBKMwdpkFGq9Xz7zB7IhHQU8XL8nE
Message-ID: <CAOMZO5B4swwwxULQrbYzsmioXGY5Thh2Q81OjtfD97__JJsc8A@mail.gmail.com>
Subject: Re: [PATCH] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2B board
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Sven.Dembianny@bshg.com, Simon.Holesch@bshg.com, 
 dario.binacchi@amarulasolutions.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Michael Bode <michael.bode@bshg.com>, 
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
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

On Mon, May 26, 2025 at 4:59=E2=80=AFPM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Introducing the BSH SystemMaster (SMM) M2B board. Notably, the M2B is

Use imperative mood: Introduce

> designed to leverage the existing device tree of its predecessor, the M2.
> The primary distinction arises from memory incompatibilities with the M2.
> To address this, we've implemented a configuration system that allows for
> selective inclusion of the desired memory components

The full stop is missing.

>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> ---
>
>  board/bsh/imx6ulz_smm_m2/Kconfig              |  21 +++
>  board/bsh/imx6ulz_smm_m2/Makefile             |   4 +-
>  board/bsh/imx6ulz_smm_m2/ddr3l_timing_128m.c  |   1 +
>  .../imx6ulz_smm_m2/ddr3l_timing_128m_m2b.c    | 152 ++++++++++++++++++
>  board/bsh/imx6ulz_smm_m2/ddr3l_timing_256m.c  |   1 +
>  .../imx6ulz_smm_m2/ddr3l_timing_256m_m2b.c    | 137 ++++++++++++++++
>  board/bsh/imx6ulz_smm_m2/ddr3l_timing_512m.c  |   1 +
>  board/bsh/imx6ulz_smm_m2/spl.c                |  37 +++--
>  board/bsh/imx6ulz_smm_m2/spl_mtypes.h         |   1 +

The MAINTAINERS entry is missing, and this causes a CI error.

> +config BSH_M2_MEMORY
> +       bool "Enable for bsh m2 variant"
> +       help
> +         If this option is enabled, U-Boot will configured to support

will be configured

> +         imx6ulz bsh m2 revision memories.
> +
> +config BSH_M2B_MEMORY
> +       bool "Enable for bsh m2b variant"
> +       help
> +         If this option is enabled, U-Boot will configured to support

Ditto.
