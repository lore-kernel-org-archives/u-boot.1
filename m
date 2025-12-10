Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE68D3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 10:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2355983655;
	Wed, 10 Dec 2025 11:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nLpGow2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5231B8367F; Wed, 10 Dec 2025 11:31:03 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C8D483642
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 11:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b725ead5800so883110466b.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 02:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765362660; x=1765967460; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wOwxgr1U3+pImw4HYxnHpHWFsQA7SLb51tBage3eMb0=;
 b=nLpGow2Rf3CjlyH5VL1DgP4uK63YbwefFnH38UBJ4McyVHxTw6Zl9ulgvXbo3i4TTx
 ChraIc9OMigahRTdHWTZpxrMaIVfG6IFMxTKmx3NclnoLKqZfnx2aBiuBltEozp+HAn6
 uMh9OYgs4k0xd0+yrFPiNb/WVfgqnygg1jDvSY6f13ZryWAHYk0lYqFWSoK0+3tCqBQC
 r1PYQyTCXed+UI56h2T10MwQmGGig1vofiilnQ/ZTCJR6ws0NoMF4L3ER5GN5QoFiLsf
 Lai1nqePeZ55Bmvc8jl2wcHMelE/BiXWQNFTn7Hw4RZZT+4Ukn7YnSUX5pNUlI/KM50H
 mdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765362660; x=1765967460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wOwxgr1U3+pImw4HYxnHpHWFsQA7SLb51tBage3eMb0=;
 b=l9wTfiqYUhpdixMPy8LkOLOe8b0X9ih6v7w/Ufv8+1YgEceyiJNksIfUCS/IllHx9k
 rzP7r598lGyEZr/H2DK33gEtlJw/jSLAbJb8QcvyNczBktmDhvjozR1jIB08bbooI8ml
 JfKrKJbO7Ma6JiARN3IEA2DYWNPQ+rGjZUA1sGa0vivhyEYYWEi74njPRwxBx9LkUGK9
 rVVZBo/unIQ0QpO3RwOdaH9d+QpPJxfG1176AClZL1uolApEzVNnaNb35f87qOf8nLyc
 xJ3V2rSSDUjTGG4J+LWQWlW5P7vsQeU4/e+sB2+QYx7/bYx/t8C6PSF16ls4zlZ45Zfa
 Lt6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB+0YtaPMOZ+r9eOdDBIfFlizgLsFu2qB+sY9jZjssURbwJOfOZlNVV2XPo1HV5kmISdFEqMw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz19hPVYLx956F7likjuayxPdXz4niHjGSUm56A/2eSSbwyjDCg
 psHZftcSk0xtT9Mk+nuqESLyZiiMA96VVAPU+/FdwDcBFyZJ9ylLCrvSblpkOWgInv8=
X-Gm-Gg: ASbGnctRgu+8ddm561lkD0fnfH11gxMKej5y+Ua49GIkFJhDUooPHs7RkOeDax9pX4X
 JcitYkBrZXmXeaLnzMhtVCThs1bws/UOdq79wkFEAsXL7qZdh3zKp0JVm+x3sQC6B+d9Vb70lBe
 IzSzJ9IuOOGwLXtt/KItfBBHc9iHBEIWc332v+ozglqRRXlgY1F2N1PnDyG2SkarOh6Jqj42GLr
 NEbD1/7SLw0cxQwQ6WeI9KYcdjrdNke8QKBZ0LDxLj8aryYc+RouJPRCQfU0+RlQTeNbTGFx9nU
 q8I5YTL6ctSMdUtqI9zk0bZYrTXhFn9KArhSOWAe7A3hbeq3oTm8HR3Vpfdew9haO0xLgZVOjVG
 2/b+E5HTMuICCXdiTIGZl2cMM4+HrFFqY4WbeI4wAoCt1rDe3NQB0YDoofR7nM+5W0Ep4eCecSg
 S6s8IpQvMx30iAzEZ/Ng9a6lF4XDifcgoYYNaIGPG++9SnL/8ufptqhCVhKmULuFnFkM/MzbDZ1
 rgS
