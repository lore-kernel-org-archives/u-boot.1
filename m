Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C379C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 17:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB3687029;
	Sat,  4 Nov 2023 18:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D8487029; Sat,  4 Nov 2023 18:14:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1C76A86D3C
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 18:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBC9AC15;
 Sat,  4 Nov 2023 10:15:06 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B96953F703;
 Sat,  4 Nov 2023 10:14:22 -0700 (PDT)
Date: Sat, 4 Nov 2023 17:13:16 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Peter Hoyes <peter.hoyes@arm.com>
Subject: Re: [PATCH 1/1] rng: fix ARMv8.5 RNDR driver
Message-ID: <20231104171316.11fde076@slackpad.lan>
In-Reply-To: <20231104070007.30099-1-heinrich.schuchardt@canonical.com>
References: <20231104070007.30099-1-heinrich.schuchardt@canonical.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat,  4 Nov 2023 09:00:07 +0200
Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

Hi Heinrich,

many thanks for finding and fixing this!

> In different parts of our code we assume that the first RNG device is the
> one to be used. Therefore it is preferable to detect the availability of
> the RNDR register already in the bind method.
> 
> For signaling the non-existence of a device the driver model requires using
> ENOENT (and not ENODEV).

Doh, now I feel silly! I thought I checked the call path, and looked at
initcall_run_list(), which prints the error message, and suggests that
only 0 would be acceptable.
But indeed -ENOENT works, with the slight caveat of printing:
================
No match for driver 'arm-rndr'
Some drivers were not found
================

But it's definitely an improvement over the current situation, and I
don't feel like boiling the DM ocean for this stupid little driver.

> Fixes: 31565bb0aa2d ("driver: rng: Add DM_RNG interface for ARMv8.5 RNDR registers")
> Signed-off-by: Heinrich Schuchardt> <heinrich.schuchardt@canonical.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>

Many thanks!
Andre

---
>  drivers/rng/arm_rndr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rng/arm_rndr.c b/drivers/rng/arm_rndr.c
> index 55989743ea..4512330e68 100644
> --- a/drivers/rng/arm_rndr.c
> +++ b/drivers/rng/arm_rndr.c
> @@ -62,10 +62,10 @@ static const struct dm_rng_ops arm_rndr_ops = {
>  	.read = arm_rndr_read,
>  };
>  
> -static int arm_rndr_probe(struct udevice *dev)
> +static int arm_rndr_bind(struct udevice *dev)
>  {
>  	if (!cpu_has_rndr())
> -		return -ENODEV;
> +		return -ENOENT;
>  
>  	return 0;
>  }
> @@ -74,7 +74,7 @@ U_BOOT_DRIVER(arm_rndr) = {
>  	.name = DRIVER_NAME,
>  	.id = UCLASS_RNG,
>  	.ops = &arm_rndr_ops,
> -	.probe = arm_rndr_probe,
> +	.bind = arm_rndr_bind,
>  };
>  
>  U_BOOT_DRVINFO(cpu_arm_rndr) = {

