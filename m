Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D3CCCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 12:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD721836D1;
	Thu, 16 Oct 2025 14:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="h05b+WWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2984836EE; Thu, 16 Oct 2025 14:54:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBDA38367F
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 14:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760619238; x=1761224038; i=xypron.glpk@gmx.de;
 bh=ISGIQkQzgU2DwIRZJZTFSg+Y8OrhSBibhBQTa/9qGcI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=h05b+WWYXXWvM4HFSQBImFhPLPWk4daZp0emmoCnqD7Lz5Au0ZUAQlEOMP4lrILA
 nRxCQY0xlHM0MkLmfFRllwhIB4/8EMQSptIGVV+aqkWzT3/64AuyOX0Tq0worZexG
 OsOT4GGu9x+MGTycZ09JxGNpBDErDtPstuB7a0MM+PEvXNqlVgCU+1sVvLrlne7tx
 Q6C+GL/TKDLuf16BdVnUh+WQO8516vVp02Lm/IuH5VAO2xPudk1CuF9Onpcb0Zw6D
 7DBw+brOSeVjKZDmByC1x3L7xacll2q1bSMZaoD7+fAMhWC0+hjRZTmQJ4vugneTb
 hl08PkVuc+RNA61hdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKlu-1uq4C73a7m-00Q8U7; Thu, 16
 Oct 2025 14:53:57 +0200
Message-ID: <55a322a8-2e3c-4936-998b-786e9e14565f@gmx.de>
Date: Thu, 16 Oct 2025 14:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: make dhcp_run() common for NET and NET_LWIP
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Benjamin Hahn <B.Hahn@phytec.de>, Tom Rini <trini@konsulko.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 U-Boot mailing list <u-boot@lists.denx.de>
References: <20251009123034.2441110-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251009123034.2441110-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tTQQpfgzVP4d9l/dM7mvQwseMBiFA4qiFLwTJrsD9aeRiOoNrGi
 DV2IVYhizLtcxVsOKOOcMd4y4yl3EpJrmQE4MpiF3p9/IJDe/q1lWOh19gJp5DXkprT4T9B
 svRqrfPwWTcaMPJOAx4CkVyalU4YHk49vn2QuwhBb+pAEGKo1RCWwEP+iuXyyezMktdYBqL
 t9TwtCNdOjgYPePTq0WWQ==
UI-OutboundReport: notjunk:1;M01:P0:1kfKX4phZnA=;scIFq323elJSpnGL5seHozmKLgW
 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
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

On 10/9/25 14:30, Jerome Forissier wrote:
> THere are currently two implementations of dhcp_run(): one in cmd/net.c
> for NET and one in net/lwip/dhcp.c for NET_LWIP. There is no
> justification for that. Therefore, move the NET version into
> net/net-common.c to be used by both stacks, and drop the NET_LWIP
> version which by the way does not look totally correct.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
>=20
>   cmd/net.c            | 36 ++----------------------------------
>   include/net-common.h | 10 ++++++++++
>   include/net-lwip.h   |  1 -
>   net/lwip/dhcp.c      | 22 ----------------------
>   net/net-common.c     | 35 +++++++++++++++++++++++++++++++++++
>   5 files changed, 47 insertions(+), 57 deletions(-)
>=20
> diff --git a/cmd/net.c b/cmd/net.c
> index 886735ea14f6..24099764493e 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -134,8 +134,8 @@ U_BOOT_CMD(dhcp6,	3,	1,	do_dhcp6,
>   #endif
>  =20
>   #if defined(CONFIG_CMD_DHCP)
> -static int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
> -		   char *const argv[])
> +int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
> +	    char *const argv[])

Thank you for all this clean up work.

Should we move the dhcp command to a new file cmd/dhcp.c to get rid of=20
all the related '#if' statements?

Best regards

Heinrich