X-Google-Smtp-Source: AGHT+IGK1N50+LJunLSIneQ4JRmGGsIwm9JbiumA/MwFpyPNMCVCJVzVkcUbSNPyBFq+gOAzQx5zgw==
X-Received: by 2002:a17:907:2d8a:b0:b76:3399:457b with SMTP id
 a640c23a62f3a-b7ce84d62a0mr196129566b.37.1765362659643; 
 Wed, 10 Dec 2025 02:30:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:bab0:64cb:d41d:cc7e?
 ([2a01:e0a:3cb:7bb0:bab0:64cb:d41d:cc7e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf71fsm17920231a12.14.2025.12.10.02.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 02:30:59 -0800 (PST)
Message-ID: <fb7060d2-0d34-4517-8679-aa9b4ea7e52c@linaro.org>
Date: Wed, 10 Dec 2025 11:30:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] net: lwip: nfs: Port the NFS code to work with LWIP
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
 <20251208-lwip_nfs-v1-5-1f5d31e15d00@linaro.org>
 <99a2c68e-dee6-4d0b-8068-ba318a3db03a@linaro.org>
 <976f38ab-fb39-4db0-a37d-31066ea941f6@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <976f38ab-fb39-4db0-a37d-31066ea941f6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 12/9/25 17:39, Andrew Goodbody wrote:
> On 09/12/2025 15:02, Jerome Forissier wrote:
>> Hi Andrew,
>>
>> On 12/8/25 13:52, Andrew Goodbody wrote:
>>> After the preparatory patches moved most of the NFS code into common
>>> files we now add the code to enable NFS support with LWIP.
>>
>> s/LWIP/lwIP/ and same in the commit subject ('lwip:' is OK as a subsystem prefix though)
> 
> OK.
> 
>>>
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>   cmd/Kconfig        |  28 +++---
>>>   cmd/lwip/Makefile  |   1 +
>>>   cmd/lwip/nfs.c     |  11 +++
>>>   include/net-lwip.h |   1 +
>>>   net/lwip/Makefile  |   1 +
>>>   net/lwip/nfs.c     | 282 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   net/nfs-common.c   |   4 +-
>>>   7 files changed, 313 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>> index 8e3efff2bee69e4be80fe8e87eb7815dd3ff8ca9..de180fd7fab62329f8b63dfed780b32e0e908e91 100644
>>> --- a/cmd/Kconfig
>>> +++ b/cmd/Kconfig
>>> @@ -2110,20 +2110,6 @@ config CMD_RARP
>>>       help
>>>         Boot image via network using RARP/TFTP protocol
>>>   -config CMD_NFS
>>> -    bool "nfs"
>>> -    help
>>> -      Boot image via network using NFS protocol.
>>> -
>>> -config NFS_TIMEOUT
>>> -    int "Timeout in milliseconds for NFS mounts"
>>> -    depends on CMD_NFS
>>> -    default 2000
>>> -    help
>>> -      Timeout in milliseconds used in NFS protocol.  If you encounter
>>> -      "ERROR: Cannot umount" in nfs command, try longer timeout such as
>>> -      10000.
>>> -
>>>   config SYS_DISABLE_AUTOLOAD
>>>       bool "Disable automatically loading files over the network"
>>>       depends on CMD_BOOTP || CMD_DHCP || CMD_NFS || CMD_RARP
>>> @@ -2218,6 +2204,20 @@ config CMD_MDIO
>>>         The MDIO interface is orthogonal to the MII interface and extends
>>>         it by adding access to more registers through indirect addressing.
>>>   +config CMD_NFS
>>> +    bool "nfs"
>>> +    help
>>> +      Boot image via network using NFS protocol.
>>> +
>>> +config NFS_TIMEOUT
>>> +    int "Timeout in milliseconds for NFS mounts"
>>> +    depends on CMD_NFS
>>> +    default 2000
>>> +    help
>>> +      Timeout in milliseconds used in NFS protocol.  If you encounter
>>> +      "ERROR: Cannot umount" in nfs command, try longer timeout such as
>>> +      10000.
>>> +
>>>   config CMD_PING
>>>       bool "ping"
>>>       select PROT_RAW_LWIP if NET_LWIP
>>> diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
>>> index a7f8976af3fb7cb2d41344f9f22a5d820c5ebc7e..90df1f5511cce4496abb16a495720df4e8cea822 100644
>>> --- a/cmd/lwip/Makefile
>>> +++ b/cmd/lwip/Makefile
>>> @@ -1,5 +1,6 @@
>>>   obj-$(CONFIG_CMD_DHCP) += dhcp.o
>>>   obj-$(CONFIG_CMD_DNS) += dns.o
>>> +obj-$(CONFIG_CMD_NFS) += nfs.o
>>>   obj-$(CONFIG_CMD_PING) += ping.o
>>>   obj-$(CONFIG_CMD_SNTP) += sntp.o
>>>   obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
>>> diff --git a/cmd/lwip/nfs.c b/cmd/lwip/nfs.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..f22db582fdb9ff7c978da41d35046bf834aaf54e
>>> --- /dev/null
>>> +++ b/cmd/lwip/nfs.c
>>> @@ -0,0 +1,11 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/* Copyright (C) 2025 Linaro Ltd. */
>>> +
>>> +#include <command.h>
>>> +#include <net.h>
>>> +
>>> +U_BOOT_CMD(nfs,    3,    1,    do_nfs,
>>> +       "boot image via network using NFS protocol",
>>> +       "[loadAddress] [[hostIPaddr:]bootfilename]"
>>> +      );
>>> +
>>> diff --git a/include/net-lwip.h b/include/net-lwip.h
>>> index c910def5719ea49c1796c11354e1a3d63e01e023..20cb0992cce1f9dbca7eaa114b4939028158d9b5 100644
>>> --- a/include/net-lwip.h
>>> +++ b/include/net-lwip.h
>>> @@ -51,6 +51,7 @@ int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
>>>   bool wget_validate_uri(char *uri);
>>>     int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>> +int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
>>>   int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
>>>     #endif /* __NET_LWIP_H__ */
>>> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
>>> index 1b48ae4d50885863e82989f77416e5c35545502a..5291cbb2a1c31a970c44c6e182dc6d3a90d489cf 100644
>>> --- a/net/lwip/Makefile
>>> +++ b/net/lwip/Makefile
>>> @@ -4,6 +4,7 @@ obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
>>>   obj-$(CONFIG_CMD_DHCP) += dhcp.o
>>>   obj-$(CONFIG_DNS) += dns.o
>>>   obj-$(CONFIG_LWIP_ICMP_SHOW_UNREACH) += icmp_unreach.o
>>> +obj-$(CONFIG_CMD_NFS) += nfs.o
>>>   obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
>>>   obj-$(CONFIG_WGET) += wget.o
>>>   diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..5a2275aec97cd7e36ca3db9c3ee138878718f3b9
>>> --- /dev/null
>>> +++ b/net/lwip/nfs.c
>>> @@ -0,0 +1,282 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/* Copyright (C) 2025 Linaro Ltd. */
>>> +
>>> +#include <console.h>
>>> +#include <display_options.h>
>>> +#include <env.h>
>>> +#include <image.h>
>>> +#include <linux/kconfig.h>
>>> +#include <lwip/timeouts.h>
>>> +#include <lwip/udp.h>
>>> +#include <net.h>
>>> +#include "../nfs-common.h"
>>> +#include <time.h>
>>> +
>>> +static ulong timer_start;
>>> +
>>> +static struct nfs_ctx {
>>> +    ip_addr_t nfs_server;
>>> +    struct udp_pcb *pcb;
>>> +} sess_ctx;
>>
>> I'd much prefer if we could avoid global variables, especially since
>> this NETLOOP_* state is imported from the legacy network stack. See
>> how tftp_loop() declares a tftp_ctx on the stack. We could have a
>> nfs_ctx for example.
> 
> I did consider that initially. Unfortunately it will much reduce the amount of code that can be shared. The nfs_ctx needs to be passed around which will change all the function signatures. The tftp code benefits from being able to use the lwIP implementation instead of attempting to reuse the legacy net code.
> Please confirm if you want me to go ahead with this change given that it is likely to mean very little, if any, code sharing.

Well, I took a closer look and indeed it's not a very good option. We
probably don't want to touch the legacy code too much.
So I'm OK with keeping the global variables.

Thanks,
-- 
Jerome

> 
>> With that I suppose "net: move net_state to net-common" could be
>> removed from the series.
> 
> It could, yes.
> 
>>> +
>>> +/**************************************************************************
>>> + * RPC_LOOKUP - Lookup RPC Port numbers
>>> + **************************************************************************
>>> + */
>>> +void rpc_req(int rpc_prog, int rpc_proc, uint32_t *data, int datalen)
>>> +{
>>> +    struct pbuf *pb;
>>> +    int pktlen;
>>> +    int sport;
>>> +    err_t err;
>>> +
>>> +    pb = pbuf_alloc(PBUF_TRANSPORT, sizeof(struct rpc_t), PBUF_RAM);
>>
>> This needs to be checked for NULL.
> 
> OK.
> 
> Andrew
> 
>>> +
>>> +    rpc_req_common(rpc_prog, rpc_proc, data, datalen,
>>> +               pb->payload, &pktlen, &sport);
>>> +
>>> +    pbuf_realloc(pb, (u16_t)pktlen);
>>> +
>>> +    err = udp_sendto(sess_ctx.pcb, pb, &sess_ctx.nfs_server, sport);
>>> +    debug_cond((err != ERR_OK), "Failed to send UDP packet err = %d\n", err);
>>> +    pbuf_free(pb);
>>> +}
>>> +
>>> +void nfs_refresh_timeout(void)
>>> +{
>>> +    timer_start = get_timer(0);
>>> +}
>>> +
>>> +static void nfs_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p,
>>> +             const ip_addr_t *addr, u16_t port)
>>> +{
>>> +    struct nfs_ctx *ctx = arg;
>>> +    int plen;
>>> +    struct rpc_t rpc_pkt;
>>> +
>>> +    if (addr->addr != ctx->nfs_server.addr)
>>> +        goto exitfree;
>>> +
>>> +    if (p->tot_len > sizeof(struct rpc_t))
>>> +        goto exitfree;
>>> +
>>> +    plen = pbuf_copy_partial(p, &rpc_pkt.u.data[0], sizeof(rpc_pkt), 0);
>>> +    nfs_pkt_recv(&rpc_pkt.u.data[0], plen);
>>> +
>>> +exitfree:
>>> +    pbuf_free(p);
>>> +}
>>> +
>>> +static int nfs_udp_init(struct nfs_ctx *ctx)
>>> +{
>>> +    ctx->pcb = udp_new();
>>> +    if (!ctx->pcb)
>>> +        return -ENOMEM;
>>> +
>>> +    ctx->pcb->local_port = nfs_our_port;
>>> +    udp_recv(ctx->pcb, nfs_recv, ctx);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int nfs_timeout_check(void)
>>> +{
>>> +    if (get_timer(timer_start) < nfs_timeout)
>>> +        return 0;
>>> +    if (++nfs_timeout_count < NFS_RETRY_COUNT) {
>>> +        puts("T ");
>>> +        timer_start = get_timer(0);
>>> +        nfs_send();
>>> +        return 0;
>>> +    }
>>> +
>>> +    return 1;
>>> +}
>>> +
>>> +static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>>> +            ip_addr_t srvip)
>>> +{
>>> +    struct netif *netif;
>>> +    int ret;
>>> +
>>> +    nfs_download_state = NETLOOP_FAIL;
>>> +    net_set_state(NETLOOP_FAIL);
>>
>> These states belong in the nfs_ctx I mentioned above.
>>
>>> +
>>> +    if (!fname || addr == 0)
>>> +        return -1;
>>> +
>>> +    netif = net_lwip_new_netif(udev);
>>> +    if (!netif)
>>> +        return -1;
>>> +
>>> +    nfs_filename = nfs_basename(fname);
>>> +    nfs_path     = nfs_dirname(fname);
>>> +
>>> +    printf("Using %s device\n", eth_get_name());
>>> +
>>> +    printf("File transfer via NFS from server %s; our IP address is %s\n",
>>> +           ip4addr_ntoa(&srvip), env_get("ipaddr"));
>>> +
>>> +    printf("\nFilename '%s/%s'.", nfs_path, nfs_filename);
>>> +
>>> +    if (net_boot_file_expected_size_in_blocks) {
>>> +        printf(" Size is 0x%x Bytes = ",
>>> +               net_boot_file_expected_size_in_blocks << 9);
>>> +        print_size(net_boot_file_expected_size_in_blocks << 9, "");
>>> +    }
>>> +    printf("\nLoad address: 0x%lx\nLoading: *\b", addr);
>>> +    image_load_addr = addr;
>>> +
>>> +    nfs_timeout_count = 0;
>>> +    nfs_state = STATE_PRCLOOKUP_PROG_MOUNT_REQ;
>>> +
>>> +    ret = nfs_udp_init(&sess_ctx);
>>> +    if (ret < 0) {
>>> +        net_lwip_remove_netif(netif);
>>> +        debug("Failed to init network interface, aborting for error = %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    net_set_state(NETLOOP_CONTINUE);
>>> +
>>> +    sess_ctx.nfs_server.addr = srvip.addr;
>>> +
>>> +    nfs_send();
>>> +
>>> +    timer_start = get_timer(0);
>>> +    do {
>>> +        net_lwip_rx(udev, netif);
>>> +        if (net_state != NETLOOP_CONTINUE)
>>> +            break;
>>> +        if (ctrlc()) {
>>> +            printf("\nAbort\n");
>>> +            break;
>>> +        }
>>> +
>>> +        if (nfs_timeout_check())
>>> +            break;
>>> +    } while (true);
>>> +    debug("%s: Loop exit at %lu\n", __func__, get_timer(0));
>>> +
>>> +    net_lwip_remove_netif(netif);
>>> +
>>> +    if (net_state == NETLOOP_SUCCESS) {
>>> +        ret = 0;
>>> +        if (net_boot_file_size > 0) {
>>> +            printf("Bytes transferred = %u (%x hex)\n",
>>> +                   net_boot_file_size, net_boot_file_size);
>>> +            env_set_hex("filesize", net_boot_file_size);
>>> +            env_set_hex("fileaddr", image_load_addr);
>>> +        }
>>> +
>>> +    } else {
>>> +        debug("%s: NFS loop failed\n", __func__);
>>> +        ret = -1;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>> +{
>>> +    int ret = CMD_RET_SUCCESS;
>>> +    char *arg = NULL;
>>> +    char *words[2] = { };
>>> +    char *fname = NULL;
>>> +    char *server_ip = NULL;
>>> +    char *end;
>>> +    ip_addr_t srvip;
>>> +    ulong laddr;
>>> +    ulong addr;
>>> +    int i;
>>> +
>>> +    laddr = env_get_ulong("loadaddr", 16, image_load_addr);
>>> +
>>> +    switch (argc) {
>>> +    case 1:
>>> +        fname = env_get("bootfile");
>>> +        break;
>>> +    case 2:
>>> +        /*
>>> +         * Only one arg - accept two forms:
>>> +         * Just load address, or just boot file name. The latter
>>> +         * form must be written in a format which can not be
>>> +         * mis-interpreted as a valid number.
>>> +         */
>>> +        addr = hextoul(argv[1], &end);
>>> +        if (end == (argv[1] + strlen(argv[1]))) {
>>> +            laddr = addr;
>>> +            fname = env_get("bootfile");
>>> +        } else {
>>> +            arg = strdup(argv[1]);
>>> +        }
>>> +        break;
>>> +    case 3:
>>> +        laddr = hextoul(argv[1], NULL);
>>> +        arg = strdup(argv[2]);
>>> +        break;
>>> +    default:
>>> +        ret = CMD_RET_USAGE;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (!arg)
>>> +        arg = net_boot_file_name;
>>> +
>>> +    if (*arg) {
>>> +        /* Parse [ip:]fname */
>>> +        i = 0;
>>> +        while ((*(words + i) = strsep(&arg, ":")))
>>> +            i++;
>>> +
>>> +        switch (i) {
>>> +        case 2:
>>> +            server_ip = words[0];
>>> +            fname = words[1];
>>> +            break;
>>> +        case 1:
>>> +            fname = words[0];
>>> +            break;
>>> +        default:
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    if (!server_ip)
>>> +        server_ip = env_get("serverip");
>>> +    if (!server_ip) {
>>> +        log_err("*** ERROR: 'serverip' not set\n");
>>> +        ret = CMD_RET_FAILURE;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (!ipaddr_aton(server_ip, &srvip)) {
>>> +        log_err("error: ipaddr_aton\n");
>>> +        ret = CMD_RET_FAILURE;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (!fname) {
>>> +        log_err("error: no file name\n");
>>> +        ret = CMD_RET_FAILURE;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (!laddr) {
>>> +        log_err("error: no load address\n");
>>> +        ret = CMD_RET_FAILURE;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (net_lwip_eth_start() < 0) {
>>> +        ret = CMD_RET_FAILURE;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (nfs_loop(eth_get_dev(), laddr, fname, srvip) < 0)
>>> +        ret = CMD_RET_FAILURE;
>>> +out:
>>> +    if (arg != net_boot_file_name)
>>> +        free(arg);
>>> +    return ret;
>>> +}
>>> diff --git a/net/nfs-common.c b/net/nfs-common.c
>>> index a6a70677bd2d8350819dd7bce336d35cc3ae7bf8..4fbde67a760f4eb2825749a051dd444bac486253 100644
>>> --- a/net/nfs-common.c
>>> +++ b/net/nfs-common.c
>>> @@ -286,9 +286,11 @@ static void nfs_umountall_req(void)
>>>       u32 *p;
>>>       int len;
>>>   -    if ((nfs_server_mount_port == -1) || !fs_mounted)
>>> +    if ((nfs_server_mount_port == -1) || !fs_mounted) {
>>>           /* Nothing mounted, nothing to umount */
>>> +        net_set_state(NETLOOP_FAIL);
>>>           return;
>>> +    }
>>>         p = &data[0];
>>>       p = rpc_add_credentials(p);
>>>
>>
>> Thanks,
> 
