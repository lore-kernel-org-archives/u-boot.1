Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B845FD3B7DB
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 18:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F7983759;
	Sat,  6 Dec 2025 19:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XoGs3XOo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC15483849; Sat,  6 Dec 2025 19:33:34 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD3E83655
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 19:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5942b58ac81so2330586e87.2
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765046012; x=1765650812; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOEzuRq4vdUWy1dd90r8d7RFcr8aZYXYmULbSbrdIpM=;
 b=XoGs3XOox6p5HadFdF5Mah5bTDOX+ESviGDyKaiDHHzllXSmgxSi5/QkXXg1tPIZPM
 x/oAWjCVc3rdHlisiWEgNyjoDtp+gfznl61n0PcQv0cqnIutW5GIjFGJdkfsX8ObFM8n
 ocUJfUL9OoXvQZB9oYek28R33AXlOv92eK/Ouhvi+BqgOQdbK0ZbyZWXceSM1bSDUm75
 7iLSJWoOzZlYlQPtKExW1N2CkPLiaJKoOqW4LMss5TsGa9WzfAA9LWFtaA9UPYshBOtc
 h9NA0FtiMt16JpILN9mNYYtpYahjVIVpW8Fh1LAg5g7A5sG1jE+gEbTuOcbh6Y/hcq9P
 QRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046012; x=1765650812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UOEzuRq4vdUWy1dd90r8d7RFcr8aZYXYmULbSbrdIpM=;
 b=JWYvnC1TIab1eVh3ZB+g4BN0apkESItCIe3W516HLm0KuTZB7+HZXkiW8zvo2bZXcm
 Iaaz6aKqosl6nWu0250pQM4+6N4lMjIg72z7LuWtpUjiQ/kzM0T5Z4iKyISh+YNKTeYg
 nJrgaxI10xB4aCjDOK7znm5kO1WMMeARTCxm03UTdJ1usV3294k9GsTA/mgQUNu6x9Lk
 EvIWpLrNh7yPDsY9NUyHO837u+X/9Zw3N+Vlmh+M8gapAXHhZVmHTIK+DWcKFGLWQbyJ
 rfbBrmiD6KPmSU1YZ4YsvP7h/zzJwbASPqQtZliRBZqtF3a8dNVVZT5yl5Po7JgH2lU0
 Y4ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRF5NeG4wI2JkDq4lXTBxVniQ3i23FTx54B6gyfC63CCejBoDcr6fvyQAMrlZulQz68mzpJ/w=@lists.denx.de
X-Gm-Message-State: AOJu0YwDNJAliU6MI7L/DLVBjKwN3GQXz8+HX7erMq0WZSRWyrEyXgyo
 l1yyKJqWFSmrXgKy+22ydCEavypGo8MwtnNVcFD/3yfG+MQWS5CSo5wnmbbbIgO9A8CN4Hn9gBV
 V7xNPMFMf4r081q6g5pJq9kQ1mrbGyOs=
X-Gm-Gg: ASbGncsQUeJizUbs+zF2EXFaRfea76Hhl075CfZ2F7Xz1JUpuh/WJzbUtEDdR8ysUFp
 lqovagphIrifwttCOeskWqA2Gr6dPE73gjBU4/QRlTMTyEgaRrYQp88V+19gcNW+4DSwCKQoX6j
 ryDl5jOI0cidfMbyjwROdCy7RTDPTlC2y/gB8vv3ETEQ8htQUuQMDS39sPlOexrQyr3uZK7dV4J
 HrjOWwqIpKivRI4mP7gmaoRJitUpBr1JfoY7sZfsI72p2WzoBzF9LZeSasrOKISY8EIvJN5F7yw
 Ez+VkFHTYWMxf8i4uAZLI2CDfVE=
X-Google-Smtp-Source: AGHT+IHL2HlYTUGILY2ctK1Q7KfZ4NYis303h6yA+FRYmlGgv8zZrZ4sRru8XAiIRWeHIJgUsi6hKSW/auSOOSLLRks=
X-Received: by 2002:a05:6512:2248:b0:592:f27d:75d4 with SMTP id
 2adb3069b0e04-598853de933mr827485e87.45.1765046011721; Sat, 06 Dec 2025
 10:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20251203-imx8ulp-v1-0-c05ced433033@nxp.com>
 <20251203-imx8ulp-v1-1-c05ced433033@nxp.com>
In-Reply-To: <20251203-imx8ulp-v1-1-c05ced433033@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Dec 2025 15:33:20 -0300
X-Gm-Features: AQt7F2oF1G5ongwH-nVpHyyCvkZIz5v7k62oFA0m5xsBfLI4EZylkJlj6_aqmEw
Message-ID: <CAOMZO5CgBLY1-WNZstYFwLEc_Ud2qGEpgjLswhPqoN0r0=UH2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] imx8ulp_evk: Move environment variables to .env
 file
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Jonas Karlman <jonas@kwiboo.se>,
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Alice Guo <alice.guo@nxp.com>
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

Hi Alice,

On Wed, Dec 3, 2025 at 5:52=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> Add board-specific environment variables to imx8ulp_evk.env for better
> maintainability.

You are doing more than that...


> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm/mach-imx/imx8ulp/Kconfig           |  1 +
>  board/freescale/imx8ulp_evk/imx8ulp_evk.env | 97 +++++++++++++++++++++++=
++++++
>  configs/imx8ulp_evk_defconfig               |  5 +-
>  include/configs/imx8ulp_evk.h               | 24 -------
>  4 files changed, 100 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/mach-imx/imx8ulp/Kconfig b/arch/arm/mach-imx/imx8ul=
p/Kconfig
> index fbca241e106..e96e34651ce 100644
> --- a/arch/arm/mach-imx/imx8ulp/Kconfig
> +++ b/arch/arm/mach-imx/imx8ulp/Kconfig
> @@ -27,6 +27,7 @@ config TARGET_IMX8ULP_EVK
>         select IMX8ULP
>         select SUPPORT_SPL
>         select IMX8ULP_DRAM
> +       imply BOOTSTD_FULL

Here you convert to standard boot.

Please split this in two separate changes: one for env and another for boot=
std.

Also, I had issues applying patch 2/2. Please rebase and send a v3.

Thanks
