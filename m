Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DACCCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 19:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D46FD6063F;
	Sat, 17 Oct 2026 19:13:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E9r_sGohuBNv; Sat, 17 Oct 2026 19:13:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 63D8E6061E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792264432;
	b=bOAiQcTZdRpNHD7yRG4yjsgfK6m+mDOE6KEqWRn4eQm2ig2GHA3i8SrZwomAoZ2eUBcl
	 MMEqfTaJN4Q/LfXGCTba6pY1hps6EpawWHjLbAvbXRBjQHs/YgpGB2NuYjrnp7TgKOTSO
	 5oHhykSV7akt7jqUUP1OtiqbXTwxjtIJbYFFdmaFeStDigHpJDkWzeJDT+JQo43PDI/OT
	 3qB/la0rNldHTCCH8TBSUp3QJf8wodsXxcVRxtsddP7XG5n/iSgVPu2hPDjLdyZcuYfHl
	 mjJ/pmxJ+Rm1dNnbx/GEpvfSytE1OJ1+1YEG3UKlOjRzqebdA/ut7X9z/h3C9REb3dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792264432;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+qYLpRH6g149W89Hku6SlZNpcj3HpsRHD55wxIpuABM=;
	b=tR8W1zGFY4el4TJY7zKy4+yP9JEaSE8hhrCTuj6F9uM69TMkVntRovYB8VdF2LgKsYDs
	 rQTLoLHk0sAsy7EcekHnW+cmqxFdl8j5O7NSC0w78Dp+JmV5mhFC85ngM/mikez+XcxMe
	 lt1cOmicDXZ5eEYvxCB/oQVvhNe69mQ6RzDikrVJih9qCOxnsEZKZ8XDBL6umgMDm08Ve
	 pkJek2mB+HXPpQHY2qAnOzbmDQ56nphrDEdqjnbWatPKrJPZtwhJehjyz8vXCSp4EdPg0
	 KnsYIaw8DRSdZ/o1bp/u7MgCAV/UXjKlbMet5WDJf9Dm6UVRTYRHObm/UVt13z0fc2Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZyYNLEhs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792264432;
	bh=+qYLpRH6g149W89Hku6SlZNpcj3HpsRHD55wxIpuABM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R1oryPlt7T63uOSvfH/3NZyoZITffEoaxEk/vdbayQCEQUgDLsNgNQSsZ5IOjzH+A
	 cWM2KpJx0g2IML9Fz32UL31Za8MYdVrkDCMwK/JIvca0z92UvBcbE63DjnDyGwEl8T
	 Xd0VpJlSxFrUvz+hIcbAfMIXEiWHxrc0DLVxP7TbmfxmWQGPBLcd79O210Ks+wet/J
	 VzQOVs0a2Ekl/yMGwaFyhra95IYr1NC9glO4QrGWe7FZ+b4kZXOzAY55lv0z0ji3Oa
	 z4R1aWujTj1I69Gi6oEpSA3ionWvo35NmTjrAsMNCoQrAyndFl+qGvujoTlPzDpXZ3
	 t/GoriY55egZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63D8E6061E;
	Sat, 17 Oct 2026 19:13:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4C6D1AB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 19:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B1F86061E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 19:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0qAj2O00YCUd for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 19:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 78B3460615
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792264429;
 b=bgcVAs/EqQM2+e1gBzUPk0le2QsBSJvwtgS2auCNWfwNPVXFDTOg3LHVi0o790BNpWU/
 Cn8rJDzj6IWsZL8ic4z297rXOJrYWVBpQBOU/bDk3IJMwgLGPHF9jyaR6ETIw7NLMpOtj
 1cnuYtA12ZvpYJsvn/S8Sih7woyw0pdakKifi3nJiKDOiIp37ZUlynm9ptpTTgoEAtMSs
 B46Xj3H2/XJW5Pe38HkLTkSVk+F5l2Kxfhe35uqiDNDf6nQ53h0GjYsk1T8ULgh2MKQ1+
 UUX1JGgKLdFvgLlHvoVitgYE9bz7HHZ5wNyzYnWFlosc23BiRGb8Ga4ANoqAr899WYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792264429;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=+qYLpRH6g149W89Hku6SlZNpcj3HpsRHD55wxIpuABM=;
 b=LxW6GqkMH7UT/fPKeOAWsPwKONPFZQsEjodFsb9c95hBIpv7otaHKftVovR/By5Rbgc7
 wHIE7n1VK0QY1/0YhFwz/D0sKsMSC/UBKh1/32GoQZKrGSX0x3O5Z0XJK+9y0hW1nu19Z
 cljG+b7Jag0ba2UwYj7SDnFxMaLn3nB6kGJJWy+EW11AJXr4MrfYViKxoqCoH/EOJZj9N
 zQn0GXe4J/vncHl1le9mJi18IG7CvjnpH+JS2Wq4gzS8SghlJJS0N2zan/oYhTynXOp7i
 UPs1cTIBY0esPozpKYRIWhhmFVbtDlK6gscYVU5KLXO6Kthi+U82tmpzulUL8ZyrW8Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZyYNLEhs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZyYNLEhs
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78B3460615
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 19:13:47 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e985106c0cso5969505ad.2
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792264427; x=1792869227;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+qYLpRH6g149W89Hku6SlZNpcj3HpsRHD55wxIpuABM=;
 b=ZyYNLEhsNF1c5DuwFrQQc1/YlqKzNTrSK0HFcsamTiUAyQgrISaGywwnw14G5DUuDt
 xTc3oQJBPW7yGav9JTDiIZxf12OTi+JUDYYOR1WEUl7txidSMdcMbhTd3l5eu28QpIER
 mrGz/TVnHkV1qHEi2XwP+K5toPylFTao4mBySPyycPMljHITUCneMAKHNFrWPJnCYLA/
 ShAthzU9cSQm+GOrlse5MpQSLXL9A688P4jnawG6sf52kDQ1uIwNcfkGK7zxNnj0BmtO
 xz8ovtB2qsvsMTODheR4k2bEq5PApQitXoZuH2tfGCW2vacCQtuMcw7FZWkfgxb44jmC
 k+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792264427; x=1792869227;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+qYLpRH6g149W89Hku6SlZNpcj3HpsRHD55wxIpuABM=;
 b=N2rU7Espu0OvpprJmf8s+4AXfp2EPsLguxSWobYAcDCJBT4LhpLambEb3R2ypMSHQI
 5mJbcOykDWe9cDknn5etqeUa0WWiT4HgdnFSKbJOafi8UxZ2evOOXLzHa14FOHCWOud4
 sGslDvEmSqijfmpqT+eGMwr4fBbAZoReon98nxsTnfc8EI2yx7RoqzNMNu92Ju0b5EXV
 yYwQTtXz2rxkqmpnLwUzoJbUuc96Gw5iboXHXTqvY3+IIncVPgRUCxOI3jziONl2azeo
 8NkfcraEYbZ5BKLOQUuFkr0JQLpsTqHEidw0uKhv5Ab0X2fzd5Lr2cwGM3zeb3byAeml
 2kdQ==
