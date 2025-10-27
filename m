Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0965CCCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 750B4836D1;
	Mon, 27 Oct 2025 14:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XeMb22Bl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA74836EE; Mon, 27 Oct 2025 14:22:26 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C09832AD
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CD5C943B4B;
 Mon, 27 Oct 2025 13:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0923DC4CEF1;
 Mon, 27 Oct 2025 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761571342;
 bh=rySXdE+Gwm3cYhlC38z0EgVnq6ZVDK+TgLtK5XF5cHU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=XeMb22BlEke3B0QGVmPyVcIpPIXdFBXQvpFrPX6nXku9trAm1NUz2J42CeitGTfsf
 7m7VrmG4+7fnUscbPTNeOWelfog8XPCRHHXmIVv6zG1cvZ2RRdhGV1lZqdXoD6VhYm
 gIRqN7rEBgF1ancrQK8/Yhv/fKxddxSC7LEJ4a/iZ8pVwZwc0pUKGSHgbsjxvwq8LX
 ihnYjMkyMFKajWxJzsGK/WeHBWY7bRiz2vybnO40HicLfWfC+WTKjMJbMvUCfN01kW
 Uibs8Nk5FUJX/aX1hLO1Kx/ko9TzAUS6I4sM0C2+E70ydszONxCHCILWwpp/irGXyv
 qaSpzyQKusNlA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>, u-boot@lists.denx.de
Cc: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, Julien Masson
 <jmasson@baylibre.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Mayuresh Chitale
 <mchitale@ventanamicro.com>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 5/9] image: Fix typos in image.h
In-Reply-To: <20251024151219.100970-6-wolfgang.wallner@br-automation.com>
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
 <20251024151219.100970-6-wolfgang.wallner@br-automation.com>
Date: Mon, 27 Oct 2025 14:22:19 +0100
Message-ID: <874irklbsk.fsf@kernel.org>
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

Hi Wolfgang,

Thank you for the patch.

On Fri, Oct 24, 2025 at 17:12, "Wolfgang Wallner" <wolfgang.wallner@br-automation.com> wrote:

> Fix some typos in include/image.h.
>
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
>  include/image.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/image.h b/include/image.h
> index fc2f2487095..9a1c828416d 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -654,10 +654,10 @@ int boot_get_fpga(struct bootm_headers *images);
>   * boot_get_ramdisk() is responsible for finding a valid ramdisk image.
>   * Currently supported are the following ramdisk sources:
>   *      - multicomponent kernel/ramdisk image,
> - *      - commandline provided address of decicated ramdisk image.
> + *      - commandline provided address of dedicated ramdisk image.
>   *
>   * returns:
> - *     0, if ramdisk image was found and valid, or skiped
> + *     0, if ramdisk image was found and valid, or skipped
>   *     rd_start and rd_end are set to ramdisk start/end addresses if
>   *     ramdisk image is found and valid
>   *
> @@ -739,7 +739,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>   * @param bootstage_id	ID of starting bootstage to use for progress updates.
>   *			This will be added to the BOOTSTAGE_SUB values when
>   *			calling bootstage_mark()
> - * @param load_op	Decribes what to do with the load address
> + * @param load_op	Describes what to do with the load address
>   * @param datap		Returns address of loaded image
>   * @param lenp		Returns length of loaded image
>   * Return: node offset of image, or -ve error code on error:
> @@ -812,7 +812,7 @@ int fit_get_node_from_config(struct bootm_headers *images,
>   * boot_get_fdt() is responsible for finding a valid flat device tree image.
>   * Currently supported are the following FDT sources:
>   *      - multicomponent kernel/ramdisk/FDT image,
> - *      - commandline provided address of decicated FDT image.
> + *      - commandline provided address of dedicated FDT image.
>   *
>   * Return:
>   *     0, if fdt image was found and valid, or skipped
> -- 
> 2.51.1
