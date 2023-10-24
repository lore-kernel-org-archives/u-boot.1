Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F84EC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 05:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE65987098;
	Tue, 24 Oct 2023 07:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BZeRa+9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7238870CB; Tue, 24 Oct 2023 07:54:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0483C87052
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 07:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698126848; x=1698731648; i=xypron.glpk@gmx.de;
 bh=TtioKYfN1TzRKyhirSt176ImHWkWrxZK/U0rYhCIArk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=BZeRa+9MS8H2AsWwAJLJAD/wqv72paeUAj/3qNoUnLe/Szc+ykQxlifU4D/i4pIP
 gBL1dclstBq0Bib85WghiKFiyGnDBKsV11leZ3tUbgWXI+eanXLX1f0ioiwYZScyB
 aHlX3q1T3dQ4JlkwzIJFwx7uaHBhcbZyWK3w3Hix3M9A4qIHSU6JurYo7ZlzTT0H0
 Wr09Vsd4UsC1XitOqcNUfN87trr899ocg4mhFBjG1c8Nb9PzdJdHZOaTq1KPgxVm1
 +RTNybMNNo8GEfAa3Q0E7NxgWtThCFlXtzv4+cCYI9yV93yzeXzis3OhVu3RwgZtP
 UxwUNztbiaI/jA9ZtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1qnlQq4Bo3-00BrRF; Tue, 24
 Oct 2023 07:54:08 +0200
Message-ID: <9a42da8f-2d82-4470-82bd-ef872e72810a@gmx.de>
Date: Tue, 24 Oct 2023 07:54:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: Get pxe config file from dhcp option 209
To: seanedmond@linux.microsoft.com
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-2-seanedmond@linux.microsoft.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231024002159.74477-2-seanedmond@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UBorwYt4XqSjOuAp/Vy+1eQKs/fFvmoX2Krjy2agw3fb/VGWKet
 1CaRAHFeDdsX9d/B/svmmcJxMXerIRMdvXRCje8JhQg9CVrtMnfO3bqmKXsnc7oqSVPjAKx
 NkrKL1wHbVfUq244vtf2+aQHsqFsBYmPkse/s+nZT+vZcqj3ISIoa5A2hbxXoXcUDhIpE/p
 PZgbUx6J7Cl/ROEQe+R0Q==
UI-OutboundReport: notjunk:1;M01:P0:gjMS1LBxkvU=;K1G7zOMys1aOFwITrHIsOQkYLW3
 lblgsZ01fW2CjZvwq+5rCxor7cpz/fLi/ZBcl4ZwUDAK9kBFKWV7RSUe5tPTTvHTOojfn+nJS
 7x4MqzIKZYfkN8f4vjjatD7wjrp8b+nhBomX17oiyBcwgd+56ksEaCayp/gkljbiHsUPJWW3V
 mYffaW3NqSc++F4VNJul74Cs87Te6+S78TBrDMDNbWqug9fqL0N3P67PkGwAXI406kbyv4lr2
 YxYL/RLh3ogl8RTlYWNTKp8BhHzUIlOzf2gNvxk9Chtq4H/v8oBzuphWjDc0Dcasl4EJnE9q4
 nt7gLjc8fhU/1p3alcrWTqdLu2m8avWZblNh8DXhavCvlLDKl0PzKPa+Pc090M/2hWUJIXmF2
 8xr3vVxORg53DtQmnxzaDsXbtLCVCsmNsEqS7V0vZFn86na6udSqz+0btrM7tf9ajzI7gtPHS
 ltxkdKXQn/wAI5zPhvJaRNERmy/yAOLOQMf1bYQQfcbrb8LzYWvZpPxenIisktdHFcwvR9SRd
 eGncxqZHYdbFFn6nN4gHHUPC52eGFK3TLiyYAgSOx/mqz1qUC6mbActAlfnJJECgIppF6cCs+
 2vaH3bBO/fiYn7gGzA+L4yQ0WWU+Btja8nqCBHwIbD3+lxxuKtJ2p+6RWsOtKlCSAwPezlvj5
 +0D+TInlifxBy1kGkTMkZtmpHpwy3fdyrnP0ngFwjCiaGsM7oR9iM3Ur88npjHUaBQ5qetZ7V
 6On3D8btZSynSrnrIQmCPX2UIG3dZe2H4glz4amr+HIL4eqrUwGzWn48C5OUNiNmwjQYX32db
 nDX8UEGzQImyhlR8TkAYmVz3CR2Vrur24Y8WY370kEFLa2dvM5JXnoCSgpChHYuQ6xB57AZmF
 NSx4UUOLd46d7VRTviE2JUDk181iVJv0tDYhUhu61vetLvPFHS1GsTXT/cdsExnLVogivMBYb
 t3+aodHODlwcpqAAJuQt05A4wVE=
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
> Allow dhcp server pass pxe config file full path by using option 209
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>   cmd/Kconfig |  4 ++++
>   cmd/pxe.c   | 10 ++++++++++
>   net/bootp.c | 21 +++++++++++++++++++++
>   3 files changed, 35 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 5bc0a92d57..adbb1a6187 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1826,6 +1826,10 @@ config BOOTP_PXE_CLIENTARCH
>   	default 0x15 if ARM
>   	default 0x0 if X86
>
> +config BOOTP_PXE_DHCP_OPTION
> +	bool "Request & store 'pxe_configfile' from BOOTP/DHCP server"
> +	depends on BOOTP_PXE

