Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAC0F94CBB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 02:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4069C842BF;
	Wed, 22 Apr 2026 04:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yv5zuFJV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E2183936; Wed, 22 Apr 2026 03:15:00 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF48F805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-66e8cf72a93so5763782a12.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820498; cv=none;
 d=google.com; s=arc-20240605;
 b=Y6NjHkNeTWgMGDB3EWuZbnwiMj87uIovAFu1dFOmp06VwSOU3jgUDs3jqMIGnlrSVk
 WjHVw+YGy1jR6kSyBfY9UKqFjNddIWSNA74xzLloi4bTsfy9mh3fD44rt4SwllXdxtFQ
 1pXxpVyO7e3IZhqeUFaSO4N1FyQE+IqwmsubGQTIzkd4SAmZKZ17kseaYzOcxLkjxfnp
 AkzsNtx51/o5tCa2n9+0RxYTHBUrwhyA551fM5HBwiVYCqi9FP5QNU1kV5MkWyC/j7lh
 CFHo2bR7reJBdAHW2kib5BoKmX0yjtVH7QR/sj710pJ5rnRxXimIFM5sg0o/dobTNU2N
 f0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xVlljdSsHJj9zISJYmp8fb/z0nr5D1kMauqQP/VdtBo=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=NebWawdYHnbACurL4Jh56VD2Jz73Zqxtx3konCogLix/1Oijp2MNRG/pTHBYBGIbdP
 6NkbGjQNnCXv3wrg79f5/ihAn28K0uaYlnwHrdhIOLX6yNlp49XktVdxnHIHcqheN9i9
 cdECC5VUuDHvjNnWirWfD+h0PkyYTumEenpv/0IUMz4CDYr8iW6cazqXONTBGoqy6ZEp
 mzoi5kFxf1mzUbQ1Zv5YVjLAEmPZULNddYUSNnKTSbFD2snI4RuNYlV+GiK2TumbnmBA
 cL9rTJaqnVl+Ek7R+/caOknHariwSqnChi5CztqFsdzzrM6crKQxl+Mi9/86fkKVH+7Z
 fNKA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820498; x=1777425298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xVlljdSsHJj9zISJYmp8fb/z0nr5D1kMauqQP/VdtBo=;
 b=Yv5zuFJVTBKELZczRCDzccCMCmzDNO8NMrS09nQ/QE2kjRGJEe/yzLrgWSNmWPdxd7
 H3AVTrTMR46+0avpnJHWZW2KVkyGCGFgEQzwqaQjdcVgCBOAXOIWB4dmYiDpFRhTb5xY
 HErvbAJ30ReEq2PPS4wPTbek3rLVAYIkhrpbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820498; x=1777425298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVlljdSsHJj9zISJYmp8fb/z0nr5D1kMauqQP/VdtBo=;
 b=MFaUopZP9MGqeKzzmbDfZItYsuosZAlAttBrRzTYezr4dMjpdVETvaEz0vUJIxPyYR
 ZM15UZq0Di2cSfrwWlaw+/pvpQ74yxvDH+g9ZxemBnr2HldXWJE2zT+CpgCiqJ4Foh2H
 ZOY5vtKS56H3VUa77JsGnugPoLFN2ahxkG0kugv4qvgutXSLX/Wu/vyBWjG2MlWaGYe1
 n8V4S3BYvTVeuca1KffIXY7Wi8FTn350v6pUROkvAC2C+FV8hGuVC5JGFwuC88aehh0c
 U4Xmkl2V4kqTHxtmYFbO/wuELwqqd1KutenfTb21WLmeYMtDJBmc7BvQ7lB/2Z/c4Pjc
 mK+A==
X-Gm-Message-State: AOJu0YzkviAe5yz37yFQe/idq2mH35N1AMRUgypPCvHaUlQY/0BUfFth
 Z2uDVlZdm6pn+s87fKTuGqKlFOblzNaWSGkWNeDJA4sj0xetIUb2/EwtQVChzLz7iVk3zk7ylV9
 M7Xf1RW/ud1p7qa+DUcHx5tCrku1LlRI3GGhAZMCg
X-Gm-Gg: AeBDies0ggY9smhAGoy8JO312IHzzJ14y27RKxyj7m1p/sORvIzAqZqT6pJImrMFEuL
 P9UxM3Iv0UMsGRDteJ4gL72Ayzd6Hfn+Tdtt2i+GFFsq0u7fPVsczjABtn6dapBWlS6dBg7E+PF
 q5z2ohvMuW8CuGZMOmgqdMLNus1W7t+OM0cAuIVp+dHAvVFGX+NhnSXG7qdG+fPRstjAPGs8HED
 SGmO4zWe4FUKMV0E4WwfWS6SRGcaBF0W/ZNJFPGjkIjL2l3qT1xpTWC/oW0/x4fyxSD3SA+qwb/
 QAlIvzM1LorWuJQX2dWK
X-Received: by 2002:a17:907:c996:b0:b9c:b069:8ac3 with SMTP id
 a640c23a62f3a-ba418b7e657mr699057166b.3.1776820498115; Tue, 21 Apr 2026
 18:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
 <20260421-qcom_spl-v3-10-efee3f76754d@seznam.cz>
In-Reply-To: <20260421-qcom_spl-v3-10-efee3f76754d@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:14:46 +1200
X-Gm-Features: AQROBzCOWbaePZHIPzAx6aWyqKPtuRHzUzy8VUEt7A-c-B6Q8eoJJ0vRHV-YoB8
Message-ID: <CAFLszTisfd4Ghsc499mOQkKcqGow5yk3iTA4R+2fwBPqr7nAOA@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] qualcomm: add defconfig,
 env and docs for SPL on sdm845
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
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 22 Apr 2026 04:42:51 +0200
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

On 2026-04-21T19:43:46, Michael Srba <michael.srba@seznam.cz> wrote:
> qualcomm: add defconfig, env and docs for SPL on sdm845
>
> The defconfig should in principle be board-agnostic. Environment
> simply contains a dfu env specifying where to load u-boot proper
> (TEXT_BASE - 64).
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> board/qualcomm/sdm845_spl.env |   2 +
>  configs/sdm845_spl_defconfig  | 138 ++++++++++++++++++++++++++++++++++++++++++
>  doc/board/qualcomm/index.rst  |   1 +
>  doc/board/qualcomm/spl.rst    |  91 ++++++++++++++++++++++++++++
>  4 files changed, 232 insertions(+), 4 deletions(-)

> diff --git a/configs/sdm845_spl_defconfig b/configs/sdm845_spl_defconfig
> @@ -0,0 +1,138 @@
> +CONFIG_BOOTM_NETBSD=y

> diff --git a/doc/board/qualcomm/spl.rst b/doc/board/qualcomm/spl.rst
> @@ -0,0 +1,91 @@
> +xbl_sec elf (signed by qualcomm). To boot on an unfused SoC, the elf additionally

Please capitalise 'Qualcomm' (also elsewhere in this patch)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
