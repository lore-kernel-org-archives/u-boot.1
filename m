Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635D2C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 06:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDF482B6B;
	Fri, 27 Jun 2025 08:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fa9kseNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE96282E52; Fri, 27 Jun 2025 08:53:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A5582B34
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 08:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8A1015C67C1;
 Fri, 27 Jun 2025 06:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BAEC4CEEB;
 Fri, 27 Jun 2025 06:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751007177;
 bh=H9Vk0OYEuYcjru5sJCAhsjA4PEvqJ5aI3uzAtvKb2so=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Fa9kseNb9kv/6ZEzQiags0S0msh3YtiLQOPAwieaphYPhUIn3X63B39p/ly2BesSr
 J5UKvPT8z0fugKA9SQuqKAJYMBybKxOB52Lotf+ISK60L19a+Fn5vKx9H8X59vJxqe
 Z0fuZWvpDGdzYa/8zp23amZANFMI0rIEVSSzDbICDeZnjfj6Twh6qyzjSqZYI+UC5F
 FqVV7FAsRldmk6/tgGm4GFuymQta+3mCFhlYbSYD/5BS4GnLy/dsAImMlbkWbeq4Rq
 LeQEadJDBN3/mDxh1Eg/fCtH9Ee7725z56HawPHMgAKZwptsNFZtvrfrKfc0A7KoH4
 CQDzHHFbXlDew==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH v4 2/2] boot: android: Prevent use of unintialised variable
In-Reply-To: <20250625-abootimg_fix-v4-2-df7af00e87b0@linaro.org>
References: <20250625-abootimg_fix-v4-0-df7af00e87b0@linaro.org>
 <20250625-abootimg_fix-v4-2-df7af00e87b0@linaro.org>
Date: Fri, 27 Jun 2025 08:52:54 +0200
Message-ID: <875xghy8u1.fsf@kernel.org>
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

> Initialise vhdr to prevent its use when uninitialised.
>
> This issue was found with Smatch.
>
> Fixes: e058176be32b (android: boot: add vendor boot image to prepare for v3, v4 support)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  boot/image-android.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 459cdb8456c..12bcf7e4fbd 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -677,7 +677,7 @@ bool android_image_get_dtb_by_index(ulong hdr_addr, ulong vendor_boot_img,
>  {
>  	struct andr_image_data img_data;
>  	const struct andr_boot_img_hdr_v0 *hdr;
> -	const struct andr_vnd_boot_img_hdr *vhdr;
> +	const struct andr_vnd_boot_img_hdr *vhdr = NULL;
>  
>  	hdr = map_sysmem(hdr_addr, sizeof(*hdr));
>  	if (vendor_boot_img != -1)
>
> -- 
> 2.39.5
