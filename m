Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C32E937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 165F9839D5;
	Sun, 12 Apr 2026 15:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a/fhPTeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D66B8416F; Sat, 11 Apr 2026 17:39:42 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B0BF80077
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 17:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9d6c8871c7so403751466b.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 08:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775921980; cv=none;
 d=google.com; s=arc-20240605;
 b=Y3h4/5DB5hDYOgjXxuL3u+5NeQEvl5xDOAkfzmTxFCPWktq3S+VqdOGAMIWc0u8frp
 gcttYscBvpYc83vGFE/ARXTCxQjXa7U0gDvOoieqQJ0cMsPtD1msDQ5uXILjMkiPtlug
 oFqzA9FCqFncZNwJQwntgeTyFvxtJRh8gbDoCdpiLwTRJDxtv+m/cTNkntyozgyk/kct
 6oY7oY8EEIfTVgEeZQcOy9NsuQ1yYPQpFNLAJC69xlPN9NY1lYHhzTpQLmcB7zYghSYc
 Oqzh5rwmtc4eEfVZCbFkuHDUaVCoB+tNCWqOMS4d7GMZznHY/9zDr7fLqlF7WrthxKuY
 9Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V2XFsxVY61ZOehtsAflcp7kp6qqkg3eOLwRHMBQiMpQ=;
 fh=pKV29h6PBf5SbuSFTM/GZF+KoVG4OaOclZXc+5Qi1tM=;
 b=KyatlDkvKN5EU4KWjuUgQR+4EHbY1RwPankQttChkvUC0WolbeAjeO69QFYHDC35hz
 baXYeBaacLbPJbsu4nqsz+2EKVlpRNGYhZwv8ZOX8s0sEYhcI52ZwTZWqIoFk3Wms6vw
 yCfm/bMmF4JzXkFJICncMnZrF6b/lwv6Fe521l2G7cPnRWZG/hP9+v/PA6luML3IvDAi
 WVgDPO5OrdOvsDMm7e6ECdDcr/jHiJK14Zp7GRgnAEtwQP4gKZc3Jd/XIkhDAbvtblUA
 V21uX1oxCw9o8FrSnGDtvHzTuImGfsWFsDvDSNAYZOSu+6IUzI0sxmOS34gkSbyZgMZb
 f4/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775921980; x=1776526780; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V2XFsxVY61ZOehtsAflcp7kp6qqkg3eOLwRHMBQiMpQ=;
 b=a/fhPTebKEvLMLPo6OOpG0GXfWa/ChN1mUzeDCSUDbFw0leoxgJUXO9OswqV3dC8Qo
 /6tkdX+U6CC2+UoYGbNnBtLcDt6jIwa+EsbUlL+RZGJUY31lzMv3y+FJCWcNvFJKwOy1
 nYsKxdCCYBlJIGrvF1IyO/mfxCriN15VHhR0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775921980; x=1776526780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2XFsxVY61ZOehtsAflcp7kp6qqkg3eOLwRHMBQiMpQ=;
 b=A13HPtWFqAKdYWQcyTIsMld3w7nnzgDOM5mYTDVcLbKUb/zN/TkfH+6Pem9VMOmUWC
 FSCXqbz1sLUAsviD9CDTOTropQqYC2TsD+L2pU155CVWnYjfXXsWJTsdyJ9kBqlAyj1t
 3xSn4qqfCglorL3WabWNrGnUEMID4gcd8dlv2RdTz5rr9DwrS/KQk5TStJgpL3n8EA6E
 itYTlqayCel5DLAY0k297wxajJvsaWQiwp6nnt9ZZG5qDqKUEItjZyUlmRq4Ht1MlhnF
 O0u+uubt5lmRFSPBT61J9bK9BSlCPfRaxDfDzXaRWx3gd7W6BgFSxHS6/87z1g/YdqaF
 IRIg==
X-Gm-Message-State: AOJu0YwoiYYY2qYqqRNZbMnjdMyYaLDjQa7/UfWlHsqF35vq4ex9rfOC
 iVgQFlp/63c9MBBeC/pVN2yo9KP3qQ2phgjA+82bXwjdIDtk6xrINn8Hut3ImR4vO7BfwCQ0POk
 ShFxG8z4kOA42yeuC7QYmiyNJrTW7VPWOVrb881OJ
X-Gm-Gg: AeBDiev85mUkzf8mVjjrW2xdhV+zegB0nBGuMBYgW9PWJqQBcinseR3zdqHWt/G1H48
 yS3imnIpq+7EXnILAqwXoShYKBUDQveTF3eepDCItWgKN/xocXMCHS3Dw0wkA9xNCNwgVw/+uML
 hSY75vvxtKKqgfZLMgg69ITsnJpOs6EYbPrrhaAE9g7c/p0zd0cjyzjyWbHaMCs1kwyq1LtSHpc
 cpPmoM01OC+1IKqODvTMJeslD1EOyfL9LdRg+tnq1kvcgR6yqS5AivK0crvSkCq9Zv5muc6Yqtp
 V3Rt0w==
X-Received: by 2002:a17:906:9fcc:b0:b98:6926:13cb with SMTP id
 a640c23a62f3a-b9d724361eamr408054666b.9.1775921979602; Sat, 11 Apr 2026
 08:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-1-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-1-9609557cf562@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 09:39:28 -0600
X-Gm-Features: AQROBzDIqulapGvlO_mo4gegtVA2FJ4DkD4uspbXl9EVcyK7ItXItOdaiSRNyek
Message-ID: <CAFLszThnheL9McSdWqdEZzU7tFVsENC8P5txbf2sfU3-9VfDbw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 12 Apr 2026 15:00:19 +0200
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

Hi Michael,

On 2026-04-11T00:00:12, Michael Srba <michael.srba@seznam.cz> wrote:
> Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
>
> On some platforms (at least Qualcomm), the bootrom expects an ELF file.
> Since the contents of the ELF file are platform specific, add a config
> option that allows specifying a linker script to use to produce the
> ELF file.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> Makefile           | 28 ++++++++++++++++++++++++++++
>  common/spl/Kconfig |  9 +++++++++
>  2 files changed, 37 insertions(+)

> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> @@ -247,6 +247,15 @@ config SPL_HANDOFF
> +config SPL_REMAKE_ELF_LDSCRIPT
> +     string "Linker script to run with u-boot-spl.bin as input"
> +     depends on !SPL_REMAKE_ELF
> +     help
> +       This allows specifying a linker script that will act on u-boot-spl.bin.
> +       Some platforms (e.g Qualcomm) use the ELF format in creative ways,
> +       including in the bootrom. Unlike SPL_REMAKE_ELF which uses a standard
> +       linker script, this allows specifying a platorm-specific one.

Typo: platform-specific

> diff --git a/Makefile b/Makefile
> @@ -2010,10 +2015,33 @@ spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
> +quiet_cmd_u-boot-spl-elf ?= LD      $@
> +     cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
> +     $(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> +     -T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
> +     -Ttext=$(CONFIG_SPL_TEXT_BASE) -z max-page-size=0x1000

The -z max-page-size=0x1000 flag is only added to the new path. If
needed for correct ELF generation, perhaps add it to the existing
cmd_u-boot-spl-elf too? If it is Qualcomm-specific, please add a
comment explaining why.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
