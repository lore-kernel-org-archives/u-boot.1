Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F97F46C59
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCFF0840B0;
	Mon,  6 Apr 2026 18:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hqs+R8cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF27684034; Mon,  6 Apr 2026 17:50:40 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B3F8341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 17:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-66f2ea5c500so786745a12.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 08:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775490638; cv=none;
 d=google.com; s=arc-20240605;
 b=jW5kbQQiKJ/qmZEKaXNMYbPRnAyKk6SaP3FnwAIk6N5hCEtOlQpklLakRO+eQhhHAm
 SWhnREceWw73MMz00MCREqdFlDOexlwbmA/XpK0Gz3ZYAQGuW6NA4XTZtxB172iqR0vb
 Ef/dji1rQMjcGnZqlCRjA0+e1eV8soSGZ0DROVwTnwbsKvMpqO8IO/eK7TwNiSD9DmCL
 iTg0ImEaqiwx3Nc2vPqOYEWvLVowYd021NWY5TgKhdXfAkhoJpgsF0DLzd580A/ntw+W
 aWPF1jaPU4yScppleiiiXzTkC5TbdEjqkvR1B6kRVFsPQKDs2kFD1QRABaYn3UcVVpA4
 QlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ro4aHxkzCP7OwUGYL7lZuP+4Z5duDwb3/XNs+brNyhY=;
 fh=lajVl/IeoACZS/6yuLfZkN/hPyImAZ81vhSDRfkAdyk=;
 b=C9uCQr2444aylQJ/sr79nbPsLztQY56GBf4GHt9pnCmltCZQWldLrf5nAcBzn4I0Ky
 fUGSIWHzAP06d4b/nrbaQJuUIZ5OnUi62qU641eV9J0MxKAcJyVLSQdwWAloYz4uWKSd
 5PhkPfArhWBYftUaGGK0YMvDyyUE/tAct0Fb81c+ZVWv+OD1ZIDwOMRdJKTXsl5vYXSd
 gGNlvxjPnnV887ueA8t+Um3Rzji6qe4mRiGATpwoyGO3IbG9c+0SL1WQp+dvOTjGqytc
 rM3V4qX+b2NxYYK3hABOsmkwnltoW6qG4lsaap99XSOlIFuqj0QNPuxrCJHlSn7a5b7j
 uhkA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775490638; x=1776095438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ro4aHxkzCP7OwUGYL7lZuP+4Z5duDwb3/XNs+brNyhY=;
 b=hqs+R8cfwFBFS6w0Ir5mICAi7uwXuOtfOI083hu2XnQ9cGModkYmBXYtUfyMQD0M3B
 N57QuhcB2qhRIcslB/FPI25qrB6dcd5C33Rx/C3CnwPMbadZEgNH+qAQk3rVeY4xa20o
 k5HYWT5pllROQ/nqu+j9miKOlslzIZs6Ev6fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775490638; x=1776095438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ro4aHxkzCP7OwUGYL7lZuP+4Z5duDwb3/XNs+brNyhY=;
 b=eQkryptyykD6fZendntDAjZOjqiU6ipFsnRuLQvTgeSU1fvKwAUi/ycDz+zcfJiYae
 PTSqwTg2eGYMrV2hMCBVrcs7HGkWz9Y+UAJ+eF/iFtW32P0ILWdztj1isaUabFP4GVNp
 67n525QX00xU2H6JsnJIB1BxmAHWyMB026KDW1KSLYxNTADGv2CjrdwAiPQL9gNN5JX9
 +ifqud1xAkkOG9LXmdzzkpakx6jqs2KbM+aawYIg7jbPHrDGlUnDGVPTUZeC465kGbj2
 R+BIMGN9NhK5/MgmPly74FTaSwVk2DsNqb/aOFoERN1ip88t/TdqLtoXJ2FM6ix+Wqka
 uv3Q==
X-Gm-Message-State: AOJu0YwXN1VYynpOuK3JjHXNu4lgcP2DQ4TNk+SDsBpBPmfc7GgfSt4E
 418vysbmmjKkGcw+FhlDU04663X1QjJ/4/e2yK20yHipuzLG5fkzk2F2QSSGiB+MegDV1jRalnP
 Zs/nmGCOtmHckhUFcXqwSpdJaw0xFZotn0Ij5sSK+
X-Gm-Gg: AeBDieuJvMcn9or3/kctVYCnTbRwCHHi+aoqcjs8xr/vRpEpCNbrJ8TSvcHEWMzCzBA
 xeUmCccacNu6p6VDPV/5PRufpb2WmoRpBMiVe06ybqnB9mGvwmQc+NHmsUt8nMLR2Qp+4b+A+Pp
 Yc4l/lz4pMbzS9OBcfX/ZYgfizM/x4DFse75wqCA42dlX/kbPKmyVmE3ZMnbDxyQRlxjevZkuo5
 zWqKHbBhm9BykhEYM4MMra+R8c7dg4WLhNxlTHWGX3J1sOvBt/kWsdmoGL0D9iqtjoLZklt6J0n
 rtSQwQ==
X-Received: by 2002:a17:907:86a9:b0:b9c:b475:90f4 with SMTP id
 a640c23a62f3a-b9cb4759648mr293425266b.29.1775490638095; Mon, 06 Apr 2026
 08:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-1-9e6c2ac66587@seznam.cz>
In-Reply-To: <20260404-qcom_spl-v1-1-9e6c2ac66587@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 09:50:22 -0600
X-Gm-Features: AQROBzBBShKHbIYgE3Owi8kVprbyXKn-WAZIslbyfYIdF4jh1RXvpdA5iKQoXmY
Message-ID: <CAFLszThhVEp3EH1Rqb6acPzJ6TbPc0p0thCG0+PHHCruKGz=iQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 06 Apr 2026 18:50:33 +0200
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

On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
> Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
>
> On some platforms (at least Qualcomm), the bootrom expects an ELF file.
> Since the contents of the ELF file are platform specific, add a config
> option that allows specifying a linker script to use to produce the
> ELF file.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>

> diff --git a/Makefile b/Makefile
> @@ -2014,6 +2017,26 @@ u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
> +quiet_cmd_u-boot-spl-elf ?= LD      $@
> +     cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
> +     -T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
> +     -Ttext=$(CONFIG_SPL_TEXT_BASE) -z max-page-size=0x1000

The existing cmd_u-boot-spl-elf includes $(if
$(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) for endianness. Please can you add
the same here for consistency.

Since this redefines cmd_u-boot-spl-elf using ?=, the earlier
definition takes precedence if both SPL_REMAKE_ELF and
SPL_REMAKE_ELF_LDSCRIPT are enabled. This is probably fine since
enabling both does not make sense, but maybe add 'depends on
!SPL_REMAKE_ELF' or a note in the Kconfig help text.

> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> @@ -247,6 +247,12 @@ config SPL_HANDOFF
> +config SPL_REMAKE_ELF_LDSCRIPT
> +     string "Linker script to run with u-boot-spl.bin as input"
> +     help
> +       This allows specifying a linker script that will act on u-boot-spl.bin
> +       (see also REMAKE_ELF)

Can you explain when you would need a custom linker script rather than
just using SPL_REMAKE_ELF ?. Something like:

Some platforms (e.g. Qualcomm) require the bootrom to load a custom
ELF format. Unlike SPL_REMAKE_ELF which uses a standard linker script,
this allows a platform-specific one.

Regards,
Simon
