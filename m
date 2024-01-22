Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAC1C47DD3
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 00:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC82878D0;
	Mon, 22 Jan 2024 01:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705882652;
	bh=tHPYh66gmjAPvBEiX1kG/v+2BG89pSKUxa/pVlwO7kU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kqaClkIGuVxkKZajKB1B0yDJzBkQhgIVNzSfE7ppdiN0QttdXSHBJY9QtWX+HdPqm
	 Wb4MiW2M37G5a1t7Jpzs2oOGqK6IR3vzROeBJtZwK3whPZC1lS6gQ2YpYqgIHsGbBP
	 jnnWrQl1mSLn6D+eUVvYxf1M+x5lWqktPxYtsu+Era+wOS+D5VjDPnhiygzFozXAa2
	 peUJhs+LFnF985gefzi26aglby1itn+gvN/j2mZrBvQLipnkzS/l17qVG8BbeBbAPV
	 AZNmAiBcdABy1E/BbAUi4Fmc0lZ3Tfg012VcomPldUoBcR5S6tqIFLQweOeFM/9F/U
	 Dwk1LQWmKCaHA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2C68687727;
 Mon, 22 Jan 2024 01:17:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705882649;
 bh=tHPYh66gmjAPvBEiX1kG/v+2BG89pSKUxa/pVlwO7kU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uk5cBL9X646R7UDE8uA56AQc7wj6xcL94Apd2noW0sgm9ipJXgQzmMv75kOS1Rw2g
 UoiZAMdLmP6bLNt+lYUlxuM0A4qGlR5JYkpywzeu7UVZHGH5/F0pvvvlY7wX0X4Bti
 a0T2ZjrJVYQy55DnJLQJ8UjCrPvzmhLrNyAjSpBn8dqYGtdgH1Y0FB4bhT0JPoTMVJ
 LFuz+z9JrSAoRImEOgIEdj4gPzqq5JtEN+tHBFYGyO5Ghs9zHYT9qQEmGULweDPXLc
 iWdm+VFXL0czpNP/4AuPzRhond3GinBLHu5rKfTCJTswKUtLCT6PQcFcApqSJktDNF
 NCuhmAJTs+U+Q==
Message-ID: <83eb61a2-ed64-47d9-98a3-b5afcd43f0d8@denx.de>
Date: Mon, 22 Jan 2024 01:16:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-of-simple: Remove Amlogic and Rockchip
 compatible
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240121203818.2075381-1-jonas@kwiboo.se>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240121203818.2075381-1-jonas@kwiboo.se>
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

On 1/21/24 21:38, Jonas Karlman wrote:
> Remove the rockchip,rk3399-dwc3 compatible from the dwc3-of-simple
> driver now that all boards have changed to use the dwc3-generic driver.
> 
> Also remove the amlogic,meson-gxl-dwc3 compatible, it is no longer in
> use by any device tree in mainline linux or U-Boot.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Marek Vasut <marex@denx.de>
