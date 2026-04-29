Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E78CFF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 17:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7381848D1;
	Wed, 29 Apr 2026 19:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XRra5dXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 081E0848D4; Wed, 29 Apr 2026 19:16:46 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A1E2848CE
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 19:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba3115fe0d5so213059566b.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777483003; cv=none;
 d=google.com; s=arc-20240605;
 b=jUpQUryvTzDBxwr2kNv08LScZxGJ4Hum6mmJb/TyEZ5XMEnZJ5n8zL4tJtSpPZ57/s
 9x6f5fDUsiavV6OgQp/GX8HxsBtxNsGWzHLBDeT+g76Kjo23PteV4osuk9SFH6KIlOww
 jBbWB7Oaw9UpAdEwL5ECs6vt1BR51NYDAeHJAmbPMnUqKeNmE51DYVM364TslLf3DjUh
 tYaX2MKn2+cIRJq7zE+pvWXqTsSRX9h0VEnFDPGWAgYC+rQpLxtt3diVDdfXg1zAfUf1
 QSVDz1ErFhpw0e95j+pEutxvsVUo9dmfVQ97BaE+9AFQk5KxrzA035YQE7WPtsOscPWa
 AO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=frbBwfaCJ+D9pSOsJ8IGHPA8MHOp6ENYp/STkSqhdYU=;
 fh=+/pNFDyGYsDJMoXpsFeigOK5l3QyGzKdfAevrQne9bY=;
 b=I0+D7eincEeHhs/TuoghtBwUpMPEGfYUqJRhgCJ6CCX8VHyoBh6c9BMt5yfe/LHNWK
 LHTQiXc9a58F/ORigKl74C51tH62BJI709Udb/lMHHy/3o+5VT2+xUy29Cfhzgj43J+c
 /YsxifsFfvvdpS/3/1++d4dK7nK//h9P/Xe8TMiBCpnMEaVxGgSuhOHtdXf7ngMgru4r
 N+4rqcUjGzbE/aqaWQnt/Sksf8k8Lwywn2DnK/be7iFESCyMndcnVOJtVvU3cwbABOaO
 v1a32NeelcTz9PcctCEVDorNalHBawx4PSc64oCRejSeJILB5maqq34Xv2769Uftcs3I
 6qKA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777483003; x=1778087803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=frbBwfaCJ+D9pSOsJ8IGHPA8MHOp6ENYp/STkSqhdYU=;
 b=XRra5dXs5cfOxoDrAxYqSV0K1K74ZI7xJkUGY8aQrgAOMgkXFWioKiXy2A8qe/baw2
 /+yYohx0HuQVwgTLpsEU2qOP6CUlE5FKxJuh2jbNbZRLw62DagS/gD2G0OnCF7Ssx+Lz
 0JWR7o0TmToXJt2kzOuPfdNvcRsZPp/+FP7f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777483003; x=1778087803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frbBwfaCJ+D9pSOsJ8IGHPA8MHOp6ENYp/STkSqhdYU=;
 b=e+/ALjZ+orEIZzGvJPYgdec/8j3iEHKGz04bNgSr8/xy5i3BbYzDz+lTP+OaDBMWVI
 mUH2qq15MvPp916bklRQbXI17FtP9Arwjo5IQKdshQyC9f34jGyKQvm2vyivjyJw4HWJ
 HF7u5gRjA5z5xQuob8KZ0d7SkrFWheyLxRs7+Nhkg9j2I6TjYugcLiANK3J4axUKDq+o
 Gdjjb1CwgHLBSCvK2UjCCxb4VPMWDbBgMqwsI7IjCZfeEUO41WzVcCRa/k7mXhVN8hIV
 wvMsA28hl5abl6vSBS5tjfZNr2HZGBheviRpcDH6M1YoNw2d96wBCvOFROEWGjk7C1m0
 u6cQ==
