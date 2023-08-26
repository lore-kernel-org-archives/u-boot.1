Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A6CC83F13
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 10:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECDFF86AF8;
	Sat, 26 Aug 2023 12:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uN4R5sNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7060086B20; Sat, 26 Aug 2023 12:21:27 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C44DC86ACC
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 12:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693045283; x=1693650083; i=xypron.glpk@gmx.de;
 bh=k/4Dy2XOvIaoKtY2+tG804otvrXVtrYMBCXIcsBtDIQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=uN4R5sNye7Z3pVt6fH1lNOwzzRnrzEPlIezafwQCQceTRmS7lhPbufUog6TD0+x+q2USuPp
 plwv4CwXBZxJ2UCuIxjiHjqhkK6DGwGqFZ0bU5iINs3Fszu+is7aJwdZ1D+ScBxJheWcOsdQz
 x7ag3JcYefor/mR5jn5qfMc2U/pxM0RVJAxxakZy9jOIgbW5v7m+m9KVZ3b0k7gLPamynT5di
 0tQe7quWzI10uc7r9fbxERghJIYdIaRfpQd+evvsUHrNamwW5HOH0hzyjq/VuTFpP8PA6eH25
 4GSddLHJPC4Nws3v0XJFRNsdWrtkwOTyLuaZ1046dZvwTJDa+P1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1pxmNB0pew-00oF5k; Sat, 26
 Aug 2023 12:21:23 +0200
Message-ID: <0a168e1e-546e-c149-d715-ccacfeb4208f@gmx.de>
Date: Sat, 26 Aug 2023 12:22:16 +0200
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
X-Provags-ID: V03:K1:Upw52qAUJW0FivYOaDB+UMWfbz4bxsWU7IW22htzfDgjSBZcObA
 /jJEKZK8J1kkj3nHISYG0or00avNKf3oMBt3ukfJ7UqjEaqfdOfN9aOWr2QjSt1y0vGfCxB
 lJTwx711R1iACuD0kJWr9iuh679WvtjVE5cwnRJi9/MXwzcOHX5QQVISYe4njxFSnUoHm/G
 lF+a9OKwwtV4jp64SPYVA==
UI-OutboundReport: notjunk:1;M01:P0:SRZWIoL0+lA=;AaETQ43UDokU+Ul3vA438WdeQ6c
 RjMKhk//bgt3A9TduqzSbHapWh7GJjdaSR+Mi6c9FuHW5jonxFRtyTt72Cv51sltKR/LjM8Kv
 7Dvry1Wcl9LprBHvc5t0cUt6Z+7S6nd4m97jZu4qMPlkSNmgs5rVU0cQTJWDzuYfaGBu9nozg
 PUCZBaWZQ6OAZPLbZ6ylp3dvMFgkqscV5baH2ItIz5ln6TopGj4uy/M4tcyvUZNE/SIWZglRX
 MKDN6Smi3RhRZiX+G9JHepEsZO0Yu5/OFSvU1YIFt6gQwb07Y8m2tFlB1A6OQPoB23ggX1vm+
 sUy6/OWEcNAS68+v0SjfncX1lIrNUtCDlGvRl+rNkNGmsU+ySDLkFLWoCXzMoK5mHxqhoAjQk
 UwSd0ZQ52R52oQwpbPESUg5veq5RwFH4oFGv2u6iNF1niPef25q49GKLRrya8hLpwaJZgUVD5
 T4GVioHbZbweSPcLxmxEcriqX7otapQkKG41oQNMfAE8QShNytn7WjenYsMX8O0vzovDU1REx
 S9emjB3g5jZNDj0fLiBkt1n43HRTFqRexVWlQI5bggQquYDNym9ieR0EiwlaE3/hQQGz8XzL2
 fiBdctNBzhCgk+pT7oC+BrW+PuHBeNnujTT9y6NORcwXkkgP6D2BnCaPiy+XQ6w4mx0cwMPvK
 Y4rKS+WHtTgEvLjdGtNkYAEkrF9sFNf/2y2k44kwCYeqNkN0lj+qW6wBVrIxm0Vkkr8Ihu0p8
 yFN/xOgRNVjm5WZfCVZYmW7C+cg5vhU5qrD8qNwxIY0asDdarxA0I0KUpLJSU3obwifS0lwnn
 sXslVFQ/1Gtiec9D/gHQ6X+z1flSXKqAtZKzGpAlDjigkyi3AjHrQX0WJmW0CtDGVB5oD3M8z
 12x+sCYIEZ/R08icz+enT6BZyHRkSnaioje2BhLoTNq5+qhA9gGenW07lWAoTA2Q8JYO+3i0D
 1vA7MxaqlwntzOGL/RUTpKlNfRE=
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

This may interfere with other fixup code requiring U-Boot specific
properties like bootmeth_vbe_ft_fixup().

We should ensure that call dt_non_compliant_purge() is the last fixup
action. Please, consider a separate event.

This code does not check if the property or node complies to the device
tree scheme or not. So why not call the function dt_purge()?

Best regards

Heinrich
