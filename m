Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B79CC5478C
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 16:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D2487BF4;
	Wed, 28 Feb 2024 17:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NqqOllCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F27687BC9; Wed, 28 Feb 2024 17:15:02 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B0787D6C
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 17:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi
 [89.27.53.110])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E3429CE;
 Wed, 28 Feb 2024 17:14:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1709136884;
 bh=+9q7BN4p8uCCYYkRcN3D4l4kBe6gYTl5YMK9KkLym3s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NqqOllCvE4WEXBtV5uq+GqOZgFW6fz7JT65pBPZY6jwdFv1SIDEsam7ZtHpGA0sR5
 M4yQnubR2iHNRUaRPiO0zR0p6Uy357O2z3M/GiJ4fEa1orSmqR6cmEHzILIhUlCk7W
 ilzscHSzHOQ7OZkkDwEeX/Q98gLZYj5CxzL28At8=
Date: Wed, 28 Feb 2024 18:14:58 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm64: zynqmp: Remove snps,enable_guctl1_ipd_quirk
 property
Message-ID: <20240228161458.GF9863@pendragon.ideasonboard.com>
References: <2067eefbad161dee64b1dc7d97c498f09a8307a2.1708962844.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2067eefbad161dee64b1dc7d97c498f09a8307a2.1708962844.git.michal.simek@amd.com>
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

Hi Michal,

Thank you for the patch.

On Mon, Feb 26, 2024 at 04:54:13PM +0100, Michal Simek wrote:
> Remove undocumented DT property. Suggested solution was to apply quirk
> via glue logic driver that's why make no sense to have it listed in DT.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> For more information please take a look at:
> https://lore.kernel.org/r/1708023665-1441674-1-git-send-email-radhey.shyam.pandey@amd.com
> https://lore.kernel.org/r/1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com
> ---
>  arch/arm/dts/zynqmp.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index b50b83b7723f..daae23c12b79 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -1008,7 +1008,6 @@
>  				/* iommus = <&smmu 0x860>; */
>  				snps,quirk-frame-length-adjustment = <0x20>;
>  				clock-names = "ref";
> -				snps,enable_guctl1_ipd_quirk;
>  				snps,resume-hs-terminations;
>  				/* dma-coherent; */
>  			};
> @@ -1040,7 +1039,6 @@
>  				/* iommus = <&smmu 0x861>; */
>  				snps,quirk-frame-length-adjustment = <0x20>;
>  				clock-names = "ref";
> -				snps,enable_guctl1_ipd_quirk;
>  				snps,resume-hs-terminations;
>  				/* dma-coherent; */
>  			};

-- 
Regards,

Laurent Pinchart
