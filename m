Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554A6C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 11:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF20688378;
	Thu, 20 Jun 2024 13:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884732;
	bh=tFE3Dlvek9bM8MBrr+kk+8On0he68uNXmAi39Lu5rJk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dX36qYWX1PSFpQvGUwgYlw1hDN/KgPKcTnESeWM2zUOIZoC0JHmuNSA2IdaHhThKi
	 lDwoD/hHxNTKIhlkR0b1De7Qx6ipOFfJ+Rf0igimH7zGZ0ebhmva+dy+uAw04/Xy2n
	 mhoWtGSj8d4l8RdG7B1jmqaRxIi5HyXeVqVXhLQltePoMTJlu5hh7gppTTdLUeSLRa
	 CmNpp1glTPbcUgbY0OFZVwyWcqGYqwEFgj/FJvqivJp9o3qAweUawqeyNZ3J6hYjQN
	 viDes00Ux+aBLxp1x6JrsEsLqbObkTE3z+Zblw3rRU/+r8hWxMXCiQ8A6otym6CF05
	 qNxCUnpQebjJQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 054F088378;
 Thu, 20 Jun 2024 13:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718884729;
 bh=tFE3Dlvek9bM8MBrr+kk+8On0he68uNXmAi39Lu5rJk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pkmaquwstn7qYTEFL1asmXbjWHXP2MZLkgqCX8Om+WpkxE5BUfVuO3P3EH90i51+K
 WLrRtkEvc6BK9hvh96ZdYnRez+YYycWLUsE4jDmuA/a2HQrrWJb+CS6NL7JoG3VWqo
 xDUfFrWwTPwrcHkC2bj1WguekUXKenHwGzvGadZCCdoWdXhq0dhUbDaicQLlu2YTNx
 p0wwb58Q1myYBgMPTB5mHobvRAMMmVCmjbeFaLNcHqaMeWSP+X52Dt77Fsfy/8nhf5
 XK5rB+5+n1s+rF+WcRezN2X0qxfoM4czMPksxkOub1BbS22XUvw1A8k1vwMJvcvND/
 HtroIxz+mbzig==
Message-ID: <3287e60f-cf77-49e4-b715-559a0ea1a710@denx.de>
Date: Thu, 20 Jun 2024 13:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] usb: dwc3: meson-gxl: switch to
 generic_phy_set_mode
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <20240620-u-boot-usb-gxl-phy-set-mode-v2-2-b81c027bc02c@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-2-b81c027bc02c@linaro.org>
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
> Use the PHY set_mode call instead of calling directly in the
> PHY shared function.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>
