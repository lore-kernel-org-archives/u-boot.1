Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04D5E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 09:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94858031D;
	Wed,  1 Jan 2025 10:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="g9fOYVt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1FDA80379; Wed,  1 Jan 2025 10:44:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 328FD8021A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 10:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735724663; x=1736329463; i=xypron.glpk@gmx.de;
 bh=zyxi0jOvRxctj5Wk0IsUHXRUbtBbMTFnIza72cExDaY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=g9fOYVt9MXFEGuNlgmFQnNv3MTVQtvRIKZ4qxQeA1jVnC2b+I+X1kB4dzRCkFXel
 aj1iAOv8MLfcPbIW8jsnCin3j/TCVWkpI7LDwpb5/+01w7xYsdOqGGHLrIstbs0c6
 PI0KyHZAQQMtLlF6TlV7QddTL/qXx96uCMkabpKZ4N01/8cdVgj/yoxsOqHSTs350
 CuNC4u7Ik12uL6GclheTXAHFWOOyaDm5orrPzcQoLLegedhyVdVI/x2lNR2zSZKAx
 vLy/q5yhv5VRnaH1DJCdeTd6SxBa/98DZZVxVpViyk/nvWFUexghQo/j61PN0wnpR
 K3XIUS7BFCBQc20wWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1t0z3E3o7O-00K3VP; Wed, 01
 Jan 2025 10:44:23 +0100
Message-ID: <58c0049d-9caf-428b-9166-4cc6e660559d@gmx.de>
Date: Wed, 1 Jan 2025 10:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/netcat: add netcat over tcp support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20250101033326.439585-1-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250101033326.439585-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HrJ6l/h1tTqbDyKg4onXfrnJJwchzHo0GwLyYaOuPcN+95UEPvx
 H//TjXl93J5dgQPKfXEOuIrq6lQYEFS9WDdfD7KOJe05ZMVdJitEoXe6FEH3uq9+ZPah/qR
 c8PM9bTVj1c0esHUE5l59oEalGpSNDZD/wtn0b2tVpZ+Yb0hJmKb1PSEMnTNHiUIIZrojh/
 6eg/6uDFUezbpgOzEKJog==
UI-OutboundReport: notjunk:1;M01:P0:eiuv45zEvC4=;leaZBeMfiSHbzq463c235qqEfxY
 iVWOH3P64xcg4ZD75FXAjxHo83g0i7g889ScWKCDZG8UqpMc+qZhj/J1v8O6zbDdW9t1Hrxzb
 OnuaMKJbSmPbJAQL2h9QHEzjoQVkGR2f1/kQD+HD9pkW4iA1SGUGuUh8oJeRWrWBNDA7zLofj
 2aVb5JAqii3IMvFIZ7Br3eCbTgXWmdyycOtRZMvdw9AFcGjlfEL50a9hjAjCXUe/spDytI5s6
 UpZl/x7S7HGIL+UK4RdyeRKmJ4fpljQ+j1gbEme7Lry7kRFw8mI3M5rO194nte79FnJn0P6v9
 /IgirrcrRnIsiMgekGmgeQLqvaDyZZTkPceXQzLhdy6a80PrguIVMDXn1mS3GCKFpVqT139ZY
 7/7ms01uS3hfBvXvmVk8oZqCrWG01prc3Qsef9s7Qb1i+FRhHTTGW7pJqd7lbvK1QCnLwmPqp
 lokNYY1y0aSXdYPD5TFl4lMilRCKSZB9LgnL7E+beS2BCg2TIFdW/UEn7P476bKilhtD6ZRei
 SMjzs+haBxXX3jj8kNFH4oAkJXcBDhwTIDU2sfw+XMANz9VJTr8xW5d5pB/bmP2Ag6Uj8GcEc
 FVszBU8oC/BkmX2y4WVG6Fpq88M2Wl5KqsP0F9uCFF3Kw/S7IeOWvJOXW4/T8TafxEvWNEGBl
 HuhZzoNximnYslXuI3WpkilUMlG9IN5eG+SCl9K+ghBauLl2T2crSEvTHxKUvBEcU0hg12IkA
 HMEQZXZfMmO1y4/tPHM0ELtFpgd0tlVMSPEvh+b8/hl2oVJSnb7AZTFzzPigA0MEwUPd8U6Hk
 J3Tzthh1NqqgrGRd/AMR8s4oCkf+QkSx8Ay7IIeU4U2Ip1ii/nMzweQ/X3obsnJ32oiZfBL7J
 GiAMRFCilyAWG/1OT01RKPGBKpti9e5mLc6FK6ak1Y70/VZ2vfdHEuSW45svSKBmYNmCrHBuH
 e3FdKdgGu88vmI5IqDzxfbH7bSMNNzXolMxGa101w/SVVmFePm62w48D3IR0z8zAeJ5oMcsAd
 Ne/s+fLzCMTisthl2h9WnDy3xiC8ULta2BVmO+QzfFVEO8TZ0aY1RObZmjr7VB/oazuZoE8Xu
 EAfFDoMx1viSri5ikDIHcomoxoK+4a
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

