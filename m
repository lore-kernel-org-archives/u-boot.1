Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5A7C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ABCD80A37;
	Wed, 22 Jan 2025 14:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MyEdAwYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2EE78078B; Wed, 22 Jan 2025 11:00:05 +0100 (CET)
Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com
 [45.254.49.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FBE80586
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 11:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chaoyi.chen@rock-chips.com
Received: from [127.0.0.1] (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes
 [58.22.7.114]) by smtp.qiye.163.com (Hmail) with ESMTP id 967e5258;
 Wed, 22 Jan 2025 17:59:54 +0800 (GMT+08:00)
Message-ID: <617b3c10-a544-46b0-8250-89ace063d7c4@rock-chips.com>
Date: Wed, 22 Jan 2025 17:59:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] video: rockchip: Add VOP2 support
To: Dang Huynh <danct12@riseup.net>, u-boot@lists.denx.de
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>, Andy Yan <andyshrk@163.com>
References: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
 <20250116-vop2-pt2-v1-5-c9d646b53930@riseup.net>
 <7b0b95a6.1824.1947dd3a56a.Coremail.andyshrk@163.com>
 <6563300.lOV4Wx5bFT@melttower>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <6563300.lOV4Wx5bFT@melttower>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4ZHlYZS0tPSh1PSRlDHx5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a948d7443bb03abkunm967e5258
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Vhw5MTIOCi9JMi5OVkhP
 TAMaFB5VSlVKTEhMTkhCQkJMQklNVTMWGhIXVRgTGhQCElUYEx4VOwkUGBBWGBMSCwhVGBQWRVlX
 WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSktDTzcG
DKIM-Signature: a=rsa-sha256;
 b=MyEdAwYXH/tTZFzWTzdGz8RbV8c7zyNtkJ82yKfxXDNeRUGttNCkUYuSdsFr1NEUuwjeeoxhiVjUVu9o/VaSqD3isfRtAra2oXVjlbXAdw73+Kruj05MmWyyAajYP7NK5WD2hbqq6gcZ4tPisOh+5GWZS6+Nk5a3mfK1IHWRT9M=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=uO8n4dTPgTuuue1Gv2hPrFt4n0qMlqmxY3nLkp6uW7c=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 22 Jan 2025 14:22:36 +0100
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

Hi Dang,

On 2025/1/19 21:41, Dang Huynh wrote:
> Hi Andy,
>
> On Sunday, January 19, 2025 9:10:10 AM UTC Andy Yan wrote:
>> Hi Danq,
>>
>> Do you have tests with this u-boot video enabled then boot a linux kernel
>> also with drm display enabled?
>>
> Yes, I booted Linux with U-Boot VOP2 and Linux VOP2 enabled without any
> problem.
The power domain of the VOP is reset during the kernel boot process on 
RK356X, which effectively resets the VOP. If the PD is not reset when 
the VOP is active, it may not be able to reset the IOMMU which cause VOP 
fault. You can verify this by setting PD to always on. In addition, the 
RK3588 may have a similar problem.
>
>> Because the u-boot video been enabled with no-mmu, when it runs into linux
>> kernel with the window/plane you enable at u-boot stage, when linux kernel
>> enable the iommu, there is a moment the window will read the memory through
>> iommu, but the framebuffer you set in u-boot stage has not been mapped by
>> iommu, there is a high probability of causing an IOMMU page fault.
>>
>
>
>
