Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5984C4167D
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 16:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC0287CCB;
	Tue, 31 Oct 2023 17:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rElSnWT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE10687CDD; Tue, 31 Oct 2023 17:45:18 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0534C87CC5
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 17:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4da3=GO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1698770707;
 bh=cs4YGb256QtdQUwHn6F0JjJHjnKSf7koySgRagLJ8A8=;
 b=rElSnWT54QgZGZ9kwk9sXFVLYLM1aQDRsn3Bj9h8erUQRGrPqncWKc83TJO/NO1ACRvajs4Wo
 RnKBS8ohtYUKNwOI9NGGaE93yFhxzrLXV/RXHXZDiXtqdIMxtXyg+3pvd9cjhjBRnmDPuCgf9DR
 q80ds7C9ZG+KXD7IGpZ1nIP4HwLIxXXCjjepIbOFhAelLaMp+zzGT0QMs5i+9qs4ipI6owpX86D
 OzPgwWgmqDOWCAQbEfWO33A2F7HQIc31KWdISmlB9Hg1sVvi+gmtjTubCT875qXCMEOKZRM48Ho
 3HlxdHsizKdeToiQQZXjysUboKFWaN8dx6JlLRthrfZg==
Message-ID: <775cde64-e33d-48e8-907f-6dbc611a3a50@kwiboo.se>
Date: Tue, 31 Oct 2023 17:45:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add SPINAND as boot device
Content-Language: en-US
To: Slawomir Stepien <sst@poczta.fm>, kever.yang@rock-chips.com
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, u-boot@lists.denx.de
References: <20231031161327.1104885-1-sst@poczta.fm>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231031161327.1104885-1-sst@poczta.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65412f12546a1d1fe79cec87
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
> Mark the flash@0 as BROM_BOOTSOURCE_SPINAND.
> Fixes use of same-as-spl in u-boot,spl-boot-order prop on Orange Pi 5
> Plus.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  arch/arm/mach-rockchip/rk3588/rk3588.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index b1f535fad5..0c8f10a97c 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -42,6 +42,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
>  	[BROM_BOOTSOURCE_SD] = "/mmc@fe2c0000",
>  	[BROM_BOOTSOURCE_SPINOR_RK3588] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_SPINAND] = "/spi@fe2b0000/flash@0",

This is not correct, please see [1] for an open discussion on this issue.

Kever: Do you have any more insights into the question on [1].

Is my assessment about the value BootRom writes to bootsource reg
correct, see [1]?

- FSPI (M0): 3
- FSPI (M1): 4
- FSPI (M2): 6

[1] https://lore.kernel.org/u-boot/b82c02c0-0a37-8553-f498-b03f85394d59@kwiboo.se/

Regards,
Jonas

>  };
>  
>  static struct mm_region rk3588_mem_map[] = {

