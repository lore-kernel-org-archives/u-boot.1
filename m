Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47621D4920F
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 12:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E351893E3;
	Mon, 18 Nov 2024 13:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBOL4k1M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4499789434; Mon, 18 Nov 2024 13:36:12 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5628914D
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ea711a76a5so708331a91.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 04:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731933367; x=1732538167; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pndVb/O5C4w9jLMDMQgRGYuRL/H4xINELq5TKKBwSKQ=;
 b=RBOL4k1MnXHAo3bLKkVfzcgnYrtJXQjU0w4OhlJItspS4o1pmqKEhTYXK5cdBosH88
 FYawJ4Wk1vj7BlCnj1HvoozqFPzufTkPqtHVxQAJcGHYeHtsFrTbUc1oHJ3DeTTmsXON
 eQ4IFNBvwfnncaR/FxpxRIGyENclcoXmx22DFFr1uHWFMX4BJOjjrBC7iSr5Ft2WiHTO
 Ip2XAP9auJNMzwmtCL4wEUqKUFitiXTnr4w6r7buImuFMtsSo7iqIjuKjL2imwMnY0Em
 JsuHifwLmdlg9cusgGbJtufCFhPdYWaMp+l+1v1bb6+HkoPO8uqYnrM/1MzhoB99bP8a
 4YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933367; x=1732538167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pndVb/O5C4w9jLMDMQgRGYuRL/H4xINELq5TKKBwSKQ=;
 b=sjdD8tZcqSEIIgKtBHuMJxMYu7r8Ds+4Z+AtdLbUMLjglhSxoKdYSGudTG4v+sibUk
 WC2+i082TLRAL4HWPPRVfIIqOsIqUdfWZsPSoWGQAE4EHhVQu7UB35If3TjvBqBeb81H
 PlNwBRuAe5t0mJpCNFBb71Tl4AvaU4X0XzgK6TG5VJyPOE13EGGiqO2gJBQHkOBBohTj
 WtXd/o1D+TN2EchVdGesyRGahpLhEHVfDg1oLq/phqmo7QR3dJTGNgtedyUf0ZmeynKi
 +w18db8XBThR3OhaRaDEmeXUZIJBBJ2labqaLFimzcLEwe4OVj6Poy8JBNxINiFse9V2
 JoGQ==
X-Gm-Message-State: AOJu0Yz7WqO3fG69BEZoihnscILYNl6rYsUn2Veni/M6ROEEMu167z2Y
 wk/Nr6ElIlUI+TMyQYg4sVLkPDS3uS/HDiO1rrrNP+UffBpC5Xm5rcQbF6xSsUhuoEsyItLuEqy
 ld9pGkRUtkaspIg1AWjBB9jm7ASU=
X-Google-Smtp-Source: AGHT+IFRHvDs3+srl4yxjWuk+UIrQoiIu44MmolIQHdv2eMkxDGfcDm/DuPFGBx1j0/vpuSKE7ZkiG68HkyibwD4zno=
X-Received: by 2002:a17:90b:4c0b:b0:2ea:6d98:b499 with SMTP id
 98e67ed59e1d1-2ea6d98b76amr3812496a91.36.1731933367268; Mon, 18 Nov 2024
 04:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-8-adrianox@gmail.com>
 <CAC_iWjJ19963N20Y52hVpQ8=-n8ifziyTcXdCNFkKR5+9nm3Ug@mail.gmail.com>
In-Reply-To: <CAC_iWjJ19963N20Y52hVpQ8=-n8ifziyTcXdCNFkKR5+9nm3Ug@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Mon, 18 Nov 2024 09:35:55 -0300
Message-ID: <CAMGU2hWt3YhijXdaKXmEE21rgQBwJ-X6taTy=1MY3TjEAcPLZg@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] efi_loader: efi_net: add efi_net_set_addr,
 efi_net_get_addr
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

