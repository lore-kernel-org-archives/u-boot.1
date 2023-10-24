Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F748C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 06:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE1ED8708A;
	Tue, 24 Oct 2023 08:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Y6UQiP9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526C2870DE; Tue, 24 Oct 2023 08:19:18 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC2487086
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 08:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698128350; x=1698733150; i=xypron.glpk@gmx.de;
 bh=7ZNE6hdS72Jh493PgyJwtUo7AcWbkEsIzTcMTxWt4MI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Y6UQiP9MG4gOI1ldCRjr+8ww+GFF7ElCMucbD3MGy7iLDiUCmRSFdDhQO8JCFaHj
 jSaxBOlxyk5neVUIkPMWmR41iwESASY2pHQHdDXOgROqIUFj0EAoiq7r+NUcA1MYa
 4WOksD4GWubx4B5dQmfBzEDjRbviJcasbH9uyB2qoXMA9IGKx7Ja8F4dTzxpWJ2Cd
 LEQ5dT2ZTKA4dWGT4P8BrDEExBa6VUoDWqI4PMk7pCPT/+YJSoPdgOBCIM1YQGVzY
 4MVjdpCv6RtqcSvOIlrYVfm/Y+7Avc0M/Y5oWYtAI/0vjRUvrdmPBDjmwv1DhjfA4
 xlGJrLvw1CzpG49C6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1rk7Ld1awp-00sye5; Tue, 24
 Oct 2023 08:19:10 +0200
Message-ID: <fd350aa1-7c67-480f-9570-d10f5e4140aa@gmx.de>
Date: Tue, 24 Oct 2023 08:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] net: bootp: add config option BOOTP_RANDOM_XID
Content-Language: en-US, de-DE
To: seanedmond@linux.microsoft.com
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de,
 Jim Liu <jim.t90615@gmail.com>
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-4-seanedmond@linux.microsoft.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231024002159.74477-4-seanedmond@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fs3Ccz+aRwtvp6QKs8kCXlRnW8WvHXio4hZSxtrcSZWY3tEbwW0
 eS5zDxGqt+7uaPVm5Y/b8WbfiYy60R3Qd7mlp+jCRXIxJ0adsUbMPxKO9r6hgmoljVAho7s
 z1dRkYbcsfPVFwwf1LveVEm22PBaSs6tU72fe1fV5rk94hXRjQ7X2pvh07SZf1fwJPuVUTd
 1aIGr7fUSy3R8iprUDuhg==
UI-OutboundReport: notjunk:1;M01:P0:amxk7M2DXAE=;Xj3fORf94syxHMYH6qB6+wamp8h
 nOLesB3hAhok6Iqny3Hep40h83NfZTJH1f6yzFRHzTHjjktu8VtVrwgvXkV+FBwYB0SuskrK5
 R8grQ8/bGuXaj6fjXBB4CGCVjnG/D5X8PUxllz8ptw8n9j37NGp1/HaOiDL4oUcZT+BOHwnp+
 9rzxwPgG//+ftsNZyQNLduOsBtoWGCkpKDdNSHiFjZIOCnQnJxSOpUgo46AnoJmV8l4IkXOx6
 DwkAdkXyhYyGUeFQcK2kaFMLza0rL0m2rJc/iMow49T0aPQ3L/AEw3JM3fd/R15fYiix5zYcg
 jXM54bR3q7aDwI+eKzymbhgUFOk8XmkW5fno90YU/cezt5bi6h7Uu5oh3K5WIhLuY78Do2jq5
 tccTH5cCi/QUv1m4Y6SfX18To3nxh/Y3dRTQ9OSpvVVGpYi8UWyDm0R/VOqktsz0GWX8FEahB
 ujK44vKm/P4oRG81Z1bGf5MROqjUEg5Q99UuwuumVWTBtqNoWIgLwV34KhEysSwMXVksR8JhF
 OI6YWO9sc58Y0zx3hIyfy1zKbqkfgUVLvuZkq0O4t12S+gzlryOkk2HolTND9u0eYySgIUu13
 6qUOpaYKXN5kZxs8tMV1do+m6+gEXbFMmnTYpoftUdfo0XDRt6Z9ki3Ey90NtC7bkpzpbMjpa
 EkR7gMm7St8LCE9jxxaBmEwUVqgHb/ygahnRrdYJOHC1BUn9+N2xx2C7ZDO5YIUBl1XOxmcRN
 iE9ePgpP7xU+v62CVF3z7HNzphJaIzK1PovIyq6SHTjdaPELExOPrI+NyjtVGZ2BwTQIajIsg
 w085+G8zKFPDms5+Uhoc/W4eQ6pOoODYkVe/3m5vSoM1zuQ0wiveqJ00DmpfDEGKkDag/C9jL
 4PGq69HJy/Z6vGWElR/XGgJqvNlDW8+HKaV/xcjxlhEjY/Z9GAfAw8Azr2itFRKq5MojGCn9H
 o5hL/MaKIuiGU4+Zn6/47b4uOOc=
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