Why should this be disabled by default?

Do we really want a separate config variable?

> +
>   config BOOTP_VCI_STRING
>   	string
>   	depends on CMD_BOOTP
> diff --git a/cmd/pxe.c b/cmd/pxe.c
> index 704589702f..9404f44518 100644
> --- a/cmd/pxe.c
> +++ b/cmd/pxe.c
> @@ -65,6 +65,8 @@ static int pxe_dhcp_option_path(struct pxe_context *ct=
x, unsigned long pxefile_a
>   	int ret =3D get_pxe_file(ctx, pxelinux_configfile, pxefile_addr_r);
>
>   	free(pxelinux_configfile);
> +	/* set to NULL to avoid double-free if DHCP is tried again */
> +	pxelinux_configfile =3D NULL;
>
>   	return ret;
>   }
> @@ -141,6 +143,14 @@ int pxe_get(ulong pxefile_addr_r, char **bootdirp, =
ulong *sizep, bool use_ipv6)
>   			  env_get("bootfile"), use_ipv6))
>   		return -ENOMEM;
>
> +	if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION) &&
> +	    pxelinux_configfile && !use_ipv6) {
> +		if (pxe_dhcp_option_path(&ctx, pxefile_addr_r) > 0)
> +			goto done;
> +
> +		goto error_exit;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_DHCP6_PXE_DHCP_OPTION) &&
>   	    pxelinux_configfile && use_ipv6) {
>   		if (pxe_dhcp_option_path(&ctx, pxefile_addr_r) > 0)
> diff --git a/net/bootp.c b/net/bootp.c
> index 7b0f45e18a..6800290963 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -26,6 +26,7 @@
>   #ifdef CONFIG_BOOTP_RANDOM_DELAY
>   #include "net_rand.h"
>   #endif
> +#include <malloc.h>
>
>   #define BOOTP_VENDOR_MAGIC	0x63825363	/* RFC1048 Magic Cookie */
>
> @@ -601,6 +602,10 @@ static int dhcp_extended(u8 *e, int message_type, s=
truct in_addr server_ip,
>   	*e++  =3D 42;
>   	*cnt +=3D 1;
>   #endif
> +	if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
> +		*e++ =3D 209;	/* PXELINUX Config File */
> +		*cnt +=3D 1;
> +	}
>   	/* no options, so back up to avoid sending an empty request list */
>   	if (*cnt =3D=3D 0)
>   		e -=3D 2;
> @@ -909,6 +914,22 @@ static void dhcp_process_options(uchar *popt, uchar=
 *end)
>   				net_boot_file_name[size] =3D 0;
>   			}
>   			break;
> +		case 209:	/* PXELINUX Config File */

This 209 appears in multiple places. Please, define a constant, e.g.
DHCP_OPTION_CONFIG_FILE, in bootp.h and use the symbolic name. Please,
document the constant referring to RFC 5071.

> +			if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
> +				/* In case it has already been allocated when get DHCP Offer packet=
,
> +				 * free first to avoid memory leak.
> +				 */
> +				if (pxelinux_configfile)
> +					free(pxelinux_configfile);
> +
> +				pxelinux_configfile =3D (char *)malloc((oplen + 1) * sizeof(char));
> +
> +				if (pxelinux_configfile)
> +					strlcpy(pxelinux_configfile, popt + 2, oplen + 1);
> +				else
> +					printf("Error: Failed to allocate pxelinux_configfile\n");

We do the same in dhcp6_parse_options(). Please, factor out a common
function to avoid code duplication.

Best regards

Heinrich

> +			}
> +			break;
>   		default:
>   #if defined(CONFIG_BOOTP_VENDOREX)
>   			if (dhcp_vendorex_proc(popt))

