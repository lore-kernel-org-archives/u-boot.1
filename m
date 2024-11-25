Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3DAD3B7D7
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 05:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F4A895E4;
	Mon, 25 Nov 2024 06:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732510825;
	bh=/XzFbKrZeq8r2Cmoo2lguEydCoDvUV6VsqCJPRuSzc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CfEkM4zuUNVXpoKdBEzPMtYMHb3Gnkr7FuRkD/kcN2KucITWjvq7tmNeQmY6k5lw/
	 1BaMqLBWHXSI1Nx7c9vUw3QzGti1f2yfn1bwgGIRelX8uyg5FGhBXwWTFIasgnQ5D1
	 LxTGSbYqJHTGg8BZCgSKAGYLAgw0ll6MpGQAyvypi3nGFqsWKNuIbySh6k+H9vKeyW
	 gmLhSgPh6gMzZ9c9SC8bNjFSV4j/Jazx2Qf/pk5+opp9Ijk1XjzroEohWQCXWPCpLZ
	 dkyYYzGOzXUUJsK5TvZVAWC30qnNUG2bEXqYU8x1MZZfMrdWlUGCyevzObbOOf57xv
	 1lIdFtaNWy9+g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C5ECD8952A;
 Mon, 25 Nov 2024 06:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732510825;
 bh=/XzFbKrZeq8r2Cmoo2lguEydCoDvUV6VsqCJPRuSzc8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aYj2i1Z43mnPvV7Rm1dIpOt+Bhd9CxM+KDHiJa6EW6hntRaGGqx00ncgfUqvkXCQ2
 IQrAvKKktDhhq8KZWKgZM0VxHwMXK45VxIM3WyWO/tJbhjDUTavQL2+hObhb7S8fbx
 wVNXYZ8Qm1NANH8FLCHRd623WPF/fg+ALiq/i/rsQAMa0MnYWwtu2dNePoir3Eq273
 VzZb5dQXaKoPX1eidtDCUPW4ayLprpeXg3ApoArymetf/nYua6OdY5kHhaxzcjhCHG
 T2NxNLopTGa02X38pDVLk2YsovvxJ8hgTs1GSnAztdM7QCzxJ5l9MDipzyhgy+UPoZ
 YAHFa6oPwquhw==
Message-ID: <17769845-60d2-45ff-8ad5-f2a54d6f7f0d@denx.de>
Date: Mon, 25 Nov 2024 05:41:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/5] usb: onboard-hub: add support for Microchip
 USB5744
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
 <20241125041202.980-4-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241125041202.980-4-venkatesh.abbarapu@amd.com>
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

On 11/25/24 5:12 AM, Venkatesh Yadav Abbarapu wrote:
> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
> The usb5744 driver trigger hub reset signal after soft reset.
> The usb5744 hub need to reset after the phy initialization,
> which toggles the gpio.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Marek Vasut <marex@denx.de>

In

Re: [PATCH v13 3/7] usb: onboard-hub: add support for Microchip USB5744
Mon, 18 Nov 2024 14:18:43 +0100

I wrote

"
I retract my RB on this patch until the discussion is concluded too.
"

Please be more careful with RBs.

Applied all, thanks.
