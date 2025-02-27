Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FA0C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 09:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87D880FE1;
	Thu, 27 Feb 2025 10:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740648364;
	bh=40qG/jIRwrpTpgPa6VIT0KRugrvESs4N6uMcYfTMUFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y0qdghs/Bs7B66Nl4EYPNvwMiqAD5co5pLv3b8HjqI3G5noNkAEXRA2LMpSyzGRDe
	 I89XTyJrcwk+2hMrqZN3YFHJFHBAyfEz2MBbYl+yB0UiC6amNZDp9a2O5e7DcnCFFe
	 g4ufxK49g04vOkwiigy6PwAy38CmwGD51CDHrzBaphulJ3PRPUuKX0sD+EesJ09f3f
	 CT0gaZC5r1sDDpbxIoD4pwjxRtzh9XR3HgIJX1ZHQsdZ2oXXp4fIBss3dmcy79frrn
	 uzlL57MBmMw0zLa5Kg966vT4GDyjsVurJd9ugbgfsyilpxgQCev+Y61m03m4AgfP6l
	 9Nr8/w/29ckXw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75FA810E6; Thu, 27 Feb 2025 10:26:01 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BA4801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Z3Qts1RWCz9tyN;
 Thu, 27 Feb 2025 10:25:57 +0100 (CET)
Message-ID: <ca57d371-5e2d-4124-aad9-4b9bfd84c928@denx.de>
Date: Thu, 27 Feb 2025 10:25:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mvebu: Fix typos in Kconfig help text
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>
References: <20250226230709.730250-1-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250226230709.730250-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Z3Qts1RWCz9tyN
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

On 27.02.25 00:07, Chris Packham wrote:
> Fix a couple of typos in mach-mvebu/Kconfig.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   arch/arm/mach-mvebu/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index adb816982f87..22180b011559 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -260,7 +260,7 @@ config DDR_LOG_LEVEL
>   	  failure, RL, WL errors and other algorithm failure.  At level 1,
>   	  provides the D-Unit setup (SPD/Static configuration).  At level 2,
>   	  provides the windows margin as a results of DQS centeralization.
> -	  At level 3, rovides the windows margin of each DQ as a results of
> +	  At level 3, provides the windows margin of each DQ as a results of
>   	  DQS centeralization.
>   
>   config DDR_IMMUTABLE_DEBUG_SETTINGS
> @@ -450,7 +450,7 @@ config MVEBU_EFUSE_VHV_GPIO
>   	string "VHV_Enable GPIO name for eFuse programming"
>   	depends on MVEBU_EFUSE && !ARMADA_3700
>   	help
> -	  The eFuse programing (burning) phase requires supplying 1.8V to the
> +	  The eFuse programming (burning) phase requires supplying 1.8V to the
>   	  device on the VHV power pin, while for normal operation the VHV power
>   	  rail must be left unconnected. See Marvell AN-389: ARMADA VHV Power
>   	  document (Doc. No. MV-S302545-00 Rev. C, August 2, 2016) for details.

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

