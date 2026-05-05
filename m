Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00608FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC12E848BF;
	Tue,  5 May 2026 14:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="ib3Nxmgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4740846A1; Tue,  5 May 2026 08:45:44 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A40184683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 08:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so14563455e9.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777963542; x=1778568342; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtOXsHJR3b22bAy+voMXgfLTOH6Tc4fByUksF7KcBsA=;
 b=ib3NxmgpNPB+yzc+p/PxyJo/tGcOC46Fny+Shy9Y40yMGad8r/1N2gGpWy6pRMItGD
 BhMYVZSpKPFQeXkbe20dBsDSf6crNGIwKq++9mfhbSRhgdIFgkIgctABEWehlmOd5a29
 03YoHD1B9Z/SM8s5E71IlgaF+ER8kG3SFjUoh+2NyX9gRPv6OH8tTb0620KGRytNAbyM
 4NdB7H3M7clT/2HMez8vqp/V6P0yUj29ntu00GwN1cmHmcV0j2O2AEJwamdJ5Mfhe5m1
 uJ9ONGde1h47mpKfpBu/YuKpKmKtKtrCFaM0/DQT0zaBc8AtZgf02nuZzlqQl6hZbYJs
 dqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777963542; x=1778568342;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZtOXsHJR3b22bAy+voMXgfLTOH6Tc4fByUksF7KcBsA=;
 b=RmmlrChBXwWTpHZs8wmVa1w8a6f7pxg6NM3ozLkIorPBd+IjvhkVvI1xqTWnHv+ffr
 mfkqZVEv/2wC2LvdxqjlNXUT9ogDbLg2Rswy0poLlqnZzzEip24j4zB+lVUOLvv6y/hD
 O0zIjmuswd9bjh/PIeQcAs7Henp01G69F034QPb+rvLof3RFeVOaRuLZU+SQB5UIsmIq
 fgC7Yj5Obh3tW3lR1VBS+VQ5+BC2UWS1nuxLB12VatmBOvnJZZntiLTMcv/OPlUtFTpU
 xe+UP9gOjLBCputYf3JnEnGlKLnJ6m4EDKpcMMixyfWXeUWehI5oXkFZbkm0xxQhw63b
 O8SA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9h31XcUQDKrkvrGmM3LsB3vz/UywgUBwnI4J5gsNxNpmWlH3zvQZ/bqjJU5NFTMHy6U+C//5E=@lists.denx.de
X-Gm-Message-State: AOJu0YzV6+bWbBd2Ld0hNPZiMvBguljwGUxjkLNHtd03JbjidP3L6pl7
 f9qvVeNzOTKS4Os8XL98S3SBw+5J7N4iHJS5xsPT5qeI25uWDnBwHUQaSOlFdykhCQU=
X-Gm-Gg: AeBDievQkJrSPOlh/kVsBXitQL52O3P/oxY0gay3VNuxMOy5g7bkCaF6x1b4+LYi2Uz
 wgIQfguda7C79fPvQoZmEElsR73JWggWqYnn/o4/zW5ICwkPtcWXk1suoJ1BrqLFFsP4jbP9OFo
 KU5334j5FMWHFsKq88PgfoB2UZgM2xcQdJBKWvWL83lGDBpkBP5PCHqElw0einpvEjOXLchCZaW
 tJaCroRKndDkcM5n/HrEwuH4oOkwW6kMz4OuVXPZlcPupPggZx3b2YEEaGIt9ecsoQPIrW1eAsh
 ChbKC41xablfiSaGjdFnvjVPzCNk6cwRiWrQsAM7M5I7KU8M5/JXRU2BqV48qvBWWnuG27BDqwe
 bxF0wYU95K+qTehwPGT90nnN4Y+kz4Ri4dT3IJ+7FE0Uu7Xy8olso2jJrQXXrOD/tgq27fCRua7
 cmhu1s+jktji9VVcZ/bK6s97gquIZayl+troqPsRw=
