Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1A1C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 17:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CBCE88772;
	Sat, 13 Jul 2024 19:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720893382;
	bh=gWYRAj981z5JbkBi8lkVs+FSGkQE6tvGi1Zfl1xj/qI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x8L+CWaXNv0A3q4tLXO57jUcX+4OtZlwHyBIqwQ/YIcebdsG2cjYIVVKQTWaZ62MC
	 UWkSfdatB57VP56rHptvwLi0dRDblG63pVHCe0JYLZXW+XfOBvnVSW/qPvmJWOsBVS
	 wenMGZuDmqXV9u9KY5rbj0eu0ERCoa7OSDyhz4Cw+GgzCwHRtnHD+zrXtAt3EBmkgI
	 amgZHCQunJEgZRikcBR54AxOLcsRbBLpNd53jTk8nXRC5SIpHQAXUiFwHTRNa8qPZ2
	 KBuZsPjfefSZSZbCFVSjsxT45Y6vMP7hhMh87yAHcdB4uKdHouDK5VUSreZdOVe6kU
	 sJvyfrKnkG0+w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 02E1B884EA;
 Sat, 13 Jul 2024 19:56:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720893381;
 bh=gWYRAj981z5JbkBi8lkVs+FSGkQE6tvGi1Zfl1xj/qI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sZZ6B50XeXCz/75+UjaY+dyy25wCr/vBe9q0W2IYzPzoOqhnO48nFPHbTt/tDfknC
 WTP2T8wxhzw6W6xDvP2yVRKqXBsOqYJM1/QoD0n1nrIiAABJdWY1FR1Zrf4odlQyBQ
 ArNunsSaZGUVUaPlKS6SscfQv3oI7FSV8vcCWWUlZ7s8CP1GljKjHFKE9YcE4ybsO6
 wuLvc7lmCyh+O2DzwIAgEw8RsW4mvwcx4erKGOK8ShFRbdBAVD31aJF5rGrIS4EB3U
 C7fF2ju7Jd/8/V/oAGlJdUvHA8N0IF9ay92P7b3vA09bSH1bPevw+D+Mbm8GDVOPb9
 oV4FNTOgu5Xqg==
Message-ID: <b7bc1129-2730-45af-a4e0-abf29c903aef@denx.de>
Date: Sat, 13 Jul 2024 18:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] arm64: dts: imx8mp: rename DHCOM SoM overlays to
 .dtso
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
 <20240710071612.1717460-2-rasmus.villemoes@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240710071612.1717460-2-rasmus.villemoes@prevas.dk>
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

On 7/10/24 9:16 AM, Rasmus Villemoes wrote:
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

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks!
