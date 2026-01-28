Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBEED3F079
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 355CA83F4C;
	Wed, 28 Jan 2026 15:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Bh/R3pcl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bbFxV7ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44F4E83FC0; Wed, 28 Jan 2026 15:57:00 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E87183F2E
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f1QN91b7gz9srj;
 Wed, 28 Jan 2026 15:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769612217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rr7SqqyWTe3ibocNaixqsgkYGOM6QuD+Vi2HxpPDmOc=;
 b=Bh/R3pclWK+lMNoP857+XILOpFNABXaTOsptfpRYhl45CJNIcGoG9ftWzwrX2OMHacnCu2
 m3vPfOlZhfMF+1q4e7MHGIE3IRF0Q0P3n7d9pFjUO7fFrkWHppWBF5WFaqOSl18HAo6rrq
 3KkVae63+5HwOVWbmm4Zl/JWDkIkd6xXDOti/G2bfzli+zZWGKszCMT8aDrO14Hi2bPzXk
 cARMdHPF8ZZuCoHKcYWZFN6m1lIm55hsI5bts4yTiHgZAgpXe7ymxZkXSjQ15iseaY3YJA
 f7V3Y/AfBuKUvrf846J3p7F678/6v4lVlfz+4bz0xLDfbQMOditNuvOsaeKZGg==
Message-ID: <71adda09-1f3b-48f7-aaed-845e6a30b6ca@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769612215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rr7SqqyWTe3ibocNaixqsgkYGOM6QuD+Vi2HxpPDmOc=;
 b=bbFxV7axvfh8Q+SQ7RrgAeofcqGRq+kwoTK3ouzNWxTvUtxzZgxKywSW8OeBxLt13XjabG
 uq2fbince/Je8K3PHsAPsrcewuG0EFSPF3D3X9GAM7GMRtN0QqKPgs/LL+B3pQcDs/YFdk
 jBOMRxKUEA4fiqF4eB+t9Y14QHe2KF+tx1GQKQuCBzsWMqilK9uAlWSSwDFcUWFhUU2VgC
 Iam+E6Oh9vqOVrbUygULLX6O/STbz4a778K9BO3JN7nIbQIc3rcdXr0IxfSq/HPNE5RDFP
 zkGYfZs2fdc/hCD0icpkQk2UgVqNwIL9q26ymeAsOF23EPPa8a92ip7O0lqYAA==
Date: Wed, 28 Jan 2026 15:56:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4] tools: fit_image: Fallback to 8-byte alignment for
 flat_dt images
To: Beleswar Padhi <b-padhi@ti.com>, trini@konsulko.com
Cc: sean.anderson@seco.com, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20260128141834.2322865-1-b-padhi@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260128141834.2322865-1-b-padhi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b0734a957999f9c13b3
X-MBO-RS-META: m3t837ipif688xm6uie5aykzxc3ae44b
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

On 1/28/26 3:18 PM, Beleswar Padhi wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Please drop this , it isnt needed.

> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
> packed inside the multidtb.fit FIT image. While the individual DTBs
> and the FIT image start address are 8-byte aligned, the DTBs embedded
> within the FIT image are not guaranteed to maintain 8-byte alignment.
> 
> This misalignment causes -FDT_ERR_ALIGNMENT failure in
> setup_multi_dtb_fit() when locating the next available DTB within the
> FIT blob and setting gd->fdt_blob, because of the recent libfdt
> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
> version v1.7.2-35-g52f07dcca47c")
> 
> To fix this, check the image type when extracting

"extracting" ? This code changes mkimage, so not "extracting" but 
"packing" (into fitImage), right ?

> FIT image data and
> set the alignment size to 8 bytes (if not already) only for flat_dt
> images. This ensures correct alignment for device tree blobs as per the
> DT spec, while also allowing different alignment sizes for other image
> types within the FIT.

[...]

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index e865f65a400..f842c845771 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -682,9 +682,17 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
>   	for (node = fdt_first_subnode(fdt, images);
>   	     node >= 0;
>   	     node = fdt_next_subnode(fdt, node)) {
> -		const char *data;
> +		const char *data, *type;
>   		int len;
>   
> +		/* Fallback to 8-byte alignment for DTBs if unaligned */
> +		type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
> +		if (type &&
> +		    len == sizeof("flat_dt") &&
> +		    !memcmp(type, "flat_dt", len) &&
> +		    align_size & 0x7)

What will be the resulting alignment if align_size = 0x1f ? 8 right ? I 
think it should be 0x20 .

> +			align_size = 8;
