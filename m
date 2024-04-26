Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45627C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 00:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3854A890B1;
	Fri, 26 Apr 2024 02:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="kOV4Pq32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5018909F; Fri, 26 Apr 2024 02:17:13 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CC2D890B4
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 02:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a56d7d457a1so183194066b.1
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714090629; x=1714695429; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5u+bZiHz4wSePBRRHNRnJ6hMJs4QnCW3pWIcGZYX6JQ=;
 b=kOV4Pq32e531A2YuFfgAa2i5wtWozuoRdY0b8lZ/LVu3AEXi0WZpo1I1heUviNcnbR
 qA47b7olo5by9p1ZaNLTgQXHwKyQzpaj2ObTNbrVthQhLtikiNRMJxZpO0LKZ93bC90e
 Td9tRgHz1qrDoJbVzbNQvcf+1gN1Subxw7GS3WRR7EvxpZ4rnkWK+kLKy6UJJdV41KeA
 40g+PbdDa6egHW/j5LAs0AXGd/y4Q08dkV6sLEBPzOvSVol0MKpSa7vBH9Qmv12s83cw
 XEQThAMjWHoZL71kLwKhvv7tLmkqxKJMbsU0GVvzGnjg2qvy2DPZj/G/MmRUkd409mZz
 xuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714090629; x=1714695429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5u+bZiHz4wSePBRRHNRnJ6hMJs4QnCW3pWIcGZYX6JQ=;
 b=QcHJ3kTGYxa+BoutGyYWKwKVSfV5fwffbq36B/cJaXk7V+QbtA4IYPa0gWG0rv4pW+
 9rBORonXHtwEHOmS4GOil059sX9gf3ojMp2s+fxRrjxL/NYrHg4T4tm2O+B5uFkMBzyj
 Xphxv/5wOTmJisJdlM3mpNx29e+cRoJzJrtD1LDnj6QWfECHHyXkKBltvQOO8nFy2bov
 vEGe1mj7TZSPcfGf8x9xL0uKSshMqmkXlMd/cvwQoWjNXRj8TuEHfcs+6FwIXMWo+SXN
 rcUW4+vziFEL4YsawVG3YBtb5finfZR9Con3PPSPsV8XLUaHGJW2jSeA8Zc991ZKBjPs
 mR3g==
X-Gm-Message-State: AOJu0YyCncWo+vjGx2iZI69lkCQYrQzQnhGvlnTr+9iPTniUSOKNniYF
 0tXvlcgDAbqAuIk3iVcmcfWcHYJOaOq8G68H6pd8OqWMXRpIlyQidg24/dZTmc2NXD6WBQ1Bzzw
 YSXAKQY8uSwXm8mAGvu2vbdF0IHhZQsYpqnWJig==
X-Google-Smtp-Source: AGHT+IH7l0hbi11GUKUIXwC5N3BkrTnqK8ChjY6/SwBy62Cl1jBnZC9M5kkVjNPAOxwookBNin2IqhDhFNQTe9hE1dM=
X-Received: by 2002:a17:906:411a:b0:a55:66d2:95d8 with SMTP id
 j26-20020a170906411a00b00a5566d295d8mr798399ejk.48.1714090629464; Thu, 25 Apr
 2024 17:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240425230314.497203-1-marex@denx.de>
 <20240425230314.497203-2-marex@denx.de>
In-Reply-To: <20240425230314.497203-2-marex@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 25 Apr 2024 17:16:57 -0700
Message-ID: <CAJ+vNU3ndKTXr5XBOd9b2aQF7WmBPARJ70Fsuab1rmnaQsEZiQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] crypto/fsl: Introduce SPL_FSL_CAAM_RNG
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Angelo Dureghello <angelo@kernel-space.org>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Gaurav Jain <gaurav.jain@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, Apr 25, 2024 at 4:03=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add SPL variant of SPL_FSL_CAAM_RNG so that the SPL_FSL_CAAM_RNG can
> be disabled in SPL if necessary. This may be necessary due to e.g.
> size constraints of the SPL.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/crypto/fsl/Kconfig  | 7 +++++++
>  drivers/crypto/fsl/Makefile | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
> index 294e1c8a44e..9f58731bb67 100644
> --- a/drivers/crypto/fsl/Kconfig
> +++ b/drivers/crypto/fsl/Kconfig
> @@ -78,6 +78,13 @@ config FSL_CAAM_RNG
>           using the prediction resistance flag which means the DRGB is
>           reseeded from the TRNG every time random data is generated.
>
> +config SPL_FSL_CAAM_RNG
> +       bool "Enable CAAM Random Number Generator support in SPL"
> +       depends on SPL_DM_RNG
> +       help
> +         This option is an SPL-variant of the FSL_CAAM_RNG option.
> +         See the help of FSL_CAAM_RNG for details.
> +
>  endif
>
>  config FSL_DCP_RNG
> diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefile
> index 7a2543e16cc..4fbce519a0b 100644
> --- a/drivers/crypto/fsl/Makefile
> +++ b/drivers/crypto/fsl/Makefile
> @@ -6,6 +6,6 @@ obj-y +=3D sec.o
>  obj-$(CONFIG_FSL_CAAM) +=3D jr.o fsl_hash.o jobdesc.o error.o
>  obj-$(CONFIG_CMD_BLOB)$(CONFIG_IMX_CAAM_DEK_ENCAP) +=3D fsl_blob.o
>  obj-$(CONFIG_RSA_FREESCALE_EXP) +=3D fsl_rsa.o
> -obj-$(CONFIG_FSL_CAAM_RNG) +=3D rng.o
> +obj-$(CONFIG_$(SPL_TPL_)FSL_CAAM_RNG) +=3D rng.o
>  obj-$(CONFIG_FSL_DCP_RNG) +=3D dcp_rng.o
>  obj-$(CONFIG_FSL_MFGPROT) +=3D fsl_mfgprot.o
> --
> 2.43.0
>

Marek,

Thanks - this series does solve the issue I am seeing in the SPL when
enabling DM_RNG. Is this going to cause an issue for people who expect
it to be currently enabled and now have to manually enable it?

Best Regards,

Tim