El lun, 18 nov 2024 a las 9:22, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> Hi Adriano,
>
> On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> > Add the functions efi_net_set_addr and  efi_net_get_addr to set
> > and get the ip address from efi code in a network agnostic way.
> > This could also go in net_common, or be compiled conditionally
> > for each network stack.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >
> > (no changes since v2)
> >
> >  include/efi_loader.h     |  16 +++++++
> >  lib/efi_loader/efi_net.c | 100 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 116 insertions(+)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 39809eac1b..612bc42816 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -125,6 +125,22 @@ static inline void efi_set_bootdev(const char *dev=
,
> const char *devnr,
> >                                    size_t buffer_size) { }
> >  #endif
> >
> > +#if CONFIG_IS_ENABLED(NETDEVICES) && CONFIG_IS_ENABLED(EFI_LOADER)
> > +void efi_net_get_addr(struct efi_ipv4_address *ip,
> > +                     struct efi_ipv4_address *mask,
> > +                     struct efi_ipv4_address *gw);
> > +void efi_net_set_addr(struct efi_ipv4_address *ip,
> > +                     struct efi_ipv4_address *mask,
> > +                     struct efi_ipv4_address *gw);
> > +#else
> > +static inline void efi_net_get_addr(struct efi_ipv4_address *ip,
> > +                                    struct efi_ipv4_address *mask,
> > +                                    struct efi_ipv4_address *gw) { }
> > +static inline void efi_net_set_addr(struct efi_ipv4_address *ip,
> > +                                    struct efi_ipv4_address *mask,
> > +                                    struct efi_ipv4_address *gw) { }
> > +#endif
> > +
> >  /* Maximum number of configuration tables */
> >  #define EFI_MAX_CONFIGURATION_TABLES 16
> >
> > diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> > index 7cd536705f..dd84b3f18d 100644
> > --- a/lib/efi_loader/efi_net.c
> > +++ b/lib/efi_loader/efi_net.c
> > @@ -17,6 +17,7 @@
> >
> >  #include <efi_loader.h>
> >  #include <malloc.h>
> > +#include <vsprintf.h>
> >  #include <net.h>
> >
> >  static const efi_guid_t efi_net_guid =3D EFI_SIMPLE_NETWORK_PROTOCOL_G=
UID;
> > @@ -997,3 +998,102 @@ out_of_resources:
> >         printf("ERROR: Out of memory\n");
> >         return EFI_OUT_OF_RESOURCES;
> >  }
> > +
> > +void efi_net_get_addr(struct efi_ipv4_address *ip,
> > +                     struct efi_ipv4_address *mask,
> > +                     struct efi_ipv4_address *gw)
> > +{
> > +#ifdef CONFIG_NET_LWIP
> > +       char *ipstr =3D "ipaddr\0\0";
> > +       char *maskstr =3D "netmask\0\0";
> > +       char *gwstr =3D "gatewayip\0\0";
>
> You generally can't define strings like that and expect to change
> them. The compiler places the string literal somewhere in memory which
> is immutable.
> If you want to keep the code as is, you need to define these as ipstr[].
>
> > +       int idx;
> > +       struct in_addr tmp;
> > +       char *env;
> > +
> > +       idx =3D dev_seq(eth_get_dev());
> > +
> > +       if (idx < 0 || idx > 99) {
> > +               log_err("unexpected idx %d\n", idx);
> > +               return;
> > +       }
> > +
> > +       if (idx) {
>
> Is 0 not legal here?
> And why is the behavior differnt with and without LWIP?
>

This is how the lwip code deals with the environment variables for the IP
address, see
get_udev_ipv4_info in
https://github.com/u-boot/u-boot/blob/a38390284ad4261723d3a2411ba988828e994=
535/net/lwip/net-lwip.c#L91
In here I am trying to be consistent with that. In legacy the network stack
just uses the variables net_ip and net_netmask.


> > +               sprintf(ipstr, "ipaddr%d", idx);
> > +               sprintf(maskstr, "netmask%d", idx);
> > +               sprintf(gwstr, "gatewayip%d", idx);
> > +       }
> > +
> > +       env =3D env_get(ipstr);
> > +       if (env && ip) {
> > +               tmp =3D string_to_ip(env);
> > +               memcpy((void *)ip, (void *)&tmp, 4);
> > +       }
> > +
> > +       env =3D env_get(maskstr);
> > +       if (env && mask) {
> > +               tmp =3D string_to_ip(env);
> > +               memcpy((void *)mask, (void *)&tmp, 4);
> > +       }
> > +       env =3D env_get(gwstr);
> > +       if (env && gw) {
> > +               tmp =3D string_to_ip(env);
> > +               memcpy((void *)gw, (void *)&tmp, 4);
> > +       }
> > +#else
> > +       if (ip)
> > +               memcpy((void *)ip, (void *)&net_ip, 4);
> > +       if (mask)
> > +               memcpy((void *)mask, (void *)&net_netmask, 4);
>
> Get rid of casts etc.
>
> > +#endif
> > +}
> > +
> > +void efi_net_set_addr(struct efi_ipv4_address *ip,
> > +                     struct efi_ipv4_address *mask,
> > +                     struct efi_ipv4_address *gw)
> > +{
> > +#ifdef CONFIG_NET_LWIP
> > +       char *ipstr =3D "ipaddr\0\0";
> > +       char *maskstr =3D "netmask\0\0";
> > +       char *gwstr =3D "gatewayip\0\0";
> > +       int idx;
> > +       struct in_addr *addr;
> > +       char tmp[46];
> > +
> > +       idx =3D dev_seq(eth_get_dev());
> > +
> > +       if (idx < 0 || idx > 99) {
> > +               log_err("unexpected idx %d\n", idx);
> > +               return;
> > +       }
> > +
> > +       if (idx) {
> > +               sprintf(ipstr, "ipaddr%d", idx);
> > +               sprintf(maskstr, "netmask%d", idx);
> > +               sprintf(gwstr, "gatewayip%d", idx);
> > +       }
> > +
> > +       if (ip) {
> > +               addr =3D (struct in_addr *)ip;
> > +               ip_to_string(*addr, tmp);
> > +               env_set(ipstr, tmp);
> > +       }
> > +
> > +       if (mask) {
> > +               addr =3D (struct in_addr *)mask;
> > +               ip_to_string(*addr, tmp);
> > +               env_set(maskstr, tmp);
> > +       }
> > +
> > +       if (gw) {
> > +               addr =3D (struct in_addr *)gw;
> > +               ip_to_string(*addr, tmp);
> > +               env_set(gwstr, tmp);
> > +       }
> > +#else
> > +       if (ip)
> > +               memcpy((void *)&net_ip, (void *)ip, 4);
> > +       if (mask)
> > +               memcpy((void *)&net_netmask, (void *)mask, 4);
> > +#endif
> > +}
> > --
> > 2.43.0
> >
>
> Cheers
> /Ilias
>

Thanks,
Adriano
