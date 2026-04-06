Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E721BF46C5A
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3422784129;
	Mon,  6 Apr 2026 18:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EoZuR9Bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 178A883E36; Mon,  6 Apr 2026 17:52:23 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1FAC8341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 17:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-66e6f1d8237so254728a12.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 08:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775490740; cv=none;
 d=google.com; s=arc-20240605;
 b=BDT3Gkd0YmthUPG3xhbRcbA7DspssmCSYZ58PJYNhgwI+9/bLMOsVUwsVEPfQHD0mS
 kCb4BKcY522iKbh6423Rev6yDtGOZGOTmMH93EVRAiNnYCOsZQjaRdh9wj5FdkTB4EbD
 bbbyb1dx9M/263bdnLHscGMGoQ627PjpXBrGG7s6Zd00RnlHWDk1Wl8LVoGkaH0uGcju
 7IlEUmU6sJsira9EcnfiSM4FDjVRz0pswXlh/5jBFAaBEq6NEW09Yl7vc2YgwtKyXgGt
 0gPQYrQWwNPPzFYBwvQdBAwlvB0K5vvSGW/9W/zK7b8k3NBLLv1w1+mzeCUAO+/U0LGw
 0FXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JJF8jaR6aywbXxo297MKPUhu/HNh7hwEwE4Rdmvx4c0=;
 fh=lajVl/IeoACZS/6yuLfZkN/hPyImAZ81vhSDRfkAdyk=;
 b=MuKbOK1Co0N/v2AYKzh5dekoYqPW1hfQfqC/RyyHWMURGqPT9bAVW6xIpVysyt2nZ+
 8gbENLXKdQ5N8BtpmaKV3zPWCxxyjCQSKdZ4PZP1P6R3+gWpo7+geCMgn4nqhWm0i61b
 RRue5WN95MHPkQgTQNs4aou8NV/x2K1pLNQZKrC/OJ7AnEoZoIysdIOdXgV8vSGq39+3
 Erj2YQxLV07NFKoSgyoJ68siyCTGPTqFjC2RoPg6TTtUm9Ymxwp0Tmi754elon3/EEJc
 nRrzVEF007MOqR54hY0q8t7YWQn9cf3ohYFul/YaUhVaq901TozvWh4yPTyArsAy7eXg
 RqGA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775490740; x=1776095540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JJF8jaR6aywbXxo297MKPUhu/HNh7hwEwE4Rdmvx4c0=;
 b=EoZuR9Bp1mHbHo1r+0yKZMrdD4Y0UZ5NcZuMectrARsddQx6ToqFmHjL0wFmTpcvv5
 /XiI62TgulI+7FCbi5au1afkdPpcwYWi47xiAF0wGTpB7D2gEP/WiffnvkO2U2m3YPs3
 UPNSyDtPWo6FwnbHxfR8/oBR0uXkUYU2B3ya8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775490740; x=1776095540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJF8jaR6aywbXxo297MKPUhu/HNh7hwEwE4Rdmvx4c0=;
 b=E9OL37Hk+yg2Lpf9RrifoA7NrMSfD8SVvcjlypOQnTmakofPwkYg2dA+9rf2bDLXXf
 1tJq3hV1priIe+rPNmIafn5Sn33l4WK/AXU46WsWek7SujY7X67vPiNX3Szde3p+DaCA
 4ColCl4J6w132ty5X7wt5GGfDsJeLDu7GtWiuLwb8Z3hHCH7BROlVqdxsEl0MzjC02nX
 AapZcbxH/DT0rN1Hq5bMtbQIQkO1k2kQkXSGYyA3UYvcXm9M7Hpju02B4y1vgj7uTDX7
 Fd8mcyxjB6n+BPsZh03ykoB3vsr4lqUTCuVJS1RD8HUBPXbbFB8u7U7dyXwC7cAshCqF
 YyjQ==
X-Gm-Message-State: AOJu0YxapSPv85vtvdoaXauCdcZNP7hdD3A/ag2Ez+oPPphsue8tP2GA
 rQUnDBPXs5kweTRs8g0ZaBsjclIXW44RGQpnXEOLckaUEqLsuBiAIHBGeoxmTCScQYt4sYPUp7b
 APyxAHRZcy4cbufuU7TBWUNWQpsZzg5AR/qanEa9Q
X-Gm-Gg: AeBDietqTct0zYe0QEP6RyxqIAQgFcVFx9h9NqOYxkhuZhr7/g4lisM9MK1WekDRlji
 xt5KRdV2U0r57g/E48wbk0nGUgPI9YTLw8ZH//xKU4qS+IWVwh5C0FQC6WoughCFQ9K+sFDTGzo
 /09G0xhDlRBJ6B/FQqAx7PbW8eb3oXgC+2nHs+/32BQoSJycYFCwEYF92fcaH+BiQ8Q3S4Uhvil
 tFaxUBUwW5gVBaLDx2vEPWvR2DMofohzNG6yV9KWDm1DRtYIzOFQAg/FRHE7q3mMBMo9qPUWbhq
 OPWTRA==
X-Received: by 2002:a17:907:6e8b:b0:b9c:a451:33cb with SMTP id
 a640c23a62f3a-b9ca4513bbdmr360820966b.22.1775490740195; Mon, 06 Apr 2026
 08:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-3-9e6c2ac66587@seznam.cz>
In-Reply-To: <20260404-qcom_spl-v1-3-9e6c2ac66587@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 09:52:08 -0600
X-Gm-Features: AQROBzBmxbPV8Mh9Cn--cRRRLc1W2AmaotK7U-8okRnL2LcGs-a8sxk9FKxnLr0
Message-ID: <CAFLszTjnLyjnDMEBJWQWb64m+LnnDcUNayAFEt4pMK0Bs0Cq2g@mail.gmail.com>
Subject: Re: [PATCH 3/5] drivers: allow clk_stub and spmi in SPL
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
> drivers: allow clk_stub and spmi in SPL
>
> Only Makefile and Kconfig changes necessary.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>

> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> @@ -114,6 +114,12 @@ config CLK_STUB
> +config SPL_CLK_STUB
> +     bool "Stub clock driver"
> +     depends on SPL_CLK
> +     help
> +       Enablestub clock driver in SPL

Enable stub

> diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
> @@ -8,6 +8,12 @@ config SPMI
> +config SPL_SPMI
> +     bool "Enable SPMI bus support in SPL"
> +     depends on SPL_DM
> +     ---help---
> +       Select this to SPMI bus support in SPL

Missing word: Select this to enable SPMI bus support in SPL

> diff --git a/drivers/Makefile b/drivers/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)SPI) += spi/
> +obj-$(CONFIG_$(PHASE_)SPMI) += spmi/

This alone is not enough since drivers/spmi/Makefile still uses
CONFIG_SPMI, not CONFIG_$(PHASE_)SPMI. During an SPL build with
CONFIG_SPL_SPMI=y, the directory will be entered but spmi-uclass.o
will not be built. Please can you update drivers/spmi/Makefile to use
the PHASE_ pattern, similar to drivers/clk/Makefile.

Regards,
Simon
