Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0355AC3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 842DA406AC;
	Wed, 14 Oct 2026 19:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xsYlyaSAi7Pr; Wed, 14 Oct 2026 19:46:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5EF5F4062E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792007171;
	b=YZh/T8FjqXVAybzHGjPUwc9xDbcQN+cpCkqGyx/ROt5lpIoCvnwUTzTQzYxMNtTBiqFy
	 AynJi2htRsRe9HQq/3uwPuXwqAOXkUvtIIDIvo9/ZhC/jSwq7QywMRHRav2wWR6KniUWG
	 PdeGUrL//VohtcbsMOUQNk2q9V7IKcUjjvb0hCTZ4bn5Ng+wzLHWLOxaLVoI5mzO8rICM
	 BQPb8GPRHzNiqweRih5WDP9mSVkm3Y+pWdv0SwMYz/xEgUuu1cCenh1+PtKSYH5NSQ675
	 yG1xlvgrRh5G7cfSzBoRPk85DghX4uQ6iIhAGjmLCDBwRXSWDWfG/zY6LxOHmrNTn0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792007171;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IKNr38uaVoxaLPAWHWiCBdqYU5ZjhE/2yEBG0acYfEQ=;
	b=PD2Lf95FHgZBV0vKytP/54ztvrN8F8DGMWyj7tJketf2/pOoxOhfeXVjK1DyQkPy8Rpk
	 Q+Y1Mqm2rqydz/HmBazMd0denkEFrtMWQveU1gGrlOqBcACp8e3ZhjE5iBY6EB0nuPyYC
	 qAoH1MAoXElz2b2fjMLafBw8/iOfc1WIUHvL1qFgGForJmO8L4HiVjFwtpGH7XaV7Sm+l
	 W7CkfR10jkekTswrUv/edW2UFMY6j1XGxut4QNlOamwO/t7cs/GvjflJHHFG2K4pEBXC8
	 EJ6jq3XJbmEUkGbhCDL1w3cQHzI7of4Ywnptlw50PjBScwUO3LvOWpc1T9Oumlm9Bow==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lcwVx+wJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792007171;
	bh=IKNr38uaVoxaLPAWHWiCBdqYU5ZjhE/2yEBG0acYfEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vF2oKWv0aNhbqs2vvhmkimQwVwPZGmZoSe8aNcixsC3qOhWCFhHyozqjQCFh3+Mbe
	 T7OLZQYsPxmv3RMLYrvmB5Lawh7FWzBhYLsmoyyV+p8PEGx/Ww+flO3qSHXqSC5pY6
	 /3YSK93MY2l92bevvjzkDS14rzWLahYdJZ+PwXvd+2YO0nbd14uzElFy7v7sPPTr0X
	 Vl+F1Eq69Akc4W+MzSDYAexyHLUfgga0AvV4foOa/wWfvPlCLG7TL9yDdy7nVzSXVb
	 dJduDO5N/sU1wuxqDgyqI9vGEw+S1cifDNfhyTw3h/1E5giR13R18N55bq+tkBaGJe
	 AgM9gLdemioRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EF5F4062E;
	Wed, 14 Oct 2026 19:46:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DE422E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73F344062E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:46:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XHrAcCMBIgfO for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:46:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 754FE405CB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792007169;
 b=rvrmZBe8ZbTpC/ndZpIMV5z0S2cAJOAyi/nA4Kf7PDLK18RTzTXXLlbfGx5kgLnpda18
 LYJL+Qh3kBPujRtgHcNXxTKA/ctjvhU+HT1H/Jjvd+DH1wrY9amLE9tEIkzKG/nII9+9V
 dmwql0hQJO7QLuROR4YgXD++U+8R1H9SHIYEUT9XrvBprXMrTZkiPXTOIHJib2RfqDE3I
 FMTW+LpNnaWwSktYiQwJVMTyjIBgInPdZfFoDIbS5FiV+LyxmYkfAND1Hdw6Qf+RMq8c8
 jXAh5zBgKrpjcim1mL5MXno82Q+K6Hdg267JEUtLUocUUgEQqESMLGKmAIrJRCRidsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792007169;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=IKNr38uaVoxaLPAWHWiCBdqYU5ZjhE/2yEBG0acYfEQ=;
 b=sITqeW1wSVeW+yHT+ZRnyB9wHoIrpDHTW87EpC5OooN1Tvmk0AJ1YJpM2nSm+lgEGZQ4
 ZV2wngLzJcNpAEZFThO4ekc/GB/eMQCf9NjmNYgYVUaAOibh2jwVw+6E+Qd0hs359j9ty
 +t0VLx1M1Q0cXWWgn7Hfam1KYye0PCnptgoL8jzEPcrj4UHstIMvaecpRamSFa5pL9Thz
 qaivucuRs84HX7Bln+QKV8RXdEX5oUDiYpwY/Wl9tZOezjqgnnxzyrjzmAEneWTJIMcmc
 LRY7s3ugrAWATqywj0zJbw0PxcsaPUTorXDYq0mtFgb5Uii49UWgwyRPbbS/n9LswjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lcwVx+wJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lcwVx+wJ
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 754FE405CB
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:46:09 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e6038cebefso33805045ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792007168; x=1792611968;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IKNr38uaVoxaLPAWHWiCBdqYU5ZjhE/2yEBG0acYfEQ=;
 b=lcwVx+wJij1TGmgJ+uBWgz8QS1SGWRuJ1F8RC04X2QUugEJiuCdZoDvJn9GfVe5JIH
 BnJ+/0OyRX9twpHFlr055vazPwhUjSIlmmxnbAzeFo6p74K4ruiDmMvtW81myAB7AxCR
 1IhrKWtQ6NYSJu/ymBwIz18cNHL/1MfBPa5qFx0K1/ssoDkV2RpPNj9zgAKGsLlvMaQU
 qWXu/8BcEPW0oyV8A7/alSMrBrmfWjA34SyNuUHsJVsB2b09TrtACXNZYlliEiYBicn/
 ys+yUuMLRFVZTkqb28vLPG4kKaw2lB6orS33J1TbYvdYcEIyrYevaHygIghUCv6ZZrit
 KPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007168; x=1792611968;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IKNr38uaVoxaLPAWHWiCBdqYU5ZjhE/2yEBG0acYfEQ=;
 b=EE8wAvltVHrwfABS3IU9lXx0jSpgcBPc4dObeGCTFmwmU4YTsM9vyhY5oPUZatX9jE
 O/bCGjX+qt04wlvNRZyndCFFqD6PNy4tAKj+i39RzYDhhbCDkjJLiKsKABkRMWstkp9q
 lYdHJO83kMdIaLJchwrxFW1g2thSMf7kggW0V30NRd727TP5LiZ9YN+QpAYAumZpRejT
 35MVgRGnAcQGV+Zurcu4Ik6JG/wYflv20i/p6Rqu8QvENxL1QkSJd3t7e9+Pk/yU9eTp
 8lMr+n9uR7xmQ25ZjxmeVwcJ9jqexdHBHWx+Ddw8FNKKF6HNjVwjP2ciuYqbaCTANaWy
 ndmw==
