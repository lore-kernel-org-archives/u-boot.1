Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8242CCCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 18:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3F6340908;
	Sat, 17 Oct 2026 18:28:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 41y-CTy_CS6T; Sat, 17 Oct 2026 18:28:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F6BA408F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792261705;
	b=Qzb3OddtUr0UXhbu68mrPaIfGu6wkMU/TC6ojyiSmKzZN3BcnxrFz4Jfu3Y6/5SusLeP
	 0jSRQH9Dl7p0wwMRft+G9U1r5nMtcPYQG3o+H/W/CMWBJXxrSfsAtEdLkbjlB4e0qvBsL
	 yjdzGVpwU8AmQV1GeNRcPUIBkIMYvJK916T04eJGUKqlepBHOROblYWL4NFs9fiQwmRmm
	 hPQgDS+98m84yEkUAZe8GFkaq+xsv0xnbdXBySFXIzV9uYCtQw99K7UwO5tVqDXqNvY5v
	 v+oRWxOWjnwRFnjryUacK4Nhzvwes7OAJea58IEZH4aHfI1CYSWPta+M3BQlgsArnXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792261705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+OkDJ+BgP8KLUaNzRFuP20lAOyK5PVgWyGKGTE7qq4c=;
	b=gpuYR7UZyKqFPzqBwGfwV8wv6j51dLwERsFl2++ib71euX8wWQSI31CyuVelO98b80FH
	 S6J+CEUcOJ60q3MDXtV79iG2uL7psIrNRZGMV1sZiiXzR/e9izUs2nGNglVmpTnsTLWWB
	 UKVp2PjE4qVG0K5y4//cpb7fBWs6IFqBsR9BXcQwu6zVIM9mA64wblQcNKSiaDXeHbUuh
	 TIxSb6Sevny3LQTknmiuguQ/g6Zad/VTXUHl5P76AP6vNGOHRGbHrU44yQ7z/nS+nk5MV
	 GYOq8AOWaIl4BRFn9Much4p244FXoBSluywqtYyo0RJsf3tMM3ke4tkXVSbA9yB5bEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792261705;
	bh=+OkDJ+BgP8KLUaNzRFuP20lAOyK5PVgWyGKGTE7qq4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BpML7IimoDp6k5nIjJG7g3qnphI1dtkOfqXyYf289ukCoL6QYzW4Q4ybG7ybwLJLR
	 3PB2rt2d4osv2OcPKUs+OGVMwGO5DYMNWqyitSaKluZFkA0njomfOxx0pxCt7xiFGJ
	 4cWkAgxLsJeJ8Wz+gnCt+6GJ+el/zVNXr8qcLBmknZ2bZr2zcB8PFrSe+XEa+3P89l
	 HLr2YVJhYQQGd/uyd2HVUe6cZpzGOkEKyuIqU0vIr8wUNoEkBzLq+u6RAw1F8Txv6v
	 nD0AnYG+MduY39IoiA9zh5P4Qt00UYp6t0v36QdvE+6I1QnqYugcL9rq9i6aB4G+Rx
	 CvvUGQs1Nm95Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F6BA408F8;
	Sat, 17 Oct 2026 18:28:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 050321DE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EACFA8122B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:28:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BwJBumt-c7SS for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 18:28:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D579A811D0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792261703;
 b=TrBwtNaY7tD6pA9y7Vm6kKndKO86ud9LZZ+FiTy6SA3AXXe3U4gU08/H4tamnbroOsC7
 0O4ZaYn72ovkCdd5CbSUPRNUdditJuYeeG7isZXMKeM6cm6PsLsTKuYu1K3HVeNw/g5SM
 5O8BLNxIrvXlCIfYzxV+Qizts9qZ2MJK3NpjA/R+VX5/B1cdSV+NCcUqQTqztF5sQb6d4
 2tD65vgygs09b4ieFbskt2F3Zp4lp/o/4hOVJG4t+L3PzUDYdEru0pSZD28W91FaWErNu
 hw1PVOzCfxNmNorr0wve0KBOWbjHxdAumSNc4uxbcp0XG/43/hgt7eah5XICII5ZfbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792261703;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=+OkDJ+BgP8KLUaNzRFuP20lAOyK5PVgWyGKGTE7qq4c=;
 b=tckYqEh4PIe61PaspXNjUhju88ujPoFt/5YxYXBSydpmVCeT8g7OJJW8E3/6h35C8WA2
 nlZGa20XNhC8k2DmLONcHF7/mCiKutBtuEp6EUG9JKwaADh+hJzQjoSfZv7PC1cMwk5aH
 ZiOWjplsi1KHzkddSIMYmqjoCZDjgElkNJlm+R8D7Hn1lxCFTi8gFWl5k9NRc6uTWuV+C
 /YvuAN+19KhXRfTBN+yWo8kXLTAleGvZTCA07amR+bQ6Y7ost2SHqpj2Li/zo8h457oFf
 OSUle7EyU1ih5IcYoLRT2mw1QkpyHrSW5E7/NZ9Bw+PdbqWBadw+qauS60qfGvJLmTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fO5FBO5j; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fO5FBO5j
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D579A811D0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:28:22 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3acdcfa2bd3so871697a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792261702; x=1792866502;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+OkDJ+BgP8KLUaNzRFuP20lAOyK5PVgWyGKGTE7qq4c=;
 b=fO5FBO5jUnDRgowCfoevg/0qRDvLcJJJfKWkswiVaP69xfXSaihKfl+wHnLtXeRuwr
 oG+T8oZ+iS2YwTkuDvlqL5lstpdJq4c7rchsmttMCxddRj3x3oIv3BGFXDzweoSoxeUS
 C44kFjD1rHoutvObOgPRlI8eOda0FXi424lU+uQW8zM+XLJ8ToLLnMUy5fRZ7lIIO+Pj
 BvBsnrITyZuYHHooIgSmsLLqn4zpq2jetWbU5dUjtszcPD80W2NrGqSlNEtoLtQSdKqP
 /vvgCdARN4/rO93Ky2tJ4bFptgHx+6FWe/E6YzYh5z8vkQP5teAalncvfYHc+FyuZrV3
 S1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792261702; x=1792866502;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+OkDJ+BgP8KLUaNzRFuP20lAOyK5PVgWyGKGTE7qq4c=;
 b=FSCn8rlzCT2JdXY8tNItuj9Osi17KP+zpu2hbQHhJpt3Nmn9awAXq4aA0i8QyolHE+
 ThXMlTh9qDJWHT8cOPFYg63KQhtKro6D4XrR5RlavbYys9ii4Ocm/lLuAaQfB0ByQKcz
 /q0Knxh4rNi/rGWoiS+ovgIXEmS7XIcrFFAsE818keV4vTSXn7OdHcFh5Dobt/bgkWlD
 g3y2xNu/yOU5ddH0TVJr7AguSVw1waciJyglBxe+YwY4XxciLJzz0jUZrXy8CoHJ/Clu
 j/2aIPAPJFlxvki6Y85W26NZTZqPhp9pG7gAGqC+VuoAMVtgPlYGETxT3mJ05+zVmpkD
 r4jQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBEaTYsEs+bTl/0xq/ZGJuJpE6lVJVrkFdlIDSgSQ5lzEoNf9v6X3xnVw1ge3tW+7NOZe5Xd8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJqZpGrzXJrAMSPKvB+WKRKrABtpK6R4xxbMaaaP3E8+r/Ja0sg
 mSYvZFAqKJmuLVzsOnfcJJoo1eUCrMPut1VoQlZJkQsT1pYcwq1aJ4YcvBcIIw==
