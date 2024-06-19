Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045C7C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 10:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B92C8840C;
	Wed, 19 Jun 2024 12:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="moFU5Grp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D678840C; Wed, 19 Jun 2024 12:08:28 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCED883E7
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 12:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f862f7c7edso43415485ad.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718791704; x=1719396504; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r8At44juuikwdjpqSmaVoKn16reWNwcHZVluQeY9ryI=;
 b=moFU5Grp/LLvKdOGb4a8KKxUOasJYbllQyG15XwKoIuh9wjN3wOSLbs/4ZhpWQss5s
 Y3QPHTSTo7gDP5QfagyT8SlgRdMkpLfC/Cp1/fEG6c/UnwHZVw0ggpwRqK7fLTqO0lWc
 i4lTqdb7WYgwInfuPp/PQMzM7dCf5FkzQdCpSl6clDoOnwq1Rwar++wLEHM8Vs5bJDRr
 6AbaJ6R4faUik3Ir5rAQkpANAqSIge3eiyiPui9wRFLPLXbPZSlQkREeJB6MV7rULar8
 gUwyOXiSdIeOBX2kcD4wnyacDCXGZwXZR2RlcRS/Y0qNYkMQUaPsvXvl+Nn++RqpQt37
 Se8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718791704; x=1719396504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r8At44juuikwdjpqSmaVoKn16reWNwcHZVluQeY9ryI=;
 b=AdQwfv3EVC0xWcWWF+e5f3UZivpCvIBPbCeTqyKxFplgb2RUPSQw9hN37qJlCIUEq/
 TI9zkvBMRj3nvK6bmdi4b25laTiXMbzPi6n9FtpHlagM7SROyO4WbrnC9s5nL15TYMXO
 r88ba5i4pjOwv+TJeWMje2cm5rjQVvRr5OKMZXyy7qEgvAtsvxTyRyj+VysP0gKiaZiK
 bJv80TeGnDFIIzcibJJUkWH/MKySFKvCCoKOGLmnuIyXki6AxEmSqCyRm/VttSjUa+ml
 yDDsxj5ORSMOyP2WH6eP2sSbGFbsbc48wFe06fpaGQlWUO9AmOqbw6NNVCchddbUBmpj
 jusw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBEGxq5VxC4fihcupPKTVOu+OgyI3XT+lsHd8EwhvVuxAZwUPZ+qS9zHy6YiU+kx6ab+VQTNfzkcwVAM6YbaTXNml7/g==
X-Gm-Message-State: AOJu0YwL2A0ek21ZR0FiVBPSoSDbOwOWgIX1OF0MpdewZ7mMTLm8hyo7
 zy9rCAnsyNvhItpAwIarg620SG7GMt7kBGAuI0OXKh1dR9Rynua8NvLFmH20v9KwtWYbkJqndg/
 cNFUqTQ2GTl5Mezi8vZ9xii57Tpoo4LPFmMq9hw==
X-Google-Smtp-Source: AGHT+IEinu5rTky3qQhLuE4kf+h0Wj44olDcbpXfY7oL2GkR4Ru8ntilKPooCp6n16D4pEsLzTQYUgeV7S5wQS+GLkM=
X-Received: by 2002:a17:902:da86:b0:1f3:cb7:b0ef with SMTP id
 d9443c01a7336-1f9aa450652mr24632695ad.51.1718791704358; Wed, 19 Jun 2024
 03:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <1455663bf6d4f8537d3919b755ef5148b65975c5.1718638104.git.jerome.forissier@linaro.org>
 <4886f096-935a-4a61-b16c-245df8b30bd8@gmx.de>
 <a2fd13c5-f918-46d1-98db-5ff00ac06f30@linaro.org>
In-Reply-To: <a2fd13c5-f918-46d1-98db-5ff00ac06f30@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Jun 2024 13:07:48 +0300
Message-ID: <CAC_iWj+Dcgfb=YAChBhvmrRBHpkzdzRFdhN55yVSHXZYRkFtWQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] net-lwip: add DHCP support and dhcp commmand
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Artur Rojek <artur@conclusive.pl>, 
 Yang Xiwen <forbidden405@outlook.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Boon Khai Ng <boon.khai.ng@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

[...]


