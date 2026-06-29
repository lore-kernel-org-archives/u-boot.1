Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F7CC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 794EA84A5D;
	Mon, 29 Jun 2026 20:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="GC5dDJw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB55849FB; Mon, 29 Jun 2026 20:29:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7C4AC849FB
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D4C355A;
 Mon, 29 Jun 2026 11:29:00 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.80.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB3D13F905;
 Mon, 29 Jun 2026 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782757744; bh=ma9BwwL14ZTw07pxyeYDmWRCMvFf9Pszh0WhlIdb0Os=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GC5dDJw0djZKJiAU+UbUCS5K6Yc1EzHgz8CqtsghXrCNQG2RerSpTio63p3Wc0bhx
 e9sdeGcgg0xXl9p/xLjQ2zB7O2gQA3Mlv3p2WThyRrbfkvwnrxYRRVQo1SnE3hYaCm
 eK4jBlzevXs6TPP37J76EpM955Tv6jy0bE/ORqGw=
Date: Mon, 29 Jun 2026 19:28:53 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 05/10] charset: mark u16_strsize() as __efi_runtime
Message-ID: <akK5ZZ4zzXvJF0n7@e130802.arm.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-6-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627144421.2067410-6-harsimransingh.tungal@arm.com>
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

Hi Harsimran,

On Sat, Jun 27, 2026 at 03:44:16PM +0100, Harsimran Singh Tungal wrote:
> Mark u16_strsize() as __efi_runtime so it can be called from the EFI
> runtime variable paths added for FF-A/MM communication after
> ExitBootServices().
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
>  lib/charset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/charset.c b/lib/charset.c
> index 182c92a50c4..738ad1352de 100644
> --- a/lib/charset.c
> +++ b/lib/charset.c
> @@ -407,7 +407,7 @@ size_t __efi_runtime u16_strnlen(const u16 *in, size_t count)
>  	return i;
>  }
>  
> -size_t u16_strsize(const void *in)
> +size_t __efi_runtime u16_strsize(const void *in)
>  {
>  	return (u16_strlen(in) + 1) * sizeof(u16);
>  }
> -- 
> 2.34.1
> 

Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Kind regards
