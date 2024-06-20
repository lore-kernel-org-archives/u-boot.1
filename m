Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D88CC2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 11:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3C088532;
	Thu, 20 Jun 2024 13:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884730;
	bh=cNiuJ0m4Y5kWc2Q6wg4C4PvMNedJOjawfurM7Q5uLqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=leyINAZpuWyAT3BSECeNHojDcYm4WFdTfnTflmUi7xq3BwDgByjwpfRBu7mw9LLF8
	 sUlFBABZHbBTafeQ+qSaYjjIbVdX0B4FdtgzUBqZ5kkF9ovUtSmdkxUHtySTGUBN5l
	 o0Wif10wpOtvaG2nNUlYwPat2E1jnrU0BgFvg8VJhBQuKzJNisZxHhzJ5nu6ou08Bz
	 +eKVuMQGVeNXdeobKzkRBq2UaETxFi3GYFBMOE3cmBF9tqx6DeFdv5SENe5mxBaFxq
	 7HZQ28qtTBPhvbwT2ZQD0hpXtKCxCPtJqk5YSiUHkFjQiYlFAFJ8Clg+xtffLECDj6
	 UOgopam9VZeGA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6251D8834D;
 Thu, 20 Jun 2024 13:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718884728;
 bh=cNiuJ0m4Y5kWc2Q6wg4C4PvMNedJOjawfurM7Q5uLqQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Fy91tRw8yaeJ86tuqlVpHu9sLKedrNK5ZMTUHW74gPQEfHbb4xtouqtyi0Vxc5RlG
 Tcd1X1OFg1UNowpJUOidKaGptCnlkcMgg+mM6tvqAUGAsX82PVClKGz6Hc5Dhi3BZ4
 4dOjJz8GndMwNCSTaIZg6GGB2jhLk6FhW/s3Z3OHkJIeZLGnPlGUVHE5N8eB7UJEOf
 fM+myEnXukKVl4gk7R/qV0hpv3Pxnu6aPSMBtZ0rgzXlekRrspbh6udcx6DsdVv8LQ
 ZzEjYpAZTPgyuYNlgrHEgtXbQ7kU6CNaCXNFNKnEpu/5SL8OS4QTUImxornBHOQTbP
 giEufnxgOwA3Q==
Message-ID: <522a0d5f-1fb8-4900-87a4-395ccdc81088@denx.de>
Date: Thu, 20 Jun 2024 13:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] phy: meson-gxl-usb2: add set_mode callback
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <20240620-u-boot-usb-gxl-phy-set-mode-v2-1-b81c027bc02c@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-1-b81c027bc02c@linaro.org>
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

On 6/20/24 9:42 AM, Neil Armstrong wrote:
> Implement set_mode callback by calling the current public
> function, use a temporary function name that will be removed
> when the public phy_meson_gxl_usb2_set_mode is finally removed
> in a following change.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>
