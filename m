Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB53C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 11:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E1B8056A;
	Fri, 25 Apr 2025 13:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745579560;
	bh=oWhRXPX13N0GWRBTkzhQubohjHq+Yqdw8+ZjzyZt9Ww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=WHIU1yejDOeotOuIGbamo1/KFUsvk31nW97C2JiZXDOgBTfzJiFQwxdvjDjmaOOdd
	 FYr92YnQhTzBqmseyt34C8uQDomGidfhxPHvtyz2MmZNBtDdYodWhGkBv6we9xh8bU
	 vm7pB9nLtUAp9aFuAOpIFYyhi3KMYOCgedmQKtHD+pFu0jj+wR3MGi93Qx2nZs2FEK
	 L+S83u7VFJhIuwDAGw7s1KqgRNF7M+d5VHzAUbC7gxlwn5AHHU60Au6n1aT6oFbIIx
	 tpsvf65I50haDhNneOM8P0KP6MZC782uDao8/koKnPshIYRYuF8iEAfOo9F1Zo91fT
	 gBYTNXeNvMFjQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 533E181F0D; Fri, 25 Apr 2025 13:12:38 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D64480194
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 13:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Egj3KIef"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C02DE10275AFC; 
 Fri, 25 Apr 2025 13:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745579555;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=oWhRXPX13N0GWRBTkzhQubohjHq+Yqdw8+ZjzyZt9Ww=;
 b=Egj3KIefE4p/1DUFlo+V5K7WDu6Fd3wSh3SBF/FoHfTX0z4mX8B3l+/39Ftom88APbbANS
 4SmV6zQOV5nm7qEu2skupFkAQkeX+Y+DX54bthqJ5PIvCNHDVIyYwpRHrN9KzX7o2FmB28
 ILSiNs2h1IrAUlWiLUEBurIVKLzzpNcSzpdHJFqZu+A4V9xMiV2vqF8gKgDCMSH7cN+R95
 lQa4b5tdynTVXnx7jUjQA/Tp9n8a78cigUphUkolNd8Rzk+zhvN8/iXEiEfngj43yxlFNe
 gFYs57GXFY0YVJ/7GmQn3iYZVmbNCd5gvRqQ/78apzFlMs12lVetaqrFs4mN+A==
Message-ID: <f122ee57-8a89-20f1-510a-687cddf173ec@denx.de>
Date: Fri, 25 Apr 2025 13:12:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] power-domain: Add support for refcounting (again)
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel.holland@sifive.com>,
 Neha Malcom Francis <n-francis@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Fabio Estevam <festevam@denx.de>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
 <20250425-ge-ian-display-support-v1-1-8a7a0fe75023@bootlin.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250425-ge-ian-display-support-v1-1-8a7a0fe75023@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Miquel,

Thanks for the fast fix, and sorry, that I did not found the
time to look into faster...

On 25.04.25 08:49, Miquel Raynal wrote:
> It is very surprising that such an uclass, specifically designed to
> handle resources that may be shared by different devices, is not keeping
> the count of the number of times a power domain has been
> enabled/disabled to avoid shutting it down unexpectedly or disabling it
> several times.
> 
> Doing this causes troubles on eg. i.MX8MP because disabling power
> domains can be done in recursive loops were the same power domain
> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
> timings to respect and it is easy to produce a race condition that puts
> the power domains in an unstable state, leading to ADB400 errors and
> later crashes in Linux.
> 
> Some drivers implement their own mechanism for that, but it is probably
> best to add this feature in the uclass and share the common code across
> drivers. In order to avoid breaking existing drivers, refcounting is
> only enabled if the number of subdomains a device node supports is
> explicitly set in the probe function. ->xlate() callbacks will return
> the power domain ID which is then being used as the array index to reach
> the correct refcounter.
> 
> As we do not want to break existing users while stile getting
> interesting error codes, the implementation is split between:
> - a low-level helper reporting error codes if the requested transition
>    could not be operated,
> - a higher-level helper ignoring the "non error" codes, like EALREADY and
>    EBUSY.
> 
> CI tests using power domains are slightly updated to make sure the count
> of on/off calls is even and the results match what we *now* expect. They
> are also extended to test the low-level functions.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   arch/sandbox/include/asm/power-domain.h          |  2 +
>   drivers/firmware/scmi/sandbox-scmi_devices.c     |  1 +
>   drivers/power/domain/power-domain-uclass.c       | 90 ++++++++++++++++++++++--
>   drivers/power/domain/sandbox-power-domain-test.c | 15 ++++
>   drivers/power/domain/sandbox-power-domain.c      |  4 ++
>   include/power-domain.h                           | 69 +++++++++++++++---
>   test/dm/power-domain.c                           | 11 ++-
>   7 files changed, 177 insertions(+), 15 deletions(-)

after reverting locally commit "197376fbf300e92afa0a1583815d9c9eb52d613a."
and applying this patch and patch 2/2 of this series, "pci enum"
works again on imx8mp based board:

u-boot=> pci enum
PCIE-0: Link up (Gen1-x1, Bus0)
u-boot=> print update_ub_emmc
update_ub_emmc=run prepemmc loadub updub cmpub
u-boot=> run loadub
e1000: 00:30:d6:39:7a:c1
        e1000: 00:30:d6:39:7a:c2
        Using e1000#1 device
TFTP from server 192.168.3.1; our IP address is 192.168.3.51
Filename 'lec/20250327/flash.bin.4g'.
Load address: 0x50000000
Loading: ##################################################  2 MiB
          354.5 KiB/s
done
Bytes transferred = 2097152 (200000 hex)
u-boot=>

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>
Tested-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