On 1/1/25 04:33, Mikhail Kshevetskiy wrote:
> This patch adds downloading/uploading of data with netcat utility.
> Client/server modes are supported both.
>
> This patch is also an example of using new tcp api for legacy stack.
>
> How to test:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    netcat-openbsd=3D1.219-1 from debian were used for a tests
>
>    a) Load data from remote host.
>         * U-Boot listen on tcp port 3456
>         * PC connects
>
>       u-boot: netcat load ${loadaddr} 3456
>       PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb
>
>    b) Load data from remote host.
>         * PC listen on tcp port 3456
>         * U-Boot connects
>
>       PC:     netcat -q1 -l -p 3456 < image.itb
>       u-boot: netcat load ${loadaddr} ${PC_IP}:3456
>
>    c) Save data to remote host
>         * U-Boot listen on tcp port 3456
>         * PC connects
>
>       u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
>       PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb
>
>    d) Save data to remote host
>         * PC listen on tcp port 3456
>         * U-Boot connects
>
>       PC:     netcat -w1 -l -p 3456 >image.itb
>       u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   cmd/Kconfig          |  10 +++
>   cmd/net.c            |  35 ++++++--
>   include/net-legacy.h |   2 +-
>   include/net/netcat.h |  20 +++++
>   net/Makefile         |   1 +
>   net/net.c            |   9 ++
>   net/netcat.c         | 194 +++++++++++++++++++++++++++++++++++++++++++
>   7 files changed, 265 insertions(+), 6 deletions(-)
>   create mode 100644 include/net/netcat.h
>   create mode 100644 net/netcat.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 93efeaec6f4..e37e50a18b5 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2091,6 +2091,16 @@ config CMD_DNS
>   	help
>   	  Lookup the IP of a hostname
>
> +config CMD_NETCAT
> +	bool "netcat"
> +	select PROT_TCP

Thank you for your patch which looks like a useful addition to U-Boot.

Here you make the netcat command depend on CMD_NET. This dependency
seems unnecessary at least for the lwIP case.

