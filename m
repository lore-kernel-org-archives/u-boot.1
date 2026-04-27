Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4756FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DAE839D9;
	Mon, 27 Apr 2026 11:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="CPD7HKdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401ED8419E; Mon, 27 Apr 2026 11:20:27 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BBB0883693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39CEE1682;
 Mon, 27 Apr 2026 02:20:18 -0700 (PDT)
Received: from [10.41.150.145] (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CA0A3F763;
 Mon, 27 Apr 2026 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777281623; bh=bqJ90Hn4EnZ5F5RM2wOF6HESxkJ/jhu+HiZKP+rU560=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CPD7HKdHBu6Sqfn4/JgSnGyUCwXryX97ArbsyHqz9bHgM5Sf91hH8upieDOxziysj
 Ef9S9vBq9kfXhsdnqkTu98R3jBromZLH5CUdg8l5lpuQ37p8tLifQfTNOLRJP7naOG
 G5XRKar8qCtBOzBK6NpQ8kEnx4n/xC0y3RaDL63Y=
Message-ID: <1248757c-f455-41eb-b1b0-a21b1c9e5fc9@arm.com>
Date: Mon, 27 Apr 2026 11:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sunxi: use vendor prefix for $fdtfile on RISC-V too
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, Samuel Holland <samuel@sholland.org>,
 u-boot@lists.denx.de
References: <20260415212136.320419-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260415212136.320419-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Heinrich,

On 4/15/26 23:21, Heinrich Schuchardt wrote:
> Once we complete the support for RISC-V Allwinner D1 (sun20i), we will need
> to prefix $fdtfile with the vendor prefix to match the Linux device-tree
> directory structure.

Not sure we really need this now, but it doesn't hurt either, so I take it.

> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>Hi 

Acked-by: Andre Przywara <andre.przywara@arm.com>

> ---
> Some work on sun20i in https://github.com/smaeul/u-boot/tree/d1-wip still
> needs to be ported to upstream.

Well, not sure there is much movement in this. The D1 SoC has lost quite 
some interest, it seems, both from the Allwinner and the community side. 
Plus I am not really a fan of the DM_SPL approach taken in this patch 
set, in particular not if there are no active testers and users.
So I am bit skeptical that upstream support will still happen at this point.

Cheers,
Andre

> ---
>   include/configs/sunxi-common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
> index b29a25d5617..49d5617f028 100644
> --- a/include/configs/sunxi-common.h
> +++ b/include/configs/sunxi-common.h
> @@ -280,7 +280,7 @@
>   	CONSOLE_STDIN_SETTINGS \
>   	CONSOLE_STDOUT_SETTINGS
>   
> -#ifdef CONFIG_ARM64
> +#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
>   #define FDTFILE "allwinner/" CONFIG_DEFAULT_DEVICE_TREE ".dtb"
>   #else
>   #define FDTFILE CONFIG_DEFAULT_DEVICE_TREE ".dtb"

