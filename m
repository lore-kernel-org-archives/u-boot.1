Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1A9CE8379
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BD188FDA;
	Mon, 30 Sep 2024 19:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727717706;
	bh=omp7Y/YZfiOGdyG7h0NLQ3IJEvhJMQz7YmYd+Q3d9bY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r+JfYdokjo7FvP21+UwQnQp4SUjRMY8SbMzhQN3LVq8OtxM/QFM5xh9Y9RkToFeyT
	 ZWY/VjlYs+g6GstYdxmjPeFNFeaWg652RnlQvwrBh6o0UELj2nlV4nvXUqgfEAw81n
	 olj8Cvs7il2VaApSn1iCjlWZoJdZ0ReW0T7mREhLeOfxLbXp2aivP+nDhOX/dSn/AW
	 y1h2vvnfxCSJYGQF0PQtQ1TKPv/KLJeG6cgl/jxrOXVWC2dnG9Hsk9118pH6+wl6iP
	 HavbYhvqMLN4lCBRlAomcGY0Zdn/47PI0fpfaFQPQfo6+GClx3ivJTkwArm/CulTWa
	 XxIKBCcCYbUkw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9758688FD6;
 Mon, 30 Sep 2024 19:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727717705;
 bh=omp7Y/YZfiOGdyG7h0NLQ3IJEvhJMQz7YmYd+Q3d9bY=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=d2AvyGvvwVCbUMqTVjXVQW0YUQSIYpinBRrdSHCt/TlWXRUPRH6rD5gQLpe2QxNDv
 sOW9Y2DwJbJYLNn+fHGrpX2NiN8NFExklGHGnHPETR+0AIWJyx/2QB9HPkJ1D3RmQ5
 msDxkwH2fpNdNidLrzbip1wzi4OcqHN7EcDC0t0ndGaqsort7N8tKsl0RbtFGPjhH0
 i//NMX3kwFBf09jZV+H+AhYB6OogBzICSfo5YOjnYUL54shfEbx56/SEV/0FqvsAyk
 I82tWFrMmA7r3RlfUogVquDnUbk8D/hTKxuwVCycYe6yRJifkfNDO4AUt85bqr7PPi
 /uohjyxTUmRtQ==
Message-ID: <75eb6eb6-dd55-4509-a041-a5941286493f@denx.de>
Date: Mon, 30 Sep 2024 19:33:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 2/3] dts: Add ability to build DTOs only from
 arch/$(ARCH)/dts
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <20240927214955.394224-1-marex@denx.de>
 <20240927214955.394224-2-marex@denx.de>
 <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
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

On 9/30/24 8:02 AM, Sumit Garg wrote:
> + Jan
> 
> Hi Marek,

Hi,

> On Sat, 28 Sept 2024 at 03:20, Marek Vasut <marex@denx.de> wrote:
>>
>> Currently the enablement of OF_UPSTREAM results on the build system
>> searching for DTs only in dts/upstream/ . There are platforms which
>> use U-Boot specific DTBOs applied on top of U-Boot control DT during
>> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
> 
> I would like to understand the need to maintain DTBOs separately from
> DTBs. Why aren't we pushing DTBOs to Linux kernel sources as we do for
> DTBs?

This is a stopgap measure, I would like to start reducing the amount of 
U-Boot DTs for iMX platforms, but the DTBOs are still in U-Boot only, so 
I would like to have some middle-of-the-road solution until the DTOs get 
upstreamed to Linux too.

> Jan recently pushed those so-called U-Boot specific DTBOs for a
> TI platform which were accepted in the Linux kernel upstream. This
> patch will just deny the ability to build those DTBOs from dts
> upstream tree. IMHO, this takes a step backwards on the whole notion
> of OF_UPSTREAM.

I don't think this will deny building those DTOs which are already 
upstream. With OF_UPSTREAM enabled, this will build:
- Upstream DTBs
- Upstream DTBOs
- U-Boot local DTBOs (and NOT U-Boot local DTBs)
The DTs that are bundled into u-boot.itb are searched exactly in that 
order too, upstream ones first, upstream DTBOs second and finally the 
U-Boot local DTBOs. The upstream content should always get higher 
priority if there are any leftover DTBOs in U-Boot which are also upstream.

> If we really want a middle ground solution to allow migration to
> OF_UPSTREAM easier then we need to find a way to build DTBOs from both
> directories (local and upstream dts). I would imagine that will likely
> complicate building and packaging DTBOs.

I believe this is exactly what this commit does ?
