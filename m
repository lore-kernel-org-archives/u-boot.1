Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5278ED64060
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 16:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B614089046;
	Fri,  8 Nov 2024 17:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lMeIw+LG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF6889177; Fri,  8 Nov 2024 17:30:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E4188B1F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 17:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731083434; x=1731688234; i=xypron.glpk@gmx.de;
 bh=KJxWxo72eRiWgVeyNlK1KqSq1ICAxxLm0kyvbr5LRAM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lMeIw+LGlr0zn1pv004v1khVEF8ho2jsXX56uWYUGjyrms9CUS87Cde+u6AWG9cG
 rGtaq8VGtl0vp3o4GjCBDlHeBZ9VuM8W6vQtBqLZ+T2/klDa+Y00u79FZQN1yRREZ
 3IRO79lPgvvJTyFN2FGGywr96OtE3TGK5S7uglglXjGbhEsp1AYJ+nh/v1ydu5nxw
 N95ahOW1cO5OOSgAADf6OkIbC1REz9LZO1Zy7G1yA4Lt6VpHe0/nfHILsRi7EYnWy
 Sqm8Ffj2M8CS5L+y4Ro97H5hN0KOtxNItL+9llwpLVhyVzbUbyJ5AEhWJ6cs6mWMY
 xEj89NA9lY0xCUQWaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1tWdXS1jKe-00hREc; Fri, 08
 Nov 2024 17:30:34 +0100
Message-ID: <13539716-eadb-4bb6-a051-6f052c6e249c@gmx.de>
Date: Fri, 8 Nov 2024 17:30:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] net: Kconfig: add CONFIG_WGET symbol
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, u-boot@lists.denx.de
References: <20241106130255.211041-1-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241106130255.211041-1-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kCyZ3SCi4t10vSZ03Tz9N56qxvk6il9syRC73db8KeiRU+3214U
 qpM/PBmZ0zlticFzp9iqlaSrli22YgKUH/HPRRSt2Mtge3xB4dAEd/kLFcDbCjC99oFAzja
 QQf3jk6ltMhwpcvxZpqT2Lr8yWviysBp5w7cYzcSJlbTNAEEiApb9tRZ8FEF3RhyD+k5iYG
 VfIdbBe5CwddaTdfdLxbA==
UI-OutboundReport: notjunk:1;M01:P0:zNeCsjsRo2A=;gME+zPH0ffj+8m4Hsbkgesa2kwX
 7EhF1uXjjg8cNOq79y7sLQtwW/1PqtdvaL/crVDw0UhAVbuiisOowOwa/650+FTA3BNGUkr/x
 6DsT17y+aXrGrd05XCT587ETlr183kjonFbYojfLZgYzGMyPcRgLI0H1JWJtEtvHafSj7Oabu
 BykQ+nQX9MohMSMi2KR9alD4nvBV2kFsV6n97VHkqxuQE5PrFtYSzdAeoH1iMTy8W0PdGJf/J
 3LAkxnxzBLlZlYoqYFqj3M3GazjO5In4WSya82yDppdUohtCGa3xA6XwhBv3bzQQrL4fvPXmX
 sKQzalDjG/nBq+7RFyAxysQfPhq+QvEJeioJwPDYrMx8HEgVrHsv7T3895VXVOazUwQkQFYSa
 4qKwkRdoYyh2qxIg8LSmadXr9E+USzVM1IBRvKRvlPtsHKqAxnregNHQJsdkr05Ty8+Y2V+hk
 Q/hpzlg6/Lyejz35yp50PBhmPfneaFXJZK4YDLgmsd7aJxnmgvr7Cef5JCgW3H9e4h2Yq6vYK
 4J2Rh2Ume8l9oZNGFppd6BMqyQ0DmgomHAqh4EfBTJ4joju/txgVSAEco3UTaBhhoP+UeSTk0
 zpUUN6dYR/tcXYsKHhSSEwcZe+cp5rQx1W1fTFo6KryIm8H1R6o7I+/r1EC8AyB3biiZWRHAL
 XHozgSLBbCsS+JiG0hWCPwywcu7q/duS3hteBoS5t7prXcHelL/0cYgxcmk8Q/2Wvph9KapBh
 dDJll/jZkQ9+Vi/cUV9oRciWhahtA/m6i/0Ko7kkDj/cQYbXB2C3SRVbC4YL8+FxiGrj+J3e0
 8Pnw4XqdS0oHSMd7eC6XENrg==
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

On 11/6/24 14:02, Adriano Cordova wrote:
> Let net/wget.c and net/lwip/wget.c depend on CONFIG_WGET, and
> cmd/wget.c depend on CONFIG_CMD_WGET. This way, the wget code
> can be used regardless of whether the wget command is available.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   cmd/Kconfig       | 5 +----
>   net/Kconfig       | 9 +++++++++
>   net/Makefile      | 2 +-
>   net/lwip/Makefile | 2 +-
>   4 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 636833646f..8f3ad94089 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2115,11 +2115,8 @@ config CMD_TFTPBOOT
>
>   config CMD_WGET
>   	bool "wget"
> -	depends on CMD_NET
>   	default y if SANDBOX
> -	select PROT_TCP if NET
> -	select PROT_TCP_LWIP if NET_LWIP
> -	select PROT_DNS_LWIP if NET_LWIP
> +	select WGET
>   	help
>   	  wget is a simple command to download kernel, or other files,
>   	  from a http server over TCP.
> diff --git a/net/Kconfig b/net/Kconfig
> index 76ab7d91ee..b4bb68dd61 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -244,6 +244,15 @@ config NET_RANDOM_ETHADDR
>   	  generated. It will be saved to the appropriate environment variable=
,
>   	  too.
>
> +config WGET
> +	bool "Enable wget"
> +	select PROT_TCP if NET
> +	select PROT_TCP_LWIP if NET_LWIP
> +	select PROT_DNS_LWIP if NET_LWIP
> +	help
> +	  Selecting this will enable wget, an interface to send HTTP requests
> +	  via the network stack.
> +
>   config TFTP_BLOCKSIZE
>   	int "TFTP block size"
>   	default 1468
> diff --git a/net/Makefile b/net/Makefile
> index 209377aeb2..7c917b318c 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -29,7 +29,7 @@ obj-$(CONFIG_$(PHASE_)TCP_FUNCTION_FASTBOOT)  +=3D fas=
tboot_tcp.o
>   obj-$(CONFIG_CMD_WOL)  +=3D wol.o
>   obj-$(CONFIG_PROT_UDP) +=3D udp.o
>   obj-$(CONFIG_PROT_TCP) +=3D tcp.o
> -obj-$(CONFIG_CMD_WGET) +=3D wget.o
> +obj-$(CONFIG_WGET) +=3D wget.o
>
>   # Disable this warning as it is triggered by:
>   # sprintf(buf, index ? "foo%d" : "foo", index)
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index f2558f8763..79dd6b3fb5 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -5,4 +5,4 @@ obj-$(CONFIG_CMD_DHCP) +=3D dhcp.o
>   obj-$(CONFIG_CMD_DNS) +=3D dns.o
>   obj-$(CONFIG_CMD_PING) +=3D ping.o
>   obj-$(CONFIG_CMD_TFTPBOOT) +=3D tftp.o
> -obj-$(CONFIG_CMD_WGET) +=3D wget.o
> +obj-$(CONFIG_WGET) +=3D wget.o

