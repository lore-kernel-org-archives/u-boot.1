Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB80CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 13:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E952184497;
	Thu,  9 Oct 2025 15:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NOlrtMGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E7C284500; Thu,  9 Oct 2025 15:13:13 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3DA084408
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 15:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BBC4961499;
 Thu,  9 Oct 2025 13:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08A3C4CEE7;
 Thu,  9 Oct 2025 13:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760015589;
 bh=xE1yzYwzkrI2VqlzFCILbbd8sSHw/aH/RCwA4fqg98s=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=NOlrtMGHVirSZk277hL27/LgyfhE5WRlPJY1utId89JlIaI4ziQ5FOTAAvzykmeWz
 aSP6aZftIQobwGIVbrTsIv8+MrQ/H78kHgkpRyfI6jLKQTxnACPctgO75BROkNcTYk
 HZpRcfUwgUyoGW6M9TLkbN9DXiXg+li9G/SWk68XA+OI2MbSLtMRngr7+NZz+t2+Ph
 WewHQSv+UvCTQkn6UcK+S28pUHF6QHCzI1ds60Ps+uMyfWPuJJN0mfUYB+6UywqGQN
 KFjJiJpH6fszZQDKrnVRvqEMH2mgCH7U0lj2CV/yymIBMzaKIeu0QdgV3+aM4dfcZy
 ZbjePgWXjCUiQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Maximilian Brune
 <maximilian.brune@9elements.com>, Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 2/4] boot: Move obtaining the label into a common file
In-Reply-To: <20251009092959.260121-3-sjg@chromium.org>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-3-sjg@chromium.org>
Date: Thu, 09 Oct 2025 15:13:07 +0200
Message-ID: <87zfa0uskc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On Thu, Oct 09, 2025 at 03:29, Simon Glass <sjg@chromium.org> wrote:

> The 'bootflow list' command supports looking at the EFI device-path when
> available. Move this piece into a common function so it can be used
> elsewhere.
>
> Use 'usb' instead of 'usb_mass_storage' for usb so that it fits in the
> column space.
>
> This updates the output from 'bootflow list'.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
> (no changes since v1)
>
>  boot/bootflow.c      | 19 +++++++++++++++++++
>  cmd/bootflow.c       |  8 +++++---
>  include/bootflow.h   |  8 ++++++++
>  test/boot/bootflow.c |  2 +-
>  4 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 15df7069209..78df09f369d 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -11,6 +11,7 @@
>  #include <bootmeth.h>
>  #include <bootstd.h>
>  #include <dm.h>
> +#include <efi_device_path.h>
>  #include <env_internal.h>
>  #include <malloc.h>
>  #include <serial.h>
> @@ -1010,3 +1011,21 @@ int bootflow_get_seq(const struct bootflow *bflow)
>  
>  	return alist_calc_index(&std->bootflows, bflow);
>  }
> +
> +const char *bootflow_guess_label(const struct bootflow *bflow)
> +{
> +	const char *name = NULL;
> +
> +	if (bflow->dev) {
> +		struct udevice *media = dev_get_parent(bflow->dev);
> +
> +		if (device_get_uclass_id(media) == UCLASS_MASS_STORAGE)
> +			name = "usb";
> +		else
> +			name = dev_get_uclass_name(media);
> +	}
> +	if (!name)
> +		name = "(none)";
> +
> +	return name;
> +}
> diff --git a/cmd/bootflow.c b/cmd/bootflow.c
> index 551dffbb8b8..5b803d4ace5 100644
> --- a/cmd/bootflow.c
> +++ b/cmd/bootflow.c
> @@ -70,10 +70,12 @@ static void report_bootflow_err(struct bootflow *bflow, int err)
>   */
>  static void show_bootflow(int index, struct bootflow *bflow, bool errors)
>  {
> +	const char *name = bootflow_guess_label(bflow);
> +
>  	printf("%3x  %-11s  %-6s  %-9.9s %4x  %-25.25s %s\n", index,
> -	       bflow->method->name, bootflow_state_get_name(bflow->state),
> -	       bflow->dev ? dev_get_uclass_name(dev_get_parent(bflow->dev)) :
> -	       "(none)", bflow->part, bflow->name, bflow->fname ?: "");
> +	       bflow->method ? bflow->method->name : "(none)",
> +	       bootflow_state_get_name(bflow->state), name, bflow->part,
> +	       bflow->name, bflow->fname ?: "");
>  	if (errors)
>  		report_bootflow_err(bflow, bflow->err);
>  }
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 2ef6eb25cf5..657e3731f11 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -692,4 +692,12 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
>   */
>  int bootflow_menu_poll(struct expo *exp, int *seqp);
>  
> +/**
> + * bootflow_guess_label() - Produce a plausible label for a bootflow
> + *
> + * This uses the uclass name or EFI device-path to come up with a useful label
> + * for display to the user. Ideally it will say "mmc", "usb", nvme", etc.
> + */
> +const char *bootflow_guess_label(const struct bootflow *bflow);
> +
>  #endif
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 7cd83dc7443..73fe3d34d0f 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -1301,7 +1301,7 @@ static int bootflow_efi(struct unit_test_state *uts)
>  	ut_assert_nextlinen("---");
>  	ut_assert_nextlinen("  0  extlinux");
>  	ut_assert_nextlinen(
> -		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
> +		"  1  efi          ready   usb          1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
>  	ut_assert_nextlinen("---");
>  	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
>  	ut_assert_console_end();
> -- 
> 2.43.0
