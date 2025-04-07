Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4D6C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 07:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA2082CE7;
	Mon,  7 Apr 2025 09:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JqjeJ1tx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30C882D05; Mon,  7 Apr 2025 09:57:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52D8F82CEB
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 09:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744012613; x=1744617413; i=xypron.glpk@gmx.de;
 bh=JiFmdfwH4xDW4UXyJl+zLc/i1zhZ0GuHNL479lOWNVQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JqjeJ1txnX8L1fVfBAZ7eOEzjNH2Yv0ZP4wzXEuIRS9vv/2QaClukf9j/T5Urt7Z
 D23R14bTFd2XbYqXYGxxXXt60awxTL+8o+02SdGpB1YdgYacOChtb72SkOVxt2+zU
 zietY6YALvVoztiK/SRrMnn7jyRqT0ykuK+1/kbE7XnsBHmTv7Tj/uhWKAifqh2L/
 edcqCXemKql4yc3EdCcJmGd4/lpCWYPpZIqL/Jt8wj8+l6JEvp6z8y++rxAR0udx0
 vYQqAlURgdcUlExaE3DVjDHt4V/GcL17Vzo6XiKXAX1sCI8hzFO0fxGvE69RX54fb
 diRpyPBr82dUaL6WJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGrE-1tZmDT1GgQ-00NTh8; Mon, 07
 Apr 2025 09:56:53 +0200
Message-ID: <ae928b59-23c1-4148-81b2-85dc5e261868@gmx.de>
Date: Mon, 7 Apr 2025 09:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dm: core: Rename dm_remove_devices_active()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, neil.armstrong@linaro.org,
 Jonas Karlman <jonas@kwiboo.se>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Rick Chen
 <rick@andestech.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250407013513.638110-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J5opjvRw7islNb/LPee/s8bhS+Tu3sYkH3h44tjgRJluH3Censp
 4SyytemYBkEGdZJOuonAzh9wcJQDryEIerHUoNcCaYs2Cixgn2RgtDr4pLgD5Vzdurei9Sm
 ZLT7Kw0tHpcEpQzu1ESsVFbAVb6d6WTh5/34M3jgKrez57K2jbGOViDP1bsCrvHPQdihb+c
 1aEEa3NnAhkYOvtlEvPrA==
UI-OutboundReport: notjunk:1;M01:P0:AblZQbP1b7A=;69lHcoL7wQoxooLOarPWcjWbytu
 vXv6e4W9UIv3EulViDjH/iW3VSogE/v2LYYDhBPFvbOyuBiI8x43uY0gizs9S41iJut8s2l9O
 D5nTkN7QLyhipeKd0owtmKvJR6Uciz/rYLIXGeBbpu9Cj7Aj4Td6F8U7JsBl8jLxl/UTmkzgG
 FPR7Vp7GyV5ulwErgK2gjlkMOnqB2D20yEMa1jAcYjOm4R+/Y9NOLJ7VyX6zlLw9C90c4B42E
 DaHJ8LLMensWkdxYfyFH3Rg8l6/aJOsUgYuXH5gucqdQ702PLDJ+LcsXlHGg7M1GcAIDiqqUm
 MMeLAgumk7IbRQEg1zIz5C2j8LH2FENgH/YTM6mJMdDF1ZeXPFiITkBRJgcyjqKsCFqkh1ZX9
 h0MMVblpdlz7wIyPpOgGc/Yukavc1RM3yeKEMRAwDkmBCYjKQitVXtibqyqViiAK2DrbpmKSM
 CU/YRl7LEQqIl3ShKTw6ZX++21wg4+uBV/Z0xNKmIMYNl25dfsWa/gia2AW4svjJHtu1avAd0
 BoNKAakE6LKJtaHAYLhIBUUsxnudgeDIPWZGUcbf56bixrIWWeBWm9WByxtzwHxuFJeTqcIeI
 6b4HOOXG6H9GGaQ3pjsaz1lvlGGPSm1FSJA/8Az2b4GKkHn7+K46Er4nwvgNYJBRwPvCuSBnu
 716isPd1oEqQ0XvSTtb/XACb6JV7BQfiSXOG1tJNm1DKrTG7HOVyAYOTDqyPYOqoYmZgMeS/f
 0YSf9MN9QK2ci2nNnLh9agQoDcae1lhxLxdiSNBf16Sx/dhxuQGrelEWGXoUfBvPQPHCrCud0
 ynwh4msdgNLA+G6W6mQfx/3TfIhxdzpjmWo6n0I0f159nLeAqnZ9W4A9+ENIwCZCl6azKG+um
 qrOTnZV8xhN9+omlsCqnpmyDE0ULztETkOujbeBAoJ91fezsGhTOUHZn89gzXgepBCpRA3rvz
 eIBEKDxYAf7iQ2k4sL91FpJy2l+PumUT10RiK/Hva7kjZgYMYNjOaNfoViQe0EpKBT61qdQdy
 juKI+EBDPTYMPx6SjqB3xJn8rjfONoAvNSasvRw7FmOpUaHtFnVSBZowcBXjCSMGnJQIUGyfc
 Pz7r5iLoUp9bovblMrazdDXdFGsJhq2pDocef9GeY8qEOCbD0UhSD2llnAIw5Xsi1G57eIEDJ
 LxXW4lDrOj8P4thSCOmb9LyX1wJtDfqXxo3KJGxRmcIFkMP95qlLnOWIuFiyfIdJnO1elgsTH
 QJ0gFaCQyuDPvZO0s7NaUemXZv3oXVRyAWvUBIvN08KYTAiz1k7H0yTetUlUKdDdQjGap6NSB
 Ih+h4R676rAYcKQdubbo69qp3e4nW9385Xi+WD63penuUgmBcwwii+tkAhFVcJNikEX+PxG51
 DnKgtrnL4BgiKu6M+MHhyWwIl4KKpoTb9od5EH/45ZeE+YeGVwZPweKH2R6w9y8hRyh6fwNGc
 pRjaXzQDGku5PqoH45wLtcPlbiL8=
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

