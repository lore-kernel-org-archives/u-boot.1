Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84445C7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1017182C2F;
	Wed, 18 Jun 2025 09:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="C8h5i4ch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E53C82C79; Wed, 18 Jun 2025 09:51:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715CB82BF6
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750233096; x=1750837896; i=xypron.glpk@gmx.de;
 bh=PZ4yWgQVaaEm2aTKh8P75gKkH7AJhXJISdDELg5wAK4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=C8h5i4cht6HYN8qlo4O1OEVKTBhoGDjFVi2iD4u1IpGGJwV9pwC2Gw8IF06ReUZ+
 W0DeG5kAqnBLMBBA//pi3mBKMPEaJKv8jlpWxDF6WmTepMrIb3JDw6ojWx1CcSUGh
 Y4gFYftcif9T4jiU451cxMpXspBanoJCXSajHgMibZujRO86qgrmI7bjY+gvx3XAY
 Jf3P0uOp3RMqfVGeZEIcKWe6P1pfHs5R3lhbNHTe+KLN72JNrLaI1fhSc2QI7IWyt
 LWElStbMWiYZvel5BsN0f0dLivgSWrjoaLhwDYu+ouhD5lmMHeybVbX+mkIkmNcpw
 iWRm7zVaZFCAZsQuLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.107.213]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYXm-1vCfGI0vNu-00bwqo; Wed, 18
 Jun 2025 09:51:36 +0200
Message-ID: <89fdbefa-6015-43d4-a74d-c31223839cee@gmx.de>
Date: Wed, 18 Jun 2025 09:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] lwip: move net/lwip/dns.c to cmd/lwip
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, U-Boot mailing list <u-boot@lists.denx.de>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
 <20250617100720.2544758-3-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250617100720.2544758-3-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GQMuKljPaydqnZoTZs6tx9E8IoVPZjlXzRxe0X0J833q0uVTsuk
 yH5b9KYwGei5VlpS5hJ5u5xWhiVlHSIX3idbj8fYWDCZSMxpWoLg6ilCtKzYA1WfMI3Pb9X
 qsF8/O9niKlSrYYmOINH2hGXcTBWT7F0ROp5+t9UHVDQFXEhqwSdEHFw509I67pU+5V6Rz2
 J9qdOhIrCimQ96UflIO0A==
UI-OutboundReport: notjunk:1;M01:P0:Jz8KvpzVIyw=;UYGJWKyjOd4ywwBpEoRQeufgykC
 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
 SSiUDzkwFQltKllW
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

On 6/17/25 12:03, Jerome Forissier wrote:
> Prepare to split the dns command from cmd/net-lwip.c by moving the
> implementation from net/lwip/dns.c to cmd/lwip.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>=20
> Changes in v3:
> - Move this patch before "lwip: split cmd/net-lwip.c into one file per
>    command".
>=20
> Changes in v2:
> - New patch
>=20
>   MAINTAINERS             | 1 +
>   cmd/Makefile            | 2 +-
>   cmd/lwip/Makefile       | 1 +
>   {net =3D> cmd}/lwip/dns.c | 0
>   net/lwip/Makefile       | 1 -
>   5 files changed, 3 insertions(+), 2 deletions(-)
>   create mode 100644 cmd/lwip/Makefile
>   rename {net =3D> cmd}/lwip/dns.c (100%)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d62dd35a385..e8f644fc75b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1409,6 +1409,7 @@ F:	net/
>   NETWORK (LWIP)
>   M:	Jerome Forissier <jerome.forissier@linaro.org>
>   S:	Maintained
> +F:	cmd/lwip/
>   F:	cmd/net-lwip.c
>   F:	configs/qemu_arm64_lwip_defconfig
>   F:	drivers/net/sandbox-lwip.c
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 80cf70b7fe8..102422470c2 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -133,7 +133,7 @@ obj-$(CONFIG_CMD_NAND) +=3D nand.o
>   ifdef CONFIG_NET
>   obj-$(CONFIG_CMD_NET) +=3D net.o net-common.o
>   else ifdef CONFIG_NET_LWIP
> -obj-$(CONFIG_CMD_NET) +=3D net-lwip.o net-common.o
> +obj-$(CONFIG_CMD_NET) +=3D net-lwip.o net-common.o lwip/

Why should any command implemented in /cmd/lwip/ depend on CONFIG_CMD_NET?
Directory lwip/ should always be traversed if CONFIG_NET_LWIP=3Dy.

We should get rid of CONFIG_CMD_NET once all commands are well separated.

Best regards

Heinrich

>   endif
>   obj-$(CONFIG_ENV_SUPPORT) +=3D nvedit.o
>   obj-$(CONFIG_CMD_NVEDIT_EFI) +=3D nvedit_efi.o
> diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
> new file mode 100644
> index 00000000000..6c4ab58d06b
> --- /dev/null
> +++ b/cmd/lwip/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_CMD_DNS) +=3D dns.o
> diff --git a/net/lwip/dns.c b/cmd/lwip/dns.c
> similarity index 100%
> rename from net/lwip/dns.c
> rename to cmd/lwip/dns.c
> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 5df222589b8..255c7d018b0 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -2,7 +2,6 @@ ccflags-y +=3D -I$(srctree)/lib/lwip/lwip/src/include -I=
$(srctree)/lib/lwip/u-boot
>  =20
>   obj-$(CONFIG_$(PHASE_)DM_ETH) +=3D net-lwip.o
>   obj-$(CONFIG_CMD_DHCP) +=3D dhcp.o
> -obj-$(CONFIG_CMD_DNS) +=3D dns.o
>   obj-$(CONFIG_CMD_PING) +=3D ping.o
>   obj-$(CONFIG_CMD_TFTPBOOT) +=3D tftp.o
>   obj-$(CONFIG_WGET) +=3D wget.o

