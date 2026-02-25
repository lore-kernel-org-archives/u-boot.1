Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96427EFD209
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 08:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05FE283AA9;
	Wed, 25 Feb 2026 09:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZObfCWQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A98083D8A; Wed, 25 Feb 2026 09:31:53 +0100 (CET)
Received: from mx-relay94-hz2.antispameurope.com
 (mx-relay94-hz2.antispameurope.com [94.100.136.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FA582A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0509038307=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate94-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=LAazKmemtYRYPo93dVeD8ifNpcB1ExsCOjVC8gnR1Rw=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772008303;
 b=MAirPdP0ij6HiWpC3I07+H2pYQ9y0UEZWCZ40Xdi5ZdFZii1TxPTAul7mVIuXXsBPTFc6nOf
 2Yo+U6ZVLpiaYhDT8g1Ap5N8iizHd0U5mvMmiMaOm0dj1JByJPlYIKTNCebI85RJh9TeQonP14+
 AQ4QPPTRqhKOSoAqdJi1oHpEVOUufcMe37SjS1c7HXxgPkzWD5/EnO9/kjQYKEf5WMW3nnJ/cbR
 3TOtzm9qeT8K9qexOLJqnL7wGkB81tZcdB3Po9+ckP5E9PJcaLUNnPootc9eQEbXTHTTAWE9vMF
 gPdsP8+C/sucrqSn/sm5z8XCiWh2HmLHVg/WQ5krze/EQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772008303;
 b=NjE6BCGrn6pf7f+mtnqrZOgTfZc2ZegZ7TvSPsAvAAC3t+QGwhhPpwP7co2utnd2jBdwHSzs
 T8yojEoN2tJbTmlBYuHCJ5a8I9A451rBYHvxwAyUWXvlmPSJ329I6SWVkl+0I656JX3i6lZ207w
 zsuP6EKTlaSGEdIJJPsXuOYjYwSx9WlM8PGD+KTqcC/0R2aR4zfVXQIpyD/hOKvFAOH/ddrVE7S
 ioMWQTk0rwinYsbcY4slIMQFP9OnECNvhg61/zDqb/fkmZKMjP5gQEwfuodeyLsX6VsG8JtoMnK
 CQ2vJy+UfF7oUFHVpnsijp5+bTiGcJe5xzvE/k4Wfz+Fg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay94-hz2.antispameurope.com; Wed, 25 Feb 2026 09:31:43 +0100
Received: from [10.123.75.134] (host-82-135-125-110.customer.m-online.net
 [82.135.125.110]) (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 DD28FCC0E8C; Wed, 25 Feb 2026 09:31:13 +0100 (CET)
Message-ID: <e61b4681-3ad5-4b4a-a667-2b7a65e60f55@ew.tq-group.com>
Date: Wed, 25 Feb 2026 09:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] boot: Create a function for final pre-boot steps
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
 <20260224142553.1608883-2-simon.glass@canonical.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <20260224142553.1608883-2-simon.glass@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay94-hz2.antispameurope.com with 4fLSVB6xWjz3dGhd
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 8f0ab68df8347c6f710fc7354efea81e
X-cloud-security: scantime:1.942
DKIM-Signature: a=rsa-sha256;
 bh=LAazKmemtYRYPo93dVeD8ifNpcB1ExsCOjVC8gnR1Rw=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772008303; v=1;
 b=ZObfCWQCCRw5lxbV/h4QVNkczVSWDlgJ+MaI8v1NR0p2GP3jbwkthUWeuaUeZwxbCcZEdzWh
 Q/+sDcrALssheHKDDBAJEYArNrJdRY533O0d/pwsapp34OlcgdNl5Z1maJZv7ekKQ42tz6ZO8ht
 5MLhng+AZRMKx5knJYthWz0ziXvoiSWs/XqauJmkNMMByXPQVvJmab9/dBk96iSacIa/zuyZ7LJ
 LUHw5IVpXVemH0qct+b+YBvneApnQzI7oogl6RQ7rLb1DGojb5TJI7Yev9qRmiOC3FEc1esN9pm
 4/zmOh+NA/Vng8O8Cwr0kSUD5jU2zEB393oF7V7UA2low==
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



Am 24.02.26 um 15:25 schrieb Simon Glass:
> There are various functions which announce that booting is imminent and
> do related preparation. Most of these are arch-specific.
> 
> In practice, most archs do the a similar thing. It would be better to

change "the a" to "a"

> have a common function, with perhaps some events for things that are
> really arch- and board-specific.
> 
> Create a new function for this. For now, nothing uses it. Be careful to
> avoid using BIT() macros which are not available with host tools.
> 
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
> 
> (no changes since v1)
> 
>   MAINTAINERS        |  1 +
>   boot/Makefile      |  2 +-
>   boot/bootm_final.c | 12 ++++++++++++
>   include/bootm.h    | 17 +++++++++++++++++
>   4 files changed, 31 insertions(+), 1 deletion(-)
>   create mode 100644 boot/bootm_final.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8d4f6ee8b2..beebb491f28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -983,6 +983,7 @@ M:	Simon Glass <sjg@chromium.org>
>   S:	Maintained
>   F:	boot/bootdev*.c
>   F:	boot/bootflow.c
> +F:	boot/bootm_final.c
>   F:	boot/bootmeth*.c
>   F:	boot/bootstd.c
>   F:	cmd/bootdev.c
> diff --git a/boot/Makefile b/boot/Makefile
> index 7fb56e7ef37..12477fabe28 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
>   
>   endif
>   
> -obj-y += image.o image-board.o
> +obj-y += image.o image-board.o bootm_final.o
>   
>   obj-$(CONFIG_ANDROID_AB) += android_ab.o
>   obj-$(CONFIG_ANDROID_BOOT_IMAGE) += image-android.o image-android-dt.o
> diff --git a/boot/bootm_final.c b/boot/bootm_final.c
> new file mode 100644
> index 00000000000..15ddbbe5e74
> --- /dev/null
> +++ b/boot/bootm_final.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Cleanup before handing off to the OS
> + *
> + * Copyright 2025 Simon Glass <sjg@chromium.org>
> + */
> +
> +#include <bootm.h>
> +
> +void bootm_final(enum bootm_final_t flags)
> +{
> +}
> diff --git a/include/bootm.h b/include/bootm.h
> index 4060cec7fc0..32711eabb2e 100644
> --- a/include/bootm.h
> +++ b/include/bootm.h
> @@ -16,6 +16,16 @@ struct cmd_tbl;
>   #define BOOTM_ERR_OVERLAP		(-2)
>   #define BOOTM_ERR_UNIMPLEMENTED	(-3)
>   
> +/**
> + * enum bootm_final_t - flags to control bootm_final()
> + *
> + * @BOOTM_FINAL_FAKE: true to do everything except actually boot; it then
> + *	returns to the caller
> + */
> +enum bootm_final_t {
> +	BOOTM_FINAL_FAKE	= 1 << 0,
> +};
> +
>   /**
>    * struct bootm_info() - information used when processing images to boot
>    *
> @@ -321,4 +331,11 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
>    */
>   int bootm_boot_start(ulong addr, const char *cmdline);
>   
> +/**
> + * bootm_final() - Announce and do cleanup before boot
> + *
> + * @flags: Flags to control what this function does
> + */
> +void bootm_final(enum bootm_final_t flags);
> +
>   #endif

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

