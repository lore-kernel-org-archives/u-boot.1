Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78250C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 18:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E95A82E52;
	Mon, 28 Jul 2025 20:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="rjVmLn5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7074982EB8; Mon, 28 Jul 2025 20:01:54 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEDD82E34
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 20:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2e95f0b6cb7so2143257fac.3
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1753725711; x=1754330511; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpHeaD6OItM/Ldx0FQnmUUTflLpuYaeWeNxuS+ICTUo=;
 b=rjVmLn5RUI+pKxb8WWm+ePEAXJtG9cyNUSyYOCpltbb5ppbWechYeAl7K+++wKw3PR
 Q+cShje9ZgojpVVhulrrPWv04PT6BejNczeo32MZSQ8Dda+yf0qJl6jO9u10AB6PnRn3
 l5jPBXMQ66UzQhTgroGZn8PFAOfEUiiGF8bct/+Lfwas2wN49D9BViK92hKQy2L2qC86
 2DuGT3xTTxEQNd+VIGTPtlpWzd1xb7A28tAoB/ZJ2QkCU07X8oa/HeUJzvRKqnxlXV+D
 R9Ihva4/0dEZdR46X12bOG87equVX8HDPpou//CEG6D7KNfrolVT68YWgS4oQw8m7VdC
 XjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753725711; x=1754330511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpHeaD6OItM/Ldx0FQnmUUTflLpuYaeWeNxuS+ICTUo=;
 b=GCCg94+wRvkQy5HhOMo+cn0PyRhQHQybYBpZv7wppxQMDvvBWAT4bZGmMdqwXDY3pt
 Mfd+FCFlPfqDCuNASwkvJDQqSJKIVstsxIDpPTG84WsgW7+foLMDQhb/c7Jtnk/mJoNK
 BdHTMdgDuYSIF3S+jPwCa/z3uAJ71uRrDwEGyHGV/p9BgkIYxiqOjZDQU+MsBC9d7KP1
 CfTomnU4KiYLiFPovEJ3DgP9SqI2SALv1WAc8tFkAhBsojCyjU0ky+2D/ZbM1FOMdq4T
 PIzgX9DmAyEl7f48hFgB4DrCFOOn+LP5WYL4L6oGJgABjqox1MQ6ApLBE+m8QzAejn8e
 Zb9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMPohy7J93IWtqzoZO9GtLgFbrVsTF/hPcUAtSDDMCaqqbjqCUjWhCxGlUeNQKASh/9yQ2eCk=@lists.denx.de
X-Gm-Message-State: AOJu0YzLZc7aOwb9FqO3u3GrImFfy6lt2fGdFh+TsjZYHErFZaiTaqZk
 IkslI2+QwJV+0qwNYvWOdIaoNu+4DTK3531fjD9Xr19824XqFP2/Hy5KjjExYfnbP6JJoHazmr9
 LkwSGVLmd9zSHUArMA1R5cTElBQr2KSZMd8fSUGdJ1w==
X-Gm-Gg: ASbGnctwDiAZmYbZPE6zHfy5qrysbZ2xErpjTTYO1NAqSD/vvnTZuYwIGh7t0VSl7c6
 mq35xmfuhzSyPX1TLJ1n1KpnRWFVQXaGb25Au0QtbDwmhfNQ00KdpOwnO1nciqZmfh8b49ABozT
 T29t++5l5tEI7xsUq+LWe/+m55atiVns2br9g+GbitSo8XN5XYQhSLtIDz5JbrLcQBMQ9fc7Wzm
 lfnuxsILZiFvsmy5Q==
X-Google-Smtp-Source: AGHT+IGou8VEwPdMPgpLYSSPsq0I3+ybqWrEU0cVDKGr9lFdcgx5h0ZKuBwpBXRq2HZgEjX6jnV2BEc9W+kU97oE2XU=
X-Received: by 2002:a05:6820:328b:b0:619:222e:b697 with SMTP id
 006d021491bc7-619222eb7eemr3119080eaf.5.1753725710680; Mon, 28 Jul 2025
 11:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
In-Reply-To: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 28 Jul 2025 11:01:39 -0700
X-Gm-Features: Ac12FXxJVFH61_irfDjX641b9vNCF9P811YcpoHgnomlunm1CmIN618uvNDGwRg
Message-ID: <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] imx: add i.MX95 b0 support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Ye Li <ye.li@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Alice Guo <alice.guo@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
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

On Mon, Jul 14, 2025 at 11:41=E2=80=AFPM Alice Guo (OSS) <alice.guo@oss.nxp=
.com> wrote:
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> Alice Guo (2):
>       tools: imx8image: Add 2 new commands CMD_CNTR_VERSION and CMD_DUMMY=
_DDR
>       imx95_evk: Add i.MX95 B0 support
>
> Ye Li (2):
>       arm: imx: Update ELE get_info structure for i.MX94
>       spl: imx: Add support for new PQC container
>
>  arch/arm/dts/imx95-u-boot.dtsi            |  8 ++---
>  arch/arm/include/asm/mach-imx/ele_api.h   |  2 ++
>  arch/arm/mach-imx/image-container.c       |  2 +-
>  arch/arm/mach-imx/imx9/Kconfig            |  1 +
>  arch/arm/mach-imx/imx9/scmi/container.cfg |  1 +
>  arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  5 +--
>  common/spl/Kconfig                        |  7 ++++
>  doc/board/nxp/imx95_evk.rst               | 12 +++----
>  include/imx8image.h                       |  6 ++++
>  include/imx_container.h                   | 11 ++++++
>  tools/imx8image.c                         | 57 ++++++++++++++++++++++++-=
------
>  11 files changed, 86 insertions(+), 26 deletions(-)
> ---
> base-commit: cd79a2839b01571b6f2915c219f71c05e3c97482
> change-id: 20250708-imx95b0-e12a13552658
>
> Best regards,
> --
> Alice Guo <alice.guo@oss.nxp.com>
>

Hi Alice,

It would appear that some of these changes break compatibility with A0
silicon chips. I've tried rolling some things back using the old ahab
container and older imx-oei but am still not able to boot my
imx95_19x19_evk with A0. Can you please explain what is necessary for
A0 vs B0?

Best Regards,

Tim
