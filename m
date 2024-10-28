Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8E0D1356B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 03:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A922788FD9;
	Mon, 28 Oct 2024 04:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730085574;
	bh=ogmY0un4dXMJFcgoH1UObYsgltkXZ1nWusvjdqr0jNE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FyNh+GbsUAG1a3+UFgiWdaSSNwJmdUHxSUiHQixYw528Xio7U/CuNN+KvfB+Gu9qi
	 ZV7QYdqQUXzGCAGXVleB+WPEbguTQaQpl0PK6qNHKeKNvjiGtlpqB7tzKGzOCVZ39A
	 WBJBwKqrxuHYj+zFj5KNHbQ7r+HD8dzgnNzx+bV4CvFUfHdb3Gx/xKv7lmsSZAZp5i
	 UognKdq6rc1/6t0+Gau/MA+INB/iqfIBbwr0ReOcCRaXCuFYghvQ8Zwa06xVwYRfha
	 0Yg8aXN8N0YQojmE5jJ3fjn75JFToNVtpdUCLsWmODL8ShZL13pZN0bjMvDvs5021+
	 jja7uDmGC5KoQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 941BD88FD9;
 Mon, 28 Oct 2024 04:19:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730085568;
 bh=ogmY0un4dXMJFcgoH1UObYsgltkXZ1nWusvjdqr0jNE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RQa2PU/K+EMBw0CA7durJyYg/5msOLWkcgEvks/NZPiz018+MrRKecOoEZeGwYdng
 NpDPsciHx+IJNRw6dA5KnO7Q/NNW2Yg/zU5+IedKDxsbfWPNbfPqEWH0bZYPGOFXGb
 6WcmHsXxVZvmOk4dagF3u1Pi0T+eYGbjlyyYs2YBc0wd9j4rTn+l86DjaCBUFw5OC/
 VSnXDZTwcNSw4hYibqZjduZmqwCQWO6tGmS6QG/E0lRRQ4Xuwk22blTaExj6KM7p1u
 I4yPpUrgqer/mbLFe0EnOk1VGPk9MZA/thNEPtws5syxISU1RW69m0wfSScSFGWW0k
 /ykQ2VCo6bNNA==
Message-ID: <71653cb9-dfd8-48c8-a972-fb75e454cbcf@denx.de>
Date: Mon, 28 Oct 2024 03:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] eth: asix88179: Fix ASIX AX88179A PHY hang
To: Khoa Hoang <admin@khoahoang.com>
Cc: u-boot <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20241027051250.35627-1-admin@khoahoang.com>
 <20241027051250.35627-2-admin@khoahoang.com>
 <16f8f409-4329-47e3-98dc-f18dc64e15e2@denx.de>
 <192d05af314.106edbab3154233.8510680526990626189@khoahoang.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <192d05af314.106edbab3154233.8510680526990626189@khoahoang.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/28/24 12:41 AM, Khoa Hoang wrote:
> ---- On Sun, 27 Oct 2024 07:44:59 -0700 Marek Vasut  wrote ---
> 
>   > On 10/27/24 6:12 AM, Khoa Hoang wrote:
>   > > In the original code, the MII_ADVERTISE register is modified while
>   > > auto-negotiation is still in progress, which causes the PHY to lock up
>   > > with the ASIX AX88179A.
>   > >
>   > > This patch disables auto-negotiation and resets the PHY before
>   > > modifying the MII_ADVERTISE register, then restarts auto-negotiation
>   > > afterward. This prevents the PHY from locking up.
>   > >
>   > > Additionally, both AX88179 and AX88179A variants do not appear to
>   > > support the ADVERTISE_LPACK (BIT(14)) in the MII_ADVERTISE register,
>   > > as setting this bit does not seem to have any effect. While I do not
>   > > have access to the AX88179{,A} datasheet, in most Ethernet PHYs, this
>   > > bit is reserved as 0, so we should avoid setting it.
>   > >
>   > > Signed-off-by: Khoa Hoang admin@khoahoang.com>
>   > > ---
>   > >   drivers/usb/eth/asix88179.c | 10 +++++++++-
>   > >   1 file changed, 9 insertions(+), 1 deletion(-)
>   > >
>   > > diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
>   > > index 4bd3b9d1..a856aa2d 100644
>   > > --- a/drivers/usb/eth/asix88179.c
>   > > +++ b/drivers/usb/eth/asix88179.c
>   > > @@ -344,14 +344,22 @@ static int asix_basic_reset(struct ueth_data *dev,
>   > >            AX_MEDIUM_GIGAMODE | AX_MEDIUM_JUMBO_EN;
>   > >       asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE, 2, 2, tmp16);
>   > >
>   > > +    /* Disable auto-negotiation and reset the PHY */
>   > > +    *tmp16 = BMCR_RESET;
>   >
>   > Why not use the same trick as u16 adv below here ?
>   >
>   > u16 reset = BMCR_RESET;
>   > asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, &reset);
>   >
>   > > +    asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, tmp16);
>   > > +
>   > >       u16 adv = 0;
>   >
> Sure, I can apply this change. I don’t have a strong preference for one approach over the other.
> 
> I noticed a mistake in these lines:
> 
> +	/* Restart auto-negotiation */
> +	*tmp16 = BMCR_ANENABLE | BMCR_ANRESTART | BMCR_RESET;
> +	asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, tmp16);
> 
> The issue is that I set BMCR_RESET, which would reset the PHY’s settings. This should be changed to:
> 
> u16 bmcr = 0;
> asix_read_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, &bmcr);
> bmcr |= BMCR_ANENABLE | BMCR_ANRESTART;
> asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, tmp16);
> 
> This avoids resetting the PHY settings while enabling and restarting auto-negotiation correctly.
> Will test this change and update in next version.
Nice !
