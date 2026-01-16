Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3B9D47CD6
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C97A830E4;
	Fri, 16 Jan 2026 11:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jfE0f5W5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EF6483623; Fri, 16 Jan 2026 11:50:46 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB79982BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2CCF141B09;
 Fri, 16 Jan 2026 10:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D899C116C6;
 Fri, 16 Jan 2026 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768560642;
 bh=1rUf5XomTb57746wrhhygO3nxjRX35VMsKwuhpdg+/o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jfE0f5W5rt57U01g668eN+Ru1fyYU38HOJHw4wkvOq72IKiO5eMrec+UXvoJ3u/Wx
 WMw7oVC0iis90K+ibhtffnB6sg8YWGURamLiCRPbz7A3cZN2GWiI10ovKJs8dwNLHN
 Cz832pfBS2u1nDlmqGWq7Q6IDZW8rIcn8rLmvHKU8WjG4xG8lZEZDTJDHJSATRQt+W
 kcS1+XYgQA+Z86ZFh9XQ0e+5ARdsUFUWFeEtY0sesNWizkKaP1AAG7GjYJzK/GF95+
 Gb5N7nRlDAz8AL+XYWVmojFKgw+MYnx2pdUREVzyBoeCjsjUPlJWgWkVhV7F5eiezF
 18FWlMCM/OKuw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Marek
 Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, Kory
 Maincent <kory.maincent@bootlin.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Dinesh
 Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Simon Glass
 <simon.glass@canonical.com>
Subject: Re: [PATCH v3 3/6] dm: core: Support multiple drivers with same
 compatibles
In-Reply-To: <20260114-topic-musb-probing-v2026-01-v3-3-ebb8d990b9df@baylibre.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
 <20260114-topic-musb-probing-v2026-01-v3-3-ebb8d990b9df@baylibre.com>
Date: Fri, 16 Jan 2026 11:50:39 +0100
Message-ID: <87bjitesqo.fsf@kernel.org>
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

Hi Markus,

Thank you for the patch.

On Wed, Jan 14, 2026 at 09:33, "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> Currently once a driver matched the compatible string of a device, other
> drivers are ignored. If the first matching driver returns -ENODEV, no
> other possibly matching drivers are iterated with that compatible of the
> device. Instead the next compatible in the list of compatibles is
> selected, assuming only one driver matches one compatible at a time.
>
> To be able to use the bind function to return -ENODEV and continue
> matching other drivers with the same compatible, move the for loop a bit
> to continue the for loop after -ENODEV was returned. The loop had to be
> adjusted a bit to still support the 'drv' argument properly. Some
> simplifications where done as well.

Nitpick: where -> were.

Please don't do any refactor/tweaks in this patch. drivers/core is
already difficult enough to review without formatting changes (to me at
least)

I see a couple below.

>
> The modification will only add additional loop iterations if -ENODEV is
> returned. Otherwise the exit and continue conditions for the loop stay
> the same and do not cause any additional iterations and should not
> impact performance.
>
> This is required for ti-musb-host and ti-musb-peripheral which both
> match on the same device but differ based on the dr_mode DT property.
> Depending on this property, the driver is either UCLASS_USB or
> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind

Nitpick: UCLASS_USB_GADGET_GENERIC (not GENERIc)

> function and returning -ENODEV the other driver can probe instead.
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  drivers/core/lists.c | 65 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> index 9d1ca38212ee7f53b8894f964f096611c8ec20a5..3d9f9bc93954efdd624dddb1833f3a855c3c28de 100644
> --- a/drivers/core/lists.c
> +++ b/drivers/core/lists.c
> @@ -235,50 +235,51 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>  		log_debug("   - attempt to match compatible string '%s'\n",
>  			  compat);
>  
> -		id = NULL;
>  		for (entry = driver; entry != driver + n_ents; entry++) {
> +			/* Search for drivers with matching drv or existing of_match */
>  			if (drv) {
>  				if (drv != entry)
>  					continue;
> -				if (!entry->of_match)
> -					break;
> +			} else if (!entry->of_match) {
> +				continue;
>  			}
> -			ret = driver_check_compatible(entry->of_match, &id,
> -						      compat);
> -			if (!ret)
> -				break;
> -		}
> -		if (entry == driver + n_ents)
> -			continue;
>  
> -		if (pre_reloc_only) {
> -			if (!ofnode_pre_reloc(node) &&
> -			    !(entry->flags & DM_FLAG_PRE_RELOC)) {
> -				log_debug("Skipping device pre-relocation\n");
> -				return 0;
> +			id = NULL;
> +			if (entry->of_match) {
> +				ret = driver_check_compatible(entry->of_match, &id,
> +							      compat);
> +				if (ret)
> +					continue;
> +				log_debug("   - found match at driver '%s' for '%s'\n",
> +					  entry->name, id->compatible);
> +			}
> +
> +			if (pre_reloc_only) {
> +				if (!ofnode_pre_reloc(node) &&
> +				    !(entry->flags & DM_FLAG_PRE_RELOC)) {
> +					log_debug("   - Skipping device pre-relocation\n");


This was changed from :

  log_debug("Skipping device pre-relocation\n");

Please move log formatting to a separate, cosmetic patch. This way, this
patch stays purely functional, and simpler.

See: https://docs.u-boot.org/en/latest/develop/sending_patches.html#general-patch-submission-rules


> +					return 0;
> +				}
> +			}
> +
> +			ret = device_bind_with_driver_data(parent, entry, name,
> +							   id ? id->data : 0, node,
> +							   &dev);
> +			if (!drv && ret == -ENODEV) {
> +				log_debug("   - Driver '%s' refuses to bind\n", entry->name);

Same here. We added "   -" to the log, making the diff overly
complicated.

Locally, discarded these message formatting changes and the diff was
much simpler.

Can we please re-submit by moving the formatting changes in a separate
patch?

Thanks
Mattijs


