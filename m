Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7E6E8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 04:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB5983C72;
	Mon, 29 Dec 2025 05:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dHZEPjc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB2883CAA; Mon, 29 Dec 2025 05:32:40 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BC683C39
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 05:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 981B96000A;
 Mon, 29 Dec 2025 04:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64523C4CEF7;
 Mon, 29 Dec 2025 04:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766982756;
 bh=Vo6AOnW3tHOD1cA7yCAOXzBWifsp29SavV52YUe/3k0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dHZEPjc91EqmtZciJt8Gvr3Wq19A+9yUlSvRpwJsWx/MSW2wHUdi/o6/6+Xsk3HGC
 ENNBSoe37Oz69iAOQTdFHMv8+styi1lin4O7EifACBdMDRvcttQJZw7K6WLSIp3ObN
 tj7Ql2mU169xV3YhZ//swYiY1D+2pETP3y+GUZiGEAARyo1hMPyHHVCenXDlQ7kt+R
 WvqGanuugCa9q7BRRzTv524I6ybFekdSe8OCTSSWTWvF0TVVFEimyprDU6M4zLhxEW
 /ujdBiNTXTPMaHzOPGppMxRZBUiY5/mdEmkepnN9sUPiLl0TAtC0WANL/C9Bx6TlKh
 tASdP3t6vivDg==
Date: Mon, 29 Dec 2025 10:02:29 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Michael Zhu <michael.zhu@starfivetech.com>,
 Drew Fustini <drew@beagleboard.org>, u-boot@lists.denx.de,
 Icenowy Zheng <uwu@icenowy.me>, Conor Dooley <conor.dooley@microchip.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: riscv: starfive: add
 xunlong,orangepi-rv
Message-ID: <aVIEXcgKNTIhwqcU@sumit-xelite>
References: <20251226193034.181659-1-e@freeshell.de>
 <20251226193034.181659-2-e@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226193034.181659-2-e@freeshell.de>
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

On Fri, Dec 26, 2025 at 11:30:02AM -0800, E Shattow wrote:
> From: Icenowy Zheng <uwu@icenowy.me>
> 
> Add "xunlong,orangepi-rv" as a StarFive JH7110 SoC-based board.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Signed-off-by: E Shattow <e@freeshell.de>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> [ upstream commit: d94ebab404b0ce6498770888e25102e32b2b13da ]
> 
> (cherry picked from commit 19644ea3243c8749d1c08d4397b4522965a9bf8e)
> ---
>  dts/upstream/Bindings/riscv/starfive.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/dts/upstream/Bindings/riscv/starfive.yaml b/dts/upstream/Bindings/riscv/starfive.yaml
> index 04510341a71..3fdeab9d8f0 100644
> --- a/dts/upstream/Bindings/riscv/starfive.yaml
> +++ b/dts/upstream/Bindings/riscv/starfive.yaml
> @@ -33,6 +33,7 @@ properties:
>                - pine64,star64
>                - starfive,visionfive-2-v1.2a
>                - starfive,visionfive-2-v1.3b
> +              - xunlong,orangepi-rv
>            - const: starfive,jh7110
>  
>  additionalProperties: true
> -- 
> 2.50.0
> 
