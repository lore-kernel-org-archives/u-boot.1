Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6911C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 534EA82DF2;
	Wed, 16 Apr 2025 15:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744809568;
	bh=iMljIrIXIktxNPL2fLqsn/cwg+lmrvVnmI4/DGNjR3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s3pfqsLDwuTm94SqS8/EAw3iugJtq1h5pOh7abHPW6YuTVGHmfg8s3TmvkRZboBCn
	 AXlXYJe27P9dP7zCd8hha8LC9rgJ1Qw43T6ipPQPea6WolB06fr8EtDcby9SszIMrn
	 OaKLPs+wQyune/y3fSLxroGKKisdcsUZ5IAwWU8l0Fv3649zI1cKQzJ3BieCefTNE3
	 VnQTxSJGRWdqMHZrzHsDEwdufKAWMIWR+Ayl+Ruc0a1bevbw1vJHHIRNEWmEhsQvn1
	 2GyXVai1dWdrbwGMdJL/1fkUP1U8XB/5qK4A90edfYq9gOCPE0rhjfVITmNnunn7CO
	 zgTn8GZEFMI0A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8233282E34; Wed, 16 Apr 2025 15:19:27 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 902C980F03
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Zd1p32DKlz9shx;
 Wed, 16 Apr 2025 15:19:23 +0200 (CEST)
Message-ID: <08e3f8d9-cb7e-44a9-84e5-ed59ba3f3ea4@denx.de>
Date: Wed, 16 Apr 2025 15:19:22 +0200
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

Applied to u-boot-marvell/master

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

