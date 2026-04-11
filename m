Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502C2E937E4
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E288419E;
	Sun, 12 Apr 2026 15:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GhZ6asZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7298416F; Sat, 11 Apr 2026 17:40:08 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D610880077
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 17:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so4995627a12.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 08:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775922006; cv=none;
 d=google.com; s=arc-20240605;
 b=S6PG4dytTgTxS3Fi+1fgwPxceimmG2FbV669fKuG2Wr/VLUJnHx2VoguTHiZnSjcys
 vwmfDqubPixgzyUTwYMw/msZMP0OsfB3YZw0+70tiRFtMEEnPqVo1Ty/QO+wq4Ls1NsY
 bc9CnMapNm7Pttb/apr5a5ZCUjtHSuysBtvBs6bp7B0kCwkXrIaar3LhM2CbjkpG4sWw
 4nowSmXe+ZBub3Ieed2kNmYobWu8uaPMuIP3C/u8ZuBPf/ngAJus9a9Q+7D9xQrDK/2U
 /kGAZ8QlLmKxEVNK0eIX8jLImcBLw/U6cRg7VZoNEzhpMb9ppztC0KJBktCCjWIXiCpS
 ntog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ACvPbFxuitcJYPNAzALjGMh3Zxop0O2RTIAODEWLe8c=;
 fh=pKV29h6PBf5SbuSFTM/GZF+KoVG4OaOclZXc+5Qi1tM=;
 b=ky3CbcqEjuRyKnf3osd2Y6/zv5eyLryB0XJnKmXgtrcDdjb/CrCQbe7GViVR+kevIz
 X4AP/zHuDCcJR26izMZfY57KuuIWHUtM+IkexgYkEvCLb3OXjZpgxaV2dEM23QwwKDKY
 SRx3fl3ltoFeb1vtwTfC/TQyjaWkcZyRJ+yjdkouZJysc8L0byLb9YXN0ij03gGqVzbm
 QmuBL74DfxWtnuxeM4yxVbNygBX6XXnoXdLNG9TXmE7YaneCydCt1I3r2BHkX3GKRVZY
 WLu/7FWKWDnEFpEvfWjTLypWtnoQ8MUBA23tneYPI1qopdPNYW0wp80MQVytZ13EgmfE
 aQUg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775922006; x=1776526806; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACvPbFxuitcJYPNAzALjGMh3Zxop0O2RTIAODEWLe8c=;
 b=GhZ6asZIRhrfDkx0JU5GfC0lg8li+efzmBfA4CUDwGsXuiMR4KiyfUoN3NzIh8MN8R
 +DUO6bgVBJWcgpVM4lMGypqbdbf9ea7Hnc+q5F7VSEMvNkFF42y8MOUjdhQWjn7DEABL
 K6+jR0QU7UyRlL8KAH+I9MNWwgvZbJnnKyCeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775922006; x=1776526806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ACvPbFxuitcJYPNAzALjGMh3Zxop0O2RTIAODEWLe8c=;
 b=Gn5fR2XZDPZylt+S09h35C/RZ9EsINpbe5AW6aYP56tqWS5SWfZ2UV1R1xPQhHTMj5
 h2jkK0JESfqVWb9c0Ew2VC2OebuGGf5Hxqiv3aOv8KdC5rDVG50S3eFHfasuJtRA+LIT
 W7Pgcx1FEMq6c7ET3ybPHx2HXc3Cw+kI9qk8CgmX+xopTgpL5TP4f0ia5yDnkzfPRULo
 Chf17FzAiPxZjQtHR9/mr+qS/s84Sv3c5hWaVNnMtdy02Xi7wKrA1kenGIHElSieGfaw
 uRbPPqJ3PP9Wup9sXf8RMXyuwrXAo+z2FAflu0a2dG2xhNONxpyLWcEHWdNbDEqRHmDE
 mi6Q==
X-Gm-Message-State: AOJu0YxcS+6lrVTZX8UMfQ4OC3jR5RL74xK+u+NVr8eDraVJzMKZYKah
 vWzmy1mqYzYYSwHh2OC3iCkcq9QAxUXH4ry0UgiR2ay0e7ttyIDlMjU263aNMiSdt2gqi5aEz3f
 k8vAQC8hS0zzCA0H793c2PCukiDXOTi0XRA9GzuCX
X-Gm-Gg: AeBDievHSdQ13Q9txid1JO675TpAEhuYB6qSGRg/nwrrcfXKTTI+eEgyQ6GPeRQEh0f
 OnXTzFggKULMbknSW0YehvY1FEwRvB6icu+wa4NNTemgMfXdcXvGQVilDaUfzXyGnw4L7so90a4
 Ht7ubXmZpap56IvW82F8an6NNiGx5VKBRezWA15XAIyna0fo/hbVETcO5fScoUmPsnHVtCmfjWW
 18gqE0a+AoDwIXbDe++IMXvOUV2HPS8dT7t08pDtLpkotqZvfJJAWysDAcSnRLMkOcTysTw7vkJ
 UOAfSw==
X-Received: by 2002:a17:907:1582:b0:b9c:3ba2:2dbd with SMTP id
 a640c23a62f3a-b9d727ac3cbmr297834066b.53.1775922005950; Sat, 11 Apr 2026
 08:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-3-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-3-9609557cf562@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 09:39:51 -0600
X-Gm-Features: AQROBzBhIGaW2UvVjEX2S9vA0YJWO8oZYLEERigLHyFS1-VOlOAtsiVRL_dxqpw
Message-ID: <CAFLszTgBU=bNqo6bPtmLJJ5y7jRHkTFz3V7xkZJAR3gzVqGMog@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] drivers: allow clk_stub and spmi in SPL
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
Content-Transfer-Encoding: quoted-printable
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
> drivers: allow clk_stub and spmi in SPL
>
> Only Makefile and Kconfig changes necessary.
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> drivers/Makefile      | 2 +-
>  drivers/clk/Kconfig   | 6 ++++++
>  drivers/spmi/Kconfig  | 6 ++++++
>  drivers/spmi/Makefile | 2 +-
>  4 files changed, 14 insertions(+), 2 deletions(-)

> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> @@ -114,6 +114,12 @@ config CLK_STUB
> +config SPL_CLK_STUB
> +     bool "Stub clock driver"
> +     depends on SPL_CLK
> +     help
> +       Enable stub clock driver in SPL

Please can you expand this to mention the use case, e.g. 'Enable this
to provide a stub clock driver in SPL for non-essential clock
controllers'

> diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
> @@ -8,6 +8,12 @@ config SPMI
> +config SPL_SPMI
> +     bool "Enable SPMI bus support in SPL"
> +     depends on SPL_DM
> +     help
> +       Select this to enable SPMI bus support in SPL

Just to check =E2=80=94 should this also depend on SPMI? Since SPMI_MSM
depends on SPMI (not SPL_SPMI), you need SPMI enabled in U-Boot proper
to get the driver compiled. Currently ARCH_SNAPDRAGON selects SPMI so
it works, but the Kconfig relationship seems loose.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
