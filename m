Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA7DC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 17:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1B083439;
	Thu, 17 Jul 2025 19:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="CpcJQsfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6158383448; Thu, 17 Jul 2025 19:17:50 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932FE833FC
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 19:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-61585dfc8f8so339870eaf.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1752772666; x=1753377466; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNkIFtNUkZe5Vv5pFGp/Ji14EH9NC2HaNdefzsm1umA=;
 b=CpcJQsfkgZX0BDbxHnK4PrVkcIhoB8hVUJn81wCcHqt+IPa4rNkl+RBUI4ZzQ4lr9R
 SMflDpHbfUUq2NflAq4N3FF9oRIYZru3CLZQIeqQBDdBzeNRZCQkkOK2Xc4nm3lUIqiZ
 HeiiP1VK3sNM+bHSchhCU9nm8LxNJDSFiD9tH5uLr5vOiq3QCoEuZ4EQB+lXOM0blm8s
 KpYJPQ882U0lXAdD8YwOhuuWPCOSpWqUS3DzVCT00Rx2qzYY7f9WSZ3DMo5Q0umE+bU7
 hC6ca2mwr6D1bFCo1QE9ayfVm0jZcVowsODn450gDjIHINSYNh4dIwpLORVH2bwm4cLk
 AVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752772666; x=1753377466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNkIFtNUkZe5Vv5pFGp/Ji14EH9NC2HaNdefzsm1umA=;
 b=m9OCzU1SMHQBSE/R608kPpraAx2ot7D4bygi5mWCkafT+ohZO3v0uvnIxYVi8ZJ+wH
 Ko/tHqx9TJ2uw6CmrBOc09UGtoNMjWxKMgN+ef92qsFKQ0GQjFgudiWUmDpftrMZlX+5
 rmRRpOSsK8+vudzOjx2HqbUxOnrE/Xt+8h+UHwmhOAYkEpMBPeoylCPKykQcOBif61Aw
 woL01k/qA7rCUyPLOGOze1vPwlLHNgMJMUF9mQSJpXM/SqEfRHEBgMk6uVwjsoNMGmnL
 ZOR23MaitBFCJuZP2udh1WRyFKMHEG2bBuv5EjPyl2L+rF030PZfJy9JiC3GEn0XpGVm
 7E4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV8WROMnnMZX+i8ogIsDleKgQn3D+Na/nI0psygY8APFhDzRt92goti0pQ/lHzdMCpI5CFAy0=@lists.denx.de
X-Gm-Message-State: AOJu0YxDHm5dT76a71TsopxFtK/0lfV8q9Es+NasDQ8fkacxGiIDvZES
 NRqkdX+h9saNhWmdcSNeqcLd0DY2K2WObGF1AlUbEe61m5cMPP73CtuUhXKnGop7VVCvc2oY2U1
 FTJ2GBZhJiaX5mvcqMq3GpV3H4vLPowyCz5Jpvju8tQ==
X-Gm-Gg: ASbGnct4L/Dzqv/bCRypoJN58R1qunzkH/BYl2oDXQXY5U1MUmRFcvcpMEbS9irPkCx
 8gyvBq1gLLVQmHfGATlNr0LFWfPYG8CqUZd6SlQIWCk/E+2nLcLVvYnpcRdVFylfkeOS6YMSNBK
 czNrW9+s8PapMguiKrjLrr/IIwD52r+Q/TqID/TV7UWzyntg+9pyXacFNoWym0EwCeLsZefVpfZ
 pRWjft8G70a05YUcg==
X-Google-Smtp-Source: AGHT+IHWQR6ZA7GsS4gjvCrHpe9/rPHlGHtk0jekblo8BrLcQRUyEPdZRASceji2+u1k1Fv6bbZ6GTBV/lNIa9vQWfo=
X-Received: by 2002:a05:6820:4dcb:b0:613:87ee:10e with SMTP id
 006d021491bc7-6159ff061fbmr6079229eaf.5.1752772666103; Thu, 17 Jul 2025
 10:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250709153623.3038697-1-tharvey@gateworks.com>
In-Reply-To: <20250709153623.3038697-1-tharvey@gateworks.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 17 Jul 2025 10:17:35 -0700
X-Gm-Features: Ac12FXyStbw8zEYnRpQcte_z_6AvSaGdbAx4GV0kfqVI-HZcXFVrAQwHDkUFyco
Message-ID: <CAJ+vNU2rgaNgS2naHK0nU_kkPpa3y6DYeQzFrJUUb6T7vJnxWQ@mail.gmail.com>
Subject: Re: [v2 PATCH 1/2] usb: common: allow dr_mode to come from gpio-id
 based usb-connector