X-Gm-Message-State: AFq9FYLrOw2Z2kE4iOl8Icg19taADF3gI4yLQGL5IyGhD+xx7AnIU1na
 gt0pkUoh4F8mtcEwuxnwR99vUIXRFHlpsjivzFLm65nalcxnyMvRKEgW
X-Gm-Gg: AYBFou1aq6E6BRhAeuSraidioBhs1WyKxA/ya2ndEIMVCTFJ4OIyYjI68bl5DwBmUvP
 L0B8/iujs+qA2T7xqXZOURxMywJfTan2SGJ6R62l9dacURVj8XBxCApVBg/2gpDApCqEN4zYWh7
 FO1pcDTN+ah4vr7FausDJHVmnYRIfcH6qMz2sWOTkrwkj3TwjKAMDsER+PzKURcO4kEXBd8sOon
 HIKDuXQ/5rgPwFCbpmPbsftiTBwW8MtKo5o9HzxDEGbQC8PP/NY8DZ0/NS78S9DQ3rUQJ7d99q7
 +eElo/wk90onczf92Sh0O3/jyHvZZPLaYXT46Kl3dJYuW/P1vwmjU3wzzSqT/Hg+fFbqPb2N6PR
 2SsvPEIwbKuVXDQOymzthGvZLdjt1LYHOQsPuP7sulRii9/uV1tn9O42QeBEOpfHfY43jBOOUtb
 Sy333c0VZ5teVpsgpas5HyCODZ15BbL2W0h0iZ0GaU2vpT/iKwXuCGB8cr2x9NaryrNH+m8huAm
 4xpXJFBy1LCAa7NYkLPkSxf+RGIvwd1rT1mxoTOIQkZVQ==
