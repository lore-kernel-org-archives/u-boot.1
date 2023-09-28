Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7172BCE7AF1
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 03:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9626686B95;
	Thu, 28 Sep 2023 05:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="QHqdrURO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFBD86DD6; Thu, 28 Sep 2023 05:06:02 +0200 (CEST)
Received: from mail-m127158.xmail.ntesmail.com
 (mail-m127158.xmail.ntesmail.com [115.236.127.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F015286B3B
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 05:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=QHqdrUROSFYpF+o8071Pe2or30eVoO5kAcZ07iLP+IzDecLB0afauS0AbEoi4ukgN8MTj8KxvKPnT8bH/hfkfEiYcY9O/KGd01548anYe3xATkn+awZcdQ+4qG89pMjcseDmlFvceEFzUfycqwB2AVfYvcFBNNlq5mZmdAM35QM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=3CPWpCOsHDt6dioF7y9XdZzJsuJ+/2Y784DcuRdB+8Q=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id A4CA14002E6;
 Thu, 28 Sep 2023 11:04:21 +0800 (CST)
Message-ID: <f448ecc1-64d1-53e6-06c6-3734224333f2@rock-chips.com>
Date: Thu, 28 Sep 2023 11:04:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/3] dm: prepare rkmtd UCLASS
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de
References: <cbbaecb0-19fc-018d-df63-c5f265156024@gmail.com>
 <409e34cc-f729-cb6d-1ee8-cbeb38c26d1c@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <409e34cc-f729-cb6d-1ee8-cbeb38c26d1c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1PTlYeTR5PT0tJSx5LQkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad9be9a852eb3kusna4ca14002e6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6Aio5Pzw*LisqVi5CTRoo
 TBEaChhVSlVKTUJOQ0xLSU1JSEJOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITkxNNwY+
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


On 2023/8/24 21:29, Johan Jonker wrote:
> Prepare a rkmtd UCLASS in use for writing Rockchip boot blocks
> in combination with existing userspace tools and rockusb command.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   disk/part.c                | 4 ++++
>   drivers/block/blk-uclass.c | 1 +
>   include/dm/uclass-id.h     | 1 +
>   3 files changed, 6 insertions(+)
>
> diff --git a/disk/part.c b/disk/part.c
> index 186ee965006e..a65f9df5dd29 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -170,6 +170,7 @@ void dev_print(struct blk_desc *dev_desc)
>   	case UCLASS_PVBLOCK:
>   	case UCLASS_HOST:
>   	case UCLASS_BLKMAP:
> +	case UCLASS_RKMTD:
>   		printf ("Vendor: %s Rev: %s Prod: %s\n",
>   			dev_desc->vendor,
>   			dev_desc->revision,
> @@ -303,6 +304,9 @@ static void print_part_header(const char *type, struct blk_desc *dev_desc)
>   	case UCLASS_PVBLOCK:
>   		puts("PV BLOCK");
>   		break;
> +	case UCLASS_RKMTD:
> +		puts("RKMTD");
> +		break;
>   	case UCLASS_VIRTIO:
>   		puts("VirtIO");
>   		break;
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index 614b975e25c2..6bad2719e729 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -34,6 +34,7 @@ static struct {
>   	{ UCLASS_VIRTIO, "virtio" },
>   	{ UCLASS_PVBLOCK, "pvblock" },
>   	{ UCLASS_BLKMAP, "blkmap" },
> +	{ UCLASS_RKMTD, "rkmtd" },
>   };
>
>   static enum uclass_id uclass_name_to_iftype(const char *uclass_idname)
> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> index 307ad6931ca7..99a411429a2f 100644
> --- a/include/dm/uclass-id.h
> +++ b/include/dm/uclass-id.h
> @@ -113,6 +113,7 @@ enum uclass_id {
>   	UCLASS_REGULATOR,	/* Regulator device */
>   	UCLASS_REMOTEPROC,	/* Remote Processor device */
>   	UCLASS_RESET,		/* Reset controller device */
> +	UCLASS_RKMTD,		/* Rockchip MTD device */
>   	UCLASS_RNG,		/* Random Number Generator */
>   	UCLASS_RTC,		/* Real time clock device */
>   	UCLASS_SCMI_AGENT,	/* Interface with an SCMI server */
> --
> 2.30.2
>
