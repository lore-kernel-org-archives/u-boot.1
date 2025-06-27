Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783C6C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 06:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF7D82B34;
	Fri, 27 Jun 2025 08:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="saPPuR40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D811782C65; Fri, 27 Jun 2025 08:49:10 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 430A080C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 08:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E92735C436F;
 Fri, 27 Jun 2025 06:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E51CC4CEE3;
 Fri, 27 Jun 2025 06:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751006944;
 bh=lEmYM35qgrzvfJmG6QbbJqnH+W09cc+IWAizD7QkkN0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=saPPuR40jqgbgkkciIspUdhGv1aamU5o9o4Ddkg5lqn6XIaRuU2J3lgOij4FWS9cN
 UMQLx3dkJ91xN/DG7kkjOJFgPHRjphLW49YERQ30Y+qZFbfaXHhLB27q1iuS7Ez2eH
 wcmDz3CnmGKmoGoVhtqRYAW/2bXgMjUkgGTE+Rh87CiovZkX7+erZbZbnkzf4XqjfW
 nW/vikmKAeu/c8/KZ79YMeg3DxjvPIkmc3rCIBWYYkjKPMsQmtwXzSgBc9HfUCQ+Kb
 HM9cT4xX9LnGL6l/D2qXj8fy+rZWYh3RKR4ApyLKoQpQ4J+nWrRTSGJ2NouqsyVR+G
 Cd8rnb0cdVZ1w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH v3] cmd: abootimg: Prevent use of unintialised variable
In-Reply-To: <20250625-abootimg_fix-v3-1-9f302e96807d@linaro.org>
References: <20250625-abootimg_fix-v3-1-9f302e96807d@linaro.org>
Date: Fri, 27 Jun 2025 08:49:01 +0200
Message-ID: <87bjq9y90i.fsf@kernel.org>
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

On Thu, Jun 26, 2025 at 09:58, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> Initiaise vhdr to prevent its use when uninitialised.

s/Initiaise/Initialise/: will fix when applying.

>
> This issue was found with Smatch.
>
> Fixes: 636da2039aea (android: boot: support boot image header version 3 and 4)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Changes in v3:
> - Just initialise the variable rather than exit early
> - Link to v2: https://lore.kernel.org/r/20250625-abootimg_fix-v2-1-0d295dc1f1e2@linaro.org
>
> Changes in v2:
> - Add unmap_sysmem(hdr) in the new exit path
> - Link to v1: https://lore.kernel.org/r/20250625-abootimg_fix-v1-1-ce1645ac9879@linaro.org
> ---
>  cmd/abootimg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index ae7a1a7c83b..9ae87581d2c 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -95,7 +95,7 @@ static int abootimg_get_dtb_load_addr(int argc, char *const argv[])
>  		return CMD_RET_USAGE;
>  	struct andr_image_data img_data = {0};
>  	const struct andr_boot_img_hdr_v0 *hdr;
> -	const struct andr_vnd_boot_img_hdr *vhdr;
> +	const struct andr_vnd_boot_img_hdr *vhdr = NULL;
>  
>  	hdr = map_sysmem(abootimg_addr(), sizeof(*hdr));
>  	if (get_avendor_bootimg_addr() != -1)
>
> ---
> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
> change-id: 20250625-abootimg_fix-51600dc8356a
>
> Best regards,
> -- 
> Andrew Goodbody <andrew.goodbody@linaro.org>
