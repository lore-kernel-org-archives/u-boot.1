Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C22ED1356D
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B6BD89030;
	Sun, 27 Oct 2024 17:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730045365;
	bh=+Rv3BuOa5/JrBQjeGOxBodDX97Fl5II35eSdpisDAc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sMT6tnc2Nlqf4YP4doTI9Ly457ygn6CGLOn5jaExM0YQmq+NAKeBsb77GYfgjdjD9
	 EHkJMea1Bt88Xv1c14wa0dDHEPzNbmeJ9YBQVH4P59JJ8bmsBfP4xLa0WPmCMPWy4q
	 r8EpPrkTPWYCRopQah35Lj/IbfB7BM5qPND2jXJunEHv2KMMY14S79ByNYv0o2tjRf
	 s5qKtrcDg08oLk4kf4iTIjxErVf9f6fzFuxhO2vUzgRxIrrKUfeXVfkeDvWbdBQjng
	 iCtKpdj2z7p1nBqd4VONQvNo8YHLPlnZ1s3mgIow3AnMJX1Q6sv4F5paHWXfB7MJrg
	 b8leW5kWZekkQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 49960881A5;
 Sun, 27 Oct 2024 17:09:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730045364;
 bh=+Rv3BuOa5/JrBQjeGOxBodDX97Fl5II35eSdpisDAc8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qRl5xQoFWeirqEXRKHIRa01Cl++XsPOzZjsSudoETWPr82tZ/c+7bcrrUUjXyYLPm
 VJIYq8aHlXH5tnsWkjtz4HWorkHxSdQotH2lTR7quWBRKleXe1oZlwC6GY7vc/lG0Q
 ooJkDe/BstLzpqFiKt6STZzZkqj5n4QU8+2iJf6qc37g0bMt0d4asvhxyRN7SG+1mV
 7HFwmn4Ynqj2iq6EjPxZZD8Fa9utc2xaWZNz2QGfZftYuUjSUM/vzZXBRmJTDu7u1A
 5dAfyQt3NjPHgcktnF6RgM/QLABQdYgykQWBBlgf95ztTXpN1KB5002GaOu5Vq/aXc
 Gsj4SxwjIwMeA==
Message-ID: <16f8f409-4329-47e3-98dc-f18dc64e15e2@denx.de>
Date: Sun, 27 Oct 2024 15:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] eth: asix88179: Fix ASIX AX88179A PHY hang
To: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241027051250.35627-1-admin@khoahoang.com>
 <20241027051250.35627-2-admin@khoahoang.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241027051250.35627-2-admin@khoahoang.com>
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

On 10/27/24 6:12 AM, Khoa Hoang wrote:
> In the original code, the MII_ADVERTISE register is modified while
> auto-negotiation is still in progress, which causes the PHY to lock up
> with the ASIX AX88179A.
> 
> This patch disables auto-negotiation and resets the PHY before
> modifying the MII_ADVERTISE register, then restarts auto-negotiation
> afterward. This prevents the PHY from locking up.
> 
> Additionally, both AX88179 and AX88179A variants do not appear to
> support the ADVERTISE_LPACK (BIT(14)) in the MII_ADVERTISE register,
> as setting this bit does not seem to have any effect. While I do not
> have access to the AX88179{,A} datasheet, in most Ethernet PHYs, this
> bit is reserved as 0, so we should avoid setting it.
> 
> Signed-off-by: Khoa Hoang <admin@khoahoang.com>
> ---
>   drivers/usb/eth/asix88179.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
> index 4bd3b9d1..a856aa2d 100644
> --- a/drivers/usb/eth/asix88179.c
> +++ b/drivers/usb/eth/asix88179.c
> @@ -344,14 +344,22 @@ static int asix_basic_reset(struct ueth_data *dev,
>   		 AX_MEDIUM_GIGAMODE | AX_MEDIUM_JUMBO_EN;
>   	asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, tmp16);
>   
> +	/* Disable auto-negotiation and reset the PHY */
> +	*tmp16 = BMCR_RESET;

Why not use the same trick as u16 adv below here ?

u16 reset = BMCR_RESET;
asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, &reset);

> +	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, tmp16);
> +
>   	u16 adv = 0;