> +	help
> +	  netcat is a simple command to load/store kernel, or other files,
> +	  using well-known netcat (nc) utility. Unlike classic netcat utility
> +	  this command supports TCP-based data transfer only, thus no data
> +	  will be lost or reordered. Any netcat implementation should work,
> +	  but openbsd one was tested only.
> +
>   config CMD_MII
>   	bool "mii"
>   	imply CMD_MDIO
> diff --git a/cmd/net.c b/cmd/net.c
> index 79525f73a51..d7a5025f940 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -208,6 +208,29 @@ U_BOOT_CMD(
>   );
>   #endif
>
> +#if defined(CONFIG_CMD_NETCAT)
> +static int do_netcat_load(struct cmd_tbl *cmdtp, int flag, int argc,
> +			  char *const argv[])
> +{
> +	return netboot_common(NETCAT_LOAD, cmdtp, argc, argv);
> +}
> +
> +static int do_netcat_save(struct cmd_tbl *cmdtp, int flag, int argc,
> +			  char *const argv[])
> +{
> +	return netboot_common(NETCAT_SAVE, cmdtp, argc, argv);
> +}
> +
> +U_BOOT_LONGHELP(netcat,
> +	"load [loadAddress] [[hostIPaddr:]port]\n"
> +	"save Address Size [[hostIPaddr:]port]");
> +
> +U_BOOT_CMD_WITH_SUBCMDS(netcat,
> +	"load/store data over plain TCP via netcat utility", netcat_help_text,
> +	U_BOOT_SUBCMD_MKENT(load, 3, 0, do_netcat_load),
> +	U_BOOT_SUBCMD_MKENT(save, 4, 0, do_netcat_save));
> +#endif
> +
>   static void netboot_update_env(void)
>   {
>   	char tmp[46];
> @@ -325,16 +348,17 @@ static int parse_args(enum proto_t proto, int argc=
, char *const argv[])
>
>   	switch (argc) {
>   	case 1:
> -		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto =3D=3D TFTPPUT)
> +		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto =3D=3D TFTPPUT) ||
> +		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto =3D=3D NETCAT_SAVE))
>   			return 1;
> -
>   		/* refresh bootfile name from env */
>   		copy_filename(net_boot_file_name, env_get("bootfile"),
>   			      sizeof(net_boot_file_name));
>   		break;
>
>   	case 2:
> -		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto =3D=3D TFTPPUT)
> +		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto =3D=3D TFTPPUT) ||
> +		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto =3D=3D NETCAT_SAVE))
>   			return 1;
>   		/*
>   		 * Only one arg - accept two forms:
> @@ -356,7 +380,8 @@ static int parse_args(enum proto_t proto, int argc, =
char *const argv[])
>   		break;
>
>   	case 3:
> -		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto =3D=3D TFTPPUT) {
> +		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto =3D=3D TFTPPUT) ||
> +		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto =3D=3D NETCAT_SAVE)) {
>   			if (parse_addr_size(argv))
>   				return 1;
>   		} else {
> @@ -367,7 +392,7 @@ static int parse_args(enum proto_t proto, int argc, =
char *const argv[])
>   		}
>   		break;
>
> -#ifdef CONFIG_CMD_TFTPPUT
> +#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
>   	case 4:
>   		if (parse_addr_size(argv))
>   			return 1;
> diff --git a/include/net-legacy.h b/include/net-legacy.h
> index bc0f0cde9fe..84a4beb9ec1 100644
> --- a/include/net-legacy.h
> +++ b/include/net-legacy.h
> @@ -305,7 +305,7 @@ extern int		net_restart_wrap;	/* Tried all network d=
evices */
>   enum proto_t {
>   	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
>   	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TC=
P,
> -	WOL, UDP, NCSI, WGET, RS
> +	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
>   };
>
>   /* Indicates whether the file name was specified on the command line *=
/
> diff --git a/include/net/netcat.h b/include/net/netcat.h
> new file mode 100644
> index 00000000000..d8e09aaaa55
> --- /dev/null
> +++ b/include/net/netcat.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: BSD-2-Clause

According to doc/develop/sending_patches.rst all new code should use the
GPL-2.0-or-later license.

> + *
> + * netcat include file
> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +#ifndef __NET_NETCAT_TCP_H__
> +#define __NET_NETCAT_TCP_H__
> +
> +/**
> + * netcat_load_start() - begin netcat in loading mode
> + */
> +void netcat_load_start(void);
> +
> +/**
> + * netcat_save_start() - begin netcat in data saving mode
> + */
> +void netcat_save_start(void);
> +
> +#endif /* __NET_NETCAT_TCP_H__ */
> diff --git a/net/Makefile b/net/Makefile
> index 7c917b318c0..bc5f2f123be 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_CMD_WOL)  +=3D wol.o
>   obj-$(CONFIG_PROT_UDP) +=3D udp.o
>   obj-$(CONFIG_PROT_TCP) +=3D tcp.o
>   obj-$(CONFIG_WGET) +=3D wget.o
> +obj-$(CONFIG_CMD_NETCAT) +=3D netcat.o
>
>   # Disable this warning as it is triggered by:
>   # sprintf(buf, index ? "foo%d" : "foo", index)
> diff --git a/net/net.c b/net/net.c
> index 1828f1cca36..595bffdc532 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -103,6 +103,7 @@
>   #include <net/fastboot_udp.h>
>   #include <net/fastboot_tcp.h>
>   #include <net/ncsi.h>
> +#include <net/netcat.h>
>   #if defined(CONFIG_CMD_PCAP)
>   #include <net/pcap.h>
>   #endif
> @@ -572,6 +573,14 @@ restart:
>   			wget_start();
>   			break;
>   #endif
> +#if defined(CONFIG_CMD_NETCAT)
> +		case NETCAT_LOAD:
> +			netcat_load_start();
> +			break;
> +		case NETCAT_SAVE:
> +			netcat_save_start();
> +			break;
> +#endif
>   #if defined(CONFIG_CMD_CDP)
>   		case CDP:
>   			cdp_start();
> diff --git a/net/netcat.c b/net/netcat.c
> new file mode 100644
> index 00000000000..47dbebe5ae2
> --- /dev/null
> +++ b/net/netcat.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0