X-Gm-Gg: AYBFou1ZQz79keFZwtgY86tKWbHtJNnIz1Z0q/10ApWRk2QIpLO3UuGtCyPSpTqyF42
 Xte8ZKCvLQS/jIcYOIXzWK4C3UeKrg71sC48+TShtZ5ZzIxLim4PjYG7QJksb6OXS4sp9x8Fe/P
 J24ACOHfDqAZtlfS5B5DqfOgB2EmnOwWe/xkcvC0/Dl4451J1Idc2SmtA8aW2IoEe/KvCVqoLdJ
 DFUtffrD66l9dayum3fs+1boToAmEYtlJo1M5eMXlQSLTQam4e4UZ/JPVQZ9j4jujiXcJPXWY7f
 kAf5xVSitl6qtHF7mFtsp7V8glprYLo1c/wtnDUlq7UGy1ItUboqHY+GOh+DzSGX+j2+RUEQAYc
 dibFwUnf+lH2a0NsEHC5GdG3JugGZDzCvonKz+2eOqmchfEzapZYbDqOfcuakLRHRWMFET1Daih
 7BLiISIBm/3roBQ8rYrnML+OpKpINnd3REwiy8OWZ1TZsDfybOqAMWKxr97lxLJi0J+ZXLfuwHE
 5ZCzV7QJQppQ1dgKWCIY3wieJljTMMbCw==
