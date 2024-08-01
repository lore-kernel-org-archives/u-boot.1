Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F260DC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 09:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 413D9885AE;
	Thu,  1 Aug 2024 11:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62E7C885BF; Thu,  1 Aug 2024 11:27:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 494D287FA7
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 11:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32C1FDA7;
 Thu,  1 Aug 2024 02:28:08 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 711E73F5A1;
 Thu,  1 Aug 2024 02:27:41 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:27:38 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, trini@konsulko.com,
 jh80.chung@samsung.com, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] tools: imagetool: Remove unnecessary check from
 toc0_verify_cert_item()
Message-ID: <20240801102738.38ed300b@donnerap.manchester.arm.com>
In-Reply-To: <20240801010100.21009-1-sw0312.kim@samsung.com>
References: <CGME20240801010104epcas1p3aadbfa545c1f7e0c7d91c3175614ab99@epcas1p3.samsung.com>
 <20240801010100.21009-1-sw0312.kim@samsung.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Thu,  1 Aug 2024 10:01:00 +0900
Seung-Woo Kim <sw0312.kim@samsung.com> wrote:

Hi,

> Remove unnecessary null check from toc0_verify_cert_item()
> because the array digest is always not null.

Do you mean it's always not NULL *as currently used*? Because digest is a
function parameter, so within the scope of this function definition can be
NULL.
I agree that *currently* there is only one caller, and this passes the
addresses of a local variable from the stack, though it's never NULL.

But I don't think this check hurts (looks like the compiler removes it
anyway), and it makes the code more robust. So is there any problem with
this check? Why do you want it to be removed?

Cheers,
Andre

> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
>  tools/sunxi_toc0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/sunxi_toc0.c b/tools/sunxi_toc0.c
> index 292649fe90f1..76693647a095 100644
> --- a/tools/sunxi_toc0.c
> +++ b/tools/sunxi_toc0.c
> @@ -444,7 +444,7 @@ static int toc0_verify_cert_item(const uint8_t *buf, uint32_t len, RSA *fw_key,
>  
>  	/* If a digest was provided, compare it to the embedded digest. */
>  	extension = &totalSequence->mainSequence.explicit3.extension;
> -	if (digest && memcmp(&extension->digest, digest, SHA256_DIGEST_LENGTH)) {
> +	if (memcmp(&extension->digest, digest, SHA256_DIGEST_LENGTH)) {
>  		pr_err("Wrong firmware digest in certificate\n");
>  		goto err;
>  	}