X-Received: by 2002:a17:902:f606:b0:2dd:b795:9cb6 with SMTP id
 d9443c01a7336-2e9a6d1ea96mr32423665ad.21.1792264426451; 
 Sat, 17 Oct 2026 12:13:46 -0700 (PDT)
Received: from google.com (61-230-12-185.dynamic-ip.hinet.net. [61.230.12.185])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e804d92sm23396785ad.19.2026.10.17.12.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:13:45 -0700 (PDT)
Date: Sun, 18 Oct 2026 03:13:41 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: Re: [PATCH v3 1/5] virtio: rtc: Add virtio RTC driver
Message-ID: <atPI5SKH7ZaiytQ3@google.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
 <20261017184622.3925389-2-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017184622.3925389-2-alan.tseng.cs@gmail.com>
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

On Sun, Oct 18, 2026 at 02:46:18AM +0800, Hung-Chun Tseng wrote:
> Add a driver for the virtio RTC device (virtio device ID 17), which
> QEMU provides as virtio-rtc-pci and virtio-rtc-device since v11.1.0.
> 
> The device exposes its clocks through a request virtqueue. As the
> virtqueue must not be used before the virtio uclass sets DRIVER_OK,
> which happens after probe(), the first read looks for the clock: it
> asks for the number of clocks with VIRTIO_RTC_REQ_CFG and queries the
> type of each with VIRTIO_RTC_REQ_CLOCK_CAP. Reading the time sends a
> VIRTIO_RTC_REQ_READ for the chosen clock and converts the nanoseconds
> since the epoch with rtc_to_tm(). Each request gives up with
> -ETIMEDOUT if the device does not answer within a second, as virtio_9p
> does. The clocks are read-only, so there is no set operation, and the
> optional alarm feature is not negotiated.

This is a bit subjective, but my feeling is that this has become
somewhat too verbose. Ideally, a commit message should explain the
"why" rather than just stating what was done. What was done can
basically be seen directly from the code changes themselves.

Regards,
Kuan-Wei

