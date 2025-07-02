Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBD9C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EEB82103;
	Wed,  2 Jul 2025 12:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fSw8vP91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F0A82ADA; Wed,  2 Jul 2025 12:27:43 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 183AE80E9A
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CA6766141F;
 Wed,  2 Jul 2025 10:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DE0C4CEED;
 Wed,  2 Jul 2025 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751452059;
 bh=DRSw98DcMEhpWFYBQN/qABMs1qxO4+LVjT8UVrg8Ye4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=fSw8vP910SG6JrO9sRsVfGgafsu7bIuS8tDPSFSfS6nez+x7OWUfrphhef2l8WPlu
 JliMSakILdaOMQty5oCLpxaIbrrOpgRCP8CFFobrD8WPG/rcfOIlkSoVfKiDzVCRjl
 Kl7Zae3bqItOn1zql0HKL4NAS7VTQh5M7htkYJx9NV78ostNTgchJEPvq+KKS5gLdv
 Y0tMqEsKRlgk4g8cbZOr48mT3O/O4TcyaBKmFEhubZH+L8C2bxozwGvPr6j4HGqWVK
 mcJnDGv3lqqEpSY+/J1vP7MohVWbx5TbzBkheGgokU07e8qrdAXbk9ILK27YuWtWFx
 400wB4FS0NMGw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 1/2] boot/android_ab.c: Make use of LBAF for printing
 lbaint_t
In-Reply-To: <20250702010603.19354-1-trini@konsulko.com>
References: <20250702010603.19354-1-trini@konsulko.com>
Date: Wed, 02 Jul 2025 12:27:36 +0200
Message-ID: <87cyaiubtz.fsf@kernel.org>
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

Hi Tom,

Thank you for the patch.

On Tue, Jul 01, 2025 at 19:06, Tom Rini <trini@konsulko.com> wrote:

> When printing the contents of an lbaint_t variable we need to use LBAF
> to print it in order to get the correct format type depending on 32 or
> 64bit-ness. Furthermore, printed message should not be split as that
> makes finding them harder, so bring this back to a single line.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  boot/android_ab.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index a287eac04fe8..13e82dbcb7fe 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -101,8 +101,7 @@ static int ab_control_create_from_disk(struct blk_desc *dev_desc,
>  	abc_blocks = DIV_ROUND_UP(sizeof(struct bootloader_control),
>  				  part_info->blksz);
>  	if (abc_offset + abc_blocks > part_info->size) {
> -		log_err("ANDROID: boot control partition too small. Need at");
> -		log_err(" least %lu blocks but have %lu blocks.\n",
> +		log_err("ANDROID: boot control partition too small. Need at least %lu blocks but have " LBAF " blocks.\n",
>  			abc_offset + abc_blocks, part_info->size);
>  		return -EINVAL;
>  	}
> -- 
> 2.43.0
