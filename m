Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD96C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 16:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 972A682DF2;
	Wed, 25 Jun 2025 18:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eaUC3rEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C3982D83; Wed, 25 Jun 2025 18:10:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C74582CFA
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 18:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 61C3C5C5859;
 Wed, 25 Jun 2025 16:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2885FC4CEEA;
 Wed, 25 Jun 2025 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750867854;
 bh=utHsBE7qzpbq0uwDoDl7Xb9HgpgSX1LsIBZLZCO5CJ8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=eaUC3rELt2qW4BML3rp+i9WDUY7lQXiijc8Wp9W7DEOCN+j+WQKwyB72srurtBpzz
 Hv0lzTIlibvgDeanemeX1VDgU2jgQfSWZkeeYlvJjm3Kcj1vnA91iDHpg4ZRGroWxL
 gs/BtwLMV65GukySm59QPHBdGmvZ1GcNPbu+jWVM/BwqddPTzA6mHD7ncWO4sHa6fn
 zy7tox8TvuJTjwDbYhMVnjp38ZDk8qpx3OH/Du1aKhWAzSErQ55CFc+NmMIyjiWkSl
 5sBFmV76huW4DfWTmNiuEtoTDOTbT5Y0JgvyUZLt1pcLGg7v5zcA1nGgu1jXcLsdRu
 aiNxdRwVvCxiw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Safae
 Ouajih <souajih@baylibre.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH v2] cmd: abootimg: Prevent use of unintialised variable
In-Reply-To: <20250625-abootimg_fix-v2-1-0d295dc1f1e2@linaro.org>
References: <20250625-abootimg_fix-v2-1-0d295dc1f1e2@linaro.org>
Date: Wed, 25 Jun 2025 18:10:52 +0200
Message-ID: <87wm8zx0mr.fsf@kernel.org>
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

Hi Andrew,

Thank you for the patch.

On Wed, Jun 25, 2025 at 16:52, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> vhdr can be used when not initialised so detect this condition
> and exit early to prevent the problem.
>
> This issue was found with Smatch.
>
> Fixes: 636da2039aea (android: boot: support boot image header version 3 and 4)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Changes in v2:
> - Add unmap_sysmem(hdr) in the new exit path
> - Link to v1: https://lore.kernel.org/r/20250625-abootimg_fix-v1-1-ce1645ac9879@linaro.org
> ---
>  cmd/abootimg.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index ae7a1a7c83b..31620aa3cfa 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -98,18 +98,20 @@ static int abootimg_get_dtb_load_addr(int argc, char *const argv[])
>  	const struct andr_vnd_boot_img_hdr *vhdr;
>  
>  	hdr = map_sysmem(abootimg_addr(), sizeof(*hdr));
> -	if (get_avendor_bootimg_addr() != -1)
> +	if (get_avendor_bootimg_addr() != -1) {
>  		vhdr = map_sysmem(get_avendor_bootimg_addr(), sizeof(*vhdr));
> +	} else {
> +		unmap_sysmem(hdr);
> +		return CMD_RET_FAILURE;
> +	}

It's valid for avendor_bootimg_adr() to be -1.
This is the case for boot image v2 and lower, where there is no
boot_vendor partition. (so there is no valid vhdr).

Per my understanding vhdr* is NULL if left unintialised. (I might be
wrong, please let me know).

android_image_get_data() handles the case where vendor_boot_hdr is NULL:
"""
	if (((struct andr_boot_img_hdr_v0 *)boot_hdr)->header_version > 2) {
		if (!vendor_boot_hdr) {
			printf("For boot header v3+ vendor boot image has to be provided\n");
			return false;
		}
"""

So I don't think we should early return here.
If we do, we will probably break boot image v2 support.

>  
>  	if (!android_image_get_data(hdr, vhdr, &img_data)) {
> -		if (get_avendor_bootimg_addr() != -1)
> -			unmap_sysmem(vhdr);
> +		unmap_sysmem(vhdr);
>  		unmap_sysmem(hdr);
>  		return CMD_RET_FAILURE;
>  	}
>  
> -	if (get_avendor_bootimg_addr() != -1)
> -		unmap_sysmem(vhdr);
> +	unmap_sysmem(vhdr);
>  	unmap_sysmem(hdr);
>  
>  	if (img_data.header_version < 2) {
>
> ---
> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
> change-id: 20250625-abootimg_fix-51600dc8356a
>
> Best regards,
> -- 
> Andrew Goodbody <andrew.goodbody@linaro.org>
