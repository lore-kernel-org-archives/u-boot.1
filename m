Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A352C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 11:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8BA88A7D;
	Wed,  1 May 2024 13:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PjgLxDro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7AF188AA4; Wed,  1 May 2024 13:37:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25FF88A77
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 13:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1714563450;
 bh=BiyGFFSJIo4dZISneaX9mNrF028HwuBlg+j1nB30UU0=;
 b=PjgLxDroCuPscKav8CADcvW1Z/08Eg7QAbUk4aXHDyf+JOM8Xs50CViNit01EuyAbW23Uapwc
 VkRvamOn3MZKH8rgm2SotzIcBqjSM5lmM4trd6jvaKVEV0PxR229br9Gqodxr9aTwrJJvqrBlcc
 QOCiQK9HOadinOvj6gWj68ljKAoyPFbIX9UiztogHnDTrlSDM9PKiMjKDPQjpoH6Tf9MuLyGobk
 WmWflfu9wnJIlnbdA+hdf4USm0LE7uoxC+vHydx6Q+tzjlv/vXaoJV95pWIHubDghE4iXPUo5N9
 dOyY15H2pUwNhRm1ixHVflxWI6W4xHvnNPamcaUmseQw==
Message-ID: <3a19b2e9-e451-4da9-b561-fa4a4788d662@kwiboo.se>
Date: Wed, 1 May 2024 13:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/31] rockchip: rk3399: Enable ARMv8 crypto and FIT
 checksum validation
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan
 <andy.yan@rock-chips.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Christopher Obbard
 <chris.obbard@collabora.com>, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-5-jonas@kwiboo.se>
 <758118bd-e7b5-43ad-a9b5-4203afc058f2@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <758118bd-e7b5-43ad-a9b5-4203afc058f2@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663229788353c369f638b84b
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

Hi Quentin,

On 2024-04-02 15:22, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/31/24 22:28, Jonas Karlman wrote:
>> The RK3399 SoC support the ARMv8 Cryptography Extensions, use of ARMv8
>> crypto can speed up FIT checksum validation in SPL.
>>
>> Imply ARMV8_SET_SMPEN and ARMV8_CRYPTO to take advantage of the crypto
>> extensions for SHA256 when validating checksum of FIT images.
>>
>> Imply SPL_FIT_SIGNATURE and LEGACY_IMAGE_FORMAT to enable FIT checksum
>> validation to almost all RK3399 boards.
>>
>> The following boards have been excluded:
>> - chromebook_bob: SPL max size limitation of 120 KiB
>> - chromebook_kevin: SPL max size limitation of 120 KiB
>> - puma-rk3399: SPL stack in SRAM and TPL+SPL combined max size
>>                 limitation of 224 KiB
>>
> 
> I think we should move the SPL stack out of SRAM, thanks for hinting at 
> this. This is clearly something I missed when migrating Puma to TPL+SPL 
> as all other devices were migrated way earlier than this board, c.f. 
> https://source.denx.de/u-boot/u-boot/-/commit/f113d7d3034672de7d074506a05a7055f1f0dcae 
> for the default address.

Great, I included a patch in v2 to use same bss and stack addresses as
most other rk3399 boards.

> 
> Considering that SPL_MAX_SIZE is set to 0x2e000 (184K) right now, we 
> should fail if we reach that size. But I couldn't with applying the same 
> changes as in this patch, is there something I'm missing that prevents 
> this from happening on Puma? Just trying to figure out what we need to 
> do to not stay too far from most RK3399 devices :)

Sure, I have changed to not exclude puma in v2.

> 
> """
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index c2aa02ec74b..f3d23fa3f11 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -21,8 +21,12 @@ CONFIG_DEBUG_UART_BASE=0xFF180000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
> +CONFIG_ARMV8_SET_SMPEN=y
> +CONFIG_ARMV8_CRYPTO=y
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_MISC_INIT_R=y
> @@ -115,4 +119,5 @@ CONFIG_DISPLAY_ROCKCHIP_HDMI=y
>   CONFIG_BMP_16BPP=y
>   CONFIG_BMP_24BPP=y
>   CONFIG_BMP_32BPP=y
> +# CONFIG_RSA is not set
>   CONFIG_ERRNO_STR=y
> """
> 
> (not booted).
> 
> Additionally, I think I should be able to bump SPL_MAX_SIZE to 0x30000 
> (224K offset for U-Boot proper on MMC - 32K offset for TPL+SPL on MMC), 
> don't you think?

Not sure what the best value would be, if I am not mistaken the 224 KiB
limit is for the combined header+TPL+SPL (idbloader.img). A quick test
build show TPL to be around 52 KiB, that leaves around 172 KiB for SPL,
the SPL binary currently only take up around 132 KiB. With CONFIG_LTO=y
build output shrink a little bit to 50 KiB + 117 KiB.

I did not include any change to SPL_MAX_SIZE in v2.

Regards,
Jonas

> 
> Backward compatibility is a PITA :)
> 
> Cheers,
> Quentin

