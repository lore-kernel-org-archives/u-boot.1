Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF52EC83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 10:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33FC086ACF;
	Sat, 26 Aug 2023 12:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aXdpptz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6589E86ACC; Sat, 26 Aug 2023 12:39:09 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB43686B20
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 12:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693046345; x=1693651145; i=xypron.glpk@gmx.de;
 bh=la9kYgYjtprlD0a+tABP3rQpPKtovn/sYWg6c/LcYVs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=aXdpptz/Du0uGUac0mlxNEW+LjRDKkw1emKBB+Gz5qiur2UV22ffYwVvidb9s+dbaTaG89O
 lUOyDB7v0ktLqgLLKrCoNSH5br4+rseLc/eRB7AExzeWsnb6+UGSPqDJDDICGdDd57EMom3B9
 qS7NbyyjFMxwbuDzzVEIVWrsKC3gy9muBa4kNvbWem+Op5iJGJVX9iK/Ms01l4EjG1IFS1p0r
 kdDI/mXIF2cQ849clA6f7v5vKiiIwycEJsjlk6BdLS+scGPwA/a9rg2W+/GTIKYwXqf6iR1M6
 bDKaS5sAqXHrSGB/te4b7OkGqnqHQAbQWPxskfaAa+oRSQ2oUqNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdebB-1q0Exc03MX-00Zk9j; Sat, 26
 Aug 2023 12:39:05 +0200
Message-ID: <a1b4dfb2-bbf7-5487-098f-c4c46ecf631c@gmx.de>
Date: Sat, 26 Aug 2023 12:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/5] dt: Provide a way to remove non-compliant nodes
 and properties
Content-Language: en-US, de-DE
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-2-sughosh.ganu@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230826090633.239342-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nxpC5EbaJ5Ijxf5osUtsC7n+4pvN+CHXdqZrT7C+GVttCxacpVo
 SL4tOUFUVpxRx86Xq6BIgpxjv7PKDA3urut2dZ9F3fTY0WfmJbF2hyh5M4crkd3U8DoNlBm
 Z/fKRh1n3wxJ1itK08esKBZtLbclCCTseDy6FRAmiBEayK2DzQQGdWjY8q4D+dPmmjuhiYI
 YD5YywdqnLGpyjjgQ83BA==
UI-OutboundReport: notjunk:1;M01:P0:tmP//Az3mWM=;En8WZwufixwme4Pa/kK15PUgmCm
 fhoxosmvKEbGLytTTw2hRU4bxhzvXJ+DDSHgIrpM2HjRYseVJUWZDjOQEA8ebHimL2EZ01OTf
 j1Dz0kEVwlP+BttNFdMkOlI/edLBIdAVWSCnWPXQTrpSEBEXoC+MOlLMteQaXBBcgqivbKtyt
 J1GClSUjAq45EiskncTJTvKV77oIceD7Pg9GxI8KPSwPZjFGNOZ44f5qMF/Cfe/wTbeqc7bKk
 JJnCAboYRiKVk6Ob37pHnAvR1zkXtds6zKJ+bp+NV3S8GZkInJjl2pL4YbE64xnR9wAFK6Xgx
 uZpV64/1vbpkyrUsMB+rTrVocilvce9cuI7WcB09PhI4Y/wUvbzECbmeWzFjRdHTHjFeH7hXI
 he4lQOJVXYmGend5atr30na6XnV4Xy7DMfLokc2/T+sZofD9fVn1eskOqYal/ErNsJ7AhulMm
 QKtsTYkJ89a7P2uRaSTXZYQav1yfDdynQJREQx8uivyrlMEsecU0wLNjz+CWwMesYAkfidrcb
 NzByBMhI/sFzXMe+LQSs2ywxnIdsdnDHUkvXnrd3D8NiZT8/H1ATwJAw4o6iCRVOSn/LK3QBO
 7IPn+/Vdx5VF5ip/UH1OHRkDp+cJfotQnKH1C6Y7O91gcwn4HKsPdBTf6+tIRb9lC5bmdUdHK
 yJrhHI3ke7J1l13S7rW25q37O++/sH88LIF2khglqJZsa/nvFHHz9E5M+iidBkmySMPMZlCkz
 ilIhiYit41kZn374JWVkoLk52evpCm1T6T7w5PZ10si8/7s7WzBOXJXVT+iNtNpzp4zvTKuAa
 dYPxIvJJV/7OCVCQeClnlwBTfRFLDN2Kc42kRgsWLGnCXNEuiTBgcOD9VLzx6aJv3dbKoeTOK
 hrPbyxS9YJ+qoaT/xP1vSOfbPzYnmXZCaxbXIQ8tGwggpPazoq0Th3vsSUUWdKkrAUGauSX5Y
 B7g2ymlkv+e0E452052yQp32/8Q=
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

