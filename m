Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7F2C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E70382CF8;
	Mon, 26 May 2025 11:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QGv5HuHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E484C82D18; Mon, 26 May 2025 11:03:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D878382C57
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748250186; x=1748854986; i=xypron.glpk@gmx.de;
 bh=sVh9XLLkH7CoYVrNswLvIJuR+lvbi+MCexOzIFT9bO8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QGv5HuHxJpNVHJYQ4zseOMqqrFS2oHR4TAbXnpemNZIL158jkWOL7xr660r7DTLw
 2+yByHT3Ib4ViN5nWvG5cNQt70o1WMMTG2Gp7x9PGnxRZc/Cxoy5fMCS/BAPcUujs
 RBXk6BjLd64aCQ2lvvIqJJB4XDKZ1hVcYUIJmQ8taF1pvphOKXfzDqvXKvco8qrs3
 zFnuB9Xwbt9t3/g7928pwDkMWk1+6K3OEbJtzlAdH/kZ2uluYM2iA8NYGr+WZafyX
 /RIAspB7mIYDoev0rZXoRgOdg4LyHBr+XNVtvPpFw5XfANqVbIsCiQqSobBfwWiYc
 k0QJA/fS3eLTbYOXkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDywo-1u9XaP3tp6-00D6Sa; Mon, 26
 May 2025 11:03:06 +0200
Message-ID: <dd989f0e-5096-4ddb-85fe-7f2f2b0eb86b@gmx.de>
Date: Mon, 26 May 2025 11:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] efi_loader/net: Remove simple network and pxe
 protocols from efi_net.c
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
 <20250516081839.28587-5-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250516081839.28587-5-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OzF5ktK7Oh0U7x4EI7Dy+dMeV7M6snDi9OqIguB5PeqkcEkN8MB
 XLxNkRR0aESib6Hz46L17jQQ2bKFp26Ow2v0aEcpfGbr246x9stUl5LSXCRvu1GnpNgAUEe
 wqAvaYJUrhitHoK4SXsbezJxurnpJDhkSQrg3d87M8MW1mVYrkQQtbixcPOQnfp9dIDknSF
 k+4Vmoqc6m9DHM4M/z5Eg==
UI-OutboundReport: notjunk:1;M01:P0:K4Ycpu0XL6k=;dkS/ptSrZvuS2GXkjh0zqajal7C
 ssuzvqFZkj82VwKPcy2rZYbwFNt+gG3DBDizo0YfiGZpk4V3UaBY+efuXc1XzWmh7t/zEAMcf
 /Lrczy0vum6IIKn8pZq5CfrKtjm3LmzdEIOaVv1ksDAfkx9YoskY1BEikUFQ7oeuw0N/IAjtn
 PEPde3g5FyySquj4D+QDX0AV5Kk4/lsA3Ykd0AWabG98XHQsNXJ9N5O7qtEQw+NblxqG7lhSL
 Qonx7X8bS0shBL/9q+L53Xruw3YXGiii5+Csj+uq9TEhAmYEKUGtzpPJ7DnAcVpFRh3G3RYUV
 VBTcjMtBLQWqbkZIzfnaVHP2AjYoeY88fSx/3lCopPTIMsIl1a5BD8srRhPGnkIE8Ao+rHWCn
 k2Fj9VCkUruupWKPCEQvIJizYD4EjJukZMHZb3CxPNOPz1ZusjiZuZwojIMwxIvT2VcM8XNpM
 d2mww2clKewSeWyUS4oV+qsIDg5I/mkPpdkTDrzLesDZUDb48RUVaU+HzRm4WK7L6Ra43Itks
 eCYizl+R7LFlKcM5ol9AMka0sJh2pU2Q7JakXEsKr1/zFLTZJvNo6oEZZGOSGEh+cX2orh6qb
 tmxaT1VAOYwdc3v/w0MMca4w+XilTUtmtSbjl3Ip1bmebUOP2MMJmYVhgf7jDe3b8O5tWIDId
 iVmmvirW4QeWKaZGQWm8PBtx+uDDBImukyEUpQGMaPnoOHjOga+crUitEzu3i+pAVMXJRHW9y
 8AkpPUAUhGRCeXTQCsl9SzOrBwKkr+FrMAT7WupPiLVVCHEAI88z8zN8ih7Z8ur6Mf2Jidhk9
 ZKg6YlcPbA8s/cnJI8VaCX71N5TZiAG26sJkbaoyxUEov/53TniDu2pvC3ywYnep9N0hqwQHc
 YgR8d9cjx0DJZAJalIqQLHCejLGd5QsN2ohY5QCHefFL7bQUHwMslzRnuI2EZA7NEd6AlOjHd
 PQs+seCmIx2CzoWc9rJFjD+B0SgiPeMe1i7kROMgXNd3Hog9bDlL4jyXi+ZGe2T+LnWRsMbPV
 U+1hpXl5f9/It7+zzRCsvqTNXYACuWyc+679wmH8duhK+S0gFbGdO0sxLSXPNRsjBnguTWunF
 qAGM91rZLnM7ibD4ZHzwgR2kYY+J7zxJpnMW1HUz3OzsfoNHbJDjEIYZodl0JsDTLthEkqkLx
 Wl+x8zW47ND5CD00t+8tFegMPrOKuMs8dIiApwprR6FniTW05McKqqrS6ijgV3aYYKK6xhD8B
 j7zyjvPvhH5WHoB2DXERb8Z00wpxZK77CDAZbfjx+dvH5ymqdLRgW1lL+PbdHTfZshkPTgB5j
 RzQo3PRsKANCPajVPROyNX8r9Clfhyc38H95AGEe8Ad6lBHl14dVPfSVY3cIdi8ZPYH3acdot
 7kOE+7neBOP865vJlTVSOZOr3FIXyeZ/BsPIRO6Opq6qHKk9vnF57risjC7uBYQnpzSgjoM9X
 +tGNOJg15dx6ZnMgUzsiqu/8CspSGaLSwhYycqfUyKQsarxteYFbeCFjVN9OfXHNEJcwlq2K9
 LNfKwZm8S+w1SnVeOv7/8GshJa3rSUPO6Br+ZZcCqYr8yxPyGNqa6/L1E1bgMdTc2KyMZxyIT
 64VINyBBqR7YfpmUu0FS+MFcDaWTmltBeaOOr+ooEBwdYi+O33BCc6H1HqRjmXVcydAKvUVRR
 zMK4zjmV/hkMyrQLmuiptZB7RmaKi14SvAjE1J1wNQBk0EeV1MIEMYUwwieuhm2hs68ewl7pK
 xbDbojlm3MlVLNad5z7ybdNAPS33ne+HiCfla680QrbHmCxVS1iAUQRy5zVRjZCfanjB3KxAK
 1Qy+rQl1IbIuMEpCENHOJJjmMIJT8ZUcJ6PrB3uiztTgjtBPHZw/5ChlxI2Ck31s4C1iaigTQ
 cMf1UW9sdTa44crg09IIYpHaHVAQfwHaeStPTMC7NHsFTXwJcDjMg0kdALivpD7oyKvvwIq+P
 p5toAtsJjPzIPfyav6EgceDqrWim7800G6zN1mCvOm9lvyNRNbsa3Bc5a01dbIE9oN2VAXxlF
 aQ+zvYXcYeN9/TwnJGZKLzZ8S/Qtmn6ueY/kVzQi/7J8Wq569v7BYColhLhgdfNbOozx3T7/m
 Px0sFfd3lVBNusIPrXlpUU9bWbwdM18hdcRiMbUFic1XMIey7o0lyJ+852Xko8uBn+DGJOXR0
 hlrq7xyjoJVdLL8O45ixdu5JP4ZUH4++sYN/0dPaZQTkfwxJnSD6nUXXEhlM0zCI1xCxY90y+
 eW+g143LIfugxXLBXXj5bUG0LUj6DBzz+tUbEzuP0LM4w6tdmoXtTjgHy2Eq2vH+pXisAUjo3
 Af4ZRw1oKSA9BaEXrwOd8MaRiGiqYGoi4KaTZzaFP45N9o4mzOCPBOxkOEqe6kGpmVCp9z5YA
 hr4+DAESCggsvZWbTU2URItm1+GjB/FWopz6OwMkatOThH38ygwuDHXwz6dP/0/VOv9tLUeeY
 ZB5tynOl31SPA1maIKflZbbuVOpNDCLpUQdq1NjmJt8HiaNMAxRfj+2MnJqo4ljzFELxV0tuX
 aeCA4blCgfhAzAhtv5Qg59r15ilA1LA23RLh7AP5YJ0RDMctBfsm99rzWpgD9HsHpogv5rxB2
 vgk7qoUrtXleVdBXDoDPFc1TvAg+DghmvoOT6uJCuEaBqlgelBG5E3qxc9AT/gf7sD699pWE2
 SI2VSC0xPyBfKz8Ooh7GHZsJjXg7vKw3xeJmjV6wk8apeGTvW1WBcN7fw6pGwfoltJy2PnUYk
 1pbzhK81Q0+b8Bm4JKY96fFFTplh42NtIRRT33b+7Lqu3ndwYIx/bNT7P0aFZ27k+asuyc3pv
 eS1nXbwhK/xLmHLkgpJ7+XUNKusSV5gSJ0Psb2oO2gZ/f634cBtp93JMpBMgYPvBjsnMSe7yy
 75Rz/WkVFQkWxU9Dmb2CC6a69KH2PbNO0SagxAp5S8LlDR5od2TXo0nPIH5piIIiqk7nd0LWT
 giGImyljuBKwL1bohmOYjpRN6oohcAKbIxmEktoBF5+NzFlEUtiBFm3GKFAY7+N3rKMnLvT0n
 mEQQ+rlIJRNJTxzVNtJXlE1UYnW1RA6hP2LVMydIgh/fClPFA95MHORi/gA2evGTqKYA+ZmEt
 5SMPXlbuL6TVOZQL/ScRPu53j/ewRFn8kbUySxPYL0fPC8QeILXX5VMV71q/1d4nq1SvkHK/f
 sAqX1AyoN6ugk6xBSqrW5dlzy7R2y1wb8WgJIP8tVcYIc/zO0G0ZSITRTA7euFtKPNDg=
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

