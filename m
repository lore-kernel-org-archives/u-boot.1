Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C48E7C4F4
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 07:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA7D86DB9;
	Thu,  5 Oct 2023 09:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="lUK3SFFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F34BA86E04; Thu,  5 Oct 2023 09:06:53 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D6086CCD
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 09:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864251c908=etienne.carriere@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3956Yi47010521; Thu, 5 Oct 2023 09:06:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 selector1; bh=roY6z0GT1ptc05Gpcq/iOGD/y8uHALEcjYrKNbentS4=; b=lU
 K3SFFBETdjIdfz3F8WShP0C9YiUC+mlYbRNDX+/vUCke7ky9oLXNhnNYdfs+sCN6
 yRfnwUpXtxW4SoJJeN1eGgVArAfbx1TYiKw7DNiFS/0qWMZaWHfs2r7GDLzTJVof
 6MiHv6P1TUg8toXtKFKfyiUF3VU2CZYokll801/S+KwYjPccpIKcKVH6yiBsZ9YF
 ZkZO2ezmFCHzTYprxEcDHn5cCsndYL7RFK6GTD/i7AoUMOc61+rYXvk+Ko88UIIp
 hm2MC5Z6mBcS4U2cAhBIllCmC7hAljLi5Q1l1mjTEKdGRwpKZP8cNr4VZxbKRaA/
 ySGtRjQNRJvdCoeFmCVg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3thr0dg49k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 09:06:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 902E710006D;
 Thu,  5 Oct 2023 09:06:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 877E721B504;
 Thu,  5 Oct 2023 09:06:47 +0200 (CEST)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:06:47 +0200
Received: from SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1]) by
 SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1%14]) with mapi id
 15.01.2507.027; Thu, 5 Oct 2023 09:06:47 +0200
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>
CC: Etienne CARRIERE <etienne.carriere@st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 05/16] firmware: scmi: implement SCMI base protocol
Thread-Topic: [PATCH v5 05/16] firmware: scmi: implement SCMI base protocol
Thread-Index: AQHZ8EbyaL5e6iPgkkWgRkpW8lnp0bA6zQU5
Date: Thu, 5 Oct 2023 07:06:47 +0000
Message-ID: <fb8782c98aee403b94c1aef98edf695d@foss.st.com>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>,
 <20230926065750.734440-6-takahiro.akashi@linaro.org>
In-Reply-To: <20230926065750.734440-6-takahiro.akashi@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.201.20.20]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_03,2023-10-02_01,2023-05-22_02
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

Hello Akashi-san,


> From: U-Boot <u-boot-bounces@lists.denx.de> on behalf of AKASHI Takahiro =
<takahiro.akashi@linaro.org>
> Sent: Tuesday, September 26, 2023 8:57 AM
>=20
> SCMI base protocol is mandatory according to the SCMI specification.
>=20
> With this patch, SCMI base protocol can be accessed via SCMI transport
> layers. All the commands, except SCMI_BASE_NOTIFY_ERRORS, are supported.
> This is because U-Boot doesn't support interrupts and the current transpo=
rt
> layers are not able to handle asynchronous messages properly.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v3
> * strncpy (TODO)
> * remove a duplicated function prototype
> * use newly-allocated memory when return vendor name or agent name
> * revise function descriptions in a header
> v2
> * add helper functions, removing direct uses of ops
> * add function descriptions for each of functions in ops
> ---

This patch v5 looks good to me. 2 suggestions.

Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com> with comments =
addressed or not.
I have successfully tested the whole PATCH v5 series on my platform.



>  drivers/firmware/scmi/Makefile |   1 +
>  drivers/firmware/scmi/base.c   | 657 +++++++++++++++++++++++++++++++++
>  include/dm/uclass-id.h         |   1 +
>  include/scmi_protocols.h       | 351 ++++++++++++++++++
>  4 files changed, 1010 insertions(+)
>  create mode 100644 drivers/firmware/scmi/base.c
>=20
> diff --git a/drivers/firmware/scmi/Makefile b/drivers/firmware/scmi/Makef=
ile
> index b2ff483c75a1..1a23d4981709 100644
> --- a/drivers/firmware/scmi/Makefile
> +++ b/drivers/firmware/scmi/Makefile
> @@ -1,4 +1,5 @@
>  obj-y  +=3D scmi_agent-uclass.o
> +obj-y  +=3D base.o
>  obj-y  +=3D smt.o
>  obj-$(CONFIG_SCMI_AGENT_SMCCC)         +=3D smccc_agent.o
>  obj-$(CONFIG_SCMI_AGENT_MAILBOX)       +=3D mailbox_agent.o
> diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
> new file mode 100644
> index 000000000000..dba143e1ff5d
> --- /dev/null
> +++ b/drivers/firmware/scmi/base.c
> @@ -0,0 +1,657 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SCMI Base protocol as U-Boot device
> + *
> + * Copyright (C) 2023 Linaro Limited
> + *             author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <scmi_agent.h>
> +#include <scmi_protocols.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <asm/types.h>
> +#include <dm/device_compat.h>
> +#include <linux/kernel.h>
> +
> +/**
> + * scmi_generic_protocol_version - get protocol version
> + * @dev:       SCMI device
> + * @id:                SCMI protocol ID
> + * @version:   Pointer to SCMI protocol version
> + *
> + * Obtain the protocol version number in @version.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int scmi_generic_protocol_version(struct udevice *dev,
> +                                 enum scmi_std_protocol id, u32 *version=
)
> +{
> +       struct scmi_protocol_version_out out;
> +       struct scmi_msg msg =3D {
> +               .protocol_id =3D id,
> +               .message_id =3D SCMI_PROTOCOL_VERSION,
> +               .out_msg =3D (u8 *)&out,
> +               .out_msg_sz =3D sizeof(out),
> +       };
> +       int ret;
> +
> +       ret =3D devm_scmi_process_msg(dev, &msg);
> +       if (ret)
> +               return ret;
> +       if (out.status)
> +               return scmi_to_linux_errno(out.status);
> +
> +       *version =3D out.version;
> +
> +       return 0;
> +}
> +
> +/**
> + * scmi_base_protocol_version_int - get Base protocol version
> + * @dev:       SCMI device
> + * @version:   Pointer to SCMI protocol version
> + *
> + * Obtain the protocol version number in @version for Base protocol.
> + *
> + * Return: 0 on success, error code on failure
> + */

