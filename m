Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84304C54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 17:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D30487F10;
	Thu, 14 Mar 2024 18:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yojT2Qwm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jj1r+nHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8188E87F5E; Thu, 14 Mar 2024 18:36:34 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 735AE87F40
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 18:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TwZLS0Rmlz9sWd;
 Thu, 14 Mar 2024 18:36:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710437792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5jtqCnq30vz9TRazsrf9MVZAi2cOL/pgi2PIEG1a7M=;
 b=yojT2QwmYA4i40HdTr7Ku0kN1ZsmgaK7L71Ns6WpKLMIT2XZww4cYGtN2dufRPjW+6XwWM
 xRTvw/1UhGI8Xy+6FWiVmtvbC5zU8ufyO/E3o3ctjwCxW6PDjy949vkMLFvPQxuQBt5knJ
 Pb6eFnWEESFA2YxSSGCLJErqFmkvyETp+yovvJgaZawafvQT1p6afB/u5V54GoxNE1X581
 UQL6hcLMpgweGRhBeLMtPeb0jz+ee0sVpylHsTPU3L5/WtsS3R5k4ojrQGUEx9S6SoUpo3
 2KyXDS4s7unpeF1qIKeUIm6wM3AsU7GJEdahMIcwMQBvgwQN2LQRlTj5Q2xTqg==
Message-ID: <1752c62f-555d-451e-bc1c-17dc9c7697b7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710437790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5jtqCnq30vz9TRazsrf9MVZAi2cOL/pgi2PIEG1a7M=;
 b=jj1r+nHDw1JOxFpo+IiWo443miA8mxsGUhATocNz0sxtntqoap+GsCzpV9y6PW8Cbt8td7
 X4ngONO0ZPIMecqifALmJFXYzeRyuNjVQm105361qfwdCXo5n2MdeBJULbNJ6dCJ67Vi4e
 r8udHZ4qq0O5HFCaMTuXcyW1v1Xo9PGvMWjP8ABFRR0qD4bNeWtkhiglaVl2J+fDXXMswE
 LOtsHkOJUTBS09z9FuhEPG9l/X0S6kY2LBgSeIn0eGXxEWRWQh6zGAZIJ4wXztWeeFlvlW
 UuGg8WCsxFNyau42tAQ9jPXJB0xFLuCMXKDrxcpBHV0pRYiXun9zO9LYeuDGaQ==
Date: Thu, 14 Mar 2024 18:36:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] net: Add a CONFIG_NET_BOARD_ETHADDR
Content-Language: en-US
To: Detlev Casanova <detlev.casanova@collabora.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>
References: <20240314144403.491850-1-detlev.casanova@collabora.com>
 <20240314144403.491850-2-detlev.casanova@collabora.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240314144403.491850-2-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 648jaurkztrhcf6sjbqmqees5wwe8d6w
X-MBO-RS-ID: 00b5ea3f39463e709ca
X-Rspamd-Queue-Id: 4TwZLS0Rmlz9sWd
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

On 3/14/24 3:43 PM, Detlev Casanova wrote:
> On some boards, a MAC address is set based on the CPU ID or other
> information. This is usually done in the misc_init_r() function.
> 
> This becomes a problem for net devices that are probed after the call to
> misc_init_r(), for example, when the ethernet is on a PCI port, which
> needs to be enumerated.
> 
> In this case, misc_init_r() will set the ethaddr variable, then, when
> the ethernet device is probed, if it has a ROM address, u-boot will warn
> about a MAC address mismatch and use the misc_init_r() address instead
> of the one in ROM.
> 
> The operating system later will most likely use the ROM MAC address,
> which can be confusing.
> 
> To avoid that, this commit introduces a CONFIG_NET_BOARD_ETHADDR that
> allows board files to implement a function to set an ethaddr in the
> environment, that will only be called when necessary. The logic is now:
> 
> - If there is there an ethaddr env var, use it.
> - If not, if there is a DT MAC address, use it.
> - If not, if there is a ROM MAC address, use it.
> - If not, if CONFIG_NET_BOARD_ETHADDR, call board_gen_ethaddr() and use
>    it.
> - If not, if CONFIG_NET_RANDOM_ETHADDR, generate random MAC
> - If not, fail with No valid MAC address found
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>   net/Kconfig      |  7 +++++++
>   net/eth-uclass.c | 17 +++++++++++++++--
>   2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/net/Kconfig b/net/Kconfig
> index 5dff6336293..6dd333ddb9e 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -54,6 +54,13 @@ config NET_RANDOM_ETHADDR
>   	  generated. It will be saved to the appropriate environment variable,
>   	  too.
>   
> +config NET_BOARD_ETHADDR
> +	bool "Board specific ethaddr if unset"
> +	help
> +	  Allow a board function to set a specific Ethernet address that can
> +	  be, e.g., based on the CPU ID. If set, this will be tried before
> +	  setting a random address (if set).
> +
>   config NETCONSOLE
>   	bool "NetConsole support"
>   	help
> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> index 3d0ec91dfa4..f194df8512a 100644
> --- a/net/eth-uclass.c
> +++ b/net/eth-uclass.c
> @@ -56,6 +56,12 @@ __weak int board_interface_eth_init(struct udevice *dev,
>   	return 0;
>   }
>   
> +/* board-specific MAC Address generation. */
> +__weak int board_gen_ethaddr(int dev_num, u8 *mac_addr)
> +{
> +	return 0;
> +}
> +
>   static struct eth_uclass_priv *eth_get_uclass_priv(void)
>   {
>   	struct uclass *uc;
> @@ -563,13 +569,20 @@ static int eth_post_probe(struct udevice *dev)
>   	if (!eth_dev_get_mac_address(dev, pdata->enetaddr) ||
>   	    !is_valid_ethaddr(pdata->enetaddr)) {
>   		/* Check if the device has a MAC address in ROM */
> +		int ret = -1;
>   		if (eth_get_ops(dev)->read_rom_hwaddr) {
> -			int ret;
> -
>   			ret = eth_get_ops(dev)->read_rom_hwaddr(dev);
>   			if (!ret)
>   				source = "ROM";
>   		}
> +		if (IS_ENABLED(CONFIG_NET_BOARD_ETHADDR) && ret) {
> +			board_gen_ethaddr(dev_seq(dev), pdata->enetaddr);

You do need to pass in the udevice *dev directly, otherwise this DM 
uclass patch would behave like non-DM code.

I'd personally just create a __weak board_gen_ethaddr() function here 
and let boards override it, without new Kconfig symbol.
