Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC360C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5492181EDD;
	Mon, 31 Mar 2025 14:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="OcetryTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA7EB81703; Mon, 31 Mar 2025 12:48:01 +0200 (CEST)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [91.218.175.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B7898129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
Message-ID: <178c8189-c47a-4d8a-a4e5-7fa4969d7258@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1743418078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97p4MJwujfc73K28ncVRhKndu2Lt4s9XALcScXIiwag=;
 b=OcetryTGPttPbgC9HjiLMw1Fkh8VO92R7cltFY2bhje432opPYlOwtcu9uifx3Iogr4FJJ
 OZ/IQJXYYp78Q4XhDCA/sg7Eyb7Ld1lF8Czr9AOcqP44CUlEFz94FKtdKBPmh43cBnEilt
 NQzNXvNurQboftGNOP5taE5d3L6fhu+HJxhG9NL22hDpFQGgUAesecla7grGZWMrpagcb2
 YBkPHYuAsOmm2th4fyhF9EvMG3uTnH0A3mYsmOZsOoXD1obrf6HszcxwicG82WjsU1HPWl
 dJNfkG/2gorrXpUJRivfet6Xo0Uw/tCmpTPL2zYRbtIzN3vRJNs2zpltM88qjQ==
Date: Mon, 31 Mar 2025 13:47:55 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] mach-snapdragon: of_fixup: fix condition check in
 ft_board_setup()
To: u-boot-qcom@groups.io, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Sam Day <me@samcday.com>, u-boot@lists.denx.de
References: <20250331104327.321339-1-caleb.connolly@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20250331104327.321339-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Mon, 31 Mar 2025 14:34:12 +0200
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

On 3/31/25 13:43, Caleb Connolly via groups.io wrote:
> The fdt_node_check_compatible() function returns 0 on success which is
> pretty confusing, and we were using it wrong!
> 
> Invert the condition check and refactor things to be more readable.
> 
> Additionally, add the check for the RB1 which needs the same fixup as
> the RB2.
> 
> Reported-by: Sam Day <me@samcday.com>
> Fixes: e64503f1fcdf ("mach-snapdragon: implement ft_board_setup() for USB role selection")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 55368dd43b66..588c92c5cc91 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -160,16 +160,16 @@ int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
>   {
>   	struct fdt_header *fdt = blob;
>   	int node;
>   
> -	/* We only want to do this fix-up for the RB1 board, quick return for all others */
> -	if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2"))
> -		return 0;
> -
> -	fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
> -		log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NULL));
> -		fdt_setprop_string(fdt, node, "dr_mode", "otg");
> -		break;
> +	/* On RB1/2 we need to fix-up the dr_mode */
> +	if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2") ||
> +	    !fdt_node_check_compatible(fdt, 0, "qcom,qrb2210-rb1")) {
> +		fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
> +			log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NULL));
> +			fdt_setprop_string(fdt, node, "dr_mode", "otg");
> +			break;
> +		}
>   	}
>   
>   	return 0;
>   }

This fixes USB mode on all my sdm660/636 boards that should only use 
gadget mode.

Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>

---
Regards,
Alexey Minnekhanov