> >> +
> >> +static struct netif *new_netif(bool with_ip)
> >> +{
> >> +    unsigned char enetaddr[ARP_HLEN];
> >> +    char hwstr[MAC_ADDR_STRLEN];
> >> +    ip4_addr_t ip, mask, gw;
> >> +    struct udevice *dev;
> >> +    struct netif *netif;
> >
> > This does not fit into the driver model.
> >
> > In the EFI subsystem we want to implement network protocols like the
> > EFI_DHCP4_PROTOCOL.
> >
> > Please, carve out functions to which we can pass a UCLASS_ETH udevice to
> > execute DHCP.
>
> v6 will have:
>
> static struct netif *new_netif(struct udevice *udev, bool with_ip)
> struct netif *net_lwip_new_netif(struct udevice *udev)
> struct netif *net_lwip_new_netif_noip(struct udevice *udev)

Heinrich, any other EFI protocols you have in mind that would require
similar tweaking? e.g the EFI_TCP4 and HTTP protocols?


>
> static int dhcp_loop(struct udevice *udev)
>
> >
> >> +    int ret;
> >> +    static bool first_call = true;
> >> +
> >> +    eth_init_rings();
> >> +
> >> +    if (first_call) {
> >> +        if (eth_init()) {
> >> +            printf("eth_init() error\n");
> >> +            return NULL;
> >> +        }
> >> +        first_call = false;
> >> +    }
> >> +
> >> +    netif_remove(net_lwip_get_netif());
> >> +
> >> +    eth_set_current();
> >> +
> >> +    dev = eth_get_dev();
> >> +    if (!dev)
> >> +        return NULL;
> >> +
> >> +    ip4_addr_set_zero(&ip);
> >> +    ip4_addr_set_zero(&mask);
> >> +    ip4_addr_set_zero(&gw);
> >> +
> >> +    if (with_ip)
> >> +        if (get_udev_ipv4_info(dev, &ip, &mask, &gw) < 0)
> >> +            return NULL;
> >> +
> >> +    eth_env_get_enetaddr_by_index("eth", dev_seq(dev), enetaddr);
> >> +    ret = snprintf(hwstr, MAC_ADDR_STRLEN, "%pM",  enetaddr);
> >> +    if (ret < 0 || ret >= MAC_ADDR_STRLEN)
> >> +        return NULL;
> >> +
> >> +    netif = calloc(1, sizeof(struct netif));
> >> +    if (!netif)
> >> +        return NULL;
> >> +
> >> +    netif->name[0] = 'e';
> >> +    netif->name[1] = 't';
> >> +
> >> +    string_to_enetaddr(hwstr, netif->hwaddr);
> >> +    netif->hwaddr_len = ETHARP_HWADDR_LEN;
> >> +
> >> +    if (!netif_add(netif, &ip, &mask, &gw, netif, net_lwip_if_init,
> >> +               netif_input)) {
> >> +        printf("error: netif_add() failed\n");
> >> +        free(netif);
> >> +        return NULL;
> >> +    }
> >> +
> >> +    netif_set_up(netif);
> >> +    netif_set_link_up(netif);
> >> +    /* Routing: use this interface to reach the default gateway */
> >> +    netif_set_default(netif);
> >> +
> >> +    return netif;
> >> +}
> >> +
> >> +/* Configure lwIP to use the currently active network device */
> >> +struct netif *net_lwip_new_netif()
> >> +{
> >> +    return new_netif(true);
> >> +}
> >> +
> >> +struct netif *net_lwip_new_netif_noip()
> >> +{
> >> +
> >> +    return new_netif(false);
> >> +}
> >> +
> >> +void net_lwip_remove_netif(struct netif *netif)
> >> +{
> >> +    netif_remove(netif);
> >> +    free(netif);
> >> +}
> >> +
> >> +int net_init(void)
> >> +{
> >> +    net_lwip_new_netif();
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static struct pbuf *alloc_pbuf_and_copy(uchar *data, int len)
> >> +{
> >> +        struct pbuf *p, *q;
> >> +
> >> +        /* We allocate a pbuf chain of pbufs from the pool. */
> >> +        p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
> >> +        if (!p) {
> >> +                LINK_STATS_INC(link.memerr);
> >> +                LINK_STATS_INC(link.drop);
> >> +                return NULL;
> >> +        }
> >> +
> >> +        for (q = p; q != NULL; q = q->next) {
> >> +                memcpy(q->payload, data, q->len);
> >> +                data += q->len;
> >> +        }
> >> +
> >> +        LINK_STATS_INC(link.recv);
> >> +
> >> +        return p;
> >> +}
> >> +
> >> +void net_process_received_packet(uchar *in_packet, int len)
> >
> > Library functions should take a udevice as an argument. Please, do not
> > use the concept of "active device" in these library functions.
>
> OK, I have unified the naming in v6 and all functions will take a udevice:
>
> static int dhcp_loop(struct udevice *udev)
> static int dns_loop(struct udevice *udev, const char *name, const char *var)
> static int ping_loop(struct udevice *udev, const ip_addr_t* addr)
> static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>                      ip_addr_t srvip)
> static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>
> >
> > The command line interface may implement such a concept for backwards
> > compatibility.
>
> Sure.
>
> Thanks,
> --
> Jerome
>
> >
> > Best regards
> >
> > Heinrich
> >
> >> +{
> >> +    struct netif *netif;
> >> +    struct pbuf *pbuf;
> >> +
> >> +    if (len < ETHER_HDR_SIZE)
> >> +        return;
> >> +
> >> +#if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
> >> +    if (push_packet) {
> >> +        (*push_packet)(in_packet, len);
> >> +        return;
> >> +    }
> >> +#endif
> >> +
> >> +    netif = net_lwip_get_netif();
> >> +    if (!netif)
> >> +        return;
> >> +
> >> +    pbuf = alloc_pbuf_and_copy(in_packet, len);
> >> +    if (!pbuf)
> >> +        return;
> >> +
> >> +    netif->input(pbuf, netif);
> >> +}
> >> +
> >> +u32_t sys_now(void)
> >> +{
> >> +    return get_timer(0);
> >> +}
> >> diff --git a/net-lwip/tftp.c b/net-lwip/tftp.c
> >> new file mode 100644
> >> index 00000000000..1fa246f55d9
> >> --- /dev/null
> >> +++ b/net-lwip/tftp.c
> >> @@ -0,0 +1,11 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/* Copyright (C) 2024 Linaro Ltd. */
> >> +
> >> +#include <command.h>
> >> +#include <net-lwip.h>
> >> +
> >> +int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >> +{
> >> +    /* Not implemented */
> >> +    return CMD_RET_FAILURE;
> >> +}
> >
