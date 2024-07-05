Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668C2C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 21:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F7A88637;
	Fri,  5 Jul 2024 23:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720216239;
	bh=nE5f8wh4Ojfkoqy5DHW09MohNHyPZGYx1H/fLNyiQc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wX7slu3oDoCRJJwgHfg664pUo24aIosTIDT+qeSEfUKpZewm5HFzWWQZdjUx5mGvA
	 lPI+cjyUdxNyjDqSrfuCRBbAoU4doItIG6K9MPP0zHAqBVO22TUqLxEzTm1bTdTAKZ
	 sVkMI4LC6W32EtSq2vvzghKGCnVvq5Ul0/hPDATPf0U5b8ZNuqQZeoAdKqLVBlUoxV
	 FKFpu87D0CaOCqB5Ev3SqLgQQdw/TPdzWin4p8/A+gU3YhLwI5hAsqFN3Y8h0qksz2
	 ei/DpPEWidNF/fPUv1z24sOCEUjYcjCXUfhig6ksIM3GbTpX+cxP+LTa9v4fYpJ9TE
	 EanOQQgQdQuNQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2BEB28813F;
 Fri,  5 Jul 2024 23:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720216238;
 bh=nE5f8wh4Ojfkoqy5DHW09MohNHyPZGYx1H/fLNyiQc0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DniqIvNrSqmyeKbW7dLbd7f7LwQX/j1+D0nzmgJ18u/n6+MkX+bsZJS4xtAUpqYBN
 V9v/dGX/eMpEcsbQuRr2wsH4pWvln1b2olPQx5pdpP1Ed8jsfRa+ijclcmbW04OTul
 7LHL3gBr0Fd846C1aFkjn7vp+N1aBf463kNUVFPJdpK2+DATkZI71Sdhw7JVL/Xlbz
 RN2fWISbCuie9Fk/B0tV51cEm8/m30VVxJu5BLBJi6/XL/OSTFQlhwP89t2fFFh5C9
 PeVXeMxz50wExXtOXxl4rCu1Xb4qRwneBAnP4kojpKvi3RbZkOIP7WjmzFSTfv5FaS
 PBYykOkmbbTqA==
Message-ID: <1d920ebf-157b-48ac-8dc5-9f27519af0ef@denx.de>
Date: Fri, 5 Jul 2024 23:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: imx8mp: rename DHCOM SoM overlays to .dtso
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
 <20240705202954.1149590-2-rasmus.villemoes@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240705202954.1149590-2-rasmus.villemoes@prevas.dk>
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

On 7/5/24 10:29 PM, Rasmus Villemoes wrote:
> Distinguish more clearly between source files meant for producing .dtb
> from those meant for producing .dtbo. No functional change, as we
> currently have rules for producing a foo.dtbo from either foo.dts or
> foo.dtso.
> 
> Note that in the linux tree, all device tree overlay sources have been
> renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
> 81d362732bac). So this is also a step towards staying closer to linux
> with respect to both Kbuild and device tree sources.
> 
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   ...rlay-eth2xfast.dts => imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} | 0
>   ...3-overlay-rev100.dts => imx8mp-dhcom-pdk3-overlay-rev100.dtso} | 0
>   ...rlay-eth1xfast.dts => imx8mp-dhcom-som-overlay-eth1xfast.dtso} | 0
>   ...om-overlay-rev100.dts => imx8mp-dhcom-som-overlay-rev100.dtso} | 0
>   4 files changed, 0 insertions(+), 0 deletions(-)
>   rename arch/arm/dts/{imx8mp-dhcom-pdk-overlay-eth2xfast.dts => imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} (100%)
>   rename arch/arm/dts/{imx8mp-dhcom-pdk3-overlay-rev100.dts => imx8mp-dhcom-pdk3-overlay-rev100.dtso} (100%)
>   rename arch/arm/dts/{imx8mp-dhcom-som-overlay-eth1xfast.dts => imx8mp-dhcom-som-overlay-eth1xfast.dtso} (100%)
>   rename arch/arm/dts/{imx8mp-dhcom-som-overlay-rev100.dts => imx8mp-dhcom-som-overlay-rev100.dtso} (100%)
> 
> diff --git a/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts b/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dtso
> similarity index 100%
> rename from arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts
> rename to arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dtso
> diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtso
> similarity index 100%
> rename from arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
> rename to arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtso
> diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dtso
> similarity index 100%
> rename from arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts
> rename to arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dtso
> diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dtso
> similarity index 100%
> rename from arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
> rename to arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dtso

Has this been even compile-tested ?

I think you need to fix up this:

arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts:#include 
"imx8mp-dhcom-som-overlay-eth1xfast.dts"