I think these inline description comment for scmi_base_protocol_xxx_int()
would better be placed as description for the exported functions scmi_base_=
protocol_xxx() and scmi_base_discover_xxx(). Either in the .c file or in th=
e header file.

Especially regarding the function scmi_base_discover_vendor()/_discover_sub=
_vendor()/_discover_agent() where caller is responsible for freeing the out=
put string.


> +static int scmi_base_protocol_version_int(struct udevice *dev, u32 *vers=
ion)
> +{
> +       return scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_BASE,
> +                                            version);
> +}
> +
> +/**
> + * scmi_protocol_attrs_int - get protocol attributes
> + * @dev:               SCMI device
> + * @num_agents:                Number of SCMI agents
> + * @num_protocols:     Number of SCMI protocols
> + *
> + * Obtain the protocol attributes, the number of agents and the number
> + * of protocols, in @num_agents and @num_protocols respectively, that
> + * the device provides.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +static int scmi_protocol_attrs_int(struct udevice *dev, u32 *num_agents,
> +                                  u32 *num_protocols)
> +{
> +       struct scmi_protocol_attrs_out out;
> +       struct scmi_msg msg =3D {
> +               .protocol_id =3D SCMI_PROTOCOL_ID_BASE,
> +               .message_id =3D SCMI_PROTOCOL_ATTRIBUTES,
> +               .out_msg =3D (u8 *)&out,
> +               .out_msg_sz =3D sizeof(out),
> +       };
> +       int ret;
> +
> +       ret =3D devm_scmi_process_msg(dev, &msg);
> +       if (ret)
> +               return ret;
> +       if (out.status)
> +               return scmi_to_linux_errno(out.status);
> +
> +       *num_agents =3D SCMI_PROTOCOL_ATTRS_NUM_AGENTS(out.attributes);
> +       *num_protocols =3D SCMI_PROTOCOL_ATTRS_NUM_PROTOCOLS(out.attribut=
es);
> +
> +       return 0;
> +}
> +
(snip)
> +
> +/**
> + * scmi_base_probe - probe base protocol device
> + * @dev:       SCMI device
> + *
> + * Probe the device for SCMI base protocol and initialize the private da=
ta.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +static int scmi_base_probe(struct udevice *dev)
> +{
> +       int ret;
> +
> +       ret =3D devm_scmi_of_get_channel(dev);
> +       if (ret) {
> +               dev_err(dev, "get_channel failed\n");
> +               return ret;
> +       }
> +
> +       return ret;
> +}
> +
> +struct scmi_base_ops scmi_base_ops =3D {

Could be static.
By the way, struct scmi_base_ops is defined in the header file but I don't =
think it needs to be known from other drivers/env, even in the case of the =
sandbox tests.
Maybe struct scmi_base_ops could be defined in this source file.

Regards,
Etienne


> +       /* Commands */
> +       .protocol_version =3D scmi_base_protocol_version_int,
> +       .protocol_attrs =3D scmi_protocol_attrs_int,
> +       .protocol_message_attrs =3D scmi_protocol_message_attrs_int,
> +       .base_discover_vendor =3D scmi_base_discover_vendor_int,
> +       .base_discover_sub_vendor =3D scmi_base_discover_sub_vendor_int,
> +       .base_discover_impl_version =3D scmi_base_discover_impl_version_i=
nt,
> +       .base_discover_list_protocols =3D scmi_base_discover_list_protoco=
ls_int,
> +       .base_discover_agent =3D scmi_base_discover_agent_int,
> +       .base_notify_errors =3D NULL,
> +       .base_set_device_permissions =3D scmi_base_set_device_permissions=
_int,
> +       .base_set_protocol_permissions =3D scmi_base_set_protocol_permiss=
ions_int,
> +       .base_reset_agent_configuration =3D
> +                       scmi_base_reset_agent_configuration_int,
> +};
> +
> +int scmi_base_protocol_version(struct udevice *dev, u32 *version)
> +{
> +       const struct scmi_base_ops *ops =3D device_get_ops(dev);
> +
> +       if (ops->protocol_version)
> +               return (*ops->protocol_version)(dev, version);
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +int scmi_base_protocol_attrs(struct udevice *dev, u32 *num_agents,
> +                            u32 *num_protocols)
> +{
> +       const struct scmi_base_ops *ops =3D device_get_ops(dev);
> +
> +       if (ops->protocol_attrs)
> +               return (*ops->protocol_attrs)(dev, num_agents, num_protoc=
ols);
> +
> +       return -EOPNOTSUPP;
> +}
> +
(snip)=
