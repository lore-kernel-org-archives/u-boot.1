Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31661CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 19:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7BA560628;
	Sat, 17 Oct 2026 19:06:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NH7qBnCwCg2j; Sat, 17 Oct 2026 19:06:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 690D66062A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792264017;
	b=nQh35r1v/Rbg1aKmoKCHVNDJi+jgpkuZPFz61li8dYm50r2k5oOzQHEJaXifrzEMmMQu
	 WczZSkKjKku6Ft9b6Q013DAxO8UD9rEpLojJEpluR9AriMZGAwl8So9NBz1V5RponJFwT
	 wqeUOVUD7Z6Yq5LtsGz02nDLH1Kbf2WLdGbNIJe1y4pPtUj4zinLhGosFnsqTZ7hrBQHz
	 d8ZZ14EsYWjQdVzkIr5UvEZitjhVLJj34t386roA1MlBYfoaLeD/kVrkKllOP3KJjTCiA
	 5lyObDFUzgwyLIWGdrRIlu0U1/iVJlm4UjL8T+y1zyd2FA+Dy2YNAcC9bPYblmvqOxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792264017;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Gt40CGmtBw8PL1TLOsgqy0w3vlP6sgsQalJWQ+Tfv2Y=;
	b=ZE7MNRcqnCdlAJNgpZpo4nGc0Ph7W9WuM0gTctY0xJb5FsQ9yzNnwcwI01IQZE5vV65H
	 dN8Gnb/e67j+o0nRRwkSzk8uifx/YwD/OTvPAFDkshlQWdhljRO/qucjHu6056noTFiM9
	 tAn3/LqvoWnJyCcIpb1WbnCyV1H3OAl12HdGpTDHaUe2YXzZxn9y2yBjY0OXAYeS+l13x
	 U5Zwhr7R8/XAp3tGAvdYahILHVCIXMAWdkIgwx3VCvTl7OTKBHLy9pwIELzk941o8eAnV
	 vKR6HUYRDCO4CpIFya5z2+3+K+c1INdrC7KjWHCBKk9gmzwIQNnMStxZcX5UE5KET1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792264017;
	bh=Gt40CGmtBw8PL1TLOsgqy0w3vlP6sgsQalJWQ+Tfv2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nL/bmQeKR+QHy9xKzl0cTr0ZNvFcL1MmHJb39AfaRO65l+i6G63V1rvfkxkPfyvrP
	 FTERbn4kQ9hLOplrWYNbal0hPSclMoKD3XK0VmXpE1Ex3neCTjnKg4rSFuZNx1VqO+
	 pcF8wX1cWWDaaPeJ9MK/j3OGfiAcY02xnzwBUdqSxiF3SUvVKsaozvi/TxzlZmNYKt
	 qQvVtLzRfHdzQ3ENCvvn+6GZKwXuoybwiNZmY89y+3iAcAK6SGsDAXFL+aNSYPxT7j
	 Hm2TNZ8Bui+ZXXZ+hM6FxdkI28lTr/Ov3nUsQcGqL40DRybs9aMEdhUEuojir/bcYZ
	 +1fqaZDsUYzcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 690D66062A;
	Sat, 17 Oct 2026 19:06:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BDE91DE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 19:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5B79408EB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 19:06:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJtSuk0AxJ1s for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 19:06:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4A194081E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792264014;
 b=tdk9tGGBECNMGfR7tcTjVwLVdiAoQLCm0xVMctxYp8Doj18qInRDkq1ifkUE9ZEwrOx7
 YZT3fM1zvbrte9HAoaDxpLs/PwMblLGNPpDIhbt/f2vf8Mo9QA0vsyt8vd2usoitdLBtx
 3mBHEogv/fNzljZvasVJe20t03SYZ5MIPkkY5QA/lK3L7mUEd8/x7Iph1aUmxM4dEwYZU
 9S8Tc0uJcEPjVlROshGcjZOTanQy/5p4gTfFXD0/oyHUSZnN8mQn1g9drGkeORDm6ZcfH
 Cqbm94r6ekuVqnHacilqfgDnQ72ajGRheOIow+9BN/JY5mt3I2WNQp9cIlFCa56CLrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792264014;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Gt40CGmtBw8PL1TLOsgqy0w3vlP6sgsQalJWQ+Tfv2Y=;
 b=efoi4EwcCZKRW7POx+LFw32Ht7DDDmyBOUu1KX8Pc45UZf7Nt6+AEFNCkG/mKXrcWaL4
 tCNm8aQV3tEXtdTJlrlDTFXM9G5yBQVdtvMe7Z6vlDc45k3nxrQGOrLaBRCWDPeW+tsjZ
 vEJZk4Be0kQWaX7MS+J+YvXQ5pHkbCR71NSGJjvgkk6O3PBT+KqlePNLybkm3gNz1SNFG
 RHCPurM45EmRkfCMj+dHoC8glVvbroVFaD3M3+iqG8oBf9eum6P0ljr8ItS0ODpn+Tjeb
 gyiRt4R83Iu29sTqAdrEahYbHXHdKcMVJj1qO/Fs7/w5DauwxbM7KC7qwhooemNlhLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bv+ywm84; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bv+ywm84
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4A194081E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 19:06:54 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ccce6d9abfeso676583a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792264014; x=1792868814;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gt40CGmtBw8PL1TLOsgqy0w3vlP6sgsQalJWQ+Tfv2Y=;
 b=bv+ywm84WsGJDNpp0MZN7ZViKFSMMx1wyc58leXLWC7khkaOl+uSgH8HODA8d1flUq
 2dk5/WzKdV8fCiZ8KJt3FUEDD0INo706MFGI242ia1psIHl3Jk6WywgVdPrLx35RUKjA
 MhIRn1JUWd/yDffKgEvYBpXWTuW03wo+1Nmgy+0hgZBSqzND2dbWX0w9PFtMEtztayoy
 l5F5Vc1iSxu308rbafgFttNrvVDuF2NdjUyynts0JEsrtrXFwlj+nuiZd2AmroKQsTPw
 oviy5h7au2mYk5U/UrBKjH4REcDMkv4Awh/Amz/RScn64Bt6voTQuxQRgtYV+B9zc/Sy
 Qa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792264014; x=1792868814;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gt40CGmtBw8PL1TLOsgqy0w3vlP6sgsQalJWQ+Tfv2Y=;
 b=kU/aBfe0vmdT5saVv5mo5dwHPLhV2SBt1p9VU4zTarShAe3LC+5ln1Yi6AwyTPRovS
 oNbwDj+8G4cewCASf3BYGLYlQmyBMcgHQuzYNR/W82U4VQ55GrjHYd53///YR9GUHaTO
 K+ktxT/5yQ9FrM59RbmLlMd8QehgGfjdDaeNM14JglLU2Nsbe/yl7n7YDROXxBPhF+hn
 8GScZZmYLYDOi9OEDUt5Y3rFn7hv2wAQiYILTxVszZcGFd7BEarJ12tRk2En6AfyaC2+
 hoPtkD2AvNUEChdO5xsySU2sU9k4mZxbj3LA0zhidXb4hRBo8xx9ObDCCvRX7AoWafME
 OvGQ==
