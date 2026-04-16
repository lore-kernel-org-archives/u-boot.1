Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2CDF43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16AAA84308;
	Fri, 17 Apr 2026 14:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nAsNnDu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA188407E; Thu, 16 Apr 2026 22:54:10 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9340883EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so2692366b.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 13:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776372847; cv=none;
 d=google.com; s=arc-20240605;
 b=jSK4pxIydlgEa9Ym4QsJidnGguua5vZEQnQGiAkHvXBsvDDVAlsY21c52JS4SM3MVx
 IWRBb3y6qcA4vFPdjyy0ayHyah3xpg6CgxEimLslLUcTcdA4JlNegJtzrWsq6LimG59I
 1qi25CokPD63n/fFS0cix9LrWreMi2ABDETWQCHcMe09O7yHvS/ceeexljTek4WkVkei
 4lH5gLYNK3pBSQu8hBmig7wwx+H1RpqGk4lj/r9PylltRtbIkMyfeNm44AQW2oJlsX8K
 1kdQHyumpbkVgt/++4z4YOZYJyx00jXhYjev7+jonywSAG+331xrhs4gy4wCN2Ea4Esh
 F93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x8U/Znn9nY7RBIoyT0cFN9dqQlWWI598tMsRGvzMjSk=;
 fh=ytDaZH57tvJbi13kk84jL7PYO94aG37dlwdUZrOBMj0=;
 b=MpRmlneaD1MjvUJzGdxmPFm8eGyLJWI10JN0grk2KwKq2aNE6cyp7kgYoruIRM6CtC
 iXgC5/SAKUK4VHokiJ1rUmfQUr9PC+80keaD3d6fNAxwppVXdmfgb65XgBAUVZlP644T
 IE6Bms26Q+UP6UWBFh+JVl8UFIrF7wr5tnfIo+s52ZJoa2fBumHd19PDDQDep9OMEA4s
 47HwqaX1oXf36N9eFgyEuptd5+m1AqrrCHximJHCYFRGfBdikJFSlCl5zJh1b5qloAAR
 92m0HWTQ0oR9krAuvZq7+Y8R0n1ru8VCAnXrn4a4YnaAcbWBbKJjlhRwG4YpCVwJjTeT
 cGwA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776372847; x=1776977647; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x8U/Znn9nY7RBIoyT0cFN9dqQlWWI598tMsRGvzMjSk=;
 b=nAsNnDu8KUTmb+mpVcZC8ADHnBgBcO93iVeiUKCRQM89vGM8wcqnMikcF231w+Xf8G
 kUiZXo/nD+a4dZCwhfzCAKglM2b5+neLu4zvzdMqBVlt//8cbD6oik76B4NrYBVM+D49
 qD+ZW+awmGIXpm41KdX/a4UZRVuuiNi53tcaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776372847; x=1776977647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8U/Znn9nY7RBIoyT0cFN9dqQlWWI598tMsRGvzMjSk=;
 b=CgZvPqZOQR1LXBnqgTdyJsXLB1FrTmZSZjMFAP3IyoaRi7cUBl9vk5AuwsC/4QfxXS
 tJfEYqWc/U3EP5YbAzt15O3n6WDPfUW657imw7/DVVd5pkKqAGTIRlNUPOMZN4JU+Zax
 a+WwcoIthINfLZNpn4pxlfMJuyNsPWONn6YwOj8f1KB0useAVGu51UCCV9lw5hlQpc6p
 pkz8cuUdXhN2w0fLzy6evolfZlMDQ0a8CNSFiQrTxesl5RVinewD7zJ2f36YgdLc+3gT
 uP/mbKN1fXMrRI2T1ybXm+q3DU/XbnBY2aejN9MZqYzVM0gR8UaVdPgSmWBsfGfP0LWq
 /Plg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9M63W5GTZ1MkOMACWItNJfl944iNg07grc4iItMgJQqYP2lOFLPC7+WSoaBeNB31V+Y/leJSI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzgv6IZ0dfS8iQnAa68a5FqF2xgCzGs7K37Ulc1Ej4rEOT49Mxh
 2xsUrT4SaKnjyQnKisHpzAvNO5Y+pA6kPFMCvCRLs1/4jmGegNjS+geZcXdCQPDlxJptLQ0iFvQ
 mzx819KRsFwF3CpySRw+Td8dN2x99II3PphjfrRmX
