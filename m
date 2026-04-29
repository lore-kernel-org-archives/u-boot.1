Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C53FF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 17:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99161848E3;
	Wed, 29 Apr 2026 19:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WpOo3iD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 056D7848DA; Wed, 29 Apr 2026 19:15:54 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B6F848E3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 19:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso12802366b.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777482951; cv=none;
 d=google.com; s=arc-20240605;
 b=EGg2uDdHIltCO1shUJ8qNz0jUoV61l48P037VimNN+JC8rLcTeZDqBoDFJbU90hSN0
 LZhOA/nwPib9jPDVIgLT3FFaqW6qieYfRCX+cKBmAXZe9M41EniNgAE9So/6wiBBl0aa
 D1XdnhS1c3ccdMcV9GlWhqZtQnMTTHJJJbyQN4wUEv/H6FcBSFMQY400I3nIGMenMZMX
 Yzc7c6XWzmbGxMmVrpbO+oj4jeP1TZ9Ouhpyre4jCLBlc/kMW66+95Ng66rAlS7HTUTd
 jvYsNRkQhZNlO0odvQPlFt8nR7z4KQfSz1twuO+Gmy0eCKz5uQ4bK/hyBWmvBLfRMIFn
 D05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LKZt+EUDNDlqVqpI5cAP28h2ZHC5stxPvVoU6xcUKk0=;
 fh=+/pNFDyGYsDJMoXpsFeigOK5l3QyGzKdfAevrQne9bY=;
 b=hctVe6Mjt/1eVhcxnUwNufgL/Ik08tbf130MnrIBp2BZk+SzWm7BynmEEmuLmW9UQE
 PVN5s+DL6nZ4OcZUPLx+/Sd/x4I7n0HNY0q0kgQNqKBke17PTPSqlJXI06n2+tmn7zr8
 PvZRKmP6QA/WB0TSPPsaUVAOKwMSia7OLwlxRIdioxyg5Zp7tPQUOD9dqvEQlQXWc7RB
 4FAncgKZWZRPyswwpyEdrzxc9khT2V6SUFGi7tgssPl2H5zZpmIz0Rx+2gLNSLcZic8W
 bzJTiTQJDJG1zk4k6XFH4pds9naHN5CwF832Yu47HVjCvPBdO1ihzMyoDkT5cFyMvygh
 GkVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777482951; x=1778087751; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKZt+EUDNDlqVqpI5cAP28h2ZHC5stxPvVoU6xcUKk0=;
 b=WpOo3iD4NIcciOSjt2ySBmyTOT3wljCOxyHvCQ0oKl0ETfN4NMilniSiwmw+9PUZxF
 0DMwcGCR7vqU/H51vDp8wwPNjPy6Bk+3RbjgkBALXJSYY1x65T6bcq2VInn4GLTaoLoW
 ThQYHR7vms8ReiNn5mXO9ke0IdAqGztqka3k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777482951; x=1778087751;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKZt+EUDNDlqVqpI5cAP28h2ZHC5stxPvVoU6xcUKk0=;
 b=oi9iFp9SM6Q4KKVDzSDdCLkaqPRzktwKYxs+AJfD2cWt3+hUuubOf7b9L+hp+fkJeu
 tPMKMot1LY/Li9weasB0LWdxDJNbJ/KHoJDs7adNvCNOHG6zUnxTwLLGxcbHEFvQCKqJ
 UIgQLAHdCDo8pblSaxkVTIDMkVQ5RkFmnSc9XyTVdPNle7bJcvQgYG33ww15jl5wXqR4
 9mc8Czd/BXlxMu0OnbVRs4/pqu1mIdgGjw7nmve162U3/XSCY9hZlQOvPgbDBiBXR4c9
 8LQO/rOd2D3MNNqpVOz70+z0ym6JIastU5K/knsLf99qVoM2j7MLGwmj2xrgfcBzl19B
 ldNg==
X-Gm-Message-State: AOJu0YxdIjcVy2FKekoO7LBQSLBJv/Nafu/VhFqO2TrOdnM0/myl1hNk
 o/zpXBIWGymClOr4h7rOxkXu2Glxh+azq9/cSGeY+xdykWa9Z1v9QeQNX7XuRNqcr4+FiNpa7FI
 74YhZNcszS4p8VB07utwD1hPGL9tuVXm8xveSWtNXbqyxHRf9cBvrkw==
X-Gm-Gg: AeBDievqVteeE7M9JBFaCTG/fEbiy8314hG2iDvXB2R/jB+hU9izT+qUPdw0jdJzcfV
 Wrtit2dNdNGmokv7b3sTnODHeWAWvC2cMbBq90X07nQThLZFhgmJYyJFoGIxxOu06KptXnFp2eR
 7wIQ0H8RuMd16s6DC2IwRbcEUP65grRY0jjFa04iK+NXO0leobkiRIzruaFtZdIii/EJYbu2QeK
 5mwfNjlXr4LsonTeHnrOAcvtLGZ4KQAbF5SMDJuzQh3pdykJu2/O7hzeFcEyU2Vt+5pmOoNSdzK
 TfYlr4d+SoHzzIetPXqge4RHc9TekMfNw5CBY0zKfavhW2c/tVVf
X-Received: by 2002:a17:907:3e9c:b0:b9c:ba09:db7d with SMTP id
 a640c23a62f3a-bb9596ccc76mr224071566b.20.1777482951577; Wed, 29 Apr 2026
 10:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
 <20260429-sys_rx_eth_buffer-no-net-v1-4-396ef37ae93c@cherry.de>
In-Reply-To: <20260429-sys_rx_eth_buffer-no-net-v1-4-396ef37ae93c@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 05:15:39 +1200
X-Gm-Features: AVHnY4L9QOhVGc1X9_AfGtvZITB0QS5-O73ORYthZp15WQXhJFx211r1Hrcyo6Y
Message-ID: <CAFLszTgYEUuvDtVK0z2UOqx_q8xNiganUjjCowNmVS9uXJXTfw@mail.gmail.com>
Subject: Re: [PATCH RFC next 4/5] net: guard SYS_RX_ETH_BUFFER with NET
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tang Yuantian <andy.tang@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-04-29T10:35:00, Quentin Schulz <foss+uboot@0leil.net> wrote:
> net: guard SYS_RX_ETH_BUFFER with NET
>
> SYS_RX_ETH_BUFFER represents the number of Ethernet receive packet
> buffers. It therefore doesn't make sense it's reachable if NET isn't
> enabled.
>
> Direct users of SYS_RX_ETH_BUFFER are:
> - drivers/net/rtl8169.c, only compiled if CONFIG_RTL8169=y, depends on
>   CONFIG_NETDEVICES=y, depends on CONFIG_NET=y,
> - drivers/net/fsl_enetc.h, via ENETC_BD_CNT, included in
>     drivers/net/{fsl_enetc.c,fsl_enetc_mdio.c,mscc_eswitch/felix_switch.c}
>   First two only compiled if CONFIG_FSL_ENETC=y, latter with
>   CONFIG_MSCC_FELIX_SWITCH=y. Both symbols depends on
>   CONFIG_NETDEVICES=y, depends on CONFIG_NET=y.
> - include/net-common.h via PKTBUFSRX,
>
> Indirect users via PKTBUFSRX:
> - arch/sandbox/include/asm/eth.h
>   - according to ./tools/qconfig.py -l -f CONFIG_SANDBOX CONFIG_NO_NET,
>     all sandbox defconfigs have network enabled so ignore this for now,
> [...]
>
> include/net-common.h | 4 ++++
>  net/Kconfig          | 4 ++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
