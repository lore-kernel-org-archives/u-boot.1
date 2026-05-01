Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE23ECCFA13
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 12:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A45D80F0E;
	Fri,  1 May 2026 14:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="GPgnSH/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86BD583E36; Fri,  1 May 2026 14:48:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 71C5E80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 14:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4857F176B;
 Fri,  1 May 2026 05:48:18 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CD283F7B4;
 Fri,  1 May 2026 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777639703; bh=hBNDxegGBsWlKGVPQc7F31bePQaFB4+OP1QeAfa86X4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GPgnSH/i+gq8fEMni9ofgK0Ua8OByHsGdRjthPt1cnddkFdni1UxJR5t4INNTEQyT
 TYNPxuUVq9zA/DUHxRpEWPWU6C2PiIDblcIXoLs1kX9wvy/4g+Z++lt0mEPSKGTB/O
 4CSN325ja3F3I4ozEobnr54znU61zlIRsy3Yp9Y0=
Date: Fri, 1 May 2026 14:47:44 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, Andrew
 Goodbody <andrew.goodbody@linaro.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/5] mtd: nand: raw: sunxi_spl: remove user data
 length reset
Message-ID: <20260501144744.1d767d13@ryzen.lan>
In-Reply-To: <20260327140508.3680105-6-richard.genoud@bootlin.com>
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
 <20260327140508.3680105-6-richard.genoud@bootlin.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 27 Mar 2026 15:05:08 +0100
Richard Genoud <richard.genoud@bootlin.com> wrote:

> No need to reset user data length registers in SPL.
> 
> In SPL, only the first user data length register is used, so we don't
> need to reset all of them.
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Acked-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/mtd/nand/raw/sunxi_nand_spl.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> index 784ffb00cf70..cf351de4e8de 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
> @@ -224,22 +224,6 @@ static int nand_change_column(u16 column)
>  	return 0;
>  }
>  
> -/*
> - * On H6/H616 the user_data length has to be set in specific registers
> - * before writing.
> - */
> -static void sunxi_nfc_reset_user_data_len(const struct nfc_config *nfc)
> -{
> -	int loop_step = NFC_REG_USER_DATA_LEN_CAPACITY;
> -
> -	/* not all SoCs have this register */
> -	if (!NFC_REG_USER_DATA_LEN(nfc, 0))
> -		return;
> -
> -	for (int i = 0; i < nfc->caps->max_ecc_steps; i += loop_step)
> -		writel_nfc(0, NFC_REG_USER_DATA_LEN(nfc, i));
> -}
> -
>  static void sunxi_nfc_set_user_data_len(const struct nfc_config *nfc,
>  					int len, int step)
>  {
> @@ -355,7 +339,6 @@ static int nand_read_page(const struct nfc_config *conf, u32 offs,
>  		 */
>  		nand_change_column(oob_off);
>  
> -		sunxi_nfc_reset_user_data_len(conf);
>  		sunxi_nfc_set_user_data_len(conf, user_data_sz, nfc_step);
>  
>  		nand_exec_cmd(NFC_DATA_TRANS | NFC_ECC_OP);

