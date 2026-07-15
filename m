Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92462C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 07:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BED84AD3;
	Wed, 15 Jul 2026 09:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hviELbCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18ACC84ADD; Wed, 15 Jul 2026 09:48:34 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1058384A67
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 09:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A43A51A0FF1;
 Wed, 15 Jul 2026 07:48:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 77B986035C;
 Wed, 15 Jul 2026 07:48:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BC19911BD3C41; 
 Wed, 15 Jul 2026 09:48:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784101710; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=92aOtT/ebONRPnYHwwpaFDoELkym5+ZAS1/TVhsU+EE=;
 b=hviELbCSQM5mX/84vl6MlQ8hRJaJA01u8+I4LZKWr/FCj95KJmgQK+/0FZNnSEAqXENqD9
 05sId251g175FI8OI2OodVkB/9dnqmO/L1lmeso3JC93naNkwIChy1LTSTdiyYKMttEfGn
 5RYncXma1VDB7X5YDqdPSfonaxXFvt/Y+cwQOIsTShlg4uqNsGjFbec0y4FWm1PJ7gImiY
 xMaPxO5FxbTGBJo3Hz/FlFRha95ZCPgVfSI4UUTXhSbldL5gC08BBlEcR42F+3msiuRuWu
 neObnVksFW9dyN7I0/dRWD2JSFPnsPu/5+BiUSZ2lKfDuX31sSVeQnPKI/dzLQ==
Message-ID: <2b758807-51ae-499d-8e0f-b251260eafcf@bootlin.com>
Date: Wed, 15 Jul 2026 09:48:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: sunxi: fix ECC count register indexing
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Hans de Goede <hdegoede@redhat.com>, Boris Brezillon <bbrezillon@kernel.org>
References: <20260714233259.508396-1-james.hilliard1@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260714233259.508396-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 15/07/2026 à 01:32, James Hilliard a écrit :
> Each ECC error-count register contains four 8-bit correction counts.
> The register-offset helper already selects the register using the ECC
> block index divided by four, but field extraction shifts by the full
> block index. This produces shifts of 32 bits or more for each register
> after the first.
> 
> Use the block index modulo four when extracting the correction count.
> 
> Fixes: 4ccae81cdadc ("mtd: nand: Add the sunxi NAND controller driver")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Genoud <richard.genoud@bootlin.com>

NB: While the fix is valid, it doesn't change anything at the end since 
the step is always 0 here. But it's better to have the right formula anyway.

> ---
>   drivers/mtd/nand/raw/sunxi_nand.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
> index 1b2c514852d..96b65c52685 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.h
> +++ b/drivers/mtd/nand/raw/sunxi_nand.h
> @@ -167,7 +167,7 @@
>   #define NFC_ECC_PAT_FOUND(x)	BIT(x)
>   #define NFC_ECC_PAT_FOUND_MSK(nfc) ((nfc)->caps->pat_found_mask)
>   
> -#define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
> +#define NFC_ECC_ERR_CNT(b, x)	(((x) >> (((b) % 4) * 8)) & 0xff)
>   
>   #define NFC_USER_DATA_LEN_MSK(step) \
>   	(0xf << (((step) % NFC_REG_USER_DATA_LEN_CAPACITY) * 4))

regards,
Richard