>   {
>   	return netboot_common(DHCP, cmdtp, argc, argv);
>   }
> @@ -145,38 +145,6 @@ U_BOOT_CMD(
>   	"boot image via network using DHCP/TFTP protocol",
>   	"[loadAddress] [[hostIPaddr:]bootfilename]"
>   );
> -
> -int dhcp_run(ulong addr, const char *fname, bool autoload)
> -{
> -	char *dhcp_argv[] =3D {"dhcp", NULL, (char *)fname, NULL};
> -	struct cmd_tbl cmdtp =3D {};	/* dummy */
> -	char file_addr[17];
> -	int old_autoload;
> -	int ret, result;
> -
> -	log_debug("addr=3D%lx, fname=3D%s, autoload=3D%d\n", addr, fname, auto=
load);
> -	old_autoload =3D env_get_yesno("autoload");
> -	ret =3D env_set("autoload", autoload ? "y" : "n");
> -	if (ret)
> -		return log_msg_ret("en1", -EINVAL);
> -
> -	if (autoload) {
> -		sprintf(file_addr, "%lx", addr);
> -		dhcp_argv[1] =3D file_addr;
> -	}
> -
> -	result =3D do_dhcp(&cmdtp, 0, !autoload ? 1 : fname ? 3 : 2, dhcp_argv=
);
> -
> -	ret =3D env_set("autoload", old_autoload =3D=3D -1 ? NULL :
> -		      old_autoload ? "y" : "n");
> -	if (ret)
> -		return log_msg_ret("en2", -EINVAL);
> -
> -	if (result)
> -		return log_msg_ret("res", -ENOENT);
> -
> -	return 0;
> -}
>   #endif
>  =20
>   #if defined(CONFIG_CMD_NFS)
> diff --git a/include/net-common.h b/include/net-common.h
> index 1112af381a98..78d98e5bba07 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -479,6 +479,16 @@ int net_loop(enum proto_t protocol);
>    */
>   int dhcp_run(ulong addr, const char *fname, bool autoload);
>  =20
> +/**
> + * do_dhcp - Run the dhcp command
> + *
> + * @cmdtp: Unused
> + * @flag: Command flags (CMD_FLAG_...)
> + * @argc: Number of arguments
> + * @argv: List of arguments
> + * Return: result (see enum command_ret_t)
> + */
> +int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[]);
>  =20
>   /**
>    * do_ping - Run the ping command
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index e88e2186635b..c910def5719e 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -50,7 +50,6 @@ int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *=
ip);
>    */
>   bool wget_validate_uri(char *uri);
>  =20
> -int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[]);
>   int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv=
[]);
>   int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const ar=
gv[]);
>  =20
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index 531bf2c67057..b798014ebcb9 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -150,25 +150,3 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[])
>  =20
>   	return CMD_RET_SUCCESS;
>   }
> -
> -int dhcp_run(ulong addr, const char *fname, bool autoload)
> -{
> -	char *dhcp_argv[] =3D {"dhcp", NULL, };
> -#ifdef CONFIG_CMD_TFTPBOOT
> -	char *tftp_argv[] =3D {"tftpboot", boot_file_name, NULL, };
> -#endif
> -	struct cmd_tbl cmdtp =3D {};	/* dummy */
> -
> -	if (autoload) {
> -#ifdef CONFIG_CMD_TFTPBOOT
> -		/* Assume DHCP was already performed */
> -		if (boot_file_name[0])
> -			return do_tftpb(&cmdtp, 0, 2, tftp_argv);
> -		return 0;
> -#else
> -		return -EOPNOTSUPP;
> -#endif
> -	}
> -
> -	return do_dhcp(&cmdtp, 0, 1, dhcp_argv);
> -}
> diff --git a/net/net-common.c b/net/net-common.c
> index b064557d5241..442b05975581 100644
> --- a/net/net-common.c
> +++ b/net/net-common.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>  =20
>   #include <dm/uclass.h>
> +#include <env.h>
>   #include <net-common.h>
>   #include <linux/time.h>
>   #include <rtc.h>
> @@ -48,3 +49,37 @@ void net_sntp_set_rtc(u32 seconds)
>   	       tm.tm_year, tm.tm_mon, tm.tm_mday,
>   	       tm.tm_hour, tm.tm_min, tm.tm_sec);
>   }
> +
> +#if defined(CONFIG_CMD_DHCP)
> +int dhcp_run(ulong addr, const char *fname, bool autoload)
> +{
> +	char *dhcp_argv[] =3D {"dhcp", NULL, (char *)fname, NULL};
> +	struct cmd_tbl cmdtp =3D {};	/* dummy */
> +	char file_addr[17];
> +	int old_autoload;
> +	int ret, result;
> +
> +	log_debug("addr=3D%lx, fname=3D%s, autoload=3D%d\n", addr, fname, auto=
load);
> +	old_autoload =3D env_get_yesno("autoload");
> +	ret =3D env_set("autoload", autoload ? "y" : "n");
> +	if (ret)
> +		return log_msg_ret("en1", -EINVAL);
> +
> +	if (autoload) {
> +		sprintf(file_addr, "%lx", addr);
> +		dhcp_argv[1] =3D file_addr;
> +	}
> +
> +	result =3D do_dhcp(&cmdtp, 0, !autoload ? 1 : fname ? 3 : 2, dhcp_argv=
);
> +
> +	ret =3D env_set("autoload", old_autoload =3D=3D -1 ? NULL :
> +		      old_autoload ? "y" : "n");
> +	if (ret)
> +		return log_msg_ret("en2", -EINVAL);
> +
> +	if (result)
> +		return log_msg_ret("res", -ENOENT);
> +
> +	return 0;
> +}
> +#endif