According to doc/develop/sending_patches.rst all new code should use the
GPL-2.0-or-later license.

> +/*
> + * netcat support driver
> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +
> +#include <command.h>
> +#include <display_options.h>
> +#include <env.h>
> +#include <image.h>
> +#include <mapmem.h>
> +#include <net.h>
> +#include <net/tcp.h>
> +#include <net/netcat.h>
> +
> +#define HASHES_PER_LINE		65
> +#define MARKER_STEP		10
> +
> +static struct in_addr		server_ip;
> +static u16			server_port;
> +static u16			local_port;
> +static int			listen;
> +static int			reading;
> +static int			marker, marks_in_line;
> +static enum net_loop_state	netcat_loop_state;
> +

Please, describe all functions in Sphinx style.  Cf.
https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

> +static void show_block_marker(int packets)
> +{
> +	for (; marker + MARKER_STEP <=3D packets; marker +=3D MARKER_STEP) {
> +		marks_in_line++;
> +		putc('#');
> +		if (marks_in_line =3D=3D HASHES_PER_LINE) {
> +			marks_in_line =3D 0;
> +			puts("\n");
> +		}
> +	}
> +}
> +
> +static void tcp_stream_on_closed(struct tcp_stream *tcp)
> +{
> +	if (tcp->status !=3D TCP_ERR_OK)
> +		netcat_loop_state =3D NETLOOP_FAIL;
> +
> +	/*
> +	 * The status line will be shown after the download/upload
> +	 * progress (see show_block_marker() function). This progress
> +	 * generally have no final "\n", so jump to new line before
> +	 * output the status
> +	 */
> +	if (netcat_loop_state !=3D NETLOOP_SUCCESS) {
> +		net_boot_file_size =3D 0;
> +		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
> +	} else {
> +		env_set_hex("filesize", net_boot_file_size);
> +		printf("\nPackets %s %d, Transfer Successful\n",
> +		       reading ? "received" : "transmitted",
> +		       reading ? tcp->rx_packets : tcp->tx_packets);
> +	}
> +	net_set_state(netcat_loop_state);
> +}
> +
> +static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx=
_bytes)
> +{
> +	net_boot_file_size =3D rx_bytes;
> +	show_block_marker(tcp->rx_packets);
> +}
> +
> +static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx=
_bytes)
> +{
> +	show_block_marker(tcp->tx_packets);
> +	if (tx_bytes =3D=3D image_save_size)
> +		tcp_stream_close(tcp);
> +}
> +
> +static void tcp_stream_on_established(struct tcp_stream *tcp)
> +{
> +	netcat_loop_state =3D NETLOOP_SUCCESS;
> +}
> +
> +static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf=
, int len)
> +{
> +	void *ptr;
> +
> +	ptr =3D map_sysmem(image_load_addr + rx_offs, len);
> +	memcpy(ptr, buf, len);
> +	unmap_sysmem(ptr);
> +
> +	return len;
> +}
> +
> +static int tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf=
, int maxlen)
> +{
> +	void *ptr;
> +
> +	if (tx_offs + maxlen > image_save_size)
> +		maxlen =3D image_save_size - tx_offs;
> +	if (!maxlen)
> +		return 0;
> +
> +	ptr =3D map_sysmem(image_save_addr + tx_offs, maxlen);
> +	memcpy(buf, ptr, maxlen);
> +	unmap_sysmem(ptr);
> +
> +	return maxlen;
> +}
> +
> +/*
> + * This function will be called on new connections (incoming or outgoin=
g)
> + * It MUST:
> + *   -- setup required tcp_stream callbacks (if connection will be acce=
pted)
> + *   -- return a connection verdict:
> + *        0: discard connection
> + *        1: accept connection

Please, use a Sphinx style function description.

Best regards

Heinrich

> + */
> +static int tcp_stream_on_create(struct tcp_stream *tcp)
> +{
> +	if (listen) {
> +		/*
> +		 * We are listening for incoming connections.
> +		 * Accept connections to netcat listen port only.
> +		 */
> +		if (tcp->lport !=3D local_port)
> +			return 0;
> +	} else {
> +		/*
> +		 * We are connecting to remote host.
> +		 * Check remote IP:port to make sure that this is our connection
> +		 */
> +		if (tcp->rhost.s_addr !=3D server_ip.s_addr ||
> +		    tcp->rport !=3D server_port)
> +			return 0;
> +	}
> +
> +	netcat_loop_state =3D NETLOOP_FAIL;
> +	net_boot_file_size =3D 0;
> +	marker =3D 0;
> +	marks_in_line =3D 0;
> +
> +	tcp->on_closed =3D tcp_stream_on_closed;
> +	tcp->on_established =3D tcp_stream_on_established;
> +	if (reading) {
> +		tcp->on_rcv_nxt_update =3D tcp_stream_on_rcv_nxt_update;
> +		tcp->rx =3D tcp_stream_rx;
> +	} else {
> +		tcp->on_snd_una_update =3D tcp_stream_on_snd_una_update;
> +		tcp->tx =3D tcp_stream_tx;
> +	}
> +
> +	return 1;
> +}
> +
> +static void netcat_start(void)
> +{
> +	struct tcp_stream *tcp;
> +
> +	memset(net_server_ethaddr, 0, 6);
> +	tcp_stream_set_on_create_handler(tcp_stream_on_create);
> +
> +	if (!strchr(net_boot_file_name, ':')) {
> +		listen =3D 1;
> +		printf("Listening on port %s...\n", net_boot_file_name);
> +
> +		local_port =3D dectoul(net_boot_file_name, NULL);
> +	} else {
> +		listen =3D 0;
> +		printf("Connecting to %s...\n", net_boot_file_name);
> +
> +		server_ip =3D string_to_ip(net_boot_file_name);
> +		server_port =3D dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
> +
> +		tcp =3D tcp_stream_connect(server_ip, server_port);
> +		if (!tcp) {
> +			printf("No free tcp streams\n");
> +			net_set_state(NETLOOP_FAIL);
> +			return;
> +		}
> +		tcp_stream_put(tcp);
> +	}
> +}
> +
> +void netcat_load_start(void)
> +{
> +	reading =3D 1;
> +
> +	return netcat_start();
> +}
> +
> +void netcat_save_start(void)
> +{
> +	reading =3D 0;
> +
> +	return netcat_start();
> +}

