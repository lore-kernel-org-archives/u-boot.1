Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046FCC7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 06:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6578682B6B;
	Fri, 27 Jun 2025 08:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tY/nU1St";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA96D82E52; Fri, 27 Jun 2025 08:51:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED4782B34
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 08:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1B9C55C6A72;
 Fri, 27 Jun 2025 06:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11F8C4CEE3;
 Fri, 27 Jun 2025 06:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751007072;
 bh=o8cKHVEkuGbAheyAWhYXKEFxCX9+LdVy/cAm12/B2H8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=tY/nU1StmrpHnqcOoXVFK88DbxpFvXBZKphdVXDt6vfwCrN5vL/6yFgORYeb/OA6o
 CCvWP1cFk8MaX3Too3I1JHTMbdBSTgEza3F8M6xnUSr85NObnV7PuJVLmjC6E//8A2
 XYkG0oMBQKIASe01TsAnw+H/zs1yu/FIV3AyXASa0ZyaZvPHctINxZQB4iMYK6gKqU
 inwl29qs12j2Eg0zOsimCTya1F9L1CTKztUmz69aQyLBlp9RDn768LpaOp1p7cz9ux
 pWy/sq9nrEOTDoTW4VEoou2UR3b9r2TogAMEX6mtrq7p5W2zGYRB3he0ODu07q68Bu
 KUuPVA6A89Naw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH v4 1/2] cmd: abootimg: Prevent use of unintialised variable
In-Reply-To: <20250625-abootimg_fix-v4-1-df7af00e87b0@linaro.org>
References: <20250625-abootimg_fix-v4-0-df7af00e87b0@linaro.org>
 <20250625-abootimg_fix-v4-1-df7af00e87b0@linaro.org>
Date: Fri, 27 Jun 2025 08:51:08 +0200
Message-ID: <878qldy8wz.fsf@kernel.org>
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

On Thu, Jun 26, 2025 at 17:38, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> Initiaise vhdr to prevent its use when uninitialised.

s/Initiaise/Initialise/: will fix when applying.

>
> This issue was found with Smatch.
>
> Fixes: 636da2039aea (android: boot: support boot image header version 3 and 4)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
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
> -- 
> 2.39.5