To: Marek Vasut <marex@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 9, 2025 at 8:36=E2=80=AFAM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> If a usb host with dr_mode of "otg" has a usb-connector using a GPIO ID
> pin use this to determine host vs peripheral.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2
>  - do not display error if 'port' node not found
>  - change print to debug
> ---
>  drivers/usb/common/common.c | 94 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> index 13e9a61072a9..85865712bfcc 100644
> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -8,6 +8,7 @@
>
>  #include <dm.h>
>  #include <asm/global_data.h>
> +#include <asm/gpio.h>
>  #include <linux/printk.h>
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ch9.h>
> @@ -22,6 +23,97 @@ static const char *const usb_dr_modes[] =3D {
>         [USB_DR_MODE_OTG]               =3D "otg",
>  };
>
> +/**
> + * get_remote_node_from_graph - Resolve the remote node from a graph bin=
ding
> + * @node: Starting ofnode (e.g., connector)
> + * @port_id: Port unit address (e.g., 0 for port@0, or -1 for first port=
)
> + * @endpoint_id: Endpoint unit address (e.g., 0 for endpoint@0, or -1 fo=
r first endpoint)
> + * Return: ofnode of the remote node, or ofnode_null() on failure
> + */
> +static ofnode get_remote_node_from_graph(ofnode node, int port_id, int e=
ndpoint_id)
> +{
> +       ofnode port_node, endpoint_node, remote_node;
> +       u32 phandle_value;
> +       char port_name[16];
> +       char endpoint_name[16];
> +
> +       /* Validate the starting node */
> +       if (!ofnode_valid(node)) {
> +               debug("Invalid starting node\n");
> +               return ofnode_null();
> +       }
> +
> +       /* Construct port name (e.g., "port" or "port@0") */
> +       if (port_id =3D=3D -1)
> +               strcpy(port_name, "port");
> +       else
> +               snprintf(port_name, sizeof(port_name), "port@%d", port_id=
);
> +
> +       /* look for a 'port' node */
> +       port_node =3D ofnode_find_subnode(node, port_name);
> +       if (!ofnode_valid(port_node))
> +               return ofnode_null();
> +
> +       /* Construct endpoint name (e.g., "endpoint" or "endpoint@0") */
> +       if (endpoint_id =3D=3D -1)
> +               strcpy(endpoint_name, "endpoint");
> +       else
> +               snprintf(endpoint_name, sizeof(endpoint_name), "endpoint@=
%d", endpoint_id);
> +
> +       /* Find the 'endpoint' node */
> +       endpoint_node =3D ofnode_find_subnode(port_node, endpoint_name);
> +       if (!ofnode_valid(endpoint_node)) {
> +               printf("No '%s' node found under '%s'\n", endpoint_name, =
port_name);
> +               return ofnode_null();
> +       }
> +
> +       /* Read the remote-endpoint phandle */
> +       phandle_value =3D ofnode_read_u32_default(endpoint_node, "remote-=
endpoint", 0);
> +       if (phandle_value =3D=3D 0) {
> +               printf("No valid 'remote-endpoint' phandle in '%s'\n", en=
dpoint_name);
> +               return ofnode_null();
> +       }
> +
> +       /* Resolve the phandle to the remote node */
> +       remote_node =3D ofnode_get_by_phandle(phandle_value);
> +       if (!ofnode_valid(remote_node)) {
> +               printf("Failed to resolve phandle %u\n", phandle_value);
> +               return ofnode_null();
> +       }
> +
> +       return remote_node;
> +}
> +
> +static enum usb_dr_mode get_connector_drmode(ofnode node)
> +{
> +       struct gpio_desc id;
> +       enum usb_dr_mode dr_mode =3D USB_DR_MODE_OTG;
> +       ofnode conn;
> +
> +       /* get remote endpoint */
> +       conn =3D get_remote_node_from_graph(node, -1, -1);
> +       /* get port endpoint */
> +       if (ofnode_valid(conn))
> +               conn =3D ofnode_get_parent(conn);
> +       /* get connector */
> +       if (ofnode_valid(conn))
> +               conn =3D ofnode_get_parent(conn);
> +       if (ofnode_valid(conn) &&
> +           ofnode_device_is_compatible(conn, "gpio-usb-b-connector") &&
> +           !gpio_request_by_name_nodev(conn, "id-gpios", 0, &id, GPIOD_I=
S_IN)) {
> +               if (dm_gpio_get_value(&id))
> +                       dr_mode =3D USB_DR_MODE_PERIPHERAL;
> +               else
> +                       dr_mode =3D USB_DR_MODE_HOST;
> +               gpio_free_list_nodev(&id, 1);
> +               pr_debug("%s got dr_mode from connector %s dr_mode=3D%s\n=
", __func__,
> +                        ofnode_get_name(node),
> +                        dr_mode =3D=3D USB_DR_MODE_HOST ? "host" : "peri=
pheral");
> +       }
> +
> +       return dr_mode;
> +}
> +
>  enum usb_dr_mode usb_get_dr_mode(ofnode node)
>  {
>         const char *dr_mode;
> @@ -35,7 +127,7 @@ enum usb_dr_mode usb_get_dr_mode(ofnode node)
>
>         for (i =3D 0; i < ARRAY_SIZE(usb_dr_modes); i++)
>                 if (!strcmp(dr_mode, usb_dr_modes[i]))
> -                       return i;
> +                       return (i =3D=3D USB_DR_MODE_OTG) ?  get_connecto=
r_drmode(node) : i;
>
>         return USB_DR_MODE_UNKNOWN;
>  }
> --
> 2.25.1
>

Hi Marek,

Have you had a chance to review this yet?

Best Regards,

Tim
