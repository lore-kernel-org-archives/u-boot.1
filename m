Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4625EE498B
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 18:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6855E86EEC;
	Fri, 18 Aug 2023 20:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=gmx.de header.i=goldsimon@gmx.de header.b="LGI4SfNJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 218D086EB9; Fri, 18 Aug 2023 20:21:25 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC03586EF2
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 20:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=goldsimon@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692382875; x=1692987675; i=goldsimon@gmx.de;
 bh=6Vn//zsYW0gN82ZYjiUckgylC8PCecz3afEbnejL9Ns=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=LGI4SfNJS1sLmAnyHl2747FOcTECMhf4j1z84do0rr1ogsFNQqKXX2caOMee9sjvB5fxe7U
 YPn6brNYfnobdipnH/Mmg6zC3RB+/okmHLPBva99bqO8Lowd9PVEDfh0w2DvAuYYL2tSxcr2Q
 i9hX+xpdZ2IWlWpQAiD8U3Bh08tdNdUzPQLZinKXFDwOlZuw0bHUg2uCDJX5ywPwt0d91/lCs
 KwklDCj4nOXPB832kfBy2PC09ztqHP1uZdnIWBEipZJ0BQ2ZhuXMOnwUwwlTWsc+Sh6CBwmht
 x/nyr5jY4ppwwuh4xPwN1BJRtG7MIx8cL+66Qy6Ip24xoniz0/8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([145.224.73.41]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1puiCf2RLP-00cMW8; Fri, 18
 Aug 2023 20:21:14 +0200
Date: Fri, 18 Aug 2023 20:21:11 +0200
From: Simon Goldschmidt <goldsimon@gmx.de>
To: Maxim Uvarov <maxim.uvarov@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com
Subject: Re: [PATCHv6 09/14] net/lwip: implement lwIP port to U-Boot
User-Agent: K-9 Mail for Android
In-Reply-To: <CAD8XO3ZKVk_Tkn5TR4Wf-nMAfpsBxbbBi5ArM8EDGN2QOMtbzA@mail.gmail.com>
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-10-maxim.uvarov@linaro.org> <ZNyQd/ACGjraW139@hades>
 <CAD8XO3ZKVk_Tkn5TR4Wf-nMAfpsBxbbBi5ArM8EDGN2QOMtbzA@mail.gmail.com>
Message-ID: <DE0D5706-DF10-455F-A359-97C50695B840@gmx.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:9raV2Aql3vbuTRg69t56wWnsvzOqmattLlCLxQxR9mQojRzTqLM
 wKK0spD3jQM0qXhQ0+CeqL3ezL+gguarsMh3w7nENzoEuRC6NiBxT4WXJKo6Ji1vKIc8EMJ
 HYYQk9kG3LputxkdUfAmkgLwqjEiRDdbyQFCy6P3eWwrShT/9wjxpYtkQfL9ffUuG8DJsAE
 y+HW3J3Vn01prkaYHo9vQ==
UI-OutboundReport: notjunk:1;M01:P0:QVCeN4tKGnM=;I5zEPl5YlCv8D9Fvp9NzATDQAZ5
 N4fWcWVpZBxE1z04fpAB5DphZroo5qM8OehC0vxmvauuXvxMWkGMxVc0tAzC4nx+DtQIp2dhY
 wp4lcEYfV5x+OgZ5ZBmC3VrmHOqpY4iHMwyu54ZCgcSFMm4UngYAow55liEHagXSom9K1T3y5
 Vl681TUDHUyAuBlAz2W+aYFXGogwmzUhQKoRozYd7MccqQKS6FKWgS7JtLqjQW831hLdZW//+
 qXimvQiFyM7hVYpIXx2H5d4xQJW8WJCF9j2Ik+9dm15f+VPTNmJ5nUXzgL1SoBQjhhodqNK+0
 YbL3bCEstLRtaWuMNzn1hfre85/sal42gAmDwN59uM9i0vVCk1pAy788XcTY5ZXD2DexBxQPQ
 WlGotrxAwv/lIQGW1+kFlqby9T1Nr89t/pq0rXWIiIftaHPRQO+tq2kavmD5yorgWcALddLAG
 C1io2A4AnyFMbsX8M7kK/UMI4N/GkZCCQIhousdBKHRgQ84Ux0XUJ5HbGTUDZka3Z1nnBJg7K
 rylH18P/vjapAdA4i75fLvCEufobSl+sbIjWh1vmkRGMWygSgxmHXKtkZeSvGWu8jEbmc0roy
 SXC2g/asBPvxzQpLP+KEqHtRuZ/3E71+MPHJ4hVx5CVzNvdeNzyrCLYMupgS4nwq1krrAcV/m
 XyByYIwPvhPkcGmTXtHBvRs3CLV0c4aLTAcRb4Op7N0copIRQkjRPFzfd1Jwe2hWCw+vxVLir
 Zrr40OzRh+ErWIEwqBklk8PswNmbgZavzzQ6vb9//KfIqmDCHMz59qcb7Zfxh9Bd7KBvBL9TN
 FmRT/7fP/ffgnDs8fz1WjHTXRejVhA00ERvADLjweURAnG/XaBSw4n3j+QJuuUd1/vqHKoJiT
 UydaMUjWt31g+Q1oDY/RcLjOsJmi3CNOJYwMckPHCJuETRE4hYoQsgoeYHCKUDefvRweSLeIF
 jx8QaxJkINud29iDnJOaKANj7co=
Content-Type: text/plain;
 charset=utf-8
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

Hi all,

could you please remove the lwip-devel list from CC? I am interested in th=
ese mails, but the more you dive into U-Boot specific things here, the less=
 people on our lwip list will be interested in this topic=2E

Thanks,
Simon


Am 18=2E August 2023 14:53:43 MESZ schrieb Maxim Uvarov <maxim=2Euvarov@li=
naro=2Eorg>:
>On Wed, 16 Aug 2023 at 15:01, Ilias Apalodimas <ilias=2Eapalodimas@linaro=
=2Eorg>
>wrote:
>
>> On Mon, Aug 14, 2023 at 07:32:48PM +0600, Maxim Uvarov wrote:
>> > Implement network lwIP interface connected to the U-boot=2E
>> > Keep original file structure widely used fro lwIP ports=2E
>> > (i=2Ee=2E port/if=2Ec port/sys-arch=2Ec)=2E
>>
>> What the patch does is obvious=2E  Try to describe *why* we need this
>>
>> >
>> > Signed-off-by: Maxim Uvarov <maxim=2Euvarov@linaro=2Eorg>
>> > ---
>> >  net/eth-uclass=2Ec                      |   8 +
>> >  net/lwip/port/if=2Ec                    | 260 ++++++++++++++++++++++=
++++
>> >  net/lwip/port/include/arch/cc=2Eh       |  39 ++++
>> >  net/lwip/port/include/arch/sys_arch=2Eh |  56 ++++++
>> >  net/lwip/port/include/limits=2Eh        |   0
>> >  net/lwip/port/sys-arch=2Ec              |  20 ++
>> >  6 files changed, 383 insertions(+)
>> >  create mode 100644 net/lwip/port/if=2Ec
>> >  create mode 100644 net/lwip/port/include/arch/cc=2Eh
>> >  create mode 100644 net/lwip/port/include/arch/sys_arch=2Eh
>> >  create mode 100644 net/lwip/port/include/limits=2Eh
>> >  create mode 100644 net/lwip/port/sys-arch=2Ec
>> >
>> > diff --git a/net/eth-uclass=2Ec b/net/eth-uclass=2Ec
>> > index c393600fab=2E=2E6625f6d8a5 100644
>> > --- a/net/eth-uclass=2Ec
>> > +++ b/net/eth-uclass=2Ec
>> > @@ -32,6 +32,7 @@ DECLARE_GLOBAL_DATA_PTR;
>> >  struct eth_device_priv {
>> >       enum eth_state_t state;
>> >       bool running;
>> > +     ulwip ulwip;
>> >  };
>> >
>> >  /**
>> > @@ -347,6 +348,13 @@ int eth_init(void)
>> >       return ret;
>> >  }
>> >
>> > +struct ulwip *eth_lwip_priv(struct udevice *current)
>> > +{
>> > +     struct eth_device_priv *priv =3D dev_get_uclass_priv(current);
>> > +
>> > +     return &priv->ulwip;
>> > +}
>> > +
>> >  void eth_halt(void)
>> >  {
>> >       struct udevice *current;
>> > diff --git a/net/lwip/port/if=2Ec b/net/lwip/port/if=2Ec
>> > new file mode 100644
>> > index 0000000000=2E=2E625a9c10bf
>> > --- /dev/null
>> > +++ b/net/lwip/port/if=2Ec
>> > @@ -0,0 +1,260 @@
>> > +// SPDX-License-Identifier: GPL-2=2E0
>> > +
>> > +/*
>> > + * (C) Copyright 2023 Linaro Ltd=2E <maxim=2Euvarov@linaro=2Eorg>
>> > + */
>> > +
>> > +#include <common=2Eh>
>> > +#include <command=2Eh>
>> > +#include <net/eth=2Eh>
>> > +#include "lwip/debug=2Eh"
>> > +#include "lwip/arch=2Eh"
>> > +#include "netif/etharp=2Eh"
>> > +#include "lwip/stats=2Eh"
>> > +#include "lwip/def=2Eh"
>> > +#include "lwip/mem=2Eh"
>> > +#include "lwip/pbuf=2Eh"
>> > +#include "lwip/sys=2Eh"
>> > +#include "lwip/netif=2Eh"
>> > +#include "lwip/ethip6=2Eh"
>> > +
>> > +#include "lwip/ip=2Eh"
>> > +
>> > +#define IFNAME0 'e'
>> > +#define IFNAME1 '0'
>>
>> Why is this needed and how was 'e0' chosen?
>> Dont we have a device name in the udevice struct?
>>
>>
>If we assume that we have lwip netif on top of an active U-Boot eth devic=
e,
>then it can be any name=2E
>
>  /** descriptive abbreviation */
>
>  char name[2];
>
>=2E/net/lwip/lwip-external/contrib/examples/ethernetif/ethernetif=2Ec:#de=
fine
>IFNAME0 'e'
>=2E/net/lwip/lwip-external/contrib/examples/ethernetif/ethernetif=2Ec:#de=
fine
>IFNAME1 'n'
>=2E/net/lwip/lwip-external/contrib/ports/unix/port/netif/tapif=2Ec:#defin=
e
>IFNAME0 't'
>=2E/net/lwip/lwip-external/contrib/ports/unix/port/netif/tapif=2Ec:#defin=
e
>IFNAME1 'p'
>=2E/net/lwip/lwip-external/contrib/ports/unix/port/netif/vdeif=2Ec:#defin=
e
>IFNAME0 'v'
>=2E/net/lwip/lwip-external/contrib/ports/unix/port/netif/vdeif=2Ec:#defin=
e
>IFNAME1 'd'
>=2E/net/lwip/lwip-external/contrib/ports/win32/pcapif=2Ec:#define IFNAME0
>                'e'
>=2E/net/lwip/lwip-external/contrib/ports/win32/pcapif=2Ec:#define IFNAME1
>                '0'
>=2E/net/lwip/lwip-external/src/netif/bridgeif=2Ec:#define IFNAME0 'b'
>=2E/net/lwip/lwip-external/src/netif/bridgeif=2Ec:#define IFNAME1 'r'
>=2E/net/lwip/port/if=2Ec:#define IFNAME0 'u'
>=2E/net/lwip/port/if=2Ec:#define IFNAME1 '0'
>
>
>
>> > +
>> > +static struct pbuf *low_level_input(struct netif *netif);
>> > +
>> > +int ulwip_enabled(void)
>> > +{
>> > +     struct ulwip *ulwip;
>> > +
>> > +     ulwip =3D eth_lwip_priv(eth_get_dev());
>>
>> eth_get_dev() can return NULL=2E  There are various locations of this c=
all
>> that needs fixing
>>
>
>
>ok=2E
>
>
>>
>> > +     return ulwip->init_done;
>> > +}
>> > +
>> > +
>> > +struct ulwip_if {
>> > +};
>>
>> Why the forward declaration?
>>
>> > +
>> > +#define LWIP_PORT_INIT_NETMASK(addr)  IP4_ADDR((addr), 255, 255, 255=
, 0)
>>
>> Why are we limiting the netmask to a class C network?
>>
>>
>that can be completely removed=2E
>
>
>> > +
>> > +void ulwip_poll(void)
>> > +{
>> > +     struct pbuf *p;
>> > +     int err;
>> > +     struct netif *netif =3D netif_get_by_index(1);
>>
>> First of all netif can be NULL=2E Apart from that always requesting ind=
ex 1
>> feels wrong=2E  We should do something similar to eth_get_dev() and get=
 the
>> *active* device correlation to an index
>>
>>
>I expect that it will be 1 lwip netif for all eth defs=2E And only active=
 eth
>dev works with lwip=2E
>This can be reconsidered but might be not a part of the initial patch set=
=2E
>
>
>> > +
>> > +     p =3D low_level_input(netif);
>> > +     if (!p) {
>> > +             log_err("error p =3D low_level_input =3D NULL\n");
>>
>> This looks like a debug message=2E
>> 'Network interface undefined' or something else, which is more readable=
=2E
>>
>> > +             return;
>> > +     }
>> > +
>> > +     /* ethernet_input always returns ERR_OK */
>> > +     err =3D ethernet_input(p, netif);
>> > +     if (err)
>> > +             log_err("ip4_input err %d\n", err);
>> > +
>> > +     return;
>> > +}
>> > +
>> > +static struct pbuf *low_level_input(struct netif *netif)
>> > +{
>> > +     struct pbuf *p, *q;
>> > +     u16_t len =3D net_rx_packet_len;
>> > +     uchar *data =3D net_rx_packet;
>> > +
>> > +     /* We allocate a pbuf chain of pbufs from the pool=2E */
>> > +     p =3D pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
>> > +     if (p) {
>>
>> if (!p) and reverse the logic
>>
>> > +             /* We iterate over the pbuf chain until we have read th=
e
>> entire
>> > +              * packet into the pbuf=2E
>> > +              */
>> > +             for (q =3D p; q !=3D NULL; q =3D q->next) {
>> > +                     /*
>> > +                      * Read enough bytes to fill this pbuf in the
>> chain=2E The
>> > +                      * available data in the pbuf is given by the
>> q->len
>> > +                      * variable=2E
>> > +                      * This does not necessarily have to be a memcp=
y,
>> you can also preallocate
>> > +                      * pbufs for a DMA-enabled MAC and after receiv=
ing
>> truncate it to the
>> > +                      * actually received size=2E In this case, ensu=
re
>> the tot_len member of the
>> > +                      * pbuf is the sum of the chained pbuf len memb=
ers=2E
>> > +                      */
>> > +                     MEMCPY(q->payload, data, q->len);
>> > +                     data +=3D q->len;
>> > +             }
>> > +             // acknowledge that packet has been read();
>> > +
>> > +             LINK_STATS_INC(link=2Erecv);
>> > +     } else {
>> > +             // drop packet();
>>
>> Is this a commented function that's missing?
>>
>>
>it's a comment=2E  That means lwip does now own this packet and actual dr=
op
>will be by U-Boot eth dev=2E
>I will remove this comment to not confuse anybody=2E
>
>
>> > +             LINK_STATS_INC(link=2Ememerr);
>> > +             LINK_STATS_INC(link=2Edrop);
>> > +     }
>> > +
>> > +     return p;
>> > +}
>> > +
>> > +static int ethernetif_input(struct pbuf *p, struct netif *netif)
>> > +{
>> > +     struct ethernetif *ethernetif;
>> > +
>> > +     ethernetif =3D netif->state;
>> > +
>> > +     /* move received packet into a new pbuf */
>> > +     p =3D low_level_input(netif);
>> > +
>> > +     /* if no packet could be read, silently ignore this */
>> > +     if (p) {
>> > +             /* pass all packets to ethernet_input, which decides wh=
at
>> packets it supports */
>> > +             if (netif->input(p, netif) !=3D ERR_OK) {
>> > +                     LWIP_DEBUGF(NETIF_DEBUG, ("%s: IP input error\n=
",
>> __func__));
>> > +                     pbuf_free(p);
>> > +                     p =3D NULL;
>> > +             }
>> > +     }
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static err_t low_level_output(struct netif *netif, struct pbuf *p)
>> > +{
>> > +     int err;
>> > +
>> > +     err =3D eth_send(p->payload, p->len);
>> > +     if (err) {
>> > +             log_err("eth_send error %d\n", err);
>> > +             return ERR_ABRT;
>> > +     }
>> > +     return ERR_OK;
>> > +}
>> > +
>> > +err_t ulwip_if_init(struct netif *netif)
>> > +{
>> > +     struct ulwip_if *uif;
>> > +     struct ulwip *ulwip;
>> > +
>> > +     uif =3D malloc(sizeof(struct ulwip_if));
>> > +     if (!uif) {
>> > +             log_err("uif: out of memory\n");
>> > +             return ERR_MEM;
>> > +     }
>> > +     netif->state =3D uif;
>> > +
>> > +     netif->name[0] =3D IFNAME0;
>> > +     netif->name[1] =3D IFNAME1;
>> > +
>> > +     netif->hwaddr_len =3D ETHARP_HWADDR_LEN;
>> > +     string_to_enetaddr(env_get("ethaddr"), netif->hwaddr);
>>
>> What if ethaddr is not set?
>>
>>
>U-Boot set's it automatically=2E I think it will generate random one=2E B=
ut
>even if somehow it will not set
>string_to_enetaddr()  function just will do nothing=2E
>
>
>
>> > +#if defined(CONFIG_LWIP_LIB_DEBUG)
>> > +     printf("              MAC: %02X:%02X:%02X:%02X:%02X:%02X\n",
>> > +            netif->hwaddr[0], netif->hwaddr[1], netif->hwaddr[2],
>> > +            netif->hwaddr[3], netif->hwaddr[4], netif->hwaddr[5]);
>> > +#endif
>> > +#if LWIP_IPV4
>> > +     netif->output =3D etharp_output;
>> > +#endif
>> > +#if LWIP_IPV6
>> > +     netif->output_ip6 =3D ethip6_output;
>> > +#endif
>> > +
>> > +     netif->linkoutput =3D low_level_output;
>> > +     netif->mtu =3D 1500;
>> > +     netif->flags =3D NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP |
>> NETIF_FLAG_LINK_UP;
>> > +
>> > +     ulwip =3D eth_lwip_priv(eth_get_dev());
>> > +     ulwip->init_done =3D 1;
>> > +     if (IS_ENABLED(CONFIG_LWIP_LIB_DEBUG)) {
>> > +             log_info("Initialized LWIP stack\n");
>> > +     }
>> > +
>> > +     return ERR_OK;
>> > +}
>> > +
>> > +int ulwip_init(void)
>> > +{
>> > +     ip4_addr_t ipaddr, netmask, gw;
>> > +     struct netif *unetif;
>> > +     struct ulwip *ulwip;
>> > +     int ret;
>> > +
>> > +     ret =3D eth_init();
>> > +     if (ret) {
>> > +             log_err("eth_init error %d\n", ret);
>> > +             return ERR_IF;
>> > +     }
>> > +
>> > +     ulwip =3D eth_lwip_priv(eth_get_dev());
>> > +     if (ulwip->init_done)
>> > +             return CMD_RET_SUCCESS;
>> > +
>> > +     unetif =3D malloc(sizeof(struct netif));
>> > +     if (!unetif)
>> > +             return ERR_MEM;
>> > +     memset(unetif, 0, sizeof(struct netif));
>> > +
>> > +     ip4_addr_set_zero(&gw);
>> > +     ip4_addr_set_zero(&ipaddr);
>> > +     ip4_addr_set_zero(&netmask);
>> > +
>> > +     ipaddr_aton(env_get("ipaddr"), &ipaddr);
>> > +     ipaddr_aton(env_get("ipaddr"), &netmask);
>>
>
>Here I missed "netmask" for &netmask=2E
>
>
>> > +
>> > +     LWIP_PORT_INIT_NETMASK(&netmask);
>> > +     if (IS_ENABLED(CONFIG_LWIP_LIB_DEBUG)) {
>> > +             printf("Starting lwIP, IP: %s\n", ip4addr_ntoa(&ipaddr)=
);
>> > +             printf("               GW: %s\n", ip4addr_ntoa(&gw));
>> > +             printf("             mask: %s\n", ip4addr_ntoa(&netmask=
));
>>
>> log_info()
>>
>> > +     }
>> > +
>> > +     if (!netif_add(unetif, &ipaddr, &netmask, &gw,
>> > +                    unetif, ulwip_if_init, ethernetif_input))
>> > +             printf("err: netif_add failed!\n");
>> > +
>> > +     netif_set_up(unetif);
>> > +     netif_set_link_up(unetif);
>> > +#if LWIP_IPV6
>> > +     netif_create_ip6_linklocal_address(unetif, 1);
>> > +     printf("             IPv6: %s\n",
>> ip6addr_ntoa(netif_ip6_addr(unetif, 0)));
>> > +#endif /* LWIP_IPV6 */
>> > +
>> > +     return CMD_RET_SUCCESS;
>> > +}
>> > +
>> > +/* placeholder, not used now */
>> > +void ulwip_destroy(void)
>> > +{
>> > +}
>> > diff --git a/net/lwip/port/include/arch/cc=2Eh
>> b/net/lwip/port/include/arch/cc=2Eh
>> > new file mode 100644
>> > index 0000000000=2E=2E55f7787ce1
>> > --- /dev/null
>> > +++ b/net/lwip/port/include/arch/cc=2Eh
>> > @@ -0,0 +1,39 @@
>> > +/* SPDX-License-Identifier: GPL-2=2E0 */
>> > +
>> > +/*
>> > + * (C) Copyright 2023 Linaro Ltd=2E <maxim=2Euvarov@linaro=2Eorg>
>> > + */
>> > +
>> > +#ifndef LWIP_ARCH_CC_H
>> > +#define LWIP_ARCH_CC_H
>> > +
>> > +#include <linux/types=2Eh>
>> > +#include <linux/kernel=2Eh>
>> > +//#include <stdlib=2Eh>    /* getenv, atoi */
>>
>> Please dont leave comments like that
>>
>> > +#include <vsprintf=2Eh>
>> > +
>> > +#define LWIP_ERRNO_INCLUDE <errno=2Eh>
>> > +
>> > +#define LWIP_ERRNO_STDINCLUDE        1
>> > +#define LWIP_NO_UNISTD_H 1
>> > +#define LWIP_TIMEVAL_PRIVATE 1
>>
>> Should those be defined in the LWIP config header instead?
>>
>> I would keep it here, like
>=2E/net/lwip/lwip-external/contrib/ports/unix/port/include/arch/cc=2Eh do=
es=2E
>Because LWIP config is more related to protocol features and settings and
>this header is about
>porr for a specific platform=2E
>
>
>
>> > +
>> > +extern unsigned int lwip_port_rand(void);
>>
>> This is like the forth time we go through this and it's a repeating
>> pattern=2E  Why do we need this extern? Can't we just include the prope=
r
>> header files?
>>
>> > +#define LWIP_RAND() (lwip_port_rand())
>>
>> This seems quite useless=2E Just use the function directly
>>
>>
>somehow I missed  this, this should be direct call:
>#include <rand=2Eh>
>#define LWIP_RAND() ((u32_t)rand())
>
>
>> > +
>> > +/* different handling for unit test, normally not needed */
>> > +#ifdef LWIP_NOASSERT_ON_ERROR
>> > +#define LWIP_ERROR(message, expression, handler) do { if
>> (!(expression)) { \
>> > +                                                 handler; }} while (=
0)
>> > +#endif
>> > +
>> > +#define LWIP_DONT_PROVIDE_BYTEORDER_FUNCTIONS
>> > +
>> > +#define LWIP_PLATFORM_ASSERT(x) do {printf("Assertion \"%s\" failed =
at
>> line %d in %s\n", \
>> > +                                 x, __LINE__, __FILE__); } while (0)
>> > +
>> > +#define atoi(str) (int)dectoul(str, NULL)
>> > +
>> > +#define LWIP_ERR_T int
>> > +
>> > +#endif /* LWIP_ARCH_CC_H */
>> > diff --git a/net/lwip/port/include/arch/sys_arch=2Eh
>> b/net/lwip/port/include/arch/sys_arch=2Eh
>> > new file mode 100644
>> > index 0000000000=2E=2E92a8560d49
>> > --- /dev/null
>> > +++ b/net/lwip/port/include/arch/sys_arch=2Eh
>> > @@ -0,0 +1,56 @@
>> > +/* SPDX-License-Identifier: GPL-2=2E0 */
>> > +
>> > +/*
>> > + * (C) Copyright 2023 Linaro Ltd=2E <maxim=2Euvarov@linaro=2Eorg>
>> > + */
>> > +
>> > +#ifndef LWIP_ARCH_SYS_ARCH_H
>> > +#define LWIP_ARCH_SYS_ARCH_H
>> > +
>> > +#include "lwip/opt=2Eh"
>> > +#include "lwip/arch=2Eh"
>> > +#include "lwip/err=2Eh"
>> > +
>> > +#define ERR_NEED_SCHED 123
>> > +
>> > +void sys_arch_msleep(u32_t delay_ms);
>> > +#define sys_msleep(ms) sys_arch_msleep(ms)
>>
>> Dont redefine random functions here=2E  U-Boot should already have all =
the
>> sleep functions you need
>>
>>
>dropeed=2E
>
>
>> > +
>> > +#if SYS_LIGHTWEIGHT_PROT
>>
>> Is this working? Can we define SYS_LIGHTWEIGHT_PROT?
>>
>> dropeed=2E
>
>
>> > +typedef u32_t sys_prot_t;
>> > +#endif /* SYS_LIGHTWEIGHT_PROT */
>> > +
>> > +#include <errno=2Eh>
>> > +
>> > +#define SYS_MBOX_NULL NULL
>> > +#define SYS_SEM_NULL  NULL
>> > +
>> > +typedef u32_t sys_prot_t;
>> > +
>> > +typedef struct sys_sem *sys_sem_t;
>> > +#define sys_sem_valid(sem) (((sem) !=3D NULL) && (*(sem) !=3D NULL))
>> > +#define sys_sem_set_invalid(sem) do { if ((sem) !=3D NULL) { *(sem) =
=3D
>> NULL; }} while (0)
>> > +
>> > +/* let sys=2Eh use binary semaphores for mutexes */
>> > +#define LWIP_COMPAT_MUTEX 1
>> > +#define LWIP_COMPAT_MUTEX_ALLOWED 1
>> > +
>> > +struct sys_mbox;
>> > +typedef struct sys_mbox *sys_mbox_t;
>> > +#define sys_mbox_valid(mbox) (((mbox) !=3D NULL) && (*(mbox) !=3D NU=
LL))
>> > +#define sys_mbox_set_invalid(mbox) do { if ((mbox) !=3D NULL) { *(mb=
ox) =3D
>> NULL; }} while (0)
>>
>> All these macros seem unnecessary=2E  Just assign types to NULL directl=
y etc
>>
>>
>ok=2E
>
>
>> > +
>> > +struct sys_thread;
>> > +typedef struct sys_thread *sys_thread_t;
>> > +
>> > +static inline u32_t sys_arch_sem_wait(sys_sem_t *sem, u32_t timeout)
>> > +{
>> > +     return 0;
>> > +};
>> > +
>> > +static inline err_t sys_mbox_trypost(sys_mbox_t *mbox, void *msg)
>> > +{
>> > +     return 0;
>> > +};
>>
>> Are those really needed?  Why do we just return 0?
>>
>> Not needed,  I think I planned to implement socket API later where it's
>needed=2E All these functions and macro can be defined to NULL with #defi=
ne
>NO_SYS  1 in the lwip configuration=2E
>This has to be an empty file=2E
>
>
>> > +
>> > +#endif /* LWIP_ARCH_SYS_ARCH_H */
>> > diff --git a/net/lwip/port/include/limits=2Eh
>> b/net/lwip/port/include/limits=2Eh
>> > new file mode 100644
>> > index 0000000000=2E=2Ee69de29bb2
>> > diff --git a/net/lwip/port/sys-arch=2Ec b/net/lwip/port/sys-arch=2Ec
>> > new file mode 100644
>> > index 0000000000=2E=2E609eeccf8c
>> > --- /dev/null
>> > +++ b/net/lwip/port/sys-arch=2Ec
>> > @@ -0,0 +1,20 @@
>> > +// SPDX-License-Identifier: GPL-2=2E0
>> > +
>> > +/*
>> > + * (C) Copyright 2023 Linaro Ltd=2E <maxim=2Euvarov@linaro=2Eorg>
>> > + */
>> > +
>> > +#include <common=2Eh>
>> > +#include <rand=2Eh>
>> > +#include "lwip/opt=2Eh"
>> > +
>> > +u32_t sys_now(void)
>> > +{
>> > +     return get_timer(0);
>> > +}
>> > +
>> > +u32_t lwip_port_rand(void)
>> > +{
>> > +     return (u32_t)rand();
>>
>> I dont see why we cant use the U-Boot defined ones directly
>>
>>
>changed=2E
>
>
>> > +}
>> > +
>> > --
>> > 2=2E30=2E2
>> >
>>
>> Thanks
>> /Ilias
>>
