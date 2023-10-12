Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B018CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA9A86D02;
	Thu, 12 Oct 2023 08:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GbWUcQGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38AED86D17; Thu, 12 Oct 2023 08:52:37 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6498886CE8
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697093546; x=1697698346; i=xypron.glpk@gmx.de;
 bh=o4j86COSdMVPwuunTJsJ+J6fZqbZ/Y3SYfaz2PgLnh0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GbWUcQGvsvehDZ1yBxJCrXLn6SRmAGel5HDLNptvAoaWPzpkKhIHxZUYOv/4LYwzdBCvqMKqjR9
 jFVnk5WqrapTAWt2u/E4fBwza5CDqAOelVnGkiNxms8m3maREm1YLlvGxyqMvUaxDvT/ukuiOe3Y8
 N3XUSz03FlGtKg63HEvRiP6hBgjlGDT5gopzDSVKwEfgeUR+lMMMQPP4/Hs0yeG0Usxh5DVf/OdrS
 CpXDGujpZ0U+egQbb9nghtzz3ZpJa4cmUjL3ny6Sz57LYmNF9meZX3LKlRRu2MFuUGf0YJEHHoGnS
 EAM0zZx2EfrhtzSi2tzQ0UQaJAsvmkHlqsaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmUHp-1rGqhX1NgX-00iU8r; Thu, 12
 Oct 2023 08:52:26 +0200
Message-ID: <49dee352-e5c9-4a43-b365-cfc4c654b396@gmx.de>
Date: Thu, 12 Oct 2023 08:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/26] net: Fix compiling SPL when fastboot is enabled
Content-Language: en-US, de-DE
To: Sean Anderson <seanga2@gmail.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-14-seanga2@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231012015626.3487451-14-seanga2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e00wtAYqpLdKr396qUiIJXElnEpFe4egJ99Ge3adL3ilOvJjIeJ
 hX6MTtVCvMghHLhULG5Yait9VgIosVGqO3AnX0McZnTnF3sgP6qRNzguSGSBcN17LiR4HIX
 iXxQYdADy8s/Lnt6P90Td0RmxkM6qECckYgcS3aHFcoxfC5bcmtr7wCEXvRqdaToPIDzSnL
 C99inXEoA7cPz/r+Krnkw==
UI-OutboundReport: notjunk:1;M01:P0:O7FjfDYaW/o=;YfO11NrWfyMuQ85L1fpLMHGppC8
 OSHN0Aq0Dlms0ODE0NbZoD+XcV42wZQ+kHnOBQQccHZ36AKyBJD49MF8dPwLLQRGpnds/4Tab
 EdQJLWQt2N0X4r3E/MA9ZBhvSlKQhFsMqfFEg2zRLfvvdAj8MqyaUTp99YeJtgj53yZRYE65m
 K71QF9ByEK2Vy7gfi73YQ269ZlW3Vu3hl6m/dZ4JU16h4+LdFXE41ecOuulXo9TKT0SW57lY6
 mhw2Ha5j1jRy2fvn8lJ2UqYRbW/OXSe5JAkb/tI5SUtRvUgWIgHDY7kSCYvvy3vkslPuw0RdC
 MTe3v61nYg6Qvbbe6pWUOKy2lkbYNjzZrdWKu4iauIVshg1xqaLAy5foT1aXukSnRiO7y7BrU
 oNH0Y5pV1bqPKpLx3y8fkrYHTC3Q4FXHbdnVb/OU1NTE/zK9X4wcAu6aeJ71Mgh3y7pCyOj8c
 OOgSHdZ/nq9BCLUk4UaObOV98ctla+DWPaYSYMN009a3rYI71k3igXKUfLVtGFOjPuhHHl2rw
 ZxtCHFLdoNyPnReD+GdN4WVoma+FSl9dB6vibM7Mc2aoSFnK4tceMN3IpY+ua8E71XdvLwxKE
 0FJDlRFTOdLy9sdpgj/yfif/0o8LPc4Jcrx05BByaDw1ntNcvlQoFOX8ODWFkHOTbm4aer1Y9
 vD2X4hsb2grvzK+WEn9mp/DhIJj83c7hN+PVQYF3APyU3S2NqX9kz5opNVzQbcTziCQEub2qG
 E+UIcS4H3osqJr4pRXM0XYej2CG3CB80Vz6wdKp/7WZdy749b/xrmlGm1ARpLv4SQujLzkuFN
 fxCtiP9aHJV0IicjxMovjRv31FG2pk7kpS3LJlknGv9Dmwxs1GKDw1L1iW1my8hTEHF/vdQtP
 vB83vPK+q3Ab8b4qCwlNYr31MG1rhA1Wsieu9X5nj+gqUSAAogWoVIziMu00Rat3svS1gEsJL
 OGi2Jw==
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

On 10/12/23 03:56, Sean Anderson wrote:
> When fastboot is enabled in U-Boot proper and SPL_NET is enabled, we wil=
l
> try to (unsuccessfully) reference it in SPL. Fix these linker errors by
> conditioning on SPL_UDP/TCP_FUNCTION_FASTBOOT.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>   net/Makefile | 4 ++--
>   net/net.c    | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/Makefile b/net/Makefile
> index 3e2d061338d..5ea58eef7e4 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -27,8 +27,8 @@ obj-$(CONFIG_CMD_PCAP) +=3D pcap.o
>   obj-$(CONFIG_CMD_RARP) +=3D rarp.o
>   obj-$(CONFIG_CMD_SNTP) +=3D sntp.o
>   obj-$(CONFIG_CMD_TFTPBOOT) +=3D tftp.o
> -obj-$(CONFIG_UDP_FUNCTION_FASTBOOT)  +=3D fastboot_udp.o
> -obj-$(CONFIG_TCP_FUNCTION_FASTBOOT)  +=3D fastboot_tcp.o
> +obj-$(CONFIG_$(SPL_)UDP_FUNCTION_FASTBOOT)  +=3D fastboot_udp.o
> +obj-$(CONFIG_$(SPL_)TCP_FUNCTION_FASTBOOT)  +=3D fastboot_tcp.o

Please, use $(SPL_TPL) so that we don't have to revisit this should we
ever decide to enable fastboot in SPL in future.

Best regards

Heinrich

>   obj-$(CONFIG_CMD_WOL)  +=3D wol.o
>   obj-$(CONFIG_PROT_UDP) +=3D udp.o
>   obj-$(CONFIG_PROT_TCP) +=3D tcp.o
> diff --git a/net/net.c b/net/net.c
> index e6f61f0f8f6..8357f084101 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -511,12 +511,12 @@ restart:
>   			tftp_start_server();
>   			break;
>   #endif
> -#if defined(CONFIG_UDP_FUNCTION_FASTBOOT)
> +#if CONFIG_IS_ENABLED(UDP_FUNCTION_FASTBOOT)
>   		case FASTBOOT_UDP:
>   			fastboot_udp_start_server();
>   			break;
>   #endif
> -#if defined(CONFIG_TCP_FUNCTION_FASTBOOT)
> +#if CONFIG_IS_ENABLED(TCP_FUNCTION_FASTBOOT)
>   		case FASTBOOT_TCP:
>   			fastboot_tcp_start_server();
>   			break;