On 16.05.25 10:18, Adriano Cordova wrote:
> efi_net.c should only [un]install protocols, leaving the
> actual implementation to efi_simple_network.c and efi_pxe.c.
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   include/efi_api.h                       |   28 +-
>   include/efi_loader.h                    |   10 +-
>   lib/efi_loader/net/Makefile             |    2 +
>   lib/efi_loader/net/efi_net.c            | 1038 +----------------------
>   lib/efi_loader/net/efi_pxe.c            |  190 +++++
>   lib/efi_loader/net/efi_simple_network.c |  880 +++++++++++++++++++
>   lib/efi_selftest/efi_selftest_snp.c     |    4 +-
>   7 files changed, 1142 insertions(+), 1010 deletions(-)
>   create mode 100644 lib/efi_loader/net/efi_pxe.c
>   create mode 100644 lib/efi_loader/net/efi_simple_network.c
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index eb61eafa028..b20d639fbea 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -1519,36 +1519,36 @@ struct efi_simple_network_mode {
>   /* revision of the simple network protocol */
>   #define EFI_SIMPLE_NETWORK_PROTOCOL_REVISION	0x00010000
>  =20
> -struct efi_simple_network {
> +struct efi_simple_network_protocol {
>   	u64 revision;
> -	efi_status_t (EFIAPI *start)(struct efi_simple_network *this);
> -	efi_status_t (EFIAPI *stop)(struct efi_simple_network *this);
> -	efi_status_t (EFIAPI *initialize)(struct efi_simple_network *this,
> +	efi_status_t (EFIAPI *start)(struct efi_simple_network_protocol *this)=
;
> +	efi_status_t (EFIAPI *stop)(struct efi_simple_network_protocol *this);
> +	efi_status_t (EFIAPI *initialize)(struct efi_simple_network_protocol *=
this,
>   			ulong extra_rx, ulong extra_tx);
> -	efi_status_t (EFIAPI *reset)(struct efi_simple_network *this,
> +	efi_status_t (EFIAPI *reset)(struct efi_simple_network_protocol *this,
>   			int extended_verification);
> -	efi_status_t (EFIAPI *shutdown)(struct efi_simple_network *this);
> -	efi_status_t (EFIAPI *receive_filters)(struct efi_simple_network *this=
,
> +	efi_status_t (EFIAPI *shutdown)(struct efi_simple_network_protocol *th=
is);
> +	efi_status_t (EFIAPI *receive_filters)(struct efi_simple_network_proto=
col *this,
>   			u32 enable, u32 disable, int reset_mcast_filter,
>   			ulong mcast_filter_count,
>   			struct efi_mac_address *mcast_filter);
> -	efi_status_t (EFIAPI *station_address)(struct efi_simple_network *this=
,
> +	efi_status_t (EFIAPI *station_address)(struct efi_simple_network_proto=
col *this,
>   			int reset, struct efi_mac_address *new_mac);
> -	efi_status_t (EFIAPI *statistics)(struct efi_simple_network *this,
> +	efi_status_t (EFIAPI *statistics)(struct efi_simple_network_protocol *=
this,
>   			int reset, ulong *stat_size, void *stat_table);
> -	efi_status_t (EFIAPI *mcastiptomac)(struct efi_simple_network *this,
> +	efi_status_t (EFIAPI *mcastiptomac)(struct efi_simple_network_protocol=
 *this,
>   			int ipv6, struct efi_ip_address *ip,
>   			struct efi_mac_address *mac);
> -	efi_status_t (EFIAPI *nvdata)(struct efi_simple_network *this,
> +	efi_status_t (EFIAPI *nvdata)(struct efi_simple_network_protocol *this=
,
>   			int read_write, ulong offset, ulong buffer_size,
>   			char *buffer);
> -	efi_status_t (EFIAPI *get_status)(struct efi_simple_network *this,
> +	efi_status_t (EFIAPI *get_status)(struct efi_simple_network_protocol *=
this,
>   			u32 *int_status, void **txbuf);
> -	efi_status_t (EFIAPI *transmit)(struct efi_simple_network *this,
> +	efi_status_t (EFIAPI *transmit)(struct efi_simple_network_protocol *th=
is,
>   			size_t header_size, size_t buffer_size, void *buffer,
>   			struct efi_mac_address *src_addr,
>   			struct efi_mac_address *dest_addr, u16 *protocol);
> -	efi_status_t (EFIAPI *receive)(struct efi_simple_network *this,
> +	efi_status_t (EFIAPI *receive)(struct efi_simple_network_protocol *thi=
s,
>   			size_t *header_size, size_t *buffer_size, void *buffer,
>   			struct efi_mac_address *src_addr,
>   			struct efi_mac_address *dest_addr, u16 *protocol);
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 5c1244824f3..cc90bdf6a3a 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -329,8 +329,6 @@ extern const efi_guid_t efi_guid_host_dev;
>   #endif
>   /* GUID of the EFI_BLOCK_IO_PROTOCOL */
>   extern const efi_guid_t efi_block_io_guid;
> -/* GUID of the EFI_SIMPLE_NETWORK_PROTOCOL */
> -extern const efi_guid_t efi_net_guid;
>   extern const efi_guid_t efi_global_variable_guid;
>   extern const efi_guid_t efi_guid_console_control;
>   extern const efi_guid_t efi_guid_device_path;
> @@ -661,9 +659,13 @@ efi_status_t efi_gop_register(void);
>   /* Called by bootefi to make the network interface available */
>   efi_status_t efi_net_register(struct udevice *dev);
>   efi_status_t efi_net_do_start(struct udevice *dev);
> -/* Called by efi_net_register to make the ip4 config2 protocol availabl=
e */
> +/* Called by efi_net_register to install EFI_SIMPLE_NETWORK_PROTOCOL */
> +efi_status_t efi_simple_network_install(const efi_handle_t handle, stru=
ct udevice *dev);
> +/* Called by efi_net_register to install EFI_PXE_BASE_CODE_PROTOCOL */
> +efi_status_t efi_pxe_install(const efi_handle_t handle, struct efi_pxe_=
packet *dhcp_ack);
> +/* Called by efi_net_register to install EFI_IP4_CONFIG2_PROTOCOL */
>   efi_status_t efi_ip4_config2_install(const efi_handle_t handle);
> -/* Called by efi_net_register to make the http protocol available */
> +/* Called by efi_net_register to install EFI_HTTP_SERVICE_BINDING_PROTO=
COL */
>   efi_status_t efi_http_install(const efi_handle_t handle);
>   /* Called by bootefi to make the watchdog available */
>   efi_status_t efi_watchdog_register(void);
> diff --git a/lib/efi_loader/net/Makefile b/lib/efi_loader/net/Makefile
> index 75131877e30..d024f1818d9 100644
> --- a/lib/efi_loader/net/Makefile
> +++ b/lib/efi_loader/net/Makefile
> @@ -1,3 +1,5 @@
>   obj-y +=3D efi_net.o
> +obj-y +=3D efi_simple_network.o
> +obj-y +=3D efi_pxe.o
>   obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) +=3D efi_ip4_config2.o
>   obj-$(CONFIG_EFI_HTTP_PROTOCOL) +=3D efi_http.o
> \ No newline at end of file
> diff --git a/lib/efi_loader/net/efi_net.c b/lib/efi_loader/net/efi_net.c
> index 40db80f4726..a7ceef4cbba 100644
> --- a/lib/efi_loader/net/efi_net.c
> +++ b/lib/efi_loader/net/efi_net.c
> @@ -1,18 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Simple network protocol
> - * PXE base code protocol
>    *
>    * Copyright (c) 2016 Alexander Graf
>    *
> - * The simple network protocol has the following statuses and services
> - * to move between them:
> - *
> - * Start():	 EfiSimpleNetworkStopped     -> EfiSimpleNetworkStarted
> - * Initialize(): EfiSimpleNetworkStarted     -> EfiSimpleNetworkInitial=
ized
> - * Shutdown():	 EfiSimpleNetworkInitialized -> EfiSimpleNetworkStarted
> - * Stop():	 EfiSimpleNetworkStarted     -> EfiSimpleNetworkStopped
> - * Reset():	 EfiSimpleNetworkInitialized -> EfiSimpleNetworkInitialized
>    */
>  =20
>   #define LOG_CATEGORY LOGC_EFI
> @@ -28,11 +18,12 @@
>   #define MAX_NUM_DHCP_ENTRIES 10
>   #define MAX_NUM_DP_ENTRIES 10
>  =20
> -const efi_guid_t efi_net_guid =3D EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
>   static const efi_guid_t efi_pxe_base_code_protocol_guid =3D
>   					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
> +#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
>   static const efi_guid_t efi_http_service_binding_guid =3D
>   					EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
> +#endif
>  =20
>   struct dp_entry {
>   	struct efi_device_path *net_dp;
> @@ -71,39 +62,12 @@ static int next_dhcp_entry;
>    *
>    * @header:			EFI object header
>    * @dev:			net udevice
> - * @net:			simple network protocol interface
> - * @net_mode:			status of the network interface
> - * @pxe:			PXE base code protocol interface
> - * @pxe_mode:			status of the PXE base code protocol
> - * @new_tx_packet:		new transmit packet
> - * @transmit_buffer:	transmit buffer
> - * @receive_buffer:		array of receive buffers
> - * @receive_lengths:	array of lengths for received packets
> - * @rx_packet_idx:		index of the current receive packet
> - * @rx_packet_num:		number of received packets
> - * @wait_for_packet:	signaled when a packet has been received
> - * @network_timer_event:	event to check for new network packets.
> - * @efi_seq_num:		sequence number of the EFI net object.
>    */
>   struct efi_net_obj {
>   	struct efi_object header;
>   	struct udevice *dev;
> -	struct efi_simple_network net;
> -	struct efi_simple_network_mode net_mode;
> -	struct efi_pxe_base_code_protocol pxe;
> -	struct efi_pxe_mode pxe_mode;
> -	void *new_tx_packet;
> -	void *transmit_buffer;
> -	uchar **receive_buffer;
> -	size_t *receive_lengths;
> -	int rx_packet_idx;
> -	int rx_packet_num;
> -	struct efi_event *wait_for_packet;
> -	struct efi_event *network_timer_event;
> -	int efi_seq_num;
>   };
>  =20
> -static int curr_efi_net_obj;
>   static struct efi_net_obj *net_objs[MAX_EFI_NET_OBJS];
>  =20
>   /**
> @@ -120,641 +84,6 @@ static bool efi_netobj_is_active(struct efi_net_obj=
 *netobj)
>   	return true;
>   }
>  =20
> -/*
> - * efi_netobj_from_snp() - get efi_net_obj from simple network protocol
> - *
> - *
> - * @snp:	pointer to the simple network protocol
> - * Return:	pointer to efi_net_obj, NULL on error
> - */
> -static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_networ=
k *snp)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> -		if (net_objs[i] && &net_objs[i]->net =3D=3D snp) {
> -			// Do not register duplicate devices
> -			return net_objs[i];
> -		}
> -	}
> -	return NULL;
> -}
> -
> -/*
> - * efi_net_start() - start the network interface
> - *
> - * This function implements the Start service of the
> - * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> - * (UEFI) specification for details.
> - *
> - * @this:	pointer to the protocol instance
> - * Return:	status code
> - */
> -static efi_status_t EFIAPI efi_net_start(struct efi_simple_network *thi=
s)
> -{
> -	efi_status_t ret =3D EFI_SUCCESS;
> -	struct efi_net_obj *nt;
> -
> -	EFI_ENTRY("%p", this);
> -	/* Check parameters */
> -	if (!this) {
> -		ret =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	}
> -
> -	nt =3D efi_netobj_from_snp(this);
> -
> -	if (this->mode->state !=3D EFI_NETWORK_STOPPED) {
> -		ret =3D EFI_ALREADY_STARTED;
> -	} else {
> -		this->int_status =3D 0;
> -		nt->wait_for_packet->is_signaled =3D false;
> -		this->mode->state =3D EFI_NETWORK_STARTED;
> -	}
> -out:
> -	return EFI_EXIT(ret);
> -}
> -
> -/*
> - * efi_net_stop() - stop the network interface
> - *
> - * This function implements the Stop service of the
> - * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> - * (UEFI) specification for details.
> - *
> - * @this:	pointer to the protocol instance
> - * Return:	status code
> - */
> -static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *this=
)
> -{
> -	efi_status_t ret =3D EFI_SUCCESS;
> -	struct efi_net_obj *nt;
> -
> -	EFI_ENTRY("%p", this);
> -
> -	/* Check parameters */
> -	if (!this) {
> -		ret =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	}
> -
> -	nt =3D efi_netobj_from_snp(this);
> -
> -	if (this->mode->state =3D=3D EFI_NETWORK_STOPPED) {
> -		ret =3D EFI_NOT_STARTED;
> -	} else {
> -		/* Disable hardware and put it into the reset state */
> -		eth_set_dev(nt->dev);
> -		env_set("ethact", eth_get_name());
> -		eth_halt();
> -		/* Clear cache of packets */
> -		nt->rx_packet_num =3D 0;
> -		this->mode->state =3D EFI_NETWORK_STOPPED;
> -	}
> -out:
> -	return EFI_EXIT(ret);
> -}
> -
> -/*
> - * efi_net_initialize() - initialize the network interface
> - *
> - * This function implements the Initialize service of the
> - * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> - * (UEFI) specification for details.
> - *
> - * @this:	pointer to the protocol instance
> - * @extra_rx:	extra receive buffer to be allocated
> - * @extra_tx:	extra transmit buffer to be allocated
> - * Return:	status code
> - */
> -static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network=
 *this,
> -					      ulong extra_rx, ulong extra_tx)
> -{
> -	int ret;
> -	efi_status_t r =3D EFI_SUCCESS;
> -	struct efi_net_obj *nt;
> -
> -	EFI_ENTRY("%p, %lx, %lx", this, extra_rx, extra_tx);
> -
> -	/* Check parameters */
> -	if (!this) {
> -		r =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	}
> -	nt =3D efi_netobj_from_snp(this);
> -
> -	switch (this->mode->state) {
> -	case EFI_NETWORK_INITIALIZED:
> -	case EFI_NETWORK_STARTED:
> -		break;
> -	default:
> -		r =3D EFI_NOT_STARTED;
> -		goto out;
> -	}
> -
> -	/* Setup packet buffers */
> -	net_init();
> -	/* Clear cache of packets */
> -	nt->rx_packet_num =3D 0;
> -	/* Set the net device corresponding to the efi net object */
> -	eth_set_dev(nt->dev);
> -	env_set("ethact", eth_get_name());
> -	/* Get hardware ready for send and receive operations */
> -	ret =3D eth_start_udev(nt->dev);
> -	if (ret < 0) {
> -		eth_halt();
> -		this->mode->state =3D EFI_NETWORK_STOPPED;
> -		r =3D EFI_DEVICE_ERROR;
> -		goto out;
> -	} else {
> -		this->int_status =3D 0;
> -		nt->wait_for_packet->is_signaled =3D false;
> -		this->mode->state =3D EFI_NETWORK_INITIALIZED;
> -	}
> -out:
> -	return EFI_EXIT(r);
> -}
> -
> -/*
> - * efi_net_reset() - reinitialize the network interface
> - *
> - * This function implements the Reset service of the
> - * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> - * (UEFI) specification for details.
> - *
> - * @this:			pointer to the protocol instance
> - * @extended_verification:	execute exhaustive verification
> - * Return:			status code
> - */
> -static efi_status_t EFIAPI efi_net_reset(struct efi_simple_network *thi=
s,
> -					 int extended_verification)
> -{
> -	efi_status_t ret;
> -
> -	EFI_ENTRY("%p, %x", this, extended_verification);
> -
> -	/* Check parameters */
> -	if (!this) {
> -		ret =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	}
> -
> -	switch (this->mode->state) {
> -	case EFI_NETWORK_INITIALIZED:
> -		break;
> -	case EFI_NETWORK_STOPPED:
> -		ret =3D EFI_NOT_STARTED;
> -		goto out;
> -	default:
> -		ret =3D EFI_DEVICE_ERROR;
> -		goto out;
> -	}
> -
> -	this->mode->state =3D EFI_NETWORK_STARTED;
> -	ret =3D EFI_CALL(efi_net_initialize(this, 0, 0));
> -out:
> -	return EFI_EXIT(ret);
> -}
> -
> -/*
> - * efi_net_shutdown() - shut down the network interface
> - *
> - * This function implements the Shutdown service of the
> - * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> - * (UEFI) specification for details.
> - *
> - * @this:	pointer to the protocol instance
> - * Return:	status code
> - */
> -static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network *=
this)
> -{
> -	efi_status_t ret =3D EFI_SUCCESS;
> -	struct efi_net_obj *nt;
> -
> -	EFI_ENTRY("%p", this);
> -
> -	/* Check parameters */
> -	if (!this) {
> -		ret =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	}
> -	nt =3D efi_netobj_from_snp(this);
> -
> -	switch (this->mode->state) {
> -	case EFI_NETWORK_INITIALIZED:
> -		break;
> -	case EFI_NETWORK_STOPPED:
> -		ret =3D EFI_NOT_STARTED;
> -		goto out;
> -	default:
> -		ret =3D EFI_DEVICE_ERROR;
> -		goto out;
> -	}
> -
> -	eth_set_dev(nt->dev);
> -	env_set("ethact", eth_get_name());
> -	eth_halt();
> -
> -	this->int_status =3D 0;
> -	nt->wait_for_packet->is_signaled =3D false;
> -	this->mode->state =3D EFI_NETWORK_STARTED;
> -
> -out:
> -	return EFI_EXIT(ret);
> -}
> -
> -/*
> - * efi_net_receive_filters() - mange multicast receive filters
> - *
> - * This function implements the ReceiveFilters service of the
> - * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> - * (UEFI) specification for details.
> - *
> - * @this:		pointer to the protocol instance
> - * @enable:		bit mask of receive filters to enable
> - * @disable:		bit mask of receive filters to disable
> - * @reset_mcast_filter:	true resets contents of the filters
> - * @mcast_filter_count:	number of hardware MAC addresses in the new fil=
ters list
> - * @mcast_filter:	list of new filters
> - * Return:		status code
> - */
> -static efi_status_t EFIAPI efi_net_receive_filters
> -		(struct efi_simple_network *this, u32 enable, u32 disable,
> -		 int reset_mcast_filter, ulong mcast_filter_count,
> -		 struct efi_mac_address *mcast_filter)
> -{
> -	EFI_ENTRY("%p, %x, %x, %x, %lx, %p", this, enable, disable,
> -		  reset_mcast_filter, mcast_filter_count, mcast_filter);
> -
> -	return EFI_EXIT(EFI_UNSUPPORTED);
> -}
> -
> -/*
> - * efi_net_station_address() - set the hardware MAC address
> - *
> - * This function implements the StationAddress service of the
> - * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> - * (UEFI) specification for details.
> - *
> - * @this:	pointer to the protocol instance
> - * @reset:	if true reset the address to default
> - * @new_mac:	new MAC address
> - * Return:	status code
> - */
> -static efi_status_t EFIAPI efi_net_station_address
> -		(struct efi_simple_network *this, int reset,
> -		 struct efi_mac_address *new_mac)
> -{
> -	EFI_ENTRY("%p, %x, %p", this, reset, new_mac);
> -
> -	return EFI_EXIT(EFI_UNSUPPORTED);
> -}
> -
> -/*
> - * efi_net_statistics() - reset or collect statistics of the network in=
terface
> - *
> - * This function implements the Statistics service of the
> - * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> - * (UEFI) specification for details.
> - *
> - * @this:	pointer to the protocol instance
> - * @reset:	if true, the statistics are reset
> - * @stat_size:	size of the statistics table
> - * @stat_table:	table to receive the statistics
> - * Return:	status code
> - */
> -static efi_status_t EFIAPI efi_net_statistics(struct efi_simple_network=
 *this,
> -					      int reset, ulong *stat_size,
> -					      void *stat_table)
> -{
> -	EFI_ENTRY("%p, %x, %p, %p", this, reset, stat_size, stat_table);
> -
> -	return EFI_EXIT(EFI_UNSUPPORTED);
> -}
> -
> -/*
> - * efi_net_mcastiptomac() - translate multicast IP address to MAC addre=
ss
> - *
> - * This function implements the MCastIPtoMAC service of the
> - * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> - * (UEFI) specification for details.
> - *
> - * @this:	pointer to the protocol instance
> - * @ipv6:	true if the IP address is an IPv6 address
> - * @ip:		IP address
> - * @mac:	MAC address
> - * Return:	status code
> - */
> -static efi_status_t EFIAPI efi_net_mcastiptomac(struct efi_simple_netwo=
rk *this,
> -						int ipv6,
> -						struct efi_ip_address *ip,
> -						struct efi_mac_address *mac)
> -{
> -	efi_status_t ret =3D EFI_SUCCESS;
> -
> -	EFI_ENTRY("%p, %x, %p, %p", this, ipv6, ip, mac);
> -
> -	if (!this || !ip || !mac) {
> -		ret =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	}
> -
> -	if (ipv6) {
> -		ret =3D EFI_UNSUPPORTED;
> -		goto out;
> -	}
> -
> -	/* Multi-cast addresses are in the range 224.0.0.0 - 239.255.255.255 *=
/
> -	if ((ip->ip_addr[0] & 0xf0) !=3D 0xe0) {
> -		ret =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	};
> -
> -	switch (this->mode->state) {
> -	case EFI_NETWORK_INITIALIZED:
> -	case EFI_NETWORK_STARTED:
> -		break;
> -	default:
> -		ret =3D EFI_NOT_STARTED;
> -		goto out;
> -	}
> -
> -	memset(mac, 0, sizeof(struct efi_mac_address));
> -
> -	/*
> -	 * Copy lower 23 bits of IPv4 multi-cast address
> -	 * RFC 1112, RFC 7042 2.1.1.
> -	 */
> -	mac->mac_addr[0] =3D 0x01;
> -	mac->mac_addr[1] =3D 0x00;
> -	mac->mac_addr[2] =3D 0x5E;
> -	mac->mac_addr[3] =3D ip->ip_addr[1] & 0x7F;
> -	mac->mac_addr[4] =3D ip->ip_addr[2];
> -	mac->mac_addr[5] =3D ip->ip_addr[3];
> -out:
> -	return EFI_EXIT(ret);
> -}
> -
> -/**
> - * efi_net_nvdata() - read or write NVRAM
> - *
> - * This function implements the GetStatus service of the Simple Network
> - * Protocol. See the UEFI spec for details.
> - *
> - * @this:		the instance of the Simple Network Protocol
> - * @read_write:		true for read, false for write
> - * @offset:		offset in NVRAM
> - * @buffer_size:	size of buffer
> - * @buffer:		buffer
> - * Return:		status code
> - */
> -static efi_status_t EFIAPI efi_net_nvdata(struct efi_simple_network *th=
is,
> -					  int read_write, ulong offset,
> -					  ulong buffer_size, char *buffer)
> -{
> -	EFI_ENTRY("%p, %x, %lx, %lx, %p", this, read_write, offset, buffer_siz=
e,
> -		  buffer);
> -
> -	return EFI_EXIT(EFI_UNSUPPORTED);
> -}
> -
> -/**
> - * efi_net_get_status() - get interrupt status
> - *
> - * This function implements the GetStatus service of the Simple Network
> - * Protocol. See the UEFI spec for details.
> - *
> - * @this:		the instance of the Simple Network Protocol
> - * @int_status:		interface status
> - * @txbuf:		transmission buffer
> - */
> -static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network=
 *this,
> -					      u32 *int_status, void **txbuf)
> -{
> -	efi_status_t ret =3D EFI_SUCCESS;
> -	struct efi_net_obj *nt;
> -
> -	EFI_ENTRY("%p, %p, %p", this, int_status, txbuf);
> -
> -	efi_timer_check();
> -
> -	/* Check parameters */
> -	if (!this) {
> -		ret =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	}
> -
> -	nt =3D efi_netobj_from_snp(this);
> -
> -	switch (this->mode->state) {
> -	case EFI_NETWORK_STOPPED:
> -		ret =3D EFI_NOT_STARTED;
> -		goto out;
> -	case EFI_NETWORK_STARTED:
> -		ret =3D EFI_DEVICE_ERROR;
> -		goto out;
> -	default:
> -		break;
> -	}
> -
> -	if (int_status) {
> -		*int_status =3D this->int_status;
> -		this->int_status =3D 0;
> -	}
> -	if (txbuf)
> -		*txbuf =3D nt->new_tx_packet;
> -
> -	nt->new_tx_packet =3D NULL;
> -out:
> -	return EFI_EXIT(ret);
> -}
> -
> -/**
> - * efi_net_transmit() - transmit a packet
> - *
> - * This function implements the Transmit service of the Simple Network =
Protocol.
> - * See the UEFI spec for details.
> - *
> - * @this:		the instance of the Simple Network Protocol
> - * @header_size:	size of the media header
> - * @buffer_size:	size of the buffer to receive the packet
> - * @buffer:		buffer to receive the packet
> - * @src_addr:		source hardware MAC address
> - * @dest_addr:		destination hardware MAC address
> - * @protocol:		type of header to build
> - * Return:		status code
> - */
> -static efi_status_t EFIAPI efi_net_transmit
> -		(struct efi_simple_network *this, size_t header_size,
> -		 size_t buffer_size, void *buffer,
> -		 struct efi_mac_address *src_addr,
> -		 struct efi_mac_address *dest_addr, u16 *protocol)
> -{
> -	efi_status_t ret =3D EFI_SUCCESS;
> -	struct efi_net_obj *nt;
> -
> -	EFI_ENTRY("%p, %lu, %lu, %p, %p, %p, %p", this,
> -		  (unsigned long)header_size, (unsigned long)buffer_size,
> -		  buffer, src_addr, dest_addr, protocol);
> -
> -	efi_timer_check();
> -
> -	/* Check parameters */
> -	if (!this || !buffer) {
> -		ret =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	}
> -
> -	nt =3D efi_netobj_from_snp(this);
> -
> -	/* We do not support jumbo packets */
> -	if (buffer_size > PKTSIZE_ALIGN) {
> -		ret =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	}
> -
> -	/* At least the IP header has to fit into the buffer */
> -	if (buffer_size < this->mode->media_header_size) {
> -		ret =3D EFI_BUFFER_TOO_SMALL;
> -		goto out;
> -	}
> -
> -	/*
> -	 * TODO:
> -	 * Support VLANs. Use net_set_ether() for copying the header. Use a
> -	 * U_BOOT_ENV_CALLBACK to update the media header size.
> -	 */
> -	if (header_size) {
> -		struct ethernet_hdr *header =3D buffer;
> -
> -		if (!dest_addr || !protocol ||
> -		    header_size !=3D this->mode->media_header_size) {
> -			ret =3D EFI_INVALID_PARAMETER;
> -			goto out;
> -		}
> -		if (!src_addr)
> -			src_addr =3D &this->mode->current_address;
> -
> -		memcpy(header->et_dest, dest_addr, ARP_HLEN);
> -		memcpy(header->et_src, src_addr, ARP_HLEN);
> -		header->et_protlen =3D htons(*protocol);
> -	}
> -
> -	switch (this->mode->state) {
> -	case EFI_NETWORK_STOPPED:
> -		ret =3D EFI_NOT_STARTED;
> -		goto out;
> -	case EFI_NETWORK_STARTED:
> -		ret =3D EFI_DEVICE_ERROR;
> -		goto out;
> -	default:
> -		break;
> -	}
> -
> -	eth_set_dev(nt->dev);
> -	env_set("ethact", eth_get_name());
> -
> -	/* Ethernet packets always fit, just bounce */
> -	memcpy(nt->transmit_buffer, buffer, buffer_size);
> -	net_send_packet(nt->transmit_buffer, buffer_size);
> -
> -	nt->new_tx_packet =3D buffer;
> -	this->int_status |=3D EFI_SIMPLE_NETWORK_TRANSMIT_INTERRUPT;
> -out:
> -	return EFI_EXIT(ret);
> -}
> -
> -/**
> - * efi_net_receive() - receive a packet from a network interface
> - *
> - * This function implements the Receive service of the Simple Network P=
rotocol.
> - * See the UEFI spec for details.
> - *
> - * @this:		the instance of the Simple Network Protocol
> - * @header_size:	size of the media header
> - * @buffer_size:	size of the buffer to receive the packet
> - * @buffer:		buffer to receive the packet
> - * @src_addr:		source MAC address
> - * @dest_addr:		destination MAC address
> - * @protocol:		protocol
> - * Return:		status code
> - */
> -static efi_status_t EFIAPI efi_net_receive
> -		(struct efi_simple_network *this, size_t *header_size,
> -		 size_t *buffer_size, void *buffer,
> -		 struct efi_mac_address *src_addr,
> -		 struct efi_mac_address *dest_addr, u16 *protocol)
> -{
> -	efi_status_t ret =3D EFI_SUCCESS;
> -	struct ethernet_hdr *eth_hdr;
> -	size_t hdr_size =3D sizeof(struct ethernet_hdr);
> -	u16 protlen;
> -	struct efi_net_obj *nt;
> -
> -	EFI_ENTRY("%p, %p, %p, %p, %p, %p, %p", this, header_size,
> -		  buffer_size, buffer, src_addr, dest_addr, protocol);
> -
> -	/* Execute events */
> -	efi_timer_check();
> -
> -	/* Check parameters */
> -	if (!this || !buffer || !buffer_size) {
> -		ret =3D EFI_INVALID_PARAMETER;
> -		goto out;
> -	}
> -
> -	nt =3D efi_netobj_from_snp(this);
> -
> -	switch (this->mode->state) {
> -	case EFI_NETWORK_STOPPED:
> -		ret =3D EFI_NOT_STARTED;
> -		goto out;
> -	case EFI_NETWORK_STARTED:
> -		ret =3D EFI_DEVICE_ERROR;
> -		goto out;
> -	default:
> -		break;
> -	}
> -
> -	if (!nt->rx_packet_num) {
> -		ret =3D EFI_NOT_READY;
> -		goto out;
> -	}
> -	/* Fill export parameters */
> -	eth_hdr =3D (struct ethernet_hdr *)nt->receive_buffer[nt->rx_packet_id=
x];
> -	protlen =3D ntohs(eth_hdr->et_protlen);
> -	if (protlen =3D=3D 0x8100) {
> -		hdr_size +=3D 4;
> -		protlen =3D ntohs(*(u16 *)&nt->receive_buffer[nt->rx_packet_idx][hdr_=
size - 2]);
> -	}
> -	if (header_size)
> -		*header_size =3D hdr_size;
> -	if (dest_addr)
> -		memcpy(dest_addr, eth_hdr->et_dest, ARP_HLEN);
> -	if (src_addr)
> -		memcpy(src_addr, eth_hdr->et_src, ARP_HLEN);
> -	if (protocol)
> -		*protocol =3D protlen;
> -	if (*buffer_size < nt->receive_lengths[nt->rx_packet_idx]) {
> -		/* Packet doesn't fit, try again with bigger buffer */
> -		*buffer_size =3D nt->receive_lengths[nt->rx_packet_idx];
> -		ret =3D EFI_BUFFER_TOO_SMALL;
> -		goto out;
> -	}
> -	/* Copy packet */
> -	memcpy(buffer, nt->receive_buffer[nt->rx_packet_idx],
> -	       nt->receive_lengths[nt->rx_packet_idx]);
> -	*buffer_size =3D nt->receive_lengths[nt->rx_packet_idx];
> -	nt->rx_packet_idx =3D (nt->rx_packet_idx + 1) % ETH_PACKETS_BATCH_RECV=
;
> -	nt->rx_packet_num--;
> -	if (nt->rx_packet_num)
> -		nt->wait_for_packet->is_signaled =3D true;
> -	else
> -		this->int_status &=3D ~EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
> -out:
> -	return EFI_EXIT(ret);
> -}
> -
>   /**
>    * efi_net_set_dhcp_ack() - take note of a selected DHCP IP address
>    *
> @@ -765,7 +94,10 @@ out:
>    */
>   void efi_net_set_dhcp_ack(void *pkt, int len)
>   {
> +	efi_status_t r =3D EFI_SUCCESS;
>   	struct efi_pxe_packet **dhcp_ack;
> +	struct efi_handler *phandler;
> +	struct efi_pxe_base_code_protocol *pxe;
>   	struct udevice *dev;
>   	int i;
>  =20
> @@ -791,200 +123,17 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
>  =20
>   	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
>   		if (net_objs[i] && net_objs[i]->dev =3D=3D dev) {
> -			net_objs[i]->pxe_mode.dhcp_ack =3D **dhcp_ack;
> -		}
> -	}
> -}
> -
> -/**
> - * efi_net_push() - callback for received network packet
> - *
> - * This function is called when a network packet is received by eth_rx(=
).
> - *
> - * @pkt:	network packet
> - * @len:	length
> - */
> -static void efi_net_push(void *pkt, int len)
> -{
> -	int rx_packet_next;
> -	struct efi_net_obj *nt;
> -
> -	nt =3D net_objs[curr_efi_net_obj];
> -	if (!nt)
> -		return;
> -
> -	/* Check that we at least received an Ethernet header */
> -	if (len < sizeof(struct ethernet_hdr))
> -		return;
> -
> -	/* Check that the buffer won't overflow */
> -	if (len > PKTSIZE_ALIGN)
> -		return;
> -
> -	/* Can't store more than pre-alloced buffer */
> -	if (nt->rx_packet_num >=3D ETH_PACKETS_BATCH_RECV)
> -		return;
> -
> -	rx_packet_next =3D (nt->rx_packet_idx + nt->rx_packet_num) %
> -	    ETH_PACKETS_BATCH_RECV;
> -	memcpy(nt->receive_buffer[rx_packet_next], pkt, len);
> -	nt->receive_lengths[rx_packet_next] =3D len;
> -
> -	nt->rx_packet_num++;
> -}
> -
> -/**
> - * efi_network_timer_notify() - check if a new network packet has been =
received
> - *
> - * This notification function is called in every timer cycle.
> - *
> - * @event:	the event for which this notification function is registered
> - * @context:	event context - not used in this function
> - */
> -static void EFIAPI efi_network_timer_notify(struct efi_event *event,
> -					    void *context)
> -{
> -	struct efi_simple_network *this =3D (struct efi_simple_network *)conte=
xt;
> -	struct efi_net_obj *nt;
> -
> -	EFI_ENTRY("%p, %p", event, context);
> -
> -	/*
> -	 * Some network drivers do not support calling eth_rx() before
> -	 * initialization.
> -	 */
> -	if (!this || this->mode->state !=3D EFI_NETWORK_INITIALIZED)
> -		goto out;
> -
> -	nt =3D efi_netobj_from_snp(this);
> -	curr_efi_net_obj =3D nt->efi_seq_num;
> -
> -	if (!nt->rx_packet_num) {
> -		eth_set_dev(nt->dev);
> -		env_set("ethact", eth_get_name());
> -		push_packet =3D efi_net_push;
> -		eth_rx();
> -		push_packet =3D NULL;
> -		if (nt->rx_packet_num) {
> -			this->int_status |=3D
> -				EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
> -			nt->wait_for_packet->is_signaled =3D true;
> +			phandler =3D NULL;
> +			r =3D efi_search_protocol(&net_objs[i]->header,
> +						&efi_pxe_base_code_protocol_guid,
> +						&phandler);
> +			if (r =3D=3D EFI_SUCCESS && phandler) {
> +				pxe =3D phandler->protocol_interface;
> +				pxe->mode->dhcp_ack =3D **dhcp_ack;
> +			}
> +			break;
>   		}
>   	}
> -out:
> -	EFI_EXIT(EFI_SUCCESS);
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_start(
> -				struct efi_pxe_base_code_protocol *this,
> -				u8 use_ipv6)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_stop(
> -				struct efi_pxe_base_code_protocol *this)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_dhcp(
> -				struct efi_pxe_base_code_protocol *this,
> -				u8 sort_offers)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_discover(
> -				struct efi_pxe_base_code_protocol *this,
> -				u16 type, u16 *layer, u8 bis,
> -				struct efi_pxe_base_code_discover_info *info)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_mtftp(
> -				struct efi_pxe_base_code_protocol *this,
> -				u32 operation, void *buffer_ptr,
> -				u8 overwrite, efi_uintn_t *buffer_size,
> -				struct efi_ip_address server_ip, char *filename,
> -				struct efi_pxe_base_code_mtftp_info *info,
> -				u8 dont_use_buffer)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_udp_write(
> -				struct efi_pxe_base_code_protocol *this,
> -				u16 op_flags, struct efi_ip_address *dest_ip,
> -				u16 *dest_port,
> -				struct efi_ip_address *gateway_ip,
> -				struct efi_ip_address *src_ip, u16 *src_port,
> -				efi_uintn_t *header_size, void *header_ptr,
> -				efi_uintn_t *buffer_size, void *buffer_ptr)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_udp_read(
> -				struct efi_pxe_base_code_protocol *this,
> -				u16 op_flags, struct efi_ip_address *dest_ip,
> -				u16 *dest_port, struct efi_ip_address *src_ip,
> -				u16 *src_port, efi_uintn_t *header_size,
> -				void *header_ptr, efi_uintn_t *buffer_size,
> -				void *buffer_ptr)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_set_ip_filter(
> -				struct efi_pxe_base_code_protocol *this,
> -				struct efi_pxe_base_code_filter *new_filter)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_arp(
> -				struct efi_pxe_base_code_protocol *this,
> -				struct efi_ip_address *ip_addr,
> -				struct efi_mac_address *mac_addr)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_set_parameters(
> -				struct efi_pxe_base_code_protocol *this,
> -				u8 *new_auto_arp, u8 *new_send_guid,
> -				u8 *new_ttl, u8 *new_tos,
> -				u8 *new_make_callback)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_set_station_ip(
> -				struct efi_pxe_base_code_protocol *this,
> -				struct efi_ip_address *new_station_ip,
> -				struct efi_ip_address *new_subnet_mask)
> -{
> -	return EFI_UNSUPPORTED;
> -}
> -
> -static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
> -				struct efi_pxe_base_code_protocol *this,
> -				u8 *new_dhcp_discover_valid,
> -				u8 *new_dhcp_ack_received,
> -				u8 *new_proxy_offer_received,
> -				u8 *new_pxe_discover_valid,
> -				u8 *new_pxe_reply_received,
> -				u8 *new_pxe_bis_reply_received,
> -				EFI_PXE_BASE_CODE_PACKET *new_dchp_discover,
> -				EFI_PXE_BASE_CODE_PACKET *new_dhcp_acc,
> -				EFI_PXE_BASE_CODE_PACKET *new_proxy_offer,
> -				EFI_PXE_BASE_CODE_PACKET *new_pxe_discover,
> -				EFI_PXE_BASE_CODE_PACKET *new_pxe_reply,
> -				EFI_PXE_BASE_CODE_PACKET *new_pxe_bis_reply)
> -{
> -	return EFI_UNSUPPORTED;
>   }
>  =20
>   /**
> @@ -1066,6 +215,10 @@ efi_status_t efi_net_do_start(struct udevice *dev)
>   	efi_status_t r =3D EFI_SUCCESS;
>   	struct efi_net_obj *netobj;
>   	struct efi_device_path *net_dp;
> +#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
> +	struct efi_handler *phandler;
> +	struct efi_pxe_base_code_protocol *pxe;
> +#endif
>   	int i;
>  =20
>   	netobj =3D NULL;
> @@ -1097,17 +250,24 @@ efi_status_t efi_net_do_start(struct udevice *dev=
)
>   	if (r !=3D EFI_SUCCESS)
>   		return r;
>   set_addr:
> -#ifdef CONFIG_EFI_HTTP_PROTOCOL
> +#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
>   	/*
>   	 * No harm on doing the following. If the PXE handle is present, the =
client could
>   	 * find it and try to get its IP address from it. In here the PXE han=
dle is present
>   	 * but the PXE protocol is not yet implmenented, so we add this in th=
e meantime.
>   	 */
> -	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_=
ip,
> -			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL, dev=
);
> +	pxe =3D NULL;
> +	r =3D efi_search_protocol(&netobj->header,
> +				&efi_pxe_base_code_protocol_guid,
> +				&phandler);
> +	if (r =3D=3D EFI_SUCCESS && phandler) {
> +		pxe =3D phandler->protocol_interface;
> +		efi_net_get_addr((struct efi_ipv4_address *)&pxe->mode->station_ip,
> +				 (struct efi_ipv4_address *)&pxe->mode->subnet_mask, NULL, dev);
> +	}
>   #endif
>  =20
> -	return r;
> +	return EFI_SUCCESS;
>   }
>  =20
>   /**
> @@ -1121,9 +281,7 @@ efi_status_t efi_net_register(struct udevice *dev)
>   	efi_status_t r;
>   	int seq_num;
>   	struct efi_net_obj *netobj;
> -	void *transmit_buffer =3D NULL;
> -	uchar **receive_buffer =3D NULL;
> -	size_t *receive_lengths;
> +	struct efi_pxe_packet *dhcp_ack;
>   	int i, j;
>  =20
>   	if (!dev) {
> @@ -1150,161 +308,58 @@ efi_status_t efi_net_register(struct udevice *de=
v)
>  =20
>   	/* We only expose the "active" network device, so one is enough */
>   	netobj =3D calloc(1, sizeof(*netobj));
> -	if (!netobj)
> -		goto out_of_resources;
> -
> -	netobj->dev =3D dev;
> -
> -	/* Allocate an aligned transmit buffer */
> -	transmit_buffer =3D calloc(1, PKTSIZE_ALIGN + PKTALIGN);
> -	if (!transmit_buffer)
> -		goto out_of_resources;
> -	transmit_buffer =3D (void *)ALIGN((uintptr_t)transmit_buffer, PKTALIGN=
);
> -	netobj->transmit_buffer =3D transmit_buffer;
> -
> -	/* Allocate a number of receive buffers */
> -	receive_buffer =3D calloc(ETH_PACKETS_BATCH_RECV,
> -				sizeof(*receive_buffer));
> -	if (!receive_buffer)
> -		goto out_of_resources;
> -	for (i =3D 0; i < ETH_PACKETS_BATCH_RECV; i++) {
> -		receive_buffer[i] =3D malloc(PKTSIZE_ALIGN);
> -		if (!receive_buffer[i])
> -			goto out_of_resources;
> +	if (!netobj) {
> +		printf("ERROR: Out of memory\n");
> +		return EFI_OUT_OF_RESOURCES;
>   	}
> -	netobj->receive_buffer =3D receive_buffer;
>  =20
> -	receive_lengths =3D calloc(ETH_PACKETS_BATCH_RECV,
> -				 sizeof(*receive_lengths));
> -	if (!receive_lengths)
> -		goto out_of_resources;
> -	netobj->receive_lengths =3D receive_lengths;
> +	netobj->dev =3D dev;
>  =20
>   	/* Hook net up to the device list */
>   	efi_add_handle(&netobj->header);
>  =20
> -	/* Fill in object data */
> -	r =3D efi_add_protocol(&netobj->header, &efi_net_guid,
> -			     &netobj->net);
> +	/* Install EFI_SIMPLE_NETWORK_PROTOCOL */
> +	r =3D efi_simple_network_install(&netobj->header, dev);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>  =20
> -	r =3D efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_gu=
id,
> -			     &netobj->pxe);
> -	if (r !=3D EFI_SUCCESS)
> -		goto failure_to_add_protocol;
> -	netobj->net.revision =3D EFI_SIMPLE_NETWORK_PROTOCOL_REVISION;
> -	netobj->net.start =3D efi_net_start;
> -	netobj->net.stop =3D efi_net_stop;
> -	netobj->net.initialize =3D efi_net_initialize;
> -	netobj->net.reset =3D efi_net_reset;
> -	netobj->net.shutdown =3D efi_net_shutdown;
> -	netobj->net.receive_filters =3D efi_net_receive_filters;
> -	netobj->net.station_address =3D efi_net_station_address;
> -	netobj->net.statistics =3D efi_net_statistics;
> -	netobj->net.mcastiptomac =3D efi_net_mcastiptomac;
> -	netobj->net.nvdata =3D efi_net_nvdata;
> -	netobj->net.get_status =3D efi_net_get_status;
> -	netobj->net.transmit =3D efi_net_transmit;
> -	netobj->net.receive =3D efi_net_receive;
> -	netobj->net.mode =3D &netobj->net_mode;
> -	netobj->net_mode.state =3D EFI_NETWORK_STOPPED;
> -	if (dev_get_plat(dev))
> -		memcpy(netobj->net_mode.current_address.mac_addr,
> -		       ((struct eth_pdata *)dev_get_plat(dev))->enetaddr, 6);
> -	netobj->net_mode.hwaddr_size =3D ARP_HLEN;
> -	netobj->net_mode.media_header_size =3D ETHER_HDR_SIZE;
> -	netobj->net_mode.max_packet_size =3D PKTSIZE;
> -	netobj->net_mode.if_type =3D ARP_ETHER;
> -
> -	netobj->pxe.revision =3D EFI_PXE_BASE_CODE_PROTOCOL_REVISION;
> -	netobj->pxe.start =3D efi_pxe_base_code_start;
> -	netobj->pxe.stop =3D efi_pxe_base_code_stop;
> -	netobj->pxe.dhcp =3D efi_pxe_base_code_dhcp;
> -	netobj->pxe.discover =3D efi_pxe_base_code_discover;
> -	netobj->pxe.mtftp =3D efi_pxe_base_code_mtftp;
> -	netobj->pxe.udp_write =3D efi_pxe_base_code_udp_write;
> -	netobj->pxe.udp_read =3D efi_pxe_base_code_udp_read;
> -	netobj->pxe.set_ip_filter =3D efi_pxe_base_code_set_ip_filter;
> -	netobj->pxe.arp =3D efi_pxe_base_code_arp;
> -	netobj->pxe.set_parameters =3D efi_pxe_base_code_set_parameters;
> -	netobj->pxe.set_station_ip =3D efi_pxe_base_code_set_station_ip;
> -	netobj->pxe.set_packets =3D efi_pxe_base_code_set_packets;
> -	netobj->pxe.mode =3D &netobj->pxe_mode;
> -
>   	/*
>   	 * Scan dhcp entries for one corresponding
>   	 * to this udevice, from newest to oldest
>   	 */
> +	dhcp_ack =3D NULL;
>   	i =3D (next_dhcp_entry + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENT=
RIES;
>   	for (j =3D 0; dhcp_cache[i].is_valid && j < MAX_NUM_DHCP_ENTRIES;
>   	     i =3D (i + MAX_NUM_DHCP_ENTRIES - 1) % MAX_NUM_DHCP_ENTRIES, j++=
) {
>   		if (dev =3D=3D dhcp_cache[i].dev) {
> -			netobj->pxe_mode.dhcp_ack =3D *dhcp_cache[i].dhcp_ack;
> +			dhcp_ack =3D dhcp_cache[i].dhcp_ack;
>   			break;
>   		}
>   	}
>  =20
> -	/*
> -	 * Create WaitForPacket event.
> -	 */
> -	r =3D efi_create_event(EVT_NOTIFY_WAIT, TPL_CALLBACK,
> -			     efi_network_timer_notify, NULL, NULL,
> -			     &netobj->wait_for_packet);
> -	if (r !=3D EFI_SUCCESS) {
> -		printf("ERROR: Failed to register network event\n");
> -		return r;
> -	}
> -	netobj->net.wait_for_packet =3D netobj->wait_for_packet;
> -	/*
> -	 * Create a timer event.
> -	 *
> -	 * The notification function is used to check if a new network packet
> -	 * has been received.
> -	 *
> -	 * iPXE is running at TPL_CALLBACK most of the time. Use a higher TPL.
> -	 */
> -	r =3D efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_NOTIFY,
> -			     efi_network_timer_notify, &netobj->net, NULL,
> -			     &netobj->network_timer_event);
> -	if (r !=3D EFI_SUCCESS) {
> -		printf("ERROR: Failed to register network event\n");
> -		return r;
> -	}
> -	/* Network is time critical, create event in every timer cycle */
> -	r =3D efi_set_timer(netobj->network_timer_event, EFI_TIMER_PERIODIC, 0=
);
> -	if (r !=3D EFI_SUCCESS) {
> -		printf("ERROR: Failed to set network timer\n");
> -		return r;
> -	}
> +	/* Install EFI_PXE_BASE_CODE_PROTOCOL */
> +	r =3D efi_pxe_install(&netobj->header, dhcp_ack);
> +	if (r !=3D EFI_SUCCESS)
> +		goto failure_to_add_protocol;
>  =20
>   #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
> +	/* Install EFI_IP4_CONFIG2_PROTOCOL */
>   	r =3D efi_ip4_config2_install(&netobj->header);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   #endif
>   #ifdef CONFIG_EFI_HTTP_PROTOCOL
> +	/* Install EFI_HTTP_PROTOCOL */
>   	r =3D efi_http_install(&netobj->header);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   #endif
> -	netobj->efi_seq_num =3D seq_num;
> +
>   	net_objs[seq_num] =3D netobj;
>   	return EFI_SUCCESS;
>   failure_to_add_protocol:
>   	printf("ERROR: Failure to add protocol\n");
>   	return r;
> -out_of_resources:
> -	free(netobj);
> -	netobj =3D NULL;
> -	free(transmit_buffer);
> -	if (receive_buffer)
> -		for (i =3D 0; i < ETH_PACKETS_BATCH_RECV; i++)
> -			free(receive_buffer[i]);
> -	free(receive_buffer);
> -	free(receive_lengths);
> -	printf("ERROR: Out of memory\n");
> -	return EFI_OUT_OF_RESOURCES;
>   }
>  =20
>   /**
> @@ -1656,7 +711,8 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_h=
ttp_method method, void **buf
>   		ret =3D efi_search_protocol(&net_objs[i]->header,
>   					  &efi_http_service_binding_guid,
>   					  &phandler);
> -		if (ret =3D=3D EFI_SUCCESS && phandler =3D=3D (void *)parent) {
> +		if (ret =3D=3D EFI_SUCCESS && phandler &&
> +		    phandler->protocol_interface =3D=3D (void *)parent) {
>   			dev =3D net_objs[i]->dev;
>   			break;
>   		}
> diff --git a/lib/efi_loader/net/efi_pxe.c b/lib/efi_loader/net/efi_pxe.c
> new file mode 100644
> index 00000000000..69cc5f22f6d
> --- /dev/null
> +++ b/lib/efi_loader/net/efi_pxe.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PXE base code protocol
> + *
> + * Copyright (c) 2016 Alexander Graf
> + *
> + */
> +
> +#define LOG_CATEGORY LOGC_EFI
> +
> +#include <efi_loader.h>
> +#include <dm.h>
> +#include <linux/sizes.h>
> +#include <malloc.h>
> +#include <vsprintf.h>
> +#include <net.h>
> +
> +static const efi_guid_t efi_pxe_base_code_protocol_guid =3D
> +					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
> +
> +/**
> + * struct efi_pxe_base_code_extended_protocol - EFI object representing=
 a
> + *												EFI_PXE_BASE_CODE_PROTOCOL
> + *												interface
> + *
> + * @pxe:			PXE base code protocol interface
> + * @pxe_mode:			status of the PXE base code protocol
> +
> + */
> +struct efi_pxe_base_code_extended_protocol {
> +	struct efi_pxe_base_code_protocol pxe;
> +	struct efi_pxe_mode pxe_mode;
> +};
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_start(
> +				struct efi_pxe_base_code_protocol *this,
> +				u8 use_ipv6)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_stop(
> +				struct efi_pxe_base_code_protocol *this)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_dhcp(
> +				struct efi_pxe_base_code_protocol *this,
> +				u8 sort_offers)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_discover(
> +				struct efi_pxe_base_code_protocol *this,
> +				u16 type, u16 *layer, u8 bis,
> +				struct efi_pxe_base_code_discover_info *info)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_mtftp(
> +				struct efi_pxe_base_code_protocol *this,
> +				u32 operation, void *buffer_ptr,
> +				u8 overwrite, efi_uintn_t *buffer_size,
> +				struct efi_ip_address server_ip, char *filename,
> +				struct efi_pxe_base_code_mtftp_info *info,
> +				u8 dont_use_buffer)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_udp_write(
> +				struct efi_pxe_base_code_protocol *this,
> +				u16 op_flags, struct efi_ip_address *dest_ip,
> +				u16 *dest_port,
> +				struct efi_ip_address *gateway_ip,
> +				struct efi_ip_address *src_ip, u16 *src_port,
> +				efi_uintn_t *header_size, void *header_ptr,
> +				efi_uintn_t *buffer_size, void *buffer_ptr)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_udp_read(
> +				struct efi_pxe_base_code_protocol *this,
> +				u16 op_flags, struct efi_ip_address *dest_ip,
> +				u16 *dest_port, struct efi_ip_address *src_ip,
> +				u16 *src_port, efi_uintn_t *header_size,
> +				void *header_ptr, efi_uintn_t *buffer_size,
> +				void *buffer_ptr)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_set_ip_filter(
> +				struct efi_pxe_base_code_protocol *this,
> +				struct efi_pxe_base_code_filter *new_filter)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_arp(
> +				struct efi_pxe_base_code_protocol *this,
> +				struct efi_ip_address *ip_addr,
> +				struct efi_mac_address *mac_addr)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_set_parameters(
> +				struct efi_pxe_base_code_protocol *this,
> +				u8 *new_auto_arp, u8 *new_send_guid,
> +				u8 *new_ttl, u8 *new_tos,
> +				u8 *new_make_callback)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_set_station_ip(
> +				struct efi_pxe_base_code_protocol *this,
> +				struct efi_ip_address *new_station_ip,
> +				struct efi_ip_address *new_subnet_mask)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
> +				struct efi_pxe_base_code_protocol *this,
> +				u8 *new_dhcp_discover_valid,
> +				u8 *new_dhcp_ack_received,
> +				u8 *new_proxy_offer_received,
> +				u8 *new_pxe_discover_valid,
> +				u8 *new_pxe_reply_received,
> +				u8 *new_pxe_bis_reply_received,
> +				EFI_PXE_BASE_CODE_PACKET *new_dchp_discover,
> +				EFI_PXE_BASE_CODE_PACKET *new_dhcp_acc,
> +				EFI_PXE_BASE_CODE_PACKET *new_proxy_offer,
> +				EFI_PXE_BASE_CODE_PACKET *new_pxe_discover,
> +				EFI_PXE_BASE_CODE_PACKET *new_pxe_reply,
> +				EFI_PXE_BASE_CODE_PACKET *new_pxe_bis_reply)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +
> +/**
> + * efi_pxe_install() - install the EFI_PXE_BASE_CODE_PROTOCOL
> + *
> + * @handle:	handle to install the protocol
> + */
> +efi_status_t efi_pxe_install(const efi_handle_t handle,
> +			     struct efi_pxe_packet *dhcp_ack)
> +{
> +	efi_status_t r;
> +	struct efi_pxe_base_code_extended_protocol *pxe;
> +
> +	/* We only expose the "active" network device, so one is enough */
> +	pxe =3D calloc(1, sizeof(*pxe));
> +	if (!pxe) {
> +		printf("ERROR: Out of memory\n");
> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	pxe->pxe.revision =3D EFI_PXE_BASE_CODE_PROTOCOL_REVISION;
> +	pxe->pxe.start =3D efi_pxe_base_code_start;
> +	pxe->pxe.stop =3D efi_pxe_base_code_stop;
> +	pxe->pxe.dhcp =3D efi_pxe_base_code_dhcp;
> +	pxe->pxe.discover =3D efi_pxe_base_code_discover;
> +	pxe->pxe.mtftp =3D efi_pxe_base_code_mtftp;
> +	pxe->pxe.udp_write =3D efi_pxe_base_code_udp_write;
> +	pxe->pxe.udp_read =3D efi_pxe_base_code_udp_read;
> +	pxe->pxe.set_ip_filter =3D efi_pxe_base_code_set_ip_filter;
> +	pxe->pxe.arp =3D efi_pxe_base_code_arp;
> +	pxe->pxe.set_parameters =3D efi_pxe_base_code_set_parameters;
> +	pxe->pxe.set_station_ip =3D efi_pxe_base_code_set_station_ip;
> +	pxe->pxe.set_packets =3D efi_pxe_base_code_set_packets;
> +	pxe->pxe.mode =3D &pxe->pxe_mode;
> +
> +	if (dhcp_ack)
> +		pxe->pxe_mode.dhcp_ack =3D *dhcp_ack;
> +
> +	r =3D efi_add_protocol(handle, &efi_pxe_base_code_protocol_guid,
> +			     &pxe->pxe);
> +	if (r !=3D EFI_SUCCESS)
> +		return r;
> +
> +	return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/net/efi_simple_network.c b/lib/efi_loader/ne=
t/efi_simple_network.c
> new file mode 100644
> index 00000000000..c7c03062b11
> --- /dev/null
> +++ b/lib/efi_loader/net/efi_simple_network.c
> @@ -0,0 +1,880 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Simple network protocol
> + *
> + * Copyright (c) 2016 Alexander Graf
> + *
> + * The simple network protocol has the following statuses and services
> + * to move between them:
> + *
> + * Start():	 EfiSimpleNetworkStopped     -> EfiSimpleNetworkStarted
> + * Initialize(): EfiSimpleNetworkStarted     -> EfiSimpleNetworkInitial=
ized
> + * Shutdown():	 EfiSimpleNetworkInitialized -> EfiSimpleNetworkStarted
> + * Stop():	 EfiSimpleNetworkStarted     -> EfiSimpleNetworkStopped
> + * Reset():	 EfiSimpleNetworkInitialized -> EfiSimpleNetworkInitialized
> + */
> +
> +#define LOG_CATEGORY LOGC_EFI
> +
> +#include <efi_loader.h>
> +#include <dm.h>
> +#include <linux/sizes.h>
> +#include <malloc.h>
> +#include <vsprintf.h>
> +#include <net.h>
> +
> +static const efi_guid_t efi_net_guid =3D EFI_SIMPLE_NETWORK_PROTOCOL_GU=
ID;
> +
> +/**
> + * struct efi_simple_network_extended_protocol - EFI object representin=
g an
> + *						 EFI_SIMPLE_NETWORK_PROTOCOL
> + *						 interface
> + *
> + * @net:			simple network protocol interface
> + * @net_mode:			status of the network interface
> + * @dev:			net udevice
> + * @new_tx_packet:		new transmit packet
> + * @transmit_buffer:	transmit buffer
> + * @receive_buffer:		array of receive buffers
> + * @receive_lengths:	array of lengths for received packets
> + * @rx_packet_idx:		index of the current receive packet
> + * @rx_packet_num:		number of received packets
> + * @wait_for_packet:	signaled when a packet has been received
> + * @network_timer_event:	event to check for new network packets.
> + */
> +struct efi_simple_network_extended_protocol {
> +	struct efi_simple_network_protocol net;
> +	struct efi_simple_network_mode net_mode;
> +	struct udevice *dev;
> +	void *new_tx_packet;
> +	void *transmit_buffer;
> +	uchar **receive_buffer;
> +	size_t *receive_lengths;
> +	int rx_packet_idx;
> +	int rx_packet_num;
> +	struct efi_event *wait_for_packet;
> +	struct efi_event *network_timer_event;
> +};
> +
> +static struct efi_simple_network_extended_protocol *current_network;
> +
> +/*
> + * efi_net_start() - start the network interface
> + *
> + * This function implements the Start service of the
> + * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_net_start(struct efi_simple_network_prot=
ocol *this)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_simple_network_extended_protocol *nt;
> +
> +	EFI_ENTRY("%p", this);
> +	/* Check parameters */
> +	if (!this) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	nt =3D (struct efi_simple_network_extended_protocol *)this;
> +
> +	if (this->mode->state !=3D EFI_NETWORK_STOPPED) {
> +		ret =3D EFI_ALREADY_STARTED;
> +	} else {
> +		this->int_status =3D 0;
> +		nt->wait_for_packet->is_signaled =3D false;
> +		this->mode->state =3D EFI_NETWORK_STARTED;
> +	}
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_net_stop() - stop the network interface
> + *
> + * This function implements the Stop service of the
> + * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network_proto=
col *this)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_simple_network_extended_protocol *nt;
> +
> +	EFI_ENTRY("%p", this);
> +
> +	/* Check parameters */
> +	if (!this) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	nt =3D (struct efi_simple_network_extended_protocol *)this;
> +
> +	if (this->mode->state =3D=3D EFI_NETWORK_STOPPED) {
> +		ret =3D EFI_NOT_STARTED;
> +	} else {
> +		/* Disable hardware and put it into the reset state */
> +		eth_set_dev(nt->dev);
> +		env_set("ethact", eth_get_name());
> +		eth_halt();
> +		/* Clear cache of packets */
> +		nt->rx_packet_num =3D 0;
> +		this->mode->state =3D EFI_NETWORK_STOPPED;
> +	}
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_net_initialize() - initialize the network interface
> + *
> + * This function implements the Initialize service of the
> + * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * @extra_rx:	extra receive buffer to be allocated
> + * @extra_tx:	extra transmit buffer to be allocated
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_net_initialize(struct efi_simple_network=
_protocol *this,
> +					      ulong extra_rx, ulong extra_tx)
> +{
> +	int ret;
> +	efi_status_t r =3D EFI_SUCCESS;
> +	struct efi_simple_network_extended_protocol *nt;
> +
> +	EFI_ENTRY("%p, %lx, %lx", this, extra_rx, extra_tx);
> +
> +	/* Check parameters */
> +	if (!this) {
> +		r =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	nt =3D (struct efi_simple_network_extended_protocol *)this;
> +
> +	switch (this->mode->state) {
> +	case EFI_NETWORK_INITIALIZED:
> +	case EFI_NETWORK_STARTED:
> +		break;
> +	default:
> +		r =3D EFI_NOT_STARTED;
> +		goto out;
> +	}
> +
> +	/* Setup packet buffers */
> +	net_init();
> +	/* Clear cache of packets */
> +	nt->rx_packet_num =3D 0;
> +	/* Set the net device corresponding to the efi net object */
> +	eth_set_dev(nt->dev);
> +	env_set("ethact", eth_get_name());
> +	/* Get hardware ready for send and receive operations */
> +	ret =3D eth_start_udev(nt->dev);
> +	if (ret < 0) {
> +		eth_halt();
> +		this->mode->state =3D EFI_NETWORK_STOPPED;
> +		r =3D EFI_DEVICE_ERROR;
> +		goto out;
> +	} else {
> +		this->int_status =3D 0;
> +		nt->wait_for_packet->is_signaled =3D false;
> +		this->mode->state =3D EFI_NETWORK_INITIALIZED;
> +	}
> +out:
> +	return EFI_EXIT(r);
> +}
> +
> +/*
> + * efi_net_reset() - reinitialize the network interface
> + *
> + * This function implements the Reset service of the
> + * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> + * (UEFI) specification for details.
> + *
> + * @this:			pointer to the protocol instance
> + * @extended_verification:	execute exhaustive verification
> + * Return:			status code
> + */
> +static efi_status_t EFIAPI efi_net_reset(struct efi_simple_network_prot=
ocol *this,
> +					 int extended_verification)
> +{
> +	efi_status_t ret;
> +
> +	EFI_ENTRY("%p, %x", this, extended_verification);
> +
> +	/* Check parameters */
> +	if (!this) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	switch (this->mode->state) {
> +	case EFI_NETWORK_INITIALIZED:
> +		break;
> +	case EFI_NETWORK_STOPPED:
> +		ret =3D EFI_NOT_STARTED;
> +		goto out;
> +	default:
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto out;
> +	}
> +
> +	this->mode->state =3D EFI_NETWORK_STARTED;
> +	ret =3D EFI_CALL(efi_net_initialize(this, 0, 0));
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_net_shutdown() - shut down the network interface
> + *
> + * This function implements the Shutdown service of the
> + * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network_p=
rotocol *this)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_simple_network_extended_protocol *nt;
> +
> +	EFI_ENTRY("%p", this);
> +
> +	/* Check parameters */
> +	if (!this) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +	nt =3D (struct efi_simple_network_extended_protocol *)this;
> +
> +	switch (this->mode->state) {
> +	case EFI_NETWORK_INITIALIZED:
> +		break;
> +	case EFI_NETWORK_STOPPED:
> +		ret =3D EFI_NOT_STARTED;
> +		goto out;
> +	default:
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto out;
> +	}
> +
> +	eth_set_dev(nt->dev);
> +	env_set("ethact", eth_get_name());
> +	eth_halt();
> +
> +	this->int_status =3D 0;
> +	nt->wait_for_packet->is_signaled =3D false;
> +	this->mode->state =3D EFI_NETWORK_STARTED;
> +
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_net_receive_filters() - mange multicast receive filters
> + *
> + * This function implements the ReceiveFilters service of the
> + * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> + * (UEFI) specification for details.
> + *
> + * @this:		pointer to the protocol instance
> + * @enable:		bit mask of receive filters to enable
> + * @disable:		bit mask of receive filters to disable
> + * @reset_mcast_filter:	true resets contents of the filters
> + * @mcast_filter_count:	number of hardware MAC addresses in the new fil=
ters list
> + * @mcast_filter:	list of new filters
> + * Return:		status code
> + */
> +static efi_status_t EFIAPI efi_net_receive_filters
> +		(struct efi_simple_network_protocol *this, u32 enable, u32 disable,
> +		 int reset_mcast_filter, ulong mcast_filter_count,
> +		 struct efi_mac_address *mcast_filter)
> +{
> +	EFI_ENTRY("%p, %x, %x, %x, %lx, %p", this, enable, disable,
> +		  reset_mcast_filter, mcast_filter_count, mcast_filter);
> +
> +	return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +/*
> + * efi_net_station_address() - set the hardware MAC address
> + *
> + * This function implements the StationAddress service of the
> + * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * @reset:	if true reset the address to default
> + * @new_mac:	new MAC address
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_net_station_address
> +		(struct efi_simple_network_protocol *this, int reset,
> +		 struct efi_mac_address *new_mac)
> +{
> +	EFI_ENTRY("%p, %x, %p", this, reset, new_mac);
> +
> +	return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +/*
> + * efi_net_statistics() - reset or collect statistics of the network in=
terface
> + *
> + * This function implements the Statistics service of the
> + * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * @reset:	if true, the statistics are reset
> + * @stat_size:	size of the statistics table
> + * @stat_table:	table to receive the statistics
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_net_statistics(struct efi_simple_network=
_protocol *this,
> +					      int reset, ulong *stat_size,
> +					      void *stat_table)
> +{
> +	EFI_ENTRY("%p, %x, %p, %p", this, reset, stat_size, stat_table);
> +
> +	return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +/*
> + * efi_net_mcastiptomac() - translate multicast IP address to MAC addre=
ss
> + *
> + * This function implements the MCastIPtoMAC service of the
> + * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Int=
erface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * @ipv6:	true if the IP address is an IPv6 address
> + * @ip:		IP address
> + * @mac:	MAC address
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_net_mcastiptomac(struct efi_simple_netwo=
rk_protocol *this,
> +						int ipv6,
> +						struct efi_ip_address *ip,
> +						struct efi_mac_address *mac)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +
> +	EFI_ENTRY("%p, %x, %p, %p", this, ipv6, ip, mac);
> +
> +	if (!this || !ip || !mac) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	if (ipv6) {
> +		ret =3D EFI_UNSUPPORTED;
> +		goto out;
> +	}
> +
> +	/* Multi-cast addresses are in the range 224.0.0.0 - 239.255.255.255 *=
/
> +	if ((ip->ip_addr[0] & 0xf0) !=3D 0xe0) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	};
> +
> +	switch (this->mode->state) {
> +	case EFI_NETWORK_INITIALIZED:
> +	case EFI_NETWORK_STARTED:
> +		break;
> +	default:
> +		ret =3D EFI_NOT_STARTED;
> +		goto out;
> +	}
> +
> +	memset(mac, 0, sizeof(struct efi_mac_address));
> +
> +	/*
> +	 * Copy lower 23 bits of IPv4 multi-cast address
> +	 * RFC 1112, RFC 7042 2.1.1.
> +	 */
> +	mac->mac_addr[0] =3D 0x01;
> +	mac->mac_addr[1] =3D 0x00;
> +	mac->mac_addr[2] =3D 0x5E;
> +	mac->mac_addr[3] =3D ip->ip_addr[1] & 0x7F;
> +	mac->mac_addr[4] =3D ip->ip_addr[2];
> +	mac->mac_addr[5] =3D ip->ip_addr[3];
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/**
> + * efi_net_nvdata() - read or write NVRAM
> + *
> + * This function implements the GetStatus service of the Simple Network
> + * Protocol. See the UEFI spec for details.
> + *
> + * @this:		the instance of the Simple Network Protocol
> + * @read_write:		true for read, false for write
> + * @offset:		offset in NVRAM
> + * @buffer_size:	size of buffer
> + * @buffer:		buffer
> + * Return:		status code
> + */
> +static efi_status_t EFIAPI efi_net_nvdata(struct efi_simple_network_pro=
tocol *this,
> +					  int read_write, ulong offset,
> +					  ulong buffer_size, char *buffer)
> +{
> +	EFI_ENTRY("%p, %x, %lx, %lx, %p", this, read_write, offset, buffer_siz=
e,
> +		  buffer);
> +
> +	return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +/**
> + * efi_net_get_status() - get interrupt status
> + *
> + * This function implements the GetStatus service of the Simple Network
> + * Protocol. See the UEFI spec for details.
> + *
> + * @this:		the instance of the Simple Network Protocol
> + * @int_status:		interface status
> + * @txbuf:		transmission buffer
> + */
> +static efi_status_t EFIAPI efi_net_get_status(struct efi_simple_network=
_protocol *this,
> +					      u32 *int_status, void **txbuf)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_simple_network_extended_protocol *nt;
> +
> +	EFI_ENTRY("%p, %p, %p", this, int_status, txbuf);
> +
> +	efi_timer_check();
> +
> +	/* Check parameters */
> +	if (!this) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	nt =3D (struct efi_simple_network_extended_protocol *)this;
> +
> +	switch (this->mode->state) {
> +	case EFI_NETWORK_STOPPED:
> +		ret =3D EFI_NOT_STARTED;
> +		goto out;
> +	case EFI_NETWORK_STARTED:
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto out;
> +	default:
> +		break;
> +	}
> +
> +	if (int_status) {
> +		*int_status =3D this->int_status;
> +		this->int_status =3D 0;
> +	}
> +	if (txbuf)
> +		*txbuf =3D nt->new_tx_packet;
> +
> +	nt->new_tx_packet =3D NULL;
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/**
> + * efi_net_transmit() - transmit a packet
> + *
> + * This function implements the Transmit service of the Simple Network =
Protocol.
> + * See the UEFI spec for details.
> + *
> + * @this:		the instance of the Simple Network Protocol
> + * @header_size:	size of the media header
> + * @buffer_size:	size of the buffer to receive the packet
> + * @buffer:		buffer to receive the packet
> + * @src_addr:		source hardware MAC address
> + * @dest_addr:		destination hardware MAC address
> + * @protocol:		type of header to build
> + * Return:		status code
> + */
> +static efi_status_t EFIAPI efi_net_transmit
> +		(struct efi_simple_network_protocol *this, size_t header_size,
> +		 size_t buffer_size, void *buffer,
> +		 struct efi_mac_address *src_addr,
> +		 struct efi_mac_address *dest_addr, u16 *protocol)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_simple_network_extended_protocol *nt;
> +
> +	EFI_ENTRY("%p, %lu, %lu, %p, %p, %p, %p", this,
> +		  (unsigned long)header_size, (unsigned long)buffer_size,
> +		  buffer, src_addr, dest_addr, protocol);
> +
> +	efi_timer_check();
> +
> +	/* Check parameters */
> +	if (!this || !buffer) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	nt =3D (struct efi_simple_network_extended_protocol *)this;
> +
> +	/* We do not support jumbo packets */
> +	if (buffer_size > PKTSIZE_ALIGN) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/* At least the IP header has to fit into the buffer */
> +	if (buffer_size < this->mode->media_header_size) {
> +		ret =3D EFI_BUFFER_TOO_SMALL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * TODO:
> +	 * Support VLANs. Use net_set_ether() for copying the header. Use a
> +	 * U_BOOT_ENV_CALLBACK to update the media header size.
> +	 */
> +	if (header_size) {
> +		struct ethernet_hdr *header =3D buffer;
> +
> +		if (!dest_addr || !protocol ||
> +		    header_size !=3D this->mode->media_header_size) {
> +			ret =3D EFI_INVALID_PARAMETER;
> +			goto out;
> +		}
> +		if (!src_addr)
> +			src_addr =3D &this->mode->current_address;
> +
> +		memcpy(header->et_dest, dest_addr, ARP_HLEN);
> +		memcpy(header->et_src, src_addr, ARP_HLEN);
> +		header->et_protlen =3D htons(*protocol);
> +	}
> +
> +	switch (this->mode->state) {
> +	case EFI_NETWORK_STOPPED:
> +		ret =3D EFI_NOT_STARTED;
> +		goto out;
> +	case EFI_NETWORK_STARTED:
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto out;
> +	default:
> +		break;
> +	}
> +
> +	eth_set_dev(nt->dev);
> +	env_set("ethact", eth_get_name());
> +
> +	/* Ethernet packets always fit, just bounce */
> +	memcpy(nt->transmit_buffer, buffer, buffer_size);
> +	net_send_packet(nt->transmit_buffer, buffer_size);
> +
> +	nt->new_tx_packet =3D buffer;
> +	this->int_status |=3D EFI_SIMPLE_NETWORK_TRANSMIT_INTERRUPT;
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/**
> + * efi_net_receive() - receive a packet from a network interface
> + *
> + * This function implements the Receive service of the Simple Network P=
rotocol.
> + * See the UEFI spec for details.
> + *
> + * @this:		the instance of the Simple Network Protocol
> + * @header_size:	size of the media header
> + * @buffer_size:	size of the buffer to receive the packet
> + * @buffer:		buffer to receive the packet
> + * @src_addr:		source MAC address
> + * @dest_addr:		destination MAC address
> + * @protocol:		protocol
> + * Return:		status code
> + */
> +static efi_status_t EFIAPI efi_net_receive
> +		(struct efi_simple_network_protocol *this, size_t *header_size,
> +		 size_t *buffer_size, void *buffer,
> +		 struct efi_mac_address *src_addr,
> +		 struct efi_mac_address *dest_addr, u16 *protocol)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct ethernet_hdr *eth_hdr;
> +	size_t hdr_size =3D sizeof(struct ethernet_hdr);
> +	u16 protlen;
> +	struct efi_simple_network_extended_protocol *nt;
> +
> +	EFI_ENTRY("%p, %p, %p, %p, %p, %p, %p", this, header_size,
> +		  buffer_size, buffer, src_addr, dest_addr, protocol);
> +
> +	/* Execute events */
> +	efi_timer_check();
> +
> +	/* Check parameters */
> +	if (!this || !buffer || !buffer_size) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	nt =3D (struct efi_simple_network_extended_protocol *)this;
> +
> +	switch (this->mode->state) {
> +	case EFI_NETWORK_STOPPED:
> +		ret =3D EFI_NOT_STARTED;
> +		goto out;
> +	case EFI_NETWORK_STARTED:
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto out;
> +	default:
> +		break;
> +	}
> +
> +	if (!nt->rx_packet_num) {
> +		ret =3D EFI_NOT_READY;
> +		goto out;
> +	}
> +	/* Fill export parameters */
> +	eth_hdr =3D (struct ethernet_hdr *)nt->receive_buffer[nt->rx_packet_id=
x];
> +	protlen =3D ntohs(eth_hdr->et_protlen);
> +	if (protlen =3D=3D 0x8100) {
> +		hdr_size +=3D 4;
> +		protlen =3D ntohs(*(u16 *)&nt->receive_buffer[nt->rx_packet_idx][hdr_=
size - 2]);
> +	}
> +	if (header_size)
> +		*header_size =3D hdr_size;
> +	if (dest_addr)
> +		memcpy(dest_addr, eth_hdr->et_dest, ARP_HLEN);
> +	if (src_addr)
> +		memcpy(src_addr, eth_hdr->et_src, ARP_HLEN);
> +	if (protocol)
> +		*protocol =3D protlen;
> +	if (*buffer_size < nt->receive_lengths[nt->rx_packet_idx]) {
> +		/* Packet doesn't fit, try again with bigger buffer */
> +		*buffer_size =3D nt->receive_lengths[nt->rx_packet_idx];
> +		ret =3D EFI_BUFFER_TOO_SMALL;
> +		goto out;
> +	}
> +	/* Copy packet */
> +	memcpy(buffer, nt->receive_buffer[nt->rx_packet_idx],
> +	       nt->receive_lengths[nt->rx_packet_idx]);
> +	*buffer_size =3D nt->receive_lengths[nt->rx_packet_idx];
> +	nt->rx_packet_idx =3D (nt->rx_packet_idx + 1) % ETH_PACKETS_BATCH_RECV=
;
> +	nt->rx_packet_num--;
> +	if (nt->rx_packet_num)
> +		nt->wait_for_packet->is_signaled =3D true;
> +	else
> +		this->int_status &=3D ~EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/**
> + * efi_net_push() - callback for received network packet
> + *
> + * This function is called when a network packet is received by eth_rx(=
).
> + *
> + * @pkt:	network packet
> + * @len:	length
> + */
> +static void efi_net_push(void *pkt, int len)
> +{
> +	int rx_packet_next;
> +	struct efi_simple_network_extended_protocol *nt;
> +
> +	nt =3D current_network;
> +	if (!nt)
> +		return;
> +
> +	/* Check that we at least received an Ethernet header */
> +	if (len < sizeof(struct ethernet_hdr))
> +		return;
> +
> +	/* Check that the buffer won't overflow */
> +	if (len > PKTSIZE_ALIGN)
> +		return;
> +
> +	/* Can't store more than pre-alloced buffer */
> +	if (nt->rx_packet_num >=3D ETH_PACKETS_BATCH_RECV)
> +		return;
> +
> +	rx_packet_next =3D (nt->rx_packet_idx + nt->rx_packet_num) %
> +	    ETH_PACKETS_BATCH_RECV;
> +	memcpy(nt->receive_buffer[rx_packet_next], pkt, len);
> +	nt->receive_lengths[rx_packet_next] =3D len;
> +
> +	nt->rx_packet_num++;
> +}
> +
> +/**
> + * efi_network_timer_notify() - check if a new network packet has been =
received
> + *
> + * This notification function is called in every timer cycle.
> + *
> + * @event:	the event for which this notification function is registered
> + * @context:	event context - not used in this function
> + */
> +static void EFIAPI efi_network_timer_notify(struct efi_event *event,
> +					    void *context)
> +{
> +	struct efi_simple_network_extended_protocol *nt;
> +
> +	EFI_ENTRY("%p, %p", event, context);
> +
> +	nt =3D (struct efi_simple_network_extended_protocol *)context;
> +
> +	/*
> +	 * Some network drivers do not support calling eth_rx() before
> +	 * initialization.
> +	 */
> +	if (!nt || nt->net.mode->state !=3D EFI_NETWORK_INITIALIZED)
> +		goto out;
> +
> +	current_network =3D nt;
> +
> +	if (!nt->rx_packet_num) {
> +		eth_set_dev(nt->dev);
> +		env_set("ethact", eth_get_name());
> +		push_packet =3D efi_net_push;
> +		eth_rx();
> +		push_packet =3D NULL;
> +		if (nt->rx_packet_num) {
> +			nt->net.int_status |=3D
> +				EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
> +			nt->wait_for_packet->is_signaled =3D true;
> +		}
> +	}
> +out:
> +	EFI_EXIT(EFI_SUCCESS);
> +}
> +
> +/**
> + * efi_simple_network_install() - install the EFI_SIMPLE_NETWORK_PROTOC=
OL
> + *
> + * @handle:	handle to install the protocol
> + * @dev:	net udevice
> + */
> +efi_status_t efi_simple_network_install(const efi_handle_t handle, stru=
ct udevice *dev)
> +{
> +	efi_status_t r;
> +	struct efi_simple_network_extended_protocol *simple_network;
> +	void *transmit_buffer =3D NULL;
> +	uchar **receive_buffer =3D NULL;
> +	size_t *receive_lengths;
> +	int i;
> +
> +	if (!dev) {
> +		/* No network device active, don't expose any */
> +		return EFI_SUCCESS;
> +	}
> +
> +	/* We only expose the "active" network device, so one is enough */
> +	simple_network =3D calloc(1, sizeof(*simple_network));
> +	if (!simple_network)
> +		goto out_of_resources;
> +
> +	simple_network->dev =3D dev;
> +
> +	/* Allocate an aligned transmit buffer */
> +	transmit_buffer =3D calloc(1, PKTSIZE_ALIGN + PKTALIGN);
> +	if (!transmit_buffer)
> +		goto out_of_resources;
> +	transmit_buffer =3D (void *)ALIGN((uintptr_t)transmit_buffer, PKTALIGN=
);
> +	simple_network->transmit_buffer =3D transmit_buffer;
> +
> +	/* Allocate a number of receive buffers */
> +	receive_buffer =3D calloc(ETH_PACKETS_BATCH_RECV,
> +				sizeof(*receive_buffer));
> +	if (!receive_buffer)
> +		goto out_of_resources;
> +	for (i =3D 0; i < ETH_PACKETS_BATCH_RECV; i++) {
> +		receive_buffer[i] =3D malloc(PKTSIZE_ALIGN);
> +		if (!receive_buffer[i])
> +			goto out_of_resources;
> +	}
> +	simple_network->receive_buffer =3D receive_buffer;
> +
> +	receive_lengths =3D calloc(ETH_PACKETS_BATCH_RECV,
> +				 sizeof(*receive_lengths));
> +	if (!receive_lengths)
> +		goto out_of_resources;
> +	simple_network->receive_lengths =3D receive_lengths;
> +
> +	simple_network->net.revision =3D EFI_SIMPLE_NETWORK_PROTOCOL_REVISION;
> +	simple_network->net.start =3D efi_net_start;
> +	simple_network->net.stop =3D efi_net_stop;
> +	simple_network->net.initialize =3D efi_net_initialize;
> +	simple_network->net.reset =3D efi_net_reset;
> +	simple_network->net.shutdown =3D efi_net_shutdown;
> +	simple_network->net.receive_filters =3D efi_net_receive_filters;
> +	simple_network->net.station_address =3D efi_net_station_address;
> +	simple_network->net.statistics =3D efi_net_statistics;
> +	simple_network->net.mcastiptomac =3D efi_net_mcastiptomac;
> +	simple_network->net.nvdata =3D efi_net_nvdata;
> +	simple_network->net.get_status =3D efi_net_get_status;
> +	simple_network->net.transmit =3D efi_net_transmit;
> +	simple_network->net.receive =3D efi_net_receive;
> +	simple_network->net.mode =3D &simple_network->net_mode;
> +	simple_network->net_mode.state =3D EFI_NETWORK_STOPPED;
> +	if (dev_get_plat(dev))
> +		memcpy(simple_network->net_mode.current_address.mac_addr,
> +		       ((struct eth_pdata *)dev_get_plat(dev))->enetaddr, 6);
> +	simple_network->net_mode.hwaddr_size =3D ARP_HLEN;
> +	simple_network->net_mode.media_header_size =3D ETHER_HDR_SIZE;
> +	simple_network->net_mode.max_packet_size =3D PKTSIZE;
> +	simple_network->net_mode.if_type =3D ARP_ETHER;
> +
> +	/*
> +	 * Create WaitForPacket event.
> +	 */
> +	r =3D efi_create_event(EVT_NOTIFY_WAIT, TPL_CALLBACK,
> +			     efi_network_timer_notify, NULL, NULL,
> +			     &simple_network->wait_for_packet);
> +	if (r !=3D EFI_SUCCESS) {
> +		printf("ERROR: Failed to register network event\n");
> +		return r;
> +	}
> +	simple_network->net.wait_for_packet =3D simple_network->wait_for_packe=
t;
> +	/*
> +	 * Create a timer event.
> +	 *
> +	 * The notification function is used to check if a new network packet
> +	 * has been received.
> +	 *
> +	 * iPXE is running at TPL_CALLBACK most of the time. Use a higher TPL.
> +	 */
> +	r =3D efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_NOTIFY,
> +			     efi_network_timer_notify, simple_network, NULL,
> +			     &simple_network->network_timer_event);
> +	if (r !=3D EFI_SUCCESS) {
> +		printf("ERROR: Failed to register network event\n");
> +		return r;
> +	}
> +	/* Network is time critical, create event in every timer cycle */
> +	r =3D efi_set_timer(simple_network->network_timer_event, EFI_TIMER_PER=
IODIC, 0);
> +	if (r !=3D EFI_SUCCESS) {
> +		printf("ERROR: Failed to set network timer\n");

If the installation fails, we should free whatever we allocated. So I=20
guess we should jump to out_of_resources.

> +		return r;
> +	}
> +
> +	r =3D efi_add_protocol(handle, &efi_net_guid,
> +			     &simple_network->net);
> +	if (r !=3D EFI_SUCCESS)

ditto

The missing part is deleting the event.

Best regards

Heinrich

> +		return r;
> +
> +	return EFI_SUCCESS;
> +out_of_resources:
> +	free(simple_network);
> +	free(transmit_buffer);
> +	if (receive_buffer)
> +		for (i =3D 0; i < ETH_PACKETS_BATCH_RECV; i++)
> +			free(receive_buffer[i]);
> +	free(receive_buffer);
> +	free(receive_lengths);
> +	printf("ERROR: Out of memory\n");
> +	return EFI_OUT_OF_RESOURCES;
> +}
> diff --git a/lib/efi_selftest/efi_selftest_snp.c b/lib/efi_selftest/efi_=
selftest_snp.c
> index b00c76c2f17..82ed3587d6f 100644
> --- a/lib/efi_selftest/efi_selftest_snp.c
> +++ b/lib/efi_selftest/efi_selftest_snp.c
> @@ -17,6 +17,8 @@
>   #include <efi_selftest.h>
>   #include <net.h>
>  =20
> +static const efi_guid_t efi_net_guid =3D EFI_SIMPLE_NETWORK_PROTOCOL_GU=
ID;
> +
>   /*
>    * MAC address for broadcasts
>    */
> @@ -65,7 +67,7 @@ struct dhcp {
>   } __packed;
>  =20
>   static struct efi_boot_services *boottime;
> -static struct efi_simple_network *net;
> +static struct efi_simple_network_protocol *net;
>   static struct efi_event *timer;
>   /* IP packet ID */
>   static unsigned int net_ip_id;

