Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE80C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 569F780F03;
	Tue,  6 May 2025 09:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jmrdQ+2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31B882102; Tue,  6 May 2025 09:44:17 +0200 (CEST)
Received: from mail-m49204.qiye.163.com (mail-m49204.qiye.163.com
 [45.254.49.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B7D5800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 141663859;
 Tue, 6 May 2025 15:38:50 +0800 (GMT+08:00)
Message-ID: <a382df04-3761-4821-bf64-9f9a1795502f@rock-chips.com>
Date: Tue, 6 May 2025 15:38:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] rockchip: mkimage: Improve support for v2 image format
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129223641.1888833-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHRkYVh5MTBpKQ0xMSRpOSFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a96a4887ddd03afkunm141663859
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mkk6KTo6DTJLPxAMHUwsPS0e
 IiJPCitVSlVKTE9NTkpMSkhKTUpKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpMQkM3Bg++
DKIM-Signature: a=rsa-sha256;
 b=jmrdQ+2Fo7QENRV3G8xaocxYmEFw2+o90B0OsmRIWuF7Kw7B9wGJZiMQsz7/3T4Gm1+EzqFC96M11Lsz4RYNwQbZDJxAnZ3/tUPUC5wOIsGawVW6UiLbXkeXdgxRala31DK9EPWzBBV8xP72sBkAvcVpFyzg4foDfrpg9L53DRQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=dnIHGAVxGe/w6cXNi9VSywQ3SNo4udoL9Y/9s9p9Bgw=;
 h=date:mime-version:subject:message-id:from;
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

Hi Jonas,

     Do you have a new version for this patch set?

     The main change in this patch set looks good to me and it needs for 
rk3576 which has land for next release.


Thanks,

- Kever

On 2025/1/30 06:36, Jonas Karlman wrote:
> The Rockchip idblock v2 image format header embeds much more information
> than the older format. E.g. it can embed up to 4 images that the BootROM
> can load, image load address, flag, checksum and more.
>
> This series improves mkimage with support for some of these features of
> the v2 image format. Features that are likely to be needed to have
> working SD-card boot on RK3576.
>
> Jonas Karlman (6):
>    rockchip: mkimage: Split size_and_off and size_and_nimage
>    rockchip: mkimage: Print image information for all embedded images
>    rockchip: mkimage: Print boot0 and boot1 parameters
>    rockchip: mkimage: Add option to change image offset alignment
>    rockchip: mkimage: Add support for up to 4 input files
>    rockchip: mkimage: Add option for image load address and flag
>
>   tools/rkcommon.c | 268 +++++++++++++++++++++++++++++------------------
>   tools/rkcommon.h |   2 -
>   2 files changed, 166 insertions(+), 104 deletions(-)
>