X-Gm-Message-State: AFq9FYINwwk8Ip3mNDx1HipOQESdr7j11BzOol6cfJGq0d5rh00QBVe1
 oRgGn1RUVVfJimZ2QFB/6Vold3+NCqJ4S7Vnw7OnDoCAXJ2OTa5BZ+Hw
X-Gm-Gg: AYBFou1UdT7CDvNf/zamFgDBE5E8rHeVx15iJ6zyP0Rec7drUixHC/D5kNwSWK4yhNa
 2niTMfnBwwtoJUceCATKyxHW/aQ36fq8DI0YhunPr8OCkWkREbRNQoUC4iCC7M2apC8njG/3880
 /SzzvZQ07PFogvKnZ7SV1kviEGsM1OKXqzoWZwN8rzy64B4sYRN3JL51JCa9zAW+AbCm12ICtOL
 PRuA5uLqubUvESEm0FNNnyd4RzITfLIr0qezW5hEPot/MUdGBGzyrYLYtUkpfrhhY5mHEQspmSg
 s5xTuyPUairbsoq8VgOI5b1gpEltix5JkFElPOvNZ7UFnh3tWiYua8B9cSRq9vsy4Zc+2Etny9M
 pC47UOek9v7M2eBmhHsmzpLba+xRBqz+49sBU7qrNpMoX8sA+sWygMBMEFwqMBuA+oywiI3ZC9K
 VA1OFjhs6ytQWxvWUR4VK83xEpvS+8SSwgwdHyRGugXJxcuBAwPrHpIidRk0ooqlz/3XxKG5Xf6
 Jsu777x32xgCyVYaNl64WUHtMVz2wiXdA==
X-Received: by 2002:a17:90b:4c85:b0:3ac:a7ee:6770 with SMTP id
 98e67ed59e1d1-3acee728d2dmr3074791a91.7.1792264013545; 
 Sat, 17 Oct 2026 12:06:53 -0700 (PDT)
Received: from google.com (61-230-12-185.dynamic-ip.hinet.net. [61.230.12.185])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac947928b4sm13648324a91.11.2026.10.17.12.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:06:53 -0700 (PDT)
Date: Sun, 18 Oct 2026 03:06:49 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: Re: [PATCH v3 1/5] virtio: rtc: Add virtio RTC driver
Message-ID: <atPHSR9xEbKuIuV5@google.com>
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
> 
> Like Linux, the driver prefers a VIRTIO_RTC_CLOCK_UTC_SMEARED clock.
> Linux registers an RTC class device only for such a clock and skips
> VIRTIO_RTC_CLOCK_UTC and VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED, which may
> step on leap seconds. QEMU, however, exposes a single clock of type
> VIRTIO_RTC_CLOCK_UTC, so following Linux strictly would leave U-Boot

This could confuse people who are looking at the current upstream qemu
code, since my patch [1] has already been merged into the qemu main
branch.

[1]: https://lore.kernel.org/qemu-devel/20260831190612.369235-1-visitorckw@gmail.com/

Regards,
Kuan-Wei

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