X-Gm-Gg: AeBDietiQ4pWQeEefS9Pv0v+82r7s5hzRZfiC9JKI8jHgEQ2H4J3uykHqO2uxHSVeNn
 xA57pXDnjoM2XaLKHNXhSIcUTg57s+QvwnCEqwH4IgoGUo6xKABmvnG0OEs9awkQQBBiVmbrCtX
 wuiArZA/l29x9+lfKV/264e4daIom6pxFZN05PrBMKUfgijgI0FC14UI8wpNk9Scxi4mIxd21wS
 nsB6AGGLWf2g1vrRrCqrbxHinZMb+kmtS40WN8RaUmbmUM9TptsWi2e9BTg0qrZn49+neVC1WUO
 wBpbPcYyrdqgBqhcxyoCWJmBluOeiRg=
X-Received: by 2002:a17:907:a60b:b0:b9c:b069:8ab6 with SMTP id
 a640c23a62f3a-ba418b7e7d6mr5714766b.7.1776372846882; Thu, 16 Apr 2026
 13:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-7-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260416053928.2834699-7-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 08:53:54 +1200
X-Gm-Features: AQROBzC4gdui_xpmBNIg96bPYGWvBXNgdX8Civ34VEoWfE4MMPo9a5Qlmz6R8Ic
Message-ID: <CAFLszTiwN_YU9SkHATfXCW+AhhDWpsNPudY9wTxC2Q98jjdLow@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] mach-snapdragon: Add initial support for IPQ5210
 SPL
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, tingting.meng@altera.com, anshuld@ti.com, 
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, dinesh.maniyam@altera.com, 
 luca.weiss@fairphone.com, danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com, 
 balaji.selvanathan@oss.qualcomm.com, adrian@mainlining.org, n-francis@ti.com, 
 wens@kernel.org, jamie.gibbons@microchip.com, justin@tidylabs.net, 
 ycliang@andestech.com, david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 richard.genoud@bootlin.com, michael@amarulasolutions.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Hi Varadarajan,

On 2026-04-16T05:39:18, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> mach-snapdragon: Add initial support for IPQ5210 SPL
>
> Add basic SPL infrastructure for IPQ5210 SoC. This handles basic serial
> console init, identifying the boot media, loading the additional
> firmware binaries to setup DDR, TFA and eventually jump to U-Boot.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> arch/arm/Kconfig                  |   5 +-
>  arch/arm/mach-snapdragon/Makefile |   3 +
>  arch/arm/mach-snapdragon/spl.c    | 640 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 646 insertions(+), 2 deletions(-)

> +static int spl_find_partition_info(enum uclass_id uclass_id, int device_num,
> +                                const char *part_name,
> +                                struct disk_partition *info)

This function is defined unconditionally but only called within the
CONFIG_IS_ENABLED(MMC) block - you could use __maybe_unused ?

> +void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
> +{
> +     void *buffer = spl_get_load_buffer(0, sectors * bl_len);
> +
> +     if (!buffer) {
> +             pr_err("Failed to get FIT load buffer\n");
> +             qcom_spl_error_handler(NULL);
> +     }

spl_get_load_buffer() always returns a non-null address so this code
is not needed

> + * @entry_point:Pointer to store the retrieved entry point.

nit: missing space after the colon

> +     if (desc->part_type == PART_TYPE_UNKNOWN) {
> +             printf("Initializing partition table\n");
> +             /*
> +              * Prefer EFI/GPT
> +              */
> +             desc->part_type = PART_TYPE_EFI;
> +     }

Simply setting part_type to PART_TYPE_EFI doesn't actually initialise
the partition table - it just tells the partition code to assume GPT.
If the device doesn't have GPT, it will fail - how about calling
part_init() or letting part_driver_lookup_type() auto-detect?

Regards,
Simon
