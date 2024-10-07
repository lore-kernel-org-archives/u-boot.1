Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E47BCFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F0AE88D82;
	Mon,  7 Oct 2024 14:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728303352;
	bh=s6pCy6tZYIW8THqLIfTGxI9ELjb8L1H7pPC0fBPOzP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=azKG4QKXb+e1k4S/oRHOGojfEFpG3oly5j/Z1o+fJXeRj9WXEEW03D103SbMWALIO
	 BbL1+7hUtUBb9fWW2Y6cX2NAYwUJ9HtpgtRHq56IAyzUL2KQVAPXryc/pAlm7SJkGb
	 Cw9/WYB2sqgoqoxE03ufi1KDcAHZwAPwBMKHfHXhN9LV4D/xVbAXcy7npePx6XOivS
	 4UhFCbZ7m30zpwldPdRMncZSyfP1b4myCiivX5G5/KomWDqC60lo5IGViqOk57swvS
	 SdtXvdGEdHUXXiINyBJvSZaXDGSqoVzE71XEZwrUygpZRj4ilz14s5mXykFFzh0uMC
	 GAlR4c1DhgVyA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5528488D4F;
 Mon,  7 Oct 2024 14:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728303350;
 bh=s6pCy6tZYIW8THqLIfTGxI9ELjb8L1H7pPC0fBPOzP8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=p+gKJtvVK4DznkT/2HvarfRbP6DQ+KH2zAH3SjMXQQos0ItQkX9Wn+FGDXMWZ1M/s
 PLm5uhaxDEz2oqeHwkVsCR5C/ISSU9bsxceh+qZ61/bbvsY/rRBVp1JL6HlPXCUDo+
 tBXYdiHCWUYvpnS4ZWW87aedZToSC9XTrREl36VQKI/5M4/Azvl6q2Cu+UxWf6ByzP
 07N/YgljGwa5aXfCvpcO/UON8nh73Dxg3LRKB2HluTuPnWE3V9l6WVprfNN22u1b3n
 2FaHZcJFWIulbggP1AZnt/v6FxIKFQSu9qfOVpBbwIz9psWWXJp2ZNcLGGHpI16+pZ
 4Ilc/LvLk94aw==
Message-ID: <6c8ab321-af54-4ea1-b72c-fb18cfa1f650@denx.de>
Date: Mon, 7 Oct 2024 14:10:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
 <20241007044547.23896-6-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241007044547.23896-6-venkatesh.abbarapu@amd.com>
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

On 10/7/24 6:45 AM, Venkatesh Yadav Abbarapu wrote:
> The .bind function is implemented to bind the correct
> "half" of the hub that the driver wants to bind,
> and returning -ENODEV for the other "half".
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