> 
> Like Linux, the driver prefers a VIRTIO_RTC_CLOCK_UTC_SMEARED clock.
> Linux registers an RTC class device only for such a clock and skips
> VIRTIO_RTC_CLOCK_UTC and VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED, which may
> step on leap seconds. QEMU, however, exposes a single clock of type
> VIRTIO_RTC_CLOCK_UTC, so following Linux strictly would leave U-Boot
> without an RTC there. If no clock smears leap seconds, the driver
> therefore falls back to the first UTC or maybe-smeared UTC clock. A
> leap second step matters little to U-Boot, which only reads the time.
> 
> Like Linux, the driver stops looking for a clock as soon as a request
> fails. After a timeout the request is still on the virtqueue, so its
> late response could be taken for that of a later request.
> 
> VIRTIO_RTC defaults to y when VIRTIO and DM_RTC are enabled, like
> VIRTIO_RNG does for DM_RNG.
> 
> If none of the clocks is UTC, the driver remembers it and fails later
> reads with -ENODEV at once, as the set of clocks never changes.
> 
> Tested with QEMU v11.1.2 on qemu-riscv64 over both PCI and MMIO.
> Sandbox tests, which emulate the device, follow later in this series.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
> Changes in v3:
> - Give up on a request after one second instead of polling forever
>   (Kuan-Wei)
> - Remember that no clock is UTC, so that later reads fail at once
>   (Simon)
> - Expand the VIRTIO_RTC help text (Simon)
> - Drop __packed from the message structs, which are naturally aligned
>   (Kuan-Wei)
> - Prefer a VIRTIO_RTC_CLOCK_UTC_SMEARED clock as Linux does, fall back
>   to the first other UTC clock, and explain why in the commit message
>   (Kuan-Wei)
> - Stop looking for a clock as soon as a request fails, as Linux does
>   (Kuan-Wei)
> - Mention in the commit message that sandbox tests follow (Simon)
> 
> Changes in v2:
> - Look for the UTC clock on the first virtio_rtc_get() instead of in
>   probe(), as the virtqueue must not be used before DRIVER_OK (Bin)
> 
>  drivers/virtio/Kconfig         |  11 ++
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_rtc.c    | 249 +++++++++++++++++++++++++++++++++
>  include/virtio.h               |   4 +-
>  5 files changed, 265 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/virtio/virtio_rtc.c
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 55b444280..48ab669f3 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -84,4 +84,15 @@ config VIRTIO_9P
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
> +	  This enables the virtio RTC driver, which reads the UTC clock
> +	  exposed by a virtio RTC device. QEMU v11.1.0 or later provides
> +	  it as virtio-rtc-pci and virtio-rtc-device. The clocks are
> +	  read-only, so the time cannot be set.
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
> index 000000000..806abe237
> --- /dev/null
> +++ b/drivers/virtio/virtio_rtc.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> + *
> + * Driver for the virtio RTC device (virtio device ID 17). The device
> + * exposes one or more read-only clocks through a request virtqueue; this
> + * driver reads a UTC clock, preferring one which smears leap seconds, and
> + * reports it through the RTC uclass.
> + */
> +
> +#include <div64.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <rtc.h>
> +#include <time.h>
> +#include <virtio_types.h>
> +#include <virtio.h>
> +#include <virtio_ring.h>
> +#include <linux/types.h>
> +
> +#define VIRTIO_RTC_TIMEOUT_MS		1000
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
> +};
> +
> +struct virtio_rtc_resp_head {
> +	u8 status;
> +	u8 reserved[7];
> +};
> +
> +/* Request for VIRTIO_RTC_REQ_READ and VIRTIO_RTC_REQ_CLOCK_CAP */
> +struct virtio_rtc_req_clock {
> +	struct virtio_rtc_req_head head;
> +	__le16 clock_id;
> +	u8 reserved[6];
> +};
> +
> +struct virtio_rtc_resp_read {
> +	struct virtio_rtc_resp_head head;
> +	__le64 clock_reading;
> +};
> +
> +struct virtio_rtc_resp_cfg {
> +	struct virtio_rtc_resp_head head;
> +	__le16 num_clocks;
> +	u8 reserved[6];
> +};
> +
> +struct virtio_rtc_resp_clock_cap {
> +	struct virtio_rtc_resp_head head;
> +	u8 type;
> +	u8 leap_second_smearing;
> +	u8 flags;
> +	u8 reserved[5];
> +};
> +
> +struct virtio_rtc_priv {
> +	struct virtqueue *vq;
> +	u16 clock_id;
> +	bool clock_found;
> +	bool no_utc_clock;
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
> +	ulong start;
> +	int ret;
> +
> +	ret = virtqueue_add(priv->vq, sgs, 1, 1);
> +	if (ret)
> +		return ret;
> +
> +	virtqueue_kick(priv->vq);
> +
> +	start = get_timer(0);
> +	while (!virtqueue_get_buf(priv->vq, &len)) {
> +		if (get_timer(start) > VIRTIO_RTC_TIMEOUT_MS)
> +			return -ETIMEDOUT;
> +	}
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
> +	u16 num_clocks, id, utc_id = 0;
> +	bool utc_found = false;
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
> +		/*
> +		 * Give up on any error: after a timeout the request is still
> +		 * on the virtqueue, so a later response could be mismatched.
> +		 */
> +		ret = virtio_rtc_xfer(dev, &req, sizeof(req), &cap, sizeof(cap));
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Like Linux, prefer a clock which smears leap seconds. Unlike
> +		 * Linux, fall back to the first other UTC clock, since that is
> +		 * the only kind of clock that QEMU provides.
> +		 */
> +		if (cap.type == VIRTIO_RTC_CLOCK_UTC_SMEARED) {
> +			utc_id = id;
> +			utc_found = true;
> +			break;
> +		}
> +
> +		if (!utc_found && virtio_rtc_is_utc(cap.type)) {
> +			utc_id = id;
> +			utc_found = true;
> +		}
> +	}
> +
> +	/* The set of clocks is fixed, so remember that none of them is UTC */
> +	if (!utc_found) {
> +		priv->no_utc_clock = true;
> +		return -ENODEV;
> +	}
> +
> +	priv->clock_id = utc_id;
> +	priv->clock_found = true;
> +
> +	return 0;
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
> +	if (priv->no_utc_clock)
> +		return -ENODEV;
> +
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
