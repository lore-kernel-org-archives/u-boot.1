Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F384ECDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 13:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2172586FEA;
	Thu, 19 Oct 2023 15:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697722686;
	bh=Qij7KKH4HHfGQ2RiMW1ONYZ1jFan0EY2iBAw9A+0WWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2WKZMA/ceJPGpVlCF9iLVZwrmzrAXPwRDusEuay7MnsHiFtmeGe5mzROGD1wjXjW
	 j5fKxuZ2d+HLHJXLJuML3MZCxK9e7BYy9KoTJTq4SBEsrf9kl6Rt9rh6qSlrNZEkkp
	 x/EpsoVOrdvDthU/h4L0Kx3o2hUNbnFPXPpXidZWZltmD5x38H1680clkVUl/3nQV8
	 v9Gn/eL6VTAHDNMqQSdA2P1ApGFHl1hN6OSHYW1mQCJwxwWSQZy+HL/GsNU/Y8Ac/t
	 CQsWPy6rjpD9LVkjNKJGZoAfSmY1Lxzc+lWJA9VdB5+UE1VturHr7z74gkQP6WIuC+
	 rsi2eQOfs/xkA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9CDCF86F93;
 Thu, 19 Oct 2023 15:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697722684;
 bh=Qij7KKH4HHfGQ2RiMW1ONYZ1jFan0EY2iBAw9A+0WWg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lT+F8UX4XZpz1abp/1H8OohziOQETWJBc1DiYXaWsPLjW3W+AlhhFTPcNQCgo62lL
 xuBErZp+Yndo3oCruunfCjaZjxZKlbatdfrBUwrSiCw1r6DP7MJ5P725punAxQ/g/D
 T09cYXXEggKUA2yqTrcCJJxn1KMsu0/Q3i3NFfSJENJ/0n59yWXgdssi7W4ilLOyyk
 b/m8UoS/WtvIo6E9kNB41BoZQLMAhSYEOw4I0G13fSOz5SAtHrPZ2GEhDyM7AvKgis
 shjKVpNkEZ93UtrYtfJovdLuHJt50KEs8mcEzpl1TSvCSj8kU1+jpEiqFKVgJPrqvS
 VjJX0odUK55eg==
Message-ID: <4f1d45c8-3688-4379-90a9-d4c7c93ce839@denx.de>
Date: Thu, 19 Oct 2023 15:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: phy-imx8mq-usb: Remove .exit operation
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: u-boot@lists.denx.de, aford173@gmail.com, tharvey@gateworks.com,
 peng.fan@nxp.com, Fabio Estevam <festevam@denx.de>
References: <20231019123609.1489768-1-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231019123609.1489768-1-festevam@gmail.com>
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

On 10/19/23 14:36, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, when running "ums 0 mmc 2" and breaking it via
> CTRL + C, the following message is seen:
> 
> u-boot=> ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1dacc00
> CTRL+C - Operation aborted
> clk usb_phy_root_clk already disabled
> 
> The USB PHY clock is disabled twice: first it gets disabled
> inside imx8mq_usb_phy_power_off(), then it is disabled again
> inside imx8mq_usb_phy_exit().
> 
> Let the USB PHY clock be disabled only once inside
> imx8mq_usb_phy_power_off() by removing the .exit operation.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Indeed, makes sense.

Reviewed-by: Marek Vasut <marex@denx.de>
