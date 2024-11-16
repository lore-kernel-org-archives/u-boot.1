Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D1DD68BF6
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 20:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C9088EFB;
	Sat, 16 Nov 2024 21:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KG0FFAvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E735788EFB; Sat, 16 Nov 2024 21:33:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1AEB8907B
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 21:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731789219; x=1732394019; i=xypron.glpk@gmx.de;
 bh=Z+GlO2NqUdLMDCM6tI/vQVoMMKupWatT07uunLW4xlI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KG0FFAvO96hSRMYmx428lceGN8ehLLFBMKG7GbKO7eG1rs7GgDfhVEufVwNrRoLU
 cx5CfFSKk3manFiRM1fBTiKOT5PdvOP1FHYGOSorClgF7ITTiIM3RM1njHXl5timw
 KYUmImFHqeh2JveG1iclMiwXQIpOKG3RPHYiZ+w0+jsCl7VKWSeO0fCcMwzUncJ+j
 peVRqjLGHXIRV5mrzB7baHIIEukZi8g41S7PDBaMEoyf9k/+Gi5OVMt4e3M7yXza6
 B/XUI+uMKSBe7OFP7pE9x8l9ldgIWgd58ufZfxPOgo8xqMkneHQSONsswqV+PDvmw
 gKjRWKCE+HS7sPs3JQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s51-1tDn413Yu7-003rWF; Sat, 16
 Nov 2024 21:33:38 +0100
Message-ID: <8c2f1261-4b25-47ff-bfdf-ef0c3af741aa@gmx.de>
Date: Sat, 16 Nov 2024 21:33:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] net: Kconfig: add CONFIG_WGET symbol
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241111210901.560691-1-adrianox@gmail.com>
 <20241111210901.560691-2-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241111210901.560691-2-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mXAAnIOvJM8xVxyZbFZtbdr3Ohjy4PgHT63gI889sc5ygC9gDsc
 5b8i+2t+BNb/+XEJ/ZD0yXa/YnF4uhgan/E64BVTRV/CaGHhDhQcNK1zCgxsUOGOVkXyZMl
 NsZ6nWbZMieEy1BTetXMgI/5lEcfxgy8yGOGRGQj5bfxVo9QXMDyXn6qzeCvrE1TujUlyi5
 3QyxVq8+dcJ9OXlP6Ac3w==
UI-OutboundReport: notjunk:1;M01:P0:w2lUfcth5Xg=;HdLwKjtNFv+c4x0xif32MjmvSri
 IZ4X3trdP8bq84uk+3CqxO1lm5w4OwVEQr9R9YPpzOgqq3XsFW0WFeUoWYp/W9b/p4zvSy96v
 WU1xny1IVwO2z8WhvzlrTQo4pUD/UJYX2SqFjs0vForQFABuC+omrCIWIJqV3wZp3ME/Xn0FZ
 jcXTxJXhV173xDaky6RMxVTArs2IozG8OnFQCgD+LIG17aOUfWRQKm1h1Z62RwFtODej46jMg
 kBXsP9chQvhbhaV8cYQMew1PltvOtP+NlGamDiix8tMx4QDa62sPcT7/3OjGwJ1uLeSDdLRaX
 bPdGRZALxhKrbQICgqGfCNmvjYf0q3iMdt8CLJJqES8eJvf6i+9x7Bm+sSH26HNHGsixtvI1n
 ZiLLCLxrpStZu8PsVdUEqCuNbkvS1eAaBU8haANMIts4O2l4fqAKzuH7wszo2qa0nQI8kBNDJ
 bhqgDF1n1QHoIve3cxCEjJTtCnxCj3lwUPBhUGDE/bEq6Nv3ZIrwXlfGXhKx+RTcQktHHVgzC
 QzaUx1xeU47W0oWDyNbVFwFNRDrWUpnNL4BimZKeiGu6Fj8tgQfP9gm8sjMVvDVLmIlmI836l
 96wRPltIjeB5uy9lDjZ1JQv4IbuunblQe3ieTI2hQX222LSeVTzYZebuOOoh76RY8KiXpbys9
 GMI+Ey6/SEhEhagfTFnyrcEmlFKDTWVtl/vMTePUr6NCZo17hAlZILB8ndPI70WYtTG11IzpJ
 TutWoFUl2DQV2NPbAHQ5pDyIpW3+JPEy1jLdiMIyu/mZJAqIS6OgsH0R5eWRu7YwNmKrjC9qd
 huzk7b9JtYOHCygWdRajnfXQE7Bt2ySKRbtIUbZIUEA/MMopAcNF1mxEqQjJL64rx3Qw541Qx
 UryehJJBfYebaWjyb/BafRgCyiMIOcWB4KbZP0dRzlmYzTbyqLIKbntZ7
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

On 11/11/24 22:08, Adriano Cordova wrote:
> Let net/wget.c and net/lwip/wget.c depend on CONFIG_WGET, and
> cmd/wget.c depend on CONFIG_CMD_WGET. This way, the wget code
> can be used regardless of whether the wget command is available.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> (no changes since v1)
>
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

