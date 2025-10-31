Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1036ACCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D9683966;
	Fri, 31 Oct 2025 16:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h0shdlFd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D862183971; Fri, 31 Oct 2025 16:39:32 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7436383677
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4739A601DC;
 Fri, 31 Oct 2025 15:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C245DC4CEE7;
 Fri, 31 Oct 2025 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761925169;
 bh=wFbm4u6x5jO0qqms4YA5ynXnVvrOmeM49d78Rwg9P8g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=h0shdlFdtCsnP1S2n4WXlc8OlNL1mecaXtmleSAPFtp4L5Yl24+N4YivpaoCnIZPT
 rXw0GcIiSkuvHW0tHAS7kXl43Qm5tL3QaumSmzu3UX+YxTNt0oHKGrH1jje6OnLR0y
 2DDNaoySFvWBLPJPu2aeeIPCTFFArSc+PPCtK+sJVWOlpHw+NEcQuPAa4au2aTvN/I
 MigqkQkynfr2lGq+pQnm3srOZix0yGXbMXMzt4+hL6wBOCa2SEC+ZZ6h4IPwORGahY
 /lSZPO1dIobux1pqugPB9I8NSDV9uRxmi/b8j/+QDzucokc8K+JeiKQnUsTWMKVPGu
 3stHRCVwFlz1Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>
Subject: Re: [PATCH v2 1/5] boot: android: import addBootConfigParameters()
 from AOSP
In-Reply-To: <20251017-bootconfig-v2-1-8c7c2f2e5474@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-1-8c7c2f2e5474@baylibre.com>
Date: Fri, 31 Oct 2025 16:39:22 +0100
Message-ID: <87ikfv5bdh.fsf@kernel.org>
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

Hi Guillaume,

Thank you for the patch.

On Fri, Oct 17, 2025 at 15:19, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:

> From: "Mattijs Korpershoek (TI.com)" <mkorpershoek@kernel.org>
>
> To properly implement Android boot image v4, U-Boot must be able to
> add additional entries to the bootconfig.
>
> Add `add_bootconfig_parameters()` to do so.
>
> This has been imported from Google's U-Boot source[1]
> The variables/function names have been reworked to be
> compliant with U-Boot's coding style.
>
> [1] https://android.googlesource.com/platform/external/u-boot/+/7af0a0506d4de6f5ea147d10fb0664a8af07d326
> Signed-off-by: Mattijs Korpershoek (TI.com) <mkorpershoek@kernel.org>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  boot/image-android.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index e46dee0d9b3..3a0a934acc7 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -57,6 +57,44 @@ static ulong add_trailer(ulong bootconfig_start_addr, ulong bootconfig_size)
>  	return BOOTCONFIG_TRAILER_SIZE;
>  }
>  
> +/*
> + * Add a string of boot config parameters to memory appended by the trailer.
> + * NOTE: This function expects bootconfig_start_addr to be already mapped.
> + *       It works directly with the mapped pointer, not a physical address.
> + */
> +u32 add_bootconfig_parameters(char *params, ulong params_size,
> +			      ulong bootconfig_start_addr, u32 bootconfig_size)
> +{
> +	if (!params || !bootconfig_start_addr)
> +		return -1;
> +
> +	if (params_size == 0)
> +		return 0;
> +
> +	u32 applied_bytes = 0;
> +	u32 new_size = 0;
> +	ulong end = bootconfig_start_addr + bootconfig_size;
> +
> +	if (is_trailer_present(end)) {
> +		end -= BOOTCONFIG_TRAILER_SIZE;
> +		applied_bytes -= BOOTCONFIG_TRAILER_SIZE;
> +		memcpy(&new_size, (void *)end, BOOTCONFIG_SIZE_SIZE);
> +	} else {
> +		/*
> +		 * When no trailer is present, the bootconfig_size includes the actual content.
> +		 * We should write new parameters right after the existing content.
> +		 */
> +		end = bootconfig_start_addr + bootconfig_size;
> +		new_size = bootconfig_size;
> +	}
> +
> +	memcpy((void *)end, params, params_size);
> +	applied_bytes += params_size;
> +	applied_bytes += add_trailer(bootconfig_start_addr,
> +				     bootconfig_size + applied_bytes);
> +	return applied_bytes;
> +}
> +
>  __weak ulong get_avendor_bootimg_addr(void)
>  {
>  	return -1;
>
> -- 
> 2.34.1
