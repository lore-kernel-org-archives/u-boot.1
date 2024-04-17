Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AD9C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 15:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C908848B;
	Wed, 17 Apr 2024 17:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713367832;
	bh=rpxv+QAQO0mPRpz0mNazC22/bMBOrXMy0Sc2oTk8ngc=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vXp2yy1F/Fzu/hsMx0SN0OOfRchrJAcoEM1GHbH1j5X8E7R574hPrBVecpdBBbuJO
	 hMlGAl9osjSlx6WqSl8o32+2uBd/fp6aYT89aHpp2PU6UYpJbSr0dG+r5cBdBkGeKp
	 U2IS4L0jXJDo9/f2QBJvzDd81jyMR6avBGOuENdpX4CgBY2izis+hgJn9uNgbXzhax
	 8168QsihujATEu876ppxuhvpPAxpcw9/guAYhLK8eNBz1MhRpY3EJNRlcNq9SNpNUZ
	 L0dnhQEMBiyUO4V42TMYC6NRIGP67fvsJqmXlSGtIb/HXTv+ryK3teBQhEgo48+HiO
	 gzTjsI4aztIRw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 250EC88456;
 Wed, 17 Apr 2024 17:30:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713367831;
 bh=rpxv+QAQO0mPRpz0mNazC22/bMBOrXMy0Sc2oTk8ngc=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=qF682UGIaxalTA6TRweTYdSBK1hVx+l6w8o3Dm5IPDd9bqhLo+mmhzDYtrcjDScC3
 GgFu/hjDtmS714KOWDk0v8IXoqVj1Yv0RzM9qpLRDILzV2nLSJPGTV9NuSyml7cAnE
 TglrhhqBGe4kKVLazG7D7fyA1bKFU+AGECvW5cYunOFfGjWuobUi/sFz7O2sx7XXv6
 CEAe1w838ElDt58gudum2hEWp2m+LEyO7BRESrJLXKcUtj56D9zg6MaVtglPuI14Ws
 zbp35PlBq0pFqsqMfBFG5G+qT/eXM0JvT1hQpUc5iKchAvoMZC52NSHeK0rP2i2QZZ
 vVXBmXEk98R+w==
Message-ID: <50284627-84dc-4d09-90f8-8061eb570235@denx.de>
Date: Wed, 17 Apr 2024 13:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch] dwc_eth_qos: Revert regression handling fixed phy
To: Nicole Battenfeld <epsi@gmx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>, Ramon Fried <rfried.dev@gmail.com>
References: <31a9f868-8f5f-2938-a22d-39a2695adba2@gmx.de>
 <31252563-cfe1-343b-cf29-31c374e5287e@denx.de>
 <b94139ba-2135-5f48-aa26-c2b301d13e46@gmx.de>
 <5cf38ecf-f02c-4219-90e8-aceccf558b43@gmx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <5cf38ecf-f02c-4219-90e8-aceccf558b43@gmx.de>
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

On 4/17/24 10:41 AM, Nicole Battenfeld wrote:
> Subject: [PATCH] dwc_eth_qos: Revert regression handling fixed phy
> 
> In imx8mp operation on eqos with fixed phy I get without that patch:
> ERROR: no/invalid <fixed-link< property!

Which commit is being reverted here ?