X-Received: by 2002:a17:90a:c110:b0:3a8:bd51:205b with SMTP id
 98e67ed59e1d1-3acef0e4640mr2713928a91.37.1792261701577; 
 Sat, 17 Oct 2026 11:28:21 -0700 (PDT)
Received: from google.com (61-230-12-185.dynamic-ip.hinet.net. [61.230.12.185])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc4972fe6sm9140799a91.15.2026.10.17.11.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 11:28:21 -0700 (PDT)
Date: Sun, 18 Oct 2026 02:28:17 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/3] virtio: rtc: Add virtio RTC driver
Message-ID: <atO-QSSxMboOtqym@google.com>
References: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
 <20261014190631.2232208-2-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014190631.2232208-2-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Hung-Chun,

Sorry for getting back on this late.

On Thu, Oct 15, 2026 at 03:06:29AM +0800, Hung-Chun Tseng wrote:
> Add a driver for the virtio RTC device (virtio device ID 17), which
> QEMU provides as virtio-rtc-pci and virtio-rtc-device since v11.1.0.
> 
> The device exposes its clocks through a request virtqueue. As the
> virtqueue must not be used before the virtio uclass sets DRIVER_OK,
> which happens after probe(), the first read looks for the clock: it
> asks for the number of clocks with VIRTIO_RTC_REQ_CFG and picks the
> first one whose VIRTIO_RTC_REQ_CLOCK_CAP type is UTC, smeared UTC or
> maybe-smeared UTC. Reading the time sends a VIRTIO_RTC_REQ_READ for
> that clock and converts the nanoseconds since the epoch with
> rtc_to_tm(). The clocks are read-only, so there is no set operation,
> and the optional alarm feature is not negotiated.
> 
> VIRTIO_RTC defaults to y when VIRTIO and DM_RTC are enabled, like
> VIRTIO_RNG does for DM_RNG.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
> 
> Changes in v2:
> - Look for the UTC clock on the first virtio_rtc_get() instead of in
>   probe(), as the virtqueue must not be used before DRIVER_OK (Bin)
> 
>  drivers/virtio/Kconfig         |   9 ++
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_rtc.c    | 213 +++++++++++++++++++++++++++++++++
>  include/virtio.h               |   4 +-
>  5 files changed, 227 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/virtio/virtio_rtc.c
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 55b444280..c19138ef2 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -84,4 +84,13 @@ config VIRTIO_9P
>  	help
>  	  This enables the 9P transport driver over virtio.
>  	  It can be used with QEMU based targets.
> +
> +config VIRTIO_RTC
> +	bool "virtio RTC driver"
> +	depends on DM_RTC
> +	depends on VIRTIO
> +	default y
> +	help
> +	  This is the virtual RTC driver. It reads the UTC clock of a
> +	  virtio RTC device. It can be used with QEMU based targets.
>  endmenu
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 6e7bcfc8e..ddb5ce4eb 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>  obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
>  obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
>  obj-$(CONFIG_VIRTIO_9P) += virtio_9p.o
> +obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
> diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
> index c163b2fd7..c6cf55922 100644
> --- a/drivers/virtio/virtio-uclass.c
> +++ b/drivers/virtio/virtio-uclass.c
> @@ -31,6 +31,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
>  	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
>  	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
>  	[VIRTIO_ID_9P]		= VIRTIO_9P_DRV_NAME,
> +	[VIRTIO_ID_CLOCK]	= VIRTIO_RTC_DRV_NAME,
>  };
>  
>  int virtio_get_config(struct udevice *vdev, unsigned int offset,
> diff --git a/drivers/virtio/virtio_rtc.c b/drivers/virtio/virtio_rtc.c
> new file mode 100644
> index 000000000..f5d4a694b
> --- /dev/null
> +++ b/drivers/virtio/virtio_rtc.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> + *
> + * Driver for the virtio RTC device (virtio device ID 17). The device
> + * exposes one or more read-only clocks through a request virtqueue; this
> + * driver reads the first UTC clock and reports it through the RTC uclass.
> + */
> +
> +#include <div64.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <rtc.h>
> +#include <virtio_types.h>
> +#include <virtio.h>
> +#include <virtio_ring.h>
> +#include <linux/types.h>
> +
> +#define VIRTIO_RTC_REQ_READ		0x0001
> +#define VIRTIO_RTC_REQ_CFG		0x1000
> +#define VIRTIO_RTC_REQ_CLOCK_CAP	0x1001
> +
> +#define VIRTIO_RTC_S_OK			0
> +
> +#define VIRTIO_RTC_CLOCK_UTC			0
> +#define VIRTIO_RTC_CLOCK_UTC_SMEARED		3
> +#define VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED	4
> +
> +struct virtio_rtc_req_head {
> +	__le16 msg_type;
> +	u8 reserved[6];
> +} __packed;

IIUC, reserved[] is already intended to ensure natural alignment for
all members, so I'm wondering if adding __packed here is actually
counterintuitive?

> +
> +struct virtio_rtc_resp_head {
> +	u8 status;
> +	u8 reserved[7];
> +} __packed;
> +
> +/* Request for VIRTIO_RTC_REQ_READ and VIRTIO_RTC_REQ_CLOCK_CAP */
> +struct virtio_rtc_req_clock {
> +	struct virtio_rtc_req_head head;
> +	__le16 clock_id;
> +	u8 reserved[6];
> +} __packed;
> +
> +struct virtio_rtc_resp_read {
> +	struct virtio_rtc_resp_head head;
> +	__le64 clock_reading;
> +} __packed;
> +
> +struct virtio_rtc_resp_cfg {
> +	struct virtio_rtc_resp_head head;
> +	__le16 num_clocks;
> +	u8 reserved[6];
> +} __packed;
> +
> +struct virtio_rtc_resp_clock_cap {
> +	struct virtio_rtc_resp_head head;
> +	u8 type;
> +	u8 leap_second_smearing;
> +	u8 flags;
> +	u8 reserved[5];
> +} __packed;
> +
> +struct virtio_rtc_priv {
> +	struct virtqueue *vq;
> +	u16 clock_id;
> +	bool clock_found;
> +};
> +
> +static int virtio_rtc_xfer(struct udevice *dev, void *req, size_t req_len,
> +			   void *resp, size_t resp_len)
> +{
> +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> +	struct virtio_rtc_resp_head *head = resp;
> +	struct virtio_sg req_sg = { req, req_len };
> +	struct virtio_sg resp_sg = { resp, resp_len };
> +	struct virtio_sg *sgs[] = { &req_sg, &resp_sg };
> +	unsigned int len;
> +	int ret;
> +
> +	ret = virtqueue_add(priv->vq, sgs, 1, 1);
> +	if (ret)
> +		return ret;
> +
> +	virtqueue_kick(priv->vq);
> +
> +	while (!virtqueue_get_buf(priv->vq, &len))
> +		;
> +
> +	if (len < sizeof(*head) || head->status != VIRTIO_RTC_S_OK)
> +		return -EIO;
> +
> +	if (len < resp_len)
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +
> +static bool virtio_rtc_is_utc(u8 type)
> +{
> +	return type == VIRTIO_RTC_CLOCK_UTC ||
> +	       type == VIRTIO_RTC_CLOCK_UTC_SMEARED ||
> +	       type == VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED;

Linux only permits VIRTIO_RTC_CLOCK_UTC_SMEARED to be registered as an
RTC class device and deliberately skips VIRTIO_RTC_CLOCK_UTC and
VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED. Of course, since U-Boot does not
have a PTP subsystem, we probably shouldn't follow Linux strictly here.
However, as an example, if a device exposes both VIRTIO_RTC_CLOCK_UTC
(e.g., clock 0 for PTP) and VIRTIO_RTC_CLOCK_UTC_SMEARED (e.g., clock 1
for RTC), the Linux RTC class binds to clock 1, whereas this U-Boot
driver simply picks the first UTC-like clock it encounters
unconditionally (clock 0). I'm not sure if this is what we want, or
whether you have considered this scenario? I feel like this is at least
worth mentioning in the commit message or in an code comment.

> +}
> +
> +static int virtio_rtc_find_utc_clock(struct udevice *dev)
> +{
> +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> +	struct virtio_rtc_req_head cfg_req = {
> +		.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CFG),
> +	};
> +	struct virtio_rtc_resp_cfg cfg = {};
> +	u16 num_clocks, id;
> +	int ret;
> +
> +	ret = virtio_rtc_xfer(dev, &cfg_req, sizeof(cfg_req), &cfg, sizeof(cfg));
> +	if (ret)
> +		return ret;
> +
> +	num_clocks = le16_to_cpu(cfg.num_clocks);
> +	for (id = 0; id < num_clocks; id++) {
> +		struct virtio_rtc_req_clock req = {
> +			.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CLOCK_CAP),
> +			.clock_id = cpu_to_le16(id),
> +		};
> +		struct virtio_rtc_resp_clock_cap cap = {};
> +
> +		ret = virtio_rtc_xfer(dev, &req, sizeof(req), &cap, sizeof(cap));
> +		if (ret)
> +			continue;

The Linux virtio-rtc driver stops and returns an error code when
viortc_clocks_init() fails. I'm not sure if we have any particular
reason to proceed here?

Regards,
Kuan-Wei

> +
> +		if (virtio_rtc_is_utc(cap.type)) {
> +			priv->clock_id = id;
> +			priv->clock_found = true;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int virtio_rtc_get(struct udevice *dev, struct rtc_time *time)
> +{
> +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> +	struct virtio_rtc_req_clock req = {
> +		.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_READ),
> +	};
> +	struct virtio_rtc_resp_read resp = {};
> +	u64 now;
> +	int ret;
> +
> +	/*
> +	 * The virtqueue must not be used before DRIVER_OK, which the virtio
> +	 * uclass sets only after probe(), so look for the clock on first use.
> +	 */
> +	if (!priv->clock_found) {
> +		ret = virtio_rtc_find_utc_clock(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	req.clock_id = cpu_to_le16(priv->clock_id);
> +
> +	ret = virtio_rtc_xfer(dev, &req, sizeof(req), &resp, sizeof(resp));
> +	if (ret)
> +		return ret;
> +
> +	now = le64_to_cpu(resp.clock_reading);
> +	do_div(now, 1000000000U);
> +	rtc_to_tm(now, time);
> +
> +	return 0;
> +}
> +
> +static int virtio_rtc_bind(struct udevice *dev)
> +{
> +	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
> +
> +	/* The alarm feature is not supported */
> +	virtio_driver_features_init(uc_priv, NULL, 0, NULL, 0);
> +
> +	return 0;
> +}
> +
> +static int virtio_rtc_probe(struct udevice *dev)
> +{
> +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = virtio_find_vqs(dev, 1, &priv->vq);
> +	if (ret < 0) {
> +		debug("%s: virtio_find_vqs failed\n", __func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rtc_ops virtio_rtc_ops = {
> +	.get	= virtio_rtc_get,
> +};
> +
> +U_BOOT_DRIVER(virtio_rtc) = {
> +	.name	= VIRTIO_RTC_DRV_NAME,
> +	.id	= UCLASS_RTC,
> +	.bind	= virtio_rtc_bind,
> +	.probe	= virtio_rtc_probe,
> +	.remove	= virtio_reset,
> +	.ops	= &virtio_rtc_ops,
> +	.priv_auto	= sizeof(struct virtio_rtc_priv),
> +	.flags	= DM_FLAG_ACTIVE_DMA,
> +};
> diff --git a/include/virtio.h b/include/virtio.h
> index b981eead5..95069a2de 100644
> --- a/include/virtio.h
> +++ b/include/virtio.h
> @@ -32,12 +32,14 @@
>  #define VIRTIO_ID_BLOCK		2 /* virtio block */
>  #define VIRTIO_ID_RNG		4 /* virtio rng */
>  #define VIRTIO_ID_9P		9 /* virtio 9p */
> -#define VIRTIO_ID_MAX_NUM	10
> +#define VIRTIO_ID_CLOCK		17 /* virtio clock/timer (rtc) */
> +#define VIRTIO_ID_MAX_NUM	18
>  
>  #define VIRTIO_NET_DRV_NAME	"virtio-net"
>  #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
>  #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
>  #define VIRTIO_9P_DRV_NAME	"virtio-9p"
> +#define VIRTIO_RTC_DRV_NAME	"virtio-rtc"
>  
>  /* Feature bits for virtio 9P */
>  #define VIRTIO_9P_MOUNT_TAG	0
> -- 
> 2.43.0
> 
