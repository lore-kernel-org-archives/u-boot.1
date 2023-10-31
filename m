Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442F0C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 16:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83ED587CCE;
	Tue, 31 Oct 2023 17:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="i5KVuvDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E6887CEB; Tue, 31 Oct 2023 17:49:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC48D86E7A
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 17:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4da3=GO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1698770987;
 bh=8GmcS/WRZTLyE63+BUN7UABCrK2jxvgJwwVOjEO2t8g=;
 b=i5KVuvDfUcSXEThafZdZ4gtVcbY6A05eCPwqWRiKUgN2z3ERjncCjWbIpQ7t07SZrPwjLTSBJ
 v2/W0NUrA3XCEPvJTAzNj91VbEcjj49vNwl4W5zxRYi+ZaOKep1kfaBKaPHCL3Yebyjoj3sYunM
 Ty7eJD3YGyN4riHtIYtVOtpszDwtpau17GvZRdQVTdwhCFiNmwZt8XBrAbOTCAiQttSUOZj3QSW
 E8ujypijsrjkIrzGUmLiPROUfue1du1H4Fft2nkli9+ekgoIs+P5NjQQEofNB6i5st29/tPWGy0
 I78r/Avc+8QudjzqpFaGCJ1JTCcVWS3uAaTp0e5Ib2WA==
Message-ID: <3d718a4e-0977-4a9b-8b9d-dc0e01849c82@kwiboo.se>
Date: Tue, 31 Oct 2023 17:49:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: orangepi-5-plus-rk3588: Build SPI image by
 default
Content-Language: en-US
To: Slawomir Stepien <sst@poczta.fm>, kever.yang@rock-chips.com
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, u-boot@lists.denx.de
References: <20231031161327.1104885-1-sst@poczta.fm>
 <20231031161327.1104885-2-sst@poczta.fm>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231031161327.1104885-2-sst@poczta.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6541302a1b3114e65022cfaa
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

On 2023-10-31 17:13, Slawomir Stepien wrote:
> Flashing this image to the on-board flash is useful when you want to
> start Linux from a medium (e.g. nvme) without flashing u-boot elements
> to it.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  configs/orangepi-5-plus-rk3588_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
> index 0473699621..9af65026a0 100644
> --- a/configs/orangepi-5-plus-rk3588_defconfig
> +++ b/configs/orangepi-5-plus-rk3588_defconfig
> @@ -103,3 +103,4 @@ CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_ERRNO_STR=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y

This was intentionally left out from original submission due to an
unfinished discussion at [1].

Also note that this option is not added at correct position in defconfig
file. Next time, please re-sync defconfig changes with a make
savedefconfig generated file.

[1] https://lore.kernel.org/u-boot/b82c02c0-0a37-8553-f498-b03f85394d59@kwiboo.se/

Regards,
Jonas