X-Received: by 2002:a05:600c:a414:b0:48a:58ae:993b with SMTP id
 5b1f17b1804b1-48a98895156mr178918805e9.16.1777963541891; 
 Mon, 04 May 2026 23:45:41 -0700 (PDT)
Received: from localhost ([213.208.155.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb694fcsm350190055e9.3.2026.05.04.23.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 23:45:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 May 2026 08:45:34 +0200
Message-Id: <DIAJGZQV0SV6.XD5JV3YBJQCV@fairphone.com>
To: "Casey Connolly" <casey.connolly@linaro.org>, <u-boot@lists.denx.de>,
 "Sumit Garg" <sumit.garg@kernel.org>, <u-boot-qcom@groups.io>
Cc: "Tom Rini" <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>, "Peng
 Fan" <peng.fan@nxp.com>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Alice Guo" <alice.guo@nxp.com>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, "Kuan-Wei Chiu" <visitorckw@gmail.com>, "Raymond
 Mao" <raymond.mao@riscstar.com>, "Stefan Roese" <stefan.roese@mailbox.org>,
 "Philip Molloy" <philip.molloy@analog.com>, "Jerome Forissier"
 <jerome.forissier@arm.com>, "Marek Vasut" <marek.vasut@mailbox.org>,
 "Varadarajan Narayanan" <varadarajan.narayanan@oss.qualcomm.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, "Aswin Murugan"
 <aswin.murugan@oss.qualcomm.com>, "Rasmus Villemoes" <ravi@prevas.dk>,
 "Heiko Schocher" <hs@nabladev.com>, "Michal Simek" <michal.simek@amd.com>,
 "Sughosh Ganu" <sughosh.ganu@arm.com>, "Antony Kurniawan Soemardi"
 <linux@smankusors.com>, "Luca Weiss" <luca.weiss@fairphone.com>, "Balaji
 Selvanathan" <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 15/15] configs: add qcom_sm8650_defconfig and debug
 fragment
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-15-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-15-c01ec2ff3886@linaro.org>
X-Mailman-Approved-At: Tue, 05 May 2026 14:19:35 +0200
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

Hi Casey,

On Mon May 4, 2026 at 8:57 PM CEST, Casey Connolly wrote:
> Add a defconfig for running on sm8650 as the first stage bootloader and
> associated debug config fragment.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  board/qualcomm/debug-sm8650.config |  5 +++++
>  configs/qcom_sm8650_defconfig      | 16 ++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/board/qualcomm/debug-sm8650.config b/board/qualcomm/debug-sm=
8650.config
> new file mode 100644
> index 000000000000..8323bf25e9c1
> --- /dev/null
> +++ b/board/qualcomm/debug-sm8650.config
> @@ -0,0 +1,5 @@
> +CONFIG_DEBUG_UART=3Dy
> +CONFIG_DEBUG_UART_ANNOUNCE=3Dy
> +CONFIG_DEBUG_UART_BASE=3D0x89c000
> +CONFIG_DEBUG_UART_MSM_GENI=3Dy
> +CONFIG_DEBUG_UART_CLOCK=3D14745600
> diff --git a/configs/qcom_sm8650_defconfig b/configs/qcom_sm8650_defconfi=
g
> new file mode 100644
> index 000000000000..e0a82c460337
> --- /dev/null
> +++ b/configs/qcom_sm8650_defconfig
> @@ -0,0 +1,16 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of QCM6490 dev boards with

QCM6490 copy-paste :)

Regards
Luca

> +# the "Linux Embedded" partition layout (which have
> +# a dedicated "uefi" partition for edk2/U-Boot)
> +
> +#include "qcom_defconfig"
> +
> +# Otherwise buildman thinks this isn't an ARM platform
> +CONFIG_ARM=3Dy
> +
> +# Address where U-Boot will be loaded
> +CONFIG_TEXT_BASE=3D0xa7000000
> +CONFIG_REMAKE_ELF=3Dy
> +
> +CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/sm8650-hdk"
> +