On 8/26/23 11:06, Sughosh Ganu wrote:
> Add a function which is registered to spy for a EVT_FT_FIXUP event,
> and removes the non upstreamed nodes and properties from the
> devicetree before it gets passed to the OS.
>
> This allows removing entire nodes, or specific properties under nodes
> from the devicetree. The required nodes and properties can be
> registered for removal through the DT_NON_COMPLIANT_PURGE and
> DT_NON_COMPLIANT_PURGE_LIST macros.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   include/dt-structs.h | 11 +++++++
>   lib/Makefile         |  1 +
>   lib/dt_purge.c       | 73 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 85 insertions(+)
>   create mode 100644 lib/dt_purge.c
>
> diff --git a/include/dt-structs.h b/include/dt-structs.h
> index fa1622cb1d..f535c60471 100644
> --- a/include/dt-structs.h
> +++ b/include/dt-structs.h
> @@ -57,3 +57,14 @@ struct phandle_2_arg {
>   #endif
>
>   #endif
> +
> +struct dt_non_compliant_purge {
> +	const char *node_path;
> +	const char *prop;
> +};
> +
> +#define DT_NON_COMPLIANT_PURGE(__name)	\
> +	ll_entry_declare(struct dt_non_compliant_purge, __name, dt_purge)
> +
> +#define DT_NON_COMPLIANT_PURGE_LIST(__name)	\
> +	ll_entry_declare_list(struct dt_non_compliant_purge, __name, dt_purge)
> diff --git a/lib/Makefile b/lib/Makefile
> index 8d8ccc8bbc..82a906daa0 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -37,6 +37,7 @@ endif
>   obj-y +=3D crc8.o
>   obj-y +=3D crc16.o
>   obj-y +=3D crc16-ccitt.o
> +obj-y +=3D dt_purge.o

SPL can be the last boot stage (e.g. for Falcon Mode). So placing this
under 'ifndef CONFIG_SPL_BUILD' is not correct.

You need some logic that identifies into which boot stage this code
belongs, e.g. use obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT).

Best regards

Heinrich

>   obj-$(CONFIG_ERRNO_STR) +=3D errno_str.o
>   obj-$(CONFIG_FIT) +=3D fdtdec_common.o
>   obj-$(CONFIG_TEST_FDTDEC) +=3D fdtdec_test.o
> diff --git a/lib/dt_purge.c b/lib/dt_purge.c
> new file mode 100644
> index 0000000000..f893ba9796
> --- /dev/null
> +++ b/lib/dt_purge.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <dt-structs.h>
> +#include <event.h>
> +#include <linker_lists.h>
> +
> +#include <linux/libfdt.h>
> +
> +/**
> + * dt_non_compliant_purge() -	Remove non-upstreamed nodes and propertie=
s
> + *				from the DT
> + * @ctx: Context for event
> + * @event: Event to process
> + *
> + * Iterate through an array of DT nodes and properties, and remove them
> + * from the device-tree before the DT gets handed over to the kernel.
> + * These are nodes and properties which do not have upstream bindings
> + * and need to be purged before being handed over to the kernel.
> + *
> + * If both the node and property are specified, delete the property. If
> + * only the node is specified, delete the entire node, including it's
> + * subnodes, if any.
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +static int dt_non_compliant_purge(void *ctx, struct event *event)
> +{
> +	int nodeoff =3D 0;
> +	int err =3D 0;
> +	void *fdt;
> +	const struct event_ft_fixup *fixup =3D &event->data.ft_fixup;
> +	struct dt_non_compliant_purge *purge_entry;
> +	struct dt_non_compliant_purge *purge_start =3D
> +		ll_entry_start(struct dt_non_compliant_purge, dt_purge);
> +	int nentries =3D ll_entry_count(struct dt_non_compliant_purge, dt_purg=
e);
> +
> +	if (fixup->images)
> +		return 0;
> +
> +	fdt =3D fixup->tree.fdt;
> +	for (purge_entry =3D purge_start; purge_entry !=3D purge_start + nentr=
ies;
> +	     purge_entry++) {
> +		nodeoff =3D fdt_path_offset(fdt, purge_entry->node_path);
> +		if (nodeoff < 0) {
> +			log_debug("Error (%d) getting node offset for %s\n",
> +				  nodeoff, purge_entry->node_path);
> +			continue;
> +		}
> +
> +		if (purge_entry->prop) {
> +			err =3D fdt_delprop(fdt, nodeoff, purge_entry->prop);
> +			if (err < 0 && err !=3D -FDT_ERR_NOTFOUND) {
> +				log_debug("Error (%d) deleting %s\n",
> +					  err, purge_entry->prop);
> +				goto out;
> +			}
> +		} else {
> +			err =3D fdt_del_node(fdt, nodeoff);
> +			if (err) {
> +				log_debug("Error (%d) trying to delete node %s\n",
> +					  err, purge_entry->node_path);
> +				goto out;
> +			}
> +		}
> +	}
> +
> +out:
> +	return err;
> +}
> +EVENT_SPY(EVT_FT_FIXUP, dt_non_compliant_purge);

