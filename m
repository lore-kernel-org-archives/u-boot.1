Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB576C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 08:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34B7682A65;
	Mon,  9 Jun 2025 10:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M6Z70yka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268E782B07; Mon,  9 Jun 2025 10:27:06 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7D082A36
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 10:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5598R2Bt719076;
 Mon, 9 Jun 2025 03:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749457622;
 bh=a5xdj02mjraT9VZNoyK3OS5iWHBUOdVp4Zq7oHNaPoQ=;
 h=Date:Subject:From:To:References:In-Reply-To;
 b=M6Z70ykaqLNMAu63ck4UDzP7ZufUlQ/InMz5upxpZSCQoSGnwGCtEdIGf8SDk7sR3
 RQP6wVjXA/P0KahvHP5xvuGXKFilDz08YN//7VQYvVS/0pjTO/AC7pfBzm1Y5KjKL6
 CHAiOB2o0BJ4rlCbB9xrSecAiHw7b5q6rWCyXZnI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5598R1c13669825
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 03:27:02 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 03:27:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 03:27:01 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5598R0xf975343;
 Mon, 9 Jun 2025 03:27:01 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 9 Jun 2025 13:56:26 +0530
Message-ID: <DAHUYGE5YBJM.2DQMLH5VCAPKX@ti.com>
Subject: Re: [PATCH] dtc: Add Kconfig option to pad device tree blob
From: Anshul Dalal <anshuld@ti.com>
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 <u-boot@lists.denx.de>, <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250603170624.93376-1-eric.schikschneit@novatechautomation.com>
In-Reply-To: <20250603170624.93376-1-eric.schikschneit@novatechautomation.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Tue Jun 3, 2025 at 10:36 PM IST, Eric Schikschneit wrote:
> This will allow arch(s) that use device tree blobs to pad the end of the
> device tree so they can be modified by board files at run time. This will
> help prevent errors such as FDT_ERR_NOSPACE from occuring.
>
> Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomation.co=
m>
> ---
>  arch/Kconfig                    | 7 +++++++
>  arch/arc/dts/Makefile           | 2 +-
>  arch/m68k/dts/Makefile          | 2 +-
>  arch/microblaze/dts/Makefile    | 2 +-
>  arch/nios2/dts/Makefile         | 2 +-
>  arch/riscv/dts/Makefile         | 2 +-
>  arch/sandbox/dts/Makefile       | 2 +-
>  arch/x86/dts/Makefile           | 2 +-
>  doc/board/broadcom/bcm7xxx.rst  | 6 ++----
>  doc/develop/makefiles.rst       | 5 ++++-
>  dts/upstream/src/arm64/Makefile | 2 +-
>  dts/upstream/src/riscv/Makefile | 2 +-
>  scripts/Makefile.dts            | 4 ++++
>  13 files changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index ea33d07c086..bf4c2c80891 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -63,6 +63,13 @@ config SYS_CACHELINE_SIZE
>  	default 64 if RISCV
>  	default 32 if MIPS
> =20
> +config SYS_DTC_PAD_BYTES
> +	int "Size in bytes to pad device tree blob"
> +	default 4096 if ARC || ARM64 || M68K || MICROBLAZE || NIOS2 \
> +		|| RISCV || SANDBOX || X86
> +	default 32768 if X86 && EFI_APP
> +	default 0
> +
>  config LINKER_LIST_ALIGN
>  	int
>  	default 32 if SANDBOX
> diff --git a/arch/arc/dts/Makefile b/arch/arc/dts/Makefile
> index fe6ad7b849a..87c627c01c8 100644
> --- a/arch/arc/dts/Makefile
> +++ b/arch/arc/dts/Makefile
> @@ -11,4 +11,4 @@ dtb-$(CONFIG_TARGET_IOT_DEVKIT) +=3D  iot_devkit.dtb
>  include $(srctree)/scripts/Makefile.dts
> =20
>  # Add any required device tree compiler flags here
> -DTC_FLAGS +=3D -R 4 -p 0x1000
> +DTC_FLAGS +=3D -R 4

Thanks for the patch Eric, the changes to padding size look good to me
although I wonder if we should expose the -R flag for configuring the
number of /reserved-memory to user under Kconfig as well.

We have it hardcoded to 4 everywhere now, might be useful to expose it
as CONFIG_SYS_DTC_RSVD or similar for users looking to create compact
DTBs (-R 0) or where more reserved regions need to be added at runtime.

Regards,
Anshul