X-Forwarded-Encrypted: i=1;
 AKwUvByVfxmLpOxa+KvdUvzFa7WIlU4jKPf7q/BbFpQFZbwkQZf+mzwwxw1GJGnGsfi94r/gKQuLc70=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJGRxuhNyC5aHxHG3Q1PX1yRENliJ0I4iu0DxKq0Hrvg0e8/9+f
 30U4fC0UDsenUP8rphv5PZ89G19+I4i4qc0JfmtB7Ne6ey6JAOkfHvRn
X-Gm-Gg: AYBFou0osycuuXm8mioATkT0U53sV4duEV89JsaVo+/R8ekCDM5yP4EVgHVEKt3cjjJ
 FMkRySx9hG9fVMsaSxxsEu6fcfoy6Y0TtBoTEw14OecAhbCQvdln1nnvfDFcss+nB5IO8+Rb5q9
 LiIqwHcKe98AtIIK6rs+xlGNZlFliLQETtKe8vriaLzclWg0tUvv0DHykrCtTuoIrZrE7JjHU9O
 OmZx/bfyVAX3s9DDwaDm6IuhJ38ASYOIQgIh4tZnxjWHeB/sb+6L/iiRxJFuDVw0JNkPMJ7QwJc
 MDifQW/tFljG9c2VAPu0YfReQuueSMa7d/GBsJ+i9DmRraFms7qNq/+NDhBv1o+go+9ydFJJ/PK
 PgtRHYERH5RUbqGesUGx8+ud0ertzO2/pP+KJdP/DXtrge4UpUgOu+knRuoJZqMeUOeCO3zq1sB
 mHJRfX731Tn88d+seS14MttA11S0GaQmogMSm1bBi0dp9Slw4C0MXh9j7nzRq/lvVL2jc9xiCQT
 RrntzkQ9w==
X-Received: by 2002:a17:903:350f:b0:2d9:599e:df95 with SMTP id
 d9443c01a7336-2e84280d570mr140746215ad.3.1792007167554; 
 Wed, 14 Oct 2026 12:46:07 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422c9944sm73108435ad.64.2026.10.14.12.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:46:07 -0700 (PDT)
Date: Thu, 15 Oct 2026 03:46:03 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/3] virtio: rtc: Add virtio RTC driver
Message-ID: <as_b-1hWbg03DGOJ@google.com>
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

Thanks for the patch.

Actually, when I sent out the qemu virtio-rtc code, I also had a local
dirty version of the virtio-rtc u-boot driver, but it has been sitting
on my TODO list. I might take a closer look at this patch in a day or
two. This also reminds me that I still have some other virtio drivers
locally that I would like to try upstreaming. I might try to send them
out within the next week or two.

> ---
> 
> Changes in v2:
> - Look for the UTC clock on the first virtio_rtc_get() instead of in
>   probe(), as the virtqueue must not be used before DRIVER_OK (Bin)

I would suggest leaving more time between sending out new patch
versions to give people a chance to review and reply, which helps avoid
spamming the list with rapid revisions. We have folks in various
timezones, and many of them are quite busy.

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

IIRC, when I sent out the virtio-9p driver for review, Simon made the
same suggestion to add a timeout mechanism to the loop here to prevent
potential hangs. While it is true that many other virtio drivers are
currently written this way, it is on my TODO list to clean them up.

Regards,
Kuan-Wei

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
