Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FD2E6688C
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 22:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4278D893F4;
	Sat, 23 Nov 2024 23:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732401265;
	bh=kedmpQXUMcl2Y1AfpzMfvi0X2iuTEdjU7Vg1jWSYVWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qwSG+EykuXIBihadVOSDVT4wZRy0mtloBhQhhdRCwcnr+3040Hu7bPTb2BwfAYin+
	 zAP8/vFgpxaMvpesVsVoRqeIyxf3LQXMW1DTpGkjhg2ajbiAn28Mdj1roa9cMBOJSb
	 zxV4jF1t2/rLTGkXgUxlosVeO7ze+KgDZsuXiJJV+udVFS4yY2Eu14dCEBGna8HxVm
	 +AM+erl1Et1IHGPza2P3iiVtlwtNXt2svURiy1kYyPCEHZ8Jd+58nd4yhd79vJ5Oj2
	 8gZxQiknArEDk0majK9vHfknJw8RoJjfqhIzVtqTgVYJ40bVCK8hYqdRBClzs/c8ou
	 mNQRDm9K+HAig==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 19EA7891A0;
 Sat, 23 Nov 2024 23:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732401264;
 bh=kedmpQXUMcl2Y1AfpzMfvi0X2iuTEdjU7Vg1jWSYVWA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O8RRx2CoDL1Z0T7K8B5ctGjih+OjuM1/2KGcIdSpZc0kVBYGRUKDiQ0Px2QHJgjjG
 D2u27GpnIsrvvH6cirXY16MEbPxAjcIwnEUuH2cI+fn/tDUSm4saaZOU+YQDo4DI4b
 upNtnw9f3nREmUuaKO2dkdO8exu2UBNJh3KbUdLgIULDds6zjkRItNpZHJmD4c28VI
 2pMcsffGFi36Blh1dpKO4uOznoxeNIR5lUtcrho/ZTNe6/LSJmsu6i3MUWFjPaXfIh
 F0ifFex+xKUBywK6toJoyLYqZsYCYrnn8XNB4RBricxHx3SH0SflDXdoEbhFncvVMc
 UaTfZTzUncuJA==
Message-ID: <b85432c1-2e49-46f7-b764-ee213131a291@denx.de>
Date: Sat, 23 Nov 2024 20:56:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] eth: asix88179: Fix ASIX AX88179A PHY hang
To: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241108055136.50701-1-admin@khoahoang.com>
 <20241108055136.50701-2-admin@khoahoang.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241108055136.50701-2-admin@khoahoang.com>
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

On 11/8/24 6:51 AM, Khoa Hoang wrote:
> The ASIX AX88179A locks up when the ADVERTISE_NPAGE bit is set in the
> MII_ADVERTISE register, suggesting that this feature may be broken or
> unsupported on this chip. In the Linux kernel, this bit is not set,
> and enabling it also causes the PHY to lock up and stay in a
> link-down state.
> 
> Additionally, the AX88179 and AX88179A variants do not appear to
> support the ADVERTISE_LPACK bit, as setting it consistently reads
> back as 0.
> 
> This patch removes the ADVERTISE_NPAGE and ADVERTISE_LPACK bits from
> the MII_ADVERTISE register configuration. It also resets the PHY
> before modifying the MII_ADVERTISE register, then restarts
> auto-negotiation, following the same flow used in the U-Boot asix.c
> driver.
> 
> Signed-off-by: Khoa Hoang <admin@khoahoang.com>
Reviewed-by: Marek Vasut <marex@denx.de>