On 10/24/23 02:21, seanedmond@linux.microsoft.com wrote:
> From: Sean Edmond <seanedmond@microsoft.com>
>
> The new config option BOOTP_RANDOM_XID will randomize the transaction ID
> for each new BOOT/DHCPv4 exchange.
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>   cmd/Kconfig |  7 +++++++
>   net/bootp.c | 31 +++++++++++++++++--------------
>   2 files changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index adbb1a6187..910f465d14 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1838,6 +1838,13 @@ config BOOTP_VCI_STRING
>   	default "U-Boot.arm" if ARM
>   	default "U-Boot"
>
> +config BOOTP_RANDOM_XID
> +	bool "Send random transaction ID to BOOTP/DHCP server"
> +	depends on CMD_BOOTP

The rand() function requires CONFIG_LIB_RAND=3Dy or
CONFIG_EXYNOS_ACE_SHA=3Dy or CONFIG_RNG_NPCM=3Dy.

Best regards

Heinrich

> +	help
> +	  Selecting this will allow for a random transaction ID to get
> +	  selected for each BOOTP/DHCPv4 exchange.
> +
>   if CMD_DHCP6
>
>   config DHCP6_PXE_CLIENTARCH
> diff --git a/net/bootp.c b/net/bootp.c
> index bab17a9ceb..f1ca2efacf 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -822,22 +822,25 @@ void bootp_request(void)
>
>   	/* Only generate a new transaction ID for each new BOOTP request */
>   	if (bootp_try =3D=3D 1) {
> -		/*
> -		 *	Bootp ID is the lower 4 bytes of our ethernet address
> -		 *	plus the current time in ms.
> -		 */
> -		bootp_id =3D ((u32)net_ethaddr[2] << 24)
> -			| ((u32)net_ethaddr[3] << 16)
> -			| ((u32)net_ethaddr[4] << 8)
> -			| (u32)net_ethaddr[5];
> -		bootp_id +=3D get_timer(0);
> -		bootp_id =3D htonl(bootp_id);
> -		bootp_add_id(bootp_id);
> -		net_copy_u32(&bp->bp_id, &bootp_id);
> -	} else {
> -		net_copy_u32(&bp->bp_id, &bootp_id);
> +		if (IS_ENABLED(CONFIG_BOOTP_RANDOM_XID)) {
> +			srand(get_ticks() + rand());
> +			bootp_id =3D rand();
> +		} else {
> +			/*
> +			 *	Bootp ID is the lower 4 bytes of our ethernet address
> +			 *	plus the current time in ms.
> +			 */
> +			bootp_id =3D ((u32)net_ethaddr[2] << 24)
> +				| ((u32)net_ethaddr[3] << 16)
> +				| ((u32)net_ethaddr[4] << 8)
> +				| (u32)net_ethaddr[5];
> +			bootp_id +=3D get_timer(0);
> +			bootp_id =3D htonl(bootp_id);
> +		}
>   	}
>
> +	bootp_add_id(bootp_id);
> +	net_copy_u32(&bp->bp_id, &bootp_id);
>   	/*
>   	 * Calculate proper packet lengths taking into account the
>   	 * variable size of the options field