On 07.04.25 03:35, Simon Glass wrote:
> This function doesn't have a great name, since we talk of devices being
> active once they are probed.
>
> Rename it to dm_remove_dma_devices().
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>
> (no changes since v1)
>
>   arch/arm/lib/bootm.c          | 4 ++--
>   arch/riscv/lib/bootm.c        | 2 +-
>   arch/x86/lib/bootm.c          | 2 +-
>   drivers/core/root.c           | 2 +-
>   include/dm/root.h             | 6 +++---
>   lib/efi_loader/efi_boottime.c | 2 +-
>   test/dm/core.c                | 2 +-
>   7 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
> index 688c2f3f29b..ef859a2cd4c 100644
> --- a/arch/arm/lib/bootm.c
> +++ b/arch/arm/lib/bootm.c
> @@ -74,10 +74,10 @@ static void announce_and_cleanup(int fake)
>   	 * Call remove function of all devices with a removal flag set.
>   	 * This may be useful for last-stage operations, like cancelling
>   	 * of DMA operation or releasing device internal buffers.
> -	 * dm_remove_devices_active() ensures that vital devices are removed i=
n
> +	 * dm_remove_dma_devices() ensures that vital devices are removed in
>   	 * a second round.
>   	 */
> -	dm_remove_devices_active();
> +	dm_remove_dma_devices();
>
>   	cleanup_before_linux();
>   }
> diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> index 76c610bcee0..9aecaafef43 100644
> --- a/arch/riscv/lib/bootm.c
> +++ b/arch/riscv/lib/bootm.c
> @@ -57,7 +57,7 @@ static void announce_and_cleanup(int fake)
>   	 * This may be useful for last-stage operations, like cancelling
>   	 * of DMA operation or releasing device internal buffers.
>   	 */
> -	dm_remove_devices_active();
> +	dm_remove_dma_devices();
>
>   	cleanup_before_linux();
>   }
> diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> index 3c420b00936..91e8de4e1ad 100644
> --- a/arch/x86/lib/bootm.c
> +++ b/arch/x86/lib/bootm.c
> @@ -50,7 +50,7 @@ void bootm_announce_and_cleanup(void)
>   	 * This may be useful for last-stage operations, like cancelling
>   	 * of DMA operation or releasing device internal buffers.
>   	 */
> -	dm_remove_devices_active();
> +	dm_remove_dma_devices();
>   }
>
>   #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
> diff --git a/drivers/core/root.c b/drivers/core/root.c
> index c7fb58285ca..101cc4d43fa 100644
> --- a/drivers/core/root.c
> +++ b/drivers/core/root.c
> @@ -148,7 +148,7 @@ int dm_remove_devices_flags(uint flags)
>   	return 0;
>   }
>
> -void dm_remove_devices_active(void)
> +void dm_remove_dma_devices(void)
>   {
>   	/* Remove non-vital devices first */
>   	device_remove(dm_root(), DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
> diff --git a/include/dm/root.h b/include/dm/root.h
> index 5651b868c8b..39a069cd465 100644
> --- a/include/dm/root.h
> +++ b/include/dm/root.h
> @@ -169,16 +169,16 @@ int dm_uninit(void);
>   int dm_remove_devices_flags(uint flags);
>
>   /**
> - * dm_remove_devices_active - Call remove function of all active driver=
s heeding
> + * dm_remove_dma_devices - Call remove function of all active drivers h=
eeding
>    *                            device dependencies as far as know, i.e.=
 removing
>    *                            devices marked with DM_FLAG_VITAL last.
>    *
>    * All active devices will be removed
>    */
> -void dm_remove_devices_active(void);
> +void dm_remove_dma_devices(void);

We have to remove all active devices. Not only DMA devices but also any
device that creates interrupts.

The renaming is misleading.

Best regards

Heinrich

>   #else
>   static inline int dm_remove_devices_flags(uint flags) { return 0; }
> -static inline void dm_remove_devices_active(void) { }
> +static inline void dm_remove_dma_devices(void) { }
>   #endif
>
>   /**
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index e525662f82f..8f78fcdf7c8 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2281,7 +2281,7 @@ static efi_status_t EFIAPI efi_exit_boot_services(=
efi_handle_t image_handle,
>   		if (IS_ENABLED(CONFIG_USB_DEVICE))
>   			udc_disconnect();
>   		board_quiesce_devices();
> -		dm_remove_devices_active();
> +		dm_remove_dma_devices();
>   	}
>
>   out:
> diff --git a/test/dm/core.c b/test/dm/core.c
> index 959b834576f..1194e3250b5 100644
> --- a/test/dm/core.c
> +++ b/test/dm/core.c
> @@ -1057,7 +1057,7 @@ static int dm_test_remove_active(struct unit_test_=
state *uts)
>   	ut_asserteq(true, device_active(dma_vital));
>
>   	/* Remove active devices in an ordered way */
> -	dm_remove_devices_active();
> +	dm_remove_dma_devices();
>
>   	/* Check that all devices are inactive right now */
>   	ut_asserteq(true, device_active(normal));

