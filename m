Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D40C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 09:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE0A8877DA;
	Mon, 25 Dec 2023 10:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qBY3VHQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB7B8877DB; Mon, 25 Dec 2023 10:23:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 058FD877BB
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 10:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703496215; x=1704101015; i=xypron.glpk@gmx.de;
 bh=+S0eBXxPXiZK4//2pPlWZe+vvSCNxu+xbEEWEAqlLRo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=qBY3VHQFHH477yKr8k+42xx4eQAuEFS5ww3hIG5KyIqLQwWCIGuk1VvipR98Sf8K
 yEg2HBexu23NLhrFNqO9+/EiIEEfUxSgC+ck+8p66w8Kj8zva08sazz3/3TaWfWZ3
 eirqW3Z/V1wSkv3NhtUdk7wynhIDhHJMeauT56Ii4QdTFseLhMX6OHkCLz4SI5HOh
 p7y6CZt5cbFXsgmoJyZHSk3I0o5A2tWIqswmgY/UNS1xDbNKkJleVWiLnTWKnadFP
 NR3vZfmbwZK1M8XxsqXSfsVkNEOZvTocxZLpUGx5rQwPx31QhjZSRK3CfgMxWXXkx
 Rpe6eKuW861FGnySDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.136] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1rfIKv3DLa-00Ng8W; Mon, 25
 Dec 2023 10:23:35 +0100
Message-ID: <b236a38c-3b66-4b7d-8c00-bfd06b3d0e77@gmx.de>
Date: Mon, 25 Dec 2023 10:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] net: tftp: remove explicit efi configuration
 dependency
Content-Language: en-US
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, Ramon Fried <rfried.dev@gmail.com>
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-4-takahiro.akashi@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231218023842.281336-4-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ank5TvIpmeL0m0MYZ1mE8riU2USDhWnktRJ1ytWiNo8ObodDmKp
 9qPzBz3iYNtwgiKojYTQAc+TTVKW59bjVMPAEcM6vxHTgJHr/u8Fs8aX2bgLIM3A/o5cOOU
 bDxTmnUCM+GUv42leTPfliPEs4GrEVY3KdmkwvJHIaSl4oGhJ0qlBEuZVwIMCmszqMFD4pu
 TashbEmJV7wtStH499V3w==
UI-OutboundReport: notjunk:1;M01:P0:u4hf/J+X5HE=;3Sg/hCn8+CehSW//tPLRXecie7m
 PDPS2oVX/YORcfxmlQGfaTZhWm90wLlwzDACI4jzg3PVbR8DoREvomq16mBJQP4Jnyl68eZJR
 /sY24mq3WvydDUqX9MC7w95+5IeB/z4ldZIxnoRTLuczI9M/KzWEBJg7rrOTj1mJ+l5epYpiH
 REp8kt9QT7pBiuLhapAix7cWYgLP3cJ0/h3RC5gZZb3CBEb/kXbvX2fj4pRFQMwe9O4cqs57E
 VeWBObz6fDsiH7DtdgpDuHesleiC7lRdqiDPpI58o6zfuHs5OAiUNymoHxCylwGEee75/m2tk
 oMLIJjWOZmTf8KSj3dxVPH8K16GfuKw/0fXSHrve0D1odct+PaVuDULek3kx6uxwKxvn4ywI1
 grZxSzfIsL9C4lQAn+ZoZQGHK3eY1gXr1KJpDjD3Hxg1f3l4mu1KdqEDgFt6/Ub5P+yOxyPSU
 ePVoraSKbLxUI69T6+JzSnHW9AclpJwGRPSAs04U/729mFpIxkE/PwKGNgcnIeSWSTTTItra7
 dGaffYbavPXaCqa1ANVjdw8H9HHMlYkVUckQtB1tj1kXNfZJ3j7joriiob64cmH4PvdocRq6e
 wV3YOUfCHUt9M2Ousv7iXCGs+ccqMsOLFuHJXxf8l74yq+4Mo5dY8IfO3WEPEt6svrP1G402h
 XmPvTFMT7GEglEvSzAN3841Iy8bo3U6QiAT7D6PH9vmJxFP1H+glVmiUnzt0VSwoaR69KiTot
 uEjr5trV5WnaBQMj0TyM4inJhSLnlPLKmbK/V3uwTdbqL77KQlNSZGw1aO63Srw1BATgyiVRg
 6/Rvg3yQBz/WB6sR0kkSFAuAukpQit2aCIyDW435OOLEUB+W2gLv1FTbBW/ITv/gBSfSVaTSa
 1YVXl+cdv6zBZcvkitGL7gtDbJG9XVeW1L1z5K8ucUzRRHtaYiSPoAG24B6shGZ4Pxs4bQ/cn
 aEvu1w==
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

On 12/18/23 03:38, AKASHI Takahiro wrote:
> Now it is clear that the feature actually depends on efi interfaces,
> not "bootefi" command. efi_set_bootdev() will automatically be nullified
> if necessary efi component is disabled.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>   net/tftp.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/tftp.c b/net/tftp.c
> index 88e71e67de35..2e335413492b 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -302,12 +302,10 @@ static void tftp_complete(void)
>   			time_start * 1000, "/s");
>   	}
>   	puts("\ndone\n");
> -	if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
> -		if (!tftp_put_active)
> -			efi_set_bootdev("Net", "", tftp_filename,
> -					map_sysmem(tftp_load_addr, 0),
> -					net_boot_file_size);
> -	}
> +	if (!tftp_put_active)
> +		efi_set_bootdev("Net", "", tftp_filename,

Function efi_set_bootdev() will not be compiled for CONFIG_EFI_LOADER=3Dn.
So this change may lead to build failures.

Best regards

Heinrich

> +				map_sysmem(tftp_load_addr, 0),
> +				net_boot_file_size);
>   	net_set_state(NETLOOP_SUCCESS);
>   }
>

