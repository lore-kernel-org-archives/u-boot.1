Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A6FE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 14:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3DCB8975A;
	Mon,  9 Dec 2024 15:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oKt+/WqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D8C8975B; Mon,  9 Dec 2024 15:02:57 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FA388C85
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 15:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=483b=TD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1733752970;
 bh=ntgW6XcnY7mf00iqHKruA0mZnDbKeftn9mLVFglB3Vk=;
 b=oKt+/WqU/1GpsV9jfwerAKD751MreTCA1vC9ysd3dxfaKi4dUcGLWH4CmqETygKYQ1+BtkFTA
 j+b5wYm16AFpC3ellp6HNDHLkOknGr0B/kLtxkhVmEz+f6Hvqaotl6npblxiibPqNF5NU3v2aCs
 EeU+XVLeURnJPmy8E7Y8xkR4LM/svOTEM0edByCzrCmj98B3KUDCDIBmomV8m+R5ycPjp9lgD+D
 lQTIjpyE7g+/2mWpxlZo6YQMScvcCdolq/J2G5iPvmDgcxuCIfrge5uBFdKlCwFiF1Qs62NsRC9
 V/LV+Szkocd5wB5PXG5nwwjjJ1WNiVSgZNZHCjbGDpuw==
Message-ID: <b3d4156f-f09b-494d-8dda-ad4300ac0eef@kwiboo.se>
Date: Mon, 9 Dec 2024 15:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rockchip: rk3288: use includes from dts/upstream
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 u-boot@lists.denx.de
References: <bc076039-33db-4d87-b1bb-d1086c74e563@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <bc076039-33db-4d87-b1bb-d1086c74e563@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6756f88ac1cee88047b93734
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

Hi Johan,

On 2024-12-09 14:19, Johan Jonker wrote:
> The clock and power DT includes for rk3288 are now
> available in the dts/upstream directory, so remove
> the ones that are now redundant. Remove the use of
> non existent SCLK_MAC_PLL id in the clock driver.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed:
>   This patch does not include the removal of a clock binding
>   as was proposed in an earlier serie elsewhere.
>   For better fit with my other patch serie for binding removal.
> 
> http://patchwork.ozlabs.org/project/uboot/patch/71b804a0-ae2a-472c-84c9-ad7c6317e154@gmail.com/
> https://patchwork.ozlabs.org/project/uboot/patch/20241109210427.884888-4-jonas@kwiboo.se/
> ---
>  drivers/clk/rockchip/clk_rk3288.c        |   8 +-
>  include/dt-bindings/clock/rk3288-cru.h   | 381 -----------------------
>  include/dt-bindings/power/rk3288-power.h |  32 --
>  3 files changed, 4 insertions(+), 417 deletions(-)
>  delete mode 100644 include/dt-bindings/clock/rk3288-cru.h
>  delete mode 100644 include/dt-bindings/power/rk3288-power.h
> 

[snip]

This cleanup is already handled in the following series:

rockchip: rk3288: Include files from dts/upstream
https://patchwork.ozlabs.org/project/uboot/cover/20241109210427.884888-1-jonas@kwiboo.se/

Regards,
Jonas
