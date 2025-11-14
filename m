Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F2CCE8D52
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05998425F;
	Fri, 14 Nov 2025 17:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BeSLSn4P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564C4842A4; Fri, 14 Nov 2025 17:49:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC318425C
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=890f=5X=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1763138988;
 bh=WS6Lrkj1f6NE7Kykui/NpzsCyOx31o7BV4uUwmoiypY=;
 b=BeSLSn4P83VPO2nB59yI/OS3mo4qC6bba91WCI5mX/NDAwIy5a8Fg/COEAFmzskgiia8m1dUt
 O50IoO+yNNYtKZSruDSv2VLebJATwEmfAZo9XHyLc/kNS6N5n9SR7U4I0uoLM9i7ccOfEW3cOd5
 ZswSPid9WNHUlfknio5NPQwszhKDrRYxrvbdBggJ4CHKtR2N9bbzjM3opl7oUXv4ahbP3CCbBwr
 bPIG90jup578QVMEt9dmLlNaYyWq424Y04e+f6fi0vtRMxsqq2Gwq7MuKvkfmiZT2+SUUlCB8+z
 dI9LtYjwClB7XYgKHR1kmVgMuCn1+Z1zaIt5ah7TMtyw==
X-Forward-Email-ID: 69175da5d912600103b51ede
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.4.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5624c4db-561b-4775-95b2-18aa2bfe84b7@kwiboo.se>
Date: Fri, 14 Nov 2025 17:49:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] configs: enable PREBOOT, CMD_ENV_ERASE on Rock Pi 4A
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Chen-Yu Tsai <wens@csie.org>,
 u-boot@lists.denx.de
References: <20251114162859.152980-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251114162859.152980-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Heinrich,

On 11/14/2025 5:28 PM, Heinrich Schuchardt wrote:
> Without pre-boot command usb start it is not possible to stop the boot
> process via the USB keyboard.
> 
> CMD_ERASEENV allows to easily reset the environment to the initial state.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/rock-pi-4-rk3399_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
> index 219f42bc7d4..6cf80e7fa5e 100644
> --- a/configs/rock-pi-4-rk3399_defconfig
> +++ b/configs/rock-pi-4-rk3399_defconfig
> @@ -22,6 +22,7 @@ CONFIG_AHCI=y
>  CONFIG_EFI_CAPSULE_ON_DISK=y
>  CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>  # CONFIG_ANDROID_BOOT_IMAGE is not set
> +CONFIG_USE_PREBOOT=y

Please do not enable PREBOOT in defconfig, this will create an
unnecessary boot delay of a few seconds for normal use. Instead please
make it more clear in the documentation on how users can enable use of
USB keyboard e.g. using environment variables or in their custom build.

USB is also auto-probed when nothing can be booted so if I am not
mistaken USB keyboard should work at end of a failed autoboot.

Regards,
Jonas

>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_SPL_MAX_SIZE=0x40000
> @@ -31,6 +32,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>  CONFIG_TPL=y
>  CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_ERASEENV=y
>  CONFIG_CMD_NVEDIT_EFI=y
>  CONFIG_CMD_DFU=y
>  CONFIG_CMD_GPT=y

