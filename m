Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E86C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 14:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0260587F1B;
	Fri,  8 Mar 2024 15:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="XjQH55T6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 758E187EED; Fri,  8 Mar 2024 15:41:29 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23ADC87EEB
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 15:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1709908884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRtsBIbmv5Mxv+A+uZmrKN29hx1T4vLOx4w7sxO0VRs=;
 b=XjQH55T6rRhOTSUrWbKfQN+H+x1q1qxVJEj/LqyR4HwmN8iASvwWwwekdcbHJvTxlSJ97Y
 Qm0+VX3doTy0LgeCFFipRZPyRU97C6u0dO0HXiiFKo52XOSbfDSOVdVha/EPFmSQjAWYT9
 97/p93sF5fha3zAFYD8jqk0yU6XeVuMxFBqFAx4eJqIDJYJpIn2kDfoTjQa6ptnqEK++yP
 0T8jKxM92p9Bi8322/aH3YQGx+Yso0xPraJJEhvlFkwCCLaE+VhWFdJiUad5ql+uBQamo8
 C+hQVwIz152xXZK3znI9Bw+ky+FtU3zuCu7IniTngvM4T6alIIqX3br2LaC7ag==
Date: Fri, 08 Mar 2024 15:41:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH] fdt_support: fix fdt_copy_fixed_partitions function()
In-Reply-To: <20240308133404.2619848-1-patrice.chotard@foss.st.com>
References: <20240308133404.2619848-1-patrice.chotard@foss.st.com>
Message-ID: <edbc4869d0244a81e92336e0b5f6b0e0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Patrice,

Please, see my comment below.

On 2024-03-08 14:34, Patrice Chotard wrote:
> Move variable declaration at the beginning of the function.
> 
> Fixes: 163c5f60ebb4 ("fdt_support: add fdt_copy_fixed_partitions 
> function")
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
>  boot/fdt_support.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 090d82ee80a..f948cf8cd42 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -1053,9 +1053,10 @@ void fdt_fixup_mtdparts(void *blob, const
> struct node_info *node_info,
>  int fdt_copy_fixed_partitions(void *blob)
>  {
>  	ofnode node, subnode;
> +	const u32 *reg;
>  	int off, suboff, res;
>  	char path[256];
> -	int address_cells, size_cells;
> +	int address_cells, size_cells, len;
>  	u8 i, j, child_count;
> 
>  	node = ofnode_by_compatible(ofnode_null(), "fixed-partitions");
> @@ -1101,9 +1102,6 @@ int fdt_copy_fixed_partitions(void *blob)
>  			if (!ofnode_valid(subnode))
>  				break;
> 
> -			const u32 *reg;
> -			int len;
> -

Perhaps it would be better to keep these two variables local
to the block they're used in.  I mean, in this case it isn't
a big deal anyway, but results in a bit cleaner code.

>  			suboff = fdt_find_or_add_subnode(blob, off, 
> ofnode_get_name(subnode));
>  			res = fdt_setprop_string(blob, suboff, "label",
>  						 ofnode_read_string(subnode, "label"));