X-Gm-Message-State: AOJu0YwycHglC61Grnme1aINU+XJPlsfXCnpmnIDCEx15dJ271lLS/xN
 mRARpbspNRJ9smHxKeRXig9VIW66LV4K5G9x7vBkxkWtq7SnKwbT1qZtuW25Q/pCwZIrRHT7LNm
 Ri+W/KduEjf3A5nmqIuRJk7JwlJHe9hNbtFBGvlR2
X-Gm-Gg: AeBDieuoapc7G7jp2S942MpQgKU5+PQNowL9sQb0j9+c1mlWNGldeVIZ8hKHxrn+1F4
 SbnNDlQBwS8anuzRIJY/xx1rNotgmCSCF1/bQPaBWTszMCAIFyDMB4e2hz9BycAH7H4I/qsyZoo
 REBIVPtEvvsUvy7nQApgz4NxnRhFQKas+1UFaafgPVell3Q7llSYSGTEUxCyKKvibmriisDMf2w
 NU1aZ4i1Zc7Kk3w8PMoXEzSZCnbu+fa2rzhsUhyUJW2e/h3TclvftSfaK6RLclsvNiDaIlftRpl
 NeV62/7xc2k7DFk/kZQwTRHj0i0QhWASSJDHa1YFm5U3xsRBAICz
X-Received: by 2002:a17:907:7f8e:b0:b9c:48d9:9025 with SMTP id
 a640c23a62f3a-bb96ab9e65emr218378066b.13.1777483003459; Wed, 29 Apr 2026
 10:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
 <20260429-sys_rx_eth_buffer-no-net-v1-5-396ef37ae93c@cherry.de>
In-Reply-To: <20260429-sys_rx_eth_buffer-no-net-v1-5-396ef37ae93c@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 05:16:32 +1200
X-Gm-Features: AVHnY4IaYGV4GY9N2Dx77eJaqYIntnnjM_ZJM8Nxo_QUwMtZY5Hh-0sNKtHS6RA
Message-ID: <CAFLszTiKqWPOFP-Kd14kVbtnGX+_SGmxpcR0zkQ0khM+Gb8S-A@mail.gmail.com>
Subject: Re: [PATCH RFC next 5/5] net: SYS_RX_ETH_BUFFER defaults to 8 when
 CONFIG_FSL_ENETC=y
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

Hi Quentin,

On 2026-04-29T10:35:00, Quentin Schulz <foss+uboot@0leil.net> wrote:
> net: SYS_RX_ETH_BUFFER defaults to 8 when CONFIG_FSL_ENETC=y
>
> drivers/net/fsl_enetc.h specifies ENETC_BD_CNT "buffer descriptors count
> must be a multiple of 8". This constant is set to
> CONFIG_SYS_RX_ETH_BUFFER which defaults to 4.
>
> All defconfigs enabling CONFIG_FSL_ENETC fortunately have it set to 8,
> according to
> ./tools/qconfig.py -l -f CONFIG_FSL_ENETC '~CONFIG_SYS_RX_ETH_BUFFER=8'.
>
> Let's make sure the default is sane by having it set to 8 when this
> driver is enabled. Note that originally[1] it was said EEPRO100 and 405
> EMAC should be 8 or higher. 405 (PPC405?) support seems to have been
> dropped in commit b5e7c84f72ee ("ppc4xx: remove ASH405 board"), 11 years
> ago. Maybe there's something we can do for EEPRO100 though?
>
> [1] commit 53cf9435ccf9 ("- CFG_RX_ETH_BUFFER added.")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> net/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/net/Kconfig b/net/Kconfig
> @@ -250,6 +250,7 @@ if NET
>
>  config SYS_RX_ETH_BUFFER
>          int "Number of receive packet buffers"
> +     default 8 if FSL_ENETC
>          default 4

Maybe convert the spaces here to tab?

Also suggest a note in the help text mentioning that FSL_ENETC needs
ENETC_BD_CNT to be a multiple of 8.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
