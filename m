Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB9EC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 07:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE58B82958;
	Fri, 11 Jul 2025 09:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FmFt/mLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E1D8006D; Fri, 11 Jul 2025 09:23:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD8878006D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 09:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 71A8E5C6E21;
 Fri, 11 Jul 2025 07:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907C1C4CEED;
 Fri, 11 Jul 2025 07:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752218618;
 bh=YMx7gVWvZGBtJqEZdsUZm8TkuK5EREKCi4IImunhOm4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=FmFt/mLldv+qtgEiTQyLa/Tnr3n9UaALDQbBes2FG/gOMztR2k5QjAdnEV8goejIq
 EWRQUJoRLZIGruef03BUhit5NZBkONYTg51Z0Oe62QfV7eNPIp6jvMt5nLvBqmubEa
 4vWBxaGof+vcjPwnwXKrgpQotw1FKh4skTIEF8V+Y+dwRpkr9edA+WdVC7pUXLuZcZ
 Z64Yoxo3OlFCmfAmF+M958gUh1quGsxbL0h2rATXj4cvzUqejzCmjavX+L5b6DB/RB
 W/m/t1ZAvYSa36Zj6DL7bZevXt1pcuAkEnw6Y/zXiq7GJ7SLdmtO8cVNQVAATCEptx
 uHkctpmDBc4ZA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Chance Yang <chance.yang@kneron.us>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, morgan.chang@kneron.us, Chance Yang
 <chance.yang@kneron.us>
Subject: Re: [PATCH] fastboot: Fix has-slot command always returning yes for
 fb_nand
In-Reply-To: <20250708-master-v1-1-574f8bec645d@kneron.us>
References: <20250708-master-v1-1-574f8bec645d@kneron.us>
Date: Fri, 11 Jul 2025 09:23:35 +0200
Message-ID: <87a55bjimg.fsf@kernel.org>
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

Hi Chance,

Thank you for the patch.

On Tue, Jul 08, 2025 at 09:16, Chance Yang <chance.yang@kneron.us> wrote:

> The issue was a mismatch in return value conventions between functions:
> - getvar_get_part_info() expects >= 0 for success
> - fb_nand_lookup() returns 0 on success, 1 on failure (from
>   find_dev_and_part)
>
> When partition didn't exist, fb_nand_lookup returned 1, but
> fastboot_nand_get_part_info passed it directly to getvar_get_part_info,
> which treated 1 >= 0 as success, causing has-slot to always return yes.
>
> Fix by converting positive return values to -ENOENT in
> fastboot_nand_get_part_info to match the expected error convention.
>
> Signed-off-by: Chance Yang <chance.yang@kneron.us>
> ---
>  drivers/fastboot/fb_nand.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
> index afc64fd5280717ae4041ed70268ccc01cfbb0496..b819541eb8fa6f537ca40fb3ea81bc7aab6118bf 100644
> --- a/drivers/fastboot/fb_nand.c
> +++ b/drivers/fastboot/fb_nand.c
> @@ -157,8 +157,13 @@ int fastboot_nand_get_part_info(const char *part_name,
>  				struct part_info **part_info, char *response)
>  {
>  	struct mtd_info *mtd = NULL;
> +	int ret;
> +
> +	ret = fb_nand_lookup(part_name, &mtd, part_info, response);
> +	if (ret > 0)

ret > 0 does not cover all the failure paths in fb_nand_lookup():

Inspecting fb_nand_loopup(), it can fail in 3 different ways.
In case of failure:

1. mtdparts_init(): returns 1
2. find_dev_and_part(): returns 1
3. dev->id->type != MTD_DEV_TYPE_NAND: returns -EINVAL

Right now, we only cover failure path 1. and 2.

Could we change this to:

if (ret)

Thanks,
Mattijs

> +		return -ENOENT;
>  
> -	return fb_nand_lookup(part_name, &mtd, part_info, response);
> +	return ret;
>  }
>  
>  /**
>
> ---
> base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
> change-id: 20250708-master-b6a53395df05
>
> Best regards,
> -- 
> Chance Yang <chance.yang@kneron.us>
